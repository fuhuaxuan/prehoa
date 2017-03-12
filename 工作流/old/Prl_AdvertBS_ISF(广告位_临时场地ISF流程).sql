--工作流程执行脚本模板：201303版（此行不允许删除）
--1、	定义用到的参数名称
declare
  sEntGid varchar2(32);         --企业Gid
  sModelGid varchar2(32);       --工作流程模型Gid
  sModelCode varchar2(32);      --工作流程模型代码
  sTaskGid_T1 varchar2(32);     --开始步骤
  sTaskGid_TA1 varchar2(32);
  sTaskGid_TA2 varchar2(32);
  sTaskGid_TA3 varchar2(32);
  sTaskGid_TB varchar2(32);
  sTaskGid_TC1 varchar2(32);
  sTaskGid_TC2 varchar2(32);
  sTaskGid_TD varchar2(32);
  sTaskGid_TMod varchar2(32);
  sTaskGid_TCC varchar2(32);
  sTaskGid_Tend varchar2(32);  --结束步骤
--2、	各参数赋值
BEGIN
  --初始化数据
  select Gid into sEntGid from Ent where Lower(code) = lower('prlintra');--修改企业Code
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


--3、	删除旧有数据信息
  delete from WF_Task_Define where entgid = sEntGid and modelgid = (select modelgid from wf_model where lower(code) = lower(sModelCode) and entgid = sEntGid);
  delete from WF_Task_Define_Exec where entgid = sEntGid and modelgid = (select modelgid from wf_model where lower(code) = lower(sModelCode) and entgid = sEntGid);
  delete from WF_Task_Define_Condition where entgid = sEntGid and modelgid = (select modelgid from wf_model where lower(code) = lower(sModelCode) and entgid = sEntGid);
  delete from WF_rt where entgid = sEntGid and modelgid = (select modelgid from wf_model where lower(code) = lower(sModelCode) and entgid = sEntGid);
  delete from WF_Model where entgid = sEntGid and lower(code) = lower(sModelCode);


--4、	定义工作流程名称 ，步骤等
  insert into WF_Model(EntGid, ModelGid, Code, Name, STAT, CLASSIFY, VERSION, AP1, AP2)
  values(sEntGid, sModelGid, sModelCode, '广告位_临时场地ISF', 3, '租户', '1.0', 0, 0);

  insert into WF_Task_Define(EntGid, ModelGid, TaskDefGid, Code, Name, Note, OrderValue, IsStart, IsEnd, IsMCF)
  values(sEntGid, sModelGid, sTaskGid_T1, sModelCode || '_T1', '填写ISF申请单', '填写', 1, 1, 0, 0);

   insert into WF_Task_Define(EntGid, ModelGid, TaskDefGid, Code, Name, Note, OrderValue, IsStart, IsEnd, IsMCF)
  values(sEntGid, sModelGid, sTaskGid_TMod, sModelCode || '_TMod', '修改ISF申请单','修改', 1, 0, 0, 0);

  insert into WF_Task_Define(EntGid, ModelGid, TaskDefGid, Code, Name, Note, OrderValue, IsStart, IsEnd, IsMCF)
  values(sEntGid, sModelGid, sTaskGid_TA1, sModelCode || '_TA1', '部门经理审批','审批', 1, 0, 0, 0);

  insert into WF_Task_Define(EntGid, ModelGid, TaskDefGid, Code, Name, Note, OrderValue, IsStart, IsEnd, IsMCF)
  values(sEntGid, sModelGid, sTaskGid_TA2, sModelCode || '_TA2', '财务经理审批','审批', 1, 0, 0, 0);

  insert into WF_Task_Define(EntGid, ModelGid, TaskDefGid, Code, Name, Note, OrderValue, IsStart, IsEnd, IsMCF)
  values(sEntGid, sModelGid, sTaskGid_TA3, sModelCode || '_TA3', '商场总经理审批','审批', 1, 0, 0, 0);

  insert into WF_Task_Define(EntGid, ModelGid, TaskDefGid, Code, Name, Note, OrderValue, IsStart, IsEnd, IsMCF)
  values(sEntGid, sModelGid, sTaskGid_TB, sModelCode || '_TB', '总部推广总监/常务理事审批','审批', 1, 0, 0, 0);

  insert into WF_Task_Define(EntGid, ModelGid, TaskDefGid, Code, Name, Note, OrderValue, IsStart, IsEnd, IsMCF)
  values(sEntGid, sModelGid, sTaskGid_TC1, sModelCode || '_TC1', '资产总监(Hd Invest)审批','审批', 1, 0, 0, 0);

  insert into WF_Task_Define(EntGid, ModelGid, TaskDefGid, Code, Name, Note, OrderValue, IsStart, IsEnd, IsMCF)
  values(sEntGid, sModelGid, sTaskGid_TC2, sModelCode || '_TC2', '首席财务官（CFO）审批','审批', 1, 0, 0, 0);

  insert into WF_Task_Define(EntGid, ModelGid, TaskDefGid, Code, Name, Note, OrderValue, IsStart, IsEnd, IsMCF)
  values(sEntGid, sModelGid, sTaskGid_TD, sModelCode || '_TD', '首席执行官（CEO）审批','审批', 1, 0, 0, 0);

  insert into WF_Task_Define(EntGid, ModelGid, TaskDefGid, Code, Name, Note, OrderValue, IsStart, IsEnd, IsMCF)
  values(sEntGid, sModelGid, sTaskGid_TCC, sModelCode||'_Tcc', '抄送相关人员', '抄送', 1, 0, 0, 1);

  insert into WF_Task_Define(EntGid, ModelGid, TaskDefGid, Code, Name, Note, OrderValue, IsStart, IsEnd, IsMCF)
  values(sEntGid, sModelGid, sTaskGid_Tend, sModelCode || '_Tend', '流程终止', '结束一个流程', 1, 0, 1, 0);

--5、	定义工作流程步骤执行人
  insert into WF_Task_Define_Exec(EntGid, ModelGid, TaskDefGid, ExecGidEx, ExecCodeEx, ExecNameEx, OwnerValue)
  select sEntGid, sModelGid, sTaskGid_T1, Gid, Code, Name, 1 from v_Usr where EntGid = sEntGid and lower(Code) = lower('all_usr_grp');

  insert into WF_Task_Define_Exec(EntGid, ModelGid, TaskDefGid, ExecGidEx, ExecCodeEx, ExecNameEx, OwnerValue)
  values( sEntGid, sModelGid, sTaskGid_TMod, '**CreateGid**', '**CreateCode**', '@发起人@', 1);

  insert into WF_Task_Define_Exec(EntGid, ModelGid, TaskDefGid, ExecGidEx, ExecCodeEx, ExecNameEx, OwnerValue)
  values( sEntGid, sModelGid, sTaskGid_TA1, '**SpecGid**', '**SpecCode**', '@流程中指定@', 1);

  insert into WF_Task_Define_Exec(EntGid, ModelGid, TaskDefGid, ExecGidEx, ExecCodeEx, ExecNameEx, OwnerValue)
  values( sEntGid, sModelGid, sTaskGid_TA2, '**SpecGid**', '**SpecCode**', '@流程中指定@', 1);

  insert into WF_Task_Define_Exec(EntGid, ModelGid, TaskDefGid, ExecGidEx, ExecCodeEx, ExecNameEx, OwnerValue)
  values( sEntGid, sModelGid, sTaskGid_TA3, '**SpecGid**', '**SpecCode**', '@流程中指定@', 1);

  insert into WF_Task_Define_Exec(EntGid, ModelGid, TaskDefGid, ExecGidEx, ExecCodeEx, ExecNameEx, OwnerValue)
  select sEntGid, sModelGid, sTaskGid_TB, Gid, Code, Name, 1 from v_Usr where EntGid = sEntGid and lower(Code) = lower('admin_grp');

  insert into WF_Task_Define_Exec(EntGid, ModelGid, TaskDefGid, ExecGidEx, ExecCodeEx, ExecNameEx, OwnerValue)
  select sEntGid, sModelGid, sTaskGid_TC1, Gid, Code, Name, 1 from v_Usr where EntGid = sEntGid and lower(Code) = lower('admin_grp');

  insert into WF_Task_Define_Exec(EntGid, ModelGid, TaskDefGid, ExecGidEx, ExecCodeEx, ExecNameEx, OwnerValue)
  select sEntGid, sModelGid, sTaskGid_TC2, Gid, Code, Name, 1 from v_Usr where EntGid = sEntGid and lower(Code) = lower('admin_grp');

  insert into WF_Task_Define_Exec(EntGid, ModelGid, TaskDefGid, ExecGidEx, ExecCodeEx, ExecNameEx, OwnerValue)
  select sEntGid, sModelGid, sTaskGid_TD, Gid, Code, Name, 1 from v_Usr where EntGid = sEntGid and lower(Code) = lower('admin_grp');

  insert into WF_Task_Define_Exec(EntGid, ModelGid, TaskDefGid, ExecGidEx, ExecCodeEx, ExecNameEx, OwnerValue)
  values( sEntGid, sModelGid, sTaskGid_TCC, '**SpecGid**', '**SpecCode**', '@流程中指定@', 1);

--6、	定义工作流程步骤走向

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

--7、为管理员以及相关人员设置权限
--监视权限  　　 作废权限  　　 变更权限  　　 模型设置权限  
  insert into wf_rt (EntGid, ModelGid, UsrGidEX, RTID)
  select sEntGid, sModelGid, gid, '1111' from org where entgid = sEntGid and lower(code) = lower('Admin_Grp');

end;
/

commit;
