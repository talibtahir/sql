create table employees (Employee_id number (6), First_name varchar2(30), Last_name varchar2(30), 
Email varchar2(30), Phone_number number(10), Hire_date date, Job_id number, salary number(6), 
Commission_pct number, Manager_id number, Department_id number(6) );

Create table Departments (Department_id number(6), Department_name varchar2(30), manager_id number, Location_id number );

create table Locations (location_id number, Street_address varchar2(60), Postal_code number(6), city varchar2(30), state_proviance VARCHAR2(30), country_id number(6));

Create table countries (Country_id number(6), country_name varchar2(30), Region_id number(6));

Create table regions (region_id number(6), region_name varchar2(30));

Create table Job_history (employee_id number(6), Start_date date, end_date date, job_id number, department_id number(6));

create table Jobs (Job_id number(6), job_title varchar2(30), min_salary number(6), max_salary number(6));

--Alter and add constraints to add keys 

alter table employees add constraint pk_Em_id primary key (Employee_id);

alter table departments add constraint pk_Dp_id primary key (Department_id);

alter table locations add constraint pk_lc_id primary key (location_id);

alter table countries add constraint pk_co_id primary key (country_id);

alter table regions add constraint pk_re_id primary key (region_id);

alter table jobs add constraint pk_jb_id primary key (job_id);





