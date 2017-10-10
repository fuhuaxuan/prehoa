create table wf_prl_oisf_app_1001 as select * from wf_prl_oisf_app;
create table wf_prl_isf_app_1001 as select * from wf_prl_isf_app;
create table wf_prl_fee_app_1001 as select * from wf_prl_fee_app;
create table wf_prl_pay_app_1001 as select * from wf_prl_pay_app;
create table wf_prl_baoxiao_app_1001 as select * from wf_prl_baoxiao_app;
create table wf_task_1001 as select * from wf_task;

update wf_prl_oisf_app a set a.apptype = 91 where a.apptype = 90;
update wf_prl_oisf_app a set a.apptype = 90 where a.apptype = 80;
update wf_prl_oisf_app a set a.apptype = 80 where a.apptype = 91;

update wf_prl_isf_app a set a.apptype = 91 where a.apptype = 90;
update wf_prl_isf_app a set a.apptype = 90 where a.apptype = 80;
update wf_prl_isf_app a set a.apptype = 80 where a.apptype = 91;

update wf_prl_isf_app a set a.apptype = 35 where a.apptype = 30;
update wf_prl_isf_app a set a.apptype = 30 where a.apptype = 20;

update wf_prl_baoxiao_app a set a.apptype = 3 where a.apptype = 15;


alter table wf_Prl_Pay_App add AppOrder int;
update wf_Prl_Pay_App set AppOrder = AppType;

alter table wf_Prl_Fee_App add AppOrder int;
update wf_Prl_Fee_App set AppOrder = AppType;

alter table wf_Prl_Baoxiao_App add AppOrder int;
update wf_Prl_Baoxiao_App set AppOrder = AppType;

alter table wf_Prl_ISF_App add AppOrder int;
update wf_Prl_ISF_App set AppOrder = AppType;

alter table wf_Prl_OISF_App add AppOrder int;
update wf_Prl_OISF_App set AppOrder = AppType;

--д��¥ISF,ISCF,ISTF���T2,������ת
--����6�����̣��޸�T2,������ת