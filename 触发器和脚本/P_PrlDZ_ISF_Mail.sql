create or replace procedure HDNET_HD_doMailIn(p_FlowGid varchar, --流程Gid
                                              p_Option varchar --选项
                                                ) as
  v_Stage   varchar2(1024); -- 过程场景
  v_ErrText varchar2(1024); -- Oracle错误信息

  v_EntGid varchar2(32); --企业Gid

  v_RecGid  varchar2(32); --收件人
  v_RecName varchar2(32); 

  v_Boot     varchar(1024);
  v_fAddr    varchar2(64);
  v_fName    varchar2(64);
  v_RplEmail varchar2(64);
  v_isHTML   varchar2(64);
begin
  -- 获取企业Gid
  v_EntGid   := getEntGid;
  v_Boot     := '<br><br><br>------本邮件由系统发出，请勿回复！------';
  v_fAddr    := 'hddenv@hd123.cn';
  v_fName    := '前台快递邮件提醒';
  v_RplEmail := 'hddenv@hd123.cn';
  v_isHTML   := 'y';

  --for 循环 取出未领取的快递
  for R in (select t.*, hr.email
              from (select m.entgid, m.recgid, m.RecName, count(*) MailCount
                      from hd_mailin m
                     where m.GetStat is null
                       and m.GetGid is null
                       and m.CreateDate >= nvl(p_Date, sysdate) - 1
                       and m.CreateDate <= nvl(p_Date, sysdate)
                     group by m.entgid, m.recgid, m.RecName
                    having count(*) > 0) t,
                   hr_emp hr
             where t.entgid = hr.entgid
               and hr.usrgid = t.recgid
               and hr.entgid = getentgid
             order by hr.code) loop
    v_RecGid  := R.RecGid;
    v_RecName := R.RecName;
    v_Stage   := '发送未领取邮件';
    HDNet_SendMail('haidingintra',
                   '快递领取提醒',
                   R.Email,
                   '前台有您的 <font color="blue">' || R.MailCount ||
                   '</font> 个快递未领取，请尽快来取！' || v_Boot,
                   v_fAddr,
                   v_fName,
                   v_RplEmail,
                   v_isHTML);
  end loop;
  --异常处理
exception
  when others then
    begin
      v_ErrText := substr('收件人:' || v_RecName || ';' || v_Stage || ' 失败!' ||
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
commit;



--自动结束讨论数据 是1天执行一次，每天临晨00:30进行
variable v_Job_HD_doMailIn number;
begin
  DBMS_JOB.SUBMIT (:v_Job_HD_doMailIn, 'HDNET_HD_doMailIn(null);', trunc(sysdate + 1) + 17.3333/24, 'trunc(sysdate + 1) + 17.3333/24');
end;
/
commit;