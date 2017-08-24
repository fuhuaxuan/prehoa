create or replace procedure P_PrlDZ_ISTF_doMail(p_FlowGid varchar --流程Gid
                                                ) as
  v_Stage   varchar2(1024); -- 过程场景
  v_ErrText varchar2(1024); -- Oracle错误信息

  v_EntGid varchar2(32); --企业Gid

  v_Title   varchar2(64); --标题
  v_Email   varchar(1024); --邮件
  v_Content varchar2(32500); --内容

  v_Head   varchar(64); --表头
  v_Body   varchar(2048); --表内容
  v_TStart varchar(32);
  v_TEnd   varchar(32);
  v_Foot   varchar(64); --表尾

begin
  -- 获取企业Gid
  v_EntGid  := getEntGid;
  v_Head    := '<table border="0" style="width:500px;"><tr><td>您好 :</td></tr>';
  v_TStart  := '<tr><td>';
  v_TEnd    := '；</td></tr>';
  v_Foot    := '<tr><td>-----------内容展示完毕-----------</td></tr></table>';
  v_Email   := '';
  v_Content := '';
  --for 循环 取出未领取的快递
  for R in (select f.*,
                   decode(f.category,
                          10,
                          'Early Termination 提前终止',
                          20,
                          'Termination 到期终止',
                          30,
                          'Others 其他:' || f.categorytext) categoryText1,
                   t.unit,
                   t.area,
                   t.lessee lessee1,
                   t.tradingname tradingname1,
                   t.leaseTermY,
                   t.leaseTermM,
                   t.leaseTermD,
                   t.HandoverDate,
                   t.Rate1,
                   t.Rate,
                   t.contractDate1,
                   t.contractdate2,
                   t.freeRentM,
                   t.freeRentD,
                   t.freeRentdate1,
                   t.freeRentdate2,
                   t.fitoutM,
                   t.fitoutD,
                   t.fitoutdate1,
                   t.fitoutdate2,
                   t.collection,
                   wm.name ModelName
              from wf_Prl_ISTF f, wf_Prl_ISF t, wf_model wm
             where f.EntGid = v_EntGid
               and f.entgid = t.entgid
               and f.entgid = wm.entgid
               and f.FlowGid = p_FlowGid
               and f.oldflowgid = t.flowgid
               and f.modelgid = wm.modelgid) loop
    v_Stage   := 'FlowGid：' || R.Flowgid || '；模型：' || R.ModelName;
    v_Title   := 'ISTF待审提醒:' || R.Fillusrdept;
    v_Content := v_Content || v_Head;
  
    v_Body    := '[流程名称] : ' || R.ModelName;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[单号] : ' || R.Num;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[发起人] : ' || R.Fillusrname;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[发起时间] : ' || to_char(R.Createdate, 'YYYY.MM.DD HH24:MI');
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[Category 类别] : ' || R.Categorytext1;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[Unit No. 单位] : ' || R.Unit;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[Area 面积] : ' || R.Area;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[Tenant/Licensee 租户] : ' || R.Lessee1;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[Trading Name 商店营业名称] : ' || R.Tradingname1;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[Lease Term 租赁期限] : ' || R.Leasetermy || '年/' ||
                 R.Leasetermm || '月/' || R.Leasetermd || '日';
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[Handover Date 交付日期] : ' ||
                 to_char(R.Handoverdate, 'YYYY.MM.DD');
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[Contract Date 合同起始日期] : ' ||
                 to_char(R.Contractdate1, 'YYYY.MM.DD') || '~' ||
                 to_char(R.Contractdate2, 'YYYY.MM.DD');
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[Free of rent Period 免租期] : ' || R.Freerentm || '月/' ||
                 R.Freerentd || '日';
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[Fit-Out Period 装修期] : ' || R.Fitoutm || '月/' ||
                 R.Fitoutd || '日（' || to_char(R.Fitoutdate1, 'YYYY.MM.DD') || '~' ||
                 to_char(R.Fitoutdate2, 'YYYY.MM.DD') || ')';
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := R.RATE1 || '(' || R.Rate || ')';
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[Termination Date 申请终止日期] : ' ||
                 to_char(R.TERMINATIONDATE, 'YYYY.MM.DD');
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '结算费用项目合计 : ';
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[实际应缴金额C=A-B] : ' || R.DATACSUM;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[实际缴纳金额D] : ' || R.DATADSUM;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[应退还(追缴)金额E=D-C] : ' || R.DATAESUM;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[未完成租约期限的租金及费用] : ' || R.NUMA;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[租金（含物业费）减免额] : ' || R.NUMB;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[装修补贴] : ' || R.NUMC;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[提前终止的补偿款（包括可没收的款项）] : ' || R.NUMD;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[Remarks 退场原因] : ' || R.REMARKS;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Content := v_Content || v_Foot;
    for U in (select hr.Email
                from hr_emp hr
               where hr.entgid = R.EntGid
                 and exists (select 1
                        from wf_task t
                       where t.EntGid = hr.EntGid
                         and t.FlowGid = R.Flowgid
                         and t.ExecGid = hr.UsrGid
                         and t.Stat = 1)) loop
      v_Email := U.EMAIL || ',';
    end loop;
    if v_Email is not null then
      HDNet_SendMail(v_Title, v_Email, v_Content);
    end if;
  end loop;
  --异常处理
exception
  when others then
    begin
      v_ErrText := substr(v_Stage || ' 失败!' || SQLCode || ':' || SQLERRM,
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
        select e.gid,
               e.code,
               e.name,
               'sys',
               'sys',
               '系统自动',
               sysdate,
               30,
               v_ErrText
          from ent e
         where e.gid = v_EntGid;
      commit;
    end;
end;
/