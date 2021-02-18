alter table WF_prlGG_ISF add Atype2 varchar2(32);
alter table WF_prlGG_ISF add Atype3 varchar2(32);
alter table WF_prlGG_ISF add MinArea NUMBER;
alter table WF_prlGG_ISF add MaxArea NUMBER;
alter table WF_prlGG_ISF add Collection varchar2(64);
alter table WF_prlGG_ISF add PowerType varchar2(32);
alter table WF_prlGG_ISF add PowerFee1 NUMBER;
alter table WF_prlGG_ISF add PowerFee2 NUMBER;
alter table WF_prlGG_ISF add WaterType varchar2(32);
alter table WF_prlGG_ISF add WaterFee1 NUMBER;
alter table WF_prlGG_ISF add WaterFee2 NUMBER;
alter table WF_prlGG_ISF_dtl add GTO NUMBER;
alter table WF_prlGG_ISF_dtl add ProGTO NUMBER;
alter table WF_prlGG_ISF_dtl add ProGTOrent NUMBER;
alter table WF_prlGG_ISF add FitoutM NUMBER;
alter table WF_prlGG_ISF add fitoutD NUMBER;
alter table WF_prlGG_ISF add FitoutDate1 date;
alter table WF_prlGG_ISF add FitoutDate2 date;
alter table wf_prlGG_isf_ground add farea NUMBER;
alter table wf_prlGG_isf_ground add jarea NUMBER;


create or replace procedure P_PrlGG_ISF_doMail(p_FlowGid varchar --流程Gid
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
  v_T1     varchar(1024);
  v_T2     varchar(1024);
  v_T3     number;
  v_T4     number;
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
  v_T1      := '';
  v_T2      := '';
  v_T3      := 0;
  v_T4      := 0;
  --for 循环 取出未领取的快递
  for R in (select f.*,
                   substr(wm.code, instr(wm.code, '_', 1) + 1) MCode,
                   wm.name ModelName
              from wf_PrlGG_ISF f, wf_model wm
             where f.EntGid = v_EntGid
               and f.entgid = wm.entgid
               and f.FlowGid = p_FlowGid
               and f.modelgid = wm.modelgid) loop
    v_Stage   := 'FlowGid：' || R.Flowgid || '；模型：' || R.ModelName;
    v_Title   := '广告位' || R.Mcode || ':' || R.FilldeptName;
    v_Content := v_Content || v_Head;
  
    v_Body    := '[流程名称] : ' || R.ModelName;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[单号] : ' || R.Num;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[发起人] : ' || R.Fillusrname;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[发起时间] : ' || to_char(R.Createdate, 'YYYY.MM.DD HH24:MI');
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[类别] : ' || R.Atype || ' ' || R.Atype2 || ' ' || R.Atype3;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
  
    for D in (select f.*
                from wf_PrlGG_ISF_ground f
               where f.EntGid = v_EntGid
                 and f.FlowGid = p_FlowGid
               order by f.fno) loop
      v_T1 := v_T1 || D.fNo || ';';
      v_T2 := v_T2 || D.floorno || ';';
      select v_T3 + nvl(D.fArea, 0) into v_T3 from dual;
      select v_T4 + nvl(D.jArea, 0) into v_T4 from dual;
    end loop;
    v_Body    := '[单位] : ' || v_T1;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[位置] : ' || v_T2;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    if v_T3 = v_T4 then
      v_Body    := '[面积] : ' || v_T3;
      v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    else
      v_Body    := '[面积] : ' || v_T3 || '-' || v_T4;
      v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    end if;
    v_Body    := '[A、租户信息] : ';
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[租户] : ' || R.Lessee;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[商店营业名称] : ' || R.Tradingname;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[联系人] : ' || R.Contactor;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[地址] : ' || R.Address;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[电话] : ' || R.Phone;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[电子邮件] : ' || R.Email;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[传真] : ' || R.Fax;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[B、合同信息] : ';
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[租赁期限] : ' || R.Leasetermy || '年/' || R.Leasetermm || '月/' ||
                 R.Leasetermd || '日';
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[交付日期] : ' || to_char(R.Handoverdate, 'YYYY.MM.DD');
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[免租期] : ' || R.Freerentm || '月/' || R.Freerentd || '日';
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[装修期] : ' || R.Fitoutm || '月/' || R.Fitoutd || '日（' ||
                 to_char(R.Fitoutdate1, 'YYYY.MM.DD') || '~' ||
                 to_char(R.Fitoutdate2, 'YYYY.MM.DD') || ')';
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[合同起始日期] : ' || to_char(R.Contractdate1, 'YYYY.MM.DD') || '~' ||
                 to_char(R.Contractdate2, 'YYYY.MM.DD');
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[租金方式] : ' || R.Rate;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[收银方式] : ' || R.Collection;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[C、租赁条件]';
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
  
    v_Body    := ' <table cellpadding="0" cellspacing="1" class="ListBar" width="100%" style="background-color: #d9dbdf;">';
    v_Body    := v_Body || '<col style="padding-left:4px;">';
    v_Body    := v_Body || '<col style="padding-left:4px;">';
    v_Body    := v_Body || '<col style="padding-left:4px;">';
    v_Body    := v_Body || '<col style="padding-left:4px;">';
    v_Body    := v_Body ||
                 '  <tr style="background-color: #ecedef;" align="center">';
    v_Body    := v_Body || '    <td nowrap rowspan="4">Yr年</td>';
    v_Body    := v_Body || '    <td nowrap rowspan="4">类别</td>';
    v_Body    := v_Body || '    <td nowrap>元/天</td>';
    v_Body    := v_Body || '    <td nowrap>元/月</td>';
    v_Body    := v_Body || ' </tr>';
    v_Content := v_Content || v_TStart || v_Body;
    v_Body    := v_Body ||
                 '  <tr style="background-color: #ecedef;" align="center">';
    v_Body    := v_Body ||
                 '    <td class="App_ListTd" style="padding:0px" nowrap colspan="2">Details 细节</td>';
    v_Body    := v_Body || ' </tr>';
    v_Content := v_Content || v_TStart || v_Body;
    v_Body    := v_Body ||
                 '  <tr style="background-color: #ecedef;" align="center">';
    v_Body    := v_Body ||
                 '    <td class="App_ListTd" style="padding:0px" nowrap colspan="2">㎡/天</td>';
    v_Body    := v_Body || ' </tr>';
    v_Content := v_Content || v_TStart || v_Body;
    v_Body    := v_Body ||
                 '  <tr style="background-color: #ecedef;" align="center">';
    v_Body    := v_Body ||
                 '    <td class="App_ListTd" style="padding:0px" nowrap colspan="2">㎡/天</td>';
    v_Body    := v_Body || ' </tr>';
    v_Content := v_Content || v_TStart || v_Body;
  
    for D in (select f.*
                from wf_PrlGG_ISF_Dtl f
               where f.EntGid = v_EntGid
                 and f.FlowGid = p_FlowGid
                 and lower(f.TBID) in ('tb_dtl10', 'tb_dtl30')
               order by f.TBID, f.yeartype) loop
      v_Body := ' <tr valign="top" style="background-color: white" align="center"  rowspan="4">';
      if lower(D.TbId) = 'tb_dtl10' then
        v_Body := v_Body || '<td nowrap> 免:' ||
                  to_char(D.Freerentdate1, 'YYYY.MM.DD') || '~' ||
                  to_char(D.Freerentdate2, 'YYYY.MM.DD') || ') </td>';
      else
        v_Body := v_Body || '<td nowrap> Yr ' || D.Yeartype || ' </td>';
      end if;
      v_Body    := v_Body || '  <td nowrap> 固定租金 </td>';
      v_Body    := v_Body || '  <td nowrap> ' ||
                   to_char(D.Tbrd, 'FM999999999990.9990') || ' </td>';
      v_Body    := v_Body || '  <td nowrap> ' ||
                   to_char(D.Tbrm, 'FM999999999990.9990') || ' </td>';
      v_Body    := v_Body || ' </tr>';
      v_Content := v_Content || v_Body;
      v_Body    := ' <tr valign="top" style="background-color: white" align="center">';
      v_Body    := v_Body || '  <td nowrap> 提成租金构造 </td>';
      v_Body    := v_Body || '  <td nowrap  colspan="2"> ' ||
                   to_char(D.GTO, 'FM999999999990.9990') || ' </td>';
      v_Body    := v_Body || ' </tr>';
      v_Content := v_Content || v_Body;
      v_Body    := ' <tr valign="top" style="background-color: white" align="center">';
      v_Body    := v_Body || '  <td nowrap> 预估营业额 </td>';
      v_Body    := v_Body || '  <td nowrap  colspan="2"> ' ||
                   to_char(D.ProGTO, 'FM999999999990.9990') || ' </td>';
      v_Body    := v_Body || ' </tr>';
      v_Content := v_Content || v_Body;
      v_Body    := ' <tr valign="top" style="background-color: white" align="center">';
      v_Body    := v_Body || '  <td nowrap> 预估提成租金 </td>';
      v_Body    := v_Body || '  <td nowrap  colspan="2"> ' ||
                   to_char(D.ProGTOrent, 'FM999999999990.9990') || ' </td>';
      v_Body    := v_Body || ' </tr>';
      v_Content := v_Content || v_Body;
    end loop;
  
    v_Body    := '</table>';
    v_Content := v_Content || v_Body || '</td></tr>';
    v_Body    := '[新] : ' || R.Brcnew;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[目前] : ' || R.Brcexist;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[批准预算] : ' || R.Brcbudget;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[合同期内总收入] : ' || R.TotalFee;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[预付租金+费用] : ' || R.AGR;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[保证金] : ' || R.Security;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[方式] : ' || R.Incash;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[电费收取] : ' || R.PowerType;
    if R.PowerType = '按度' then
      v_Body := v_Body || R.PowerFee1 || '元/度';
    elsif R.PowerType = '固定费用' then
      v_Body := v_Body || R.PowerFee2 || '元/天';
    end if;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[水费收取] : ' || R.WaterType;
    if R.WaterType = '按度' then
      v_Body := v_Body || R.WaterFee1 || '元/吨';
    elsif R.WaterType = '固定费用' then
      v_Body := v_Body || R.WaterFee2 || '元/天';
    end if;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[特别条件/评语] : ' || R.Memo;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Content := v_Content || v_Foot;
    for U in (select distinct hr.Email
                from hr_emp hr
               where hr.entgid = R.EntGid
                 and hr.Email is not null
                 and exists (select 1
                        from wf_task t
                       where t.EntGid = hr.EntGid
                         and t.FlowGid = R.Flowgid
                         and t.ExecGid = hr.UsrGid
                         and t.Stat = 1)) loop
      v_Email := v_Email || U.EMAIL || ',';
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
