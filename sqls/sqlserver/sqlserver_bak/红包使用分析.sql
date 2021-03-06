use xueshandai

select a.member_id,a.use_date,b.reg_time
from (
select a.member_id,a.use_date
from xueshandai.dbo.card_coupons_detail a
inner join xueshandai.dbo.card_coupons_batch b  on a.batch_id = b.id 
where b.prefix in ('0292')
and  member_id is not null
and a.use_to is not null
) a 
inner join member b on a.member_id=b.id
order by use_date desc 


select * from register_attach_info where sid like '%mojifen%'


select * from member where id=995960

-- 加息券
select
a.batch_id,a.amount,a.member_id,a.status,a.use_to,a.valid_date,a.invalid_date,a.use_date
,b.prefix,b.batch_desc,invest_id,c.capital

select b.prefix,a.member_id,a.valid_date,a.use_date,c.borrow_id,c.capital
from card_coupons_detail a
inner join card_coupons_batch b  on a.batch_id = b.id 
inner join borrow_invest c on a.invest_id=c.id
where b.prefix in ('0292')
and  member_id is not null
and use_date is not null




select top 10 * from card_coupons_detail



drop table #1
select
a.batch_id,a.amount,a.member_id,a.status,a.use_to,a.valid_date,a.invalid_date,a.use_date
,b.prefix,b.batch_desc
into #1
from xueshandai.dbo.card_coupons_detail a
inner join xueshandai.dbo.card_coupons_batch b  on a.batch_id = b.id 
where b.prefix in ('0386','0387','0388','0389','0390','0391')
and  member_id is not null

select count(distinct member_id)
from xueshandai.dbo.card_coupons_detail a
inner join xueshandai.dbo.card_coupons_batch b  on a.batch_id = b.id 
where b.prefix in ('0386','0387','0388','0389','0390','0391')
and member_id is not null

select member_id
from xueshandai.dbo.card_coupons_detail a
inner join xueshandai.dbo.card_coupons_batch b  on a.batch_id = b.id 
where b.prefix in ('0386','0387','0388','0389','0390','0391')
and member_id is not null
group by member_id

select *
into #2
from #1
where status=1

select count(distinct member_id) as 发放红包客户数
,count(1) as 红包个数
,sum(amount) as 发放红包金额
,count(distinct case when status=1 then member_id else null end ) as 使用红包客户数
,sum(case when status=1 then 1 else 0 end) as 使用红包个数
,sum(case when status=1 then amount else 0 end) as 使用红包金额
from #1

select * from (
select member_id,count(1) as c from #1 group by member_id ) a where c >3

select * from #1 where member_id is  null 

select a.amount as 红包金额
,a.c as 发放数量
,b.c as 使用数量
from (select amount,count(1) as c from #1 group by amount) a 
left outer join (select amount,count(1) as c from #1 where status =1 group by amount  ) b on a.amount=b.amount
order by a.amount

select  status,amount,count(1) as c from #1 group by status,amount

select top 10 * from #1

select status,sum(amount) as amount from #1 group by status 
--0	9494250.00
--1	295750.00



drop table #2
select a.*
,b.*
into #2
from (select investor_id,borrow_id,sum(capital) as capital from borrow_invest group by investor_id,borrow_id) a 
inner join (select member_id,use_to,sum(amount) as batch_amount 
  from #1 where status=1 group by member_id,use_to
) b on a.investor_id=b.member_id and borrow_id = b.use_to


select top 10 * from #2 

drop table #3
select investor_id,sum(batch_amount) as batch_amount,sum(capital) as capital  
into #3
from #2  
group by investor_id

select batch_amount,count(1) as c 
,avg(capital) as capital_avg
,min(capital) as capital_min
,max(capital) as capital_max
from #3 group by batch_amount




select sum(batch_amount) 
from #2

select count(distinct investor_id) as investor_num
,count(1) as invest_num
,sum(capital) as invest_capital
,sum(batch_amount) as batch_amount
from #2

select count(distinct investor_id) as 投资客户数
,count(1) as 使用红包的投标数
,sum(capital) as 投资金额
,sum(batch_amount) as 红包金额
from #2


