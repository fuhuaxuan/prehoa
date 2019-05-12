create or replace procedure P_Prl_Push(p_UsrGid in varchar2 --�û�Gid
                                       ) is
  req  utl_http.req; --���Ͷ���
  resp utl_http.resp; --���ն���

  v_Stage    varchar2(1024); --����
  v_Url      varchar2(32); --�����ַ
  v_PostData varchar2(4000); --POST�ύ������
  v_UsrCode  varchar2(32); --�û�����
  v_Value    varchar2(2000); --������Ϣ��������
  v_Content  varchar2(2048); --������Ϣ��ȫ������

begin

  v_Stage := '��ѯ����';

  v_Stage := '��ʼ������';
  v_Url   := 'https://api.jpush.cn/v3/push';

  v_PostData := '{"platform":"all","audience":{"alias":["heading"]},"notification":{"android":{"alert":"������OA","title":"����3����ִ������"},"ios":{"alert":"����3����ִ������","sound":"default","badge":"+1","thread-id":"prloa"}},"options":{"time_to_live":86400}}';
  --������ת�����ı���
  v_PostData := utl_url.escape(v_PostData, true, 'utf-8');

  --���÷���HTTP���������ͷ�ļ�
  v_Stage := '���÷���HTTP���������ͷ�ļ�';
  --req  := utl_http.begin_request(v_Url, 'POST', 'HTTP/1.1');
  --req  := utl_http.begin_request(v_Url || v_PostData);
  req := utl_http.begin_request(v_Url, 'POST', 'HTTP/1.1');
  utl_http.Set_Header(req, 'Content-Type', 'application/json');
  utl_http.Set_Header(req,
                      'Authorization',
                      'Basic NjNlMGE2OGU4NzAxY2ExOGEyZDRjNDhhOjczZTZlNzk4YzJhMzRjYWU4MDIyNzk3NA==');

  --POST�����������Ϣ
  v_Stage := 'POST�����������Ϣ';
  utl_http.set_header(req, 'Content-Length', lengthb(v_PostData));
  utl_http.write_text(req, v_PostData);

  --�õ�����http��Ӧ����
  v_Stage := '�õ�����http��Ӧ����';
  resp    := utl_http.get_response(req);

  --�õ�����http��Ӧ����������Ϣ
  v_Stage := '�õ�����http��Ӧ����������Ϣ';
  loop
    utl_http.read_line(resp, v_Value, TRUE);
    v_Content := v_Content || v_Value;
  END loop;

  --�������ض���
  v_Stage := '�������ض���';
  utl_http.end_response(resp);

  --�������
exception
  when utl_http.end_of_body then
    utl_http.end_response(resp);
  when others then
    v_Content := v_Stage || 'ʧ��!' || SQLCode || ':' || SQLERRM;
  
    --������־
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
             'ϵͳ�Զ�',
             sysdate,
             30,
             v_Content
        from ent e
       where e.gid = getentgid;
    commit;
end P_Prl_Push;
/


--1.�������ʿ����б�ACLemail_server_permissions����
BEGIN
 DBMS_NETWORK_ACL_ADMIN.CREATE_ACL (
  acl          => 'push_server_permissions.xml', 
  description  => 'Enables network permissions for the e-mail server',
  principal    => 'intraprl_v3', --��Ϊ����Ҫ���в������û�
  is_grant     => TRUE, 
  privilege    => 'connect');
END;
/

--2. ���� ACL ���ʼ��������������
BEGIN
DBMS_NETWORK_ACL_ADMIN.assign_acl (
    acl         => 'push_server_permissions.xml',
    host        => '10.10.0.200', --SMTP��������ַ
    lower_port  => 25,
    upper_port  => 25);
  COMMIT;
END;
/

--3.�������ʿ����б�ACL��network_services��
BEGIN
 DBMS_NETWORK_ACL_ADMIN.CREATE_ACL (
  acl          => 'network_services.xml', 
  description  => 'Enables network permissions for the e-mail server',
  principal    => 'intraprl_v3', --��Ϊ����Ҫ���в������û�
  is_grant     => TRUE, 
  privilege    => 'connect');
END;
/

--4. ���� ACL ���ʼ��������������
BEGIN
DBMS_NETWORK_ACL_ADMIN.assign_acl (
    acl         => 'network_services.xml',
    host        => '*', --SMTP��������ַ
    lower_port  => NULL,
    upper_port  => NULL);
  COMMIT;
END;
/


----��ѯ
 SELECT host, lower_port, upper_port, acl FROM dba_network_acls;
 
 
 SELECT acl,
       principal,
       privilege,
       is_grant,
       TO_CHAR(start_date, 'DD-MON-YYYY') AS start_date,
       TO_CHAR(end_date, 'DD-MON-YYYY') AS end_date
  FROM dba_network_acl_privileges;

--ɾ��ACL
  BEGIN
DBMS_NETWORK_ACL_ADMIN.drop_acl(acl => 'network_services.xml');
COMMIT;
END;