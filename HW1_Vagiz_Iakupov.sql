-- Изначально данные в таблице удовлетворяли 1НФ, то есть были атомары
-- для того что бы соответствовать 2НФ собираем все данные по клиентам в одну таблицу
create table customers (
customer_id int
,first_name varchar
,last_name varchar
,gender varchar
,dob date
,job_title varchar
,job_industry_category varchar
,wealth_segment varchar
,deceased_indicator varchar
,owns_car varchar
);
-- так же для соответствия 2НФ формируем отдельно таблицу адрессов так как по одному адресу могут проживать разные клиенты 
create table addresses (
address_id int
,customer_id int
,address varchar
,postcode varchar
,state varchar
,country varchar
,property_valuation int
);
-- каждая транцакция произведена по отдельности, не обнаружил в исходных данных чтобы в одной транзакции пресутствовало болше одного product_id
create table transactions (
transaction_id int
,product_id int
,customer_id int
,transaction_date date
,online_order boolean
,order_status varchar
);
-- для соответствия 3 нф информации о продукции разделил на две таблици products и brands
create table products (
product_id int
,brand_id int
,brand varchar
,product_line varchar
,product_class varchar
,product_size varchar
,list_price decimal(10, 2)
,standard_cost decimal(10, 2)
);

create table brands (
brand_id int
,brand_name varchar
);

select * from products;

-- создаю временную таблицу для того что бы удалить дублированные строки
create table temp_products as
select distinct on (product_id) *
from products
order by product_id, (select null); 

truncate table products;

insert into products 
select * from temp_products;

drop table temp_products;

select * from brands_1;

update Products
set brand_id = (
select brand_id
from Brands_1
where Brands_1.brand_name = Products.brand
);

alter table products drop column brand;

drop table products_tmp;
drop table brands;
