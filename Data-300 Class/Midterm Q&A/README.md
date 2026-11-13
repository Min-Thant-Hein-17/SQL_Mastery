# Midterm Q&A: Answer the questions 

<img width="1588" height="1668" alt="image" src="https://github.com/user-attachments/assets/dc0d1d30-e3f3-4568-9024-c8469e44a3d0" />


ANSWER THE FOLLOWING QUESTIONS IN 1-2 sentences.

1.   Can there be a Customer (Client) without holding any Lease? (2 marks)

2.   Can a PrivateOwner and a BusinessOwner own the same property? (2 marks)

3.   How many Staff can a Manager supervise according to the diagram? (2 marks).

4.   Choose any two 1..1 relationships from the diagram and explain in 1-2 sentences for each relationship. (2 marks)

5.   Can a PropertyForRent exist without being advertised in a Newspaper? (2 marks)

6.  If a Client is deleted from the system, which related entities might also be affected? (2 marks)

7.   If a Client holds multiple leases, what is the minimum and maximum number of leases they can hold? (2 marks)

8.  Can a PropertyForRent be both advertised and not leased at the same time? (2 marks)

9.  Can a Staff work under both a Manager and a Supervisor at the same time? (2 marks)

10. If a Branch is deleted, what happens to its associated Staff? (2 marks)


Answers: 

1.  Yes, there can be a Customer (Client) without holding any Lease, because the relationship between Client and Lease is 0..* on Lease. This means a client can exist without any lease.

2. No, a PrivateOwner and a BusinessOwner cannot own the same property, because the Owner specialization is "Mandatory, OR". Thus, a property is owned by one owner who is either private or business owner, not both.

3. A Manager can supervise between 1 and 10 staff members, as indicated by the 1..10 cardinality.

4. 

Manager–Branch: Each branch is managed by exactly one manager, and also each manager manages exactly one branch.

Owner–PropertyForRent: Each property is owned by exactly one owner, and each owner also owns at least one property.

5. Yes, a PropertyForRent can exist without being advertised in a Newspaper, because the Advertises relationship is 0..*. Therefore, advertising is optional.

6. Deleting a client may affect related Lease records and Preference records because of the Holds relationship for Lease records and the States relationship for Preference records.

7.  If a Client holds multiple leases, minimum is 0, maximum is unlimited, 0..*.

8. Yes, a PropertyForRent can be both advertised and not leased at the same time because advertising and leasing are independent relationships.

9. Yes, a Staff can work under both a Manager and a Supervisor at the same time, because every Staff member must have one Manager and optionally can have one Supervisor. Thus, it is possible for a Staff member to have both.

10. If a Branch is deleted, staff cannot exist without a branch, 1..1. Therefore, deleting a branch would require deleting or reassigning its staff.


