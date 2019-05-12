create or replace procedure P_Prl_OISF_doMail(p_FlowGid varchar --流程Gid
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
                   substr(wm.code, instr(wm.code, '_', 1) + 2) MCode,
                   wm.name ModelName
              from wf_Prl_OISF f, wf_model wm
             where f.EntGid = v_EntGid
               and f.entgid = wm.entgid
               and f.FlowGid = p_FlowGid
               and f.modelgid = wm.modelgid) loop
    v_Stage   := 'FlowGid：' || R.Flowgid || '；模型：' || R.ModelName;
    v_Title   := '写字楼' || R.Mcode || '待审提醒:' || R.FILLDEPTNAME;
    v_Content := v_Content || v_Head;
  
    v_Body    := '[流程名称] : ' || R.ModelName;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[单号] : ' || R.Num;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[发起人] : ' || R.Fillusrname;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[发起时间] : ' || to_char(R.Createdate, 'YYYY.MM.DD HH24:MI');
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[Category 类别] : ' || R.Atype || R.Category ||
                 R.Categorytext;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[Unit No. 单位] : ' || R.Unit;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[Area 面积] : ' || R.Area;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[Tenant/Licensee 租户] : ' || R.Lessee;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[Trading Name 商店营业名称] : ' || R.Tradingname;
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
    v_Body    := '[Free of rent Period 免租期] : ' || R.Freerenty || '年/' ||
                 R.Freerentm || '月/' || R.Freerentd || '日';
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[Fit-Out Period 装修期] : ' || R.Fitoutm || '月/' ||
                 R.Fitoutd || '日（' || to_char(R.Fitoutdate1, 'YYYY.MM.DD') || '~' ||
                 to_char(R.Fitoutdate2, 'YYYY.MM.DD') || ')';
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[Security Deposit (mths) 保证金] : ' || R.Security;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
  
    v_Body := ' <table cellpadding="0" cellspacing="1" class="ListBar" width="100%" style="background-color: #d9dbdf;">';
    v_Body := v_Body || ' <col style="padding-left:4px;">';
    v_Body := v_Body || '<col style="padding-left:4px;">';
    v_Body := v_Body || '  <col style="padding-left:4px;">';
    v_Body := v_Body || '  <col style="padding-left:4px;">';
    v_Body := v_Body || '  <col style="padding-left:4px;">';
    v_Body := v_Body || '  <col style="padding-left:4px;">';
    v_Body := v_Body || '  <col style="padding-left:4px;">';
    v_Body := v_Body || '  <col style="padding-left:4px;">';
    v_Body := v_Body || '  <col style="padding-left:4px;">';
    v_Body := v_Body || '  <col style="padding-left:4px;">';
    v_Body := v_Body ||
              '  <tr style="background-color: #ecedef;" align="center">';
    v_Body := v_Body || '   <td rowspan="2">Yr 年</td>';
    v_Body := v_Body || '   <td colspan="4">Base Rental<br>固定租金</td>';
    v_Body := v_Body ||
              '   <td colspan="4" nowrap>Property Mgmt Fee<br>物管费</td>';
    v_Body := v_Body || ' </tr>';
    v_Body := v_Body ||
              ' <tr style="background-color: #ecedef;" align="center">';
    v_Body := v_Body || '   <td>㎡/天</td>';
    v_Body := v_Body || '  <td>总数/月</td>';
    v_Body := v_Body || '   <td>(含免)<br>㎡/天</td>';
    v_Body := v_Body || '   <td>(含免）<br>㎡/月</td>';
    v_Body := v_Body || '   <td>㎡/天</td>';
    v_Body := v_Body || '  <td>总数/月</td>';
    v_Body := v_Body || '   <td>(含免)<br>㎡/天</td>';
    v_Body := v_Body || '   <td>(含免）<br>㎡/月</td>';
    v_Body := v_Body || ' </tr>';
  
    v_Content := v_Content || v_TStart || v_Body;
  
    for D in (select f.*
                from Wf_Prl_OIsf_Dtl f
               where f.EntGid = v_EntGid
                 and f.FlowGid = p_FlowGid
                 and lower(f.TBID) in ('tb_dtl30')
               order by f.TBID, f.yeartype) loop
      v_Body := ' <tr valign="top" style="background-color: white" align="center">';
    
      v_Body    := v_Body || '<td nowrap> Yr ' || D.Yeartype || ' </td>';
      v_Body    := v_Body || '  <td nowrap> ' ||
                   to_char(D.Tbrd, 'FM999999999990.9990') || ' </td>';
      v_Body    := v_Body || '  <td nowrap> ' ||
                   to_char(D.TBRM, 'FM999999999990.9990') || ' </td>';
      v_Body    := v_Body || '  <td nowrap> ' ||
                   to_char(D.Ftbrd, 'FM999999999990.9990') || ' </td>';
      v_Body    := v_Body || '  <td nowrap> ' ||
                   to_char(D.Ftbrm, 'FM999999999990.9990') || ' </td>';
      v_Body    := v_Body || '  <td nowrap> ' ||
                   to_char(D.pmfd, 'FM999999999990.9990') || ' </td>';
      v_Body    := v_Body || '  <td nowrap> ' ||
                   to_char(D.pmfm, 'FM999999999990.9990') || ' </td>';
      v_Body    := v_Body || '  <td nowrap> ' ||
                   to_char(D.Fpmfd, 'FM999999999990.9990') || ' </td>';
      v_Body    := v_Body || '  <td nowrap> ' ||
                   to_char(D.Fpmfm, 'FM999999999990.9990') || ' </td>';
      v_Body    := v_Body || ' </tr>';
      v_Content := v_Content || v_Body;
    end loop;
  
    v_Body    := '</table>';
    v_Content := v_Content || v_Body || '</td></tr>';
  
    v_Body    := '[New 新] : ' || R.Brcnew || 'RMB/㎡/天';
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[Existing 目前] : ' || R.Brcexist || 'RMB/㎡/天';
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[Budget 批准预算] : ' || R.Brcbudget || 'RMB/㎡/天';
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[Special Terms and Conditions/Remarks :特别条件/评语] : ' ||
                 R.Memo;
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
/
