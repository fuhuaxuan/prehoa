create or replace procedure P_Prl_OISCF_doApp(p_EntGid    varchar2, --企业Gid
                                              p_ModelGid  varchar, --模型Gid
                                              p_FlowGid   varchar, --流程Gid
                                              p_AppAssign varchar2 --意见
                                              ) as
begin
  P_Prl_OISF_doApp(p_EntGid, p_ModelGid, p_FlowGid, p_AppAssign);
end;
/
