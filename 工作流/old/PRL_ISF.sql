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
  select Gid into sEntGid from Ent where Lower(code) = 'prlintra';--修改企业Gid
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

  --删除旧数据
  delete from WF_Task_Define where entgid = sEntGid and modelgid = (select modelgid from wf_model where lower(code) = lower('PRL_ISF') and entgid = sEntGid);
  delete from WF_Task_Define_Exec where entgid = sEntGid and modelgid = (select modelgid from wf_model where lower(code) = lower('PRL_ISF') and entgid = sEntGid);
  delete from WF_Task_Define_Condition where entgid = sEntGid and modelgid = (select modelgid from wf_model where lower(code) = lower('PRL_ISF') and entgid = sEntGid);
  delete from WF_rt where entgid = sEntGid and modelgid = (select modelgid from wf_model where lower(code) = lower('PRL_ISF') and entgid = sEntGid);
  delete from WF_Model where entgid = sEntGid and lower(code) = lower('PRL_ISF');


  --Model Table
  insert into WF_Model(EntGid, ModelGid, Code, Name, STAT, CLASSIFY, VERSION, AP1, AP2)
  values(sEntGid, sModelGid, 'PRL_ISF', '租赁意向申报表 Income Summary Form', 3, '租户', '1.0', 0, 0);

  --Model Tasks Define
  insert into WF_Task_Define(EntGid, ModelGid, TaskDefGid, Code, Name, Note, OrderValue, IsStart, IsEnd, IsMCF)
  values(sEntGid, sModelGid, sTaskGid_t1, 'PRL_ISF_T1', '提交/Submit', '提交/Submit', 1, 1, 0, 0);
 
  insert into WF_Task_Define(EntGid, ModelGid, TaskDefGid, Code, Name, Note, OrderValue, IsStart, IsEnd, IsMCF)
  values(sEntGid, sModelGid, sTaskGid_ta1, 'PRL_ISF_TA1', '财务经理/FM审批', '审批/Approval', 1, 0, 0, 0);

  insert into WF_Task_Define(EntGid, ModelGid, TaskDefGid, Code, Name, Note, OrderValue, IsStart, IsEnd, IsMCF)
  values(sEntGid, sModelGid, sTaskGid_ta2, 'PRL_ISF_TA2', '招商总经理/LM审批', '审批/Approval', 99, 0, 0, 0);

  insert into WF_Task_Define(EntGid, ModelGid, TaskDefGid, Code, Name, Note, OrderValue, IsStart, IsEnd, IsMCF)
  values(sEntGid, sModelGid, sTaskGid_ta3, 'PRL_ISF_TA3', '商场总经理/CM审批', '审批/Approval', 1, 0, 0, 0);

  insert into WF_Task_Define(EntGid, ModelGid, TaskDefGid, Code, Name, Note, OrderValue, IsStart, IsEnd, IsMCF)
  values(sEntGid, sModelGid, sTaskGid_tb, 'PRL_ISF_TB', '常务理事/COO审批', '审批/Approval', 1, 0, 0, 0);

  insert into WF_Task_Define(EntGid, ModelGid, TaskDefGid, Code, Name, Note, OrderValue, IsStart, IsEnd, IsMCF)
  values(sEntGid, sModelGid, sTaskGid_tc1, 'PRL_ISF_TC1', '资产总监/Hd Invest审批', '审批/Approval', 1, 0, 0, 0);

  insert into WF_Task_Define(EntGid, ModelGid, TaskDefGid, Code, Name, Note, OrderValue, IsStart, IsEnd, IsMCF)
  values(sEntGid, sModelGid, sTaskGid_tc2, 'PRL_ISF_TC2', '首席财务官/CFO审批', '审批/Approval', 1, 0, 0, 0);

  insert into WF_Task_Define(EntGid, ModelGid, TaskDefGid, Code, Name, Note, OrderValue, IsStart, IsEnd, IsMCF)
  values(sEntGid, sModelGid, sTaskGid_td, 'PRL_ISF_TD', '首席执行官/CEO审批', '审批/Approval', 1, 0, 0, 0);

  insert into WF_Task_Define(EntGid, ModelGid, TaskDefGid, Code, Name, Note, OrderValue, IsStart, IsEnd, IsMCF)
  values(sEntGid, sModelGid, sTaskGid_tmod, 'PRL_ISF_TMod', '提交者修改/Modify', '修改/Modify', 1, 0, 0, 0);

  insert into WF_Task_Define(EntGid, ModelGid, TaskDefGid, Code, Name, Note, OrderValue, IsStart, IsEnd, IsMCF)
  values(sEntGid, sModelGid, sTaskGid_tcc1, 'PRL_ISF_Tcc1', 'Asset Manager请阅读', '请阅读/Read', 1, 0, 0, 1);

  insert into WF_Task_Define(EntGid, ModelGid, TaskDefGid, Code, Name, Note, OrderValue, IsStart, IsEnd, IsMCF)
  values(sEntGid, sModelGid, sTaskGid_tcc2, 'PRL_ISF_Tcc2', '请阅读/Read', '请阅读/Read', 1, 0, 0, 1);

  insert into WF_Task_Define(EntGid, ModelGid, TaskDefGid, Code, Name, Note, OrderValue, IsStart, IsEnd, IsMCF)
  values(sEntGid, sModelGid, sTaskGid_tend, 'PRL_ISF_Tend', '流程终止/End', '结束一个流程/Ent', 1, 0, 1, 0);



  --Model Tasks Execer Define
  insert into WF_Task_Define_Exec(EntGid, ModelGid, TaskDefGid, ExecGidEx, ExecCodeEx, ExecNameEx, OwnerValue)
  select sEntGid, sModelGid, sTaskGid_t1, Gid, Code, Name, 1 from v_Usr where EntGid = sEntGid and lower(Code) = 'all_usr_grp';

  insert into WF_Task_Define_Exec(EntGid, ModelGid, TaskDefGid, ExecGidEx, ExecCodeEx, ExecNameEx, OwnerValue)
  values( sEntGid, sModelGid, sTaskGid_ta1, '**SpecGid**', '**SpecCode**', '@流程中指定@', 1);

  insert into WF_Task_Define_Exec(EntGid, ModelGid, TaskDefGid, ExecGidEx, ExecCodeEx, ExecNameEx, OwnerValue)
  values( sEntGid, sModelGid, sTaskGid_ta2, '**SpecGid**', '**SpecCode**', '@流程中指定@', 1);

  insert into WF_Task_Define_Exec(EntGid, ModelGid, TaskDefGid, ExecGidEx, ExecCodeEx, ExecNameEx, OwnerValue)
  values( sEntGid, sModelGid, sTaskGid_ta3, '**SpecGid**', '**SpecCode**', '@流程中指定@', 1);

  insert into WF_Task_Define_Exec(EntGid, ModelGid, TaskDefGid, ExecGidEx, ExecCodeEx, ExecNameEx, OwnerValue)
  select sEntGid, sModelGid, sTaskGid_tb, Gid, Code, Name, 1 from v_Usr where EntGid = sEntGid and lower(Code) = 'admin_grp';

  insert into WF_Task_Define_Exec(EntGid, ModelGid, TaskDefGid, ExecGidEx, ExecCodeEx, ExecNameEx, OwnerValue)
  select sEntGid, sModelGid, sTaskGid_tc1, Gid, Code, Name, 1 from v_Usr where EntGid = sEntGid and lower(Code) = 'admin_grp';

  insert into WF_Task_Define_Exec(EntGid, ModelGid, TaskDefGid, ExecGidEx, ExecCodeEx, ExecNameEx, OwnerValue)
  select sEntGid, sModelGid, sTaskGid_tc2, Gid, Code, Name, 1 from v_Usr where EntGid = sEntGid and lower(Code) = 'admin_grp';

  insert into WF_Task_Define_Exec(EntGid, ModelGid, TaskDefGid, ExecGidEx, ExecCodeEx, ExecNameEx, OwnerValue)
  select sEntGid, sModelGid, sTaskGid_td, Gid, Code, Name, 1 from v_Usr where EntGid = sEntGid and lower(Code) = 'admin_grp';


  insert into WF_Task_Define_Exec(EntGid, ModelGid, TaskDefGid, ExecGidEx, ExecCodeEx, ExecNameEx, OwnerValue)
  values( sEntGid, sModelGid, sTaskGid_tmod, '**CreateGid**', '**CreateCode**', '@发起人@', 1);

  insert into WF_Task_Define_Exec(EntGid, ModelGid, TaskDefGid, ExecGidEx, ExecCodeEx, ExecNameEx, OwnerValue)
  select sEntGid, sModelGid, sTaskGid_tcc1, Gid, Code, Name, 1 from v_Usr where EntGid = sEntGid and lower(Code) = 'admin_grp';

  insert into WF_Task_Define_Exec(EntGid, ModelGid, TaskDefGid, ExecGidEx, ExecCodeEx, ExecNameEx, OwnerValue)
  values( sEntGid, sModelGid, sTaskGid_tcc2, '**SpecGid**', '**SpecCode**', '@流程中指定@', 1);


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


  --流程控制权限
  insert into wf_rt (EntGid, ModelGid, UsrGidEX, RTID)
  select sEntGid, sModelGid, gid, '1111' from org where entgid = sEntGid and code = 'Admin_Grp';


end;
/


commit;