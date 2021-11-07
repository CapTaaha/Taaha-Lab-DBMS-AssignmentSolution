#3)Display the number of the customer group by their genders who have placed any order
#of amount greater than or equal to Rs.3000.

select c.CUS_GENDER, count(c.CUS_GENDER)
from CUSTOMER c, ORDERS o
where c.CUS_ID = O.CUS_ID
and o.ORD_AMOUNT>=3000
group by c.CUS_GENDER;


#4) Display all the orders along with the product name ordered by a customer having
#Customer_Id=2.

select o.*, pr.PRO_NAME
from orders o inner join product_details p 
on p.PROD_ID = o.PROD_ID
inner join product pr
on pr.PRO_ID = p.PRO_ID
where o.CUS_ID=2;

#5) Display the Supplier details who can supply more than one product

select s.*
from supplier s, product_details p
where s.SUPP_ID = p.SUPP_ID
having count(p.SUPP_ID)>1;

#6) Find the category of the product whose order amount is minimum

select c.*
from orders o inner join product_details pd
on pd.PROD_ID = o.PROD_ID 
inner join product p
on p.PRO_ID = pd.PRO_ID 
inner join category c
on c.CAT_ID = p.CAT_ID
having min(o.ORD_AMOUNT);

#7) Display the Id and Name of the Product ordered after “2021-10-05”
select p.PRO_ID, p.PRO_NAME
from orders o inner join product_details pd
on pd.PROD_ID = o.PROD_ID
inner join product p
on p.PRO_ID = pd.PRO_ID
where o.ORD_DATE>'2021-10-05';


#8) Print the top 3 supplier name and id and their rating on the basis of their rating along
#with the customer name who has given the rating.
select s.SUPP_ID, s.SUPP_NAME, r.RAT_RATSTARS, c.CUS_NAME
from supplier s inner join rating r
on s.SUPP_ID = r.SUPP_ID
inner join customer c
on c.CUS_ID = r.CUS_ID
order by r.RAT_RATSTARS desc limit 3;



#9) Display customer name and gender whose names start or end with character 'A'.
select c.CUS_NAME, c.CUS_GENDER
from customer c
where CUS_NAME like 'A%' or CUS_NAME like '%A';


#10) Display the total order amount of the male customers.
select sum(o.ord_amount)
from orders o
inner join customer c
on c.CUS_ID = o.CUS_ID
where CUS_GENDER='M';



#11) Display all the Customers left outer join with the orders.
select c.*
from customer c left join orders o
on c.CUS_ID = o.CUS_ID;


#12) Create a stored procedure to display the Rating for a Supplier if any along with the
#Verdict on that rating if any like if rating >4 then “Genuine Supplier” if rating >2 “Average
#Supplier” else “Supplier should not be considered”
delimiter &&
create procedure proc()
begin

select s.SUPP_ID, s.SUPP_NAME, r.RAT_RATSTARS,

case
when r.RAT_RATSTARS>4
then 'Genuine Supplier'
when r.RAT_RATSTARS>2
then 'Average Supplier'
else 'Supplier should not be considered'
end as verdict

from supplier s inner join rating r
on r.SUPP_ID = s.SUPP_ID;
end &&

call proc();