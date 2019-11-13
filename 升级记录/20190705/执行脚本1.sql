---权限执行脚本
declare
  v_EntGid  varchar2(32);
begin
select Gid into v_EntGid from Ent where Lower(code) = Lower('prlintra'); 
--新增模块权限
delete from rt where id in ('prl_lcfeedtl','prl_lcfeedtldown','prl_ogroundlist','prl_ogroundlistdown','prl_ogrounddtl','prl_ogrounddtldown');

insert into rt(id,name,atype,alevel,url,aorder,memo) values('prl_lcfeedtl','已使用费用列表','DOA管理','30','/bin/hdnet.dll/__explainmodule?url=prl_lcfeedtl','800442','已使用费用列表');
insert into rt(id,name,atype,alevel,url,aorder,memo) values('prl_lcfeedtldown','已使用费用列表','DOA管理','30','/bin/hdnet.dll/__explainmodule?url=prl_lcfeedtldown','800443','已使用费用列表');
insert into rt(id,name,atype,alevel,url,aorder,memo) values('prl_ogroundlist','楼层出租面积动态统计','DOA管理','30','/bin/hdnet.dll/__explainmodule?url=prl_ogroundlist','800444','楼层出租面积动态统计');
insert into rt(id,name,atype,alevel,url,aorder,memo) values('prl_ogroundlistdown','楼层出租面积动态统计','DOA管理','30','/bin/hdnet.dll/__explainmodule?url=prl_ogroundlistdown','800445','楼层出租面积动态统计');
insert into rt(id,name,atype,alevel,url,aorder,memo) values('prl_ogrounddtl','楼层出租面积动态明细','DOA管理','30','/bin/hdnet.dll/__explainmodule?url=prl_ogrounddtl','800446','楼层出租面积动态明细');
insert into rt(id,name,atype,alevel,url,aorder,memo) values('prl_ogrounddtldown','楼层出租面积动态明细','DOA管理','30','/bin/hdnet.dll/__explainmodule?url=prl_ogrounddtldown','800447','楼层出租面积动态明细');

--将权限默认给管理员组
--插入企业权限
delete from ent_rt where entgid = v_EntGid and rtid in ('prl_lcfeedtl','prl_lcfeedtldown','prl_ogroundlist','prl_ogroundlistdown','prl_ogrounddtl','prl_ogrounddtldown');
insert into ent_rt select v_EntGid , id from rt where id in ('prl_lcfeedtl','prl_lcfeedtldown','prl_ogroundlist','prl_ogroundlistdown','prl_ogrounddtl','prl_ogrounddtldown');

--插入管理员权限
delete from org_rt where entgid = v_EntGid and rtid in ('prl_lcfeedtl','prl_lcfeedtldown','prl_ogroundlist','prl_ogroundlistdown','prl_ogrounddtl','prl_ogrounddtldown');
insert into org_rt select v_EntGid ,org.gid , rt.id,'10' from org, rt where org.entgid = v_EntGid and lower(org.code) = lower('admin_grp') and rt.id in ('prl_lcfeedtl','prl_lcfeedtldown','prl_ogroundlist','prl_ogroundlistdown','prl_ogrounddtl','prl_ogrounddtldown');

--插入组织所有权限表
delete from org_rt_all where entgid = v_EntGid and rtid in ('prl_lcfeedtl','prl_lcfeedtldown','prl_ogroundlist','prl_ogroundlistdown','prl_ogrounddtl','prl_ogrounddtldown');
insert into org_rt_all select v_EntGid ,org.gid , rt.id,'10' from org, rt where org.entgid = v_EntGid and lower(org.code) = lower('admin_grp') and rt.id in ('prl_lcfeedtl','prl_lcfeedtldown','prl_ogroundlist','prl_ogroundlistdown','prl_ogrounddtl','prl_ogrounddtldown');

end;
/
commit;

create or replace view v_PRL_Ground_Floor as
select g.floorno, g.fno, g.farea
  from prl_groundh g
 where g.deptsource = '0001'
 order by g.floorno;

create or replace view v_Prl_OIsf_Floor as
select t.fno, t.floorno, g.farea, t.farea tarea
  from wf_prl_oisf_ground g, prl_groundh t, v_Prl_OISF v
 where g.entgid = v.entgid
   and g.flowgid = v.ISFFlowGid
   and lower(g.fno) = lower(t.fno)
   and v.ISFDepeCode = t.deptsource
   and v.ISCFFlowGid is null
   and v.ISTFFlowGid is null
   and v.ISFStat not in ('40')
   and v.ISFCONTRACTDATE1 <= sysdate
   and v.ISFCONTRACTDATE2 >= sysdate;


create or replace view v_prl_oisf as
select i.entgid,
       i.ISFFlowType,
       i.ISFModelGid,
       i.ISFModelCode,
       i.ISFFlowGid,
       i.ISFNum,
       i.ISFFillUsrName,
       i.ISFCreateDate,
       i.ISFStat,
       i.ISFStatText,
       i.ISFDepeCode,
       i.ISFCONTRACTDATE1,
       i.ISFCONTRACTDATE2,
       c.ISCFModelGid,
       c.ISCFModelCode,
       c.ISCFFlowGid,
       c.ISCFNum,
       c.ISCFFillUsrName,
       c.ISCFStat,
       c.ISCFFStat,
       t.ISTFModelGid,
       t.ISTFModelCode,
       t.ISTFFlowGid,
       t.ISTFNum,
       t.ISTFFillUsrName,
       t.ISTFStat,
       t.ISTFFStat
  from (select f.entgid,
               decode(f.FlowType, '10', 'ISF', '20', 'ISCF', 'MAll') ISFFlowType,
               f.modelgid ISFModelGid,
               wm.code ISFModelCode,
               f.flowgid ISFFlowGid,
               f.num ISFNum,
               f.fillusrname ISFFillUsrName,
               f.createdate ISFcreatedate,
               f.CONTRACTDATE1 ISFCONTRACTDATE1,
               f.CONTRACTDATE2 ISFCONTRACTDATE2,
               decode(f.stat,
                      '0',
                      '未开始',
                      '1',
                      '填写中',
                      '10',
                      '已提交，审批中',
                      '12',
                      '已同意',
                      '13',
                      '已否决',
                      '30',
                      '已完成',
                      '40',
                      '已终止合同',
                      '100',
                      '发起人结束流程',
                      f.Stat) ISFStatText,
               f.stat ISFStat,
               substr(f.FillDeptCode, 0, 4) ISFDepeCode
          from wf_prl_Oisf f, wf_flow wf, wf_model wm
         where f.entgid = wf.entgid
           and f.flowgid = wf.flowgid
           and f.Entgid = wm.EntGid
           and wf.ModelGid = wm.ModelGid
           and wf.stat = 3
           and f.stat in ('30', '40', '已完成')
           and f.flowtype in (10, 20)
        union
        select f.entgid,
               decode(f.FlowType, '10', 'ISF', '20', 'ISCF', 'MAll') ISFFlowType,
               f.modelgid ISFModelGid,
               wm.code ISFModelCode,
               f.flowgid ISFFlowGid,
               f.num ISFNum,
               f.fillusrname ISFFillUsrName,
               f.createdate ISFcreatedate,
               f.CONTRACTDATE1 ISFCONTRACTDATE1,
               f.CONTRACTDATE2 ISFCONTRACTDATE2,
               decode(f.stat,
                      '0',
                      '未开始',
                      '1',
                      '填写中',
                      '10',
                      '已提交，审批中',
                      '12',
                      '已同意',
                      '13',
                      '已否决',
                      '30',
                      '已完成',
                      '40',
                      '已终止合同',
                      '100',
                      '发起人结束流程',
                      f.Stat) ISFStatText,
               f.stat ISFStat,
               substr(f.FillDeptCode, 0, 4) ISFDepeCode
          from wf_prl_Oisf f, wf_model wm
         where f.Entgid = wm.EntGid
           and f.ModelGid = wm.ModelGid
           and f.flowtype = 30
           and f.stat in ('30', '40')) i,
       (select f.entgid,
               f.modelgid ISCFModelGid,
               wm.code ISCFModelCode,
               f.flowgid ISCFFlowGid,
               f.num ISCFNum,
               f.fillusrname ISCFfillUsrName,
               decode(f.stat,
                      '0',
                      '未开始',
                      '1',
                      '填写中',
                      '10',
                      '已提交，审批中',
                      '12',
                      '已同意',
                      '13',
                      '已否决',
                      '30',
                      '已完成',
                      '40',
                      '已终止合同',
                      '100',
                      '发起人结束流程',
                      f.Stat) ISCFStat,
               decode(wf.stat,
                      '0',
                      '未执行',
                      '1',
                      '待执行',
                      '2',
                      '执行中',
                      '3',
                      '已完成',
                      '4',
                      '已停止',
                      '5',
                      '已作废',
                      '6',
                      '已超时') ISCFFStat,
               f.oldflowgid
          from wf_prl_Oisf f, wf_flow wf, wf_model wm
         where f.entgid = wf.entgid
           and f.flowgid = wf.flowgid
           and f.Entgid = wm.EntGid
           and wf.ModelGid = wm.ModelGid
           and wf.stat < 4
           and f.stat not in ('终止', '100')) c,
       (select f.entgid,
               f.modelgid ISTFModelGid,
               wm.code ISTFModelCode,
               f.flowgid ISTFFlowGid,
               f.num ISTFNum,
               f.fillusrname ISTFfillUsrName,
               decode(f.stat,
                      '0',
                      '未开始',
                      '1',
                      '填写中',
                      '10',
                      '已提交，审批中',
                      '12',
                      '已同意',
                      '13',
                      '已否决',
                      '30',
                      '已完成',
                      '40',
                      '已终止合同',
                      '100',
                      '发起人结束流程',
                      f.Stat) ISTFStat,
               decode(wf.stat,
                      '0',
                      '未执行',
                      '1',
                      '待执行',
                      '2',
                      '执行中',
                      '3',
                      '已完成',
                      '4',
                      '已停止',
                      '5',
                      '已作废',
                      '6',
                      '已超时') ISTFFStat,
               f.oldflowgid
          from wf_prl_Oistf f, wf_flow wf, wf_model wm
         where f.entgid = wf.entgid
           and f.flowgid = wf.flowgid
           and f.Entgid = wm.EntGid
           and wf.ModelGid = wm.ModelGid
           and wf.stat < 4
           and f.stat not in ('终止', '100')) t
 where i.entgid = c.entgid(+)
   and i.ISFFlowGid = c.oldflowgid(+)
   and i.entgid = t.entgid(+)
   and i.ISFFlowGid = t.oldflowgid(+)
 order by i.ISFcreatedate desc;

