CREATE TYPE depend_t AS OBJECT (
    depname      VARCHAR2(12),
    gender       CHAR(1),
    bdate        DATE,
    relationship VARCHAR2(10)
);
/

CREATE TYPE dependtb_t AS TABLE OF depend_t;
/

CREATE TYPE emp_t AS OBJECT (
    eno        NUMBER(4),
    ename      VARCHAR2(15),
    edept      REF dept_t,
    salary     NUMBER(8,2),
    dependents dependtb_t
);
/

CREATE TYPE dept_t AS OBJECT (
    dno  NUMBER(2),
    dname VARCHAR2(12),
    mgr  REF emp_t
);
/

CREATE TYPE proj_t AS OBJECT (
    pno    NUMBER(4),
    pname  VARCHAR2(15),
    pdept  REF dept_t,
    budget NUMBER(10,2)
);
/

CREATE TYPE work_t AS OBJECT (
    wemp  REF emp_t,
    wproj REF proj_t,
    since DATE,
    hours NUMBER(4,2)
);
/

CREATE TABLE Dept OF dept_t (
    dno PRIMARY KEY
);
/

CREATE TABLE Emp OF emp_t (
    eno PRIMARY KEY
)
NESTED TABLE dependents STORE AS dependent_tb;
/

CREATE TABLE Proj OF proj_t (
    pno PRIMARY KEY
);
/

CREATE TABLE Works OF work_t;
/



INSERT INTO Dept VALUES (dept_t(10, 'DS', NULL));
INSERT INTO Dept VALUES (dept_t(20, 'SE', NULL));
COMMIT;




INSERT INTO Emp VALUES (
  emp_t(
    2143,
    'Kamal',
    (SELECT REF(d) FROM Dept d WHERE d.dno = 10),
    80000,
    dependtb_t()
  )
);

INSERT INTO Emp VALUES (
    emp_t(
        2150,
        'Nimal',
        (SELECT REF(d) FROM Dept d WHERE d.dno = 20),
        60000,
        dependtb_t(
            depend_t('Nimali','F', DATE '2018-03-05', 'Daughter'),
            depend_t('Saman','M', DATE '2016-01-20', 'Son')
        )
    )
);

commit;


UPDATE Dept d
SET d.mgr = (SELECT REF(e) FROM Emp e WHERE e.eno = 2143)
WHERE d.dno = 10;

UPDATE Dept d
SET d.mgr = (SELECT REF(e) FROM Emp e WHERE e.eno = 2150)
WHERE d.dno = 20;

COMMIT;


INSERT INTO Proj VALUES (
    proj_t(
        1001,
        'CustomerAI',
        (SELECT REF(d) FROM Dept d WHERE d.dno = 10),
        500000
    )
);
COMMIT;


INSERT INTO Works VALUES (
    work_t(
        (SELECT REF(e) FROM Emp e WHERE e.eno = 2143),
        (SELECT REF(p) FROM Proj p WHERE p.pno = 1001),
        SYSDATE,
        40
    )
);
COMMIT;


---------------- a -----------------

ALTER TYPE emp_t
ADD MEMBER FUNCTION child_allowance
RETURN NUMBER
CASCADE;
/


CREATE OR REPLACE TYPE BODY emp_t AS
  MEMBER FUNCTION child_allowance
  RETURN NUMBER IS
    cnt NUMBER := 0;
  BEGIN
    IF dependents IS NOT NULL THEN
      SELECT COUNT(*)
      INTO cnt
      FROM TABLE(dependents) d
      WHERE d.relationship = 'CHILD';
    END IF;

    RETURN salary * 0.05 * cnt;
  END;
END;
/


----------------- b ---------------------

SELECT 
    e.ename,
    e.salary,
    e.child_allowance() AS child_allowance
FROM Emp e
WHERE e.child_allowance() > 0;

--------------------- c --------------------

INSERT INTO TABLE (
    SELECT e.dependents
    FROM Emp e
    WHERE e.eno = 2143
)
VALUES (
    depend_t(
        'Jeremy',
        'M',
        DATE '2001-03-12',
        'CHILD'
    )
);
COMMIT;


------------------ d ----------------------

ALTER TYPE emp_t
ADD MEMBER FUNCTION bonus(rate NUMBER)
RETURN NUMBER
CASCADE;
/


CREATE OR REPLACE TYPE BODY emp_t AS
  MEMBER FUNCTION bonus(rate NUMBER)
  RETURN NUMBER IS
  BEGIN
    RETURN salary * rate;
  END;
END;
/


------------------- e ----------------------

SELECT 
    e.ename,
    e.bonus(0.12) AS bonus_amount
FROM Emp e, Dept d
WHERE e.edept = REF(d)
AND d.dname = 'DS';



