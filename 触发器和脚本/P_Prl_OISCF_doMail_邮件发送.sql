create or replace procedure P_Prl_OISCF_doMail(p_FlowGid varchar --����Gid
                                                ) as
begin
  P_Prl_OISF_doMail(p_FlowGid);
end;
/
