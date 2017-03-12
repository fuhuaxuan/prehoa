
--以下脚本需要替换
--替换-海鼎代码-"9191",替换成确定的海鼎代码。

--创建HDNet应用用户
create user 
hdIntra 			--用户名
identified by 
"heading.com" 			--密码
default tablespace users temporary tablespace temp;

--赋权限，Resource,Connect为ORACLE默认角色,并且不限制用户的空间
GRANT dba , unlimited tablespace, CREATE ANY TABLE to hdIntra;

--链接到新创建的数据库用户
CONNECT hdIntra/heading.com@orcl;

--创建企业GID
create or replace function getEntGid return varchar2 is
begin
  return '2000000000000000000000000009260A';
end;
/

--创建企业海鼎Code
create or replace function getEntCode return varchar2 is
begin
  return '9260A';
end;
/

--创建企业全名
create or replace function getEntName return varchar2 is
begin
  return '沈阳长峰房地产开发有限公司';
end;
/

--创建企业简称
create or replace function getEntSName return varchar2 is
begin
  return '辽宁沈阳龙之梦亚太中心';
end;
/

--网站用户代码-企业代码
create or replace function getHDNetCode return varchar2 is
begin
  return 'prlintra';
end;
/

--初始化用户数（一般用户数量是合同中用户数量再加上2，因为我们内部，管理员，heading用户就占用了2个数量）
create or replace function getUsrCount return varchar2 is
begin
  return '0';
end;
/

--网站路径
create or replace function getHDNetPath return varchar2 is
begin
  return 'd:\hdnet\';
end;
/


--全体用户组Gid
create or replace function getGid3 return varchar2 is
begin
  return 'ALL_USR_GRP';
end;
/

--企业部门组Gid
create or replace function getGid4 return varchar2 is
begin
  return 'DEPT';
end;
/

--天气预报
create or replace function getWeatherUrl return varchar2 is
begin
  return 'http://m.weather.com.cn/m/pn6/weather.htm';
end;
/
