create or replace procedure P_PrlYL_BaoXiao_doMail(p_FlowGid varchar --流程Gid
                                                   ) as
  v_Stage   varchar2(1024); -- 过程场景
  v_ErrText varchar2(1024); -- Oracle错误信息

  v_EntGid varchar2(32); --企业Gid

  v_Title   varchar2(64); --标题
  v_Email   varchar(1024); --邮件
  v_Content varchar2(32500); --内容

  v_Head    varchar(64); --表头
  v_Body    varchar(2048); --表内容
  v_TStart  varchar(32);
  v_TEnd    varchar(32);
  v_Foot    varchar(64); --表尾
  v_Count   int;
  v_CeoName varchar(64); --CEO

begin
  -- 获取企业Gid
  v_EntGid  := getEntGid;
  v_Head    := '<table border="0" style="width:500px;"><tr><td>您好 :</td></tr>';
  v_TStart  := '<tr><td>';
  v_TEnd    := '；</td></tr>';
  v_Foot    := '<tr><td>-----------内容展示完毕-----------</td></tr></table>';
  v_Email   := '';
  v_Content := '';

  select count(*)
    into v_Count
    from wf_task t
   where t.EntGid = v_EntGid
     and t.FlowGid = p_FlowGid
     and t.Stat = 1
     and lower(t.code) like '%_tc1%';

  if v_Count > 0 then
    select t.Note
      into v_CeoName
      from wf_task t
     where t.EntGid = v_EntGid
       and t.FlowGid = p_FlowGid
       and t.Stat = 1
       and lower(t.code) like '%_tc1%';
  end if;

  --for 循环 取出未领取的快递
  for R in (select f.*, wm.name ModelName
              from Wf_PrlYL_Baoxiao f, wf_model wm
             where f.EntGid = v_EntGid
               and f.entgid = wm.entgid
               and f.FlowGid = p_FlowGid
               and f.modelgid = wm.modelgid) loop
    v_Stage   := 'FlowGid：' || R.Flowgid || '；模型：' || R.ModelName;
    v_Title   := '个人报销待审提醒:' || R.Filldeptname;
    v_Content := v_Content || v_Head;
  
    if v_Count > 0 then
      v_Body    := '<font stylr="color:red">' || v_CeoName || '</font>';
      v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    end if;

    v_Body    := '[流程名称] : ' || R.ModelName;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[单号] : ' || R.Num;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[发起人] : ' || R.Fillusrname;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[发起时间] : ' || to_char(R.Createdate, 'YYYY.MM.DD HH24:MI');
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[公司名称] : ' || R.Comname;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '<table cellpadding="0" cellspacing="1" class="ListBar" width="100%" style="background-color: #d9dbdf;">';
    v_Body    := v_Body || '<col style="padding-left:4px;width:80%">';
    v_Body    := v_Body || '<col style="padding-left:4px;width:20%">';
    v_Body    := v_Body ||
                 '<tr style="background-color: #ecedef;" align="center">';
    v_Body    := v_Body || '<td>项目信息</td>';
    v_Body    := v_Body || '<td>本次申请金额[元]</td>';
    v_Body    := v_Body || '</tr>';
    v_Content := v_Content || v_TStart || v_Body;
  
    for D in (select f.*
                from Wf_PrlYL_Baoxiao_Dtl f
               where f.EntGid = v_EntGid
                 and f.FlowGid = p_FlowGid) loop
      v_Body    := '<tr valign="top" style="background-color: white">';
      v_Body    := v_Body || '<td>[' || D.Acgcode || ']' || D.Acgname ||
                   '</td>';
      v_Body    := v_Body || '<td align="center">' || D.Applyfee || '</td>';
      v_Body    := v_Body || '</tr>';
      v_Content := v_Content || v_Body;
    end loop;
  
    v_Body    := '</table>';
    v_Content := v_Content || v_Body || '</td></tr>';
    v_Body    := '[报销金额汇总] : ' || R.Sumfee || '元';
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[报销备注] : ' || R.Memo;
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

create or replace procedure P_PrlYL_Fee_doMail(p_FlowGid varchar --流程Gid
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
  v_Count       int;
  v_CeoName   varchar(64); --CEO

begin
  -- 获取企业Gid
  v_EntGid  := getEntGid;
  v_Head    := '<table border="0" style="width:500px;"><tr><td>您好 :</td></tr>';
  v_TStart  := '<tr><td>';
  v_TEnd    := '；</td></tr>';
  v_Foot    := '<tr><td>-----------内容展示完毕-----------</td></tr></table>';
  v_Email   := '';
  v_Content := '';

  select count(*)
    into v_Count
    from wf_task t
   where t.EntGid = v_EntGid
     and t.FlowGid = p_FlowGid
     and t.Stat = 1
     and lower(t.code) like '%_tc1%';

  if v_Count > 0 then
    select t.Note
      into v_CeoName
      from wf_task t
     where t.EntGid = v_EntGid
       and t.FlowGid = p_FlowGid
       and t.Stat = 1
       and lower(t.code) like '%_tc1%';
  end if;

  --for 循环 取出未领取的快递
  for R in (select f.*, wm.name ModelName
              from wf_PrlYL_Fee f, wf_model wm
             where f.EntGid = v_EntGid
               and f.entgid = wm.entgid
               and f.FlowGid = p_FlowGid
               and f.modelgid = wm.modelgid) loop
    v_Stage   := 'FlowGid：' || R.Flowgid || '；模型：'|| R.ModelName;
    v_Title   := '费用待审提醒:' || R.Fillusrdept;
    v_Content := v_Content || v_Head;
  
    if v_Count > 0 then
      v_Body    := '<font stylr="color:red">' || v_CeoName || '</font>';
      v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    end if;

    v_Body    := '[流程名称] : ' || R.ModelName;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[单号] : ' || R.Num;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[发起人] : ' || R.Fillusrname;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[发起时间] : ' || to_char(R.Createdate, 'YYYY.MM.DD HH24:MI');
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[公司名称] : ' || R.Companyname;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[项目名称] : ' || R.ACGONENAME || '-' || R.Acgtwoname;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[DOA信息] : ' || R.Doacode || '-' || R.Doaname;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[申请目的] : ' || R.Target;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[申请项目内容] : ' || R.Memo;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[推荐及理由] : ' || R.Reason;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[剩余预算金额] : ' || R.Controlfee || '元';
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[本次申请金额] : 今年' || R.Askfee || '元；明年' ||
                 nvl(R.Naskfee, '0') || '元';
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

create or replace procedure P_PrlYL_Pay_doMail(p_FlowGid varchar --流程Gid
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
  v_Count       int;
  v_CeoName   varchar(64); --CEO

begin
  -- 获取企业Gid
  v_EntGid  := getEntGid;
  v_Head    := '<table border="0" style="width:500px;"><tr><td>您好 :</td></tr>';
  v_TStart  := '<tr><td>';
  v_TEnd    := '；</td></tr>';
  v_Foot    := '<tr><td>-----------内容展示完毕-----------</td></tr></table>';
  v_Email   := '';
  v_Content := '';

  select count(*)
    into v_Count
    from wf_task t
   where t.EntGid = v_EntGid
     and t.FlowGid = p_FlowGid
     and t.Stat = 1
     and lower(t.code) like '%_tc1%';

  if v_Count > 0 then
    select t.Note
      into v_CeoName
      from wf_task t
     where t.EntGid = v_EntGid
       and t.FlowGid = p_FlowGid
       and t.Stat = 1
       and lower(t.code) like '%_tc1%';
  end if;

  --for 循环 取出未领取的快递
  for R in (select f.*, wm.name ModelName
              from wf_PrlYL_Pay f, wf_model wm
             where f.EntGid = v_EntGid
               and f.entgid = wm.entgid
               and f.FlowGid = p_FlowGid
               and f.modelgid = wm.modelgid) loop
    v_Stage   := 'FlowGid：' || R.Flowgid || '；模型：' || R.ModelName;
    v_Title   := '付款待审提醒:' || R.Fillusrdept;
    v_Content := v_Content || v_Head;
  
    if v_Count > 0 then
      v_Body    := '<font stylr="color:red">' || v_CeoName || '</font>';
      v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    end if;

    v_Body    := '[流程名称] : ' || R.ModelName;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[单号] : ' || R.Num;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[发起人] : ' || R.Fillusrname;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[发起时间] : ' || to_char(R.Createdate, 'YYYY.MM.DD HH24:MI');
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    if R.Feeflowgid is not null then
      v_Body    := '[费用单号] : ' || R.Feenum || '-' || R.Partnum;
      v_Content := v_Content || v_TStart || v_Body || v_TEnd;
      v_Body    := '[是否尾款] : ';
      if R.Isend = 10 then
        v_Body := v_Body || '是';
      else
        v_Body := v_Body || '否';
      end if;
      v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    end if;
    v_Body    := '[公司名称] : ' || R.Companyname;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[项目名称] : ' || R.acgonename || '-' || R.acgtwoname;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[DOA信息] : ' || R.Doacode;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[付款金额] : ' || nvl(R.payfee, 0) || '元';
    if substr(R.Acgonename, 0, 1) = '3' then
      v_Body := v_Body || '(公司承担：' || nvl(R.Npayfee, 0) || '元)';
    end if;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[要求支付方式] : ' || R.Payway;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[人民币(大写)] : ' || R.Bigrmb;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[付款备注] :' || R.Memo;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[收款单位] : ' || R.Payee;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    if R.Feeflowgid is not null then
      v_Body    := '[（A）项目总额] : ' || R.feea;
      v_Content := v_Content || v_TStart || v_Body || v_TEnd;
      v_Body    := '[（B）已付款金额] : ' || R.Feeb;
      v_Content := v_Content || v_TStart || v_Body || v_TEnd;
      v_Body    := '[（C）本次付款] : ' || R.Payfee;
      v_Content := v_Content || v_TStart || v_Body || v_TEnd;
      v_Body    := '[尚欠余额=A-B-C] : ' || R.Feeleft;
      v_Content := v_Content || v_TStart || v_Body || v_TEnd;
      v_Body    := '[实际付款总额=B+C] : ' || R.Feeok;
      v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    end if;
  
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
create or replace procedure P_PrlYL_Stamp_doMail(p_FlowGid varchar --流程Gid
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
  v_Count       int;
  v_CeoName   varchar(64); --CEO

begin
  -- 获取企业Gid
  v_EntGid  := getEntGid;
  v_Head    := '<table border="0" style="width:500px;"><tr><td>您好 :</td></tr>';
  v_TStart  := '<tr><td>';
  v_TEnd    := '；</td></tr>';
  v_Foot    := '<tr><td>-----------内容展示完毕-----------</td></tr></table>';
  v_Email   := '';
  v_Content := '';
  
  select count(*)
    into v_Count
    from wf_task t
   where t.EntGid = v_EntGid
     and t.FlowGid = p_FlowGid
     and t.Stat = 1
     and lower(t.code) like '%_tc1%';

  if v_Count > 0 then
    select t.Note
      into v_CeoName
      from wf_task t
     where t.EntGid = v_EntGid
       and t.FlowGid = p_FlowGid
       and t.Stat = 1
       and lower(t.code) like '%_tc1%';
  end if;

  --for 循环 取出未领取的快递
  for R in (select f.*, wm.name ModelName
              from wf_PrlYL_Stamp f, wf_model wm
             where f.EntGid = v_EntGid
               and f.entgid = wm.entgid
               and f.FlowGid = p_FlowGid
               and f.modelgid = wm.modelgid) loop
    v_Stage   := 'FlowGid：' || R.Flowgid || '；模型：' || R.ModelName;
    v_Title   := '用印待审提醒:' || R.FILLDEPTNAME;
    v_Content := v_Content || v_Head;
  
    if v_Count > 0 then
      v_Body    := '<font stylr="color:red">' || v_CeoName || '</font>';
      v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    end if;

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
    v_Body    := '[部门类型] : ' || R.DeptType;
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