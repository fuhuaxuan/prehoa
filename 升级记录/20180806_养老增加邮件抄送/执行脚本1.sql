--工作流程执行脚本模板：201303版（此行不允许删除）
--1、定义用到的参数名称
declare
  v_EntGid      varchar2(32);
  v_ModelGid    varchar2(32);
  v_ModelCode   varchar2(32);
  v_TaskGid_T2  varchar2(32);
  v_TaskGid_Tcc varchar2(32);
  v_Count       int;
begin
  --取出企业Gid
  select Gid into v_EntGid from Ent where Lower(Code) = lower('prlintra');

  --定义模型代码
  v_ModelCode := 'PrlYL_BaoXiao';

  --取出模型Gid
  select ModelGid into v_ModelGid from Wf_Model where EntGid = v_EntGid and Lower(Code) = lower(v_ModelCode);

  --取出步骤 v_TaskGid_Tcc 的个数
  select count(*) into v_Count from WF_Task_Define wtd where EntGid = v_EntGid and ModelGid = v_ModelGid and Lower(Code) = lower(v_ModelCode || '_tc1');

  --定义新增步骤 v_TaskGid_Tcc
  if v_Count = 0 then
    v_TaskGid_Tcc := sys_guid();
  else
    --取出步骤 v_TaskGid_Tcc
    select TaskDefGid into v_TaskGid_Tcc from WF_Task_Define wtd where EntGid = v_EntGid and ModelGid = v_ModelGid and Lower(Code) = lower(v_ModelCode || '_tc1');
  end if;

  --取出步骤 v_TaskGid_T2
  select TaskDefGid into v_TaskGid_T2 from WF_Task_Define wtd where EntGid = v_EntGid and ModelGid = v_ModelGid and Lower(Code) = lower(v_ModelCode || '_t2');

  --删除步骤 v_TaskGid_Tcc
  delete from WF_Task_Define where EntGid = v_EntGid and ModelGid = v_ModelGid and TaskDefGid = v_TaskGid_Tcc;

  --插入步骤 v_TaskGid_Tcc
  insert into WF_Task_Define (EntGid, ModelGid, TaskDefGid, Code, Name, Note, OrderValue, IsStart, IsEnd, IsMCF)
  select v_EntGid, v_ModelGid, v_TaskGid_Tcc, v_ModelCode || '_Tc1', '抄送邮件', '抄送', 1, 0, 0, 1 from dual;

  --删除 v_TaskGid_Tcc 步骤执行人
  delete from WF_Task_Define_Exec where EntGid = v_EntGid and ModelGid = v_ModelGid and TaskDefGid = v_TaskGid_Tcc;

  --插入 v_TaskGid_Tcc 步骤执行人
  insert into WF_Task_Define_Exec (EntGid, ModelGid, TaskDefGid, ExecGidEx, ExecCodeEx, ExecNameEx, OwnerValue)
  select v_EntGid, v_ModelGid, v_TaskGid_Tcc, Gid, Code, Name, 1 from v_Usr where EntGid = v_EntGid and lower(Code) = lower('Admin_Grp');

  --删除流程走向 v_TaskGid_T2 - v_TaskGid_Tcc
  delete from WF_Task_Define_Condition where EntGid = v_EntGid and ModelGid = v_ModelGid and FromTaskDef = v_TaskGid_T2 and ToTaskDef = v_TaskGid_Tcc;

  --新增流程走向 v_TaskGid_T2 - v_TaskGid_Tcc
  insert into WF_Task_Define_Condition (EntGid, ModelGid, FromTaskDef, ToTaskDef)
  select v_EntGid, v_ModelGid, v_TaskGid_T2, v_TaskGid_Tcc from dual;
end;
/
commit;
--工作流程执行脚本模板：201303版（此行不允许删除）
--1、定义用到的参数名称
declare
  v_EntGid      varchar2(32);
  v_ModelGid    varchar2(32);
  v_ModelCode   varchar2(32);
  v_TaskGid_T2  varchar2(32);
  v_TaskGid_Tcc varchar2(32);
  v_Count       int;
begin
  --取出企业Gid
  select Gid into v_EntGid from Ent where Lower(Code) = lower('prlintra');

  --定义模型代码
  v_ModelCode := 'PrlYL_CG';

  --取出模型Gid
  select ModelGid into v_ModelGid from Wf_Model where EntGid = v_EntGid and Lower(Code) = lower(v_ModelCode);

  --取出步骤 v_TaskGid_Tcc 的个数
  select count(*) into v_Count from WF_Task_Define wtd where EntGid = v_EntGid and ModelGid = v_ModelGid and Lower(Code) = lower(v_ModelCode || '_tc1');

  --定义新增步骤 v_TaskGid_Tcc
  if v_Count = 0 then
    v_TaskGid_Tcc := sys_guid();
  else
    --取出步骤 v_TaskGid_Tcc
    select TaskDefGid into v_TaskGid_Tcc from WF_Task_Define wtd where EntGid = v_EntGid and ModelGid = v_ModelGid and Lower(Code) = lower(v_ModelCode || '_tc1');
  end if;

  --取出步骤 v_TaskGid_T2
  select TaskDefGid into v_TaskGid_T2 from WF_Task_Define wtd where EntGid = v_EntGid and ModelGid = v_ModelGid and Lower(Code) = lower(v_ModelCode || '_t2');

  --删除步骤 v_TaskGid_Tcc
  delete from WF_Task_Define where EntGid = v_EntGid and ModelGid = v_ModelGid and TaskDefGid = v_TaskGid_Tcc;

  --插入步骤 v_TaskGid_Tcc
  insert into WF_Task_Define (EntGid, ModelGid, TaskDefGid, Code, Name, Note, OrderValue, IsStart, IsEnd, IsMCF)
  select v_EntGid, v_ModelGid, v_TaskGid_Tcc, v_ModelCode || '_Tc1', '抄送邮件', '抄送', 1, 0, 0, 1 from dual;

  --删除 v_TaskGid_Tcc 步骤执行人
  delete from WF_Task_Define_Exec where EntGid = v_EntGid and ModelGid = v_ModelGid and TaskDefGid = v_TaskGid_Tcc;

  --插入 v_TaskGid_Tcc 步骤执行人
  insert into WF_Task_Define_Exec (EntGid, ModelGid, TaskDefGid, ExecGidEx, ExecCodeEx, ExecNameEx, OwnerValue)
  select v_EntGid, v_ModelGid, v_TaskGid_Tcc, Gid, Code, Name, 1 from v_Usr where EntGid = v_EntGid and lower(Code) = lower('Admin_Grp');

  --删除流程走向 v_TaskGid_T2 - v_TaskGid_Tcc
  delete from WF_Task_Define_Condition where EntGid = v_EntGid and ModelGid = v_ModelGid and FromTaskDef = v_TaskGid_T2 and ToTaskDef = v_TaskGid_Tcc;

  --新增流程走向 v_TaskGid_T2 - v_TaskGid_Tcc
  insert into WF_Task_Define_Condition (EntGid, ModelGid, FromTaskDef, ToTaskDef)
  select v_EntGid, v_ModelGid, v_TaskGid_T2, v_TaskGid_Tcc from dual;
end;
/
commit;
--工作流程执行脚本模板：201303版（此行不允许删除）
--1、定义用到的参数名称
declare
  v_EntGid      varchar2(32);
  v_ModelGid    varchar2(32);
  v_ModelCode   varchar2(32);
  v_TaskGid_T2  varchar2(32);
  v_TaskGid_Tcc varchar2(32);
  v_Count       int;
begin
  --取出企业Gid
  select Gid into v_EntGid from Ent where Lower(Code) = lower('prlintra');

  --定义模型代码
  v_ModelCode := 'PrlYL_ChuChai';

  --取出模型Gid
  select ModelGid into v_ModelGid from Wf_Model where EntGid = v_EntGid and Lower(Code) = lower(v_ModelCode);

  --取出步骤 v_TaskGid_Tcc 的个数
  select count(*) into v_Count from WF_Task_Define wtd where EntGid = v_EntGid and ModelGid = v_ModelGid and Lower(Code) = lower(v_ModelCode || '_tc1');

  --定义新增步骤 v_TaskGid_Tcc
  if v_Count = 0 then
    v_TaskGid_Tcc := sys_guid();
  else
    --取出步骤 v_TaskGid_Tcc
    select TaskDefGid into v_TaskGid_Tcc from WF_Task_Define wtd where EntGid = v_EntGid and ModelGid = v_ModelGid and Lower(Code) = lower(v_ModelCode || '_tc1');
  end if;

  --取出步骤 v_TaskGid_T2
  select TaskDefGid into v_TaskGid_T2 from WF_Task_Define wtd where EntGid = v_EntGid and ModelGid = v_ModelGid and Lower(Code) = lower(v_ModelCode || '_t2');

  --删除步骤 v_TaskGid_Tcc
  delete from WF_Task_Define where EntGid = v_EntGid and ModelGid = v_ModelGid and TaskDefGid = v_TaskGid_Tcc;

  --插入步骤 v_TaskGid_Tcc
  insert into WF_Task_Define (EntGid, ModelGid, TaskDefGid, Code, Name, Note, OrderValue, IsStart, IsEnd, IsMCF)
  select v_EntGid, v_ModelGid, v_TaskGid_Tcc, v_ModelCode || '_Tc1', '抄送邮件', '抄送', 1, 0, 0, 1 from dual;

  --删除 v_TaskGid_Tcc 步骤执行人
  delete from WF_Task_Define_Exec where EntGid = v_EntGid and ModelGid = v_ModelGid and TaskDefGid = v_TaskGid_Tcc;

  --插入 v_TaskGid_Tcc 步骤执行人
  insert into WF_Task_Define_Exec (EntGid, ModelGid, TaskDefGid, ExecGidEx, ExecCodeEx, ExecNameEx, OwnerValue)
  select v_EntGid, v_ModelGid, v_TaskGid_Tcc, Gid, Code, Name, 1 from v_Usr where EntGid = v_EntGid and lower(Code) = lower('Admin_Grp');

  --删除流程走向 v_TaskGid_T2 - v_TaskGid_Tcc
  delete from WF_Task_Define_Condition where EntGid = v_EntGid and ModelGid = v_ModelGid and FromTaskDef = v_TaskGid_T2 and ToTaskDef = v_TaskGid_Tcc;

  --新增流程走向 v_TaskGid_T2 - v_TaskGid_Tcc
  insert into WF_Task_Define_Condition (EntGid, ModelGid, FromTaskDef, ToTaskDef)
  select v_EntGid, v_ModelGid, v_TaskGid_T2, v_TaskGid_Tcc from dual;
end;
/
commit;
--工作流程执行脚本模板：201303版（此行不允许删除）
--1、定义用到的参数名称
declare
  v_EntGid      varchar2(32);
  v_ModelGid    varchar2(32);
  v_ModelCode   varchar2(32);
  v_TaskGid_T2  varchar2(32);
  v_TaskGid_Tcc varchar2(32);
  v_Count       int;
begin
  --取出企业Gid
  select Gid into v_EntGid from Ent where Lower(Code) = lower('prlintra');

  --定义模型代码
  v_ModelCode := 'PrlYL_Contract';

  --取出模型Gid
  select ModelGid into v_ModelGid from Wf_Model where EntGid = v_EntGid and Lower(Code) = lower(v_ModelCode);

  --取出步骤 v_TaskGid_Tcc 的个数
  select count(*) into v_Count from WF_Task_Define wtd where EntGid = v_EntGid and ModelGid = v_ModelGid and Lower(Code) = lower(v_ModelCode || '_tc1');

  --定义新增步骤 v_TaskGid_Tcc
  if v_Count = 0 then
    v_TaskGid_Tcc := sys_guid();
  else
    --取出步骤 v_TaskGid_Tcc
    select TaskDefGid into v_TaskGid_Tcc from WF_Task_Define wtd where EntGid = v_EntGid and ModelGid = v_ModelGid and Lower(Code) = lower(v_ModelCode || '_tc1');
  end if;

  --取出步骤 v_TaskGid_T2
  select TaskDefGid into v_TaskGid_T2 from WF_Task_Define wtd where EntGid = v_EntGid and ModelGid = v_ModelGid and Lower(Code) = lower(v_ModelCode || '_t2');

  --删除步骤 v_TaskGid_Tcc
  delete from WF_Task_Define where EntGid = v_EntGid and ModelGid = v_ModelGid and TaskDefGid = v_TaskGid_Tcc;

  --插入步骤 v_TaskGid_Tcc
  insert into WF_Task_Define (EntGid, ModelGid, TaskDefGid, Code, Name, Note, OrderValue, IsStart, IsEnd, IsMCF)
  select v_EntGid, v_ModelGid, v_TaskGid_Tcc, v_ModelCode || '_Tc1', '抄送邮件', '抄送', 1, 0, 0, 1 from dual;

  --删除 v_TaskGid_Tcc 步骤执行人
  delete from WF_Task_Define_Exec where EntGid = v_EntGid and ModelGid = v_ModelGid and TaskDefGid = v_TaskGid_Tcc;

  --插入 v_TaskGid_Tcc 步骤执行人
  insert into WF_Task_Define_Exec (EntGid, ModelGid, TaskDefGid, ExecGidEx, ExecCodeEx, ExecNameEx, OwnerValue)
  select v_EntGid, v_ModelGid, v_TaskGid_Tcc, Gid, Code, Name, 1 from v_Usr where EntGid = v_EntGid and lower(Code) = lower('Admin_Grp');

  --删除流程走向 v_TaskGid_T2 - v_TaskGid_Tcc
  delete from WF_Task_Define_Condition where EntGid = v_EntGid and ModelGid = v_ModelGid and FromTaskDef = v_TaskGid_T2 and ToTaskDef = v_TaskGid_Tcc;

  --新增流程走向 v_TaskGid_T2 - v_TaskGid_Tcc
  insert into WF_Task_Define_Condition (EntGid, ModelGid, FromTaskDef, ToTaskDef)
  select v_EntGid, v_ModelGid, v_TaskGid_T2, v_TaskGid_Tcc from dual;
end;
/
commit;
--工作流程执行脚本模板：201303版（此行不允许删除）
--1、定义用到的参数名称
declare
  v_EntGid      varchar2(32);
  v_ModelGid    varchar2(32);
  v_ModelCode   varchar2(32);
  v_TaskGid_T2  varchar2(32);
  v_TaskGid_Tcc varchar2(32);
  v_Count       int;
begin
  --取出企业Gid
  select Gid into v_EntGid from Ent where Lower(Code) = lower('prlintra');

  --定义模型代码
  v_ModelCode := 'PrlYL_Fee';

  --取出模型Gid
  select ModelGid into v_ModelGid from Wf_Model where EntGid = v_EntGid and Lower(Code) = lower(v_ModelCode);

  --取出步骤 v_TaskGid_Tcc 的个数
  select count(*) into v_Count from WF_Task_Define wtd where EntGid = v_EntGid and ModelGid = v_ModelGid and Lower(Code) = lower(v_ModelCode || '_tc1');

  --定义新增步骤 v_TaskGid_Tcc
  if v_Count = 0 then
    v_TaskGid_Tcc := sys_guid();
  else
    --取出步骤 v_TaskGid_Tcc
    select TaskDefGid into v_TaskGid_Tcc from WF_Task_Define wtd where EntGid = v_EntGid and ModelGid = v_ModelGid and Lower(Code) = lower(v_ModelCode || '_tc1');
  end if;

  --取出步骤 v_TaskGid_T2
  select TaskDefGid into v_TaskGid_T2 from WF_Task_Define wtd where EntGid = v_EntGid and ModelGid = v_ModelGid and Lower(Code) = lower(v_ModelCode || '_t2');

  --删除步骤 v_TaskGid_Tcc
  delete from WF_Task_Define where EntGid = v_EntGid and ModelGid = v_ModelGid and TaskDefGid = v_TaskGid_Tcc;

  --插入步骤 v_TaskGid_Tcc
  insert into WF_Task_Define (EntGid, ModelGid, TaskDefGid, Code, Name, Note, OrderValue, IsStart, IsEnd, IsMCF)
  select v_EntGid, v_ModelGid, v_TaskGid_Tcc, v_ModelCode || '_Tc1', '抄送邮件', '抄送', 1, 0, 0, 1 from dual;

  --删除 v_TaskGid_Tcc 步骤执行人
  delete from WF_Task_Define_Exec where EntGid = v_EntGid and ModelGid = v_ModelGid and TaskDefGid = v_TaskGid_Tcc;

  --插入 v_TaskGid_Tcc 步骤执行人
  insert into WF_Task_Define_Exec (EntGid, ModelGid, TaskDefGid, ExecGidEx, ExecCodeEx, ExecNameEx, OwnerValue)
  select v_EntGid, v_ModelGid, v_TaskGid_Tcc, Gid, Code, Name, 1 from v_Usr where EntGid = v_EntGid and lower(Code) = lower('Admin_Grp');

  --删除流程走向 v_TaskGid_T2 - v_TaskGid_Tcc
  delete from WF_Task_Define_Condition where EntGid = v_EntGid and ModelGid = v_ModelGid and FromTaskDef = v_TaskGid_T2 and ToTaskDef = v_TaskGid_Tcc;

  --新增流程走向 v_TaskGid_T2 - v_TaskGid_Tcc
  insert into WF_Task_Define_Condition (EntGid, ModelGid, FromTaskDef, ToTaskDef)
  select v_EntGid, v_ModelGid, v_TaskGid_T2, v_TaskGid_Tcc from dual;
end;
/
commit;
--工作流程执行脚本模板：201303版（此行不允许删除）
--1、定义用到的参数名称
declare
  v_EntGid      varchar2(32);
  v_ModelGid    varchar2(32);
  v_ModelCode   varchar2(32);
  v_TaskGid_T2  varchar2(32);
  v_TaskGid_Tcc varchar2(32);
  v_Count       int;
begin
  --取出企业Gid
  select Gid into v_EntGid from Ent where Lower(Code) = lower('prlintra');

  --定义模型代码
  v_ModelCode := 'PrlYL_Pay';

  --取出模型Gid
  select ModelGid into v_ModelGid from Wf_Model where EntGid = v_EntGid and Lower(Code) = lower(v_ModelCode);

  --取出步骤 v_TaskGid_Tcc 的个数
  select count(*) into v_Count from WF_Task_Define wtd where EntGid = v_EntGid and ModelGid = v_ModelGid and Lower(Code) = lower(v_ModelCode || '_tc1');

  --定义新增步骤 v_TaskGid_Tcc
  if v_Count = 0 then
    v_TaskGid_Tcc := sys_guid();
  else
    --取出步骤 v_TaskGid_Tcc
    select TaskDefGid into v_TaskGid_Tcc from WF_Task_Define wtd where EntGid = v_EntGid and ModelGid = v_ModelGid and Lower(Code) = lower(v_ModelCode || '_tc1');
  end if;

  --取出步骤 v_TaskGid_T2
  select TaskDefGid into v_TaskGid_T2 from WF_Task_Define wtd where EntGid = v_EntGid and ModelGid = v_ModelGid and Lower(Code) = lower(v_ModelCode || '_t2');

  --删除步骤 v_TaskGid_Tcc
  delete from WF_Task_Define where EntGid = v_EntGid and ModelGid = v_ModelGid and TaskDefGid = v_TaskGid_Tcc;

  --插入步骤 v_TaskGid_Tcc
  insert into WF_Task_Define (EntGid, ModelGid, TaskDefGid, Code, Name, Note, OrderValue, IsStart, IsEnd, IsMCF)
  select v_EntGid, v_ModelGid, v_TaskGid_Tcc, v_ModelCode || '_Tc1', '抄送邮件', '抄送', 1, 0, 0, 1 from dual;

  --删除 v_TaskGid_Tcc 步骤执行人
  delete from WF_Task_Define_Exec where EntGid = v_EntGid and ModelGid = v_ModelGid and TaskDefGid = v_TaskGid_Tcc;

  --插入 v_TaskGid_Tcc 步骤执行人
  insert into WF_Task_Define_Exec (EntGid, ModelGid, TaskDefGid, ExecGidEx, ExecCodeEx, ExecNameEx, OwnerValue)
  select v_EntGid, v_ModelGid, v_TaskGid_Tcc, Gid, Code, Name, 1 from v_Usr where EntGid = v_EntGid and lower(Code) = lower('Admin_Grp');

  --删除流程走向 v_TaskGid_T2 - v_TaskGid_Tcc
  delete from WF_Task_Define_Condition where EntGid = v_EntGid and ModelGid = v_ModelGid and FromTaskDef = v_TaskGid_T2 and ToTaskDef = v_TaskGid_Tcc;

  --新增流程走向 v_TaskGid_T2 - v_TaskGid_Tcc
  insert into WF_Task_Define_Condition (EntGid, ModelGid, FromTaskDef, ToTaskDef)
  select v_EntGid, v_ModelGid, v_TaskGid_T2, v_TaskGid_Tcc from dual;
end;
/
commit;
--工作流程执行脚本模板：201303版（此行不允许删除）
--1、定义用到的参数名称
declare
  v_EntGid      varchar2(32);
  v_ModelGid    varchar2(32);
  v_ModelCode   varchar2(32);
  v_TaskGid_T2  varchar2(32);
  v_TaskGid_Tcc varchar2(32);
  v_Count       int;
begin
  --取出企业Gid
  select Gid into v_EntGid from Ent where Lower(Code) = lower('prlintra');

  --定义模型代码
  v_ModelCode := 'PrlYL_Stamp';

  --取出模型Gid
  select ModelGid into v_ModelGid from Wf_Model where EntGid = v_EntGid and Lower(Code) = lower(v_ModelCode);

  --取出步骤 v_TaskGid_Tcc 的个数
  select count(*) into v_Count from WF_Task_Define wtd where EntGid = v_EntGid and ModelGid = v_ModelGid and Lower(Code) = lower(v_ModelCode || '_tc1');

  --定义新增步骤 v_TaskGid_Tcc
  if v_Count = 0 then
    v_TaskGid_Tcc := sys_guid();
  else
    --取出步骤 v_TaskGid_Tcc
    select TaskDefGid into v_TaskGid_Tcc from WF_Task_Define wtd where EntGid = v_EntGid and ModelGid = v_ModelGid and Lower(Code) = lower(v_ModelCode || '_tc1');
  end if;

  --取出步骤 v_TaskGid_T2
  select TaskDefGid into v_TaskGid_T2 from WF_Task_Define wtd where EntGid = v_EntGid and ModelGid = v_ModelGid and Lower(Code) = lower(v_ModelCode || '_t2');

  --删除步骤 v_TaskGid_Tcc
  delete from WF_Task_Define where EntGid = v_EntGid and ModelGid = v_ModelGid and TaskDefGid = v_TaskGid_Tcc;

  --插入步骤 v_TaskGid_Tcc
  insert into WF_Task_Define (EntGid, ModelGid, TaskDefGid, Code, Name, Note, OrderValue, IsStart, IsEnd, IsMCF)
  select v_EntGid, v_ModelGid, v_TaskGid_Tcc, v_ModelCode || '_Tc1', '抄送邮件', '抄送', 1, 0, 0, 1 from dual;

  --删除 v_TaskGid_Tcc 步骤执行人
  delete from WF_Task_Define_Exec where EntGid = v_EntGid and ModelGid = v_ModelGid and TaskDefGid = v_TaskGid_Tcc;

  --插入 v_TaskGid_Tcc 步骤执行人
  insert into WF_Task_Define_Exec (EntGid, ModelGid, TaskDefGid, ExecGidEx, ExecCodeEx, ExecNameEx, OwnerValue)
  select v_EntGid, v_ModelGid, v_TaskGid_Tcc, Gid, Code, Name, 1 from v_Usr where EntGid = v_EntGid and lower(Code) = lower('Admin_Grp');

  --删除流程走向 v_TaskGid_T2 - v_TaskGid_Tcc
  delete from WF_Task_Define_Condition where EntGid = v_EntGid and ModelGid = v_ModelGid and FromTaskDef = v_TaskGid_T2 and ToTaskDef = v_TaskGid_Tcc;

  --新增流程走向 v_TaskGid_T2 - v_TaskGid_Tcc
  insert into WF_Task_Define_Condition (EntGid, ModelGid, FromTaskDef, ToTaskDef)
  select v_EntGid, v_ModelGid, v_TaskGid_T2, v_TaskGid_Tcc from dual;
end;
/
commit;