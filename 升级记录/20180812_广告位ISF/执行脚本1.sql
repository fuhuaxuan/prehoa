---权限执行脚本
declare
  v_EntGid  varchar2(32);
begin
select Gid into v_EntGid from Ent where Lower(code) = Lower('prlintra'); 
--新增模块权限
delete from rt where id in ('prlgg_groundh_add','prlgg_groundh_addsave','prlgg_groundh_mod','prlgg_groundh_modsave','prlgg_groundh_del','prlgg_groundh_list','prlgg_groundh_dtl','prlgg_groundh_down','prlgg_groundh_import','prlgg_groundh_importsave');

insert into rt(id,name,atype,alevel,url,aorder,memo) values('prlgg_groundh_add','地理位置新增','广告位地理位置','30','/bin/hdnet.dll/__explainmodule?url=prlgg_groundh_add','800601','地理位置新增');
insert into rt(id,name,atype,alevel,url,aorder,memo) values('prlgg_groundh_addsave','地理位置新增','广告位地理位置','30','/bin/hdnet.dll/__explainmodule?url=prlgg_groundh_addsave','800602','地理位置新增保存');
insert into rt(id,name,atype,alevel,url,aorder,memo) values('prlgg_groundh_mod','地理位置修改','广告位地理位置','30','/bin/hdnet.dll/__explainmodule?url=prlgg_groundh_mod','800603','地理位置修改');
insert into rt(id,name,atype,alevel,url,aorder,memo) values('prlgg_groundh_modsave','地理位置修改','广告位地理位置','30','/bin/hdnet.dll/__explainmodule?url=prlgg_groundh_modsave','800604','地理位置修改保存');
insert into rt(id,name,atype,alevel,url,aorder,memo) values('prlgg_groundh_del','地理位置删除','广告位地理位置','30','/bin/hdnet.dll/__explainmodule?url=prlgg_groundh_del','800605','地理位置删除');
insert into rt(id,name,atype,alevel,url,aorder,memo) values('prlgg_groundh_list','地理位置查看','广告位地理位置','30','/bin/hdnet.dll/__explainmodule?url=prlgg_groundh_list','800606','地理位置列表');
insert into rt(id,name,atype,alevel,url,aorder,memo) values('prlgg_groundh_dtl','地理位置查看','广告位地理位置','30','/bin/hdnet.dll/__explainmodule?url=prlgg_groundh_dtl','800607','地理位置明细');
insert into rt(id,name,atype,alevel,url,aorder,memo) values('prlgg_groundh_down','地理位置导出','广告位地理位置','30','/bin/hdnet.dll/__explainmodule?url=prlgg_groundh_down','800608','地理位置导出');
insert into rt(id,name,atype,alevel,url,aorder,memo) values('prlgg_groundh_import','地理位置导入','广告位地理位置','30','/bin/hdnet.dll/__explainmodule?url=prlgg_groundh_import','800609','地理位置导入');
insert into rt(id,name,atype,alevel,url,aorder,memo) values('prlgg_groundh_importsave','地理位置导入','广告位地理位置','30','/bin/hdnet.dll/__explainmodule?url=prlgg_groundh_importsave','800610','地理位置导入保存');

--将权限默认给管理员组
--插入企业权限
delete from ent_rt where entgid = v_EntGid and rtid in ('prlgg_groundh_add','prlgg_groundh_addsave','prlgg_groundh_mod','prlgg_groundh_modsave','prlgg_groundh_del','prlgg_groundh_list','prlgg_groundh_dtl','prlgg_groundh_down','prlgg_groundh_import','prlgg_groundh_importsave');
insert into ent_rt select v_EntGid , id from rt where id in ('prlgg_groundh_add','prlgg_groundh_addsave','prlgg_groundh_mod','prlgg_groundh_modsave','prlgg_groundh_del','prlgg_groundh_list','prlgg_groundh_dtl','prlgg_groundh_down','prlgg_groundh_import','prlgg_groundh_importsave');

--插入管理员权限
delete from org_rt where entgid = v_EntGid and rtid in ('prlgg_groundh_add','prlgg_groundh_addsave','prlgg_groundh_mod','prlgg_groundh_modsave','prlgg_groundh_del','prlgg_groundh_list','prlgg_groundh_dtl','prlgg_groundh_down','prlgg_groundh_import','prlgg_groundh_importsave');
insert into org_rt select v_EntGid ,org.gid , rt.id,'10' from org, rt where org.entgid = v_EntGid and lower(org.code) = lower('admin_grp') and rt.id in ('prlgg_groundh_add','prlgg_groundh_addsave','prlgg_groundh_mod','prlgg_groundh_modsave','prlgg_groundh_del','prlgg_groundh_list','prlgg_groundh_dtl','prlgg_groundh_down','prlgg_groundh_import','prlgg_groundh_importsave');

--插入组织所有权限表
delete from org_rt_all where entgid = v_EntGid and rtid in ('prlgg_groundh_add','prlgg_groundh_addsave','prlgg_groundh_mod','prlgg_groundh_modsave','prlgg_groundh_del','prlgg_groundh_list','prlgg_groundh_dtl','prlgg_groundh_down','prlgg_groundh_import','prlgg_groundh_importsave');
insert into org_rt_all select v_EntGid ,org.gid , rt.id,'10' from org, rt where org.entgid = v_EntGid and lower(org.code) = lower('admin_grp') and rt.id in ('prlgg_groundh_add','prlgg_groundh_addsave','prlgg_groundh_mod','prlgg_groundh_modsave','prlgg_groundh_del','prlgg_groundh_list','prlgg_groundh_dtl','prlgg_groundh_down','prlgg_groundh_import','prlgg_groundh_importsave');

end;
/
commit;
drop table prlGG_GROUNDH;			
create table prlGG_GROUNDH (			
	fgid	int	not null,
	fno	varchar2(64)	not null,
	fArea	NUMBER(24,2)	null,
	jArea	NUMBER(24,2)	null,
	fmr	NUMBER(24,2)	null,
	--		
	floorno	VARCHAR2(16)	null,
	deptsource	varchar2(64)	null,
	--		
	fstat	VARCHAR2(16)	null,
	fnow	int	null,
	OpType	varchar2(32)	null,
	OpDate	Date	null,
	OpGid	varchar2(32)	null,
	OpCode	varchar2(64)	null,
	OpName	varchar2(64)	null,
	constraint PK_prlGG_GROUNDH primary key(fGid)		
	);		

drop table prlGG_GROUNDH_Rcd;			
create table prlGG_GROUNDH_Rcd (			
	EntGid	varchar2(32)	not null,
	Gid	varchar2(32)	not null,
	--		
	fGid	varchar2(32)	null,
	fNo	varchar2(32)	null,
	OpType	varchar2(32)	null,
	OpDate	Date	null,
	OpGid	varchar2(32)	null,
	OpCode	varchar2(64)	null,
	OpName	varchar2(64)	null,
	OpMemo	varchar2(4000)	null,
	constraint PK_prlGG_GROUNDH_Rcd primary key(EntGid,Gid)		
	);		
			
drop table prlGG_GROUNDH_Temp;			
create table prlGG_GROUNDH_Temp (			
	EntGid	varchar2(32)	not null,
	Gid	varchar2(32)	not null,
	--		
	Line	int	null,
	fGid	varchar2(32)	null,
	deptsource	varchar2(64)	null,
	fno	varchar2(64)	null,
	farea	NUMBER(24,2)	null,
	Jarea	NUMBER(24,2)	null,
	fmr	NUMBER(24,2)	null,
	floorno	VARCHAR2(16)	null,
	ImportGid	varchar2(32)	null,
	constraint PK_prlGG_GROUNDH_Temp primary key(EntGid,Gid)		
	);		
