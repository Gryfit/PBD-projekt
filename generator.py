from faker import Faker
from Lib import random
from datetime import datetime, timedelta
from faker.providers import BaseProvider
import pymssql

BEGINNING = datetime(2016, 1, 8, 22, 40, 1)
END = datetime(2018, 1, 8, 22, 40, 1)

fake = Faker('en_GB')
server = "mssql.iisg.agh.edu.pl"
user = "kbak"
password = "------"

conn = pymssql.connect(server, user, password, "kbak_a")
cursor = conn.cursor()


#cursor.execute('EXEC sp_MSForEachTable \'ALTER TABLE ? NOCHECK CONSTRAINT ALL\'')
#cursor.execute('EXEC sp_MSForEachTable \'DELETE FROM ?\'')
#cursor.execute('EXEC sp_MSForEachTable \'ALTER TABLE ? WITH CHECK CHECK CONSTRAINT ALL\'')

CompanyIDCurret=1

for ClientID in range(1, 101): #1000 klientów brzmi ok
#    phone = fake.phone_number() daj na 25
    print("jestem w %u" % ClientID)

    cursor.execute('INSERT INTO Clients VALUES (\'%s\',\'%s\')' %
                   (fake.email(), fake.phone_number()))
    conn.commit()
    #mamy Klientów
    if random.randint(0, 2) == 1:
        comp = fake.company()
        if comp.find('\''):
            comp = "DERP INC"
        cursor.execute('INSERT INTO CompanyList VALUES (\'%s\')' % comp)
        conn.commit()
        cursor.execute('INSERT INTO CompanyClients VALUES (%u,%u)' %
                       (ClientID, CompanyIDCurret))
        conn.commit()
        CompanyIDCurret+=1
    #część z nich została klientami firmowymi
    cursor.execute('SELECT SUM(1) FROM Clients')
    row = cursor.fetchone()
    ClientID = row[0]

    OrderIDTotal=1
    ClientIDCurr=1
    PaymentID = 1
for ConferenceID in range(1, 101): #100 konferencji
    StartDate = fake.date_time_between_dates(BEGINNING,END) #każda ma jakiś start w okresie od początku działalności do końca
    D =random.randint(1, 3)
    Duration = timedelta(D) #długość konferencji minimum 1 dzień maximum 3 dni
    EndDate = StartDate + Duration #Końcowa data konferencji
    Seats = random.randint(100, 1000) #miejsca na konferencje
    BasePrice = random.randint(1000, 50000)/100 #cena podstawowa od 10zł do 500zł (z groszami)
    StudentDiscount = random.randint(0, 50) #zniżka studencka
    cursor.execute('INSERT INTO Conferences VALUES (\'%s\',\'%s\',%u,%u,%u)' %
                   (StartDate,EndDate,Seats,BasePrice,StudentDiscount))
    conn.commit()
    cursor.callproc('GenerateDays', (ConferenceID,))
    for ConferenceDayID in range(1,D+1):
        print("ticket dla dnia %u i konfy %u" % (ConferenceDayID,ConferenceID,))
        cursor.callproc('GenerateTickets', (ConferenceID, ConferenceDayID))
        conn.commit()
    #mamy już wygenerowane konferencje Dni konferencji i tickety ale puste

    for OrderID in range(1, random.randint(2, 3)): #1 albo 2 zamówienia per client
        if ClientIDCurr<ClientID:
            OrderDate = StartDate - timedelta(random.randint(30, 100))
            cursor.execute('INSERT INTO Orders VALUES (%u,\'%s\')' % (ClientIDCurr,OrderDate))
            conn.commit()
            cursor.execute('INSERT INTO Payments VALUES (%u,%u,\'%s\',%u,\'%s\')' % (PaymentID,OrderID,OrderDate,(random.randint(1000,5000)/100),fake.iban()))
            conn.commit()
            ClientIDCurr +=1
            PaymentID += 1
            for ConferenceDayID in range(1,D+1):
                cursor.execute("UPDATE Tickets SET OrderID = %u WHERE ConferenceID = %u AND ConferenceDayID = %u" % (OrderIDTotal, ConferenceID, ConferenceDayID))
                conn.commit()
            OrderIDTotal+=1
    #mamy Ordery i akutalizację ticketów
    Temp = StartDate
    for Levels in range(random.randint(1, 4)):
        DiscountLevel = Temp - timedelta(30)
        cursor.execute('INSERT INTO ConferenceDiscounts VALUES (%u,\'%s\',%u)' %
                       (ConferenceID,DiscountLevel,random.randint(1, 50)))
        conn.commit()
        Temp = DiscountLevel
    #mamy już zniżki od czasu
    for ConferenceDayID in range(1, D + 1):
        for WorkshopID in range(1, random.randint(1, 5)):
            StartOfWorkshop = StartDate + timedelta(ConferenceID-1)
            StartOfWorkshop = StartOfWorkshop.replace(hour=11, minute=00, second=00)
            cursor.execute('INSERT INTO Workshops VALUES (%u,%u,\'%s\',\'%s\',%u,%u)' %
                           (
                           ConferenceDayID, ConferenceID, StartOfWorkshop, StartOfWorkshop + timedelta(0,WorkshopID), random.randint(0, 40),
                           random.randint(0, 50)))
            conn.commit()
            StartOfWorkshop += timedelta(0,WorkshopID)
            # mamy workshopy

cursor.execute('SELECT SUM(1) FROM ConferenceDays')
row = cursor.fetchone()
TicketIDTotal = row[0]
cursor.execute('SELECT SUM(1) FROM CompanyList')
row = cursor.fetchone()
CompanyListTotal = row[0]
for PersonID in range(1,TicketIDTotal+1):
    if random.randint(0,2)==1:
        cursor.execute('INSERT INTO People VALUES (%u,\'%s\',\'%s\')' % (random.randint(1,CompanyListTotal),fake.first_name(),fake.last_name()))
        conn.commit()
    else:
        cursor.execute('INSERT INTO People VALUES ( NULL ,\'%s\',\'%s\')' % (fake.first_name(),fake.last_name()))
        conn.commit()
    if random.randint(0, 2) == 1:
        cursor.execute('INSERT INTO Students VALUES (%u)' % PersonID)
        conn.commit()
#mamy osoby


cursor.execute('SELECT SUM(1) FROM Workshops')
row = cursor.fetchone()
NumWorkshops = row[0]
cursor.execute('SELECT SUM(1) FROM Tickets')
row = cursor.fetchone()
TicketID = row[0]
NumWorkshopsCurr = 1
for WorkshopReservationID in range(1,random.randint(1,5)):
    if(NumWorkshopsCurr<=NumWorkshops):
        cursor.execute('INSERT INTO WorkshopReservations VALUES (%u,%u)' %(NumWorkshopsCurr,TicketID))
        conn.commit()
        NumWorkshopsCurr+=1
#mamy Rezerwacje na workshopy


conn.close()
