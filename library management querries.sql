create database Library;
use Library;
create table Branch(
   Branch_no int PRIMARY KEY ,
   Manager_Id int, 
   Branch_address varchar(100),  
   Contact_no varchar(15)
);
insert into Branch values
(1,201,'Malappuram','9876543210'),
(2,202,'Calicut','9876543211'),
(3,203,'Kochi','9876543212'),
(4,204,'Trivandrum ','9876543213');

create table Employee(
   Emp_Id int PRIMARY KEY,
   Emp_name varchar(50), 
   Position  varchar(50),
   Salary decimal(10,2),
   Branch_no int,
   foreign key (Branch_no) references Branch(Branch_no)
);
insert into Employee values
(201,'Rahul','Manager',65000,1),
(202,'Anita','Manager',55000,2),
(203,'Joseph','Manager',48000,3),
(204,'Meera','Manager',70000,4),
(205,'Arjun','Assistant',30000,1),
(206,'Sneha','Clerk',25000,1),
(207,'David','Assistant',28000,2),
(208,'Fatima','Clerk',26000,3),
(209,'Nikhil','Assistant',32000,4),
(210,'Sara','Clerk',24000,4),
(211,'Deepa','Assistant',28000,1),
(212,'Kiran','Clerk',22000,1),
(213,'Anu','Assistant',26000,1),
(214,'Deepa','Clerk',24000,2);

create table Books(  
   ISBN varchar(20)PRIMARY KEY ,
   Book_title  varchar(100),
   Category  varchar(50),
   Rental_Price decimal(6,2),
   Status  varchar(5),
   Author  varchar(50),
   Publisher varchar(50)
);
insert into Books values
('B101','History of India','History',30,'yes','Romila Thapar','Penguin'),
('B102','World History','History',35,'yes','John Roberts','Oxford'),
('B103','SQL Basics','Technology',20,'yes','Alan Beaulieu','OReilly'),
('B104','Python Programming','Technology',40,'no','Mark Lutz','OReilly'),
('B105','Business Analytics','Business',50,'yes','James Evans','Pearson'),
('B106','Machine Learning','Technology',60,'yes','Andrew Ng','Stanford'),
('B107','Financial Accounting','Commerce',25,'yes','Robert Brown','McGraw Hill');

create table Customer ( 
   Customer_Id int PRIMARY KEY ,
   Customer_name  varchar(50),
   Customer_address  varchar(100),
   Reg_date date
);
insert into Customer values
(301,'Aisha','Malappuram','2021-05-10'),
(302,'Rahman','Calicut','2023-02-12'),
(303,'Sneha','Kochi','2020-09-18'),
(304,'Vivek','Trivandrum','2022-03-25'),
(305,'Fatima','Malappuram','2021-12-01'),
(306,'Arun','Calicut','2023-01-15');

create table IssueStatus(  
   Issue_Id int PRIMARY KEY  ,
   Issued_cust int,
   Issued_book_name varchar(100),
   Issue_date date,
   Isbn_book varchar(20),
   foreign key (issued_cust) references customer(customer_id),
   foreign key (isbn_book) references books(isbn)
);
insert into IssueStatus values
(401,302,'History of India','2023-06-10','B101'),
(402,304,'SQL Basics','2023-06-15','B103'),
(403,306,'Machine Learning','2023-07-01','B106'),
(404,302,'Business Analytics','2023-07-10','B105');

create table ReturnStatus(
   Return_Id int PRIMARY KEY , 
   Return_cust  int,
   Return_book_name varchar(100), 
   Return_date  date,
   Isbn_book2 varchar(20),
   foreign key (isbn_book2) references books(isbn)
);
insert into ReturnStatus values
(501,602,'History of India','2023-06-20','B101'),
(502,604,'SQL Basics','2023-06-25','B103'),
(503,606,'Machine Learning','2023-07-10','B106');

select * from Branch;
select * from Employee;
select * from Books;
select * from Customer;
select * from IssueStatus;
select * from ReturnStatus;
-- 1 Retrieve the book title, category, and rental price of all available books. 
select Book_title,Category,Rental_Price from Books where Status='yes';
-- 2 List the employee names and their respective salaries in descending order of salary. 
select Emp_name,Salary from Employee order by Salary desc;
-- 3 Retrieve the book titles and the corresponding customers who have issued those books. 
select IssueStatus.Issued_book_name,Customer.Customer_name from IssueStatus 
join Customer on Customer.Customer_Id =IssueStatus.Issued_cust;
-- 4 Display the total count of books in each category. 
select Category,count(*) as count_books from Books group by Category;
-- 5 Retrieve the employee names and their positions for the employees whose salaries are above Rs.50,000. 
select emp_name,position from Employee where salary >50000;
-- 6 List the customer names who registered before 2022-01-01 and have not issued any books yet. 
select Customer_name from Customer where reg_date < '2022-01-01' and Customer_Id
 not in(select Issued_cust from IssueStatus) ;
 -- 7 Display the branch numbers and the total count of employees in each branch. 
 select branch_no, count(*) as total_employees from employee group by branch_no;
 -- 8  Display the names of customers who have issued books in the month of June 2023.
 select Customer.Customer_name from Customer join IssueStatus on
 Customer.Customer_Id =IssueStatus.Issued_cust 
 where IssueStatus.Issue_date between '2023-06-01' and '2023-06-30';
 -- 9 Retrieve book_title from book table containing history. 
 select Book_title from Books where Book_title like '%history%';
 -- 10 Retrieve the branch numbers along with the count of employees for branches having more than 5 employees
 select branch_no, count(*) as total_employees from employee 
 group by branch_no having count(*) > 5;
 -- 11 Retrieve the names of employees who manage branches and their respective branch addresses.
select Employee.emp_name, Branch.branch_address from Employee join Branch  on
 Employee.emp_id = Branch.manager_id;
 -- 12 Display the names of customers who have issued books with a rental price higher than Rs. 25.
 select Customer.customer_name from customer join IssueStatus on Customer.customer_id = IssueStatus.issued_cust join Books 
on IssueStatus.isbn_book = Books.isbn where Books.rental_price > 25;





