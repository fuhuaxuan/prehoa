--��������ִ�нű�ģ�壺201303�棨���в�����ɾ����
--1�������õ��Ĳ�������
declare
  v_EntGid      varchar2(32);
  v_ModelGid    varchar2(32);
  v_ModelCode   varchar2(32);
  v_TaskGid_T2  varchar2(32);
  v_TaskGid_Tcc varchar2(32);
  v_Count       int;
begin
  --ȡ����ҵGid
  select Gid into v_EntGid from Ent where Lower(Code) = lower('prlintra');

  --����ģ�ʹ���
  v_ModelCode := 'PrlYL_BaoXiao';

  --ȡ��ģ��Gid
  select ModelGid into v_ModelGid from Wf_Model where EntGid = v_EntGid and Lower(Code) = lower(v_ModelCode);

  --ȡ������ v_TaskGid_Tcc �ĸ���
  select count(*) into v_Count from WF_Task_Define wtd where EntGid = v_EntGid and ModelGid = v_ModelGid and Lower(Code) = lower(v_ModelCode || '_tc1');

  --������������ v_TaskGid_Tcc
  if v_Count = 0 then
    v_TaskGid_Tcc := sys_guid();
  else
    --ȡ������ v_TaskGid_Tcc
    select TaskDefGid into v_TaskGid_Tcc from WF_Task_Define wtd where EntGid = v_EntGid and ModelGid = v_ModelGid and Lower(Code) = lower(v_ModelCode || '_tc1');
  end if;

  --ȡ������ v_TaskGid_T2
  select TaskDefGid into v_TaskGid_T2 from WF_Task_Define wtd where EntGid = v_EntGid and ModelGid = v_ModelGid and Lower(Code) = lower(v_ModelCode || '_t2');

  --ɾ������ v_TaskGid_Tcc
  delete from WF_Task_Define where EntGid = v_EntGid and ModelGid = v_ModelGid and TaskDefGid = v_TaskGid_Tcc;

  --���벽�� v_TaskGid_Tcc
  insert into WF_Task_Define (EntGid, ModelGid, TaskDefGid, Code, Name, Note, OrderValue, IsStart, IsEnd, IsMCF)
  select v_EntGid, v_ModelGid, v_TaskGid_Tcc, v_ModelCode || '_Tc1', '�����ʼ�', '����', 1, 0, 0, 1 from dual;

  --ɾ�� v_TaskGid_Tcc ����ִ����
  delete from WF_Task_Define_Exec where EntGid = v_EntGid and ModelGid = v_ModelGid and TaskDefGid = v_TaskGid_Tcc;

  --���� v_TaskGid_Tcc ����ִ����
  insert into WF_Task_Define_Exec (EntGid, ModelGid, TaskDefGid, ExecGidEx, ExecCodeEx, ExecNameEx, OwnerValue)
  select v_EntGid, v_ModelGid, v_TaskGid_Tcc, Gid, Code, Name, 1 from v_Usr where EntGid = v_EntGid and lower(Code) = lower('Admin_Grp');

  --ɾ���������� v_TaskGid_T2 - v_TaskGid_Tcc
  delete from WF_Task_Define_Condition where EntGid = v_EntGid and ModelGid = v_ModelGid and FromTaskDef = v_TaskGid_T2 and ToTaskDef = v_TaskGid_Tcc;

  --������������ v_TaskGid_T2 - v_TaskGid_Tcc
  insert into WF_Task_Define_Condition (EntGid, ModelGid, FromTaskDef, ToTaskDef)
  select v_EntGid, v_ModelGid, v_TaskGid_T2, v_TaskGid_Tcc from dual;
end;
/
commit;
--��������ִ�нű�ģ�壺201303�棨���в�����ɾ����
--1�������õ��Ĳ�������
declare
  v_EntGid      varchar2(32);
  v_ModelGid    varchar2(32);
  v_ModelCode   varchar2(32);
  v_TaskGid_T2  varchar2(32);
  v_TaskGid_Tcc varchar2(32);
  v_Count       int;
begin
  --ȡ����ҵGid
  select Gid into v_EntGid from Ent where Lower(Code) = lower('prlintra');

  --����ģ�ʹ���
  v_ModelCode := 'PrlYL_CG';

  --ȡ��ģ��Gid
  select ModelGid into v_ModelGid from Wf_Model where EntGid = v_EntGid and Lower(Code) = lower(v_ModelCode);

  --ȡ������ v_TaskGid_Tcc �ĸ���
  select count(*) into v_Count from WF_Task_Define wtd where EntGid = v_EntGid and ModelGid = v_ModelGid and Lower(Code) = lower(v_ModelCode || '_tc1');

  --������������ v_TaskGid_Tcc
  if v_Count = 0 then
    v_TaskGid_Tcc := sys_guid();
  else
    --ȡ������ v_TaskGid_Tcc
    select TaskDefGid into v_TaskGid_Tcc from WF_Task_Define wtd where EntGid = v_EntGid and ModelGid = v_ModelGid and Lower(Code) = lower(v_ModelCode || '_tc1');
  end if;

  --ȡ������ v_TaskGid_T2
  select TaskDefGid into v_TaskGid_T2 from WF_Task_Define wtd where EntGid = v_EntGid and ModelGid = v_ModelGid and Lower(Code) = lower(v_ModelCode || '_t2');

  --ɾ������ v_TaskGid_Tcc
  delete from WF_Task_Define where EntGid = v_EntGid and ModelGid = v_ModelGid and TaskDefGid = v_TaskGid_Tcc;

  --���벽�� v_TaskGid_Tcc
  insert into WF_Task_Define (EntGid, ModelGid, TaskDefGid, Code, Name, Note, OrderValue, IsStart, IsEnd, IsMCF)
  select v_EntGid, v_ModelGid, v_TaskGid_Tcc, v_ModelCode || '_Tc1', '�����ʼ�', '����', 1, 0, 0, 1 from dual;

  --ɾ�� v_TaskGid_Tcc ����ִ����
  delete from WF_Task_Define_Exec where EntGid = v_EntGid and ModelGid = v_ModelGid and TaskDefGid = v_TaskGid_Tcc;

  --���� v_TaskGid_Tcc ����ִ����
  insert into WF_Task_Define_Exec (EntGid, ModelGid, TaskDefGid, ExecGidEx, ExecCodeEx, ExecNameEx, OwnerValue)
  select v_EntGid, v_ModelGid, v_TaskGid_Tcc, Gid, Code, Name, 1 from v_Usr where EntGid = v_EntGid and lower(Code) = lower('Admin_Grp');

  --ɾ���������� v_TaskGid_T2 - v_TaskGid_Tcc
  delete from WF_Task_Define_Condition where EntGid = v_EntGid and ModelGid = v_ModelGid and FromTaskDef = v_TaskGid_T2 and ToTaskDef = v_TaskGid_Tcc;

  --������������ v_TaskGid_T2 - v_TaskGid_Tcc
  insert into WF_Task_Define_Condition (EntGid, ModelGid, FromTaskDef, ToTaskDef)
  select v_EntGid, v_ModelGid, v_TaskGid_T2, v_TaskGid_Tcc from dual;
end;
/
commit;
--��������ִ�нű�ģ�壺201303�棨���в�����ɾ����
--1�������õ��Ĳ�������
declare
  v_EntGid      varchar2(32);
  v_ModelGid    varchar2(32);
  v_ModelCode   varchar2(32);
  v_TaskGid_T2  varchar2(32);
  v_TaskGid_Tcc varchar2(32);
  v_Count       int;
begin
  --ȡ����ҵGid
  select Gid into v_EntGid from Ent where Lower(Code) = lower('prlintra');

  --����ģ�ʹ���
  v_ModelCode := 'PrlYL_ChuChai';

  --ȡ��ģ��Gid
  select ModelGid into v_ModelGid from Wf_Model where EntGid = v_EntGid and Lower(Code) = lower(v_ModelCode);

  --ȡ������ v_TaskGid_Tcc �ĸ���
  select count(*) into v_Count from WF_Task_Define wtd where EntGid = v_EntGid and ModelGid = v_ModelGid and Lower(Code) = lower(v_ModelCode || '_tc1');

  --������������ v_TaskGid_Tcc
  if v_Count = 0 then
    v_TaskGid_Tcc := sys_guid();
  else
    --ȡ������ v_TaskGid_Tcc
    select TaskDefGid into v_TaskGid_Tcc from WF_Task_Define wtd where EntGid = v_EntGid and ModelGid = v_ModelGid and Lower(Code) = lower(v_ModelCode || '_tc1');
  end if;

  --ȡ������ v_TaskGid_T2
  select TaskDefGid into v_TaskGid_T2 from WF_Task_Define wtd where EntGid = v_EntGid and ModelGid = v_ModelGid and Lower(Code) = lower(v_ModelCode || '_t2');

  --ɾ������ v_TaskGid_Tcc
  delete from WF_Task_Define where EntGid = v_EntGid and ModelGid = v_ModelGid and TaskDefGid = v_TaskGid_Tcc;

  --���벽�� v_TaskGid_Tcc
  insert into WF_Task_Define (EntGid, ModelGid, TaskDefGid, Code, Name, Note, OrderValue, IsStart, IsEnd, IsMCF)
  select v_EntGid, v_ModelGid, v_TaskGid_Tcc, v_ModelCode || '_Tc1', '�����ʼ�', '����', 1, 0, 0, 1 from dual;

  --ɾ�� v_TaskGid_Tcc ����ִ����
  delete from WF_Task_Define_Exec where EntGid = v_EntGid and ModelGid = v_ModelGid and TaskDefGid = v_TaskGid_Tcc;

  --���� v_TaskGid_Tcc ����ִ����
  insert into WF_Task_Define_Exec (EntGid, ModelGid, TaskDefGid, ExecGidEx, ExecCodeEx, ExecNameEx, OwnerValue)
  select v_EntGid, v_ModelGid, v_TaskGid_Tcc, Gid, Code, Name, 1 from v_Usr where EntGid = v_EntGid and lower(Code) = lower('Admin_Grp');

  --ɾ���������� v_TaskGid_T2 - v_TaskGid_Tcc
  delete from WF_Task_Define_Condition where EntGid = v_EntGid and ModelGid = v_ModelGid and FromTaskDef = v_TaskGid_T2 and ToTaskDef = v_TaskGid_Tcc;

  --������������ v_TaskGid_T2 - v_TaskGid_Tcc
  insert into WF_Task_Define_Condition (EntGid, ModelGid, FromTaskDef, ToTaskDef)
  select v_EntGid, v_ModelGid, v_TaskGid_T2, v_TaskGid_Tcc from dual;
end;
/
commit;
--��������ִ�нű�ģ�壺201303�棨���в�����ɾ����
--1�������õ��Ĳ�������
declare
  v_EntGid      varchar2(32);
  v_ModelGid    varchar2(32);
  v_ModelCode   varchar2(32);
  v_TaskGid_T2  varchar2(32);
  v_TaskGid_Tcc varchar2(32);
  v_Count       int;
begin
  --ȡ����ҵGid
  select Gid into v_EntGid from Ent where Lower(Code) = lower('prlintra');

  --����ģ�ʹ���
  v_ModelCode := 'PrlYL_Contract';

  --ȡ��ģ��Gid
  select ModelGid into v_ModelGid from Wf_Model where EntGid = v_EntGid and Lower(Code) = lower(v_ModelCode);

  --ȡ������ v_TaskGid_Tcc �ĸ���
  select count(*) into v_Count from WF_Task_Define wtd where EntGid = v_EntGid and ModelGid = v_ModelGid and Lower(Code) = lower(v_ModelCode || '_tc1');

  --������������ v_TaskGid_Tcc
  if v_Count = 0 then
    v_TaskGid_Tcc := sys_guid();
  else
    --ȡ������ v_TaskGid_Tcc
    select TaskDefGid into v_TaskGid_Tcc from WF_Task_Define wtd where EntGid = v_EntGid and ModelGid = v_ModelGid and Lower(Code) = lower(v_ModelCode || '_tc1');
  end if;

  --ȡ������ v_TaskGid_T2
  select TaskDefGid into v_TaskGid_T2 from WF_Task_Define wtd where EntGid = v_EntGid and ModelGid = v_ModelGid and Lower(Code) = lower(v_ModelCode || '_t2');

  --ɾ������ v_TaskGid_Tcc
  delete from WF_Task_Define where EntGid = v_EntGid and ModelGid = v_ModelGid and TaskDefGid = v_TaskGid_Tcc;

  --���벽�� v_TaskGid_Tcc
  insert into WF_Task_Define (EntGid, ModelGid, TaskDefGid, Code, Name, Note, OrderValue, IsStart, IsEnd, IsMCF)
  select v_EntGid, v_ModelGid, v_TaskGid_Tcc, v_ModelCode || '_Tc1', '�����ʼ�', '����', 1, 0, 0, 1 from dual;

  --ɾ�� v_TaskGid_Tcc ����ִ����
  delete from WF_Task_Define_Exec where EntGid = v_EntGid and ModelGid = v_ModelGid and TaskDefGid = v_TaskGid_Tcc;

  --���� v_TaskGid_Tcc ����ִ����
  insert into WF_Task_Define_Exec (EntGid, ModelGid, TaskDefGid, ExecGidEx, ExecCodeEx, ExecNameEx, OwnerValue)
  select v_EntGid, v_ModelGid, v_TaskGid_Tcc, Gid, Code, Name, 1 from v_Usr where EntGid = v_EntGid and lower(Code) = lower('Admin_Grp');

  --ɾ���������� v_TaskGid_T2 - v_TaskGid_Tcc
  delete from WF_Task_Define_Condition where EntGid = v_EntGid and ModelGid = v_ModelGid and FromTaskDef = v_TaskGid_T2 and ToTaskDef = v_TaskGid_Tcc;

  --������������ v_TaskGid_T2 - v_TaskGid_Tcc
  insert into WF_Task_Define_Condition (EntGid, ModelGid, FromTaskDef, ToTaskDef)
  select v_EntGid, v_ModelGid, v_TaskGid_T2, v_TaskGid_Tcc from dual;
end;
/
commit;
--��������ִ�нű�ģ�壺201303�棨���в�����ɾ����
--1�������õ��Ĳ�������
declare
  v_EntGid      varchar2(32);
  v_ModelGid    varchar2(32);
  v_ModelCode   varchar2(32);
  v_TaskGid_T2  varchar2(32);
  v_TaskGid_Tcc varchar2(32);
  v_Count       int;
begin
  --ȡ����ҵGid
  select Gid into v_EntGid from Ent where Lower(Code) = lower('prlintra');

  --����ģ�ʹ���
  v_ModelCode := 'PrlYL_Fee';

  --ȡ��ģ��Gid
  select ModelGid into v_ModelGid from Wf_Model where EntGid = v_EntGid and Lower(Code) = lower(v_ModelCode);

  --ȡ������ v_TaskGid_Tcc �ĸ���
  select count(*) into v_Count from WF_Task_Define wtd where EntGid = v_EntGid and ModelGid = v_ModelGid and Lower(Code) = lower(v_ModelCode || '_tc1');

  --������������ v_TaskGid_Tcc
  if v_Count = 0 then
    v_TaskGid_Tcc := sys_guid();
  else
    --ȡ������ v_TaskGid_Tcc
    select TaskDefGid into v_TaskGid_Tcc from WF_Task_Define wtd where EntGid = v_EntGid and ModelGid = v_ModelGid and Lower(Code) = lower(v_ModelCode || '_tc1');
  end if;

  --ȡ������ v_TaskGid_T2
  select TaskDefGid into v_TaskGid_T2 from WF_Task_Define wtd where EntGid = v_EntGid and ModelGid = v_ModelGid and Lower(Code) = lower(v_ModelCode || '_t2');

  --ɾ������ v_TaskGid_Tcc
  delete from WF_Task_Define where EntGid = v_EntGid and ModelGid = v_ModelGid and TaskDefGid = v_TaskGid_Tcc;

  --���벽�� v_TaskGid_Tcc
  insert into WF_Task_Define (EntGid, ModelGid, TaskDefGid, Code, Name, Note, OrderValue, IsStart, IsEnd, IsMCF)
  select v_EntGid, v_ModelGid, v_TaskGid_Tcc, v_ModelCode || '_Tc1', '�����ʼ�', '����', 1, 0, 0, 1 from dual;

  --ɾ�� v_TaskGid_Tcc ����ִ����
  delete from WF_Task_Define_Exec where EntGid = v_EntGid and ModelGid = v_ModelGid and TaskDefGid = v_TaskGid_Tcc;

  --���� v_TaskGid_Tcc ����ִ����
  insert into WF_Task_Define_Exec (EntGid, ModelGid, TaskDefGid, ExecGidEx, ExecCodeEx, ExecNameEx, OwnerValue)
  select v_EntGid, v_ModelGid, v_TaskGid_Tcc, Gid, Code, Name, 1 from v_Usr where EntGid = v_EntGid and lower(Code) = lower('Admin_Grp');

  --ɾ���������� v_TaskGid_T2 - v_TaskGid_Tcc
  delete from WF_Task_Define_Condition where EntGid = v_EntGid and ModelGid = v_ModelGid and FromTaskDef = v_TaskGid_T2 and ToTaskDef = v_TaskGid_Tcc;

  --������������ v_TaskGid_T2 - v_TaskGid_Tcc
  insert into WF_Task_Define_Condition (EntGid, ModelGid, FromTaskDef, ToTaskDef)
  select v_EntGid, v_ModelGid, v_TaskGid_T2, v_TaskGid_Tcc from dual;
end;
/
commit;
--��������ִ�нű�ģ�壺201303�棨���в�����ɾ����
--1�������õ��Ĳ�������
declare
  v_EntGid      varchar2(32);
  v_ModelGid    varchar2(32);
  v_ModelCode   varchar2(32);
  v_TaskGid_T2  varchar2(32);
  v_TaskGid_Tcc varchar2(32);
  v_Count       int;
begin
  --ȡ����ҵGid
  select Gid into v_EntGid from Ent where Lower(Code) = lower('prlintra');

  --����ģ�ʹ���
  v_ModelCode := 'PrlYL_Pay';

  --ȡ��ģ��Gid
  select ModelGid into v_ModelGid from Wf_Model where EntGid = v_EntGid and Lower(Code) = lower(v_ModelCode);

  --ȡ������ v_TaskGid_Tcc �ĸ���
  select count(*) into v_Count from WF_Task_Define wtd where EntGid = v_EntGid and ModelGid = v_ModelGid and Lower(Code) = lower(v_ModelCode || '_tc1');

  --������������ v_TaskGid_Tcc
  if v_Count = 0 then
    v_TaskGid_Tcc := sys_guid();
  else
    --ȡ������ v_TaskGid_Tcc
    select TaskDefGid into v_TaskGid_Tcc from WF_Task_Define wtd where EntGid = v_EntGid and ModelGid = v_ModelGid and Lower(Code) = lower(v_ModelCode || '_tc1');
  end if;

  --ȡ������ v_TaskGid_T2
  select TaskDefGid into v_TaskGid_T2 from WF_Task_Define wtd where EntGid = v_EntGid and ModelGid = v_ModelGid and Lower(Code) = lower(v_ModelCode || '_t2');

  --ɾ������ v_TaskGid_Tcc
  delete from WF_Task_Define where EntGid = v_EntGid and ModelGid = v_ModelGid and TaskDefGid = v_TaskGid_Tcc;

  --���벽�� v_TaskGid_Tcc
  insert into WF_Task_Define (EntGid, ModelGid, TaskDefGid, Code, Name, Note, OrderValue, IsStart, IsEnd, IsMCF)
  select v_EntGid, v_ModelGid, v_TaskGid_Tcc, v_ModelCode || '_Tc1', '�����ʼ�', '����', 1, 0, 0, 1 from dual;

  --ɾ�� v_TaskGid_Tcc ����ִ����
  delete from WF_Task_Define_Exec where EntGid = v_EntGid and ModelGid = v_ModelGid and TaskDefGid = v_TaskGid_Tcc;

  --���� v_TaskGid_Tcc ����ִ����
  insert into WF_Task_Define_Exec (EntGid, ModelGid, TaskDefGid, ExecGidEx, ExecCodeEx, ExecNameEx, OwnerValue)
  select v_EntGid, v_ModelGid, v_TaskGid_Tcc, Gid, Code, Name, 1 from v_Usr where EntGid = v_EntGid and lower(Code) = lower('Admin_Grp');

  --ɾ���������� v_TaskGid_T2 - v_TaskGid_Tcc
  delete from WF_Task_Define_Condition where EntGid = v_EntGid and ModelGid = v_ModelGid and FromTaskDef = v_TaskGid_T2 and ToTaskDef = v_TaskGid_Tcc;

  --������������ v_TaskGid_T2 - v_TaskGid_Tcc
  insert into WF_Task_Define_Condition (EntGid, ModelGid, FromTaskDef, ToTaskDef)
  select v_EntGid, v_ModelGid, v_TaskGid_T2, v_TaskGid_Tcc from dual;
end;
/
commit;
--��������ִ�нű�ģ�壺201303�棨���в�����ɾ����
--1�������õ��Ĳ�������
declare
  v_EntGid      varchar2(32);
  v_ModelGid    varchar2(32);
  v_ModelCode   varchar2(32);
  v_TaskGid_T2  varchar2(32);
  v_TaskGid_Tcc varchar2(32);
  v_Count       int;
begin
  --ȡ����ҵGid
  select Gid into v_EntGid from Ent where Lower(Code) = lower('prlintra');

  --����ģ�ʹ���
  v_ModelCode := 'PrlYL_Stamp';

  --ȡ��ģ��Gid
  select ModelGid into v_ModelGid from Wf_Model where EntGid = v_EntGid and Lower(Code) = lower(v_ModelCode);

  --ȡ������ v_TaskGid_Tcc �ĸ���
  select count(*) into v_Count from WF_Task_Define wtd where EntGid = v_EntGid and ModelGid = v_ModelGid and Lower(Code) = lower(v_ModelCode || '_tc1');

  --������������ v_TaskGid_Tcc
  if v_Count = 0 then
    v_TaskGid_Tcc := sys_guid();
  else
    --ȡ������ v_TaskGid_Tcc
    select TaskDefGid into v_TaskGid_Tcc from WF_Task_Define wtd where EntGid = v_EntGid and ModelGid = v_ModelGid and Lower(Code) = lower(v_ModelCode || '_tc1');
  end if;

  --ȡ������ v_TaskGid_T2
  select TaskDefGid into v_TaskGid_T2 from WF_Task_Define wtd where EntGid = v_EntGid and ModelGid = v_ModelGid and Lower(Code) = lower(v_ModelCode || '_t2');

  --ɾ������ v_TaskGid_Tcc
  delete from WF_Task_Define where EntGid = v_EntGid and ModelGid = v_ModelGid and TaskDefGid = v_TaskGid_Tcc;

  --���벽�� v_TaskGid_Tcc
  insert into WF_Task_Define (EntGid, ModelGid, TaskDefGid, Code, Name, Note, OrderValue, IsStart, IsEnd, IsMCF)
  select v_EntGid, v_ModelGid, v_TaskGid_Tcc, v_ModelCode || '_Tc1', '�����ʼ�', '����', 1, 0, 0, 1 from dual;

  --ɾ�� v_TaskGid_Tcc ����ִ����
  delete from WF_Task_Define_Exec where EntGid = v_EntGid and ModelGid = v_ModelGid and TaskDefGid = v_TaskGid_Tcc;

  --���� v_TaskGid_Tcc ����ִ����
  insert into WF_Task_Define_Exec (EntGid, ModelGid, TaskDefGid, ExecGidEx, ExecCodeEx, ExecNameEx, OwnerValue)
  select v_EntGid, v_ModelGid, v_TaskGid_Tcc, Gid, Code, Name, 1 from v_Usr where EntGid = v_EntGid and lower(Code) = lower('Admin_Grp');

  --ɾ���������� v_TaskGid_T2 - v_TaskGid_Tcc
  delete from WF_Task_Define_Condition where EntGid = v_EntGid and ModelGid = v_ModelGid and FromTaskDef = v_TaskGid_T2 and ToTaskDef = v_TaskGid_Tcc;

  --������������ v_TaskGid_T2 - v_TaskGid_Tcc
  insert into WF_Task_Define_Condition (EntGid, ModelGid, FromTaskDef, ToTaskDef)
  select v_EntGid, v_ModelGid, v_TaskGid_T2, v_TaskGid_Tcc from dual;
end;
/
commit;