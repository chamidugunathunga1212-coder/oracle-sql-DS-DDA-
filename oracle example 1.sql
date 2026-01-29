SHOW USER; // check the user

//create the type

CREATE TYPE PersonType AS OBJECT(
    id NUMBER,
    name VARCHAR2(30)
);
/

//show the type exists
SELECT type_name
FROM user_types
WHERE type_name = 'PERSONTYPE';

//view the structure of the type
DESC PersonType;

//create the person_table it holds the PersonType type objects
CREATE TABLE person_table OF PersonType;

//show the table exists
SELECT table_name
FROM user_tables
WHERE table_name = 'PERSON_TABLE';

//view the structure of the table
DESC person_table;

//insert the values
INSERT INTO person_table VALUES (PersonType(5,'chamidu'));
INSERT INTO person_table VALUES (PersonType(7,'dewmi'));
COMMIT;


// view the data
SELECT * FROM person_table;

// view the rows as the full object
SELECT VALUE(p)
FROM person_table p;

// check the columns metadata
SELECT column_name, data_type
FROM user_tab_columns
WHERE table_name = 'PERSON_TABLE';



