create or replace view v_flowfee as
select entgid,
       trim(to_char(year, '9999')) year,
       createdate,
       companygid comgid,
       acggid,
       opusrgid,
       opusrcode,
       opusrname,
       opdate,
       oppfee,
       opcfee,
       opmemo,
       opmodelcode,
       opflowgid,
       opnum,
       opfee
  from PRL_DOA_RCD
union all
select f.entgid,
       to_char(f.createdate, 'YYYY') Year,
       f.createdate,
       f.companygid comgid,
       f.acgtwogid acggid,
       f.fillusrgid opusrgid,
       f.fillusrcode opusrcode,
       f.fillusrname opusrname,
       f.createdate opdate,
       0 oppfee,
       0 opcfee,
       '�������뵥�ۼ�-δ���' opmemo,
       'PRLDZ_FEE' opmodelcode,
       f.flowgid opflowgid,
       f.num opnum,
       0 - nvl(nvl(confirmfee, askfee), 0) opfee
  from wf_prl_fee f, wf_flow wf
 where f.entgid = wf.entgid
   and f.flowgid = wf.flowgid
   and wf.stat < 3
   and f.stat not in ('13', '100', '��ֹ')
union all
select f.entgid,
       to_char(f.createdate, 'YYYY') Year,
       f.createdate,
       f.comgid comgid,
       fd.acggid acggid,
       f.fillusrgid opusrgid,
       f.fillusrcode opusrcode,
       f.fillusrname opusrname,
       f.createdate opdate,
       0 oppfee,
       0 opcfee,
       '���˱������ۼ�-δ���' opmemo,
       'PRLDZ_BAOXIAO' opmodelcode,
       f.flowgid opflowgid,
       f.num opnum,
       0 - nvl(ApplyFee, 0) opfee
  from wf_prl_baoxiao f, wf_prl_baoxiao_dtl fd, wf_flow wf
 where f.entgid = wf.entgid
   and f.entgid = fd.entgid
   and f.flowgid = wf.flowgid
   and f.flowgid = fd.flowgid
   and wf.stat < 3
   and f.stat not in ('��ֹ')
   and f.istake is null
union all
select f.entgid,
       to_char(f.createdate, 'YYYY') Year,
       f.createdate,
       f.companygid comgid,
       f.acgtwogid acggid,
       f.fillusrgid opusrgid,
       f.fillusrcode opusrcode,
       f.fillusrname opusrname,
       f.createdate opdate,
       0 oppfee,
       0 opcfee,
       '�������뵥�ۼ�-δ���' opmemo,
       'PRLDZ_PAY' opmodelcode,
       f.flowgid opflowgid,
       f.num opnum,
       0 - nvl(nvl(NPayFee,payfee), 0) opfee
  from WF_PRL_PAY f, wf_flow wf
 where f.entgid = wf.entgid
   and f.flowgid = wf.flowgid
   and wf.stat < 3
   and f.stat not in ('13', '100', '��ֹ')
   and f.feeflowgid is null
union all
select f.entgid,
       to_char(f.createdate, 'YYYY') Year,
       f.createdate,
       f.comGid comgid,
       f.pAcgGid acggid,
       f.fillusrgid opusrgid,
       f.fillusrcode opusrcode,
       f.fillusrname opusrname,
       f.createdate opdate,
       0 oppfee,
       0 opcfee,
       'Ԥ�����ۼ�-δ���' opmemo,
       'PrlDZ_AcgChg' opmodelcode,
       f.flowgid opflowgid,
       f.num opnum,
       0 - nvl(ApplyFee, 0) opfee
  from WF_PRLDZ_AcgChg f, wf_flow wf
 where f.entgid = wf.entgid
   and f.flowgid = wf.flowgid
   and wf.stat < 3
   and f.stat not in ('��ֹ');
