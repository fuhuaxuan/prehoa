create or replace procedure P_Prl_Stamp_doMail(p_FlowGid varchar --流程Gid
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
  for R in (select f.*, wm.name ModelName
              from wf_Prl_Stamp f, wf_model wm
             where f.EntGid = v_EntGid
               and f.entgid = wm.entgid
               and f.FlowGid = p_FlowGid
               and f.modelgid = wm.modelgid) loop
    v_Stage   := 'FlowGid：' || R.Flowgid || '；模型：' || R.ModelName;
    v_Title   := '用印待审提醒:' || R.FILLDEPTNAME;
    v_Content := v_Content || v_Head;
  
    v_Body    := '[流程名称] : ' || R.ModelName;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[单号] : ' || R.Num;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[发起人] : ' || R.Fillusrname;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[发起时间] : ' || to_char(R.Createdate, 'YYYY.MM.DD HH24:MI');
  
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[是否关联流程] : ' || R.mIsFlow || '（单号' || R.mNum || '）';
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[申请类型] : ' || R.ApplyType;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[申请印章种类] : ' || R.StampType;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[公司名称] : ' || R.ComName;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
  
    if R.ApplyType = '非合同类文件用印' then
      v_Body    := '[文件接收方名称] : ' || R.FilerName;
      v_Content := v_Content || v_TStart || v_Body || v_TEnd;
      v_Body    := '[文件名称] : ' || R.FileName;
      v_Content := v_Content || v_TStart || v_Body || v_TEnd;
      v_Body    := '[文件份数] : ' || R.FileCount;
      v_Content := v_Content || v_TStart || v_Body || v_TEnd;
      v_Body    := '[文件目的] : ' || R.FileAim;
      v_Content := v_Content || v_TStart || v_Body || v_TEnd;
      v_Body    := '[申请人声明及保证] : 我保证我所提交的用于盖章的非合同类文件与本申请所注载内容一致';
      v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    end if;
    if R.ApplyType = '合同签署用印' then
      v_Body    := '[合同名称] : ' || R.ContractName;
      v_Content := v_Content || v_TStart || v_Body || v_TEnd;
      v_Body    := '[合同份数] : ' || R.ContractCount;
      v_Content := v_Content || v_TStart || v_Body || v_TEnd;
      v_Body    := '[合同金额/总租金] : ' || R.ContractFee;
      v_Content := v_Content || v_TStart || v_Body || v_TEnd;
      v_Body    := '[合作公司] : ' || R.ContactName;
      v_Content := v_Content || v_TStart || v_Body || v_TEnd;
      v_Body    := '[合同期限] : ' || to_char(R.ContractDate1, 'YYYY.MM.DD') || '~' ||
                   to_char(R.ContractDate2, 'YYYY.MM.DD');
      v_Content := v_Content || v_TStart || v_Body || v_TEnd;
      v_Body    := '[合同概要] : ' || R.ComtractMemo;
      v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    end if;
    v_Body    := '[备注] : ' || R.Memo;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Content := v_Content || v_Foot;
    for U in (select distinct hr.Email
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