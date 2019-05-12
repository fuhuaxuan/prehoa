--ISF��ͼ
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
                      'δִ��',
                      '1',
                      '��ִ��',
                      '2',
                      'ִ����',
                      '3',
                      '�����',
                      '4',
                      '��ֹͣ',
                      '5',
                      '������',
                      '6',
                      '�ѳ�ʱ') ISFFStat,
               substr(f.FILLDEPTCODE, 0, 4) ISFDepeCode
          from wf_PrlGG_ISF f, wf_flow wf, wf_model wm
         where f.entgid = wf.entgid
           and f.flowgid = wf.flowgid
           and f.Entgid = wm.EntGid
           and wf.ModelGid = wm.ModelGid
           and wf.stat = 3
           and f.stat in ('����ֹ��ͬ','�����')
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
                      'δִ��',
                      '1',
                      '��ִ��',
                      '2',
                      'ִ����',
                      '3',
                      '�����',
                      '4',
                      '��ֹͣ',
                      '5',
                      '������',
                      '6',
                      '�ѳ�ʱ') ISCFFStat,
               f.oldflowgid
          from wf_PrlGG_ISF f, wf_flow wf, wf_model wm
         where f.entgid = wf.entgid
           and f.flowgid = wf.flowgid
           and f.Entgid = wm.EntGid
           and wf.ModelGid = wm.ModelGid
           and wf.stat < 4
           and f.stat not in ('��ֹ', '100')) c,
       (select f.entgid,
               f.modelgid ISTFModelGid,
               wm.code ISTFModelCode,
               f.flowgid ISTFFlowGid,
               f.num ISTFNum,
               f.fillusrname ISTFfillUsrName,
               f.stat ISTFStat,
               decode(wf.stat,
                      '0',
                      'δִ��',
                      '1',
                      '��ִ��',
                      '2',
                      'ִ����',
                      '3',
                      '�����',
                      '4',
                      '��ֹͣ',
                      '5',
                      '������',
                      '6',
                      '�ѳ�ʱ') ISTFFStat,
               f.oldflowgid
          from wf_prlGG_istf f, wf_flow wf, wf_model wm
         where f.entgid = wf.entgid
           and f.flowgid = wf.flowgid
           and f.Entgid = wm.EntGid
           and wf.ModelGid = wm.ModelGid
           and wf.stat < 4
           and f.stat not in ('��ֹ')) t
 where i.entgid = c.entgid(+)
   and i.ISFFlowGid = c.oldflowgid(+)
   and i.entgid = t.entgid(+)
   and i.ISFFlowGid = t.oldflowgid(+)
 order by i.ISFcreatedate desc;
