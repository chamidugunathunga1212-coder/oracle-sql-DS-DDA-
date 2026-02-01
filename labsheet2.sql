DROP TABLE proj_tab CASCADE CONSTRAINTS;
DROP TABLE emp_tab  CASCADE CONSTRAINTS;
DROP TABLE dept_tab CASCADE CONSTRAINTS;

-- Types next
DROP TYPE proj_t FORCE;
DROP TYPE emp_t  FORCE;
DROP TYPE dept_t FORCE;


SELECT object_name, object_type, status
FROM user_objects
WHERE object_name IN ('DEPT_T','EMP_T');


ALTER TYPE dept_t COMPILE;
SHOW ERRORS TYPE dept_t;




------------------- A -----------------------------------

-- Create the types
CREATE TYPE Dept_t FORCE  AS OBJECT(
    dno NUMBER(2),
    dname VARCHAR2(12),
    mgr REF EMP_t
);
/


CREATE TYPE EMP_t AS OBJECT(
    eno NUMBER(4),
    ename VARCHAR2(15),
    edept REF Dept_t,
    salary NUMBER(8,2)

);
/

CREATE TYPE Proj_t AS OBJECT(
    pno NUMBER(4),
    pname VARCHAR2(15),
    pdept REF Dept_t,
    budget NUMBER(10,2)
    
);
/

-- Create the tables
CREATE TABLE Emp_tab OF EMP_t(
    eno PRIMARY KEY,
    ename NOT NULL
);

CREATE TABLE Dept_tab OF Dept_t(
    dno PRIMARY KEY,
    dname NOT NULL
);

CREATE TABLE Proj_tab OF Proj_t(
    pno PRIMARY KEY,
    pname NOT NULL
);


------------------------------- B ---------------------------
-- insert data 

-- insert data to the dept_tab

INSERT INTO dept_tab VALUES(dept_t(10,'DS',NULL));
INSERT INTO dept_tab VALUES(dept_t(20,'IT',NULL));
INSERT INTO dept_tab VALUES(dept_t(30,'SE',NULL));

COMMIT;

-- insert data to the emp_tab
INSERT INTO Emp_tab VALUES(
    emp_t(
        100,
        'chamidu',
        (SELECT REF(d) FROM dept_tab d WHERE d.dno = 10),
        10000
    )
);

INSERT INTO Emp_tab VALUES(
    emp_t(
        200,
        'dewmi',
        (SELECT REF(d) FROM dept_tab d WHERE d.dno = 30),
        12000
    )
);


INSERT INTO Emp_tab VALUES(
    emp_t(
        300,
        'chithira',
        (SELECT REF(d) FROM dept_tab d WHERE d.dno = 20),
        15000
    )
);

COMMIT;


-- insert data to the proj_tab


INSERT INTO Proj_tab VALUES(
    Proj_t(
        101,
        'data project',
        (SELECT REF(d) from dept_tab d WHERE d.dno = 20),
        20000
    )
);

INSERT INTO Proj_tab VALUES(
    Proj_t(
        102,
        'sql project',
        (SELECT REF(d) from dept_tab d WHERE d.dno = 10),
        30000
    )
);

INSERT INTO Proj_tab VALUES(
    Proj_t(
        103,
        'sql project',
        (SELECT REF(d) from dept_tab d WHERE d.dno = 10),
        70000
    )
);

COMMIT;



-- update the dep_table manager column values NULL to employee number

UPDATE dept_tab d
SET d.mgr = (SELECT REF(e) FROM emp_tab e WHERE e.eno = 100)
WHERE d.dno = 10;

UPDATE dept_tab d
SET d.mgr = (SELECT REF(e) FROM emp_tab e WHERE e.eno = 200)
WHERE d.dno = 20;

UPDATE dept_tab d
SET d.mgr = (SELECT REF(e) FROM emp_tab e WHERE e.eno = 300)
WHERE d.dno = 30;


SELECT d.dname as department_name ,e.ename as manager_name 
FROM dept_tab d,emp_tab e
WHERE d.mgr = REF(e);

COMMIT;




--------------------------- C --------------------------

SELECT d.dno,d.dname,e.ename,e.salary
FROM dept_tab d, emp_tab e
WHERE d.mgr = REF(e);



------------------------- D -----------------------------

SELECT * FROM proj_tab;

SELECT p.pname as Project_Name , e.ename as Manager_name , d.dname as Department
FROM dept_tab d,proj_tab p,emp_tab e
WHERE p.pdept = REF(d) AND d.mgr = REF(e) AND p.budget > 50000;


---------------------------- E ----------------------------

SELECT d.dno as department_number , d.dname as department_name , SUM(p.budget) as total_budget
FROM dept_tab d ,proj_tab p
WHERE p.pdept = REF(d)
GROUP BY d.dno,d.dname;


------------------------------ F ------------------------

SELECT e.ename as Manager_name
FROM dept_tab d,proj_tab p,emp_tab e
WHERE p.pdept = REF(d) AND d.mgr = REF(e)
AND p.budget = (SELECT MAX(budget) FROM proj_tab)
;




