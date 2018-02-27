create or replace view v_PrlYY_Acg as
select entgid,
         gid,
         code,
         name,
         type,
         '' parentgid,
         null parentcode,
         '' parentname,
         feeflag,
         payflag
    from PrlYY_Acg
   where type = '10'
  union
  select b.entgid,
         b.gid,
         b.code,
         b.name,
         b.type,
         a.gid,
         a.code,
         a.name,
         b.feeflag,
         b.payflag
    from PrlYY_Acg a, PrlYY_Acg b
   where b.type = '20'
     and a.type = '10'
     and a.gid = b.parentgid;
CREATE OR REPLACE VIEW V_PrlYY_Acg_Post AS
select t.*,
       a1.Apper  A1Apper,
       a2.Apper  A2Apper,
       a3.Apper  A3Apper,
       a4.Apper  A4Apper,
       a5.Apper  A5Apper,
       a6.Apper  A6Apper,
       a7.Apper  A7Apper,
       a8.Apper  A8Apper,
       a9.Apper  A9Apper,
       a10.Apper A10Apper
  from (select p.entgid,
               p.gid    AcgGid,
               p.code   AcgCode,
               p.Name   AcgName,
               c.Gid    ComGid,
               c.code   ComCode,
               c.name   ComName
          from PrlYY_Acg p, PrlYY_Company c
         where p.entgid = c.entgid
           and p.type = 20) t,
       PrlYY_Acg_Post a1,
       PrlYY_Acg_Post a2,
       PrlYY_Acg_Post a3,
       PrlYY_Acg_Post a4,
       PrlYY_Acg_Post a5,
       PrlYY_Acg_Post a6,
       PrlYY_Acg_Post a7,
       PrlYY_Acg_Post a8,
       PrlYY_Acg_Post a9,
       PrlYY_Acg_Post a10
 where t.EntGid = a1.EntGid(+)
   and t.EntGid = a2.EntGid(+)
   and t.EntGid = a3.EntGid(+)
   and t.EntGid = a4.EntGid(+)
   and t.EntGid = a5.EntGid(+)
   and t.EntGid = a6.EntGid(+)
   and t.EntGid = a7.EntGid(+)
   and t.EntGid = a8.EntGid(+)
   and t.EntGid = a9.EntGid(+)
   and t.EntGid = a10.EntGid(+)
   and t.AcgGid = a1.AcgGid(+)
   and t.AcgGid = a2.AcgGid(+)
   and t.AcgGid = a3.AcgGid(+)
   and t.AcgGid = a4.AcgGid(+)
   and t.AcgGid = a5.AcgGid(+)
   and t.AcgGid = a6.AcgGid(+)
   and t.AcgGid = a7.AcgGid(+)
   and t.AcgGid = a8.AcgGid(+)
   and t.AcgGid = a9.AcgGid(+)
   and t.AcgGid = a10.AcgGid(+)
   and t.ComGid = a1.ComGid(+)
   and t.ComGid = a2.ComGid(+)
   and t.ComGid = a3.ComGid(+)
   and t.ComGid = a4.ComGid(+)
   and t.ComGid = a5.ComGid(+)
   and t.ComGid = a6.ComGid(+)
   and t.ComGid = a7.ComGid(+)
   and t.ComGid = a8.ComGid(+)
   and t.ComGid = a9.ComGid(+)
   and t.ComGid = a10.ComGid(+)
   and lower(a1.postcode(+)) = '10'
   and lower(a2.postcode(+)) = '15'
   and lower(a3.postcode(+)) = '20'
   and lower(a4.postcode(+)) = '25'
   and lower(a5.postcode(+)) = '30'
   and lower(a6.postcode(+)) = '35'
   and lower(a7.postcode(+)) = '40'
   and lower(a8.postcode(+)) = '45'
   and lower(a9.postcode(+)) = '50'
   and lower(a10.postcode(+)) = '55'
 order by t.AcgCode;

CREATE OR REPLACE VIEW V_PrlYY_App AS
select t.*,
       b.AppGid  BAppGid,
       b.AppCode BAppCode,
       b.AppName BAppName,
       f.AppGid  FAppGid,
       f.AppCode FAppCode,
       f.AppName FAppName,
       p.AppGid  PAppGid,
       p.AppCode PAppCode,
       p.AppName PAppName,
       s.AppGid  SAppGid,
       s.AppCode SAppCode,
       s.AppName SAppName
  from (select p.entgid,
               p.gid    PostGid,
               p.code   PostCode,
               p.Name   PostName,
               c.Gid    ComGid,
               c.code   ComCode,
               c.name   ComName
          from PrlYY_Post p, PrlYY_Company c
         where p.entgid = c.entgid) t,
       PrlYY_App b,
       PrlYY_App f,
       PrlYY_App p,
       PrlYY_App s
 where t.entgid = b.entgid(+)
   and t.entgid = f.entgid(+)
   and t.entgid = p.entgid(+)
   and t.entgid = s.entgid(+)
   and t.PostGid = b.postgid(+)
   and t.PostGid = f.postgid(+)
   and t.PostGid = p.postgid(+)
   and t.PostGid = s.postgid(+)
   and t.ComGid = b.ComGid(+)
   and t.ComGid = f.ComGid(+)
   and t.ComGid = p.ComGid(+)
   and t.ComGid = s.ComGid(+)
   and lower(b.modelcode(+)) = 'PrlYY_baoxiao'
   and lower(f.modelcode(+)) = 'PrlYY_fee'
   and lower(p.modelcode(+)) = 'PrlYY_pay'
   and lower(s.modelcode(+)) = 'PrlYY_stamp'
 order by t.Postcode;