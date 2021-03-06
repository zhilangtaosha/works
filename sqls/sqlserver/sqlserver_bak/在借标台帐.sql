  use xueshandai

  select top 10 * from enterprise_info
  select  a.id as borrow_id,a.status,a.loaner_id
  ,b.member_id,b.company_name,b.business_license_no
  ,m.id as member_id_m,m.real_name,m.idcard
  ,post_time,full_time,amount,cycle_type,cycle,amount,rate 
  ,is_display
  from  borrow a 
  left outer join enterprise_info b on a.loaner_id=b.member_id
  left outer join member m on a.loaner_id = m.id
  where a.status in (1,4,5) and a.is_display=1
  and a.id not in (select borrow_id from repayment_detail where status in (2))
  order by full_time

  select top 10 * from borrow
  
  where id=13552


  select distinct 

  select top 10 * from repayment_detail where status in (2) and capital>0

  status=2


  select distinct borrow_id from repayment_detail where status in (2)