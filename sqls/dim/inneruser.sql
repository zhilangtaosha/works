-- psql dims

drop table member_inner;
create table member_inner as 
select unnest(ARRAY[
'699996'
,'shanzi'
,'lingda'
,'chang1234'
,'helili'
,'immqqq'
,'gundan'
,'dfmzliao'
,'afyjnui'
,'efmzmen'
,'fmzmen'
,'vmzshi'
,'ofmzhui'
,'ufmzse'
,'wwwcom'
,'pobobobo'
,'rrrwww'
,'tttwww'
,'zui008'
,'xyuedd'
,'yyqqcc'
,'36asdf'
,'gdafa1'
,'Coput2'
,'5222558'
,'regist'
,'啊sdfdd'
,'tlisdir'
,'eqruu0'
,'kjiuj4'
,'setgzth'
,'sirwei'
,'wangfei'
,'HF2009'
,'sovzakr'
,'gfserz'
,'9iu159'
,'enheng'
,'backing'
,'minihh'
,'liangmi'
,'langqun'
,'baobaobei'
,'huangse'
,'pangzi'
,'badyou'
,'mahugu'
,'lizhi1'
,'whynot'
,'buyong'
,'kasfei'
,'gongxi'
,'yanzheng'
,'songhua'
,'okbeng'
,'coldmm'
,'girl88'
,'legtwo'
,'mmxxmm'
,'ancl326'
,'kqqbb112'
,'suchasyou'
,'ceshi123'
,'tomorrow'
,'babynan'
,'onemee'
] ) as inner_id
;

create table m_inner as 
select a.uname,b.id
from member_inner a 
left outer join member b on a.uname=b.uname
;