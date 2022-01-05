--2b.
SELECT C.ComponentID, C.Purchased_Quantity,BP.Installed_Quantity
FROM 
(SELECT PI.ComponentID, Sum(PI.Quantity) as Purchased_Quantity 
FROM PurchaseOrder PO inner join PurchaseItem PI on PO.PurchaseID = PI.PurchaseID 
WHERE PO.OrderDate < '07-30-2000'
GROUP BY PI.ComponentID) as C
 LEFT JOIN
 (Select BP.ComponentID, SUM(BP.Quantity) as Installed_Quantity
 FROM BikeParts BP 
 WHERE BP.DateInstalled < '07-30-2000'
 GROUP BY BP.ComponentID) as BP on C.ComponentID = BP.ComponentID
WHERE ((C.Purchased_Quantity - (BP.Installed_Quantity))/(BP.Installed_Quantity)*1.0)>0.25

--3
SELECT Employee_ID, SUM(Line_Qty) as 'total'
FROM LGLINE AS LL Inner JOIN LGINVOICE AS LV
on LL.inv_num = LV.inv_num
inner join lgproduct AS LP 
on LP.prod_sku = LL.prod_sku
inner join lgbrand as LB
on LB.brand_id = LP.brand_id
Where Brand_name = 'Binder Prime'
GROUP BY Employee_Id; 

Create Table Ranking( 
Category   varchar(50)null,
Low  int null,
High  int null)
insert into Ranking values ('Poor',0,70)
insert into Ranking values ('Good',71,130)
insert into Ranking values ('Excellent',131,1000)

SELECT LE.Emp_num, LE.Emp_fname, LE.Emp_Lname,LE.Emp_Email, SB.total, R.CATEGORY
from LGEMPLOYEE as LE Left outer JOIN (SELECT Employee_ID, sum(Line_Qty) as 'total'
FROM LGLINE as LL Inner JOIN LGINVOICE as LV
on LL.inv_num = LV.inv_num
inner join lgproduct as LP 
on LP.prod_sku = LL.prod_sku
inner join lgbrand as LB
on LB.brand_id = LP.brand_id
Where Brand_name = 'Binder Prime'
GROUP BY Employee_Id ) as SB
ON LE.Emp_num = SB.Employee_ID 
INNER JOIN Ranking as R ON SB.total >= R.Low and SB.total <=R.High  


--4a

select distinct c.CUSTOMER_NAME
from customerz as c inner join ORDERS o on c.CUSTOMER_NUM = o.CUSTOMER_NUM
	 inner join ORDER_LINE as OL on o.ORDER_NUM = ol.ORDER_NUM
	 inner join ITEM as I on I.ITEM_NUM = OL.ITEM_NUM
where CATEGORY = 'pzl'

--4b 
select customer_name
from customerz
where customer_num in 
(select customer_num
from orders
where order_num in 
(select order_num
from order_line
where item_num in (select item_num
from item
where category = 'pzl')))

--4.d
Select I.ITEM_NUM, AVG(Quoted_Price) as Average_Quoted_Price
from item as I
left outer join ORDER_LINE as O
on I.ITEM_NUM = O.ITEM_NUM
Group by I.ITEM_NUM

--4f
select c.customer_name
from customerz c inner join rep r on c.REP_NUM = r.REP_NUM
where exists(select * from rep where city in ('Fullton', 'grove') and r.city in (' fullton','grove'))

--4g
select c.customer_name
from customerz c inner join rep r on c.REP_NUM = r.REP_NUM
where r.city in (' fullton','grove')