
CREATE OR REPLACE VIEW V_PrlZB_App AS
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
          from PrlZB_Post p, Prlzb_Company c
         where p.entgid = c.entgid) t,
       PrlZB_Baoxiao_App b,
       PrlZB_Fee_App f,
       PrlZB_Pay_App p,
       PrlZB_Stamp_App s
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
 order by t.Postcode;