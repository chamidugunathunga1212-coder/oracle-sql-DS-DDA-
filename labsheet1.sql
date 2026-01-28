// Create your own user

ALTER SESSION SET CONTAINER = FREEPDB1;


CREATE USER uni_user IDENTIFIED BY "Uni#12345";
GRANT CREATE SESSION, CREATE TABLE, CREATE VIEW, CREATE SEQUENCE TO uni_user;
ALTER USER uni_user QUOTA UNLIMITED ON USERS;


//1. create the tables

CREATE TABLE EMPLOYEE(
    EmpNo VARCHAR(20),
    fname CHARACTER(20),
    lname CHARACTER(20),
    address VARCHAR(40),
    salary INTEGER,
    DeptNo VARCHAR(20),
    
    PRIMARY KEY (EmpNo),
    FOREIGN KEY (DeptNo) REFERENCES Department (DeptNo)
);


CREATE TABLE Department(
    DeptNo VARCHAR(20),
    DeptName CHARACTER(20),
    Location VARCHAR(20),

    PRIMARY KEY (DeptNo)
);


CREATE TABLE Project(
    ProjNo CHARACTER(5),
    Project_Name VARCHAR(20),
    DeptNo VARCHAR(20),

    PRIMARY KEY (ProjNo),
    FOREIGN KEY (DeptNo) REFERENCES Department (DeptNo)
);

CREATE TABLE Works_On(
    EmpNo VARCHAR(20),
    ProjNo CHARACTER(5),
    DateWorked DATE,
    Hours NUMBER(2),
    
    PRIMARY KEY (EmpNo,ProjNo),
    FOREIGN KEY (EmpNo) REFERENCES EMPLOYEE (EmpNo),
    FOREIGN KEY (ProjNo) REFERENCES Project (ProjNo)
);


//2. inster the rows

INSERT ALL
INTO EMPLOYEE VALUES ('Emp01','John','Scott','Mysore',45000,'003')
INTO EMPLOYEE VALUES ('Emp02','James','Smith','Bangalore',50000,'005')
INTO EMPLOYEE VALUES ('Emp03','Edward','Hedge','Bangalore',65000,'002')
INTO EMPLOYEE VALUES ('Emp04','Santhosh','Kumar','Delhi',80000,'002')
INTO EMPLOYEE VALUES ('Emp05','Veena','M','Mumbai',45000,'004')
SELECT DUMMY  FROM dual;        
    
INSERT ALL
INTO Department VALUES ('001','Accounts','Bangalore')
INTO Department VALUES ('002','IT','Mumbai')
INTO Department VALUES ('003','ECE','Mumbai')
INTO Department VALUES ('004','ISE','Mumbai')
INTO Department VALUES ('005','CSE','Delhi')
SELECT DUMMY  FROM dual;


INSERT ALL
INTO Project VALUES ('P01','IOT','005')
INTO Project VALUES ('P02','Cloud','005')
INTO Project VALUES ('P03','BankMgmt','004')
INTO Project VALUES ('P04','Sensors','003')
INTO Project VALUES ('P05','BigData','002')
SELECT DUMMY  FROM dual;


INSERT ALL
INTO Works_On VALUES ('Emp02','P03','02-OCT-2018',4)
INTO Works_On VALUES ('Emp01','P02','22-JAN-2014',13)
INTO Works_On VALUES ('Emp02','P02','19-JUN-2020',15)
INTO Works_On VALUES ('Emp02','P01','11-JUN-2020',10)
INTO Works_On VALUES ('Emp01','P04','08-FEB-2009',6)
INTO Works_On VALUES ('Emp01','P05','02-SEP-2011',7)
SELECT DUMMY  FROM dual;



//3

// a
SELECT e.fname,e.address
FROM EMPLOYEE e
INNER JOIN Department d on e.DeptNo = d.DeptNo
WHERE d.DeptName = 'IT';

// b

SELECT DISTINCT salary
FROM EMPLOYEE;

// c

SELECT e.fname,e.lname
FROM EMPLOYEE e
INNER JOIN Works_On w on e.EmpNo = w.EmpNo
WHERE e.DeptNo = '005' and w.Hours > 10 and w.ProjNo = 'P01';

// d

SELECT d.DeptName, e.lname, e.fname, p.Project_Name
FROM EMPLOYEE e
INNER JOIN Department d on e.DeptNo = d.DeptNo
INNER JOIN Works_On w on e.EmpNo = w.EmpNo
INNER JOIN Project p ON w.ProjNo = p.ProjNo
ORDER BY d.DeptName, e.lname, e.fname;

// e
SELECT e.fname, e.lname, e.salary as before_salary ,e.salary+(e.salary * 0.10) as after_salary
FROM EMPLOYEE e
INNER JOIN Works_On w on e.EmpNo = w.EmpNo
INNER JOIN Project p ON w.ProjNo = p.ProjNo
WHERE p.Project_Name = 'IOT';



DROP TABLE EMPLOYEE;





