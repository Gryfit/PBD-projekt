from faker import Faker
from Lib import random
from datetime import datetime, timedelta
from faker.providers import BaseProvider

fake = Faker('en_US')

#nie wiem jak zrobić z Clients bo to jest pojedyńczy klucz główny który się nie chce inkrementować ;-;
#poprawić conferenceDays w bazie na IDENTITY bo inaczej to się nie da :P

#Open
Conferences = open("Conferences.txt", 'w+')
ConferenceDiscounts = open("ConferenceDiscounts.txt", 'w+')
ConferenceDays = open("ConferenceDays.txt", 'w+')
Workshops = open("Workshops.txt", 'w+')
WorkshopReservations = open("WorkshopReservations.txt",'w+')
Tickets = open("Tickets.txt", 'w+')
People = open("People.txt", 'w+')
Orders = open("Orders.txt", 'w+')
Payments = open("Payments.txt", 'w+')
CompanyClients = open("CompanyClients.txt", 'w+')
PrivateClients = open("PrivateClients.txt", 'w+')
CompanyList = open("PrivateClients.txt", 'w+')
Students = open("Students.txt", 'w+')


#Desc
Conferences.write("StartDate,EndDate,Seats,BasePrice,StudentDiscount\n")
ConferenceDiscounts.write("ConferenceID,UntilDate,Discount\n")
ConferenceDays.write("ConferenceID,Day\n")
Workshops.write("ConferenceDayID,ConferenceDaysConferenceID,Start,Duration,Seats,BasePrice\n")
WorkshopReservations.write("WorkshopID,TicketID,TicketsPersonID\n")
Tickets.write("PersonID,ConferenceDayID,OrderID,ConferenceDaysConferenceID\n")
People.write("CompanyID,LastName,FistName\n")
Orders.write("ClientID,OrderDate,Email,Phone\n")
Payments.write("OrderID,PaymentDate,PaymentValue,BankAccount\n")
CompanyClients.write("CientID,ComapnyID\n")
PrivateClients.write("ClientID,PersonID\n")
CompanyList.write("CompanyName\n")
Students.write("PersonID\n")
#Write
for ConferenceID in range(0, 1000):
    StartDate = fake.date_time()
    DaysInteger = random.randint(1, 3)
    DaysTimeDate = timedelta(DaysInteger)
    EndDate = StartDate + DaysTimeDate
    Seats = random.randint(100, 1000)
    BasePrice = random.randint(10, 50)  # dlaczego tak mało ?
    StudentDiscount = random.randint(0, 50)
    Conferences.write("%s,%s,%u,%u,%u\n" % (StartDate, EndDate, Seats, BasePrice, StudentDiscount))
    dis = random.randint(1, 3)
    for disc in range(0, dis):
        UntilDate = StartDate - timedelta(30*disc)
        Discount = random.randint(0, 25)
        ConferenceDiscounts.write("%u,%s,%u\n" % (ConferenceID, UntilDate, Discount))
    for days in range(0,DaysInteger):
        Day = StartDate + timedelta(days)
        ConferenceDays.write("%u,%s\n" % (ConferenceID, Day))

#Close
Conferences.close()
ConferenceDiscounts.close()
ConferenceDays.close()
Workshops.close()
WorkshopReservations.close()
Tickets.close()
People.close()
Orders.close()
Payments.close()
CompanyClients.close()
PrivateClients.close()
CompanyList.close()
Students.close()