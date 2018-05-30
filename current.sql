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
 select person_id, first_name, last_name, birth_date
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
 
 
 
 
 
 
 
 