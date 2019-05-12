create or replace procedure P_PrlGG_ISCF_doMail(p_FlowGid varchar --Á÷³ÌGid
                                                ) as
begin
  P_PrlGG_ISF_doMail(p_FlowGid);
end;
/