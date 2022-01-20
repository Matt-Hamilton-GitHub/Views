


SQL> CREATE VIEW CONTACT
   AS SELECT name, phone
   FROM publisher

View created.

SQL> SELECT * FROM contact;

NAME                    PHONE
----------------------- ------------
PRINTING IS US          000-714-8321
PUBLISH OUR WAY         010-410-0010
AMERICAN PUBLISHING     800-555-1211
READING MATERIALS INC.  800-555-9743
REED-N-RITE             800-555-8284


Answer to Question 2
====================

SQL> CREATE OR REPLACE VIEW contact
   AS SELECT name, phone
   FROM publisher
   WITH READ ONLY;

View created.

SQL> UPDATE CONTACT
    SET PHONE = 000
    WHERE NAME ='PRINTING IS US';
SET PHONE = 000
    *
ERROR at line 2:
ORA-42399: cannot perform a DML operation on a read-only view

Answer to Question 3
====================

SQL> CREATE FORCE VIEW HOMEWORK13
    AS SELECT COL1, COL2
    FROM FIRSTATTEMPT;

Warning: View created with compilation errors.


Answer to Question 4
====================

SQL> DESC HOMEWORK13;
ERROR:
ORA-24372: invalid object for describe


Answer to Question 5
====================
SQL> CREATE VIEW reorderinfo
   AS SELECT isbn, title, contact, phone
  FROM books JOIN publisher USING(pubid)

View created.


Answer to Question 6
====================
SQL> UPDATE REORDERINFO
        SET CONTACT = 'MATT HAMILTON'
         WHERE PHONE ='000-714-8321';
     SET CONTACT = 'MATT HAMILTON'
         *
ERROR at line 2:
ORA-01779: cannot modify a column which maps to a non key-preserved table

SQL>

ERROR at line 2:
ORA-01779: cannot modify a column which maps to a non key-preserved table

The error message occures because the view contains more than one table, updates can be applied to only one table.
One of the tables containes the primary key that the view uses to uniquely identify recoirds it displays

Answer to Question 7
====================

SQL> UPDATE REORDERINFO
  2  SET ISBN = '950430465'
  3  WHERE TITLE = 'REVENGE OF MICKEY';
UPDATE REORDERINFO
*
ERROR at line 1:
ORA-02292: integrity constraint (SCOTT.ORDERITEMS_ISBN_FK) violated - child record found

The error occured because orderitems table uses the foreigh key dependencies (SCOTT.ORDERITEMS_ISBN_FK)

Answer to Question 8
====================


SQL> DELETE FROM reorderinfo
  2  WHERE contact = 'TOMMIE SEYMOUR';
DELETE FROM reorderinfo
*
ERROR at line 1:
ORA-02292: integrity constraint (SCOTT.ORDERITEMS_ISBN_FK) violated - child record found

the error coused by the constraint  that does not allowe to delete the data because it uses the foreigh key

Answer to Question 9
====================

SQL> rollback;

Rollback complete.

Answer to Question 10
====================

SQL> DROP VIEW reorderinfo;

View dropped


			Advanced Challenge
			------------------


Answer to Question 1
====================


SQL> CREATE OR REPLACE VIEW MOSTPOPBOOKS
    AS SELECT title, SUM(quantity) QUANTITY, TO_CHAR(((retail-cost)/cost*100),'999.99') "PROFIT %"
    FROM books join orderitems using(isbn)
    GROUP BY title, TO_CHAR(((retail-cost)/cost*100),'999.99')
    ORDER BY QUANTITY DESC;

View created.


SQL> CREATE OR REPLACE VIEW FIVEMOSTPOPBOOKS
   AS SELECT * FROM MOSTPOPBOOKS
   WHERE ROWNUM <= 5;

View created.


SQL> SELECT * FROM FIVEMOSTPOPBOOKS;

TITLE                            QUANTITY PROFIT
------------------------------ ---------- -------
COOKING WITH MUSHROOMS                  8   59.60
DATABASE IMPLEMENTATION                 7   78.18
PAINLESS CHILD-REARING                  6   87.40
REVENGE OF MICKEY                       5   54.93
BIG BEAR AND LITTLE DOVE                4   68.23

