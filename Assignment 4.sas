libname Orion "/home/u61762417/my_shared_file_links/jhshows0/STA5067/SAS Data/orion";
run;

proc contents data= orion.Employee_Addresses position; run;
proc contents data= orion.Employee_Payroll position; run;







/* Question 1 */

Title1 "Employee with More than 30 Years of Service";
Title2 "As of December 31, 2007";

Proc sql; 
select 
	Employee_Name,
	int(('31DEC2007'd- Employee_Hire_date)/365.25) as YOS label='Years of Service' 

from orion.Employee_Addresses as one Inner Join Orion.Employee_Payroll as two

on one.Employee_Id= two.Employee_Id

where calculated YOS>30

order by 1

; 
quit;
Title1;
Title2;
	







/*Question 2 */

Proc sql;
select 
	Employee_Name label='Name',
	City, 
	Job_title

from orion.sales as a right join orion.Employee_Addresses as b 

on a. Employee_Id= b. Employee_Id

order by 2,3,1
; 
quit; 










/*Question 3 */

Title "US and Australian  Internet Customers Purchasing Foreign Manufactored Products";

proc sql;

select 
	customer_name label='Name',
	sum(supplier_country ne country) as Purchases
	

from orion.Product_dim as a, orion.order_fact as b, orion.Customer as c


where a.Product_Id= b.Product_Id and c.Customer_Id= b.customer_Id and b.employee_Id=99999999

and country in ('AU','US') 

group by customer_name 

having calculated purchases > 0

order by purchases desc

;quit;






/*Question 4 */

Title1 "Employee with More than 30 Years of Service";
Title2 "As of December 31, 2007";

Proc sql; 
create table Employee_service as 

select 
	Employee_Name
	,int(('31DEC2007'd- Employee_Hire_date)/365.25) as YOS label='Years of Service'
	,Manager_Id

from orion.Employee_Addresses as a, Orion.Employee_Payroll as b, orion.Employee_organization as c

where a.Employee_Id= b.Employee_Id and c.employee_Id=b.employee_Id

; 

select 
	a.employee_name,
	YOS,
	b.employee_name as Manager label="Manager Name"

from employee_service as a, orion.employee_addresses as b


where a.Manager_id= b.employee_Id

order by 3, 2 desc, 1

;

quit;
Title1;
Title2;




/* Question 5 */

Proc sql; 
select 
	Employee_name label='Name'
	,city
	,INT(('31DEC2007'd - birth_date)/365.25) as age
	,employee_gender
	
from orion.employee_payroll as a, orion.employee_addresses as b

where a. employee_Id= b. employee_Id and 
country="US"

order by 2, 3, 1

;
quit;
	
	
	
	
	
libname Train "/home/u61762417/my_shared_file_links/jhshows0/STA5067/SAS Data/train";


/*Question 6 */

Title 'New Jersey Employees';

proc sql; 
select 
	substr(firstName,1,1) || "." || LastName as Name 
	,jobcode
	,gender 

from train.staffmaster as a, train.payrollmaster as b

where a.empID=b.EmpID and
	state="NJ"

order by 3, 2

;
quit;








/* Question 7 */

data t1 t2;
		call streaminit(54321);
   do id=1,7,4,2,6,11,9;
		chol=int(rand("Normal",240,40));
		sbp=int(rand("Normal",120,20));
		output t1;
  	end;
   do id1=2,1,5,7,3,9;
		chol=int(rand("Normal",240,40));
		sbp=int(rand("Normal",120,20));
		output t2;
	end;
run;
title "t1";
proc print data=t1 noobs;run;
title "t2";
proc print data=t2 noobs;run;
title;


proc sql;

select 
	coalesce(one.id, two.id1) as Id,
	 one.chol,
	 two.sbp
	 
from t1 as one, t2 as two

where one.id=two.id1

order by 1

;
quit;






















