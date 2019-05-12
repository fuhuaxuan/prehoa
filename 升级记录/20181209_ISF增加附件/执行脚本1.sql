alter table wf_prl_isf add SecurityStand Number(20,4);
alter table wf_prl_isf add MonthSale Number(20,4);
alter table wf_prl_isf add IsHY varchar2(10);
alter table wf_prl_isf add IsQZ varchar2(10);
alter table wf_prl_isf add AttachType varchar2(32);
alter table WF_PRL_ISF_Attach add Attach_Type int;



update WF_PRL_ISF_Attach set Attach_Type = 50;
update wf_prl_isf set SecurityStand=Security,AttachType = '个人';
commit;

create or replace procedure HDNET_Prl_doISF(p_EntGid  varchar2, --企业Gid
                                            p_FlowGid varchar2 --流程FlowGid
                                            ) as
  v_Stage   varchar2(1024); -- 过程场景
  v_ErrText varchar2(1024); -- Oracle错误信息

  v_FlowType   int; --流程类型 isf-10,iscf-20
  v_OldFlowGid varchar2(32); --流程Gid

  v_P1     number(20, 4); --（批准预算-New:新）/批准预算*100)
  v_P2     number(20, 4); --（批准预算-New:新）*总面积*(365/12)
  v_P3     number(20, 4); --免租期 月
  v_P4     number(20, 4); --装修补贴 月 + 装修补贴 月
  v_P5     varchar(32); --餐饮：业态代码 01 开头;  非餐饮：业态代码 非 01 开头
  v_P6     number(20, 4); --面积（计租面积）总和
  v_P7     number(20, 4); --免租期租金短缺（第一年取决于计租方式的总租金单价-免租期取决于计租方式的总租金单价）*计租面积*免租期天数(其中：免租期天数计算：取免租期日期段对应的天数)
  v_P8     number(20, 4); --起租日（ISCF 合同开始日期 - ISF 合同开始日期）
  v_P9     number(20, 4); --保证金差异（标准 - 实际）
  v_Atype  varchar(32); --类型
  v_CBDate Date; --ISCF 合同开始日期

  v_Category varchar2(64); --类别
  v_D1       varchar2(32); --短租标记（固定，非固定，其它）
  v_D2       number(20, 4); --短租月份

  --ISF 的
  v_Old_P3     number(20, 4); --免租期 月
  v_Old_P4     number(20, 4); --装修补贴 月 + 装修补贴 月
  v_Old_P6     number(20, 4); --面积（计租面积）总和
  v_Old_P7     number(20, 4); --免租期租金短缺（第一年取决于计租方式的总租金单价-免租期取决于计租方式的总租金单价）*计租面积*免租期天数(其中：免租期天数计算：取免租期日期段对应的天数)
  v_Old_CBDate Date; --ISCF 合同开始日期

  v_YearFee number(20, 4); --第一年取决于计租方式的总租金单价
  v_FreeFee number(20, 4); --免租期取决于计租方式的总租金单价
  v_FreeDay number(20, 4); --免租期天数

  v_Old_YearFee number(20, 4); --第一年取决于计租方式的总租金单价
  v_Old_FreeFee number(20, 4); --免租期取决于计租方式的总租金单价
  v_Old_FreeDay number(20, 4); --免租期天数

  v_T2 number(20, 4); --P2变量
  v_T3 number(20, 4); --P3变量
  v_T6 number(20, 4); --P6变量
  v_T7 number(20, 4); --P7变量

  v_Count number(20, 4); --判断是否存在

  v_Result number(20, 4); --返回值
begin
  v_Result := 40;
  v_P8     := 0;
  v_P9     := 0;
  v_Stage  := '取出参数P1-P6，判断当前流程是ISF还是ISCF';
  select nvl(f.sPARAM1, 0),
         nvl(f.sPARAM2, 0),
         nvl(f.FreeRentM, 0),
         nvl(f.TotalFee + f.OtherTotalFee, 0),
         decode(substr(f.Trade, 0, 2), '01', '餐饮', '非餐饮'),
         nvl(f.Area, 0),
         decode(f.FlowType, 10, 50000, 30000),
         f.FlowType,
         f.oldFlowGid,
         f.ContractDate1,
         nvl(f.BRCNew, 0),
         nvl(f.MZQCNew, 0),
         f.Category,
         nvl(f.LeaseTermM, 0),
         nvl(f.SecurityStand, 0) - nvl(f.Security, 0),
         f.Atype
    into v_P1,
         v_P2,
         v_P3,
         v_P4,
         v_P5,
         v_P6,
         v_T2,
         v_FlowType,
         v_OldFlowGid,
         v_CBDate,
         v_YearFee,
         v_FreeFee,
         v_Category,
         v_D2,
         v_P9,
         v_Atype
    from wf_PRL_ISF f
   where f.EntGid = p_EntGid
     and f.FlowGid = p_FlowGid;

  v_Stage := '判断租期的类别';
  if v_Category = 'Licence 短期租约(固定)' then
    v_D1 := '固定';
  elsif v_Category = 'Licence 短期租约(非固定)' then
    v_D1 := '非固定';
  else
    v_D1 := '其它';
  end if;

  v_Stage   := '取出免租期天数';
  v_FreeDay := 0;
  select count(*)
    into v_Count
    from wf_PRL_ISF_Dtl fd
   where fd.EntGid = p_EntGid
     and fd.FlowGid = p_FlowGid
     and lower(fd.TbID) = 'tb_dtl10';
  if v_Count != 0 then
    select nvl(FreeRentDate2 - FreeRentDate1 + 1, 0)
      into v_FreeDay
      from wf_PRL_ISF_Dtl fd
     where fd.EntGid = p_EntGid
       and fd.FlowGid = p_FlowGid
       and lower(fd.TbID) = 'tb_dtl10';
  end if;

  v_Stage := '计算 P7 免租期租金短缺';
  v_P7    := (v_YearFee - v_FreeFee) * v_P6 * v_FreeDay;

  if v_OldFlowGid is not null then
    v_Stage := '取出Old ISF：' || v_OldFlowGid || '参数P1-P6，判断当前流程是ISF还是ISCF';
    select nvl(f.FreeRentM, 0),
           nvl(f.TotalFee + f.OtherTotalFee, 0),
           nvl(f.Area, 0),
           f.ContractDate1,
           nvl(f.BRCNew, 0),
           nvl(f.MZQCNew, 0)
      into v_Old_P3,
           v_Old_P4,
           v_Old_P6,
           v_Old_CBDate,
           v_Old_YearFee,
           v_Old_FreeFee
      from wf_PRL_ISF f
     where f.EntGid = p_EntGid
       and f.FlowGid = v_OldFlowGid;
  
    v_Stage       := '取出Old ISF' || v_OldFlowGid || '免租期天数';
    v_Old_FreeDay := 0;
    select count(*)
      into v_Count
      from wf_PRL_ISF_Dtl fd
     where fd.EntGid = p_EntGid
       and fd.FlowGid = v_OldFlowGid
       and lower(fd.TbID) = 'tb_dtl10';
    if v_Count != 0 then
      select nvl(FreeRentDate2 - FreeRentDate1 + 1, 0)
        into v_Old_FreeDay
        from wf_PRL_ISF_Dtl fd
       where fd.EntGid = p_EntGid
         and fd.FlowGid = v_OldFlowGid
         and lower(fd.TbID) = 'tb_dtl10';
    end if;
  
    v_Stage  := '计算Old ISF' || v_OldFlowGid || ' P7 免租期租金短缺';
    v_Old_P7 := (v_Old_YearFee - v_Old_FreeFee) * v_Old_P6 * v_Old_FreeDay;
  
    v_Stage := '计算P8';
    if v_CBDate is not null and v_Old_CBDate is not null then
      v_P8 := v_CBDate - v_Old_CBDate;
    end if;
  
    v_Stage := '计算新的P3';
    if v_Old_P3 = v_P3 then
      v_P3 := 0;
    end if;
  
    v_Stage := '计算新的P4';
    if v_Old_P4 = v_P4 then
      v_P4 := 0;
    end if;
  
    v_Stage := '计算新的P7';
    if v_Old_P7 = v_P7 then
      v_P7 := 0;
    end if;
  end if;

  v_T6 := 1000000000;
  --v_P5:餐饮
  if v_P5 = '餐饮' then
    --v_P6:面积
    if v_P6 <= 100 then
      v_T3 := 1;
      v_T7 := 30000;
    elsif v_P6 > 100 and v_P6 <= 250 then
      v_T3 := 2;
      v_T7 := 50000;
    else
      v_T3 := 3;
      v_T6 := 250;
      v_T7 := 1000000000;
    end if;
    --v_P5:非餐饮
  else
    --v_P6:面积
    if v_P6 <= 250 then
      v_T3 := 1;
      v_T7 := 50000;
    elsif v_P6 > 250 and v_P6 <= 500 then
      v_T3 := 2;
      v_T7 := 80000;
    else
      v_T3 := 3;
      v_T6 := 500;
      v_T7 := 1000000000;
    end if;
  end if;

  v_Stage := '判断流程最终到达的节点';
  if v_D1 = '固定' then
    if v_D2 >= 0 then
      v_Result := 60;
    end if;
    if v_D2 > 6 then
      v_Result := 90;
    end if;
    if v_D2 > 12 then
      v_Result := 100;
    end if;
  elsif v_D1 = '其它' then
    if (v_P1 > 0 or v_P2 > 0) or v_P4 > 0 or
       (v_Atype = 'Rental 出租' and v_P9 > 0) or (v_P3 > v_T3 or v_P7 > v_T7) or
       v_P8 > 0 then
      v_Result := 60;
    end if;
    if (v_P1 > 10 or v_P2 > 50000) or v_P4 > 80000 or
       (v_Atype = 'Rental 出租' and v_P9 > 10000) or
       (v_P3 > v_T3 or v_P7 > v_T7) or v_P8 > 30 then
      v_Result := 80;
    end if;
    if (v_P1 > 10 or v_P2 > 50000) or v_P4 > 80000 or
       (v_Atype = 'Rental 出租' and v_P9 > 10000) or
       (v_P6 > v_T6 and v_P3 > v_T3) then
      v_Result := 90;
    end if;
    if (v_P1 > 10 and v_P2 > 50000) or v_P4 > 300000 or
       (v_Atype = 'Rental 出租' and v_P9 > 50000) then
      v_Result := 100;
    end if;
  end if;

  --返回计算结果
  --40-TA3
  --60-TB
  --80-TC1
  --90-TC2
  --100-TD
  v_Stage := '更新P1-P8到ISF表中';
  update wf_PRL_ISF
     set (sPARAM3, sPARAM4, sPARAM5, sPARAM6, sPARAM7, sPARAM8, sStep) =
         (select v_P3, v_P4, v_P5, v_P6, v_P7, v_P8, v_Result from dual)
   where EntGid = p_EntGid
     and FlowGid = p_FlowGid;
  commit;
  --异常处理
exception
  when others then
    begin
      rollback;
      v_ErrText := substr('流程Gid:' || p_FlowGid || ';' || v_Stage || ' 失败!' ||
                          SQLCode || ':' || SQLERRM,
                          1,
                          1024);
      --插入日志
      insert into Log
        (EntGid,
         EntCode,
         EntName,
         UsrGid,
         UsrCode,
         UsrName,
         CreateDate,
         Atype,
         AContent)
        select e.Gid,
               e.Code,
               e.Name,
               'sys',
               'sys',
               '系统自动',
               sysdate,
               30,
               v_ErrText
          from ent e
         where e.Gid = p_EntGid;
      commit;
    end;
end;
/
