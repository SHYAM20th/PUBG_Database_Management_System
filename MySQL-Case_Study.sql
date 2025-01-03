------------------------------------------------------------------------------------------------------
create database case_study;
use case_study;
--------------------------------------------------------------------------------------------------------------------------------
create table pubg(user_id int,
user_name varchar(20),character_name varchar(20),
level int,tier varchar(20),
map_name varchar(33),ww_chicken_dinner varchar(80),
matchs int);
----------------------- INSERT TABLE -----------------------------------------------------------------------------
insert into pubg values (100001,'Sam','Sara',73,'Ace','Erangle','Winner Winner Chicken_dinner',5),
                    	(100002,'Jai','Victor',74,'Platinum','Livik','Winner Winner Chicken_dinner',6),
                       	(100003,'Santhosh','Carlo',72,'Conqueror','Miramar','Lose',5),
						(100004,'Gokul','Andy',48,'Diamond','Karakin','Lose',3),
                        (100005,'Dinesh','Anna',55,'Crown','Nusa','Lose',2),
                        (100006,'Zoro','Emilia',30,'Gold','Sanhok','Winner Winner Chicken_dinner',2);
select*from pubg;
drop table pubg;
----------------------------------------------------------- CREATE TABLE 2 MAP ------------------------------------------------------------------------------------------------------
create table map(user_id int,
map_name varchar(30),
map_size varchar(60),
duration varchar(20),
air_drop int,
exclusive_weapons varchar(60));

insert into map values(100001,'Erangle','8km x 8km','35min',5,'M416'),
					  (100006,'Sanhok','4km x 4km','20min',3,'QBZ'),
                      (100007,'Livik','2km x 2km','15min',4,'Famas'),
                      (100002,'Nusa','1km x 1km','10min',2,'Aug'),
                      (100003,'Vikendi','6km x 6km','30min',4,'G36C'),
                      (100004,'Miramar','8km x 8km','35min',5,'Win94'),
                      (100005,'karakin','2km x 2km','15min',3,'M762');
				
select*from map;                
--------------------------------------------------------- CREATE TABLE 3 WEAPAN --------------------------------------------------------------------------
create table weapons (assault_rifle varchar(60),
sniper_rifle varchar(60),shotgun varchar(60),
pistol varchar(60),exclusive_weapons varchar(60));							

insert into weapons values ('AKM','Kar98K','S12K','P92','M416');
insert into weapons values ('M416','M24','DBS','Desert eagle','Win94');
insert into weapons values ('Groza','AWM','S686','Skorpion','M762');
insert into weapons values ('M762','Win94','M1014','Flare gun','Aug');
insert into weapons values ('Famas','AMR','S1897','R45','G36C');
insert into weapons values ('QBZ','Mosin Nagant','NS2000','P18C','Famas');

select *from weapons;
-------------------------------------------------------------- 
select*from pubg;
select*from map;
select*from weapons;
select*from user_profile;

------------------------ CREATE TABLE 4 USER PROFILE ---------------------------------------------------------------------------------------------------
create table user_profile (user_name varchar(20),
user_id int,map_name varchar(30),
matchs int,ww_chicken_dinner varchar(80),
exclusive_weapons varchar(60),kd_ratio float,
kills int,ranks int);

insert into user_profile values('Sam',100001,'Erangle',5,'Winner Winner Chicken_dinner','M416',2.0,7,1),
							('Jai',100002,'Livik',5,'Winner Winner Chicken_dinner','FAMAS',3.4,8,2),
							('Gokul',100003,'Sanhok',3,'Lose','QBZ',2.50,3,4),
							('Santhosh',100004,'Nusa',5,'Lose','Aug',4.0,12,5),
							('Dinesh',100005,'Vikendi',2,'Lose','G36C',2.8,8,6),
							('Zoro',100006,'Miramar',2,'Winner Winner Chicken_dinner','Win94',2.6,6,3),
							('Luffy',100007,'Erangle',8,'Lose','M416',3.0,5,6);
 
select *from user_profile;
--------------------------------------------------------------------------------------------------------------------------------


----------------------------- ALTER TABLE -----------------------------------------------------------------------
alter table pubg rename column characters to character_name; 

------------------------------------------ UPDATE TABLE ----------------------------------------

update pubg set tier = 'Ace' where user_name = 'dinesh'; 


------------------------------------------ LIKE --- AND --- OR -----IN -------------------------------------------------

select*from map where map_name like '%ang%';

select*from weapons where pistol like '%4%' ;

select * from user_profile where user_name = 'sam' 
or user_name = 'jai' or user_name = 'santhosh';

select * from weapons where shotgun in('M1014','DBS','S12K');





-------------------------------------------- AGGREGATE FUNCTION -------------------------------

select count(user_name)from pubg;

select count(distinct(user_id))as id from pubg;

select avg(level),user_id,user_name,level,tier from pubg 
group by user_id,user_name,level,tier order by avg(level) asc limit 3;

select max(level),min(level) from pubg;


---------------------------------------------- CONCAT FUNCTION ------------------------------------------------------------- 

select concat(map_name," ",map_size)as map_details
 from map group by map_name,map_size;

----------------------------------------------- SUB QUERY ----------------------------------------------------------------------  

select user_id,user_name,map_name,matchs from pubg 
where matchs <(select avg(matchs)from user_profile); 

select user_id,user_name,matchs,
(select avg(matchs)from pubg)as
 avg_match from pubg;

select user_name,characters from pubg 
where user_id in
(select distinct user_id from user_profile);

select user_name,characters from pubg 
where user_id in (select distinct user_id from pubg);

select*from user_profile where kills >
(select max(kills) from user_profile)limit 3 ;

select now();

select current_date();

select*from user_profile;

select user_name,map_name from pubg
 where map_name in (select distinct map_name from map);

----------------------------------------------- JOIN QUERY -------------------------------------------------------------------------

select up.user_name,up.map_name,w.assault_rifle,
w.exclusive_weapons,up.ww_chicken_dinner from weapons w
join user_profile up on w.exclusive_weapons = up.exclusive_weapons ;

select up.user_name,up.map_name,w.assault_rifle,w.exclusive_weapons,
up.ww_chicken_dinner from weapons w left join user_profile up
on w.exclusive_weapons = up.exclusive_weapons is not null limit 8;

select up.user_name,up.map_name,w.assault_rifle,w.exclusive_weapons,
up.ww_chicken_dinner from weapons w right join user_profile up on w.exclusive_weapons = up.exclusive_weapons ;

select up.user_name,up.map_name,w.assault_rifle,w.exclusive_weapons,up.ww_chicken_dinner from weapons w
cross join user_profile up on w.exclusive_weapons = up.exclusive_weapons ;

select up.user_name,up.map_name,w.assault_rifle,w.exclusive_weapons,up.ww_chicken_dinner from weapons w
inner join user_profile up on w.exclusive_weapons = up.exclusive_weapons ;

select p.user_name,p.characters,p.tier,up.kills,up.ranks,
m.map_name,m.duration,up.ww_chicken_dinner from pubg p 
join user_profile up on p.user_id = up.user_id join map m
on up.user_id = m.user_id;

----------------------------------------------------- UNION AND UNION ALL -------------------------------------------

select user_name,ww_chicken_dinner from pubg
union all
select user_name,ww_chicken_dinner from user_profile order by user_name;

select user_name,ww_chicken_dinner from pubg
union 
select user_name,ww_chicken_dinner from user_profile order by user_name;

----------------------------------------------------- WINDOWS FUNCTIONS  -----------------------------------------------------------------------------

select user_name ,rank() over(order by ranks) from user_profile; 

select user_name, dense_rank() over(order by ranks)
as dense_ranks from user_profile;

select user_name, percent_rank() over(order by ranks)as
percentage from user_profile;

----------------------------------------


select w.assault_rifle,w.sniper_rifle,w.shotgun,up.user_name,up.map_name,ww_chicken_dinner from weapons w
join user_profile up on w.exclusive_weapons = up.exclusive_weapons ;

select*from map;
select*from weapons;
select*from user_profile;
select*from pubg;

---------------------------------------------- TRANSACTION CONTROL LANGUAGE ----------------------------------------------------

set autocommit=off;

delete from user_profile where user_id = 100001;

select * from user_profile;

rollback;

--------------------------------------------------- REPLACE AND INSTR ---------------------------------------------------

select replace('luffy','luffy','Naruto')as renames;

select instr('ace dominator','dominator');

select distinct user_id,user_name from user_profile;