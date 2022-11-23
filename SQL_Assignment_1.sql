create database Tasks;
Use Tasks;

/*Task1:*/

create table Shopping_history(
Product varchar(20) Not null,
quantity int not null,
unit_price int not null);

insert into shopping_history values ('Milk',3,10), ('bread',7,3),('bread',5,2);
select  * from shopping_history;

Select Product, sum(Quantity * Unit_Price) as Total_Price from
Shopping_History group by Product order by Product Desc;

/* Task2.1 */
create table phones (
`Name` Varchar(20),
Phone_number int Not Null);

Create table calls (
id int not null,
caller int not null,
callee int not null,
duration int not null,
unique(id));

insert into phones values ('Jack',1234),('Lena',3333),('Mark',9999),('Anna',7582);
insert into calls Values (25,1234,7582,8),(7,9999,7582,1),(18,9999,3333,4),
						(2,7582,3333,3),(3,3333,1234,1),(21,3333,1234,1);

select * from Calls;

/* Task 2.1 Using SubQuery */
select p.name from Phones p
inner Join 
(
Select Caller, sum(duration) as Total_duration from
	(select Caller, duration from calls
	union all
	select Callee, duration from calls
	) as duration_summary group by Caller having Total_duration>=10) d
on p.phone_number = d.caller order by p.name;

/* Task 2.1 Using Common Table Expression */
Select p.Name from phones p
inner join 
(with CTE_Duration_Summary as(
		select caller, duration from calls
		union all
		select callee, duration from calls)
	select caller, sum(duration) as Total_duration from CTE_Duration_Summary
	group by Caller having Total_duration>=10) D
on p.phone_number = D.Caller order by p.Name;

/* Task 2.2 */
create table phones_new (
`Name` Varchar(20),
Phone_number int Not Null);

Create table calls_new (
id int not null,
caller int not null,
callee int not null,
duration int not null,
unique(id));

insert into phones_New values ('John',6356),('Addison',4315),('Kate',8003),('Ginny',9831);
insert into calls_New Values (65,8003,9831,7),(100,9831,8003,3),(145,4315,9831,18);

select * from Calls_new;

/* Task 2.2 Using Common Table Expressions */
Select p.Name from Phones_New p
inner join 
(With CTE_Sum_Duration as (
	select Caller, Duration from calls_New
    union all
    select callee, Duration from calls_New)
Select Caller, Sum(Duration) as Total_Duration from CTE_Sum_Duration
group by 1 having Total_duration>=10) C
on P.Phone_number = C.Caller
order by p.Name;

/* Task 2.2 using SubQuery */
Select p.name from Phones_new p
Inner Join
(Select Caller, Sum(Duration) as Total_Duration from 
	(select Caller, Duration from Calls_new
	union all
	select Callee, Duration from calls_new) as Sum_Duration group by Caller having Total_duration >=10) D
on p.Phone_number = D.Caller order by p.name;

/* Task 3.1 */

create table if not exists transactions (
amount int not null, `date` date not null);

insert into transactions values (1000,'2020-01-06'),(-10,'2020-01-14'),(-75,'2020-01-20'),(-5,'2020-01-25')
,(-4,'2020-01-29'),(2000,'2020-03-10'),(-75,'2020-03-12'),(-20,'2020-03-15'),(40,'2020-03-15'),(-50,'2020-03-17')
,(200,'2020-10-10'),(-200,'2020-10-10');
select * from Transactions;

/* Using Subqueries */
Select (Sum(Total_TXN_Amount)-((12-Sum(Charges))*5)) as Balance from(
Select *,
	case
	when Transaction_type = 'Credit_card' and TXN_Count>=3 and Total_TXN_Amount <-100 then 1
    else 0
    end as Charges
    from(
		select `Date`, Sum(Amount) as Total_TXN_Amount, Transaction_type, Count(Transaction_Type) as TXN_Count
		from(
			select amount, `date`,
			Case when Amount < 0 then 'Credit_card'
				 when Amount > 0 then 'Deposit'
				 End As 'Transaction_type'
			from transactions )
		as TXN_Table group by month(`date`),Transaction_type)
	as Tbl_Charges)
as Balance_Amount;

/* Task 3.2 */

create table if not exists transactions2 (
amount int not null, `date` date not null);

insert into transactions2 values (1,'2020-06-29'),(35,'2020-02-20'),(-50,'2020-02-03'),(-1,'2020-02-26')
,(-200,'2020-08-01'),(-44,'2020-02-07'),(-5,'2020-02-25'),(1,'2020-06-29'),(1,'2020-06-29'),(-100,'2020-12-29')
,(-100,'2020-12-30'),(-100,'2020-12-31');
select * from Transactions2;

/* Using Subqueries */
Select (Sum(Total_TXN_Amount) - ((12-sum(Charges))*5)) as Balance from
(
	Select *, Case
		when TXN_Type = 'Credit_Pay' and TXN_Count >=3 and Total_TXN_Amount <= -100 then 1
        else 0
		end as Charges
		from 
        (
			Select `date`,TXN_Type, Sum(Amount) as Total_TXN_Amount, count(TXN_Type) as TXN_Count
			 from
             (
				Select `date`,Amount,
					Case
						When Amount < 0 then 'Credit_Pay'
						else 'Deposit'
						End as TXN_Type
					from Transactions2
			) as TBL_TXN_type group by TXN_Type, Month(date)
		) as TXN_Table
) as Final_Balance;

/* Task 3.3 */

create table if not exists transactions3 (
amount int not null, `date` date not null);

insert into transactions3 values (6000,'2020-04-03'),(5000,'2020-04-02'),(4000,'2020-04-01'),(3000,'2020-03-01')
,(2000,'2020-02-01'),(1000,'2020-01-01');
select * from Transactions3;

/* Using CTE */
With CTE_TXN as(
	Select *,
	Case when TXN_Type = 'Credit_Payment' and TXN_Count >=3 and Total_TXN_Amount < -100 then 1
    else 0
	end as charges
	from(
		Select`Date`, Sum(Amount) as Total_TXN_Amount, TXN_Type, Count(TXN_Type) as TXN_Count from
			(
			Select `date`, Amount,
			Case
				when Amount<0 then 'Credit_Payment'
				else 'Deposit'
				end as TXN_Type
			from Transactions3
			) as TXN_Table group by TXN_Type, Month(`date`)
		) as TXN_Charges
)
Select (Sum(Total_TXN_Amount) - ((12 - Sum(Charges))*5)) as Balance from CTE_TXN;

