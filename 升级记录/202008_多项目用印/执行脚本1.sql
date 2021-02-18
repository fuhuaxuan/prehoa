--工作流程执行脚本模板：201403版（此行不允许删除）
--1、定义流程用到的参数名称
declare
  v_EntGid varchar2(32);         --企业Gid
  v_ModelGid varchar2(32);       --工作流程模型Gid
  v_ModelCode varchar2(32);      --工作流程模型代码
  v_TaskGid varchar2(32);
  v_TaskGid_T1 varchar2(32);     --开始步骤
  v_TaskGid_T2 varchar2(32);
  v_TaskGid_Tcc varchar2(32);
  v_TaskGid_Tc varchar2(32);
  v_TaskGid_Tc1 varchar2(32);
  v_TaskGid_Tc2 varchar2(32);
  v_TaskGid_Tend varchar2(32);   --结束步骤
  v_Count int;
BEGIN
--2、初始化赋值
  v_TaskGid := sys_guid();
  v_TaskGid_T1 := sys_guid();
  v_TaskGid_T2 := sys_guid();
  v_TaskGid_Tcc := sys_guid();
  v_TaskGid_Tc := sys_guid();
  v_TaskGid_Tc1 := sys_guid();
  v_TaskGid_Tc2 := sys_guid();
  v_TaskGid_Tend := sys_guid();

  --获取企业Gid
  select Gid into v_EntGid from Ent where Lower(code) = lower('prlintra');--修改企业Code

  --定义模型代码
  v_ModelCode := 'PrlDZ_Stamp';

  --取出当前模型代码对应模型的数量
  select count(*) into v_Count from wf_model where lower(Code) = lower(v_ModelCode) and EntGid = v_EntGid;
  
  --获取模型Gid
  if v_Count = 0 then
    v_ModelGid := sys_guid();
  else
    select ModelGid into v_ModelGid from wf_model where lower(Code) = lower(v_ModelCode) and EntGid = v_EntGid;
  end if;

--3、删除旧有数据信息
  delete from WF_Model where EntGid = v_EntGid and ModelGid = v_ModelGid;
  delete from WF_Task_Define where EntGid = v_EntGid and ModelGid = v_ModelGid;
  delete from WF_Task_Define_Exec where EntGid = v_EntGid and ModelGid = v_ModelGid;
  delete from WF_Task_Define_Condition where EntGid = v_EntGid and ModelGid = v_ModelGid;
  delete from WF_rt where EntGid = v_EntGid and ModelGid = v_ModelGid;
  --delete from WF_Flow where EntGid = v_EntGid and ModelGid = v_ModelGid;
  --delete from WF_Task where EntGid = v_EntGid and ModelGid = v_ModelGid;
  --delete from WF_Task_History where EntGid = v_EntGid and ModelGid = v_ModelGid;

--4、定义工作流程名称 ，步骤等
  insert into WF_Model(EntGid, ModelGid, Code, Name, STAT, CLASSIFY, VERSION, AP1, AP2)
  select v_EntGid, v_ModelGid, v_ModelCode, '多项目用印申请流程', 3, '项目审批流程-行政相关', '1.0', 0, 0 from dual;

  /*
  insert into WF_Task_Define(EntGid, ModelGid, TaskDefGid, Code, Name, Note, OrderValue, IsStart, IsEnd, IsMCF)
  select v_EntGid, v_ModelGid, v_TaskGid, v_ModelCode, '明细', '用于判断查看权限', 1, 0, 0, 0 from dual;
  */

  insert into WF_Task_Define(EntGid, ModelGid, TaskDefGid, Code, Name, Note, OrderValue, IsStart, IsEnd, IsMCF)
  select v_EntGid, v_ModelGid, v_TaskGid_T1, v_ModelCode || '_T1', '发起人填写申请单', '填写/修改', 1, 1, 0, 0 from dual;

  insert into WF_Task_Define(EntGid, ModelGid, TaskDefGid, Code, Name, Note, OrderValue, IsStart, IsEnd, IsMCF)
  select v_EntGid, v_ModelGid, v_TaskGid_T2, v_ModelCode || '_T2', '请审批','审批', 1, 0, 0, 0 from dual;

  insert into WF_Task_Define(EntGid, ModelGid, TaskDefGid, Code, Name, Note, OrderValue, IsStart, IsEnd, IsMCF)
  select v_EntGid, v_ModelGid, v_TaskGid_Tcc, v_ModelCode||'_Tcc', '抄送人印章管理人', '抄送', 1, 0, 0, 1 from dual;

  insert into WF_Task_Define(EntGid, ModelGid, TaskDefGid, Code, Name, Note, OrderValue, IsStart, IsEnd, IsMCF)
  select v_EntGid, v_ModelGid, v_TaskGid_Tc, v_ModelCode||'_Tc', '抄送项目副总监', '抄送', 1, 0, 0, 1 from dual;

  insert into WF_Task_Define(EntGid, ModelGid, TaskDefGid, Code, Name, Note, OrderValue, IsStart, IsEnd, IsMCF)
  select v_EntGid, v_ModelGid, v_TaskGid_Tc1, v_ModelCode||'_Tc1', '抄送财务总监', '抄送', 1, 0, 0, 1 from dual;

  insert into WF_Task_Define(EntGid, ModelGid, TaskDefGid, Code, Name, Note, OrderValue, IsStart, IsEnd, IsMCF)
  select v_EntGid, v_ModelGid, v_TaskGid_Tc2, v_ModelCode||'_Tc2', '抄送董事会秘书', '抄送', 1, 0, 0, 1 from dual;

  insert into WF_Task_Define(EntGid, ModelGid, TaskDefGid, Code, Name, Note, OrderValue, IsStart, IsEnd, IsMCF)
  select v_EntGid, v_ModelGid, v_TaskGid_Tend, v_ModelCode || '_Tend', '流程终止', '结束一个流程', 1, 0, 1, 0 from dual;

--5、定义工作流程步骤执行人

  insert into WF_Task_Define_Exec(EntGid, ModelGid, TaskDefGid, ExecGidEx, ExecCodeEx, ExecNameEx, OwnerValue)
  select v_EntGid, v_ModelGid, v_TaskGid, '**FlowMember**', '**FlowMember**', '@流程参与人@', 1 from dual;

  insert into WF_Task_Define_Exec(EntGid, ModelGid, TaskDefGid, ExecGidEx, ExecCodeEx, ExecNameEx, OwnerValue)
  select v_EntGid, v_ModelGid, v_TaskGid, Gid, Code, Name, 1 from v_Usr where EntGid = v_EntGid and lower(Code) = lower('Admin_Grp');

  insert into WF_Task_Define_Exec(EntGid, ModelGid, TaskDefGid, ExecGidEx, ExecCodeEx, ExecNameEx, OwnerValue)
  select v_EntGid, v_ModelGid, v_TaskGid_T1, Gid, Code, Name, 1 from v_Usr where EntGid = v_EntGid and lower(Code) = lower('all_usr_grp');

  insert into WF_Task_Define_Exec(EntGid, ModelGid, TaskDefGid, ExecGidEx, ExecCodeEx, ExecNameEx, OwnerValue)
  select v_EntGid, v_ModelGid, v_TaskGid_T1, '**SpecGid**', '**SpecCode**', '@流程中指定@', 1 from dual;

  insert into WF_Task_Define_Exec(EntGid, ModelGid, TaskDefGid, ExecGidEx, ExecCodeEx, ExecNameEx, OwnerValue)
  select v_EntGid, v_ModelGid, v_TaskGid_T2, '**SpecGid**', '**SpecCode**', '@流程中指定@', 1 from dual;

  insert into WF_Task_Define_Exec(EntGid, ModelGid, TaskDefGid, ExecGidEx, ExecCodeEx, ExecNameEx, OwnerValue)
  select v_EntGid, v_ModelGid, v_TaskGid_Tcc, '**SpecGid**', '**SpecCode**', '@流程中指定@', 1 from dual;

--6、定义工作流程步骤走向

  insert into WF_Task_Define_Condition(EntGid, ModelGid, FromTaskDef, ToTaskDef)
  select v_EntGid, v_ModelGid, v_TaskGid_T1, v_TaskGid_T2 from dual;

  insert into WF_Task_Define_Condition(EntGid, ModelGid, FromTaskDef, ToTaskDef)
  select v_EntGid, v_ModelGid, v_TaskGid_T1, v_TaskGid_Tend from dual;

  insert into WF_Task_Define_Condition(EntGid, ModelGid, FromTaskDef, ToTaskDef)
  select v_EntGid, v_ModelGid, v_TaskGid_T2, v_TaskGid_Tend from dual;

  insert into WF_Task_Define_Condition(EntGid, ModelGid, FromTaskDef, ToTaskDef)
  select v_EntGid, v_ModelGid, v_TaskGid_T2, v_TaskGid_T1 from dual;

  insert into WF_Task_Define_Condition(EntGid, ModelGid, FromTaskDef, ToTaskDef)
  select v_EntGid, v_ModelGid, v_TaskGid_T1, v_TaskGid_Tcc from dual;

  insert into WF_Task_Define_Condition(EntGid, ModelGid, FromTaskDef, ToTaskDef)
  select v_EntGid, v_ModelGid, v_TaskGid_T1, v_TaskGid_Tc from dual;

  insert into WF_Task_Define_Condition(EntGid, ModelGid, FromTaskDef, ToTaskDef)
  select v_EntGid, v_ModelGid, v_TaskGid_T1, v_TaskGid_Tc1 from dual;

  insert into WF_Task_Define_Condition(EntGid, ModelGid, FromTaskDef, ToTaskDef)
  select v_EntGid, v_ModelGid, v_TaskGid_T1, v_TaskGid_Tc2 from dual;

--7、为管理员以及相关人员设置权限
--监视权限  　　 作废权限  　　 变更权限  　　 模型设置权限  
  insert into wf_rt (EntGid, ModelGid, UsrGidEX, RTID)
  select v_EntGid, v_ModelGid, gid, '1111' from org where EntGid = v_EntGid and lower(code) = lower('Admin_Grp');

end;
/

commit;

--版本号：2014年3月份;此行不允许删除			
drop table WF_PrlDZ_Stamp;			
create table WF_PrlDZ_Stamp (			
	EntGid 	varchar2(32)	not null,
	ModelGid	varchar2(32)	not null,
	FlowGid	varchar2(32)	not null,
	Num	varchar2(32)	null,
	CreateDate	date	default sysdate not null,
	LastUpdDate	date	default sysdate not null,
	--		
	Stat	varchar2(32)	null,
	--		
	FillUsrGid	varchar2(32)	null,
	FillUsrCode	varchar2(64)	null,
	FillUsrName	varchar2(64)	null,
	FillDeptGid	varchar2(32)	null,
	FillDeptCode	varchar2(64)	null,
	FillDeptName	varchar2(64)	null,
	--		
	EndMemo	varchar2(2000)	null,
	mIsFlow	varchar2(32)	null,
	mModelCode	varchar2(64)	null,
	mFlowGid	varchar2(32)	null,
	mNum	varchar2(64)	null,
	--		
	ApplyType	varchar2(16)	null,
	StampType	varchar2(512)	null,
	ComGid	varchar2(32)	null,
	ComName	varchar2(64)	null,
	--非合同类文件用印		
	FilerName	varchar2(64)	null,
	FileName	varchar2(128)	null,
	FileCount	varchar2(32)	null,
	FileAim	varchar2(128)	null,
	ApplyState	varchar2(32)	null,
	--合同类文件用印		
	ContractName	varchar2(256)	null,
	ContractCount	varchar2(32)	null,
	ContractFee	varchar2(64)	null,
	ContactName	varchar2(128)	null,
	ContractDate1	date	null,
	ContractDate2	date	null,
	ComtractMemo	varchar2(2000)	null,
	Memo	varchar2(2000)	null,
	constraint PK_WF_PrlDZ_Stamp primary key(EntGid, FlowGid),		
	CONSTRAINT UNQ_PrlDZ_Stamp UNIQUE(Num)		
	);		
create index idx_WF_PrlDZ_Stamp_1 on WF_PrlDZ_Stamp(FillUsrGid);			
			
drop table WF_PrlDZ_Stamp_Dtl;			
create table WF_PrlDZ_Stamp_Dtl (			
	EntGid 	varchar2(32)	not null,
	ModelGid	varchar2(32)	not null,
	FlowGid	varchar2(32)	not null,
	Gid	varchar2(32)	not null,
	--		
	ComGid	varchar2(32)	null,
	ComCode	varchar2(64)	null,
	ComName	varchar2(64)	null,
	constraint PK_WF_PrlDZ_Stamp_Dtl primary key(EntGid, FlowGid, Gid)		
	);		
			
drop table WF_PrlDZ_Stamp_App;			
create table WF_PrlDZ_Stamp_App (			
	EntGid 	varchar2(32)	not null,
	ModelGid	varchar2(32)	not null,
	FlowGid	varchar2(32)	not null,
	Gid	varchar2(32)	not null,
	--		
	AppGid	varchar2(32)	null,
	AppCode	varchar2(64)	null,
	AppName	varchar2(64)	null,
	AppDept	varchar2(64)	null,
	AppOrder	int	null,
	AppType	int	null,
	--		
	AppAssign	varchar2(64)	null,
	AppMemo	varchar2(4000)	null,
	AppDate	date	null,
	constraint PK_WF_PrlDZ_Stamp_App primary key(EntGid, FlowGid, Gid)		
	);		
			
			
drop table WF_PrlDZ_Stamp_Attach;			
create table WF_PrlDZ_Stamp_Attach (			
	EntGid 	varchar2(32)	not null,
	ModelGid	varchar2(32)	not null,
	FlowGid	varchar2(32)	not null,
	Gid	varchar2(32)	not null,
	--		
	AttachTitle	varchar2(256)	null,
	AttachUrl	varchar2(1024)	null,
	AttachSize	int	null,
	constraint PK_WF_PrlDZ_Stamp_Attach primary key(EntGid, FlowGid, Gid)		
	);		
			
drop table WF_PrlDZ_Stamp_Attach2;			
create table WF_PrlDZ_Stamp_Attach2 (			
	EntGid 	varchar2(32)	not null,
	ModelGid	varchar2(32)	not null,
	FlowGid	varchar2(32)	not null,
	Gid	varchar2(32)	not null,
	--		
	AttachTitle	varchar2(256)	null,
	AttachUrl	varchar2(1024)	null,
	AttachSize	int	null,
	constraint PK_WF_PrlDZ_Stamp_Attach2 primary key(EntGid, FlowGid, Gid)		
	);		

create or replace procedure P_PrlDZ_Stamp_doApp(p_EntGid    varchar2, --企业Gid
                                                p_ModelGid  varchar, --模型Gid
                                                p_FlowGid   varchar, --流程Gid
                                                p_AppAssign varchar2 --意见
                                                ) as
  v_Stage   varchar2(1024); -- 过程场景
  v_ErrText varchar2(1024); -- Oracle错误信息

  v_UsrGid      varchar2(32); --用户Gid
  v_ModelCode   varchar2(32); --模型代码
  v_DeptGid     varchar2(32); --当前用户部门
  v_PreDeptCode varchar2(32); --所属部门代码
  v_StampType   varchar2(128); --印章类型
  v_ApplyType   varchar2(128); --印章类型
  v_AppOrder    int;
begin
  commit;
  v_AppOrder := 0;
  v_Stage    := '取出流程信息';
  select f.FillUsrGid,
         f.FillDeptGid,
         substr(f.FillDeptCode, 0, 4),
         f.Stamptype,
         f.ApplyType
    into v_UsrGid, v_DeptGid, v_PreDeptCode, v_StampType, v_ApplyType
    from wf_PrlDZ_Stamp f
   where f.entgid = p_EntGid
     and f.flowgid = p_FlowGid;

  v_Stage := '取出模型信息';
  select m.code
    into v_ModelCode
    from wf_model m
   where m.Entgid = p_EntGid
     and m.modelgid = p_ModelGid;

  if p_AppAssign <> '终止' then
    --插入审批人
    v_AppOrder := v_AppOrder + 1;
    insert into wf_PrlDZ_Stamp_App
      (EntGid,
       ModelGid,
       FlowGid,
       Gid,
       AppGid,
       AppCode,
       AppName,
       AppOrder,
       AppType)
      select p_EntGid,
             p_ModelGid,
             p_FlowGid,
             sys_guid(),
             v.PostGid AppGid,
             v.PostCode AppCode,
             v.PostName AppName,
             v_AppOrder AppOrder,
             20 AppType
        from v_Post v
       where v.EntGid = p_EntGid
         and v.deptGid = v_DeptGid
         and v.atype = 10
         and rownum = 1;
    v_AppOrder := v_AppOrder + 1;
    insert into wf_PrlDZ_Stamp_App
      (EntGid,
       ModelGid,
       FlowGid,
       Gid,
       AppGid,
       AppCode,
       AppName,
       AppOrder,
       AppType)
      select p_EntGid,
             p_ModelGid,
             p_FlowGid,
             sys_guid(),
             v.PostGid AppGid,
             v.PostCode AppCode,
             v.PostName AppName,
             v_AppOrder AppOrder,
             23 AppType
        from v_Post v
       where v.EntGid = p_EntGid
         and v.deptGid = v_DeptGid
         and v.atype = 23
         and rownum = 1
         and v_ApplyType = '标准类合同用印';
  
    for C in (select f.*
                from wf_PrlDZ_Stamp_Dtl f
               where f.EntGid = p_EntGid
                 and f.FlowGid = p_FlowGid
               order by ComName) loop
      v_AppOrder := v_AppOrder + 1;
      insert into wf_PrlDZ_Stamp_App
        (EntGid,
         ModelGid,
         FlowGid,
         Gid,
         AppGid,
         AppCode,
         AppName,
         AppOrder,
         AppType)
        select p_EntGid,
               p_ModelGid,
               p_FlowGid,
               sys_guid(),
               v.PostGid AppGid,
               v.PostCode AppCode,
               v.PostName AppName,
               v_AppOrder AppOrder,
               25 AppType
          from v_Post v
         where v.EntGid = p_EntGid
           and v.deptGid = C.ComGid
           and v.atype = 30
           and rownum = 1;
    end loop;
    v_AppOrder := v_AppOrder + 1;
    insert into wf_PrlDZ_Stamp_App
      (EntGid,
       ModelGid,
       FlowGid,
       Gid,
       AppGid,
       AppCode,
       AppName,
       AppOrder,
       AppType)
      select p_EntGid,
             p_ModelGid,
             p_FlowGid,
             sys_guid(),
             v.PostGid AppGid,
             v.PostCode AppCode,
             v.PostName AppName,
             v_AppOrder AppOrder,
             30 AppType
        from v_Post v
       where v.EntGid = p_EntGid
         and v.deptGid = v_DeptGid
         and v.atype = 35
         and rownum = 1;
  
    v_AppOrder := v_AppOrder + 1;
    insert into wf_PrlDZ_Stamp_App
      (EntGid,
       ModelGid,
       FlowGid,
       Gid,
       AppGid,
       AppCode,
       AppName,
       AppOrder,
       AppType)
      select p_EntGid,
             p_ModelGid,
             p_FlowGid,
             sys_guid(),
             v.PostGid AppGid,
             v.PostCode AppCode,
             v.PostName AppName,
             v_AppOrder AppOrder,
             35 AppType
        from v_Post v
       where v.EntGid = p_EntGid
         and v.deptGid = v_DeptGid
         and v.atype = 40
         and rownum = 1;
  
    v_AppOrder := v_AppOrder + 1;
    insert into wf_PrlDZ_Stamp_App
      (EntGid,
       ModelGid,
       FlowGid,
       Gid,
       AppGid,
       AppCode,
       AppName,
       AppOrder,
       AppType)
      select p_EntGid,
             p_ModelGid,
             p_FlowGid,
             sys_guid(),
             v.PostGid AppGid,
             v.PostCode AppCode,
             v.PostName AppName,
             v_AppOrder AppOrder,
             37 AppType
        from v_Post v
       where v.EntGid = p_EntGid
         and v.deptGid = v_DeptGid
         and v.atype = 80
         and rownum = 1;
  
    if v_ApplyType <> '标准类合同用印' or v_PreDeptCode in ('0001', '0023') then
      for R in (select a.AppGid, a.AppCode, a.AppName, a.Line, a.StampType
                  from Prl_Stamp_App a, wf_PrlDZ_Stamp_Dtl d
                 where a.EntGid = p_EntGid
                   and a.EntGid = d.EntGid
                   and d.FlowGid = p_FlowGid
                   and v_StampType like '%' || StampType || '%'
                   and a.ComGid = d.ComGid
                 order by d.ComName,
                          decode(a.StampType,
                                 '财务印章',
                                 50,
                                 '公司公章',
                                 60,
                                 '法定代表人名章',
                                 70,
                                 '公司股东章',
                                 80,
                                 '合同章',
                                 90),
                          a.Line) loop
        v_AppOrder := v_AppOrder + 1;
        insert into wf_PrlDZ_Stamp_App
          (EntGid,
           ModelGid,
           FlowGid,
           Gid,
           AppGid,
           AppCode,
           AppName,
           AppOrder,
           AppType)
          select p_EntGid,
                 p_ModelGid,
                 p_FlowGid,
                 sys_guid(),
                 R.AppGid,
                 R.AppCode,
                 R.AppName,
                 v_AppOrder,
                 decode(R.StampType,
                        '财务印章',
                        50,
                        '公司公章',
                        60,
                        '法定代表人名章',
                        70,
                        '公司股东章',
                        80,
                        '合同章',
                        90)
            from dual;
        commit;
      end loop;
    end if;
  
    /*for R in (select distinct s.AppGid, s.AppCode, s.Appname
                from PrlDZ_Stamp s, WF_PrlDZ_Stamp f
               where f.EntGid = p_EntGid
                 and f.FlowGid = p_FlowGid
                 and s.ComGid = f.ComGid
                 and f.StampType like '%' || s.StampType || '%'
               order by s.appcode) loop
      select max(AppOrder)
        into v_Count
        from wf_PrlDZ_Stamp_App t
       where t.entgid = p_EntGid
         and t.Flowgid = p_FlowGid
         and t.apporder < 100;
      insert into wf_PrlDZ_Stamp_App
        (EntGid,
         ModelGid,
         FlowGid,
         Gid,
         AppGid,
         AppCode,
         AppName,
         AppOrder,
         AppType)
        select p_EntGid,
               p_ModelGid,
               p_FlowGid,
               sys_guid(),
               R.AppGid,
               R.AppCode,
               R.AppName,
               v_Count + 1,
               98
          from dual;
    
      commit;
    end loop;*/
  
    --取出审批人中重复的审批人
    delete from wf_PrlDZ_Stamp_App f
     where f.EntGid = p_EntGid
       and f.FlowGid = p_FlowGid
       and f.Apporder > 0
       and f.Appdate is null
       and not exists (select 1
              from (select min(t.apporder) apporder,
                           t.EntGid,
                           t.FlowGid,
                           t.AppGid
                      from wf_PrlDZ_Stamp_App t
                     where t.EntGid = p_EntGid
                       and t.FlowGid = p_FlowGid
                       and t.AppOrder < 100
                       and t.AppDate is null
                     group by t.EntGid, t.FlowGid, t.AppGid) a
             where f.EntGid = a.EntGid
               and f.FlowGid = a.FlowGid
               and f.apporder = a.apporder);
    v_Stage := '插入审批人';
    if p_AppAssign = '提交' then
      insert into WF_Task
        (EntGid,
         ModelGid,
         FlowGid,
         TaskDefGid,
         TaskGid,
         Stat,
         Code,
         Name,
         Note,
         ExecGid,
         ExecCode,
         ExecName,
         OrderValue,
         IsMCF)
        select p_EntGid,
               p_ModelGid,
               p_FlowGid,
               d.TaskDefGid,
               sys_guid(),
               1,
               d.code,
               d.name,
               d.note,
               a.AppGid,
               a.AppCode,
               a.AppName,
               d.OrderValue,
               d.IsMCF
          from WF_Task_Define d,
               (select *
                  from (select *
                          from wf_PrlDZ_Stamp_App t
                         where t.entgid = p_EntGid
                           and t.flowgid = p_FlowGid
                           and t.AppOrder <= 100
                           and t.AppDate is null
                         order by t.Apporder)
                 where rownum = 1) a
         where d.EntGid = p_EntGid
           and d.ModelGid = p_ModelGid
           and replace(lower(d.code), lower(v_ModelCode), '') in ('_t2')
           and not exists (select 1
                  from wf_task t
                 where t.entgid = p_EntGid
                   and t.flowgid = p_FlowGid
                   and t.TaskDefGid = d.taskdefgid
                   and t.ExecGid = a.AppGid
                   and t.stat = 1);
    end if;
  end if;
  commit;
  --异常处理
exception
  when others then
    begin
      rollback;
      v_ErrText := substr('流程Gid:' || p_FlowGid || ';用户Gid:' || v_UsrGid || ';' ||
                          v_Stage || ' 失败!' || SQLCode || ':' || SQLERRM,
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
         where e.gid = p_EntGid;
      commit;
    end;
end;
/
create or replace procedure P_PrlDZ_Stamp_doApp2(p_EntGid    varchar2, --企业Gid
                                                 p_ModelGid  varchar, --模型Gid
                                                 p_FlowGid   varchar, --流程Gid
                                                 p_AppAssign varchar2, --意见
                                                 p_AppMemo   varchar2 --意见
                                                 ) as
  v_Stage   varchar2(1024); -- 过程场景
  v_ErrText varchar2(1024); -- Oracle错误信息

  v_UsrGid      varchar2(32); --用户Gid
  v_ModelCode   varchar2(32); --模型代码
  v_DeptGid     varchar2(32); --当前用户部门
  v_PreDeptCode varchar2(32); --所属部门代码
  v_StampType   varchar2(128); --印章类型
  v_ApplyType   varchar2(128); --印章类型
  v_Count       int;
begin
  commit;
  v_Stage := '取出流程信息';
  select f.FillUsrGid,
         f.FillDeptGid,
         substr(f.FillDeptCode, 0, 4),
         f.Stamptype,
         f.ApplyType
    into v_UsrGid, v_DeptGid, v_PreDeptCode, v_StampType, v_ApplyType
    from wf_PrlDZ_Stamp f
   where f.entgid = p_EntGid
     and f.flowgid = p_FlowGid;

  v_Stage := '取出模型信息';
  select m.code
    into v_ModelCode
    from wf_model m
   where m.Entgid = p_EntGid
     and m.modelgid = p_ModelGid;

  if p_AppAssign = '提交' then
    for R in (select distinct s.AppGid, s.AppCode, s.Appname
                from Prl_Stamp s, WF_PrlDZ_Stamp f, WF_PrlDZ_Stamp_Dtl d
               where f.EntGid = p_EntGid
                 and f.FlowGid = p_FlowGid
                 and d.FlowGid = p_FlowGid
                 and s.ComGid = d.ComGid
                 and f.StampType like '%' || s.StampType || '%'
               order by f.ComName, s.appcode) loop
      select max(AppOrder)
        into v_Count
        from wf_PrlDZ_Stamp_App t
       where t.entgid = p_EntGid
         and t.Flowgid = p_FlowGid
         and t.apporder < 100;
      insert into wf_PrlDZ_Stamp_App
        (EntGid,
         ModelGid,
         FlowGid,
         Gid,
         AppGid,
         AppCode,
         AppName,
         AppOrder,
         AppType)
        select p_EntGid,
               p_ModelGid,
               p_FlowGid,
               sys_guid(),
               R.AppGid,
               R.AppCode,
               R.AppName,
               v_Count + 1,
               98
          from dual;
      commit;
    end loop;
  
    --取出审批人中重复的审批人
    delete from wf_PrlDZ_Stamp_App f
     where f.EntGid = p_EntGid
       and f.FlowGid = p_FlowGid
       and f.Apporder > 0
       and f.Appdate is null
       and not exists (select 1
              from (select min(t.apporder) apporder,
                           t.EntGid,
                           t.FlowGid,
                           t.AppGid
                      from wf_PrlDZ_Stamp_App t
                     where t.EntGid = p_EntGid
                       and t.FlowGid = p_FlowGid
                       and t.AppOrder < 100
                       and t.AppDate is null
                     group by t.EntGid, t.FlowGid, t.AppGid) a
             where f.EntGid = a.EntGid
               and f.FlowGid = a.FlowGid
               and f.apporder = a.apporder);
    commit;
    v_Stage := '插入审批人';
    insert into WF_Task
      (EntGid,
       ModelGid,
       FlowGid,
       TaskDefGid,
       TaskGid,
       Stat,
       Code,
       Name,
       Memo,
       Note,
       ExecGid,
       ExecCode,
       ExecName,
       OrderValue,
       IsMCF)
      select p_EntGid,
             p_ModelGid,
             p_FlowGid,
             d.TaskDefGid,
             sys_guid(),
             1,
             d.code,
             d.name,
             p_AppMemo,
             d.note,
             a.AppGid,
             a.AppCode,
             a.AppName,
             d.OrderValue,
             d.IsMCF
        from WF_Task_Define d,
             (select *
                from (select *
                        from wf_PrlDZ_Stamp_App t
                       where t.entgid = p_EntGid
                         and t.flowgid = p_FlowGid
                         and t.AppOrder <= 100
                         and t.AppDate is null
                       order by t.Apporder)
               where rownum = 1) a
       where d.EntGid = p_EntGid
         and d.ModelGid = p_ModelGid
         and replace(lower(d.code), lower(v_ModelCode), '') in ('_t2')
         and not exists (select 1
                from wf_task t
               where t.entgid = p_EntGid
                 and t.flowgid = p_FlowGid
                 and t.TaskDefGid = d.taskdefgid
                 and t.ExecGid = a.AppGid
                 and t.stat = 1);
  end if;
  commit;
  --异常处理
exception
  when others then
    begin
      rollback;
      v_ErrText := substr('流程Gid:' || p_FlowGid || ';用户Gid:' || v_UsrGid || ';' ||
                          v_Stage || ' 失败!' || SQLCode || ':' || SQLERRM,
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
         where e.gid = p_EntGid;
      commit;
    end;
end;
/
create or replace procedure P_PrlDZ_Stamp_doMail(p_FlowGid varchar --流程Gid
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
              from wf_PrlDZ_Stamp f, wf_model wm
             where f.EntGid = v_EntGid
               and f.entgid = wm.entgid
               and f.FlowGid = p_FlowGid
               and f.modelgid = wm.modelgid) loop
    v_Stage   := 'FlowGid：' || R.Flowgid || '；模型：' || R.ModelName;
    v_Title   := '用印待审提醒:' || R.FILLDEPTNAME;
    v_Content := v_Content || v_Head;
  
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
    v_Body    := '[申请类型] : ' || R.ApplyType;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[申请印章种类] : ' || R.StampType;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[公司名称] : ';
  
    for C in (select f.*
                from wf_PrlDZ_Stamp_Dtl f
               where f.EntGid = v_EntGid
                 and f.FlowGid = p_FlowGid
               order by ComName) loop
      v_Body := v_Body || C.ComName || ';';
    end loop;
  
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
    for U in (select distinct hr.Email
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

create or replace procedure P_PrlDZ_Stamp_doApp2(p_EntGid    varchar2, --企业Gid
                                                 p_ModelGid  varchar, --模型Gid
                                                 p_FlowGid   varchar, --流程Gid
                                                 p_AppAssign varchar2, --意见
                                                 p_AppMemo   varchar2 --意见
                                                 ) as
  v_Stage   varchar2(1024); -- 过程场景
  v_ErrText varchar2(1024); -- Oracle错误信息

  v_UsrGid      varchar2(32); --用户Gid
  v_ModelCode   varchar2(32); --模型代码
  v_DeptGid     varchar2(32); --当前用户部门
  v_PreDeptCode varchar2(32); --所属部门代码
  v_StampType   varchar2(128); --印章类型
  v_ApplyType   varchar2(128); --印章类型
  v_Count       int;
begin
  v_Stage := '取出流程信息';
  select f.FillUsrGid,
         f.FillDeptGid,
         substr(f.FillDeptCode, 0, 4),
         f.Stamptype,
         f.ApplyType
    into v_UsrGid, v_DeptGid, v_PreDeptCode, v_StampType, v_ApplyType
    from wf_PrlDZ_Stamp f
   where f.entgid = p_EntGid
     and f.flowgid = p_FlowGid;

  v_Stage := '取出模型信息';
  select m.code
    into v_ModelCode
    from wf_model m
   where m.Entgid = p_EntGid
     and m.modelgid = p_ModelGid;

  if p_AppAssign = '提交' then
    for R in (select distinct s.AppGid, s.AppCode, s.Appname
                from Prl_Stamp s, WF_PrlDZ_Stamp f, WF_PrlDZ_Stamp_Dtl d
               where f.EntGid = p_EntGid
                 and f.FlowGid = p_FlowGid
                 and d.FlowGid = p_FlowGid
                 and s.ComGid = d.ComGid
                 and f.StampType like '%' || s.StampType || '%'
               order by f.ComName, s.appcode) loop
      select max(AppOrder)
        into v_Count
        from wf_PrlDZ_Stamp_App t
       where t.entgid = p_EntGid
         and t.Flowgid = p_FlowGid
         and t.apporder < 100;
      insert into wf_PrlDZ_Stamp_App
        (EntGid,
         ModelGid,
         FlowGid,
         Gid,
         AppGid,
         AppCode,
         AppName,
         AppOrder,
         AppType)
        select p_EntGid,
               p_ModelGid,
               p_FlowGid,
               sys_guid(),
               R.AppGid,
               R.AppCode,
               R.AppName,
               v_Count + 1,
               98
          from dual;
    end loop;
  
    --取出审批人中重复的审批人
    delete from wf_PrlDZ_Stamp_App f
     where f.EntGid = p_EntGid
       and f.FlowGid = p_FlowGid
       and f.Apporder > 0
       and f.Appdate is null
       and not exists (select 1
              from (select min(t.apporder) apporder,
                           t.EntGid,
                           t.FlowGid,
                           t.AppGid
                      from wf_PrlDZ_Stamp_App t
                     where t.EntGid = p_EntGid
                       and t.FlowGid = p_FlowGid
                       and t.AppOrder < 100
                       and t.AppDate is null
                     group by t.EntGid, t.FlowGid, t.AppGid) a
             where f.EntGid = a.EntGid
               and f.FlowGid = a.FlowGid
               and f.apporder = a.apporder);
    v_Stage := '插入审批人';
    insert into WF_Task
      (EntGid,
       ModelGid,
       FlowGid,
       TaskDefGid,
       TaskGid,
       Stat,
       Code,
       Name,
       Memo,
       Note,
       ExecGid,
       ExecCode,
       ExecName,
       OrderValue,
       IsMCF)
      select p_EntGid,
             p_ModelGid,
             p_FlowGid,
             d.TaskDefGid,
             sys_guid(),
             1,
             d.code,
             d.name,
             p_AppMemo,
             d.note,
             a.AppGid,
             a.AppCode,
             a.AppName,
             d.OrderValue,
             d.IsMCF
        from WF_Task_Define d,
             (select *
                from (select *
                        from wf_PrlDZ_Stamp_App t
                       where t.entgid = p_EntGid
                         and t.flowgid = p_FlowGid
                         and t.AppOrder <= 100
                         and t.AppDate is null
                       order by t.Apporder)
               where rownum = 1) a
       where d.EntGid = p_EntGid
         and d.ModelGid = p_ModelGid
         and replace(lower(d.code), lower(v_ModelCode), '') in ('_t2')
         and not exists (select 1
                from wf_task t
               where t.entgid = p_EntGid
                 and t.flowgid = p_FlowGid
                 and t.TaskDefGid = d.taskdefgid
                 and t.ExecGid = a.AppGid
                 and t.stat = 1);
  end if;
  --异常处理
exception
  when others then
    begin
      rollback;
      v_ErrText := substr('流程Gid:' || p_FlowGid || ';用户Gid:' || v_UsrGid || ';' ||
                          v_Stage || ' 失败!' || SQLCode || ':' || SQLERRM,
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
         where e.gid = p_EntGid;
      commit;
    end;
end;
/

create or replace procedure P_Prl_Stamp_doApp2(p_EntGid    varchar2, --企业Gid
                                               p_ModelGid  varchar, --模型Gid
                                               p_FlowGid   varchar, --流程Gid
                                               p_AppAssign varchar2, --意见
                                               p_AppMemo varchar2 --意见
                                               ) as
  v_Stage   varchar2(1024); -- 过程场景
  v_ErrText varchar2(1024); -- Oracle错误信息

  v_UsrGid      varchar2(32); --用户Gid
  v_ModelCode   varchar2(32); --模型代码
  v_DeptGid     varchar2(32); --当前用户部门
  v_PreDeptCode varchar2(32); --所属部门代码
  v_ComGid      varchar2(32); --项目Gid
  v_StampType   varchar2(128); --印章类型
  v_ApplyType   varchar2(128); --印章类型
  v_Count       int;
begin
  v_Stage := '取出流程信息';
  select f.FillUsrGid,
         f.FillDeptGid,
         substr(f.FillDeptCode, 0, 4),
         f.Stamptype,
         f.ApplyType,
         f.Comgid
    into v_UsrGid,
         v_DeptGid,
         v_PreDeptCode,
         v_StampType,
         v_ApplyType,
         v_ComGid
    from wf_prl_Stamp f
   where f.entgid = p_EntGid
     and f.flowgid = p_FlowGid;

  v_Stage := '取出模型信息';
  select m.code
    into v_ModelCode
    from wf_model m
   where m.Entgid = p_EntGid
     and m.modelgid = p_ModelGid;

  if p_AppAssign = '提交' then
    for R in (select distinct s.AppGid, s.AppCode, s.Appname
                from Prl_Stamp s, WF_Prl_Stamp f
               where f.EntGid = p_EntGid
                 and f.FlowGid = p_FlowGid
                 and s.ComGid = f.ComGid
                 and f.StampType like '%' || s.StampType || '%'
               order by s.appcode) loop
      select max(AppOrder)
        into v_Count
        from wf_Prl_Stamp_App t
       where t.entgid = p_EntGid
         and t.Flowgid = p_FlowGid
         and t.apporder < 100;
      insert into wf_Prl_Stamp_App
        (EntGid,
         ModelGid,
         FlowGid,
         Gid,
         AppGid,
         AppCode,
         AppName,
         AppOrder,
         AppType)
        select p_EntGid,
               p_ModelGid,
               p_FlowGid,
               sys_guid(),
               R.AppGid,
               R.AppCode,
               R.AppName,
               v_Count + 1,
               98
          from dual;
    end loop;
  
    --取出审批人中重复的审批人
    delete from wf_Prl_Stamp_App f
     where f.EntGid = p_EntGid
       and f.FlowGid = p_FlowGid
       and f.Apporder > 0
       and f.Appdate is null
       and not exists (select 1
              from (select min(t.apporder) apporder,
                           t.EntGid,
                           t.FlowGid,
                           t.AppGid
                      from wf_Prl_Stamp_App t
                     where t.EntGid = p_EntGid
                       and t.FlowGid = p_FlowGid
                       and t.AppOrder < 100
                       and t.AppDate is null
                     group by t.EntGid, t.FlowGid, t.AppGid) a
             where f.EntGid = a.EntGid
               and f.FlowGid = a.FlowGid
               and f.apporder = a.apporder);
    v_Stage := '插入审批人';
    insert into WF_Task
      (EntGid,
       ModelGid,
       FlowGid,
       TaskDefGid,
       TaskGid,
       Stat,
       Code,
       Name,
       Memo,
       Note,
       ExecGid,
       ExecCode,
       ExecName,
       OrderValue,
       IsMCF)
      select p_EntGid,
             p_ModelGid,
             p_FlowGid,
             d.TaskDefGid,
             sys_guid(),
             1,
             d.code,
             d.name,
             p_AppMemo,
             d.note,
             a.AppGid,
             a.AppCode,
             a.AppName,
             d.OrderValue,
             d.IsMCF
        from WF_Task_Define d,
             (select *
                from (select *
                        from wf_Prl_Stamp_App t
                       where t.entgid = p_EntGid
                         and t.flowgid = p_FlowGid
                         and t.AppOrder <= 100
                         and t.AppDate is null
                       order by t.Apporder)
               where rownum = 1) a
       where d.EntGid = p_EntGid
         and d.ModelGid = p_ModelGid
         and replace(lower(d.code), lower(v_ModelCode), '') in ('_t2')
         and not exists (select 1
                from wf_task t
               where t.entgid = p_EntGid
                 and t.flowgid = p_FlowGid
                 and t.TaskDefGid = d.taskdefgid
                 and t.ExecGid = a.AppGid
                 and t.stat = 1);
  end if;
  --异常处理
exception
  when others then
    begin
      rollback;
      v_ErrText := substr('流程Gid:' || p_FlowGid || ';用户Gid:' || v_UsrGid || ';' ||
                          v_Stage || ' 失败!' || SQLCode || ':' || SQLERRM,
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
         where e.gid = p_EntGid;
      commit;
    end;
end;
/
--工作流程执行脚本模板：201403版（此行不允许删除）
--1、定义流程用到的参数名称
declare
  v_EntGid varchar2(32);         --企业Gid
  v_ModelGid varchar2(32);       --工作流程模型Gid
  v_ModelCode varchar2(32);      --工作流程模型代码
  v_TaskGid varchar2(32);
  v_TaskGid_T1 varchar2(32);     --开始步骤
  v_TaskGid_T2 varchar2(32);
  v_TaskGid_T3 varchar2(32);
  v_TaskGid_Tcc varchar2(32);
  v_TaskGid_Tc varchar2(32);
  v_TaskGid_Tc2 varchar2(32);
  v_TaskGid_Tc3 varchar2(32);
  v_TaskGid_Tend varchar2(32);   --结束步骤
  v_Count int;
BEGIN
--2、初始化赋值
  v_TaskGid := sys_guid();
  v_TaskGid_T1 := sys_guid();
  v_TaskGid_T2 := sys_guid();
  v_TaskGid_T3 := sys_guid();
  v_TaskGid_Tcc := sys_guid();
  v_TaskGid_Tc := sys_guid();
  v_TaskGid_Tc2 := sys_guid();
  v_TaskGid_Tc3 := sys_guid();
  v_TaskGid_Tend := sys_guid();

  --获取企业Gid
  select Gid into v_EntGid from Ent where Lower(code) = lower('prlintra');--修改企业Code

  --定义模型代码
  v_ModelCode := 'PrlDZ_Stamp';

  --取出当前模型代码对应模型的数量
  select count(*) into v_Count from wf_model where lower(Code) = lower(v_ModelCode) and EntGid = v_EntGid;
  
  --获取模型Gid
  if v_Count = 0 then
    v_ModelGid := sys_guid();
  else
    select ModelGid into v_ModelGid from wf_model where lower(Code) = lower(v_ModelCode) and EntGid = v_EntGid;
  end if;

--3、删除旧有数据信息
  delete from WF_Model where EntGid = v_EntGid and ModelGid = v_ModelGid;
  delete from WF_Task_Define where EntGid = v_EntGid and ModelGid = v_ModelGid;
  delete from WF_Task_Define_Exec where EntGid = v_EntGid and ModelGid = v_ModelGid;
  delete from WF_Task_Define_Condition where EntGid = v_EntGid and ModelGid = v_ModelGid;
  delete from WF_rt where EntGid = v_EntGid and ModelGid = v_ModelGid;
  --delete from WF_Flow where EntGid = v_EntGid and ModelGid = v_ModelGid;
  --delete from WF_Task where EntGid = v_EntGid and ModelGid = v_ModelGid;
  --delete from WF_Task_History where EntGid = v_EntGid and ModelGid = v_ModelGid;

--4、定义工作流程名称 ，步骤等
  insert into WF_Model(EntGid, ModelGid, Code, Name, STAT, CLASSIFY, VERSION, AP1, AP2)
  select v_EntGid, v_ModelGid, v_ModelCode, '多项目用印申请流程', 3, '项目审批流程-行政相关', '1.0', 0, 0 from dual;

  /*
  insert into WF_Task_Define(EntGid, ModelGid, TaskDefGid, Code, Name, Note, OrderValue, IsStart, IsEnd, IsMCF)
  select v_EntGid, v_ModelGid, v_TaskGid, v_ModelCode, '明细', '用于判断查看权限', 1, 0, 0, 0 from dual;
  */

  insert into WF_Task_Define(EntGid, ModelGid, TaskDefGid, Code, Name, Note, OrderValue, IsStart, IsEnd, IsMCF)
  select v_EntGid, v_ModelGid, v_TaskGid_T1, v_ModelCode || '_T1', '发起人填写申请单', '填写/修改', 1, 1, 0, 0 from dual;

  insert into WF_Task_Define(EntGid, ModelGid, TaskDefGid, Code, Name, Note, OrderValue, IsStart, IsEnd, IsMCF)
  select v_EntGid, v_ModelGid, v_TaskGid_T2, v_ModelCode || '_T2', '请审批','审批', 1, 0, 0, 0 from dual;

  insert into WF_Task_Define(EntGid, ModelGid, TaskDefGid, Code, Name, Note, OrderValue, IsStart, IsEnd, IsMCF)
  select v_EntGid, v_ModelGid, v_TaskGid_Tcc, v_ModelCode||'_Tcc', '抄送人印章管理人', '抄送', 1, 0, 0, 1 from dual;

  insert into WF_Task_Define(EntGid, ModelGid, TaskDefGid, Code, Name, Note, OrderValue, IsStart, IsEnd, IsMCF)
  select v_EntGid, v_ModelGid, v_TaskGid_Tc, v_ModelCode||'_Tc', '抄送项目副总监', '抄送', 1, 0, 0, 1 from dual;

  insert into WF_Task_Define(EntGid, ModelGid, TaskDefGid, Code, Name, Note, OrderValue, IsStart, IsEnd, IsMCF)
  select v_EntGid, v_ModelGid, v_TaskGid_Tc2, v_ModelCode||'_Tc2', '抄送财务总监', '抄送', 1, 0, 0, 1 from dual;

  insert into WF_Task_Define(EntGid, ModelGid, TaskDefGid, Code, Name, Note, OrderValue, IsStart, IsEnd, IsMCF)
  select v_EntGid, v_ModelGid, v_TaskGid_Tc3, v_ModelCode||'_Tc3', '抄送董事会秘书', '抄送', 1, 0, 0, 1 from dual;

  insert into WF_Task_Define(EntGid, ModelGid, TaskDefGid, Code, Name, Note, OrderValue, IsStart, IsEnd, IsMCF)
  select v_EntGid, v_ModelGid, v_TaskGid_T3, v_ModelCode || '_T3', '发起人确认','确认', 1, 0, 0, 0 from dual;

  insert into WF_Task_Define(EntGid, ModelGid, TaskDefGid, Code, Name, Note, OrderValue, IsStart, IsEnd, IsMCF)
  select v_EntGid, v_ModelGid, v_TaskGid_Tend, v_ModelCode || '_Tend', '流程终止', '结束一个流程', 1, 0, 1, 0 from dual;

--5、定义工作流程步骤执行人

  insert into WF_Task_Define_Exec(EntGid, ModelGid, TaskDefGid, ExecGidEx, ExecCodeEx, ExecNameEx, OwnerValue)
  select v_EntGid, v_ModelGid, v_TaskGid, '**FlowMember**', '**FlowMember**', '@流程参与人@', 1 from dual;

  insert into WF_Task_Define_Exec(EntGid, ModelGid, TaskDefGid, ExecGidEx, ExecCodeEx, ExecNameEx, OwnerValue)
  select v_EntGid, v_ModelGid, v_TaskGid, Gid, Code, Name, 1 from v_Usr where EntGid = v_EntGid and lower(Code) = lower('Admin_Grp');

  insert into WF_Task_Define_Exec(EntGid, ModelGid, TaskDefGid, ExecGidEx, ExecCodeEx, ExecNameEx, OwnerValue)
  select v_EntGid, v_ModelGid, v_TaskGid_T1, Gid, Code, Name, 1 from v_Usr where EntGid = v_EntGid and lower(Code) = lower('all_usr_grp');

  insert into WF_Task_Define_Exec(EntGid, ModelGid, TaskDefGid, ExecGidEx, ExecCodeEx, ExecNameEx, OwnerValue)
  select v_EntGid, v_ModelGid, v_TaskGid_T1, '**SpecGid**', '**SpecCode**', '@流程中指定@', 1 from dual;

  insert into WF_Task_Define_Exec(EntGid, ModelGid, TaskDefGid, ExecGidEx, ExecCodeEx, ExecNameEx, OwnerValue)
  select v_EntGid, v_ModelGid, v_TaskGid_T2, '**SpecGid**', '**SpecCode**', '@流程中指定@', 1 from dual;

  insert into WF_Task_Define_Exec(EntGid, ModelGid, TaskDefGid, ExecGidEx, ExecCodeEx, ExecNameEx, OwnerValue)
  select v_EntGid, v_ModelGid, v_TaskGid_Tcc, '**SpecGid**', '**SpecCode**', '@流程中指定@', 1 from dual;

  insert into WF_Task_Define_Exec(EntGid, ModelGid, TaskDefGid, ExecGidEx, ExecCodeEx, ExecNameEx, OwnerValue)
  select v_EntGid, v_ModelGid, v_TaskGid_Tc, '**SpecGid**', '**SpecCode**', '@流程中指定@', 1 from dual;

  insert into WF_Task_Define_Exec(EntGid, ModelGid, TaskDefGid, ExecGidEx, ExecCodeEx, ExecNameEx, OwnerValue)
  select v_EntGid, v_ModelGid, v_TaskGid_Tc2, Gid, Code, Name, 1 from v_Usr where EntGid = v_EntGid and lower(Code) = lower('ching.siewlin');

  insert into WF_Task_Define_Exec(EntGid, ModelGid, TaskDefGid, ExecGidEx, ExecCodeEx, ExecNameEx, OwnerValue)
  select v_EntGid, v_ModelGid, v_TaskGid_Tc3, Gid, Code, Name, 1 from v_Usr where EntGid = v_EntGid and lower(Code) = lower('taliyah.shang');

  insert into WF_Task_Define_Exec(EntGid, ModelGid, TaskDefGid, ExecGidEx, ExecCodeEx, ExecNameEx, OwnerValue)
  select v_EntGid, v_ModelGid, v_TaskGid_T3, '**CreateGid**', '**CreateCode**', '@发起人@', 1 from dual;

--6、定义工作流程步骤走向

  insert into WF_Task_Define_Condition(EntGid, ModelGid, FromTaskDef, ToTaskDef)
  select v_EntGid, v_ModelGid, v_TaskGid_T1, v_TaskGid_T2 from dual;

  insert into WF_Task_Define_Condition(EntGid, ModelGid, FromTaskDef, ToTaskDef)
  select v_EntGid, v_ModelGid, v_TaskGid_T1, v_TaskGid_Tend from dual;

  insert into WF_Task_Define_Condition(EntGid, ModelGid, FromTaskDef, ToTaskDef)
  select v_EntGid, v_ModelGid, v_TaskGid_T2, v_TaskGid_T1 from dual;

  insert into WF_Task_Define_Condition(EntGid, ModelGid, FromTaskDef, ToTaskDef)
  select v_EntGid, v_ModelGid, v_TaskGid_T2, v_TaskGid_T3 from dual;

  insert into WF_Task_Define_Condition(EntGid, ModelGid, FromTaskDef, ToTaskDef)
  select v_EntGid, v_ModelGid, v_TaskGid_T1, v_TaskGid_Tcc from dual;

  insert into WF_Task_Define_Condition(EntGid, ModelGid, FromTaskDef, ToTaskDef)
  select v_EntGid, v_ModelGid, v_TaskGid_T1, v_TaskGid_Tc from dual;

  insert into WF_Task_Define_Condition(EntGid, ModelGid, FromTaskDef, ToTaskDef)
  select v_EntGid, v_ModelGid, v_TaskGid_T1, v_TaskGid_Tc2 from dual;

  insert into WF_Task_Define_Condition(EntGid, ModelGid, FromTaskDef, ToTaskDef)
  select v_EntGid, v_ModelGid, v_TaskGid_T1, v_TaskGid_Tc3 from dual;

  insert into WF_Task_Define_Condition(EntGid, ModelGid, FromTaskDef, ToTaskDef)
  select v_EntGid, v_ModelGid, v_TaskGid_T3, v_TaskGid_Tend from dual;

--7、为管理员以及相关人员设置权限
--监视权限  　　 作废权限  　　 变更权限  　　 模型设置权限  
  insert into wf_rt (EntGid, ModelGid, UsrGidEX, RTID)
  select v_EntGid, v_ModelGid, gid, '1111' from org where EntGid = v_EntGid and lower(code) = lower('Admin_Grp');

end;
/

commit;