
--查询标信息
select id as 标号
,loaner_id as 借款人id
,name as 标名称
,case when category='ordinary' then '担保标' when category='transfer' then '信用标' when category='worth' then '净值标' else '其他'  end '产品名称'
,full_time as 满标时间
,amount as 借款本金
,cycle as 借款期限
,case when cycle_type='1' then '天' when cycle_type='2' then '月' else '其他'  end '借款期限单位'
,case when interest_type='0' then '投标计息' when interest_type='1' then '满标计息' else '其他'  end '计息方式'
,case when repay_type=0 then '未知' 
when repay_type=1 then '一次性还款'
when repay_type=2 then '每月等额本息'
when repay_type=3 then '按月还息'
when repay_type=4 then '按季还息'
when repay_type=5 then '半年还本息'
else ''
end as 还款方式
,rate as 利率
,interest_total as 利息
,loaner_fee_total as 管理费率,loaner_total as 管理费
,case when status =0 then '待审核'
when status =1 then '投标'
when status =2 then '未通过审核'
when status =3 then '流标'
when status =4 then '满标'
when status =5 then '还款中'
when status =6 then '完成'
else '' end as 标状态
--,category
--,deadline
--,cycle_type
--,interest_type
--,repay_type
--,status
--,is_be_overdue
--,date_created,last_updated
from borrow  
--where id in (12628)
where id in (408,10019,12628,12545,8858,8785,5524,5977)

select b.username,a.*
from borrow a 
left outer join member b on a.loaner_id=b.id 
--where id in (12628)
where a.id in (408,10019,12628,12545,8858,8785,5524,5977)

--标号	借款人id	标名称	产品名称	满标时间	借款本金	借款期限	借款期限单位	计息方式	还款方式	利率	利息	管理费率	管理费	标状态
--12628	979231	上海某科技公司借款100万	信用标	2018-01-08 09:40:46.220	1000000.00	12	月	满标计息	按月还息	0.1300	129999.96	0.0220	22000.00	还款中

--投标详情
select id as invest_id
,borrow_id
,investor_id
,loaner_id
,capital 
,date_created
,capital_type
,status
from borrow_invest a 
where borrow_id in (12628)
--where borrow_id in (408,10019,12628,12545,8858,8785,5524,5977)
order by a.borrow_id,invest_id

select borrow_id,sum(capital) as capital 
from borrow_invest
where borrow_id in (12628)
group by borrow_id


--还款计划
select * 
from repayment_detail
--where borrow_id in (12628)
where borrow_id in (408,10019,12628,12545,8858,8785,5524,5977)
order by borrow_id,issue

select * from 


--还款记录
select * 
from repayment_history
--where borrow_id in (12628)
where borrow_id in (408,10019,12628,12545,8858,8785,5524,5977)
order by borrow_id,repay_time

--流水
select c.*
from (
select distinct loaner_id
from borrow
--where id in (12628)
where id in (408,10019,12628,12545,8858,8785,5524,5977)
) a 
left outer join (select id as account_id,member_id from account where type='cash') b  on a.loaner_id = b.member_id
left outer join cash_flow c on b.account_id=c.account_id
left outer join mold m on c.event_type_id=m.id
where m.code='loanerRepayPart'

Xsd123!@#


select top 10 * from cash_flow

where 
order by account_id,date_created


select * from account where member_id in (979231) and type='cash'

left outer join (select loan)


select * from member where id=421

use xueshandai
select * from borrow where id in (408)

select * from mold order by code

select id,loaner_id,name,full_time,amount,interest_total,rate,cycle,deadline,* from borrow where id in (408)




select * from borrow where id='11398'

--冲值
select * from account_recharge where member_id=(select loaner_id from borrow where id='11398') 

--提现
select * from account_withdraw where member_id=(select loaner_id from borrow where id='11398') 


--还款计划
--select * from repayment_detail where member_id=(select loaner_id from borrow where id='408')  and need_repayment_time >='2014-01-04' and need_repayment_time<='2014-01-05'  order by need_repayment_time

select * from repayment_detail where member_id=(select loaner_id from borrow where id='11398') and borrow_id=11398

select cf.* from cash_flow cf,mold d 
where account_id =(select id from account where type='cash' and member_id=(select loaner_id from borrow where id='11398')) 
and cf.event_type_id = d.id and cf.event_source in (select id from repayment_history where borrow_id='11398') and d.code='loanerRepayPart'


=======================================

select id from repayment_history where borrow_id='408'

select min(date_created) as dmin,max(date_created) as dmax from repayment_history
--2013-11-22 02:13:21.7700000
--2018-03-25 17:27:21.4570000

select min(date_created) as dmin,max(date_created) as dmax from repayment_detail



-------------------------------

==============================================
12208，11398，5776  -- 陈宝峰
12967,13073

--标
use xueshandai

select * from borrow where id='12967'

--提现
select * from account_withdraw where member_id=(select loaner_id from borrow where id='12967') 

--充值
select * from account_recharge where member_id=(select loaner_id from borrow where id='12967') 

--还款流水
select cf.* from cash_flow cf,mold d 
where account_id =(select id from account where type='cash' and member_id=(select loaner_id from borrow where id='12967')) 
and cf.event_type_id = d.id and cf.event_source in (select id from repayment_history where borrow_id='12967') 
and d.code='loanerRepayPart'


--select * from repayment_detail where member_id=(select loaner_id from borrow where id='10019')  and need_repayment_time >='2014-01-04' and need_repayment_time<='2014-01-05'  order by need_repayment_time
--还款表现
select * from repayment_detail where borrow_id='12967' order by issue

--投标用户
select top  10 * from borrow_invest where borrow_id = 12967

--投标用户流水
select cf.* from cash_flow cf,mold d 
where account_id =(select id from account where type='cash' and member_id=(select investor_id from borrow_invest where id='90219')) 
and cf.event_type_id = d.id and cf.event_source in (select id from borrow_invest where id='90219')


-------------------------------


select * from borrow where id='12628'


select * from account_withdraw where member_id=(select loaner_id from borrow where id='12628') 

select * from account_recharge where member_id=(select loaner_id from borrow where id='12628') 


select cf.* from cash_flow cf,mold d 
where account_id =(select id from account where type='cash' and member_id=(select loaner_id from borrow where id='12628')) 
and cf.event_type_id = d.id and cf.event_source in (select id from repayment_history where borrow_id='12628') 
and d.code='loanerRepayPart'


--select * from repayment_detail where member_id=(select loaner_id from borrow where id='10019')  and need_repayment_time >='2014-01-04' and need_repayment_time<='2014-01-05'  order by need_repayment_time
select * from repayment_detail where borrow_id='12628' order by issue

select * from borrow_invest where borrow_id = 12628

select cf.* from cash_flow cf,mold d 
where account_id =(select id from account where type='cash' and member_id=(select investor_id from borrow_invest where id='308199')) 
and cf.event_type_id = d.id and cf.event_source in (select id from borrow_invest where id='308199')


-------------------------------


select * from borrow where id='408'


select * from account_withdraw where member_id=(select loaner_id from borrow where id='408') 

select * from account_recharge where member_id=(select loaner_id from borrow where id='408') 


select cf.* from cash_flow cf,mold d 
where account_id =(select id from account where type='cash' and member_id=(select loaner_id from borrow where id='408')) 
and cf.event_type_id = d.id and cf.event_source in (select id from repayment_history where borrow_id='408') 
and d.code='loanerRepayPart'


--select * from repayment_detail where member_id=(select loaner_id from borrow where id='10019')  and need_repayment_time >='2014-01-04' and need_repayment_time<='2014-01-05'  order by need_repayment_time
select * from repayment_detail where borrow_id='408' order by issue

select * from borrow_invest where borrow_id = 408

select cf.* from cash_flow cf,mold d 
where account_id =(select id from account where type='cash' and member_id=(select investor_id from borrow_invest where id='9402')) 
and cf.event_type_id = d.id and cf.event_source in (select id from borrow_invest where id='9402')



-------------------------------


select * from borrow where id='12545'


select * from account_withdraw where member_id=(select loaner_id from borrow where id='12545') 

select * from account_recharge where member_id=(select loaner_id from borrow where id='12545') 


select cf.* from cash_flow cf,mold d 
where account_id =(select id from account where type='cash' and member_id=(select loaner_id from borrow where id='12545')) 
and cf.event_type_id = d.id and cf.event_source in (select id from repayment_history where borrow_id='12545') 
and d.code='loanerRepayPart'


--select * from repayment_detail where member_id=(select loaner_id from borrow where id='10019')  and need_repayment_time >='2014-01-04' and need_repayment_time<='2014-01-05'  order by need_repayment_time
select * from repayment_detail where borrow_id='12545' order by issue

select * from borrow_invest where borrow_id = 12545

select cf.* from cash_flow cf,mold d 
where account_id =(select id from account where type='cash' and member_id=(select investor_id from borrow_invest where id='304482')) 
and cf.event_type_id = d.id and cf.event_source in (select id from borrow_invest where id='304482')


-------------------------------


select * from borrow where id='8858'


select * from account_withdraw where member_id=(select loaner_id from borrow where id='8858') 

select * from account_recharge where member_id=(select loaner_id from borrow where id='8858') 


select cf.* from cash_flow cf,mold d 
where account_id =(select id from account where type='cash' and member_id=(select loaner_id from borrow where id='8858')) 
and cf.event_type_id = d.id and cf.event_source in (select id from repayment_history where borrow_id='8858') 
and d.code='loanerRepayPart'


--select * from repayment_detail where member_id=(select loaner_id from borrow where id='10019')  and need_repayment_time >='2014-01-04' and need_repayment_time<='2014-01-05'  order by need_repayment_time
select * from repayment_detail where borrow_id='8858' order by issue

select * from borrow_invest where borrow_id = 8858

select cf.* from cash_flow cf,mold d 
where account_id =(select id from account where type='cash' and member_id=(select investor_id from borrow_invest where id='165783')) 
and cf.event_type_id = d.id and cf.event_source in (select id from borrow_invest where id='165783')


-------------------------------


select * from borrow where id='8785'


select * from account_withdraw where member_id=(select loaner_id from borrow where id='8785') 

select * from account_recharge where member_id=(select loaner_id from borrow where id='8785') 


select cf.* from cash_flow cf,mold d 
where account_id =(select id from account where type='cash' and member_id=(select loaner_id from borrow where id='8785')) 
and cf.event_type_id = d.id and cf.event_source in (select id from repayment_history where borrow_id='8785') 
and d.code='loanerRepayPart'


--select * from repayment_detail where member_id=(select loaner_id from borrow where id='10019')  and need_repayment_time >='2014-01-04' and need_repayment_time<='2014-01-05'  order by need_repayment_time
select * from repayment_detail where borrow_id='8785' order by issue

select * from borrow_invest where borrow_id = 8785

select cf.* from cash_flow cf,mold d 
where account_id =(select id from account where type='cash' and member_id=(select investor_id from borrow_invest where id='163440')) 
and cf.event_type_id = d.id and cf.event_source in (select id from borrow_invest where id='163440')


-------------------------------


select * from borrow where id='5524'


select * from account_withdraw where member_id=(select loaner_id from borrow where id='5524') 

select * from account_recharge where member_id=(select loaner_id from borrow where id='5524') 


select cf.* from cash_flow cf,mold d 
where account_id =(select id from account where type='cash' and member_id=(select loaner_id from borrow where id='5524')) 
and cf.event_type_id = d.id and cf.event_source in (select id from repayment_history where borrow_id='5524') 
and d.code='loanerRepayPart'


--select * from repayment_detail where member_id=(select loaner_id from borrow where id='10019')  and need_repayment_time >='2014-01-04' and need_repayment_time<='2014-01-05'  order by need_repayment_time
select * from repayment_detail where borrow_id='5524' order by issue

select * from borrow_invest where borrow_id = 5524

select cf.* from cash_flow cf,mold d 
where account_id =(select id from account where type='cash' and member_id=(select investor_id from borrow_invest where id='86127')) 
and cf.event_type_id = d.id and cf.event_source in (select id from borrow_invest where id='86127')


-------------------------------


select * from borrow where id='5977'


select * from account_withdraw where member_id=(select loaner_id from borrow where id='5977') 

select * from account_recharge where member_id=(select loaner_id from borrow where id='5977') 


select cf.* from cash_flow cf,mold d 
where account_id =(select id from account where type='cash' and member_id=(select loaner_id from borrow where id='5977')) 
and cf.event_type_id = d.id and cf.event_source in (select id from repayment_history where borrow_id='5977') 
and d.code='loanerRepayPart'


--select * from repayment_detail where member_id=(select loaner_id from borrow where id='10019')  and need_repayment_time >='2014-01-04' and need_repayment_time<='2014-01-05'  order by need_repayment_time
select * from repayment_detail where borrow_id='5977' order by issue

select * from borrow_invest where borrow_id = 5977

select cf.* from cash_flow cf,mold d 
where account_id =(select id from account where type='cash' and member_id=(select investor_id from borrow_invest where id='92756')) 
and cf.event_type_id = d.id and cf.event_source in (select id from borrow_invest where id='92756')


----------------------

select * from borrow where id='12545'


select * from account_withdraw where member_id=(select loaner_id from borrow where id='12545') 

select * from account_recharge where member_id=(select loaner_id from borrow where id='12545') 


select cf.* from cash_flow cf,mold d where account_id =(select id from account where type='cash' and member_id=(select loaner_id from borrow where id='12545')) and cf.event_type_id = d.id and cf.event_source in (select id from repayment_history where borrow_id='12545') and d.code='loanerRepayPart'


select cf.* from cash_flow cf,mold d where account_id =(select id from account where type='cash' and member_id=(select investor_id from borrow_invest where id='')) and cf.event_type_id = d.id and cf.event_source in (select id from borrow_invest where id='')



---------------------------



select * from borrow where id='8858'

select * from borrow where loaner_id='101408'


select * from account_withdraw where member_id=(select loaner_id from borrow where id='8858') 




select cf.* from cash_flow cf,mold d where account_id =(select id from account where type='cash' and member_id=(select loaner_id from borrow where id='8858')) and cf.event_type_id = d.id and cf.event_source in (select id from repayment_history where borrow_id='8858') and d.code='loanerRepayPart'


select cf.* from cash_flow cf,mold d where account_id =(select id from account where type='cash' and member_id=(select investor_id from borrow_invest where id='')) and cf.event_type_id = d.id and cf.event_source in (select id from borrow_invest where id='')



--------------------------



select * from borrow where id='8785'

select * from borrow where loaner_id='96794'


select * from account_withdraw where member_id=(select loaner_id from borrow where id='8785') 

select * from account_recharge where member_id=(select loaner_id from borrow where id='8785') 


select cf.* from cash_flow cf,mold d where account_id =(select id from account where type='cash' and member_id=(select loaner_id from borrow where id='8785')) and cf.event_type_id = d.id and cf.event_source in (select id from repayment_history where borrow_id='8785') and d.code='loanerRepayPart'


select cf.* from cash_flow cf,mold d where account_id =(select id from account where type='cash' and member_id=(select investor_id from borrow_invest where id='')) and cf.event_type_id = d.id and cf.event_source in (select id from borrow_invest where id='')



----------------

select * from borrow where id='12208'

select * from borrow where loaner_id='283398' 

select * from account_withdraw where member_id=(select loaner_id from borrow where id='12208') 

select * from account_recharge where member_id=(select loaner_id from borrow where id='12208') 


select cf.* from cash_flow cf,mold d where account_id =(select id from account where type='cash' and member_id=(select loaner_id from borrow where id='12208')) and cf.event_type_id = d.id and cf.event_source in (select id from repayment_history where borrow_id='12208') and d.code='loanerRepayPart'


select cf.* from cash_flow cf,mold d where account_id =(select id from account where type='cash' and member_id=(select investor_id from borrow_invest where id='')) and cf.event_type_id = d.id and cf.event_source in (select id from borrow_invest where id='')

------------------------

select * from borrow where id='11398'

select * from borrow where loaner_id='229404' 

select * from account_withdraw where member_id=(select loaner_id from borrow where id='11398') 

select * from account_recharge where member_id=(select loaner_id from borrow where id='11398') 


select cf.* from cash_flow cf,mold d where account_id =(select id from account where type='cash' and member_id=(select loaner_id from borrow where id='11398')) and cf.event_type_id = d.id and cf.event_source in (select id from repayment_history where borrow_id='11398') and d.code='loanerRepayPart'


select cf.* from cash_flow cf,mold d where account_id =(select id from account where type='cash' and member_id=(select investor_id from borrow_invest where id='')) and cf.event_type_id = d.id and cf.event_source in (select id from borrow_invest where id='')


------------------------

select * from borrow where id='5776'

select * from borrow where loaner_id='82512' 


select * from account_withdraw where member_id=(select loaner_id from borrow where id='5776') 

select * from account_recharge where member_id=(select loaner_id from borrow where id='5776') 




select cf.* from cash_flow cf,mold d where account_id =(select id from account where type='cash' and member_id=(select loaner_id from borrow where id='5776')) and cf.event_type_id = d.id and cf.event_source in (select id from repayment_history where borrow_id='5776') and d.code='loanerRepayPart'


select cf.* from cash_flow cf,mold d where account_id =(select id from account where type='cash' and member_id=(select investor_id from borrow_invest where id='')) and cf.event_type_id = d.id and cf.event_source in (select id from borrow_invest where id='')


select distinct loan_fee from borrow_invest  where borrow_id='12992'

---4978---4804

select * from borrow where status in (4,5) and category='worth'



select sum(fact_repay_fee),sum(should_repay_fee) from repayment_detail where need_repayment_time between '2016-1-1 00:00:00'and '2016-12-31 23:59:59' and status between '1' and '4' and borrow_id in (select id from borrow where status between 4 and 7 and is_display ='1')

select sum(fact_repay_fee),sum(should_repay_fee) from repayment_detail where repayment_time between '2016-1-1 00:00:00'and '2016-12-31 23:59:59' and status between '1' and '4'


select sum(member_overdue_fee),sum(company_overdue_fee) from repayment_history where type in (3) and repay_time between '2016-1-1 00:00:00'and '2016-12-31 23:59:59' 

select * from displacement_detail where repay_time between '2016-1-1 00:00:00'and '2016-12-31 23:59:59' and borrow_id in(select id from borrow where category ='worth' and is_display ='1') 


select * from repayment_detail where repayment_time between '2016-1-1 00:00:00'and '2016-12-31 23:59:59' and status between '1' and '4' order by fact_repay_fee desc

select sum(fact_repay_fee),sum(should_repay_fee) from repayment_detail where repayment_time between '2016-1-1 00:00:00'and '2016-1-31 23:59:59' and status between '1' and '4'


select * from repayment_detail where id='22677'


select * from repayment_history where id='22677'


select sum(member_overdue_fee),sum(company_overdue_fee) from repayment_history where type in (3) and repay_time between '2016-1-1 00:00:00'and '2016-1-31 23:59:59' 


select sum(member_overdue_fee),sum(company_overdue_fee) from repayment_history where type in (3) and repay_time between '2016-1-1 00:00:00'and '2016-1-31 23:59:59'  and borrow_id in (select id from borrow where category ='worth')


select * from repayment_history where type in (3) and repay_time between '2016-1-1 00:00:00'and '2016-12-31 23:59:59'  and borrow_id in (select id from borrow where category !='worth')



select * from repayment_history where type in (2) and repay_time between '2016-1-1 00:00:00'and '2016-12-31 23:59:59'  and borrow_id in (select id from borrow where category ='worth')



---------------------------
select borrow_id '标号',member_id '借款人',company_overdue_fee '还款公司逾期费',member_overdue_fee '还款投资者逾期费',repay_time '还款时间' from repayment_history where type in (3) and repay_time between '2016-1-1 00:00:00'and '2016-12-31 23:59:59'  and borrow_id in (select id from borrow where category !='worth')



select borrow_id '标号',member_id '借款人',company_overdue_fee '还款公司逾期费',member_overdue_fee '还款投资者逾期费',repay_time '还款时间'  from repayment_history where type in (2) and repay_time between '2016-1-1 00:00:00'and '2016-12-31 23:59:59'  and borrow_id in (select id from borrow where category ='worth') order by borrow_id


select sum(company_overdue_fee+member_overdue_fee) from repayment_history where type in (2,3) and repay_time between '2016-1-1 00:00:00'and '2016-12-31 23:59:59'



select sum(company_overdue_fee+member_overdue_fee)   from repayment_history where type in (2) and repay_time between '2016-1-1 00:00:00'and '2016-12-31 23:59:59'  and borrow_id in (select id from borrow where category ='worth')




select b.category
,case when company_overdue_fee>0 then 1 else 0 end as company_overdue 
,case when member_overdue_fee>0 then 1 else 0 end as member_overdue
,type
,count(1) as c  
from repayment_history a  
left outer join borrow b on a.borrow_id=b.id
group by b.category
,case when company_overdue_fee>0 then 1 else 0 end 
,case when member_overdue_fee>0 then 1 else 0 end
,type
order by category,company_overdue,member_overdue,type

select *  from repayment_history where company_overdue_fee>0 and member_overdue_fee>0

----------------------------------




select 
	b.id '标号',
	case when b.category='ordinary' then '担保标' when b.category='transfer' then '信用标' when b.category='worth' then '净值标' else '其他'  end '产品名称',
	b.name '标名称' ,
	b.loaner_id '借款人id',
	m.real_name '借款人名称',
	bt.ct '出借人数',
	b.amount '借款本金',
	b.cycle '借款期限',
	case when b.cycle_type='1' then '天' when b.cycle_type='2' then '月' else '其他'  end '借款期限单位',
	case when b.interest_type='0' then '投标计息' when b.interest_type='1' then '满标计息' else '其他'  end '计息方式',
	b.rate '利率',
	b.full_time '满标时间',
	r.need_repayment_time '应还款时间',
	r.repayment_time '实际还款时间',
	b.loaner_fee_total '管理费率',
	b.loaner_total '借款管理费',
	r.should_repay_fee '应还款逾期费',
	r.fact_repay_fee '实际还款逾期费'
	from 
		borrow b,
		repayment_detail r,
		member m,
		(select borrow_id,COUNT(distinct investor_id) ct from borrow_invest group by borrow_id ) bt 
	where 
		b.id = r.borrow_id 
		and b.loaner_id=m.id 
		and b.id = bt.borrow_id 
		and b.is_display ='1'
		and b.status between 4 and 6
		and b.full_time <'2018-3-22 00:00:00'
		and r.repayment_time between '2016-1-1 00:00:00'and '2016-12-31 23:59:59'

		and b.category ='worth'
		and r.fact_repay_fee>0

		order by b.id

