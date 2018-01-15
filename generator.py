from faker import Faker
from Lib import random
from datetime import datetime, timedelta
from faker.providers import BaseProvider
import pymssql

BEGINNING = datetime(2016, 1, 8, 22, 40, 1)
END = datetime(2018, 1, 8, 22, 40, 1)

fake = Faker('en_US')

server = "mssql.iisg.agh.edu.pl ENSURE FAIL"
user = "kbak"
password = "------"

conn = pymssql.connect(server, user, password, "kbak_a")
cursor = conn.cursor()

for ConferenceID in range(1, 1001):
    StartDate = fake.date_time_between_dates(BEGINNING,END)
    Duration = timedelta(random.randint(1, 3))
    EndDate = StartDate + Duration
    Seats = random.randint(100, 1000)
    BasePrice = random.randint(1000, 50000)/100
    StudentDiscount = random.randint(0, 50)

    cursor.execute('INSERT INTO Conferences VALUES (%s,%s,%u,%.2f,%u)' %
                   (StartDate,EndDate,Seats,BasePrice,StudentDiscount))
    conn.commit()
    Temp = StartDate
    for Levels in range(random.randint(1, 3)):
        DiscountLevel = Temp - timedelta(30)
        cursor.execute('INSERT INTO ConferencesDiscounts VALUES (%u,%s,%u)' %
                       (ConferenceID,DiscountLevel,random.randint(1, 50)))
        conn.commit()
        Temp = DiscountLevel
for CompanyID in range(1,501):
    CompanyName = fake.company()
    cursor.execute('INSERT INTO CompanyList VALUES (%s)' %
                   CompanyName)
    conn.commit()
for ClientID in range(1, 10001):
    Email = fake.email()
    Phone = fake.phone_number()
    cursor.execute('INSERT INTO Clients VALUES (%s,%s)' %
                   (Email, Phone))
    conn.commit()
    numOfOrders =  random.randint(2, 5)
    if random.randint(0, 1) == 1:
        cursor.execute('INSERT INTO CompanyClients VALUES (%u,%u)' %
                       (ClientID, random.randint(1, 501)))
        numOfOrders = random.randint(100, 200)
        conn.commit()
    for Orders in range (1,numOfOrders):
        OrderDate =fake.date_time_between_dates(BEGINNING,END);
        cursor.execute('INSERT INTO Orders VALUES (%u,%s)' %
                       (ClientID, fake.date_time_between_dates(BEGINNING,END)))
        conn.commit()
conn.close()






















# Conferences.write("StartDate,EndDate,Seats,BasePrice,StudentDiscount\n")
# ConferenceDiscounts.write("ConferenceID,UntilDate,Discount\n")
# ConferenceDays.write("ConferenceID,Day\n")
# Workshops.write("ConferenceDayID,ConferenceDaysConferenceID,Start,Duration,Seats,BasePrice\n")
# WorkshopReservations.write("WorkshopID,TicketID,TicketsPersonID\n")
# Tickets.write("PersonID,ConferenceDayID,OrderID,ConferenceDaysConferenceID\n")
# People.write("CompanyID,LastName,FistName\n")
# Orders.write("ClientID,OrderDate,Email,Phone\n")
# Payments.write("OrderID,PaymentDate,PaymentValue,BankAccount\n")
# CompanyClients.write("CientID,ComapnyID\n")
# PrivateClients.write("ClientID,PersonID\n")
# CompanyList.write("CompanyName\n")
# Students.write("PersonID\n")
