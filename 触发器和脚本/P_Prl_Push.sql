create or replace procedure P_Prl_Push(p_UsrGid in varchar2 --用户Gid
                                       ) is
  req  utl_http.req; --发送对象
  resp utl_http.resp; --接收对象

  v_Stage    varchar2(1024); --场景
  v_Url      varchar2(32); --邮箱地址
  v_PostData varchar2(4000); --POST提交的内容
  v_UsrCode  varchar2(32); --用户代码
  v_Value    varchar2(2000); --返回信息的行内容
  v_Content  varchar2(2048); --返回信息的全部内容

begin

  v_Stage := '查询数据';

  v_Stage := '初始化推送';
  v_Url   := 'https://api.jpush.cn/v3/push';

  v_PostData := '{"platform":"all","audience":{"alias":["heading"]},"notification":{"android":{"alert":"鹏瑞利OA","title":"您有3个待执行流程"},"ios":{"alert":"您有3个待执行流程","sound":"default","badge":"+1","thread-id":"prloa"}},"options":{"time_to_live":86400}}';
  --将中文转成中文编码
  v_PostData := utl_url.escape(v_PostData, true, 'utf-8');

  --设置发送HTTP邮箱请求的头文件
  v_Stage := '设置发送HTTP邮箱请求的头文件';
  --req  := utl_http.begin_request(v_Url, 'POST', 'HTTP/1.1');
  --req  := utl_http.begin_request(v_Url || v_PostData);
  req := utl_http.begin_request(v_Url, 'POST', 'HTTP/1.1');
  utl_http.Set_Header(req, 'Content-Type', 'application/json');
  utl_http.Set_Header(req,
                      'Authorization',
                      'Basic NjNlMGE2OGU4NzAxY2ExOGEyZDRjNDhhOjczZTZlNzk4YzJhMzRjYWU4MDIyNzk3NA==');

  --POST发送邮箱的信息
  v_Stage := 'POST发送邮箱的信息';
  utl_http.set_header(req, 'Content-Length', lengthb(v_PostData));
  utl_http.write_text(req, v_PostData);

  --得到返回http响应对象
  v_Stage := '得到返回http响应对象';
  resp    := utl_http.get_response(req);

  --得到返回http响应对象内容信息
  v_Stage := '得到返回http响应对象内容信息';
  loop
    utl_http.read_line(resp, v_Value, TRUE);
    v_Content := v_Content || v_Value;
  END loop;

  --结束返回对象
  v_Stage := '结束返回对象';
  utl_http.end_response(resp);

  --出错控制
exception
  when utl_http.end_of_body then
    utl_http.end_response(resp);
  when others then
    v_Content := v_Stage || '失败!' || SQLCode || ':' || SQLERRM;
  
    --插入日志
    insert into Log
      (EntGid,
       EntCode,
       EntName,
       UsrGid,
       UsrCode,
       UsrName,
       CreateDate,
       Atype,
       AContent)
      select e.gid,
             e.code,
             e.name,
             'sys',
             'sys',
             '系统自动',
             sysdate,
             30,
             v_Content
        from ent e
       where e.gid = getentgid;
    commit;
end P_Prl_Push;
/


--1.创建访问控制列表（ACLemail_server_permissions），
BEGIN
 DBMS_NETWORK_ACL_ADMIN.CREATE_ACL (
  acl          => 'push_server_permissions.xml', 
  description  => 'Enables network permissions for the e-mail server',
  principal    => 'intraprl_v3', --此为将来要进行操作的用户
  is_grant     => TRUE, 
  privilege    => 'connect');
END;
/

--2. 将此 ACL 与邮件服务器相关联，
BEGIN
DBMS_NETWORK_ACL_ADMIN.assign_acl (
    acl         => 'push_server_permissions.xml',
    host        => '10.10.0.200', --SMTP服务器地址
    lower_port  => 25,
    upper_port  => 25);
  COMMIT;
END;
/

--3.创建访问控制列表（ACL）network_services，
BEGIN
 DBMS_NETWORK_ACL_ADMIN.CREATE_ACL (
  acl          => 'network_services.xml', 
  description  => 'Enables network permissions for the e-mail server',
  principal    => 'intraprl_v3', --此为将来要进行操作的用户
  is_grant     => TRUE, 
  privilege    => 'connect');
END;
/

--4. 将此 ACL 与邮件服务器相关联，
BEGIN
DBMS_NETWORK_ACL_ADMIN.assign_acl (
    acl         => 'network_services.xml',
    host        => '*', --SMTP服务器地址
    lower_port  => NULL,
    upper_port  => NULL);
  COMMIT;
END;
/


----查询
 SELECT host, lower_port, upper_port, acl FROM dba_network_acls;
 
 
 SELECT acl,
       principal,
       privilege,
       is_grant,
       TO_CHAR(start_date, 'DD-MON-YYYY') AS start_date,
       TO_CHAR(end_date, 'DD-MON-YYYY') AS end_date
  FROM dba_network_acl_privileges;

--删除ACL
  BEGIN
DBMS_NETWORK_ACL_ADMIN.drop_acl(acl => 'network_services.xml');
COMMIT;
END;