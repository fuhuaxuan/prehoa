create or replace procedure P_Prl_OISCF_doMail(p_FlowGid varchar --Á÷³ÌGid
                                                ) as
begin
  P_Prl_OISF_doMail(p_FlowGid);
end;
/
