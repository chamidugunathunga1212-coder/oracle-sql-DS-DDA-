# IT3031 – Database Systems and Data Driven Applications  
## Practical 1: Relational Model
---

## 📌 Overview
This practical demonstrates the implementation of a **Relational Database Model** using SQL.  
It covers table creation, data insertion, and SQL queries based on a given schema involving employees, departments, projects, and work allocations.

The practical focuses on:
- Relational schema design
- Primary and foreign key relationships
- Data manipulation using SQL
- Multi-table queries using JOIN operations

---

## 🗂️ Database Schema

The database consists of the following four tables:

### 1. Employee
| Column   | Data Type     |
|---------|---------------|
| EmpNo (PK) | VARCHAR(20) |
| fname   | CHAR(20) |
| lname   | CHAR(20) |
| address | VARCHAR(40) |
| salary  | INTEGER |
| DeptNo (FK) | VARCHAR(20) |

### 2. Department
| Column   | Data Type     |
|---------|---------------|
| DeptNo (PK) | VARCHAR(20) |
| DeptName | CHAR(20) |
| Location | VARCHAR(20) |

### 3. Project
| Column   | Data Type     |
|---------|---------------|
| ProjNo (PK) | CHAR(5) |
| Project_Name | VARCHAR(20) |
| DeptNo (FK) | VARCHAR(20) |

### 4. Works_On
| Column   | Data Type     |
|---------|---------------|
| EmpNo (FK) | VARCHAR(20) |
| ProjNo (FK) | CHAR(5) |
| DateWorked | DATE |
| Hours | NUMBER(2) |

---

## 🔑 Key Constraints
- **Primary Keys** ensure uniqueness of records
- **Foreign Keys** maintain referential integrity
- Composite primary key used in `Works_On` table

---

## 🧪 SQL Operations Performed

### ✔ Table Creation
- All tables were created with appropriate data types
- Primary and foreign key constraints were defined

### ✔ Data Insertion
- Sample data inserted for:
  - Employees
  - Departments
  - Projects
  - Employee work assignments

### ✔ Query Execution
The following queries were successfully implemented:

1. Retrieve the name and address of employees working in the **IT department**
2. Retrieve all employee salaries and **distinct salary values**
3. Find employees in **Department 005** who worked **more than 10 hours** on **Project P01**
4. List employees and their projects, ordered by:
   - Department
   - Last name
   - First name
5. Calculate the **new salary** of employees working on the **IOT project** after a **10% increment**

---

## 🛠️ Technologies Used
- **SQL**
- **Oracle Database / MySQL (SQL standard compliant)**
- **Relational Database Concepts**

---

---

## 🎯 Learning Outcomes
- Understanding relational database design
- Applying normalization concepts
- Writing complex SQL queries using JOINs
- Handling real-world relational data scenarios

---

## 👤 Author
**Chamidu Gunathunga**  
BSc (Hons) in IT – Data Science  
SLIIT

---

## 📄 License
This project is created for **academic purposes only** under IT3031 – Database Systems and Data Driven Applications.
