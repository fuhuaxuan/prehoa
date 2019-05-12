---权限执行脚本
declare
  v_EntGid  varchar2(32);
begin
select Gid into v_EntGid from Ent where Lower(code) = Lower('prlintra'); 
--新增模块权限
delete from rt where id in ('prlgg_isflist','prlgg_isfdown','prlgg_isfdtl','prlgg_isfdtldown');

insert into rt(id,name,atype,alevel,url,aorder,memo) values('prlgg_isflist','广告位ISF查看列表','DOA管理','30','/bin/hdnet.dll/__explainmodule?url=prlgg_isflist','800430','ISF查看列表');
insert into rt(id,name,atype,alevel,url,aorder,memo) values('prlgg_isfdown','广告位ISF查看列表','DOA管理','30','/bin/hdnet.dll/__explainmodule?url=prlgg_isfdown','800431','ISF查看列表');
insert into rt(id,name,atype,alevel,url,aorder,memo) values('prlgg_isfdtl','广告位ISF明细列表','DOA管理','30','/bin/hdnet.dll/__explainmodule?url=prlgg_isfdtl','800432','ISF明细列表');
insert into rt(id,name,atype,alevel,url,aorder,memo) values('prlgg_isfdtldown','广告位ISF明细列表','DOA管理','30','/bin/hdnet.dll/__explainmodule?url=prlgg_isfdtldown','800433','ISF明细列表');

--将权限默认给管理员组
--插入企业权限
delete from ent_rt where entgid = v_EntGid and rtid in ('prlgg_isflist','prlgg_isfdown','prlgg_isfdtl','prlgg_isfdtldown');
insert into ent_rt select v_EntGid , id from rt where id in ('prlgg_isflist','prlgg_isfdown','prlgg_isfdtl','prlgg_isfdtldown');

--插入管理员权限
delete from org_rt where entgid = v_EntGid and rtid in ('prlgg_isflist','prlgg_isfdown','prlgg_isfdtl','prlgg_isfdtldown');
insert into org_rt select v_EntGid ,org.gid , rt.id,'10' from org, rt where org.entgid = v_EntGid and lower(org.code) = lower('admin_grp') and rt.id in ('prlgg_isflist','prlgg_isfdown','prlgg_isfdtl','prlgg_isfdtldown');

--插入组织所有权限表
delete from org_rt_all where entgid = v_EntGid and rtid in ('prlgg_isflist','prlgg_isfdown','prlgg_isfdtl','prlgg_isfdtldown');
insert into org_rt_all select v_EntGid ,org.gid , rt.id,'10' from org, rt where org.entgid = v_EntGid and lower(org.code) = lower('admin_grp') and rt.id in ('prlgg_isflist','prlgg_isfdown','prlgg_isfdtl','prlgg_isfdtldown');

end;
/
commit;
--ISF视图
create or replace view v_PrlGG_ISF as
select i.entgid,
       i.ISFFlowType,
       i.ISFModelGid,
       i.ISFModelCode,
       i.ISFFlowGid,
       i.ISFNum,
       i.ISFFillUsrName,
       i.ISFCreateDate,
       i.ISFStat,
       i.ISFFStat,
       i.ISFDepeCode,
       i.lessee          ISFlessee,
       i.tradingname     ISFtradingname,
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
               f.stat ISFStat,
               f.lessee,
               f.tradingname,
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
                      '已超时') ISFFStat,
               substr(f.FILLDEPTCODE, 0, 4) ISFDepeCode
          from wf_PrlGG_ISF f, wf_flow wf, wf_model wm
         where f.entgid = wf.entgid
           and f.flowgid = wf.flowgid
           and f.Entgid = wm.EntGid
           and wf.ModelGid = wm.ModelGid
           and wf.stat = 3
           and f.stat in ('已完成')
           and f.flowtype in (10, 20)) i,
       (select f.entgid,
               f.modelgid ISCFModelGid,
               wm.code ISCFModelCode,
               f.flowgid ISCFFlowGid,
               f.num ISCFNum,
               f.fillusrname ISCFfillUsrName,
               f.stat ISCFStat,
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
          from wf_PrlGG_ISF f, wf_flow wf, wf_model wm
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
               f.stat ISTFStat,
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
          from wf_prlGG_istf f, wf_flow wf, wf_model wm
         where f.entgid = wf.entgid
           and f.flowgid = wf.flowgid
           and f.Entgid = wm.EntGid
           and wf.ModelGid = wm.ModelGid
           and wf.stat < 4
           and f.stat not in ('终止')) t
 where i.entgid = c.entgid(+)
   and i.ISFFlowGid = c.oldflowgid(+)
   and i.entgid = t.entgid(+)
   and i.ISFFlowGid = t.oldflowgid(+)
 order by i.ISFcreatedate desc;
