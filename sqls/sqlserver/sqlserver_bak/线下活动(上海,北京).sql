
-- 签到名单
drop table #1;
select  member_id,active_type,sign_date
into #1
from Offline_Activity_Sign where is_sign=1 and myself=1

select active_type,count(1) as pv,count(distinct member_id) as uv
from #1
group by active_type

--active_type	pv	uv
--1	259	259
--2	109	109

-- 重复的数据
select * from (select member_id,count(1) as c from #1 group by member_id) a where c>1

select distinct a.*
,coalesce(b.birthday,c.birthday) as birthday
,datediff(year,coalesce(b.birthday,c.birthday),getdate()) as age
,coalesce(b.gender,c.gender) as gender
into #2
from #1 a 
left outer join member_id_card_info b on a.member_id=b.member_id
left outer join member_info c on a.member_id=c.member_id

select active_type,count(1) as pv,count(distinct member_id) as uv
from #2
group by active_type

select top 10 * from #2


select a.member_id,a.active_type,a.sign_date,a.age,a.gender
,sum(case when b.date_created<a.sign_date then capital else 0 end) as capital_before
,sum(case when b.date_created>=a.sign_date then capital else 0 end) as capital_after
into #3
from #2 a 
inner join (
select a.* 
from borrow_invest a 
inner join borrow b on a.borrow_id = b.id
where b.status in (4,5,6)
) b on a.member_id=b.investor_id
group by a.member_id,a.active_type,a.sign_date,a.age,a.gender


select * from #3

select * from #3 where capital_after>0

select distinct member_id from #3

select * from borrow_invest where investor_id in (940864)


select * from #3 where member_id=278679

select sum(capital) as capital from borrow_invest where investor_id=278679

select * from borrow_invest where investor_id=26   order by id desc

