create or replace view v_prl_Invoice as
select f.entgid,
       f.modelgid,
       '��������' ModelName,
       f.flowgid,
       f.num,
       f.stat,
       f.createdate,
       f.fillusrgid,
       f.fillusrcode,
       f.fillusrname,
       f.fillusrdeptgid fillDeptgid,
       f.fillusrdeptcode fillDeptcode,
       f.fillusrdept fillDeptname,
       f.companygid comgid,
       f.companyname comname,
       a.attach_title,
       replace(Attach_Url,' ','%20') attach_url
  from wf_prl_pay f, wf_prl_pay_attach a
 where f.entgid = a.entgid
   and f.flowgid = a.flowgid
   and a.Attach_Type = 20
   and f.stat = '�����'
union all
select f.entgid,
       f.modelgid,
       '�ܲ���������' ModelName,
       f.flowgid,
       f.num,
       f.stat,
       f.createdate,
       f.fillusrgid,
       f.fillusrcode,
       f.fillusrname,
       f.fillusrdeptgid fillDeptgid,
       f.fillusrdeptcode fillDeptcode,
       f.fillusrdept fillDeptname,
       f.companygid comgid,
       f.companyname comname,
       a.attach_title,
       replace(Attach_Url,' ','%20') attach_url
  from wf_prlzb_pay f, wf_prlzb_pay_attach a
 where f.entgid = a.entgid
   and f.flowgid = a.flowgid
   and a.Attach_Type = 20
   and f.stat = '�����'
union all
select f.entgid,
       f.modelgid,
       '���˱�������' ModelName,
       f.flowgid,
       f.num,
       f.stat,
       f.createdate,
       f.fillusrgid,
       f.fillusrcode,
       f.fillusrname,
       f.fillDeptgid,
       f.fillDeptcode,
       f.fillDeptname,
       f.comgid,
       f.comname,
       a.attach_title,
       replace(Attach_Url,' ','%20') attach_url
  from wf_prl_baoxiao f, wf_prl_baoxiao_attach a
 where f.entgid = a.entgid
   and f.flowgid = a.flowgid
   and a.Attach_Type = 20
   and f.stat = '�����'
union all
select f.entgid,
       f.modelgid,
       '�ܲ����˱�������' ModelName,
       f.flowgid,
       f.num,
       f.stat,
       f.createdate,
       f.fillusrgid,
       f.fillusrcode,
       f.fillusrname,
       f.fillDeptgid,
       f.fillDeptcode,
       f.fillDeptname,
       f.comgid,
       f.comname,
       a.attach_title,
       replace(Attach_Url,' ','%20') attach_url
  from wf_prlzb_baoxiao f, wf_prlzb_baoxiao_attach a
 where f.entgid = a.entgid
   and f.flowgid = a.flowgid
   and a.Attach_Type = 20
   and f.stat = '�����';