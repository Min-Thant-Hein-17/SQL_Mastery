# SQL DDL Practice 

https://docs.google.com/document/d/1ugcVcxBOFaERdC1FLlehX6trc8B8YAeC-oBLh0EPCSg/edit?usp=sharing 

Design a schema for BookNest, an online book rental service. The database must enforce integrity automatically. Read the scenario rules carefully and implement them when writing DDL.
Part A — Tables  
Use these exact column names and data types. (Choose suitable sizes where shown.)
1) Member
member_id — INT


first_name — VARCHAR(50)


last_name — VARCHAR(50)


email — VARCHAR(100)


phone_number — VARCHAR(20)


join_date — DATE


membership_type — VARCHAR(10) (values come from the scenario)


2) Publisher
publisher_id — INT


publisher_name — VARCHAR(100)


country — VARCHAR(50)


3) Book
book_id — INT


title — VARCHAR(200)


author — VARCHAR(100)


genre — VARCHAR(30)


price — DECIMAL(6,2)


stock — INT


publisher_id — INT (links to Publisher)


4) Rental
rental_id — INT


member_id — INT (links to Member)


book_id — INT (links to Book)


rental_date — DATE


return_date — DATE


status — VARCHAR(10) (values come from the scenario)


5) Payment
payment_id — INT


rental_id — INT (links to Rental)


amount — DECIMAL(6,2)


payment_date — DATE


6) Review
review_id — INT


member_id — INT (links to Member)


book_id — INT (links to Book)


rating — INT


review_text — TEXT


Part B — Scenario Rules (Describe the required integrity/referential)
Member
Every member has a unique identifier. ⇒ ID PK


No two members can share the same email. ⇒  UNIQUE (Email)
Members are either “Regular” or “Premium” (only these). ⇒ CHECK
When a member is removed: ⇒ DELETE CASCADE
 • All of their rentals are removed.
 • All of their reviews are removed.


Publisher
Every publisher has a unique identifier.


If a publisher is removed:
 • Books they published must remain, but their publisher information becomes unknown rather than removing the books.


Book
Every book has a unique identifier and must be linked to a valid publisher.


Price must be greater than zero.


Stock must never be negative.


If a book is removed:
 • Past rentals must stay in the system, but the book reference in those rentals becomes empty/missing (keep history).
 • Any reviews for that book are removed.


Rental
Every rental has a unique identifier and must link to a valid member and a valid book.


A member cannot rent the same book more than once on the same date.


The return date must be later than the rental date.


If a member is removed, all of their rentals are removed.


If a rental is removed, any related payments are removed.


No two rentals for the same book should overlap in time (avoid double-booking).


Payment
Every payment belongs to exactly one rental.


If a rental is removed, its payment is removed.


Payment amount must be positive.


Review
Each review belongs to an existing member and an existing book.


If the member or the book is removed, the review is removed.


A member can review a given book only once.


Ratings must be between 1 and 5.


Part C — Student Tasks
Create the schema


Write DDL to create all six tables with appropriate keys, relationships, and integrity based on the scenario.


Enforce business rules


Implement all uniqueness, value ranges, allowed value sets, date logic, and the “unknown/empty” behavior described above.


Prevent double-booking for the same book (time overlap).


Prevent duplicate reviews by the same member for the same book.


Change requests
 a) Add a column published_year INT to Book.
 b) Remove phone_number from Member.
 c) Change country in Publisher to default to “Unknown”.
 d) Make join_date in Member default to today’s date.












Sample INSERT Data for BookNest
Insert Publishers
-- Insert some publishers
INSERT INTO publisher (publisher_id, publisher_name, country)
VALUES
    (1, 'TechPress', 'USA'),
    (2, 'EduBooks', 'UK'),
    (3, 'Global Reads', 'Thailand');

Insert Members
-- Insert members with different membership types
INSERT INTO member (member_id, first_name, last_name, email, phone_number, membership_type)
VALUES
    (101, 'Alice', 'Wong', 'alice@example.com', '0812345678', 'Regular'),
    (102, 'Bob', 'Smith', 'bob@example.com', '0898765432', 'Premium'),
    (103, 'Charlie', 'Ng', 'charlie@example.com', NULL, 'Regular');

Insert Books
-- Insert books linked to publishers
INSERT INTO book (book_id, title, author, genre, price, stock, publisher_id)
VALUES
    (201, 'Database Systems', 'C. J. Date', 'Science', 50.00, 3, 1),
    (202, 'Machine Learning Basics', 'Andrew Ng', 'Science', 60.00, 2, 1),
    (203, 'Storytelling for Data', 'Cole N. Knaflic', 'Non-Fiction', 45.00, 5, 2),
    (204, 'Children of Time', 'Adrian Tchaikovsky', 'Fiction', 30.00, 4, 3);

Insert Rentals
-- Insert rentals for members
INSERT INTO rental (rental_id, member_id, book_id, rental_date, return_date, status)
VALUES
    (301, 101, 201, DATE '2025-09-01', DATE '2025-09-07', 'Borrowed'),
    (302, 102, 202, DATE '2025-09-02', DATE '2025-09-10', 'Borrowed'),
    (303, 101, 203, DATE '2025-09-05', DATE '2025-09-12', 'Returned');
Insert Payments
-- Insert payments related to rentals
INSERT INTO payment (payment_id, rental_id, amount, payment_date)
VALUES
    (401, 303, 10.00, DATE '2025-09-06'),
    (402, 302, 15.00, DATE '2025-09-03');

Insert Reviews
-- Insert reviews for books
INSERT INTO review (review_id, member_id, book_id, rating, review_text)
VALUES
    (501, 101, 201, 5, 'Very informative book, highly recommended!'),
    (502, 102, 203, 4, 'Great insights on data storytelling.'),
    (503, 101, 204, 3, 'Interesting but a bit long.');

Suggested Student Tasks with This Data
Check uniqueness: Try inserting a member with a duplicate email → should fail.


Test referential integrity:


Delete a publisher → check if publisher_id in related books becomes NULL or default as per their design.


Delete a member → verify that rentals and reviews are automatically deleted.


Test constraints:


Try inserting a book with negative price or stock → should fail.


Try inserting a rental where return_date <= rental_date → should fail.


Try renting the same book twice for the same date → should fail.


Test cascading deletes: Delete a rental and confirm its payment is deleted automatically.

Test scenarios (write sample statements to demonstrate behavior)


Deleting a Member with existing rentals, payments, and reviews—show what remains.


Deleting a Publisher with existing books—show how books are affected.


Deleting a Book with past rentals and reviews—show what remains/changes.


Attempting:
 • a negative book price or stock,
 • a rental where return_date ≤ rental_date,
 • two rentals of the same book that overlap,
 • a duplicate review by the same member for the same book,
 • exceeding rental limits for Regular vs Premium.


