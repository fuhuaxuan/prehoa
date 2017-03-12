declare
  sEntGid varchar2(32);
  sModelGid varchar2(32);
  sTaskGid_t1 varchar2(32);
  sTaskGid_ta1 varchar2(32);
  sTaskGid_ta2 varchar2(32);
  sTaskGid_ta3 varchar2(32);
  sTaskGid_tb varchar2(32);
  sTaskGid_tc1 varchar2(32);
  sTaskGid_tc2 varchar2(32);
  sTaskGid_td varchar2(32);
  sTaskGid_t9 varchar2(32);
  sTaskGid_t10 varchar2(32);
  sTaskGid_tmod varchar2(32);
  sTaskGid_tcc1 varchar2(32);
  sTaskGid_tcc2 varchar2(32);
  sTaskGid_tend varchar2(32);
BEGIN
  select Gid into sEntGid from Ent where Lower(code) = 'prlintra';--�޸���ҵGid
  sModelGid := sys_guid();
  sTaskGid_t1 := sys_guid();
  sTaskGid_ta1 := sys_guid();
  sTaskGid_ta2 := sys_guid();
  sTaskGid_ta3 := sys_guid();
  sTaskGid_tb := sys_guid();
  sTaskGid_tc1 := sys_guid();
  sTaskGid_tc2 := sys_guid();
  sTaskGid_td := sys_guid();
  sTaskGid_t9 := sys_guid();
  sTaskGid_t10 := sys_guid();
  sTaskGid_tmod := sys_guid();
  sTaskGid_tcc1 := sys_guid();
  sTaskGid_tcc2 := sys_guid();
  sTaskGid_tend := sys_guid();

  --ɾ��������
  delete from WF_Task_Define where entgid = sEntGid and modelgid = (select modelgid from wf_model where lower(code) = lower('PRL_ISF') and entgid = sEntGid);
  delete from WF_Task_Define_Exec where entgid = sEntGid and modelgid = (select modelgid from wf_model where lower(code) = lower('PRL_ISF') and entgid = sEntGid);
  delete from WF_Task_Define_Condition where entgid = sEntGid and modelgid = (select modelgid from wf_model where lower(code) = lower('PRL_ISF') and entgid = sEntGid);
  delete from WF_rt where entgid = sEntGid and modelgid = (select modelgid from wf_model where lower(code) = lower('PRL_ISF') and entgid = sEntGid);
  delete from WF_Model where entgid = sEntGid and lower(code) = lower('PRL_ISF');


  --Model Table
  insert into WF_Model(EntGid, ModelGid, Code, Name, STAT, CLASSIFY, VERSION, AP1, AP2)
  values(sEntGid, sModelGid, 'PRL_ISF', '���������걨�� Income Summary Form', 3, '�⻧', '1.0', 0, 0);

  --Model Tasks Define
  insert into WF_Task_Define(EntGid, ModelGid, TaskDefGid, Code, Name, Note, OrderValue, IsStart, IsEnd, IsMCF)
  values(sEntGid, sModelGid, sTaskGid_t1, 'PRL_ISF_T1', '�ύ/Submit', '�ύ/Submit', 1, 1, 0, 0);
 
  insert into WF_Task_Define(EntGid, ModelGid, TaskDefGid, Code, Name, Note, OrderValue, IsStart, IsEnd, IsMCF)
  values(sEntGid, sModelGid, sTaskGid_ta1, 'PRL_ISF_TA1', '������/FM����', '����/Approval', 1, 0, 0, 0);

  insert into WF_Task_Define(EntGid, ModelGid, TaskDefGid, Code, Name, Note, OrderValue, IsStart, IsEnd, IsMCF)
  values(sEntGid, sModelGid, sTaskGid_ta2, 'PRL_ISF_TA2', '�����ܾ���/LM����', '����/Approval', 99, 0, 0, 0);

  insert into WF_Task_Define(EntGid, ModelGid, TaskDefGid, Code, Name, Note, OrderValue, IsStart, IsEnd, IsMCF)
  values(sEntGid, sModelGid, sTaskGid_ta3, 'PRL_ISF_TA3', '�̳��ܾ���/CM����', '����/Approval', 1, 0, 0, 0);

  insert into WF_Task_Define(EntGid, ModelGid, TaskDefGid, Code, Name, Note, OrderValue, IsStart, IsEnd, IsMCF)
  values(sEntGid, sModelGid, sTaskGid_tb, 'PRL_ISF_TB', '��������/COO����', '����/Approval', 1, 0, 0, 0);

  insert into WF_Task_Define(EntGid, ModelGid, TaskDefGid, Code, Name, Note, OrderValue, IsStart, IsEnd, IsMCF)
  values(sEntGid, sModelGid, sTaskGid_tc1, 'PRL_ISF_TC1', '�ʲ��ܼ�/Hd Invest����', '����/Approval', 1, 0, 0, 0);

  insert into WF_Task_Define(EntGid, ModelGid, TaskDefGid, Code, Name, Note, OrderValue, IsStart, IsEnd, IsMCF)
  values(sEntGid, sModelGid, sTaskGid_tc2, 'PRL_ISF_TC2', '��ϯ�����/CFO����', '����/Approval', 1, 0, 0, 0);

  insert into WF_Task_Define(EntGid, ModelGid, TaskDefGid, Code, Name, Note, OrderValue, IsStart, IsEnd, IsMCF)
  values(sEntGid, sModelGid, sTaskGid_td, 'PRL_ISF_TD', '��ϯִ�й�/CEO����', '����/Approval', 1, 0, 0, 0);

  insert into WF_Task_Define(EntGid, ModelGid, TaskDefGid, Code, Name, Note, OrderValue, IsStart, IsEnd, IsMCF)
  values(sEntGid, sModelGid, sTaskGid_tmod, 'PRL_ISF_TMod', '�ύ���޸�/Modify', '�޸�/Modify', 1, 0, 0, 0);

  insert into WF_Task_Define(EntGid, ModelGid, TaskDefGid, Code, Name, Note, OrderValue, IsStart, IsEnd, IsMCF)
  values(sEntGid, sModelGid, sTaskGid_tcc1, 'PRL_ISF_Tcc1', 'Asset Manager���Ķ�', '���Ķ�/Read', 1, 0, 0, 1);

  insert into WF_Task_Define(EntGid, ModelGid, TaskDefGid, Code, Name, Note, OrderValue, IsStart, IsEnd, IsMCF)
  values(sEntGid, sModelGid, sTaskGid_tcc2, 'PRL_ISF_Tcc2', '���Ķ�/Read', '���Ķ�/Read', 1, 0, 0, 1);

  insert into WF_Task_Define(EntGid, ModelGid, TaskDefGid, Code, Name, Note, OrderValue, IsStart, IsEnd, IsMCF)
  values(sEntGid, sModelGid, sTaskGid_tend, 'PRL_ISF_Tend', '������ֹ/End', '����һ������/Ent', 1, 0, 1, 0);



  --Model Tasks Execer Define
  insert into WF_Task_Define_Exec(EntGid, ModelGid, TaskDefGid, ExecGidEx, ExecCodeEx, ExecNameEx, OwnerValue)
  select sEntGid, sModelGid, sTaskGid_t1, Gid, Code, Name, 1 from v_Usr where EntGid = sEntGid and lower(Code) = 'all_usr_grp';

  insert into WF_Task_Define_Exec(EntGid, ModelGid, TaskDefGid, ExecGidEx, ExecCodeEx, ExecNameEx, OwnerValue)
  values( sEntGid, sModelGid, sTaskGid_ta1, '**SpecGid**', '**SpecCode**', '@������ָ��@', 1);

  insert into WF_Task_Define_Exec(EntGid, ModelGid, TaskDefGid, ExecGidEx, ExecCodeEx, ExecNameEx, OwnerValue)
  values( sEntGid, sModelGid, sTaskGid_ta2, '**SpecGid**', '**SpecCode**', '@������ָ��@', 1);

  insert into WF_Task_Define_Exec(EntGid, ModelGid, TaskDefGid, ExecGidEx, ExecCodeEx, ExecNameEx, OwnerValue)
  values( sEntGid, sModelGid, sTaskGid_ta3, '**SpecGid**', '**SpecCode**', '@������ָ��@', 1);

  insert into WF_Task_Define_Exec(EntGid, ModelGid, TaskDefGid, ExecGidEx, ExecCodeEx, ExecNameEx, OwnerValue)
  select sEntGid, sModelGid, sTaskGid_tb, Gid, Code, Name, 1 from v_Usr where EntGid = sEntGid and lower(Code) = 'admin_grp';

  insert into WF_Task_Define_Exec(EntGid, ModelGid, TaskDefGid, ExecGidEx, ExecCodeEx, ExecNameEx, OwnerValue)
  select sEntGid, sModelGid, sTaskGid_tc1, Gid, Code, Name, 1 from v_Usr where EntGid = sEntGid and lower(Code) = 'admin_grp';

  insert into WF_Task_Define_Exec(EntGid, ModelGid, TaskDefGid, ExecGidEx, ExecCodeEx, ExecNameEx, OwnerValue)
  select sEntGid, sModelGid, sTaskGid_tc2, Gid, Code, Name, 1 from v_Usr where EntGid = sEntGid and lower(Code) = 'admin_grp';

  insert into WF_Task_Define_Exec(EntGid, ModelGid, TaskDefGid, ExecGidEx, ExecCodeEx, ExecNameEx, OwnerValue)
  select sEntGid, sModelGid, sTaskGid_td, Gid, Code, Name, 1 from v_Usr where EntGid = sEntGid and lower(Code) = 'admin_grp';


  insert into WF_Task_Define_Exec(EntGid, ModelGid, TaskDefGid, ExecGidEx, ExecCodeEx, ExecNameEx, OwnerValue)
  values( sEntGid, sModelGid, sTaskGid_tmod, '**CreateGid**', '**CreateCode**', '@������@', 1);

  insert into WF_Task_Define_Exec(EntGid, ModelGid, TaskDefGid, ExecGidEx, ExecCodeEx, ExecNameEx, OwnerValue)
  select sEntGid, sModelGid, sTaskGid_tcc1, Gid, Code, Name, 1 from v_Usr where EntGid = sEntGid and lower(Code) = 'admin_grp';

  insert into WF_Task_Define_Exec(EntGid, ModelGid, TaskDefGid, ExecGidEx, ExecCodeEx, ExecNameEx, OwnerValue)
  values( sEntGid, sModelGid, sTaskGid_tcc2, '**SpecGid**', '**SpecCode**', '@������ָ��@', 1);


  --Model Task Condition
  insert into WF_Task_Define_Condition(EntGid, ModelGid, FromTaskDef, ToTaskDef)
  values( sEntGid, sModelGid, sTaskGid_t1, sTaskGid_tmod);

  insert into WF_Task_Define_Condition(EntGid, ModelGid, FromTaskDef, ToTaskDef)
  values( sEntGid, sModelGid, sTaskGid_t1, sTaskGid_ta1);

  insert into WF_Task_Define_Condition(EntGid, ModelGid, FromTaskDef, ToTaskDef)
  values( sEntGid, sModelGid, sTaskGid_tmod, sTaskGid_ta1);

  insert into WF_Task_Define_Condition(EntGid, ModelGid, FromTaskDef, ToTaskDef)
  values( sEntGid, sModelGid, sTaskGid_ta1, sTaskGid_ta2);

  insert into WF_Task_Define_Condition(EntGid, ModelGid, FromTaskDef, ToTaskDef)
  values( sEntGid, sModelGid, sTaskGid_ta1, sTaskGid_ta3);

  insert into WF_Task_Define_Condition(EntGid, ModelGid, FromTaskDef, ToTaskDef)
  values( sEntGid, sModelGid, sTaskGid_ta2, sTaskGid_ta3);


  insert into WF_Task_Define_Condition(EntGid, ModelGid, FromTaskDef, ToTaskDef)
  values( sEntGid, sModelGid, sTaskGid_ta3, sTaskGid_tb);

  insert into WF_Task_Define_Condition(EntGid, ModelGid, FromTaskDef, ToTaskDef)
  values( sEntGid, sModelGid, sTaskGid_tb, sTaskGid_tc1);

  insert into WF_Task_Define_Condition(EntGid, ModelGid, FromTaskDef, ToTaskDef)
  values( sEntGid, sModelGid, sTaskGid_tc1, sTaskGid_tc2);


  insert into WF_Task_Define_Condition(EntGid, ModelGid, FromTaskDef, ToTaskDef)
  values( sEntGid, sModelGid, sTaskGid_tc2, sTaskGid_td);




  insert into WF_Task_Define_Condition(EntGid, ModelGid, FromTaskDef, ToTaskDef)
  values( sEntGid, sModelGid, sTaskGid_ta1, sTaskGid_tmod);

  insert into WF_Task_Define_Condition(EntGid, ModelGid, FromTaskDef, ToTaskDef)
  values( sEntGid, sModelGid, sTaskGid_ta2, sTaskGid_tmod);

  insert into WF_Task_Define_Condition(EntGid, ModelGid, FromTaskDef, ToTaskDef)
  values( sEntGid, sModelGid, sTaskGid_ta3, sTaskGid_tmod);

  insert into WF_Task_Define_Condition(EntGid, ModelGid, FromTaskDef, ToTaskDef)
  values( sEntGid, sModelGid, sTaskGid_tb, sTaskGid_tmod);

  insert into WF_Task_Define_Condition(EntGid, ModelGid, FromTaskDef, ToTaskDef)
  values( sEntGid, sModelGid, sTaskGid_tc1, sTaskGid_tmod);

  insert into WF_Task_Define_Condition(EntGid, ModelGid, FromTaskDef, ToTaskDef)
  values( sEntGid, sModelGid, sTaskGid_tc2, sTaskGid_tmod);

  insert into WF_Task_Define_Condition(EntGid, ModelGid, FromTaskDef, ToTaskDef)
  values( sEntGid, sModelGid, sTaskGid_td, sTaskGid_tmod);



  insert into WF_Task_Define_Condition(EntGid, ModelGid, FromTaskDef, ToTaskDef)
  values( sEntGid, sModelGid, sTaskGid_ta1, sTaskGid_tcc1);

  insert into WF_Task_Define_Condition(EntGid, ModelGid, FromTaskDef, ToTaskDef)
  values( sEntGid, sModelGid, sTaskGid_ta2, sTaskGid_tcc1);

  insert into WF_Task_Define_Condition(EntGid, ModelGid, FromTaskDef, ToTaskDef)
  values( sEntGid, sModelGid, sTaskGid_ta3, sTaskGid_tcc1);

  insert into WF_Task_Define_Condition(EntGid, ModelGid, FromTaskDef, ToTaskDef)
  values( sEntGid, sModelGid, sTaskGid_tb, sTaskGid_tcc1);

  insert into WF_Task_Define_Condition(EntGid, ModelGid, FromTaskDef, ToTaskDef)
  values( sEntGid, sModelGid, sTaskGid_tc1, sTaskGid_tcc1);

  insert into WF_Task_Define_Condition(EntGid, ModelGid, FromTaskDef, ToTaskDef)
  values( sEntGid, sModelGid, sTaskGid_tc2, sTaskGid_tcc1);

  insert into WF_Task_Define_Condition(EntGid, ModelGid, FromTaskDef, ToTaskDef)
  values( sEntGid, sModelGid, sTaskGid_td, sTaskGid_tcc1);


  insert into WF_Task_Define_Condition(EntGid, ModelGid, FromTaskDef, ToTaskDef)
  values( sEntGid, sModelGid, sTaskGid_ta3, sTaskGid_tcc2);

  insert into WF_Task_Define_Condition(EntGid, ModelGid, FromTaskDef, ToTaskDef)
  values( sEntGid, sModelGid, sTaskGid_tb, sTaskGid_tcc2);


  insert into WF_Task_Define_Condition(EntGid, ModelGid, FromTaskDef, ToTaskDef)
  values( sEntGid, sModelGid, sTaskGid_tc2, sTaskGid_tcc2);

  insert into WF_Task_Define_Condition(EntGid, ModelGid, FromTaskDef, ToTaskDef)
  values( sEntGid, sModelGid, sTaskGid_td, sTaskGid_tcc2);




  insert into WF_Task_Define_Condition(EntGid, ModelGid, FromTaskDef, ToTaskDef)
  values( sEntGid, sModelGid, sTaskGid_ta1, sTaskGid_t1);

  insert into WF_Task_Define_Condition(EntGid, ModelGid, FromTaskDef, ToTaskDef)
  values( sEntGid, sModelGid, sTaskGid_ta2, sTaskGid_t1);


  insert into WF_Task_Define_Condition(EntGid, ModelGid, FromTaskDef, ToTaskDef)
  values( sEntGid, sModelGid, sTaskGid_ta3, sTaskGid_t1);


  insert into WF_Task_Define_Condition(EntGid, ModelGid, FromTaskDef, ToTaskDef)
  values( sEntGid, sModelGid, sTaskGid_tb, sTaskGid_t1);

  insert into WF_Task_Define_Condition(EntGid, ModelGid, FromTaskDef, ToTaskDef)
  values( sEntGid, sModelGid, sTaskGid_tc1, sTaskGid_t1);

  insert into WF_Task_Define_Condition(EntGid, ModelGid, FromTaskDef, ToTaskDef)
  values( sEntGid, sModelGid, sTaskGid_tc2, sTaskGid_t1);


  insert into WF_Task_Define_Condition(EntGid, ModelGid, FromTaskDef, ToTaskDef)
  values( sEntGid, sModelGid, sTaskGid_td, sTaskGid_t1);


  insert into WF_Task_Define_Condition(EntGid, ModelGid, FromTaskDef, ToTaskDef)
  values( sEntGid, sModelGid, sTaskGid_ta3, sTaskGid_tend);

  insert into WF_Task_Define_Condition(EntGid, ModelGid, FromTaskDef, ToTaskDef)
  values( sEntGid, sModelGid, sTaskGid_tb, sTaskGid_tend);


  insert into WF_Task_Define_Condition(EntGid, ModelGid, FromTaskDef, ToTaskDef)
  values( sEntGid, sModelGid, sTaskGid_tc2, sTaskGid_tend);


  insert into WF_Task_Define_Condition(EntGid, ModelGid, FromTaskDef, ToTaskDef)
  values( sEntGid, sModelGid, sTaskGid_td, sTaskGid_tend);

  insert into WF_Task_Define_Condition(EntGid, ModelGid, FromTaskDef, ToTaskDef)
  values( sEntGid, sModelGid, sTaskGid_tmod, sTaskGid_tend);


  --���̿���Ȩ��
  insert into wf_rt (EntGid, ModelGid, UsrGidEX, RTID)
  select sEntGid, sModelGid, gid, '1111' from org where entgid = sEntGid and code = 'Admin_Grp';


end;
/


commit;