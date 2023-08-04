create database library ;
use library;
create table books (
  ISBN VARCHAR(255) PRIMARY KEY,
  Book_title VARCHAR(255),
  Category VARCHAR(100),
  Rental_Price DECIMAL(10, 2),
  Status VARCHAR(3),
  Author VARCHAR(255),
  Publisher VARCHAR(255)
); 
create table branch(
  Branch_no INT PRIMARY KEY,
  Manager_Id INT,
  Branch_address VARCHAR(55),
  Contact_no VARCHAR(20)
);
create table employee(
  Emp_Id INT PRIMARY KEY,
  Emp_name VARCHAR(25),
  Position VARCHAR(10),
  Salary DECIMAL(10, 2)
);
drop table customer;
create table customer(
   Customer_Id INT PRIMARY KEY,
  Customer_name VARCHAR(25),
  Customer_address VARCHAR(25),
  Reg_date DATE
  );
create table issueStatus(
 Issue_Id INT PRIMARY KEY,
  Issued_cust INT,
  Issued_book_name VARCHAR(55),
  Issue_date DATE,
  Isbn_book VARCHAR(55),
  FOREIGN KEY (Issued_cust) REFERENCES Customer(Customer_Id),
  FOREIGN KEY (Isbn_book) REFERENCES Books(ISBN)
);
create table returnStatus(
    Return_Id INT PRIMARY KEY,
  Return_cust INT,
  Return_book_name VARCHAR(25),
  Return_date DATE,
  Isbn_book2 VARCHAR(55),
  FOREIGN KEY (Return_cust) REFERENCES Customer(Customer_Id),
  FOREIGN KEY (Isbn_book2) REFERENCES Books(ISBN)
);
INSERT INTO books (ISBN, Book_title, Category, Rental_Price, Status, Author, Publisher) VALUES
  ('BL00001', 'fundamental principle', 'Economics', 100, 'yes', 'Alfred Marshell', 'Elgar '),
  ('BL00002', 'The wealth of Nation', 'Economics', 150, 'yes', 'JM Keynes ', 'DC Publications'),
  ('BL00003', 'Capitalism and Freedom ','Economics', 275, 'yes', 'Milton friedman ', 'KC publication'),
  ('BL00004', 'Principle of Political Economy', 'Economics', 299, 'yes',  'Alfred marshell', 'Dc Books'),
  ('BL00005', 'Indian Currency and Finance', 'Economics', 125, 'yes', 'J M Keynes', '16 Th Edition ');

INSERT INTO branch (Branch_no, Manager_Id, Branch_address, Contact_no)
VALUES
  (1, 101, 'vsgsh', ' 36954878'),
  (2, 102, 'huhj', ' 4589765'),
  (3, 103, 'eyuoisbh', ' 4579136'),
  (4, 104, ' aaaaanb', ' 4795462'),
  (5, 105, 'gshgd', ' 4879536');
INSERT INTO employee (Emp_Id, Emp_name, Position, Salary)
VALUES
  (101, 'Viswa', 'Clerk', 25000.00),
  (102, 'rahul', 'Librarian', 500000.00),
  (103, ' Aneesh', 'Clerk', 30000.00),
  (104, 'Regu', 'Manager', 580000.00),
  (105, 'Munnas', 'Clerk', 20000.00);
INSERT INTO customer (Customer_Id, Customer_name, Customer_address, Reg_date)
VALUES
  (1, 'Vijith', 'ert', '2020-11-02'),
  (2, 'Ravi', 'ggg', '2021-11-09'),
  (3, 'Sheethal', 'vvvv', '2020-02-20'),
  (4, 'Parvana', 'oki', '2023-01-11'),
  (5, 'aswathi', 'plou', '2022-10-15');
 INSERT INTO IssueStatus (Issue_Id, Issued_cust, Issued_book_name, Issue_date, Isbn_book)
VALUES
  (1, 1, 'fundamental principle', '2023-07-10', 'BL00001'),
  (2, 2, 'The wealth of Nation', '2023-07-12', 'BL00002'),
  (3, 3, 'Capitalism and Freedom', '2023-07-20', 'BL00003'),
  (5, 5, 'Indian Currency and Finance', '2023-07-22', 'BL00006');
 INSERT INTO returnStatus (Return_Id, Return_cust, Return_book_name, Return_date, Isbn_book2)
VALUES
  (1, 1, 'Capitalism and Freedom' ,'2023-07-15', 'BL00001'),
  (2, 2, 'Indian Currency and Finance', '2023-07-20', 'BL00002'),
  (3, 3, 'fundamental principle', '2023-07-25', 'BL00003'),
  (5, 5, 'The wealth of Nation', '2023-08-05', 'BL00005');

SELECT Book_title, Category, Rental_Price
FROM books
WHERE Status = 'yes';

SELECT Emp_name, Salary
FROM employee
ORDER BY Salary DESC;


SELECT b.Book_title, c.Customer_name
FROM Books b
JOIN IssueStatus i ON b.ISBN = i.Isbn_book
JOIN Customer c ON i.Issued_cust = c.Customer_Id;



SELECT Emp_name, Position
FROM employee
WHERE Salary > 30000;


SELECT Customer_name
FROM customer
WHERE Reg_date < '2023-01-10'
AND Customer_Id NOT IN (SELECT DISTINCT Issued_cust FROM IssueStatus);


SELECT Branch.Branch_no, COUNT(*) AS Total_Employees
FROM Branch
JOIN Employee ON Branch.Manager_Id = Employee.Emp_Id
GROUP BY Branch.Branch_no;

SELECT DISTINCT c.Customer_name
FROM Customer c
JOIN IssueStatus i ON c.Customer_Id = i.Issued_cust
WHERE i.Issue_date >= '2023-02-10'
AND i.Issue_date < '2023-01-12';


SELECT Book_title
FROM Books
WHERE Category = 'c';


SELECT Branch.Branch_no, COUNT(*) AS Total_Employees
FROM Branch
JOIN Employee ON Branch.Manager_Id = Employee.Emp_Id
GROUP BY Branch.Branch_no
HAVING COUNT(*) > 3;