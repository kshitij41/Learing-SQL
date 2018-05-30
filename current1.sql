SHOW CHARACTER SET;


CREATE TABLE person
(person_id smallint unsigned, first_name varchar(20), last_name varchar(20), gender enum('m','f'),
 birth_date date, address varchar(200), city varchar(20), state varchar(20), country varchar(20),
 postal_code varchar(20), constraint pk_person primary key(person_id));
 
 desc person;
 
 create table favorite_food
 (person_id smallint unsigned, food varchar(100), constraint pk_favorite_foods primary key(person_id,food),
 constraint fk_person_id foreign key(person_id) references person (person_id));
 
 desc favorite_food;
 
set foreign_key_checks = 0;
alter table person modify person_id smallint unsigned auto_increment;

desc person;

set foreign_key_checks = 1;

insert into person
(person_id, first_name,last_name,gender,birth_date)
values(null, 'henry', 'turner', 'm', '1999-5-27');

 select person_id, first_name, last_name, birth_date, gender
 from person
 where last_name = 'turner';
 
 insert into favorite_food
 (person_id,food)
 values(1,'nachos');
 
 insert into favorite_food
 (person_id,food)
 values(1,'honeynuts');
 
 insert into favorite_food
 (person_id,food)
 values(1,'chessepizza');
 
 select food
 from favorite_food
 where person_id = 1
 order by food;
 
 insert into person
 (person_id, first_name, last_name, gender, birth_date, address, city ,state, country, postal_code)
 values(null, 'susan','smith','f','1975-7-23', '23 maple st.', 'arlington','va','usa','20220');
 
 select person_id, first_name, last_name, birth_date
 from person;
 
 update person
 set address = '1225 tremont st.',
 city = 'boston',
 state = 'ma',
 country = 'usa',
 postal_code = '02138'
 where person_id = 1;
 
 delete from person
 where person_id = 2;
 
 show warnings;
 
 select gender, birth_date
 from person
 where person_id = 1;
 
 show tables;
 
 drop table favorite_food;
 drop table person;
 
 desc customer;
 
 select fname, lname
 from employee;
 
 select *
 from department;
 
 select dept_id, name
 from department;
 
 select name
 from department;
 
 select emp_id,
 'ACTIVE',
 emp_id*3.14159,
 upper(lname)
 from employee;
 
 select version(),
 user(),
 database();
 
 select emp_id,
 'ACTIVE' status,
 emp_id*3.14158 emp_id_times_pie,
 upper(lname) upper_last_name
 from employee;
 
 select cust_id
 from account;
 
 select distinct cust_id
 from account;
 
 select e.emp_id, e.fname, e.lname
 from(select emp_id, fname, lname, start_date, title
from employee)e;
 
 create view employee_vw as
 select emp_id, fname, lname,
   YEAR(start_date) start_year
 from employee;
 
 select emp_id, start_year
 from employee_vw;
 
 select employee.emp_id, employee.fname, employee.lname,
  department.name dept_name
  from employee inner join department
  on employee.dept_id = department.dept_id;
 
 select e.emp_id, e.fname, e.lname,
 d.name dept_name
 from employee e inner join department d
 on e.dept_id = d.dept_id;
 
 select emp_id, fname, lname, start_date, title
 from employee
 where (title = 'Head Teller' and start_date > '2002-01-01') or
  (title = 'Teller' and start_date > '2003-01-01');
 
 select open_emp_id, product_cd
 from account
 order by open_emp_id, product_cd;
 
 select account_id, product_cd, open_date,avail_balance
 from account
 order by avail_balance desc;
 
 select cust_id, cust_type_cd, city, state, fed_id
 from customer
 order by right(fed_id,3);
 
 select emp_id, title, start_date, fname, lname
 from employee
 order by 2, 5;
 
 select pt.name product_type, p.name product
 from product p inner join product_type pt
   on p.product_type_cd = pt.product_type_cd
 where pt.name != 'Customer Accounts';
 
 select emp_id,fname,lname,start_date
 from employee
 where start_date between '2001-01-01' and '2003-01-01';
 
 select cust_id,fed_id
 from customer
 where cust_type_cd = 'I' and fed_id between '500-00-0000' and '999-99-9999';
 
 select account_id, product_cd, cust_id, avail_balance
 from account
 where product_cd not in ('CHK','CD','MM','SAV');
 
 select emp_id, fname,lname
 from employee
 where left(lname,1) = 'T';
 
 select lname
 from employee
 where lname like '_a%e%';
 
 select cust_id,fed_id
 from customer
 where fed_id like '___-__-____';
 
 select emp_id,fname,lname
 from employee
 where lname like 'F%' or lname like 'G%';
 
 select emp_id,fname,lname
 from employee 
 where lname regexp '^[FG]';
 
 select emp_id,fname,lname,superior_emp_id
 from employee
 where superior_emp_id is null;
 
 select emp_id,fname,lname,superior_emp_id
 from employee
 where superior_emp_id = null;
 
 select emp_id, fname,lname,superior_emp_id
 from employee
 where superior_emp_id is not null;
 
 select emp_id,fname,lname,superior_emp_id
 from employee
 where superior_emp_id != 6 or superior_emp_id is null;
 
 desc employee;
 
 desc department;
 
 select e.fname,e.lname,d.name
 from employee e join department d;
 
 select e.fname,e.lname,d.name
 from employee e join department d
 on e.dept_id = d.dept_id;
 
 select e.fname,e.lname,d.name
 from employee e inner join department d
 on e.dept_id = d.dept_id;
 
 select e.fname,e.lname,d.name
 from employee e inner join department d
 using(dept_id);
 
 select e.fname,e.lname,d.name
 from employee e , department d
 where e.dept_id = d.dept_id;  /* old */
 
 select a.account_id, a.cust_id, a.open_date, a.product_cd
 from account a inner join employee e on a.open_emp_id = e.emp_id
      inner join branch b on e.assigned_branch_id = b.branch_id
 where e.start_date <= '2003-01-01' and (e.title = 'Teller' or e.title = 'Head Teller')
       and b.name = 'Woburn Branch';
       
select a.account_id, c.fed_id, e.fname, e.lname
from account a inner join customer c on a.cust_id = c.cust_id inner join employee e 
 on a.open_emp_id = e.emp_id
where c.cust_type_cd = 'B';

select a.account_id, a.cust_id, a.open_date,a.product_cd
from account a inner join(select emp_id, assigned_branch_id from employee where
 start_date < '2003-01-01' and (title = 'Teller' or title = 'Head Teller')) e
 on a.open_emp_id = e.emp_id
 inner join (select branch_id from branch where name = 'Woburn Branch')b
 on e.assigned_branch_id = b.branch_id;

select a.account_id, e.emp_id, b_a.name open_branch, b_e.name emp_branch
from account a inner join branch b_a on a.open_branch_id = b_a.branch_id
 inner join employee e on a.open_emp_id = e.emp_id inner join branch b_e on 
 e.assigned_branch_id = b_e.branch_id
 where a.product_cd = 'CHK';
 
 select e.emp_id, e_mgr.fname mgr_fname, e_mgr.lname mgr_lname
 from employee e inner join employee e_mgr on e.superior_emp_id = e_mgr.emp_id;
 
 select e.emp_id,e.fname,e.lname,e.start_date
 from employee e inner join product p on 
  e.start_date >= p.date_offered and e.start_date <= p.date_retired
  where p.name = 'no-fee checking';
  
  select e1.fname, e1.lname, 'VS' vs, e2.fname, e2.lname
  from employee e1 inner join employee e2
  on e1.emp_id < e2.emp_id
  where e1.title = 'Teller' and e2.title = 'Teller';
  
  select 1 num , 'abc' str
  union
  select 5 num ,'xyz' str;
  
  select cust_id , lname name from individual
  union all
  select cust_id , name from business;
  
  select emp_id from employee where assigned_branch_id = 2 and (title = 'Teller' or title = 'Head Teller')
  union /*union all*/
  select distinct open_emp_id from account where open_branch_id = 2;
  
  /*intersect*/
  
  select emp_id
  from employee
  where assigned_branch_id = 2
  and(title = 'Teller' or title = 'Head Teller') and emp_id
  not in(
  select distinct open_emp_id
  from account
  where open_branch_id = 2);
  
  select emp_id, assigned_branch_id
  from employee
  where title = 'Teller'
  union
  select open_emp_id, open_branch_id
  from account
  where product_cd = 'SAV'
  order by emp_id;
  
  select cust_id
  from account
  where product_cd in ('SAV','MM')
  union all
  select a.cust_id
  from account a inner join branch b on a.open_branch_id = b.branch_id
  where b.name = 'Woburn Branch'
  union
  select cust_id
  from account
  where avail_balance between 500 and 2500;
  
  create table string_tbl
  (char_fld char(30), vchar_fld varchar(40), text_fld text);
  
  insert into string_tbl (char_fld, vchar_fld, text_fld)
  values('hoobla hoobla char', 'hoohla hoohla hoobla varchar', 'hoobla hoobla hoobla hoobla text');
  
  update string_tbl
  set text_fld = 'thi doesn\'t work ?';
  
  select quote(text_fld)
  from string_tbl;
  
  select 'abcdefg', char(97,98,99,100,101,102,103);
  
  select cast(concat('danke sch', char(148), 'n') as char(1000) character set utf8);
  
  select ascii('a');
  
  delete from string_tbl;
  
  insert into string_tbl (char_fld,vchar_fld,text_fld)
  values('this string is 28 characters','this string is 28 characters','this string is 28 characters');
  
  select length(char_fld) char_length, length(vchar_fld) vchar_length, length(text_fld) text_length
  from string_tbl;
  
  select position('characters' in vchar_fld)
  from string_tbl;
  
  select locate('is', vchar_fld,5)
  from string_tbl;
  
  delete from string_tbl;
  
  insert into string_tbl (vchar_fld) values ('abcd');
  insert into string_tbl (vchar_fld) values ('xyz');
  insert into string_tbl (vchar_fld) values ('qrstuv');
  insert into string_tbl (vchar_fld) values ('abcd');
  
  select vchar_fld
  from string_tbl
  order by vchar_fld;
  
  select name, name like '%ns' ends_in_ns
  from department;
  
  select cust_id, cust_type_cd, fed_id, fed_id regexp '.{3}-.{2}-.{4}' is_ss_no_format
  from customer;
  
  delete from string_tbl;
  
  insert into string_tbl (text_fld)
  values('this string was 29 characters');
  
  update string_tbl
  set text_fld = concat(text_fld, ' but now it\'s longer');
  
  select concat(fname, ' ', lname, ' have been a ',title, ' since ', start_date) emp_narrative
  from employee
  where title = 'Teller' or title = 'Head Teller';
  
  select insert('goodbye world',9,0,'cruel ') string;
  
  select insert('goodbye world', 1 , 7, 'hello ');
  
  
  select substring('goodbye cruel world' , 9 , 5);
  
  select round(17,-1), truncate(17,-1);
  
  select account_id, sign(avail_balance), abs(avail_balance)
  from account;
  
  use mysql;
  select name from time_zone_name;
  
   select cast('2005-01-01 04:23:43' as datetime);
   
/*update individual
set birth_date = str_to_date('March 5, 2005', '%M %d,%y')
where cust_id = 9999;*/

select date_add(current_date(), interval 5 day);

use bank;
update transaction
set txn_date = date_add(txn_date, interval '3:27:11' HOUR_SECOND)
where txn_id = 9999;

select LAST_DAY('2005-03-25');

select current_timestamp() current_est, convert_tz(current_timestamp() , 'US/Eastern' ,'UTC') current_utc;

select dayname('2003-03-23');

select extract(year from '2005-03-22 22:19:05');

select datediff('2005-09-05', '2005-06-22');

select cast('2446534ABD' as unsigned integer);

use bank;

select open_emp_id, count(*) how_many
from account
group by open_emp_id;

select open_emp_id, count(*) how_many
from account
group by open_emp_id
having count(*) > 4;

SELECT product_cd,
  MAX(avail_balance) max_balance,
  MIN(avail_balance) min_balance,
  AVG(avail_balance) avg_balance,
  SUM(avail_balance) tot_balance,
  COUNT(*) num_accounts
FROM account
group by product_cd;

select max(pending_balance - avail_balance) max_uncleared
from account;

create table num_tbl (val smallint);

insert into num_tbl values(3);
insert into num_tbl values(5);
insert into num_tbl values(1);

select count(*) num_rows, count(val) num_val, max(val) maximum, sum(val) total, min(val) minimum
from num_tbl; 

select product_cd, sum(avail_balance) prod_balance
from account
group by product_cd;

select product_cd, open_branch_id, sum(avail_balance) tot_balance
from account
group by product_cd, open_branch_id;

select extract(year from start_date) start_year, count(*) how_many
from employee
group by extract(year from start_date);

select product_cd, open_branch_id ,sum(avail_balance) sum_total
from account
group by product_cd,open_branch_id with rollup;

select product_cd ,sum(avail_balance) prod_balance
from account
where status = 'ACTIVE'
group by product_cd
having sum(avail_balance) >= 10000; /* min(avail_balance) >= 1000 and max(avail_balance) < 10000*/

select account_id,product_cd, avail_balance, cust_id
from account
where account_id = (select max(account_id) from account);

select account_id,product_cd, cust_id, avail_balance
from account
where open_emp_id <> (select e.emp_id from employee e inner join branch b on 
e.assigned_branch_id = b.branch_id where e.title = 'Head Teller' and b.city = 'Woburn');

select branch_id,name, city
from branch
where name in ('Headquarters', 'Quincy Branch');

select emp_id, fname, lname, title
from employee
where emp_id in(select superior_emp_id from employee);

select emp_id, fname, lname, title
from employee
where emp_id not in(select superior_emp_id from employee where superior_emp_id is not null);

select emp_id, fname, lname, title
from employee
where emp_id <> all (select superior_emp_id 
from employee 
where superior_emp_id is not null);

select account_id ,cust_id, product_cd, avail_balance
from account
where avail_balance < all( select a.avail_balance from account a inner join individual i /* any */
on a.cust_id = i.cust_id where i.fname = 'Frank' and i.lname = 'Tucker'); 

select account_id, product_cd, cust_id
from account
where (open_branch_id, open_emp_id) in
  (select b.branch_id, e.emp_id
  from branch b inner join employee e on b.branch_id = e.assigned_branch_id
   where b.name = 'Woburn Branch' and (e.title = 'Teller' or e.title = 'Head Teller'));

select c.cust_id, c.cust_type_cd, c.city
from customer c
where 2 = (select count(*) from account a where a.cust_id = c.cust_id);

select c.cust_id, c.cust_type_cd, c.city
from customer c
where (select sum(avail_balance) from account a where a.cust_id = c.cust_id )between 5000 and 10000;

select a.account_id,a.product_cd,a.cust_id
from account a 
where not exists (select 1 from business b where b.cust_id = a.cust_id);

update account a 
set a.last_activity_date = (select max(t.txn_date) from transaction t where t.account_id = a.account_id)
where exists (select 1 from transaction t where t.account_id = a.account_id);

delete from department 
where not exists(select 1 from employee  where employee.dept_id = department.dept_id);

select d.dept_id, d.name, e_cnt.how_many num_employees
from department d inner join (select dept_id, count(*) how_many from employee group by dept_id) e_cnt
where d.dept_id  = e_cnt.dept_id;

use bank;

select groups.name, count(*) num_customers
from 
(select sum(a.avail_balance) cust_balance 
from account a inner join product p 
on a.product_cd = p.product_cd
where p.product_type_cd = 'ACCOUNT' 
group by a.cust_id) cust_rollup inner join 
(select 'small fry' name,0 lower_limit,4999.99 upper_limit
 union all 
 select 'average joes' name, 5000 lower_limit,
 9999.99 upper_limit 
 union all
select 'big fish' name, 10000 lower_limit,
 99999999.99 upper_limit) groups 
 on cust_rollup.cust_balance between
groups.lower_limit and groups.upper_limit
group by groups.name;


select product_cd, open_branch_id branch_id, open_emp_id emp_id, sum(avail_balance) total_deposits
from account
group by product_cd, open_branch_id, open_emp_id;

select p.name product, b.name branch, concat(e.fname, ' ', e.lname) name, account_groups.total_deposits
from (select product_cd, open_branch_id branch_id, open_emp_id emp_id, sum(avail_balance) total_deposits
from account
group by product_cd, open_branch_id, open_emp_id) account_groups inner join employee e on 
account_groups.emp_id = e.emp_id inner join branch b on b.branch_id = account_groups.branch_id
inner join product p on p.product_cd = account_groups.product_cd
where p.product_type_cd = 'ACCOUNT';


select open_emp_id, count(*) accounts
from account
group by open_emp_id
having count(*) = (select max(emp_cnt.how_many) from (select count(*) how_many from account 
group by open_emp_id) emp_cnt);


select 
(select p.name from product p 
where p.product_cd = a.product_cd
and p.product_type_cd = 'ACCOUNT') product,
(select b.name from branch b 
where b.branch_id = a.open_branch_id) branch,
(select concat(fname, ' ', lname) from employee 
where e.emp_id = a.open_emp_id) name
from account a
group by a.product_cd, a.open_branch_id, a.open_emp_id;

select emp.emp_id , concat(emp.fname, ' ', emp.lname) emp_name, (select concat(boss.fname, ' ', boss.lname)
from employee boss where emp.superior_emp_id = boss.emp_id) boss_name
from employee emp
where emp.superior_emp_id is not null
order by (select boss.lname from employee boss where boss.emp_id = emp.superior_emp_id), emp.lname;

select a.account_id, a.cust_id, b.name
from account a left outer join business b
on a.cust_id = b.cust_id;

select a.account_id, a.cust_id, i.fname, i.lname
from account a left outer join individual i
on a.cust_id = i.cust_id;

select c.cust_id, b.name
from customer c right outer join business b
on c.cust_id = b.cust_id;

select a.account_id, a.product_cd,concat(i.fname, ' ', i.lname) person_name, b.name business_name
from account a left outer join individual i on a.cust_id = i.cust_id left outer join business b
on a.cust_id = b.cust_id; 

select e.fname, e.lname, e_mgr.fname mgr_fname, e_mgr.lname mgr_lname
from employee e right outer join employee e_mgr
on e.superior_emp_id = e_mgr.emp_id;

select a.account_id, a.cust_id, c.cust_type_cd, c.fed_id
from account a natural join customer c;

select c.cust_id, c.fed_id, c.cust_type_cd, concat(i.fname, ' ', i.lname),b.name business_name
from customer c left outer join individual i on c.cust_id = i.cust_id left outer join business b
on c.cust_id = b.cust_id;

select c.cust_id, c.fed_id,
  case 
     when c.cust_type_cd = 'I'
         then concat(i.fname, ' ',i.lname)
	 when c.cust_type_cd = 'B'
         then b.name
	 else 'unknown'
     end name
from customer c left outer join individual i on c.cust_id = i.cust_id
   left outer join business b on c.cust_id = b.cust_id;
   
   
use bank;

select sum(case when extract(year from open_date) = 2000 then 1 else 0 end) year_2000,
sum(case when extract(year from open_date) = 2001 then 1 else 0 end ) year_2001,
sum(case when extract(year from open_date) = 2002 then 1 else 0 end ) year_2002,
sum(case when extract(year from open_date) = 2003 then 1 else 0 end ) year_2003,
sum(case when extract(year from open_date) = 2004 then 1 else 0 end ) year_2004,
sum(case when extract(year from open_date) = 2005 then 1 else 0 end ) year_2005
from account
where open_date > '1999-12-31';

select c.cust_id, c.fed_id, c.cust_type_cd, case when exists(select 1 from account a 
where a.cust_id = c.cust_id and a.product_cd = 'CHK') then 'Y' else 'N' end has_checking,
case when exists(select 1 from account a where a.cust_id = c.cust_id and a.product_cd = 'SAV') then 'Y'
else 'N' end has_saving
from customer c

select c.cust_id, c.fed_id, c.cust_type_cd, case (select count(*) from account a where a.cust_id = c.cust_id)
when 0 then 'None'
when 1 then '1'
when 2 then '2'
else '3+' end num_accounts
from customer c;

select a.cust_id, a.product_cd, a.avail_balance /
 case when prod_tots.tot_balance = 0 then 1
       else prod_tots.tot_balance
 end percent_of_total
 from account a inner join (select a.product_cd, sum(a.avail_balance) tot_balance from account a group by a.product_cd) prod_tots
 on a.product_cd = prod_tots.product_cd;
 


