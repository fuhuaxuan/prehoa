--��������ִ�нű�ģ�壺201303�棨���в�����ɾ����
--1��	�����õ��Ĳ�������
declare
  sEntGid varchar2(32);         --��ҵGid
  sModelGid varchar2(32);       --��������ģ��Gid
  sModelCode varchar2(32);      --��������ģ�ʹ���
  sTaskGid_T1 varchar2(32);     --��ʼ����
  sTaskGid_TA1 varchar2(32);
  sTaskGid_TA2 varchar2(32);
  sTaskGid_TA3 varchar2(32);
  sTaskGid_TB varchar2(32);
  sTaskGid_TC1 varchar2(32);
  sTaskGid_TC2 varchar2(32);
  sTaskGid_TD varchar2(32);
  sTaskGid_TMod varchar2(32);
  sTaskGid_TCC varchar2(32);
  sTaskGid_Tend varchar2(32);  --��������
--2��	��������ֵ
BEGIN
  --��ʼ������
  select Gid into sEntGid from Ent where Lower(code) = lower('prlintra');--�޸���ҵCode
  sModelGid := sys_guid();
  sModelCode := 'Prl_AdvertBS_ISF';
  sTaskGid_T1 := sys_guid();
  sTaskGid_TA1 := sys_guid();
  sTaskGid_TA2 := sys_guid();
  sTaskGid_TA3 := sys_guid();
  sTaskGid_TB := sys_guid();
  sTaskGid_TC1 := sys_guid();
  sTaskGid_TC2 := sys_guid();
  sTaskGid_TD := sys_guid();
  sTaskGid_TMod := sys_guid();
  sTaskGid_TCC := sys_guid();
  sTaskGid_Tend := sys_guid();


--3��	ɾ������������Ϣ
  delete from WF_Task_Define where entgid = sEntGid and modelgid = (select modelgid from wf_model where lower(code) = lower(sModelCode) and entgid = sEntGid);
  delete from WF_Task_Define_Exec where entgid = sEntGid and modelgid = (select modelgid from wf_model where lower(code) = lower(sModelCode) and entgid = sEntGid);
  delete from WF_Task_Define_Condition where entgid = sEntGid and modelgid = (select modelgid from wf_model where lower(code) = lower(sModelCode) and entgid = sEntGid);
  delete from WF_rt where entgid = sEntGid and modelgid = (select modelgid from wf_model where lower(code) = lower(sModelCode) and entgid = sEntGid);
  delete from WF_Model where entgid = sEntGid and lower(code) = lower(sModelCode);


--4��	���幤���������� �������
  insert into WF_Model(EntGid, ModelGid, Code, Name, STAT, CLASSIFY, VERSION, AP1, AP2)
  values(sEntGid, sModelGid, sModelCode, '���λ_��ʱ����ISF', 3, '�⻧', '1.0', 0, 0);

  insert into WF_Task_Define(EntGid, ModelGid, TaskDefGid, Code, Name, Note, OrderValue, IsStart, IsEnd, IsMCF)
  values(sEntGid, sModelGid, sTaskGid_T1, sModelCode || '_T1', '��дISF���뵥', '��д', 1, 1, 0, 0);

   insert into WF_Task_Define(EntGid, ModelGid, TaskDefGid, Code, Name, Note, OrderValue, IsStart, IsEnd, IsMCF)
  values(sEntGid, sModelGid, sTaskGid_TMod, sModelCode || '_TMod', '�޸�ISF���뵥','�޸�', 1, 0, 0, 0);

  insert into WF_Task_Define(EntGid, ModelGid, TaskDefGid, Code, Name, Note, OrderValue, IsStart, IsEnd, IsMCF)
  values(sEntGid, sModelGid, sTaskGid_TA1, sModelCode || '_TA1', '���ž�������','����', 1, 0, 0, 0);

  insert into WF_Task_Define(EntGid, ModelGid, TaskDefGid, Code, Name, Note, OrderValue, IsStart, IsEnd, IsMCF)
  values(sEntGid, sModelGid, sTaskGid_TA2, sModelCode || '_TA2', '����������','����', 1, 0, 0, 0);

  insert into WF_Task_Define(EntGid, ModelGid, TaskDefGid, Code, Name, Note, OrderValue, IsStart, IsEnd, IsMCF)
  values(sEntGid, sModelGid, sTaskGid_TA3, sModelCode || '_TA3', '�̳��ܾ�������','����', 1, 0, 0, 0);

  insert into WF_Task_Define(EntGid, ModelGid, TaskDefGid, Code, Name, Note, OrderValue, IsStart, IsEnd, IsMCF)
  values(sEntGid, sModelGid, sTaskGid_TB, sModelCode || '_TB', '�ܲ��ƹ��ܼ�/������������','����', 1, 0, 0, 0);

  insert into WF_Task_Define(EntGid, ModelGid, TaskDefGid, Code, Name, Note, OrderValue, IsStart, IsEnd, IsMCF)
  values(sEntGid, sModelGid, sTaskGid_TC1, sModelCode || '_TC1', '�ʲ��ܼ�(Hd Invest)����','����', 1, 0, 0, 0);

  insert into WF_Task_Define(EntGid, ModelGid, TaskDefGid, Code, Name, Note, OrderValue, IsStart, IsEnd, IsMCF)
  values(sEntGid, sModelGid, sTaskGid_TC2, sModelCode || '_TC2', '��ϯ����٣�CFO������','����', 1, 0, 0, 0);

  insert into WF_Task_Define(EntGid, ModelGid, TaskDefGid, Code, Name, Note, OrderValue, IsStart, IsEnd, IsMCF)
  values(sEntGid, sModelGid, sTaskGid_TD, sModelCode || '_TD', '��ϯִ�й٣�CEO������','����', 1, 0, 0, 0);

  insert into WF_Task_Define(EntGid, ModelGid, TaskDefGid, Code, Name, Note, OrderValue, IsStart, IsEnd, IsMCF)
  values(sEntGid, sModelGid, sTaskGid_TCC, sModelCode||'_Tcc', '���������Ա', '����', 1, 0, 0, 1);

  insert into WF_Task_Define(EntGid, ModelGid, TaskDefGid, Code, Name, Note, OrderValue, IsStart, IsEnd, IsMCF)
  values(sEntGid, sModelGid, sTaskGid_Tend, sModelCode || '_Tend', '������ֹ', '����һ������', 1, 0, 1, 0);

--5��	���幤�����̲���ִ����
  insert into WF_Task_Define_Exec(EntGid, ModelGid, TaskDefGid, ExecGidEx, ExecCodeEx, ExecNameEx, OwnerValue)
  select sEntGid, sModelGid, sTaskGid_T1, Gid, Code, Name, 1 from v_Usr where EntGid = sEntGid and lower(Code) = lower('all_usr_grp');

  insert into WF_Task_Define_Exec(EntGid, ModelGid, TaskDefGid, ExecGidEx, ExecCodeEx, ExecNameEx, OwnerValue)
  values( sEntGid, sModelGid, sTaskGid_TMod, '**CreateGid**', '**CreateCode**', '@������@', 1);

  insert into WF_Task_Define_Exec(EntGid, ModelGid, TaskDefGid, ExecGidEx, ExecCodeEx, ExecNameEx, OwnerValue)
  values( sEntGid, sModelGid, sTaskGid_TA1, '**SpecGid**', '**SpecCode**', '@������ָ��@', 1);

  insert into WF_Task_Define_Exec(EntGid, ModelGid, TaskDefGid, ExecGidEx, ExecCodeEx, ExecNameEx, OwnerValue)
  values( sEntGid, sModelGid, sTaskGid_TA2, '**SpecGid**', '**SpecCode**', '@������ָ��@', 1);

  insert into WF_Task_Define_Exec(EntGid, ModelGid, TaskDefGid, ExecGidEx, ExecCodeEx, ExecNameEx, OwnerValue)
  values( sEntGid, sModelGid, sTaskGid_TA3, '**SpecGid**', '**SpecCode**', '@������ָ��@', 1);

  insert into WF_Task_Define_Exec(EntGid, ModelGid, TaskDefGid, ExecGidEx, ExecCodeEx, ExecNameEx, OwnerValue)
  select sEntGid, sModelGid, sTaskGid_TB, Gid, Code, Name, 1 from v_Usr where EntGid = sEntGid and lower(Code) = lower('admin_grp');

  insert into WF_Task_Define_Exec(EntGid, ModelGid, TaskDefGid, ExecGidEx, ExecCodeEx, ExecNameEx, OwnerValue)
  select sEntGid, sModelGid, sTaskGid_TC1, Gid, Code, Name, 1 from v_Usr where EntGid = sEntGid and lower(Code) = lower('admin_grp');

  insert into WF_Task_Define_Exec(EntGid, ModelGid, TaskDefGid, ExecGidEx, ExecCodeEx, ExecNameEx, OwnerValue)
  select sEntGid, sModelGid, sTaskGid_TC2, Gid, Code, Name, 1 from v_Usr where EntGid = sEntGid and lower(Code) = lower('admin_grp');

  insert into WF_Task_Define_Exec(EntGid, ModelGid, TaskDefGid, ExecGidEx, ExecCodeEx, ExecNameEx, OwnerValue)
  select sEntGid, sModelGid, sTaskGid_TD, Gid, Code, Name, 1 from v_Usr where EntGid = sEntGid and lower(Code) = lower('admin_grp');

  insert into WF_Task_Define_Exec(EntGid, ModelGid, TaskDefGid, ExecGidEx, ExecCodeEx, ExecNameEx, OwnerValue)
  values( sEntGid, sModelGid, sTaskGid_TCC, '**SpecGid**', '**SpecCode**', '@������ָ��@', 1);

--6��	���幤�����̲�������

  --Model Task Condition
  insert into WF_Task_Define_Condition(EntGid, ModelGid, FromTaskDef, ToTaskDef)
  values( sEntGid, sModelGid, sTaskGid_T1, sTaskGid_TMod);

  insert into WF_Task_Define_Condition(EntGid, ModelGid, FromTaskDef, ToTaskDef)
  values( sEntGid, sModelGid, sTaskGid_T1, sTaskGid_TA1);

  insert into WF_Task_Define_Condition(EntGid, ModelGid, FromTaskDef, ToTaskDef)
  values( sEntGid, sModelGid, sTaskGid_TMod, sTaskGid_TA1);

  insert into WF_Task_Define_Condition(EntGid, ModelGid, FromTaskDef, ToTaskDef)
  values( sEntGid, sModelGid, sTaskGid_TA1, sTaskGid_TA2);

  insert into WF_Task_Define_Condition(EntGid, ModelGid, FromTaskDef, ToTaskDef)
  values( sEntGid, sModelGid, sTaskGid_TA2, sTaskGid_TA3);

  insert into WF_Task_Define_Condition(EntGid, ModelGid, FromTaskDef, ToTaskDef)
  values( sEntGid, sModelGid, sTaskGid_TA3, sTaskGid_TB);

  insert into WF_Task_Define_Condition(EntGid, ModelGid, FromTaskDef, ToTaskDef)
  values( sEntGid, sModelGid, sTaskGid_TB, sTaskGid_TC1);

  insert into WF_Task_Define_Condition(EntGid, ModelGid, FromTaskDef, ToTaskDef)
  values( sEntGid, sModelGid, sTaskGid_TC1, sTaskGid_TC2);

  insert into WF_Task_Define_Condition(EntGid, ModelGid, FromTaskDef, ToTaskDef)
  values( sEntGid, sModelGid, sTaskGid_TC2, sTaskGid_TD);


  insert into WF_Task_Define_Condition(EntGid, ModelGid, FromTaskDef, ToTaskDef)
  values( sEntGid, sModelGid, sTaskGid_TA1, sTaskGid_TMod);

  insert into WF_Task_Define_Condition(EntGid, ModelGid, FromTaskDef, ToTaskDef)
  values( sEntGid, sModelGid, sTaskGid_TA2, sTaskGid_TMod);

  insert into WF_Task_Define_Condition(EntGid, ModelGid, FromTaskDef, ToTaskDef)
  values( sEntGid, sModelGid, sTaskGid_TA3, sTaskGid_TMod);

  insert into WF_Task_Define_Condition(EntGid, ModelGid, FromTaskDef, ToTaskDef)
  values( sEntGid, sModelGid, sTaskGid_TB, sTaskGid_TMod);

  insert into WF_Task_Define_Condition(EntGid, ModelGid, FromTaskDef, ToTaskDef)
  values( sEntGid, sModelGid, sTaskGid_TC1, sTaskGid_TMod);

  insert into WF_Task_Define_Condition(EntGid, ModelGid, FromTaskDef, ToTaskDef)
  values( sEntGid, sModelGid, sTaskGid_TC2, sTaskGid_TMod);

  insert into WF_Task_Define_Condition(EntGid, ModelGid, FromTaskDef, ToTaskDef)
  values( sEntGid, sModelGid, sTaskGid_TD, sTaskGid_TMod);


  insert into WF_Task_Define_Condition(EntGid, ModelGid, FromTaskDef, ToTaskDef)
  values( sEntGid, sModelGid, sTaskGid_T1, sTaskGid_TCC);

  insert into WF_Task_Define_Condition(EntGid, ModelGid, FromTaskDef, ToTaskDef)
  values( sEntGid, sModelGid, sTaskGid_TMod, sTaskGid_TCC);

  insert into WF_Task_Define_Condition(EntGid, ModelGid, FromTaskDef, ToTaskDef)
  values( sEntGid, sModelGid, sTaskGid_TA3, sTaskGid_TCC);

  insert into WF_Task_Define_Condition(EntGid, ModelGid, FromTaskDef, ToTaskDef)
  values( sEntGid, sModelGid, sTaskGid_TB, sTaskGid_TCC);

  insert into WF_Task_Define_Condition(EntGid, ModelGid, FromTaskDef, ToTaskDef)
  values( sEntGid, sModelGid, sTaskGid_TC1, sTaskGid_TCC);

  insert into WF_Task_Define_Condition(EntGid, ModelGid, FromTaskDef, ToTaskDef)
  values( sEntGid, sModelGid, sTaskGid_TC2, sTaskGid_TCC);

  insert into WF_Task_Define_Condition(EntGid, ModelGid, FromTaskDef, ToTaskDef)
  values( sEntGid, sModelGid, sTaskGid_TD, sTaskGid_TCC);


  insert into WF_Task_Define_Condition(EntGid, ModelGid, FromTaskDef, ToTaskDef)
  values( sEntGid, sModelGid, sTaskGid_TMod, sTaskGid_Tend);

  insert into WF_Task_Define_Condition(EntGid, ModelGid, FromTaskDef, ToTaskDef)
  values( sEntGid, sModelGid, sTaskGid_TA3, sTaskGid_Tend);

  insert into WF_Task_Define_Condition(EntGid, ModelGid, FromTaskDef, ToTaskDef)
  values( sEntGid, sModelGid, sTaskGid_TB, sTaskGid_Tend);

  insert into WF_Task_Define_Condition(EntGid, ModelGid, FromTaskDef, ToTaskDef)
  values( sEntGid, sModelGid, sTaskGid_TC2, sTaskGid_Tend);

  insert into WF_Task_Define_Condition(EntGid, ModelGid, FromTaskDef, ToTaskDef)
  values( sEntGid, sModelGid, sTaskGid_TD, sTaskGid_Tend);

--7��Ϊ����Ա�Լ������Ա����Ȩ��
--����Ȩ��  ���� ����Ȩ��  ���� ���Ȩ��  ���� ģ������Ȩ��  
  insert into wf_rt (EntGid, ModelGid, UsrGidEX, RTID)
  select sEntGid, sModelGid, gid, '1111' from org where entgid = sEntGid and lower(code) = lower('Admin_Grp');

end;
/

commit;
