create or replace procedure HDNET_HD_doMailIn(p_FlowGid varchar, --����Gid
                                              p_Option varchar --ѡ��
                                                ) as
  v_Stage   varchar2(1024); -- ���̳���
  v_ErrText varchar2(1024); -- Oracle������Ϣ

  v_EntGid varchar2(32); --��ҵGid

  v_RecGid  varchar2(32); --�ռ���
  v_RecName varchar2(32); 

  v_Boot     varchar(1024);
  v_fAddr    varchar2(64);
  v_fName    varchar2(64);
  v_RplEmail varchar2(64);
  v_isHTML   varchar2(64);
begin
  -- ��ȡ��ҵGid
  v_EntGid   := getEntGid;
  v_Boot     := '<br><br><br>------���ʼ���ϵͳ����������ظ���------';
  v_fAddr    := 'hddenv@hd123.cn';
  v_fName    := 'ǰ̨����ʼ�����';
  v_RplEmail := 'hddenv@hd123.cn';
  v_isHTML   := 'y';

  --for ѭ�� ȡ��δ��ȡ�Ŀ��
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
    v_Stage   := '����δ��ȡ�ʼ�';
    HDNet_SendMail('haidingintra',
                   '�����ȡ����',
                   R.Email,
                   'ǰ̨������ <font color="blue">' || R.MailCount ||
                   '</font> �����δ��ȡ���뾡����ȡ��' || v_Boot,
                   v_fAddr,
                   v_fName,
                   v_RplEmail,
                   v_isHTML);
  end loop;
  --�쳣����
exception
  when others then
    begin
      v_ErrText := substr('�ռ���:' || v_RecName || ';' || v_Stage || ' ʧ��!' ||
                          SQLCode || ':' || SQLERRM,
                          1,
                          1024);
      --������־
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
               'ϵͳ�Զ�',
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



--�Զ������������� ��1��ִ��һ�Σ�ÿ���ٳ�00:30����
variable v_Job_HD_doMailIn number;
begin
  DBMS_JOB.SUBMIT (:v_Job_HD_doMailIn, 'HDNET_HD_doMailIn(null);', trunc(sysdate + 1) + 17.3333/24, 'trunc(sysdate + 1) + 17.3333/24');
end;
/
commit;