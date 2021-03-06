create or replace procedure P_PrlZB_Pay_doMail(p_FlowGid varchar --流程Gid
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
              from wf_PrlZB_Pay f, wf_model wm
             where f.EntGid = v_EntGid
               and f.entgid = wm.entgid
               and f.FlowGid = p_FlowGid
               and f.modelgid = wm.modelgid) loop
    v_Stage   := 'FlowGid：' || R.Flowgid || '；模型：' || R.ModelName;
    v_Title   := '付款待审提醒:' || R.Fillusrdept;
    v_Content := v_Content || v_Head;
  
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