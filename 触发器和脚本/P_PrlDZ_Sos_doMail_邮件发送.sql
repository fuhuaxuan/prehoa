create or replace procedure P_PrlDZ_SOS_doMail(p_FlowGid varchar --流程Gid
                                               ) as
  v_Stage   varchar2(1024); -- 过程场景
  v_ErrText varchar2(1024); -- Oracle错误信息

  v_EntGid varchar2(32); --企业Gid

  v_Title   varchar2(64); --标题
  v_Email   varchar(1024); --邮件
  v_Content varchar2(32500); --内容

  v_Head   varchar(64); --表头
  v_Body   varchar(2048); --表内容
  v_TStart varchar(32);
  v_TEnd   varchar(32);
  v_Foot   varchar(64); --表尾

begin
  -- 获取企业Gid
  v_EntGid  := getEntGid;
  v_Head    := '<table border="0" style="width:500px;"><tr><td>您好 :</td></tr>';
  v_TStart  := '<tr><td>';
  v_TEnd    := '；</td></tr>';
  v_Foot    := '<tr><td>-----------内容展示完毕-----------</td></tr></table>';
  v_Email   := '';
  v_Content := '';
  --for 循环 取出未领取的快递
  for R in (select f.*, wm.name ModelName
              from wf_PrlDZ_Sos f, wf_model wm
             where f.EntGid = v_EntGid
               and f.entgid = wm.entgid
               and f.FlowGid = p_FlowGid
               and f.modelgid = wm.modelgid) loop
    v_Stage   := 'FlowGid：' || R.Flowgid || '；模型：' || R.ModelName;
    v_Title   := 'SOS待审提醒:' || R.FILLDEPTNAME;
    v_Content := v_Content || v_Head;
  
    v_Body    := '[流程名称] : ' || R.ModelName;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[单号] : ' || R.Num;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[发起人] : ' || R.Fillusrname;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[发起时间] : ' || to_char(R.Createdate, 'YYYY.MM.DD HH24:MI');
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
  
    v_Body    := '[申请类型] : ' || R.ApplyType;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[分类] : ' || R.SosType;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    if R.ApplyType = '变更' then
      v_Body    := '[调整前] : ';
      v_Body    := v_Body ||
                   '<table width="100%" cellpadding="0"  cellspacing="1" style="background-color: #d9dbdf;">';
      v_Body    := v_Body || '  <colgroup>';
      v_Body    := v_Body || '    <col style="width:10%">';
      v_Body    := v_Body || '     <col style="width:15%">';
      v_Body    := v_Body || '     <col style="width:15%">';
      v_Body    := v_Body || '     <col style="width:15%">';
      v_Body    := v_Body || '     <col style="width:15%">';
      v_Body    := v_Body || '     <col style="width:15%">';
      v_Body    := v_Body || '     <col style="width:15%">';
      v_Body    := v_Body || '  </colgroup>';
      v_Body    := v_Body || '  <thead>';
      v_Body    := v_Body ||
                   '  <tr style="background-color: #ecedef;" align="center">';
      v_Body    := v_Body || '    <td>序号</td>';
      v_Body    := v_Body || '    <td>单位</td>';
      v_Body    := v_Body || '    <td>楼层</td>';
      v_Body    := v_Body || '    <td>面积</td>';
      v_Body    := v_Body || '    <td>建筑面积</td>';
      v_Body    := v_Body || '    <td>预算单价<br>租金+物管+推广</td>';
      v_Body    := v_Body || '    <td>月总租金</td>';
      v_Body    := v_Body || '  </tr>';
      v_Body    := v_Body || '  </thead>';
      v_Body    := v_Body || '  <tbody>';
      v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    
      for D in (select f.*
                  from Wf_PrlDZ_SOS_Dtl f
                 where f.EntGid = v_EntGid
                   and f.FlowGid = p_FlowGid
                   and f.aType = '10'
                 order by f.Line) loop
        v_Body    := ' <tr valign="top" style="background-color: white" align="center">';
        v_Body    := v_Body || '<td align="center">' || D.Line || '</td>';
        v_Body    := v_Body || '<td align="center">' || D.fNo || '</td>';
        v_Body    := v_Body || '<td align="center">' || D.floorNo || '</td>';
        v_Body    := v_Body || '<td align="center">' || D.fArea || '</td>';
        v_Body    := v_Body || '<td align="center">' || D.jArea || '</td>';
        v_Body    := v_Body || '<td align="center">' || D.fmr || '</td>';
        v_Body    := v_Body || '<td align="center">' || D.fmrM || '</td>';
        v_Body    := v_Body || ' </tr>';
        v_Content := v_Content || v_Body;
      end loop;
      v_Body    := '  </tbody>';
      v_Body    := v_Body || '  <tfoot>';
      v_Body    := v_Body || '  <tr style="background-color: white">';
      v_Body    := v_Body || '    <td align="right" colspan="3">合计：</td>';
      v_Body    := v_Body || '    <td align="center">' || R.fAreaSum1 ||
                   '</td>';
      v_Body    := v_Body || '    <td align="center">' || R.jAreaSum1 ||
                   '</td>';
      v_Body    := v_Body || '    <td align="center"></td>';
      v_Body    := v_Body || '    <td align="center"></td>';
      v_Body    := v_Body || '  </tr>';
      v_Body    := v_Body || '  </tfoot>';
      v_Body    := v_Body || '</table>';
      v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    end if;
    v_Body    := '[调整后] : ';
    v_Body    := v_Body ||
                 '<table width="100%" cellpadding="0"  cellspacing="1" style="background-color: #d9dbdf;">';
    v_Body    := v_Body || '  <colgroup>';
    v_Body    := v_Body || '    <col style="width:10%">';
    v_Body    := v_Body || '     <col style="width:15%">';
    v_Body    := v_Body || '     <col style="width:15%">';
    v_Body    := v_Body || '     <col style="width:15%">';
    v_Body    := v_Body || '     <col style="width:15%">';
    v_Body    := v_Body || '     <col style="width:15%">';
      v_Body    := v_Body || '     <col style="width:15%">';
    v_Body    := v_Body || '  </colgroup>';
    v_Body    := v_Body || '  <thead>';
    v_Body    := v_Body ||
                 '  <tr style="background-color: #ecedef;" align="center">';
    v_Body    := v_Body || '    <td>序号</td>';
    v_Body    := v_Body || '    <td>单位</td>';
    v_Body    := v_Body || '    <td>楼层</td>';
    v_Body    := v_Body || '    <td>面积</td>';
    v_Body    := v_Body || '    <td>建筑面积</td>';
    v_Body    := v_Body || '    <td>预算单价<br>租金+物管+推广</td>';
    v_Body    := v_Body || '    <td>月总租金</td>';
    v_Body    := v_Body || '  </tr>';
    v_Body    := v_Body || '  </thead>';
    v_Body    := v_Body || '  <tbody>';
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
  
    for D in (select f.*
                from Wf_PrlDZ_SOS_Dtl f
               where f.EntGid = v_EntGid
                 and f.FlowGid = p_FlowGid
                 and f.aType = '20'
               order by f.Line) loop
      v_Body    := ' <tr valign="top" style="background-color: white" align="center">';
      v_Body    := v_Body || '<td align="center">' || D.Line || '</td>';
      v_Body    := v_Body || '<td align="center">' || D.fNo || '</td>';
      v_Body    := v_Body || '<td align="center">' || D.floorNo || '</td>';
      v_Body    := v_Body || '<td align="center">' || D.fArea || '</td>';
      v_Body    := v_Body || '<td align="center">' || D.jArea || '</td>';
      v_Body    := v_Body || '<td align="center">' || D.fmr || '</td>';
        v_Body    := v_Body || '<td align="center">' || D.fmrM || '</td>';
      v_Body    := v_Body || ' </tr>';
      v_Content := v_Content || v_Body;
    end loop;
    v_Body    := '  </tbody>';
    v_Body    := v_Body || '  <tfoot>';
    v_Body    := v_Body || '  <tr style="background-color: white">';
    v_Body    := v_Body || '    <td align="right" colspan="3">合计：</td>';
    v_Body    := v_Body || '    <td align="center">' || R.fAreaSum2 ||
                 '</td>';
    v_Body    := v_Body || '    <td align="center">' || R.jAreaSum2 ||
                 '</td>';
    v_Body    := v_Body || '    <td align="center"></td>';
    v_Body    := v_Body || '    <td align="center"></td>';
    v_Body    := v_Body || '  </tr>';
    v_Body    := v_Body || '  </tfoot>';
    v_Body    := v_Body || '</table>';
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[备注] : ' || R.Memo;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Content := v_Content || v_Foot;
    for U in (select distinct hr.Email
                from hr_emp hr
               where hr.entgid = R.EntGid
                 and hr.Email is not null
                 and exists (select 1
                        from wf_task t
                       where t.EntGid = hr.EntGid
                         and t.FlowGid = R.Flowgid
                         and t.ExecGid = hr.UsrGid
                         and t.Stat = 1)) loop
      v_Email := v_Email || U.EMAIL || ',';
    end loop;
    if v_Email is not null then
      HDNet_SendMail(v_Title, v_Email, v_Content);
    end if;
  end loop;
  --异常处理
exception
  when others then
    begin
      v_ErrText := substr(v_Stage || ' 失败!' || SQLCode || ':' || SQLERRM,
                          1,
                          1024);
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
               v_ErrText
          from ent e
         where e.gid = v_EntGid;
      commit;
    end;
end;
/
