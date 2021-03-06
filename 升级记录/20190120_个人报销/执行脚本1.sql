drop table Prl_BaoXiao_Type;			
create table Prl_BaoXiao_Type (			
	EntGid 	varchar2(32)  not null,
  Gid  varchar2(32)  not null,
  Name  varchar2(256)  null,
  constraint PK_Prl_BaoXiao_Type primary key(EntGid, Gid)    
  );    
drop table PrlZB_BaoXiao_Type;			
create table PrlZB_BaoXiao_Type (			
	EntGid 	varchar2(32)	not null,
	Gid	varchar2(32)	not null,
	Name	varchar2(256)	null,
	constraint PK_PrlZB_BaoXiao_Type primary key(EntGid, Gid)		
	);		


---权限执行脚本
declare
  v_EntGid  varchar2(32);
begin
select Gid into v_EntGid from Ent where Lower(code) = Lower('prlintra'); 
--新增模块权限
delete from rt where id in ('prl_baoxiao_type','prl_baoxiao_typesave','prlzb_baoxiao_type','prlzb_baoxiao_typesave');

insert into rt(id,name,atype,alevel,url,aorder,memo) values('prl_baoxiao_type','个人报销项目设置','DOA管理','30','/bin/hdnet.dll/__explainmodule?url=prl_baoxiao_type','800438','个人报销项目设置');
insert into rt(id,name,atype,alevel,url,aorder,memo) values('prl_baoxiao_typesave','个人报销项目设置','DOA管理','30','/bin/hdnet.dll/__explainmodule?url=prl_baoxiao_typesave','800439','个人报销项目设置');

--将权限默认给管理员组
--插入企业权限
delete from ent_rt where entgid = v_EntGid and rtid in ('prl_baoxiao_type','prl_baoxiao_typesave','prlzb_baoxiao_type','prlzb_baoxiao_typesave');
insert into ent_rt select v_EntGid , id from rt where id in ('prl_baoxiao_type','prl_baoxiao_typesave','prlzb_baoxiao_type','prlzb_baoxiao_typesave');

--插入管理员权限
delete from org_rt where entgid = v_EntGid and rtid in ('prl_baoxiao_type','prl_baoxiao_typesave','prlzb_baoxiao_type','prlzb_baoxiao_typesave');
insert into org_rt select v_EntGid ,org.gid , rt.id,'10' from org, rt where org.entgid = v_EntGid and lower(org.code) = lower('admin_grp') and rt.id in ('prl_baoxiao_type','prl_baoxiao_typesave','prlzb_baoxiao_type','prlzb_baoxiao_typesave');

--插入组织所有权限表
delete from org_rt_all where entgid = v_EntGid and rtid in ('prl_baoxiao_type','prl_baoxiao_typesave','prlzb_baoxiao_type','prlzb_baoxiao_typesave');
insert into org_rt_all select v_EntGid ,org.gid , rt.id,'10' from org, rt where org.entgid = v_EntGid and lower(org.code) = lower('admin_grp') and rt.id in ('prl_baoxiao_type','prl_baoxiao_typesave','prlzb_baoxiao_type','prlzb_baoxiao_typesave');

end;
/
commit;


alter table WF_Prl_BaoXiao_Dtl add TypeGid	varchar2(32);
alter table WF_Prl_BaoXiao_Dtl add TypeName	varchar2(128);
alter table WF_PrlZB_BaoXiao_Dtl add TypeGid	varchar2(32);
alter table WF_PrlZB_BaoXiao_Dtl add TypeName	varchar2(128);


create or replace procedure P_PrlDZ_BaoXiao_doMail(p_FlowGid varchar --流程Gid
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
              from Wf_Prl_Baoxiao f, wf_model wm
             where f.EntGid = v_EntGid
               and f.entgid = wm.entgid
               and f.FlowGid = p_FlowGid
               and f.modelgid = wm.modelgid) loop
    v_Stage   := 'FlowGid：' || R.Flowgid || '；模型：' || R.ModelName;
    v_Title   := '个人报销待审提醒:' || R.Filldeptname;
    v_Content := v_Content || v_Head;
  
    v_Body    := '[流程名称] : ' || R.ModelName;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[单号] : ' || R.Num;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[发起人] : ' || R.Fillusrname;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[发起时间] : ' || to_char(R.Createdate, 'YYYY.MM.DD HH24:MI');
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[公司名称] : ' || R.Comname;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '<table cellpadding="0" cellspacing="1" class="ListBar" width="100%" style="background-color: #d9dbdf;">';
    v_Body    := v_Body || '<col style="padding-left:4px;width:40%">';
    v_Body    := v_Body || '<col style="padding-left:4px;width:20%">';
    v_Body    := v_Body || '<col style="padding-left:4px;width:20%">';
    v_Body    := v_Body || '<col style="padding-left:4px;width:20%">';
    v_Body    := v_Body ||
                 '<tr style="background-color: #ecedef;" align="center">';
    v_Body    := v_Body || '<td>科目</td>';
    v_Body    := v_Body || '<td>项目</td>';
    v_Body    := v_Body || '<td>本次申请金额[元]</td>';
    v_Body    := v_Body || '<td>备注</td>';
    v_Body    := v_Body || '</tr>';
    v_Content := v_Content || v_TStart || v_Body;
  
    for D in (select f.*
                from Wf_Prl_Baoxiao_Dtl f
               where f.EntGid = v_EntGid
                 and f.FlowGid = p_FlowGid) loop
      v_Body := '<tr valign="top" style="background-color: white">';
      v_Body := v_Body || '<td>[' || D.Acgcode || ']' || D.Acgname ||
                '</td>';
      v_Body := v_Body || '<td>' || D.TypeName || '</td>';
      v_Body := v_Body || '<td align="center">' || D.Applyfee || '</td>';
      v_Body := v_Body || '<td>' || D.Memo || '</td>';
      v_Body := v_Body || '</tr>';
      v_Content := v_Content || v_Body;
    end loop;
  
    v_Body    := '</table>';
    v_Content := v_Content || v_Body || '</td></tr>';
    v_Body    := '[报销金额汇总] : ' || R.Sumfee || '元';
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[报销备注] : ' || R.Memo;
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


create or replace procedure P_PrlZB_BaoXiao_doMail(p_FlowGid varchar --流程Gid
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
              from Wf_PrlZB_Baoxiao f, wf_model wm
             where f.EntGid = v_EntGid
               and f.entgid = wm.entgid
               and f.FlowGid = p_FlowGid
               and f.modelgid = wm.modelgid) loop
    v_Stage   := 'FlowGid：' || R.Flowgid || '；模型：' || R.ModelName;
    v_Title   := '个人报销待审提醒:' || R.Filldeptname;
    v_Content := v_Content || v_Head;
  
    v_Body    := '[流程名称] : ' || R.ModelName;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[单号] : ' || R.Num;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[发起人] : ' || R.Fillusrname;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[发起时间] : ' || to_char(R.Createdate, 'YYYY.MM.DD HH24:MI');
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[公司名称] : ' || R.Comname;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '<table cellpadding="0" cellspacing="1" class="ListBar" width="100%" style="background-color: #d9dbdf;">';
    v_Body    := v_Body || '<col style="padding-left:4px;width:40%">';
    v_Body    := v_Body || '<col style="padding-left:4px;width:20%">';
    v_Body    := v_Body || '<col style="padding-left:4px;width:20%">';
    v_Body    := v_Body || '<col style="padding-left:4px;width:20%">';
    v_Body    := v_Body ||
                 '<tr style="background-color: #ecedef;" align="center">';
    v_Body    := v_Body || '<td>科目</td>';
    v_Body    := v_Body || '<td>项目</td>';
    v_Body    := v_Body || '<td>本次申请金额[元]</td>';
    v_Body    := v_Body || '<td>备注</td>';
    v_Body    := v_Body || '</tr>';
    v_Content := v_Content || v_TStart || v_Body;
  
    for D in (select f.*
                from Wf_PrlZB_Baoxiao_Dtl f
               where f.EntGid = v_EntGid
                 and f.FlowGid = p_FlowGid) loop
      v_Body := '<tr valign="top" style="background-color: white">';
      v_Body := v_Body || '<td>[' || D.Acgcode || ']' || D.Acgname ||
                '</td>';
      v_Body := v_Body || '<td>' || D.TypeName || '</td>';
      v_Body := v_Body || '<td align="center">' || D.Applyfee || '</td>';
      v_Body := v_Body || '<td>' || D.Memo || '</td>';
      v_Body := v_Body || '</tr>';
      v_Content := v_Content || v_Body;
    end loop;
  
    v_Body    := '</table>';
    v_Content := v_Content || v_Body || '</td></tr>';
    v_Body    := '[报销金额汇总] : ' || R.Sumfee || '元';
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
    v_Body    := '[报销备注] : ' || R.Memo;
    v_Content := v_Content || v_TStart || v_Body || v_TEnd;
  
    v_Content := v_Content || v_Foot;
    for U in (select hr.Email
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
