create or replace procedure P_PrlGG_ISCF_doApp(p_EntGid    varchar2, --��ҵGid
                                              p_ModelGid  varchar, --ģ��Gid
                                              p_FlowGid   varchar, --����Gid
                                              p_AppAssign varchar2 --���
                                              ) as
begin
  P_PrlGG_ISF_doApp(p_EntGid, p_ModelGid, p_FlowGid, p_AppAssign);
end;
/
