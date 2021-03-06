/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP 1000 [id]
      ,[invest_id]
      ,[borrow_id]
      ,[payer_id]
      ,[receiver_id]
      ,[date_created]
      ,[created_by]
      ,[version]
  FROM [xueshandai].[dbo].[member_xmgj_zhaiquan]


  use xueshandai
  select is_admin
  from member
  where id=980723



  select rown,* from (
select a.* 
,ROW_NUMBER() over(partition by investor_id order by a.date_created desc ) as rown
from borrow_invest a 
inner join borrow b on a.borrow_id =b.id 
where b.status in (4,5,6)
) a 
where 1=1
and rown=1
and investor_id=980723



select a.investor_id
,a.capital as 待收金额
,b.date_created as 最近一次投资时间
,b.borrow_type as 最近一次投资标类型
,b.capital as 最近一次投资金额
from (
select investor_id,sum(capital) as capital
from receipt_detail
where status in (1)
group by investor_id
) a 
inner join (
select * from (
select a.*
,case when cycle_type=1 then '日标-' else '月标-' end + convert(varchar(5),cycle) as borrow_type
,ROW_NUMBER() over(partition by investor_id order by a.date_created desc ) as rown
from borrow_invest a 
inner join borrow b on a.borrow_id =b.id 
where b.status in (4,5,6)
) a where rown=1
) b on a.investor_id=b.investor_id
where a.investor_id=980723




select a.investor_id as member_id
,a.capital as 待收金额
,b.date_created as 最近一次投资时间
,b.borrow_type as 最近一次投资标类型
,b.capital as 最近一次投资金额
from (
select investor_id,sum() as capital
from receipt_detail
where status in (1)
group by investor_id
) a 
inner join (
select * from (
select a.*
,case when cycle_type=1 then '日标-' else '月标-' end + convert(varchar(5),cycle) as borrow_type
,ROW_NUMBER() over(partition by investor_id order by a.date_created desc ) as rown
from borrow_invest a 
inner join borrow b on a.borrow_id =b.id 
where b.status in (4,5,6)
) a where rown=1
) b on a.investor_id=b.investor_id
left outer join member_xmgj_transfer c1 on a.investor_id=c1.member_id
left outer join member_xmgj_zhaiquan c2 on a.investor_id=c2.payer_id
where not(c1.member_id is not null and c2.payer_id is null)


select a.*
into #1
from (
select a.id as member_id,a.reg_time 注册时间
from member a 
left outer join (select distinct investor_id from borrow_invest ) b on a.id = b.investor_id
where b.investor_id is null
and a.is_admin=0
) a 
inner join (
select a.id as member_id
,coalesce(b.date_created,c.date_created) as date_identified
from member a 
left outer join (select * from platform_customer where operate_type=2) b on a.id=b.member_id
left outer join (
select * from (
select *
,ROW_NUMBER() OVER(PARTITION BY member_id ORDER BY id desc) as  rown
from account_bank where operate_status=1 and authenticate_status=2 and auditing_status=1
) a where rown=1
) c on a.id=c.member_id
where b.member_id is not null or c.member_id is not null
) b on a.member_id=b.member_id



select a.*
into #2
from (
select a.id as member_id,a.reg_time 注册时间
from member a 
left outer join (select distinct investor_id from borrow_invest ) b on a.id = b.investor_id
where b.investor_id is null
and a.is_admin=0
) a 
left outer join (
select a.id as member_id
,coalesce(b.date_created,c.date_created) as date_identified
from member a 
left outer join (select * from platform_customer where operate_type=2) b on a.id=b.member_id
left outer join (
select * from (
select *
,ROW_NUMBER() OVER(PARTITION BY member_id ORDER BY id desc) as  rown
from account_bank where operate_status=1 and authenticate_status=2 and auditing_status=1
) a where rown=1
) c on a.id=c.member_id
where b.member_id is not null or c.member_id is not null
) b on a.member_id=b.member_id
where b.member_id is null 


select * from #2


select count(1) as c
from  (
select a.id as member_id,a.reg_time 注册时间
from member a 
left outer join (select distinct investor_id from borrow_invest ) b on a.id = b.investor_id
where b.investor_id is null
and a.is_admin=0
) a 


807301

select count(1) as c from #1
select 391983+415317

select count(1) as c from #2

415317

select * from #1
order by 注册时间