create or replace procedure P_Prl_OISCF_doApp(p_EntGid    varchar2, --��ҵGid
                                              p_ModelGid  varchar, --ģ��Gid
                                              p_FlowGid   varchar, --����Gid
                                              p_AppAssign varchar2 --���
                                              ) as
begin
  P_Prl_OISF_doApp(p_EntGid, p_ModelGid, p_FlowGid, p_AppAssign);
end;
/
