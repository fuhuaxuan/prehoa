create or replace view v_prldz_area as
select i.entgid,
       i.ISFModelGid,
       i.ISFModelCode,
       i.ISFFlowGid,
       i.ISFNum,
       i.ISFFillUsrName,
       i.ISFCreateDate,
       i.ISFStat,
       i.ISFProjectName,
       c.ISCFModelGid,
       c.ISCFModelCode,
       c.ISCFFlowGid,
       c.ISCFNum,
       c.ISCFFillUsrName,
       c.ISCFStat,
       c.ISCFProjectName
  from (select f.entgid,
               f.modelgid    ISFModelGid,
               wm.code       ISFModelCode,
               f.flowgid     ISFFlowGid,
               f.num         ISFNum,
               f.stat        ISFStat,
               f.fillusrname ISFFillUsrName,
               f.createdate  ISFcreatedate,
               f.ProjectName ISFProjectName
          from wf_prldz_area f, wf_flow wf, wf_model wm
         where f.entgid = wf.entgid
           and f.flowgid = wf.flowgid
           and f.Entgid = wm.EntGid
           and wf.ModelGid = wm.ModelGid
           and wf.stat = 3
           and f.stat in ('已完成')) i,
       (select f.entgid,
               f.modelgid    ISCFModelGid,
               wm.code       ISCFModelCode,
               f.flowgid     ISCFFlowGid,
               f.num         ISCFNum,
               f.stat        ISCFStat,
               f.fillusrname ISCFFillUsrName,
               f.createdate  ISCFcreatedate,
               f.ProjectName ISCFProjectName,
               f.oldflowgid,
               f.rootflowgid
          from wf_prldz_area f, wf_flow wf, wf_model wm
         where f.entgid = wf.entgid
           and f.flowgid = wf.flowgid
           and f.Entgid = wm.EntGid
           and wf.ModelGid = wm.ModelGid
           and wf.stat = 3
           and f.stat in ('已完成')) c
 where i.entgid = c.entgid(+)
   and i.ISFFlowGid = c.oldflowgid(+)
 order by i.ISFcreatedate desc;
