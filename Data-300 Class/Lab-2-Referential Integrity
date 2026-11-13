# Lab-2-Referential Integrity


Lab Instruction 
 
https://docs.google.com/document/d/1gX6PmN2CGe7JoygSL145xjvHuYL3G9mG_rjUU3-YqBk/edit?usp=sharing
 Referential Activity  [Lab] - Submit to the canvas

Submission Instructions - Screenshot the query and result step by step. Submit the document as PDF format. 

Step 1: Relations Creation

Create the Hotel table using the integrity enhancement features of SQL. Now create the Room, Booking, and Guest tables using the integrity enhancement features of SQL with the
Following constraints:

(a) type must be one of Single, Double, or Family.
(b) price must be between £10 and £100.
(c) roomNo must be between 1 and 100.
(d) dateFrom and dateTo must be greater than today’s date.
(e) The same room cannot be double-booked.
(f) The same guest cannot have overlapping bookings.

Hotel (hotelNo, hotelName, city), H002
Room (roomNo, hotelNo, type, price)
Booking (hotelNo, guestNo, dateFrom, dateTo, roomNo)

(H001, G001, 23/09/2025, 27/09/2025, 001003)
(H001, G001, 26/09/2025, 30/09, 2025, 001005)

 
Guest (guestNo, guestName, guestAddress)



Step 2: Insert the data using the following SQL (Show the tables in each data)

-- Hotels
INSERT INTO Hotel VALUES (1, 'Grand Palace', 'London');
INSERT INTO Hotel VALUES (2, 'Ocean View', 'Cape Town');
INSERT INTO Hotel VALUES (3, 'Taj Mahal Hotel', 'Mumbai');


INSERT INTO Hotel VALUES (4, 'Dragon Inn', 'Beijing');
INSERT INTO Hotel VALUES (5, 'Dragon Inn', 'Beijing');

-- Rooms
INSERT INTO Room VALUES (1, 1, 'Single', 50);
INSERT INTO Room VALUES (2, 1, 'Double', 80);
INSERT INTO Room VALUES (1, 2, 'Family', 90);
INSERT INTO Room VALUES (2, 3, 'Single', 45);
INSERT INTO Room VALUES (3, 4, 'Double', 70);

-- Guests
INSERT INTO Guest VALUES (101, 'Alice Johnson', '123 Main St, London, UK');
INSERT INTO Guest VALUES (102, 'Ravi Kumar', 'Mumbai, India');
INSERT INTO Guest VALUES (103, 'Chen Wei', 'Beijing, China');
INSERT INTO Guest VALUES (104, 'Maria Silva', 'Rio de Janeiro, Brazil');
INSERT INTO Guest VALUES (105, 'Andile Nkosi', 'Durban, South Africa');

-- Bookings (future dates to satisfy constraint)
INSERT INTO Booking (hotelNo, guestNo, roomNo, dateFrom, dateTo)
VALUES (1, 101, 1, '2025-10-20', '2025-10-25');

INSERT INTO Booking (hotelNo, guestNo, roomNo, dateFrom, dateTo)
VALUES (3, 102, 2, '2025-11-01', '2025-11-05');

INSERT INTO Booking (hotelNo, guestNo, roomNo, dateFrom, dateTo)
VALUES (4, 103, 3, '2025-12-10', '2025-12-20');


Step 3: Create Views

-- Cheapest hotels view
CREATE VIEW CheapestHotels AS
SELECT h.hotelNo, h.hotelName, h.city, MIN(r.price) AS cheapestPrice
FROM Hotel h
JOIN Room r ON h.hotelNo = r.hotelNo
GROUP BY h.hotelNo, h.hotelName, h.city
HAVING MIN(r.price) = (
    SELECT MIN(price) FROM Room
);


-- Guests from BRICS countries view
CREATE VIEW BRICSGGuests AS
SELECT guestNo, guestName, guestAddress
FROM Guest
WHERE guestAddress ILIKE ANY (ARRAY['%Brazil%', '%Russia%', '%India%', '%China%', '%South Africa%']);


Step 4: Create Two User Groups in Pgadmin

Manager → password = 123manager
Give “CheapestHotels” view access to manager
Give “BRICSGGuests” view access to manager

Staff → password = 123staff
Give “BRICSGGuests” view access to manager

Step 5: Test in PSql

E.g. command login 
\c database_name user_name



Submit step by step screenshot 

See CheapestHotels View as manager
See BRICSGGuests View as manager
Switch to staff (\c database_name user_name)
See CheapestHotels View as staff
See BRICSGGuests View as staff

############



