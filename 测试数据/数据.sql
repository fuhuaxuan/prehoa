prompt PL/SQL Developer import file
prompt Created on 2012年6月1日 by Administrator
set feedback off
set define off
prompt Disabling triggers for BUSRANGE...
alter table BUSRANGE disable all triggers;
prompt Disabling triggers for BUSRANGESALETYPE...
alter table BUSRANGESALETYPE disable all triggers;
prompt Disabling triggers for REGION...
alter table REGION disable all triggers;
prompt Disabling triggers for SALE_INTRA...
alter table SALE_INTRA disable all triggers;
prompt Disabling triggers for SALE_MALL...
alter table SALE_MALL disable all triggers;
prompt Disabling triggers for STORE...
alter table STORE disable all triggers;
prompt Deleting STORE...
delete from STORE;
commit;
prompt Deleting SALE_MALL...
delete from SALE_MALL;
commit;
prompt Deleting SALE_INTRA...
delete from SALE_INTRA;
commit;
prompt Deleting REGION...
delete from REGION;
commit;
prompt Deleting BUSRANGESALETYPE...
delete from BUSRANGESALETYPE;
commit;
prompt Deleting BUSRANGE...
delete from BUSRANGE;
commit;
prompt Loading BUSRANGE...
insert into BUSRANGE (BUSRANGECODE, BUSRANGENAME)
values ('CY', '餐饮');
insert into BUSRANGE (BUSRANGECODE, BUSRANGENAME)
values ('YL', '娱乐');
insert into BUSRANGE (BUSRANGECODE, BUSRANGENAME)
values ('JD', '酒店');
insert into BUSRANGE (BUSRANGECODE, BUSRANGENAME)
values ('WYZL', '物业租赁');
insert into BUSRANGE (BUSRANGECODE, BUSRANGENAME)
values ('LZMTYSY', '龙之梦购物中心统一收银');
insert into BUSRANGE (BUSRANGECODE, BUSRANGENAME)
values ('HXMKL', '红星美凯龙');
insert into BUSRANGE (BUSRANGECODE, BUSRANGENAME)
values ('YTSM', '亚太数码中心');
commit;
prompt 7 records loaded
prompt Loading BUSRANGESALETYPE...
insert into BUSRANGESALETYPE (BUSRANGECODE, SALETYPECODE, SALETYPENAME)
values ('JD', 'JD01', '房费');
insert into BUSRANGESALETYPE (BUSRANGECODE, SALETYPECODE, SALETYPENAME)
values ('JD', 'JD02', '餐饮');
insert into BUSRANGESALETYPE (BUSRANGECODE, SALETYPECODE, SALETYPENAME)
values ('JD', 'JD03', '其他');
insert into BUSRANGESALETYPE (BUSRANGECODE, SALETYPECODE, SALETYPENAME)
values ('WYZL', 'WYZL01', '物业管理费');
insert into BUSRANGESALETYPE (BUSRANGECODE, SALETYPECODE, SALETYPENAME)
values ('WYZL', 'WYZL02', '物业租赁费');
insert into BUSRANGESALETYPE (BUSRANGECODE, SALETYPECODE, SALETYPENAME)
values ('LZMTYSY', 'LZMTYSY01', '现金');
insert into BUSRANGESALETYPE (BUSRANGECODE, SALETYPECODE, SALETYPENAME)
values ('LZMTYSY', 'LZMTYSY02', '银行卡');
insert into BUSRANGESALETYPE (BUSRANGECODE, SALETYPECODE, SALETYPENAME)
values ('LZMTYSY', 'LZMTYSY03', '其他');
insert into BUSRANGESALETYPE (BUSRANGECODE, SALETYPECODE, SALETYPENAME)
values ('YTSM', 'YTSM01', '现金');
insert into BUSRANGESALETYPE (BUSRANGECODE, SALETYPECODE, SALETYPENAME)
values ('YTSM', 'YTSM02', '银行卡');
insert into BUSRANGESALETYPE (BUSRANGECODE, SALETYPECODE, SALETYPENAME)
values ('YTSM', 'YTSM03', '其他');
insert into BUSRANGESALETYPE (BUSRANGECODE, SALETYPECODE, SALETYPENAME)
values ('HXMKL', 'HXMKL01', '现金');
insert into BUSRANGESALETYPE (BUSRANGECODE, SALETYPECODE, SALETYPENAME)
values ('HXMKL', 'HXMKL02', '银行卡');
insert into BUSRANGESALETYPE (BUSRANGECODE, SALETYPECODE, SALETYPENAME)
values ('HXMKL', 'HXMKL03', '其他');
insert into BUSRANGESALETYPE (BUSRANGECODE, SALETYPECODE, SALETYPENAME)
values ('CY', 'CY01', '现金');
insert into BUSRANGESALETYPE (BUSRANGECODE, SALETYPECODE, SALETYPENAME)
values ('CY', 'CY02', '银行卡');
insert into BUSRANGESALETYPE (BUSRANGECODE, SALETYPECODE, SALETYPENAME)
values ('CY', 'CY03', '其他');
insert into BUSRANGESALETYPE (BUSRANGECODE, SALETYPECODE, SALETYPENAME)
values ('YL', 'YL01', '现金');
insert into BUSRANGESALETYPE (BUSRANGECODE, SALETYPECODE, SALETYPENAME)
values ('YL', 'YL02', '银行卡');
insert into BUSRANGESALETYPE (BUSRANGECODE, SALETYPECODE, SALETYPENAME)
values ('YL', 'YL03', '其他');
commit;
prompt 20 records loaded
prompt Loading REGION...
insert into REGION (REGIONCODE, REGIONNAME)
values ('SH', '上海');
insert into REGION (REGIONCODE, REGIONNAME)
values ('SY', '沈阳');
commit;
prompt 2 records loaded
prompt Loading SALE_INTRA...
prompt Table is empty
prompt Loading SALE_MALL...
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('05-03-2012', 'dd-mm-yyyy'), 'LZMTYSY02', 48387.9);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('13-08-2011', 'dd-mm-yyyy'), 'LZMTYSY02', 224485.7);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('14-09-2011', 'dd-mm-yyyy'), 'LZMTYSY02', 40752.1);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('22-10-2011', 'dd-mm-yyyy'), 'LZMTYSY02', 140913.7);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('17-08-2011', 'dd-mm-yyyy'), 'LZMTYSY02', 75565.9);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('29-09-2011', 'dd-mm-yyyy'), 'LZMTYSY02', 58559.6);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('14-10-2011', 'dd-mm-yyyy'), 'LZMTYSY02', 62452.5);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('03-03-2012', 'dd-mm-yyyy'), 'LZMTYSY02', 133612.4);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('25-07-2011', 'dd-mm-yyyy'), 'LZMTYSY03', -20.9);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('07-09-2011', 'dd-mm-yyyy'), 'LZMTYSY03', -2009.6);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('09-10-2011', 'dd-mm-yyyy'), 'LZMTYSY03', 8596.6);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('10-11-2011', 'dd-mm-yyyy'), 'LZMTYSY03', 14949.1);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('13-11-2011', 'dd-mm-yyyy'), 'LZMTYSY03', 37775.3);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('31-12-2011', 'dd-mm-yyyy'), 'LZMTYSY03', 34634.7);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('03-10-2011', 'dd-mm-yyyy'), 'LZMTYSY03', 37788.6);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('12-08-2011', 'dd-mm-yyyy'), 'LZMTYSY03', -1160.5);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('17-11-2011', 'dd-mm-yyyy'), 'LZMTYSY03', 830.2);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('21-11-2011', 'dd-mm-yyyy'), 'LZMTYSY03', 10712);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('08-08-2011', 'dd-mm-yyyy'), 'LZMTYSY03', -96);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('26-11-2011', 'dd-mm-yyyy'), 'LZMTYSY03', -334.5);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('28-07-2011', 'dd-mm-yyyy'), 'LZMTYSY03', -3);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('22-09-2011', 'dd-mm-yyyy'), 'LZMTYSY03', -1844.6);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('13-02-2012', 'dd-mm-yyyy'), 'LZMTYSY03', 9367.5);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('21-03-2012', 'dd-mm-yyyy'), 'LZMTYSY03', 5587.5);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('18-07-2011', 'dd-mm-yyyy'), 'LZMTYSY03', -56.6);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('08-11-2011', 'dd-mm-yyyy'), 'LZMTYSY03', 81010.7);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('23-12-2011', 'dd-mm-yyyy'), 'LZMTYSY03', 24405.7);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('10-02-2012', 'dd-mm-yyyy'), 'LZMTYSY03', 83154);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('25-02-2012', 'dd-mm-yyyy'), 'LZMTYSY03', 8956.9);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('19-07-2011', 'dd-mm-yyyy'), 'LZMTYSY03', -6);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('17-08-2011', 'dd-mm-yyyy'), 'LZMTYSY03', -6963.3);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('07-10-2011', 'dd-mm-yyyy'), 'LZMTYSY03', -622.8);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('16-12-2011', 'dd-mm-yyyy'), 'LZMTYSY03', 307.1);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('05-08-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 30);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('08-01-2012', 'dd-mm-yyyy'), 'LZMTYSY01', 306563.9);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('18-11-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 193292.1);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('02-04-2012', 'dd-mm-yyyy'), 'LZMTYSY01', 362664.5);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('29-08-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 10108324.8);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('26-07-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 300);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('03-12-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 299060.85);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('13-08-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 153816);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('16-12-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 200732.04);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('29-12-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 175757.4);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('03-03-2012', 'dd-mm-yyyy'), 'LZMTYSY01', 339613.2);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('02-09-2011', 'dd-mm-yyyy'), 'LZMTYSY02', 46255.3);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('04-10-2011', 'dd-mm-yyyy'), 'LZMTYSY02', 186924.2);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('08-09-2011', 'dd-mm-yyyy'), 'LZMTYSY02', 67955.7);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('16-11-2011', 'dd-mm-yyyy'), 'LZMTYSY02', 31330.6);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('16-01-2012', 'dd-mm-yyyy'), 'LZMTYSY02', 81475.4);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('05-11-2011', 'dd-mm-yyyy'), 'LZMTYSY02', 260947.5);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('06-04-2012', 'dd-mm-yyyy'), 'LZMTYSY02', 900);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('19-09-2011', 'dd-mm-yyyy'), 'LZMTYSY02', 55506);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('19-10-2011', 'dd-mm-yyyy'), 'LZMTYSY02', 53567.1);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('17-11-2011', 'dd-mm-yyyy'), 'LZMTYSY02', 50457.1);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('17-12-2011', 'dd-mm-yyyy'), 'LZMTYSY02', 364280.5);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('18-02-2012', 'dd-mm-yyyy'), 'LZMTYSY02', 141140.5);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('09-01-2012', 'dd-mm-yyyy'), 'LZMTYSY02', 57423.5);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('28-03-2012', 'dd-mm-yyyy'), 'LZMTYSY02', 73083.6);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('23-10-2011', 'dd-mm-yyyy'), 'LZMTYSY02', 130410);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('08-12-2011', 'dd-mm-yyyy'), 'LZMTYSY02', 60160.3);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('21-01-2012', 'dd-mm-yyyy'), 'LZMTYSY02', 229197.1);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('22-07-2011', 'dd-mm-yyyy'), 'LZMTYSY02', 810.6);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('29-12-2011', 'dd-mm-yyyy'), 'LZMTYSY02', 60143.1);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('04-08-2011', 'dd-mm-yyyy'), 'LZMTYSY03', -50);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('30-08-2011', 'dd-mm-yyyy'), 'LZMTYSY03', -6016);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('09-03-2012', 'dd-mm-yyyy'), 'LZMTYSY03', 10070.8);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('26-09-2011', 'dd-mm-yyyy'), 'LZMTYSY03', 5170.7);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('02-03-2012', 'dd-mm-yyyy'), 'LZMTYSY03', 2979.1);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('13-03-2012', 'dd-mm-yyyy'), 'LZMTYSY03', 14393.6);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('05-09-2011', 'dd-mm-yyyy'), 'LZMTYSY03', -4986.3);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('23-01-2012', 'dd-mm-yyyy'), 'LZMTYSY03', 17867.4);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('21-08-2011', 'dd-mm-yyyy'), 'LZMTYSY03', -12274.1);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('25-08-2011', 'dd-mm-yyyy'), 'LZMTYSY03', -9961.4);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('24-09-2011', 'dd-mm-yyyy'), 'LZMTYSY03', -246.9);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('05-03-2012', 'dd-mm-yyyy'), 'LZMTYSY03', 1639.8);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('13-08-2011', 'dd-mm-yyyy'), 'LZMTYSY03', -14144.2);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('08-12-2011', 'dd-mm-yyyy'), 'LZMTYSY03', 3063.9);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('03-03-2012', 'dd-mm-yyyy'), 'LZMTYSY03', 23943.7);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('13-07-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 184);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('14-12-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 132229);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('30-01-2012', 'dd-mm-yyyy'), 'LZMTYSY01', 255139.4);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('11-08-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 924.4);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('02-11-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 172709.13);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('04-03-2012', 'dd-mm-yyyy'), 'LZMTYSY01', 369729.7);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('27-02-2012', 'dd-mm-yyyy'), 'LZMTYSY01', 217170.5);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('03-09-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 172641.3);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('18-02-2012', 'dd-mm-yyyy'), 'LZMTYSY01', 329891.6);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('06-08-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 3854.9);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('04-09-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 206768.2);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('11-11-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 176702.6);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('05-12-2011', 'dd-mm-yyyy'), 'LZMTYSY02', 83996.8);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('13-12-2011', 'dd-mm-yyyy'), 'LZMTYSY02', 58226.3);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('17-09-2011', 'dd-mm-yyyy'), 'LZMTYSY02', 123510.6);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('10-11-2011', 'dd-mm-yyyy'), 'LZMTYSY02', 99117.9);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('03-02-2012', 'dd-mm-yyyy'), 'LZMTYSY02', 43100.4);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('09-02-2012', 'dd-mm-yyyy'), 'LZMTYSY02', 54047.2);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('02-02-2012', 'dd-mm-yyyy'), 'LZMTYSY02', 79274.3);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('03-09-2011', 'dd-mm-yyyy'), 'LZMTYSY02', 85932.2);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('09-12-2011', 'dd-mm-yyyy'), 'LZMTYSY02', 54565.2);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('14-08-2011', 'dd-mm-yyyy'), 'LZMTYSY02', 169023.4);
commit;
prompt 100 records committed...
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('20-08-2011', 'dd-mm-yyyy'), 'LZMTYSY02', 156300.4);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('23-11-2011', 'dd-mm-yyyy'), 'LZMTYSY02', 104800.3);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('03-12-2011', 'dd-mm-yyyy'), 'LZMTYSY02', 100303.3);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('25-02-2012', 'dd-mm-yyyy'), 'LZMTYSY02', 107734.6);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('06-08-2011', 'dd-mm-yyyy'), 'LZMTYSY02', 166.6);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('04-09-2011', 'dd-mm-yyyy'), 'LZMTYSY02', 93851.3);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('01-11-2011', 'dd-mm-yyyy'), 'LZMTYSY02', 154830.2);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('09-11-2011', 'dd-mm-yyyy'), 'LZMTYSY02', 86630.5);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('18-03-2012', 'dd-mm-yyyy'), 'LZMTYSY02', 359262.3);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('22-03-2012', 'dd-mm-yyyy'), 'LZMTYSY02', 32160.9);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('02-09-2011', 'dd-mm-yyyy'), 'LZMTYSY03', -3083.1);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('15-02-2012', 'dd-mm-yyyy'), 'LZMTYSY03', 5146.4);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('08-09-2011', 'dd-mm-yyyy'), 'LZMTYSY03', -5414.9);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('12-10-2011', 'dd-mm-yyyy'), 'LZMTYSY03', -959.7);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('06-04-2012', 'dd-mm-yyyy'), 'LZMTYSY03', -43);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('26-08-2011', 'dd-mm-yyyy'), 'LZMTYSY03', -4959.6);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('19-09-2011', 'dd-mm-yyyy'), 'LZMTYSY03', 893.7);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('10-12-2011', 'dd-mm-yyyy'), 'LZMTYSY03', 3523.6);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('11-02-2012', 'dd-mm-yyyy'), 'LZMTYSY03', 5588.2);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('17-03-2012', 'dd-mm-yyyy'), 'LZMTYSY03', 37208);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('31-07-2011', 'dd-mm-yyyy'), 'LZMTYSY03', -.8);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('11-10-2011', 'dd-mm-yyyy'), 'LZMTYSY03', -498.4);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('27-03-2012', 'dd-mm-yyyy'), 'LZMTYSY03', 3744.2);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('19-11-2011', 'dd-mm-yyyy'), 'LZMTYSY03', 36166.6);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('23-11-2011', 'dd-mm-yyyy'), 'LZMTYSY03', 22988.3);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('14-01-2012', 'dd-mm-yyyy'), 'LZMTYSY03', 109030.2);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('30-12-2011', 'dd-mm-yyyy'), 'LZMTYSY03', 25422.4);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('23-07-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 200.1);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('26-10-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 111046.2);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('11-12-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 304411.25);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('09-03-2012', 'dd-mm-yyyy'), 'LZMTYSY01', 190098.2);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('30-10-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 422339.37);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('30-07-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 738.2);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('12-11-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 317890.5);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('25-11-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 175462.4);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('13-03-2012', 'dd-mm-yyyy'), 'LZMTYSY01', 149392.5);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('05-04-2012', 'dd-mm-yyyy'), 'LZMTYSY01', 154216.4);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('11-10-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 91569.6);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('13-01-2012', 'dd-mm-yyyy'), 'LZMTYSY01', 267144.04);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('25-08-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 146564.3);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('29-01-2012', 'dd-mm-yyyy'), 'LZMTYSY01', 310494.2);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('25-02-2012', 'dd-mm-yyyy'), 'LZMTYSY01', 377449.6);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('24-03-2012', 'dd-mm-yyyy'), 'LZMTYSY01', 317865.8);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('20-03-2012', 'dd-mm-yyyy'), 'LZMTYSY01', 140643.5);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('10-08-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 580.1);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('08-03-2012', 'dd-mm-yyyy'), 'LZMTYSY01', 339502.4);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('07-09-2011', 'dd-mm-yyyy'), 'LZMTYSY02', 76585.7);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('30-01-2012', 'dd-mm-yyyy'), 'LZMTYSY02', 217545.4);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('23-08-2011', 'dd-mm-yyyy'), 'LZMTYSY02', 47653.9);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('01-02-2012', 'dd-mm-yyyy'), 'LZMTYSY02', 57941.5);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('26-02-2012', 'dd-mm-yyyy'), 'LZMTYSY02', 147054.2);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('12-08-2011', 'dd-mm-yyyy'), 'LZMTYSY02', 30135.9);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('31-07-2011', 'dd-mm-yyyy'), 'LZMTYSY02', 388);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('24-10-2011', 'dd-mm-yyyy'), 'LZMTYSY02', 48298.7);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('27-03-2012', 'dd-mm-yyyy'), 'LZMTYSY02', 59210.7);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('12-09-2011', 'dd-mm-yyyy'), 'LZMTYSY02', 218008.6);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('01-12-2011', 'dd-mm-yyyy'), 'LZMTYSY02', 593261.5);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('10-09-2011', 'dd-mm-yyyy'), 'LZMTYSY02', 146635.4);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('13-12-2011', 'dd-mm-yyyy'), 'LZMTYSY03', -807.8);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('14-12-2011', 'dd-mm-yyyy'), 'LZMTYSY03', 21382.9);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('18-10-2011', 'dd-mm-yyyy'), 'LZMTYSY03', -597.3);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('26-03-2012', 'dd-mm-yyyy'), 'LZMTYSY03', 1658.2);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('11-01-2012', 'dd-mm-yyyy'), 'LZMTYSY03', 8502.1);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('26-07-2011', 'dd-mm-yyyy'), 'LZMTYSY03', -18.5);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('20-09-2011', 'dd-mm-yyyy'), 'LZMTYSY03', -1127.4);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('20-12-2011', 'dd-mm-yyyy'), 'LZMTYSY03', 4798.2);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('13-09-2011', 'dd-mm-yyyy'), 'LZMTYSY03', -1041.1);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('01-12-2011', 'dd-mm-yyyy'), 'LZMTYSY03', 57638.5);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('15-11-2011', 'dd-mm-yyyy'), 'LZMTYSY03', 379535.9);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('30-11-2011', 'dd-mm-yyyy'), 'LZMTYSY03', 26065.9);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('13-04-2012', 'dd-mm-yyyy'), 'LZMTYSY01', 193023.8);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('13-04-2012', 'dd-mm-yyyy'), 'LZMTYSY02', 71216.4);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('13-04-2012', 'dd-mm-yyyy'), 'LZMTYSY03', 291402.8);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('25-04-2012', 'dd-mm-yyyy'), 'LZMTYSY03', 5105.9);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('25-04-2012', 'dd-mm-yyyy'), 'LZMTYSY01', 122601.8);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('25-04-2012', 'dd-mm-yyyy'), 'LZMTYSY02', 63333.5);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('26-04-2012', 'dd-mm-yyyy'), 'LZMTYSY01', 139581.6);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('26-04-2012', 'dd-mm-yyyy'), 'LZMTYSY03', 1723);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('26-04-2012', 'dd-mm-yyyy'), 'LZMTYSY02', 56645.9);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('08-04-2012', 'dd-mm-yyyy'), 'LZMTYSY01', 323575);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('08-04-2012', 'dd-mm-yyyy'), 'LZMTYSY02', 164358);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('08-04-2012', 'dd-mm-yyyy'), 'LZMTYSY03', 18682.8);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('09-04-2012', 'dd-mm-yyyy'), 'LZMTYSY03', 20721.6);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('09-04-2012', 'dd-mm-yyyy'), 'LZMTYSY02', 44628.7);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('09-04-2012', 'dd-mm-yyyy'), 'LZMTYSY01', 135669.9);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('10-04-2012', 'dd-mm-yyyy'), 'LZMTYSY01', 132082.1);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('10-04-2012', 'dd-mm-yyyy'), 'LZMTYSY03', 2337.5);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('10-04-2012', 'dd-mm-yyyy'), 'LZMTYSY02', 53877.8);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('11-04-2012', 'dd-mm-yyyy'), 'LZMTYSY02', 52900.5);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('11-04-2012', 'dd-mm-yyyy'), 'LZMTYSY03', 12387.2);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('11-04-2012', 'dd-mm-yyyy'), 'LZMTYSY01', 117375.7);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('12-04-2012', 'dd-mm-yyyy'), 'LZMTYSY03', 5194.7);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('12-04-2012', 'dd-mm-yyyy'), 'LZMTYSY01', 136655.6);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('12-04-2012', 'dd-mm-yyyy'), 'LZMTYSY02', 71901.4);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('14-04-2012', 'dd-mm-yyyy'), 'LZMTYSY01', 292875.1);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('14-04-2012', 'dd-mm-yyyy'), 'LZMTYSY02', 125080.8);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('14-04-2012', 'dd-mm-yyyy'), 'LZMTYSY03', 118924.4);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('15-04-2012', 'dd-mm-yyyy'), 'LZMTYSY03', 15212.9);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('15-04-2012', 'dd-mm-yyyy'), 'LZMTYSY02', 168416.6);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('15-04-2012', 'dd-mm-yyyy'), 'LZMTYSY01', 318217.1);
commit;
prompt 200 records committed...
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('16-04-2012', 'dd-mm-yyyy'), 'LZMTYSY01', 133322.6);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('16-04-2012', 'dd-mm-yyyy'), 'LZMTYSY02', 81041.7);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('16-04-2012', 'dd-mm-yyyy'), 'LZMTYSY03', 10170.9);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('17-04-2012', 'dd-mm-yyyy'), 'LZMTYSY02', 111709.1);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('17-04-2012', 'dd-mm-yyyy'), 'LZMTYSY01', 176526.7);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('17-04-2012', 'dd-mm-yyyy'), 'LZMTYSY03', 9174.8);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('18-04-2012', 'dd-mm-yyyy'), 'LZMTYSY02', 68712.8);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('18-04-2012', 'dd-mm-yyyy'), 'LZMTYSY03', 2402.6);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('18-04-2012', 'dd-mm-yyyy'), 'LZMTYSY01', 163733.9);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('19-04-2012', 'dd-mm-yyyy'), 'LZMTYSY03', 218262.3);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('19-04-2012', 'dd-mm-yyyy'), 'LZMTYSY01', 138072.6);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('19-04-2012', 'dd-mm-yyyy'), 'LZMTYSY02', 1247674.5);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('20-04-2012', 'dd-mm-yyyy'), 'LZMTYSY01', 166475.8);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('20-04-2012', 'dd-mm-yyyy'), 'LZMTYSY02', 57839.9);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('20-04-2012', 'dd-mm-yyyy'), 'LZMTYSY03', 11649.6);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('21-04-2012', 'dd-mm-yyyy'), 'LZMTYSY01', 277985.2);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('21-04-2012', 'dd-mm-yyyy'), 'LZMTYSY02', 107375);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('21-04-2012', 'dd-mm-yyyy'), 'LZMTYSY03', 18785.5);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('22-04-2012', 'dd-mm-yyyy'), 'LZMTYSY02', 128448.1);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('22-04-2012', 'dd-mm-yyyy'), 'LZMTYSY01', 288844.4);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('22-04-2012', 'dd-mm-yyyy'), 'LZMTYSY03', 29694.6);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('23-04-2012', 'dd-mm-yyyy'), 'LZMTYSY02', 45882.9);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('23-04-2012', 'dd-mm-yyyy'), 'LZMTYSY03', 7885.8);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('23-04-2012', 'dd-mm-yyyy'), 'LZMTYSY01', 126778.7);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('24-04-2012', 'dd-mm-yyyy'), 'LZMTYSY02', 61122.1);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('24-04-2012', 'dd-mm-yyyy'), 'LZMTYSY01', 131583.9);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('24-04-2012', 'dd-mm-yyyy'), 'LZMTYSY03', 8726.5);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('27-04-2012', 'dd-mm-yyyy'), 'LZMTYSY02', 48714.6);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('27-04-2012', 'dd-mm-yyyy'), 'LZMTYSY03', 6865.8);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('27-04-2012', 'dd-mm-yyyy'), 'LZMTYSY01', 153674.9);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('01-10-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 559173.7);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('23-03-2012', 'dd-mm-yyyy'), 'LZMTYSY01', 152000);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('11-07-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 94);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('02-10-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 504353.99);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('01-08-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 139.8);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('16-08-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 135405.4);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('18-01-2012', 'dd-mm-yyyy'), 'LZMTYSY01', 248896.97);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('12-08-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 15742.6);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('12-09-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 262529.4);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('22-09-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 89675);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('14-01-2012', 'dd-mm-yyyy'), 'LZMTYSY01', 385345.4);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('23-09-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 87767.2);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('07-10-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 338605.7);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('09-03-2012', 'dd-mm-yyyy'), 'LZMTYSY02', 103391.9);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('18-08-2011', 'dd-mm-yyyy'), 'LZMTYSY02', 95722.9);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('16-10-2011', 'dd-mm-yyyy'), 'LZMTYSY02', 219887.5);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('27-12-2011', 'dd-mm-yyyy'), 'LZMTYSY02', 109719.8);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('11-02-2012', 'dd-mm-yyyy'), 'LZMTYSY02', 204499.4);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('13-03-2012', 'dd-mm-yyyy'), 'LZMTYSY02', 55413.5);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('16-03-2012', 'dd-mm-yyyy'), 'LZMTYSY02', 105609.5);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('28-08-2011', 'dd-mm-yyyy'), 'LZMTYSY02', 90840.2);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('24-11-2011', 'dd-mm-yyyy'), 'LZMTYSY02', 109673.3);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('26-11-2011', 'dd-mm-yyyy'), 'LZMTYSY02', 205046);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('25-08-2011', 'dd-mm-yyyy'), 'LZMTYSY02', 117615.4);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('20-09-2011', 'dd-mm-yyyy'), 'LZMTYSY02', 44828.3);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('17-01-2012', 'dd-mm-yyyy'), 'LZMTYSY03', 38087.3);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('27-07-2011', 'dd-mm-yyyy'), 'LZMTYSY03', -20.6);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('15-10-2011', 'dd-mm-yyyy'), 'LZMTYSY03', -5889.2);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('03-04-2012', 'dd-mm-yyyy'), 'LZMTYSY03', 64064.9);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('05-08-2011', 'dd-mm-yyyy'), 'LZMTYSY03', -1);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('12-12-2011', 'dd-mm-yyyy'), 'LZMTYSY03', 49409.1);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('18-01-2012', 'dd-mm-yyyy'), 'LZMTYSY03', 59309.1);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('22-01-2012', 'dd-mm-yyyy'), 'LZMTYSY03', 12849.6);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('14-03-2012', 'dd-mm-yyyy'), 'LZMTYSY03', 5642.1);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('10-07-2011', 'dd-mm-yyyy'), 'LZMTYSY03', -66.8);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('22-11-2011', 'dd-mm-yyyy'), 'LZMTYSY03', 715.1);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('20-02-2012', 'dd-mm-yyyy'), 'LZMTYSY03', 10710.4);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('29-11-2011', 'dd-mm-yyyy'), 'LZMTYSY03', 15553.6);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('21-01-2012', 'dd-mm-yyyy'), 'LZMTYSY03', 73040.5);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('23-02-2012', 'dd-mm-yyyy'), 'LZMTYSY03', 10598.3);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('17-07-2011', 'dd-mm-yyyy'), 'LZMTYSY03', -68.8);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('18-09-2011', 'dd-mm-yyyy'), 'LZMTYSY03', -2871.4);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('08-03-2012', 'dd-mm-yyyy'), 'LZMTYSY03', 9095.2);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('18-03-2012', 'dd-mm-yyyy'), 'LZMTYSY03', 16655.8);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('06-01-2012', 'dd-mm-yyyy'), 'LZMTYSY01', 185908.3);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('17-02-2012', 'dd-mm-yyyy'), 'LZMTYSY01', 203548.2);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('22-08-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 134577.5);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('25-10-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 107598.3);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('01-02-2012', 'dd-mm-yyyy'), 'LZMTYSY01', 194551.5);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('02-03-2012', 'dd-mm-yyyy'), 'LZMTYSY01', 161547.8);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('26-08-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 148093.1);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('25-12-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 986317.7);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('28-01-2012', 'dd-mm-yyyy'), 'LZMTYSY01', 378309.8);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('19-11-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 311287.33);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('20-12-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 194377.2);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('16-02-2012', 'dd-mm-yyyy'), 'LZMTYSY01', 222572.1);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('17-10-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 130987.3);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('23-12-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 228082.2);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('17-08-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 116901.8);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('16-09-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 115069.4);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('06-11-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 365121.85);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('09-11-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 161024.3);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('08-02-2012', 'dd-mm-yyyy'), 'LZMTYSY01', 195938.2);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('24-02-2012', 'dd-mm-yyyy'), 'LZMTYSY01', 245168.5);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('15-03-2012', 'dd-mm-yyyy'), 'LZMTYSY01', 155245.6);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('22-03-2012', 'dd-mm-yyyy'), 'LZMTYSY01', 148241.4);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('13-07-2011', 'dd-mm-yyyy'), 'LZMTYSY02', -262.8);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('11-12-2011', 'dd-mm-yyyy'), 'LZMTYSY02', 614217.1);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('06-01-2012', 'dd-mm-yyyy'), 'LZMTYSY02', 80070.8);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('09-10-2011', 'dd-mm-yyyy'), 'LZMTYSY02', 102515.3);
commit;
prompt 300 records committed...
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('25-10-2011', 'dd-mm-yyyy'), 'LZMTYSY02', 71073.6);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('02-11-2011', 'dd-mm-yyyy'), 'LZMTYSY02', 109560.6);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('28-02-2012', 'dd-mm-yyyy'), 'LZMTYSY02', 53150.5);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('01-03-2012', 'dd-mm-yyyy'), 'LZMTYSY02', 55136);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('01-08-2011', 'dd-mm-yyyy'), 'LZMTYSY02', 630.8);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('14-11-2011', 'dd-mm-yyyy'), 'LZMTYSY02', 77476.1);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('12-12-2011', 'dd-mm-yyyy'), 'LZMTYSY02', 53752.4);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('08-01-2012', 'dd-mm-yyyy'), 'LZMTYSY02', 129720.2);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('07-08-2011', 'dd-mm-yyyy'), 'LZMTYSY02', 1979.6);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('12-11-2011', 'dd-mm-yyyy'), 'LZMTYSY02', 180477.6);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('10-12-2011', 'dd-mm-yyyy'), 'LZMTYSY02', 193806.8);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('24-12-2011', 'dd-mm-yyyy'), 'LZMTYSY02', 724138.3);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('11-09-2011', 'dd-mm-yyyy'), 'LZMTYSY02', 128657.4);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('28-10-2011', 'dd-mm-yyyy'), 'LZMTYSY02', 236550.8);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('24-09-2011', 'dd-mm-yyyy'), 'LZMTYSY02', 148055.7);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('28-11-2011', 'dd-mm-yyyy'), 'LZMTYSY02', 49855.4);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('28-09-2011', 'dd-mm-yyyy'), 'LZMTYSY02', 187644.2);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('10-08-2011', 'dd-mm-yyyy'), 'LZMTYSY02', 1318.8);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('23-09-2011', 'dd-mm-yyyy'), 'LZMTYSY02', 65681.4);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('30-09-2011', 'dd-mm-yyyy'), 'LZMTYSY02', 125967.5);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('06-11-2011', 'dd-mm-yyyy'), 'LZMTYSY02', 259587.7);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('30-12-2011', 'dd-mm-yyyy'), 'LZMTYSY02', 105850.9);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('07-01-2012', 'dd-mm-yyyy'), 'LZMTYSY03', 43239.8);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('07-02-2012', 'dd-mm-yyyy'), 'LZMTYSY03', 31166.7);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('25-10-2011', 'dd-mm-yyyy'), 'LZMTYSY03', 3199.1);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('01-04-2012', 'dd-mm-yyyy'), 'LZMTYSY03', 2739.5);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('09-09-2011', 'dd-mm-yyyy'), 'LZMTYSY03', -3813.1);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('02-01-2012', 'dd-mm-yyyy'), 'LZMTYSY03', 36861.9);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('12-01-2012', 'dd-mm-yyyy'), 'LZMTYSY03', 31580.3);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('18-08-2011', 'dd-mm-yyyy'), 'LZMTYSY03', -7316.9);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('17-12-2011', 'dd-mm-yyyy'), 'LZMTYSY03', 9309.4);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('29-08-2011', 'dd-mm-yyyy'), 'LZMTYSY03', -4175.6);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('31-10-2011', 'dd-mm-yyyy'), 'LZMTYSY03', 6963.6);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('31-01-2012', 'dd-mm-yyyy'), 'LZMTYSY03', 28574.7);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('28-09-2011', 'dd-mm-yyyy'), 'LZMTYSY03', -2862.6);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('19-12-2011', 'dd-mm-yyyy'), 'LZMTYSY03', 690509.5);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('20-03-2012', 'dd-mm-yyyy'), 'LZMTYSY03', 8437.9);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('29-03-2012', 'dd-mm-yyyy'), 'LZMTYSY03', 3933.6);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('29-09-2011', 'dd-mm-yyyy'), 'LZMTYSY03', 6539.2);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('06-02-2012', 'dd-mm-yyyy'), 'LZMTYSY03', 43624.3);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('04-10-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 356613.5);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('13-12-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 148909.62);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('24-08-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 203904.8);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('17-09-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 208108.9);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('07-11-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 132027.7);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('04-12-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 309358.3);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('14-03-2012', 'dd-mm-yyyy'), 'LZMTYSY01', 165518.1);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('06-12-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 163383.68);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('16-03-2012', 'dd-mm-yyyy'), 'LZMTYSY01', 182288.4);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('26-03-2012', 'dd-mm-yyyy'), 'LZMTYSY01', 134809.3);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('25-09-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 228485.2);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('28-10-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 258479.2);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('20-08-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 168530.2);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('27-08-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 226684.7);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('24-09-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 189026.7);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('28-11-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 137256.1);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('13-02-2012', 'dd-mm-yyyy'), 'LZMTYSY01', 231892.3);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('05-01-2012', 'dd-mm-yyyy'), 'LZMTYSY01', 164986.65);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('15-11-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 122293.4);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('15-02-2012', 'dd-mm-yyyy'), 'LZMTYSY02', 92194.6);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('23-03-2012', 'dd-mm-yyyy'), 'LZMTYSY02', 57040);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('11-07-2011', 'dd-mm-yyyy'), 'LZMTYSY02', 249.3);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('31-08-2011', 'dd-mm-yyyy'), 'LZMTYSY02', 50937.4);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('02-10-2011', 'dd-mm-yyyy'), 'LZMTYSY02', 2253635.9);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('11-03-2012', 'dd-mm-yyyy'), 'LZMTYSY02', 196404.5);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('03-04-2012', 'dd-mm-yyyy'), 'LZMTYSY02', 178865.3);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('18-01-2012', 'dd-mm-yyyy'), 'LZMTYSY02', 135276);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('12-02-2012', 'dd-mm-yyyy'), 'LZMTYSY02', 484761);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('27-02-2012', 'dd-mm-yyyy'), 'LZMTYSY02', 76545.5);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('07-03-2012', 'dd-mm-yyyy'), 'LZMTYSY02', 77527.9);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('25-09-2011', 'dd-mm-yyyy'), 'LZMTYSY02', 119396.2);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('24-01-2012', 'dd-mm-yyyy'), 'LZMTYSY02', 70936.1);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('10-03-2012', 'dd-mm-yyyy'), 'LZMTYSY02', 192686.5);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('04-11-2011', 'dd-mm-yyyy'), 'LZMTYSY02', 137015);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('20-03-2012', 'dd-mm-yyyy'), 'LZMTYSY02', 38255.1);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('31-03-2012', 'dd-mm-yyyy'), 'LZMTYSY02', 88646.1);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('30-01-2012', 'dd-mm-yyyy'), 'LZMTYSY03', 78437.9);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('17-02-2012', 'dd-mm-yyyy'), 'LZMTYSY03', 1421.7);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('11-08-2011', 'dd-mm-yyyy'), 'LZMTYSY03', -118.8);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('26-01-2012', 'dd-mm-yyyy'), 'LZMTYSY03', 13985.8);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('04-12-2011', 'dd-mm-yyyy'), 'LZMTYSY03', 239.2);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('13-10-2011', 'dd-mm-yyyy'), 'LZMTYSY03', -96.1);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('30-03-2012', 'dd-mm-yyyy'), 'LZMTYSY03', 55000.5);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('11-09-2011', 'dd-mm-yyyy'), 'LZMTYSY03', -1102.4);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('25-09-2011', 'dd-mm-yyyy'), 'LZMTYSY03', 16407.5);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('28-10-2011', 'dd-mm-yyyy'), 'LZMTYSY03', 12396.7);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('29-10-2011', 'dd-mm-yyyy'), 'LZMTYSY03', 678924.5);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('10-03-2012', 'dd-mm-yyyy'), 'LZMTYSY03', 11697.2);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('12-09-2011', 'dd-mm-yyyy'), 'LZMTYSY03', -3439.6);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('03-08-2011', 'dd-mm-yyyy'), 'LZMTYSY03', -88.4);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('15-09-2011', 'dd-mm-yyyy'), 'LZMTYSY03', 1667.2);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('04-11-2011', 'dd-mm-yyyy'), 'LZMTYSY03', 14612.4);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('05-01-2012', 'dd-mm-yyyy'), 'LZMTYSY03', 6432.9);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('16-09-2011', 'dd-mm-yyyy'), 'LZMTYSY03', -158.7);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('09-11-2011', 'dd-mm-yyyy'), 'LZMTYSY03', 8370);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('07-01-2012', 'dd-mm-yyyy'), 'LZMTYSY01', 311249.55);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('31-12-2011', 'dd-mm-yyyy'), 'LZMTYSY01', -74896209.9);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('15-01-2012', 'dd-mm-yyyy'), 'LZMTYSY01', 392264.45);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('28-02-2012', 'dd-mm-yyyy'), 'LZMTYSY01', 251937);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('01-03-2012', 'dd-mm-yyyy'), 'LZMTYSY01', 131216.9);
commit;
prompt 400 records committed...
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('01-04-2012', 'dd-mm-yyyy'), 'LZMTYSY01', 191590.7);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('22-01-2012', 'dd-mm-yyyy'), 'LZMTYSY01', 61248.5);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('09-12-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 146863.5);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('24-12-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 827096);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('27-09-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 110892.7);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('08-10-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 157706.85);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('28-12-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 152361.6);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('24-01-2012', 'dd-mm-yyyy'), 'LZMTYSY01', 230271.9);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('27-03-2012', 'dd-mm-yyyy'), 'LZMTYSY01', 177097.5);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('14-09-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 84807.1);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('10-02-2012', 'dd-mm-yyyy'), 'LZMTYSY01', 322098.8);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('30-12-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 219634.26);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('26-10-2011', 'dd-mm-yyyy'), 'LZMTYSY02', 69187.7);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('29-02-2012', 'dd-mm-yyyy'), 'LZMTYSY02', 99451.5);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('31-12-2011', 'dd-mm-yyyy'), 'LZMTYSY02', 162574.2);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('09-09-2011', 'dd-mm-yyyy'), 'LZMTYSY02', 54722.7);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('06-10-2011', 'dd-mm-yyyy'), 'LZMTYSY02', 251970.2);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('05-04-2012', 'dd-mm-yyyy'), 'LZMTYSY02', 133429);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('13-01-2012', 'dd-mm-yyyy'), 'LZMTYSY02', 89623.1);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('27-10-2011', 'dd-mm-yyyy'), 'LZMTYSY02', 77646.3);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('31-01-2012', 'dd-mm-yyyy'), 'LZMTYSY02', 71210.5);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('08-11-2011', 'dd-mm-yyyy'), 'LZMTYSY02', 124941.1);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('19-12-2011', 'dd-mm-yyyy'), 'LZMTYSY02', 93127.8);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('23-12-2011', 'dd-mm-yyyy'), 'LZMTYSY02', 172047.9);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('15-11-2011', 'dd-mm-yyyy'), 'LZMTYSY02', 29316.8);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('14-02-2012', 'dd-mm-yyyy'), 'LZMTYSY02', 465866.4);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('08-03-2012', 'dd-mm-yyyy'), 'LZMTYSY02', 367578.4);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('05-12-2011', 'dd-mm-yyyy'), 'LZMTYSY03', -2732.6);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('24-08-2011', 'dd-mm-yyyy'), 'LZMTYSY03', -23736.8);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('21-12-2011', 'dd-mm-yyyy'), 'LZMTYSY03', 9521.5);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('28-02-2012', 'dd-mm-yyyy'), 'LZMTYSY03', 5522.7);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('01-03-2012', 'dd-mm-yyyy'), 'LZMTYSY03', 6903.5);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('16-08-2011', 'dd-mm-yyyy'), 'LZMTYSY03', -7046.2);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('07-08-2011', 'dd-mm-yyyy'), 'LZMTYSY03', -162.8);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('03-09-2011', 'dd-mm-yyyy'), 'LZMTYSY03', -7286.2);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('03-11-2011', 'dd-mm-yyyy'), 'LZMTYSY03', 101657.7);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('18-11-2011', 'dd-mm-yyyy'), 'LZMTYSY03', 633922.8);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('06-12-2011', 'dd-mm-yyyy'), 'LZMTYSY03', -1208.6);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('25-12-2011', 'dd-mm-yyyy'), 'LZMTYSY03', 487966.5);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('24-11-2011', 'dd-mm-yyyy'), 'LZMTYSY03', 46178.1);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('13-01-2012', 'dd-mm-yyyy'), 'LZMTYSY03', 38751);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('27-08-2011', 'dd-mm-yyyy'), 'LZMTYSY03', -7338.6);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('03-01-2012', 'dd-mm-yyyy'), 'LZMTYSY03', 44833.8);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('29-01-2012', 'dd-mm-yyyy'), 'LZMTYSY03', 40822.7);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('04-02-2012', 'dd-mm-yyyy'), 'LZMTYSY03', 47445.4);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('06-08-2011', 'dd-mm-yyyy'), 'LZMTYSY03', -1067.3);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('20-07-2011', 'dd-mm-yyyy'), 'LZMTYSY03', -3.6);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('20-10-2011', 'dd-mm-yyyy'), 'LZMTYSY03', -403.9);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('14-02-2012', 'dd-mm-yyyy'), 'LZMTYSY03', 50001.5);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('04-08-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 213.1);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('25-07-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 351);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('30-08-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 131177.6);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('18-12-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 529915.2);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('25-03-2012', 'dd-mm-yyyy'), 'LZMTYSY01', 350918.2);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('08-09-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 113896.9);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('26-02-2012', 'dd-mm-yyyy'), 'LZMTYSY01', 405777.4);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('17-11-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 125627.91);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('21-11-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 142875.8);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('11-09-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 240196.8);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('27-01-2012', 'dd-mm-yyyy'), 'LZMTYSY01', 364007.83);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('03-01-2012', 'dd-mm-yyyy'), 'LZMTYSY01', 382905.9);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('22-10-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 257133.78);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('22-07-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 722.1);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('15-12-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 161128.53);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('18-10-2011', 'dd-mm-yyyy'), 'LZMTYSY02', 86995.7);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('04-03-2012', 'dd-mm-yyyy'), 'LZMTYSY02', 181749);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('01-04-2012', 'dd-mm-yyyy'), 'LZMTYSY02', 62840.4);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('03-10-2011', 'dd-mm-yyyy'), 'LZMTYSY02', 290847.2);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('12-10-2011', 'dd-mm-yyyy'), 'LZMTYSY02', 41250.5);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('14-03-2012', 'dd-mm-yyyy'), 'LZMTYSY02', 75335.3);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('05-02-2012', 'dd-mm-yyyy'), 'LZMTYSY02', 348403.9);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('17-03-2012', 'dd-mm-yyyy'), 'LZMTYSY02', 145345.4);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('08-08-2011', 'dd-mm-yyyy'), 'LZMTYSY02', 1413.1);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('20-02-2012', 'dd-mm-yyyy'), 'LZMTYSY02', 124647.1);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('21-08-2011', 'dd-mm-yyyy'), 'LZMTYSY02', 283825.5);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('16-02-2012', 'dd-mm-yyyy'), 'LZMTYSY02', 70171.6);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('14-01-2012', 'dd-mm-yyyy'), 'LZMTYSY02', 205521.4);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('24-03-2012', 'dd-mm-yyyy'), 'LZMTYSY02', 97933.5);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('29-03-2012', 'dd-mm-yyyy'), 'LZMTYSY02', 54168.1);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('07-12-2011', 'dd-mm-yyyy'), 'LZMTYSY02', 55666.1);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('04-01-2012', 'dd-mm-yyyy'), 'LZMTYSY02', 49668.6);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('26-10-2011', 'dd-mm-yyyy'), 'LZMTYSY03', 384);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('23-03-2012', 'dd-mm-yyyy'), 'LZMTYSY03', 6743.8);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('02-08-2011', 'dd-mm-yyyy'), 'LZMTYSY03', -104.1);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('31-08-2011', 'dd-mm-yyyy'), 'LZMTYSY03', -3122.8);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('07-11-2011', 'dd-mm-yyyy'), 'LZMTYSY03', 12936.6);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('14-11-2011', 'dd-mm-yyyy'), 'LZMTYSY03', -605.2);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('06-10-2011', 'dd-mm-yyyy'), 'LZMTYSY03', -3018);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('27-12-2011', 'dd-mm-yyyy'), 'LZMTYSY03', 13775.7);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('05-04-2012', 'dd-mm-yyyy'), 'LZMTYSY03', 7571.8);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('29-07-2011', 'dd-mm-yyyy'), 'LZMTYSY03', -56.4);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('27-09-2011', 'dd-mm-yyyy'), 'LZMTYSY03', 1692.3);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('27-11-2011', 'dd-mm-yyyy'), 'LZMTYSY03', 545498.1);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('22-10-2011', 'dd-mm-yyyy'), 'LZMTYSY03', 6073.4);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('10-01-2012', 'dd-mm-yyyy'), 'LZMTYSY03', 32762.9);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('19-02-2012', 'dd-mm-yyyy'), 'LZMTYSY03', 19876.9);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('31-03-2012', 'dd-mm-yyyy'), 'LZMTYSY03', 14247.9);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('06-09-2011', 'dd-mm-yyyy'), 'LZMTYSY03', -991);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('23-09-2011', 'dd-mm-yyyy'), 'LZMTYSY03', 96.4);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('11-11-2011', 'dd-mm-yyyy'), 'LZMTYSY03', 30713.9);
commit;
prompt 500 records committed...
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('04-01-2012', 'dd-mm-yyyy'), 'LZMTYSY03', 70883.9);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('08-02-2012', 'dd-mm-yyyy'), 'LZMTYSY03', 31241.7);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('17-01-2012', 'dd-mm-yyyy'), 'LZMTYSY01', 251770.1);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('09-10-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 181257.31);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('12-03-2012', 'dd-mm-yyyy'), 'LZMTYSY01', 155600.1);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('02-01-2012', 'dd-mm-yyyy'), 'LZMTYSY01', 408352.1);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('12-01-2012', 'dd-mm-yyyy'), 'LZMTYSY01', 239951.7);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('10-07-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 200);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('06-10-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 388216.5);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('11-02-2012', 'dd-mm-yyyy'), 'LZMTYSY01', 472095.4);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('07-03-2012', 'dd-mm-yyyy'), 'LZMTYSY01', 167093.2);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('30-03-2012', 'dd-mm-yyyy'), 'LZMTYSY01', 162494.8);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('29-07-2011', 'dd-mm-yyyy'), 'LZMTYSY01', -30.1);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('23-01-2012', 'dd-mm-yyyy'), 'LZMTYSY01', 176289.3);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('10-03-2012', 'dd-mm-yyyy'), 'LZMTYSY01', 332772.3);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('02-12-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 153191.02);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('20-01-2012', 'dd-mm-yyyy'), 'LZMTYSY01', 315424.3);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('04-02-2012', 'dd-mm-yyyy'), 'LZMTYSY01', 286673.2);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('23-02-2012', 'dd-mm-yyyy'), 'LZMTYSY01', 179837.62);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('01-11-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 219130.01);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('07-12-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 139108.4);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('04-01-2012', 'dd-mm-yyyy'), 'LZMTYSY01', 167619.2);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('17-01-2012', 'dd-mm-yyyy'), 'LZMTYSY02', 134374.6);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('11-08-2011', 'dd-mm-yyyy'), 'LZMTYSY02', 339.6);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('21-09-2011', 'dd-mm-yyyy'), 'LZMTYSY02', 84246.5);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('15-10-2011', 'dd-mm-yyyy'), 'LZMTYSY02', 93124.9);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('25-01-2012', 'dd-mm-yyyy'), 'LZMTYSY02', 71331.3);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('05-07-2011', 'dd-mm-yyyy'), 'LZMTYSY02', 0);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('26-09-2011', 'dd-mm-yyyy'), 'LZMTYSY02', 35136.5);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('02-01-2012', 'dd-mm-yyyy'), 'LZMTYSY02', 194756.5);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('13-10-2011', 'dd-mm-yyyy'), 'LZMTYSY02', 114786.5);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('22-11-2011', 'dd-mm-yyyy'), 'LZMTYSY02', 57010.4);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('25-12-2011', 'dd-mm-yyyy'), 'LZMTYSY02', 1392358.7);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('02-04-2012', 'dd-mm-yyyy'), 'LZMTYSY02', 137861.1);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('11-01-2012', 'dd-mm-yyyy'), 'LZMTYSY02', 55270.3);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('29-11-2011', 'dd-mm-yyyy'), 'LZMTYSY02', 55336.9);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('10-02-2012', 'dd-mm-yyyy'), 'LZMTYSY02', 140033.1);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('09-08-2011', 'dd-mm-yyyy'), 'LZMTYSY02', 110.6);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('16-09-2011', 'dd-mm-yyyy'), 'LZMTYSY02', 37496.5);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('20-10-2011', 'dd-mm-yyyy'), 'LZMTYSY02', 78433.4);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('11-11-2011', 'dd-mm-yyyy'), 'LZMTYSY02', 115695.4);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('30-07-2011', 'dd-mm-yyyy'), 'LZMTYSY03', -133);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('09-12-2011', 'dd-mm-yyyy'), 'LZMTYSY03', -1321.4);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('28-08-2011', 'dd-mm-yyyy'), 'LZMTYSY03', -9123.8);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('20-08-2011', 'dd-mm-yyyy'), 'LZMTYSY03', -13067.3);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('03-12-2011', 'dd-mm-yyyy'), 'LZMTYSY03', 6753);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('01-01-2012', 'dd-mm-yyyy'), 'LZMTYSY03', 32530.6);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('24-03-2012', 'dd-mm-yyyy'), 'LZMTYSY03', 37172.7);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('22-07-2011', 'dd-mm-yyyy'), 'LZMTYSY03', -104.5);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('04-09-2011', 'dd-mm-yyyy'), 'LZMTYSY03', -6275.7);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('10-09-2011', 'dd-mm-yyyy'), 'LZMTYSY03', 3294.8);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('24-02-2012', 'dd-mm-yyyy'), 'LZMTYSY03', -906.8);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('31-08-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 135680.5);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('25-01-2012', 'dd-mm-yyyy'), 'LZMTYSY01', 301780.7);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('19-08-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 109874.4);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('03-11-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 150818);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('31-07-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 33.2);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('09-01-2012', 'dd-mm-yyyy'), 'LZMTYSY01', 186885.9);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('11-01-2012', 'dd-mm-yyyy'), 'LZMTYSY01', 196409.8);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('21-08-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 260893.3);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('01-09-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 105441.8);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('10-10-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 95597.74);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('27-11-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 349900.7);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('03-08-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 358.6);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('21-07-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 105);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('31-03-2012', 'dd-mm-yyyy'), 'LZMTYSY01', 176273.5);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('29-03-2012', 'dd-mm-yyyy'), 'LZMTYSY01', 134887.3);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('17-07-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 200);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('06-09-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 92378.8);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('14-10-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 156352.4);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('06-02-2012', 'dd-mm-yyyy'), 'LZMTYSY01', 199632.4);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('18-03-2012', 'dd-mm-yyyy'), 'LZMTYSY01', 324663.82);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('14-12-2011', 'dd-mm-yyyy'), 'LZMTYSY02', 56829.7);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('17-02-2012', 'dd-mm-yyyy'), 'LZMTYSY02', 48394);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('25-03-2012', 'dd-mm-yyyy'), 'LZMTYSY02', 141371.7);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('19-03-2012', 'dd-mm-yyyy'), 'LZMTYSY02', 43912.2);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('22-02-2012', 'dd-mm-yyyy'), 'LZMTYSY02', 29775.5);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('12-01-2012', 'dd-mm-yyyy'), 'LZMTYSY02', 74597);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('30-07-2011', 'dd-mm-yyyy'), 'LZMTYSY02', 501.9);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('26-12-2011', 'dd-mm-yyyy'), 'LZMTYSY02', 111917.7);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('05-09-2011', 'dd-mm-yyyy'), 'LZMTYSY02', 40615.4);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('20-11-2011', 'dd-mm-yyyy'), 'LZMTYSY02', 173679.7);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('01-09-2011', 'dd-mm-yyyy'), 'LZMTYSY02', 65608.8);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('21-07-2011', 'dd-mm-yyyy'), 'LZMTYSY02', 206.5);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('10-01-2012', 'dd-mm-yyyy'), 'LZMTYSY02', 79840.7);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('20-01-2012', 'dd-mm-yyyy'), 'LZMTYSY02', 137395);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('15-03-2012', 'dd-mm-yyyy'), 'LZMTYSY02', 122464.8);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('21-10-2011', 'dd-mm-yyyy'), 'LZMTYSY03', -711.5);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('04-03-2012', 'dd-mm-yyyy'), 'LZMTYSY03', 11402.7);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('12-03-2012', 'dd-mm-yyyy'), 'LZMTYSY03', 6521);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('19-08-2011', 'dd-mm-yyyy'), 'LZMTYSY03', 37618.7);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('15-07-2011', 'dd-mm-yyyy'), 'LZMTYSY03', -36);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('16-10-2011', 'dd-mm-yyyy'), 'LZMTYSY03', 3189.5);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('28-01-2012', 'dd-mm-yyyy'), 'LZMTYSY03', 23365.8);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('21-02-2012', 'dd-mm-yyyy'), 'LZMTYSY03', 5649.1);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('08-10-2011', 'dd-mm-yyyy'), 'LZMTYSY03', 2242.9);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('09-01-2012', 'dd-mm-yyyy'), 'LZMTYSY03', 29629.4);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('12-07-2011', 'dd-mm-yyyy'), 'LZMTYSY03', -.6);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('27-10-2011', 'dd-mm-yyyy'), 'LZMTYSY03', 676);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('02-12-2011', 'dd-mm-yyyy'), 'LZMTYSY03', 3207.4);
commit;
prompt 600 records committed...
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('28-11-2011', 'dd-mm-yyyy'), 'LZMTYSY03', 195949);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('16-02-2012', 'dd-mm-yyyy'), 'LZMTYSY03', 12114);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('30-09-2011', 'dd-mm-yyyy'), 'LZMTYSY03', -2780.9);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('27-07-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 742.7);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('13-11-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 345144.5);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('16-01-2012', 'dd-mm-yyyy'), 'LZMTYSY01', 228144.2);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('22-02-2012', 'dd-mm-yyyy'), 'LZMTYSY01', 188671.2);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('09-09-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 113519);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('17-12-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 332008.81);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('24-10-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 108492.5);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('20-11-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 319256.9);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('22-12-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 179786.28);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('31-10-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 251673.98);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('05-03-2012', 'dd-mm-yyyy'), 'LZMTYSY01', 139629.1);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('18-07-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 671.4);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('08-12-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 132164.5);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('20-07-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 110);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('18-12-2011', 'dd-mm-yyyy'), 'LZMTYSY02', 313328.6);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('02-08-2011', 'dd-mm-yyyy'), 'LZMTYSY02', 168.7);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('22-08-2011', 'dd-mm-yyyy'), 'LZMTYSY02', 76363.7);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('19-01-2012', 'dd-mm-yyyy'), 'LZMTYSY02', 89458.1);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('02-03-2012', 'dd-mm-yyyy'), 'LZMTYSY02', 59340.8);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('29-08-2011', 'dd-mm-yyyy'), 'LZMTYSY02', 51926.2);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('08-10-2011', 'dd-mm-yyyy'), 'LZMTYSY02', 68038);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('02-12-2011', 'dd-mm-yyyy'), 'LZMTYSY02', 62924.1);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('03-01-2012', 'dd-mm-yyyy'), 'LZMTYSY02', 195489.5);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('29-01-2012', 'dd-mm-yyyy'), 'LZMTYSY02', 107046.4);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('21-03-2012', 'dd-mm-yyyy'), 'LZMTYSY02', 27256.9);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('15-09-2011', 'dd-mm-yyyy'), 'LZMTYSY02', 45163.4);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('17-10-2011', 'dd-mm-yyyy'), 'LZMTYSY02', 78030);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('23-02-2012', 'dd-mm-yyyy'), 'LZMTYSY02', 50653.6);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('06-01-2012', 'dd-mm-yyyy'), 'LZMTYSY03', 48863);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('25-11-2011', 'dd-mm-yyyy'), 'LZMTYSY03', 8922.1);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('24-12-2011', 'dd-mm-yyyy'), 'LZMTYSY03', 164216.3);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('05-02-2012', 'dd-mm-yyyy'), 'LZMTYSY03', 96102.6);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('18-02-2012', 'dd-mm-yyyy'), 'LZMTYSY03', 12163.8);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('28-12-2011', 'dd-mm-yyyy'), 'LZMTYSY03', 29656.5);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('09-08-2011', 'dd-mm-yyyy'), 'LZMTYSY03', -198.9);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('07-12-2011', 'dd-mm-yyyy'), 'LZMTYSY03', 2674.9);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('29-12-2011', 'dd-mm-yyyy'), 'LZMTYSY03', 13618.3);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('02-09-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 145074.2);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('19-03-2012', 'dd-mm-yyyy'), 'LZMTYSY01', 133772.2);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('10-11-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 160571.54);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('26-01-2012', 'dd-mm-yyyy'), 'LZMTYSY01', 396937.53);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('09-02-2012', 'dd-mm-yyyy'), 'LZMTYSY01', 188714.5);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('11-03-2012', 'dd-mm-yyyy'), 'LZMTYSY01', 343610.1);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('18-08-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 127539.6);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('16-10-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 260174.86);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('21-02-2012', 'dd-mm-yyyy'), 'LZMTYSY01', 235580.3);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('08-08-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 1231.2);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('29-10-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 424952.9);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('20-02-2012', 'dd-mm-yyyy'), 'LZMTYSY01', 216217.6);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('15-09-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 80160.8);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('01-12-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 152544.7);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('19-12-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 232070.4);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('10-01-2012', 'dd-mm-yyyy'), 'LZMTYSY01', 194517.77);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('19-02-2012', 'dd-mm-yyyy'), 'LZMTYSY01', 428654.05);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('18-09-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 220343.3);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('30-11-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 179563.82);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('14-02-2012', 'dd-mm-yyyy'), 'LZMTYSY01', 772230.88);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('13-11-2011', 'dd-mm-yyyy'), 'LZMTYSY02', 237309.3);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('21-12-2011', 'dd-mm-yyyy'), 'LZMTYSY02', 104565.5);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('15-01-2012', 'dd-mm-yyyy'), 'LZMTYSY02', 229963.1);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('16-08-2011', 'dd-mm-yyyy'), 'LZMTYSY02', 70904.3);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('19-08-2011', 'dd-mm-yyyy'), 'LZMTYSY02', 58513.7);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('26-08-2011', 'dd-mm-yyyy'), 'LZMTYSY02', 91555.7);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('30-03-2012', 'dd-mm-yyyy'), 'LZMTYSY02', 60665.2);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('28-12-2011', 'dd-mm-yyyy'), 'LZMTYSY02', 97695.8);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('13-02-2012', 'dd-mm-yyyy'), 'LZMTYSY02', 211797.8);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('03-08-2011', 'dd-mm-yyyy'), 'LZMTYSY02', 974);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('05-01-2012', 'dd-mm-yyyy'), 'LZMTYSY02', 154426.1);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('06-09-2011', 'dd-mm-yyyy'), 'LZMTYSY02', 57624.5);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('18-09-2011', 'dd-mm-yyyy'), 'LZMTYSY02', 93427.4);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('15-12-2011', 'dd-mm-yyyy'), 'LZMTYSY02', 36324.7);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('16-12-2011', 'dd-mm-yyyy'), 'LZMTYSY02', 126443.4);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('23-07-2011', 'dd-mm-yyyy'), 'LZMTYSY03', -30);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('15-08-2011', 'dd-mm-yyyy'), 'LZMTYSY03', -8552.9);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('04-10-2011', 'dd-mm-yyyy'), 'LZMTYSY03', -3572.4);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('29-02-2012', 'dd-mm-yyyy'), 'LZMTYSY03', 962.4);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('25-03-2012', 'dd-mm-yyyy'), 'LZMTYSY03', 8970);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('23-08-2011', 'dd-mm-yyyy'), 'LZMTYSY03', -5643.8);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('02-10-2011', 'dd-mm-yyyy'), 'LZMTYSY03', 33765.3);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('16-11-2011', 'dd-mm-yyyy'), 'LZMTYSY03', 2004.4);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('16-01-2012', 'dd-mm-yyyy'), 'LZMTYSY03', 46880.1);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('25-01-2012', 'dd-mm-yyyy'), 'LZMTYSY03', 72482.5);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('03-02-2012', 'dd-mm-yyyy'), 'LZMTYSY03', 19355.2);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('01-08-2011', 'dd-mm-yyyy'), 'LZMTYSY03', -16.6);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('30-10-2011', 'dd-mm-yyyy'), 'LZMTYSY03', 22210.7);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('12-02-2012', 'dd-mm-yyyy'), 'LZMTYSY03', 20616.6);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('02-04-2012', 'dd-mm-yyyy'), 'LZMTYSY03', 4427.4);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('24-01-2012', 'dd-mm-yyyy'), 'LZMTYSY03', 21535.7);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('10-10-2011', 'dd-mm-yyyy'), 'LZMTYSY03', -1676.7);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('23-10-2011', 'dd-mm-yyyy'), 'LZMTYSY03', 2366.2);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('21-07-2011', 'dd-mm-yyyy'), 'LZMTYSY03', -1.8);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('14-10-2011', 'dd-mm-yyyy'), 'LZMTYSY03', 432.4);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('15-12-2011', 'dd-mm-yyyy'), 'LZMTYSY03', 169515);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('22-03-2012', 'dd-mm-yyyy'), 'LZMTYSY03', 3121.6);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('15-08-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 149343.3);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('07-09-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 108046.7);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('07-02-2012', 'dd-mm-yyyy'), 'LZMTYSY01', 216039.5);
commit;
prompt 700 records committed...
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('29-02-2012', 'dd-mm-yyyy'), 'LZMTYSY01', 186015.7);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('18-10-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 114602.2);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('05-07-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 0);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('26-09-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 92456.58);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('03-10-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 441918.28);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('12-10-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 110424.98);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('19-01-2012', 'dd-mm-yyyy'), 'LZMTYSY01', 284543.39);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('15-07-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 199);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('24-11-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 164679.04);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('14-08-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 161934.7);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('20-09-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 98595.7);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('29-11-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 248653.92);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('04-04-2012', 'dd-mm-yyyy'), 'LZMTYSY01', 461261.9);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('26-01-2012', 'dd-mm-yyyy'), 'LZMTYSY02', 87288.6);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('28-01-2012', 'dd-mm-yyyy'), 'LZMTYSY02', 121316.9);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('21-02-2012', 'dd-mm-yyyy'), 'LZMTYSY02', 121967.3);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('26-03-2012', 'dd-mm-yyyy'), 'LZMTYSY02', 88457.9);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('12-07-2011', 'dd-mm-yyyy'), 'LZMTYSY02', 262.8);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('31-10-2011', 'dd-mm-yyyy'), 'LZMTYSY02', 120131.3);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('27-11-2011', 'dd-mm-yyyy'), 'LZMTYSY02', 215922.2);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('20-12-2011', 'dd-mm-yyyy'), 'LZMTYSY02', 102725.5);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('19-07-2011', 'dd-mm-yyyy'), 'LZMTYSY02', 455.7);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('30-11-2011', 'dd-mm-yyyy'), 'LZMTYSY02', 95149.9);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('01-10-2011', 'dd-mm-yyyy'), 'LZMTYSY03', 19113.8);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('19-03-2012', 'dd-mm-yyyy'), 'LZMTYSY03', 8994.7);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('01-02-2012', 'dd-mm-yyyy'), 'LZMTYSY03', 9196);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('05-11-2011', 'dd-mm-yyyy'), 'LZMTYSY03', 15551.6);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('08-01-2012', 'dd-mm-yyyy'), 'LZMTYSY03', 51992.2);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('02-02-2012', 'dd-mm-yyyy'), 'LZMTYSY03', 11304.5);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('19-10-2011', 'dd-mm-yyyy'), 'LZMTYSY03', 779.1);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('16-03-2012', 'dd-mm-yyyy'), 'LZMTYSY03', 9500.9);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('22-12-2011', 'dd-mm-yyyy'), 'LZMTYSY03', 12150.6);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('28-03-2012', 'dd-mm-yyyy'), 'LZMTYSY03', 5719.4);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('14-08-2011', 'dd-mm-yyyy'), 'LZMTYSY03', -8490.6);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('14-09-2011', 'dd-mm-yyyy'), 'LZMTYSY03', 678.3);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('01-11-2011', 'dd-mm-yyyy'), 'LZMTYSY03', 38426);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('21-10-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 129645.9);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('05-12-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 148109.1);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('15-02-2012', 'dd-mm-yyyy'), 'LZMTYSY01', 221198);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('21-09-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 94309.4);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('16-11-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 145505.7);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('03-04-2012', 'dd-mm-yyyy'), 'LZMTYSY01', 441537.6);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('05-11-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 321986.09);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('14-11-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 112935.58);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('06-04-2012', 'dd-mm-yyyy'), 'LZMTYSY01', 400);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('13-10-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 115489.2);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('22-11-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 140360.3);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('26-12-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 190621.68);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('06-03-2012', 'dd-mm-yyyy'), 'LZMTYSY01', 150484.6);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('26-11-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 287908.35);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('28-03-2012', 'dd-mm-yyyy'), 'LZMTYSY01', 176665.7);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('13-09-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 92406.5);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('04-11-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 158267.4);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('08-11-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 162376);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('21-01-2012', 'dd-mm-yyyy'), 'LZMTYSY01', 348875.12);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('19-07-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 666.5);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('15-08-2011', 'dd-mm-yyyy'), 'LZMTYSY02', 72529.6);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('07-02-2012', 'dd-mm-yyyy'), 'LZMTYSY02', 86393.7);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('24-08-2011', 'dd-mm-yyyy'), 'LZMTYSY02', 96403.7);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('30-10-2011', 'dd-mm-yyyy'), 'LZMTYSY02', 365245.9);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('04-12-2011', 'dd-mm-yyyy'), 'LZMTYSY02', 142225);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('22-01-2012', 'dd-mm-yyyy'), 'LZMTYSY02', 43845);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('18-11-2011', 'dd-mm-yyyy'), 'LZMTYSY02', 584789.4);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('06-03-2012', 'dd-mm-yyyy'), 'LZMTYSY02', 56017.8);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('29-10-2011', 'dd-mm-yyyy'), 'LZMTYSY02', 404879.2);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('22-12-2011', 'dd-mm-yyyy'), 'LZMTYSY02', 569555.5);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('27-08-2011', 'dd-mm-yyyy'), 'LZMTYSY02', 96656.4);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('22-09-2011', 'dd-mm-yyyy'), 'LZMTYSY02', 31038.1);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('10-10-2011', 'dd-mm-yyyy'), 'LZMTYSY02', 34954.7);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('13-09-2011', 'dd-mm-yyyy'), 'LZMTYSY02', 23392.1);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('04-04-2012', 'dd-mm-yyyy'), 'LZMTYSY02', 209752.1);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('07-10-2011', 'dd-mm-yyyy'), 'LZMTYSY02', 202597.5);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('06-02-2012', 'dd-mm-yyyy'), 'LZMTYSY02', 54569.6);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('08-02-2012', 'dd-mm-yyyy'), 'LZMTYSY02', 50562.9);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('11-12-2011', 'dd-mm-yyyy'), 'LZMTYSY03', 117475.9);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('17-09-2011', 'dd-mm-yyyy'), 'LZMTYSY03', -1808.9);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('02-11-2011', 'dd-mm-yyyy'), 'LZMTYSY03', 15571.6);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('15-01-2012', 'dd-mm-yyyy'), 'LZMTYSY03', 71668.4);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('27-02-2012', 'dd-mm-yyyy'), 'LZMTYSY03', 1343.4);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('12-11-2011', 'dd-mm-yyyy'), 'LZMTYSY03', 21628.1);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('26-12-2011', 'dd-mm-yyyy'), 'LZMTYSY03', 44670.2);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('06-03-2012', 'dd-mm-yyyy'), 'LZMTYSY03', 13522);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('24-10-2011', 'dd-mm-yyyy'), 'LZMTYSY03', -1058.7);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('20-11-2011', 'dd-mm-yyyy'), 'LZMTYSY03', 2826.1);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('17-10-2011', 'dd-mm-yyyy'), 'LZMTYSY03', 410.1);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('10-08-2011', 'dd-mm-yyyy'), 'LZMTYSY03', -97.1);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('06-11-2011', 'dd-mm-yyyy'), 'LZMTYSY03', 23014.1);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('15-03-2012', 'dd-mm-yyyy'), 'LZMTYSY03', 15099.2);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('05-10-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 340950.82);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('02-08-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 580.5);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('03-02-2012', 'dd-mm-yyyy'), 'LZMTYSY01', 203140.8);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('02-02-2012', 'dd-mm-yyyy'), 'LZMTYSY01', 185907.6);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('07-08-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 960.8);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('19-09-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 93945.4);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('19-10-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 104752.01);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('17-03-2012', 'dd-mm-yyyy'), 'LZMTYSY01', 270160.45);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('28-08-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 238124.2);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('12-07-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 135);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('28-07-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 45);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('27-10-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 125808.1);
commit;
prompt 800 records committed...
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('23-11-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 169489.77);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('01-01-2012', 'dd-mm-yyyy'), 'LZMTYSY01', 496361.78);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('31-01-2012', 'dd-mm-yyyy'), 'LZMTYSY01', 243435.4);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('21-03-2012', 'dd-mm-yyyy'), 'LZMTYSY01', 127568);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('10-09-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 211324.3);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('30-09-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 266656.8);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('20-10-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 186981.8);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('30-08-2011', 'dd-mm-yyyy'), 'LZMTYSY02', 43362.8);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('01-10-2011', 'dd-mm-yyyy'), 'LZMTYSY02', 405456.1);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('07-01-2012', 'dd-mm-yyyy'), 'LZMTYSY02', 107142.3);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('07-11-2011', 'dd-mm-yyyy'), 'LZMTYSY02', 96274.3);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('27-09-2011', 'dd-mm-yyyy'), 'LZMTYSY02', 232634.7);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('11-10-2011', 'dd-mm-yyyy'), 'LZMTYSY02', 33300.1);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('23-01-2012', 'dd-mm-yyyy'), 'LZMTYSY02', 37649.2);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('26-07-2011', 'dd-mm-yyyy'), 'LZMTYSY02', 344.1);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('19-11-2011', 'dd-mm-yyyy'), 'LZMTYSY02', 174135.6);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('04-02-2012', 'dd-mm-yyyy'), 'LZMTYSY02', 203926);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('19-02-2012', 'dd-mm-yyyy'), 'LZMTYSY02', 144706);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('24-02-2012', 'dd-mm-yyyy'), 'LZMTYSY02', 69899.3);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('05-10-2011', 'dd-mm-yyyy'), 'LZMTYSY03', 26483.3);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('18-12-2011', 'dd-mm-yyyy'), 'LZMTYSY03', 714302.4);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('22-08-2011', 'dd-mm-yyyy'), 'LZMTYSY03', -6042.6);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('21-09-2011', 'dd-mm-yyyy'), 'LZMTYSY03', -1728);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('09-02-2012', 'dd-mm-yyyy'), 'LZMTYSY03', 26700.7);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('22-02-2012', 'dd-mm-yyyy'), 'LZMTYSY03', 4103.5);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('26-02-2012', 'dd-mm-yyyy'), 'LZMTYSY03', 8498.9);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('11-03-2012', 'dd-mm-yyyy'), 'LZMTYSY03', 13367);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('19-01-2012', 'dd-mm-yyyy'), 'LZMTYSY03', 99088.8);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('07-07-2011', 'dd-mm-yyyy'), 'LZMTYSY03', 0);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('07-03-2012', 'dd-mm-yyyy'), 'LZMTYSY03', 6403.9);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('27-01-2012', 'dd-mm-yyyy'), 'LZMTYSY03', 18900.7);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('01-09-2011', 'dd-mm-yyyy'), 'LZMTYSY03', -4041.8);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('20-01-2012', 'dd-mm-yyyy'), 'LZMTYSY03', 56500.5);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('04-04-2012', 'dd-mm-yyyy'), 'LZMTYSY03', 9187.4);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('23-08-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 145775.3);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('15-10-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 236158.63);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('21-12-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 210552.52);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('12-12-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 165161.69);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('12-02-2012', 'dd-mm-yyyy'), 'LZMTYSY01', 494636.5);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('10-12-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 267024.87);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('27-12-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 174413.2);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('05-02-2012', 'dd-mm-yyyy'), 'LZMTYSY01', 339088.1);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('05-09-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 109956.9);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('23-10-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 254023.36);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('28-09-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 241766.05);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('09-08-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 1120.1);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('29-09-2011', 'dd-mm-yyyy'), 'LZMTYSY01', 137015.7);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('05-10-2011', 'dd-mm-yyyy'), 'LZMTYSY02', 154630.4);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('21-10-2011', 'dd-mm-yyyy'), 'LZMTYSY02', 98383.3);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('12-03-2012', 'dd-mm-yyyy'), 'LZMTYSY02', 70007);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('03-11-2011', 'dd-mm-yyyy'), 'LZMTYSY02', 104722.6);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('25-11-2011', 'dd-mm-yyyy'), 'LZMTYSY02', 160867.9);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('21-11-2011', 'dd-mm-yyyy'), 'LZMTYSY02', 69631);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('06-12-2011', 'dd-mm-yyyy'), 'LZMTYSY02', 80511.9);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('27-01-2012', 'dd-mm-yyyy'), 'LZMTYSY02', 87134);
insert into SALE_MALL (STORECODE, TIME, SALETYPECODE, SALE)
values ('00001', to_date('01-01-2012', 'dd-mm-yyyy'), 'LZMTYSY02', 537089);
commit;
prompt 856 records loaded
prompt Loading STORE...
insert into STORE (STORECODE, STORENAME, REGIONCODE, BUSRANGECODE)
values ('00001', '鹏瑞利长峰购物中心', 'SY', 'LZMTYSY');
insert into STORE (STORECODE, STORENAME, REGIONCODE, BUSRANGECODE)
values ('00002', 'yes百货', 'SY', 'LZMTYSY');
insert into STORE (STORECODE, STORENAME, REGIONCODE, BUSRANGECODE)
values ('00003', '龙之梦红星美凯龙', 'SY', 'HXMKL');
insert into STORE (STORECODE, STORENAME, REGIONCODE, BUSRANGECODE)
values ('00004', '龙之梦丽晶大酒店', 'SY', 'JD');
insert into STORE (STORECODE, STORENAME, REGIONCODE, BUSRANGECODE)
values ('00005', '龙之梦百味餐饮公司', 'SY', 'CY');
insert into STORE (STORECODE, STORENAME, REGIONCODE, BUSRANGECODE)
values ('00006', '龙悦冰场', 'SY', 'YL');
insert into STORE (STORECODE, STORENAME, REGIONCODE, BUSRANGECODE)
values ('00007', '辛巴达游乐场', 'SY', 'YL');
commit;
prompt 7 records loaded
prompt Enabling triggers for BUSRANGE...
alter table BUSRANGE enable all triggers;
prompt Enabling triggers for BUSRANGESALETYPE...
alter table BUSRANGESALETYPE enable all triggers;
prompt Enabling triggers for REGION...
alter table REGION enable all triggers;
prompt Enabling triggers for SALE_INTRA...
alter table SALE_INTRA enable all triggers;
prompt Enabling triggers for SALE_MALL...
alter table SALE_MALL enable all triggers;
prompt Enabling triggers for STORE...
alter table STORE enable all triggers;
set feedback on
set define on
prompt Done.
