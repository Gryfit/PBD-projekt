from faker import Faker
import random
from datetime import datetime, timedelta
from faker.providers import BaseProvider
import pymssql

BEGINNING = datetime(2016, 12, 8, 22, 40, 1)
END = datetime(2018, 10, 8, 22, 40, 1)

fake = Faker('en_GB')
server = "mssql.iisg.agh.edu.pl"
user = "kbak"
password = "-----"

conn = pymssql.connect(server, user, password, "kbak_a")
cursor = conn.cursor()

PersonID = 0
OrderID = 0
TicketID = 0
PaymentID = 0

for ConferenceID in range(1, 40): #3 lata razy srednio 2 konferencje
    StartDate = fake.date_time_between_dates(BEGINNING,END) #kazda ma jakis start w okresie od poczatku dzialalnosci do konca
    D =random.randint(1, 3)
    Duration = timedelta(D) #dlugosc konferencji minimum 1 dzien maximum 3 dni
    EndDate = StartDate + Duration #Koncowa data konferencji
    Seats = random.randint(10, 30) * 10 #miejsca na konferencje
    BasePrice = random.randint(1, 50) * 10 #cena podstawowa od 10zl do 500zl (z groszami)
    StudentDiscount = random.randint(0, 5) * 10 #znizka studencka
    cursor.execute('INSERT INTO Conferences VALUES (\'%s\',\'%s\',%u,%u,%u, 0)' %
                   (StartDate,EndDate,Seats,BasePrice,StudentDiscount))
    conn.commit()

    # Tworzymy znizki dla konferencji
    Temp = StartDate
    for Levels in range(random.randint(1, 4)):
        DiscountLevel = Temp - timedelta(30)
        cursor.execute('INSERT INTO ConferenceDiscounts VALUES (%u,\'%s\',%u)' %
                       (ConferenceID, DiscountLevel, random.randint(1, 5) * 10))
        conn.commit()
        Temp = DiscountLevel

    for day in range(1,D+1): # tworzymy warsztaty na konferencji
        StartOfWorkshop = StartDate 
        StartOfWorkshop = StartOfWorkshop.replace(hour=10, minute=00, second=00)
        for WorkshopID in range(1, 2):
            Length = timedelta(0,0,0,0,0,random.randint(1,2))
            cursor.execute('INSERT INTO Workshops VALUES (%u,%u,\'%s\',\'%s\',%u,%u, %u)' %
                           (
                           day, ConferenceID, StartOfWorkshop, StartOfWorkshop + Length, random.randint(10, 25),
                           random.randint(1, 5) * 5, 0))
            conn.commit()
            cursor.execute('INSERT INTO Workshops VALUES (%u,%u,\'%s\',\'%s\',%u,%u, %u)' %
                           (
                           day, ConferenceID, StartOfWorkshop, StartOfWorkshop + Length + timedelta(0,0,0,0,0,1), random.randint(10, 25),
                           random.randint(1, 5) * 5, 0))
            conn.commit()
            StartOfWorkshop = StartOfWorkshop + Length + timedelta(0,0,0,0,0,2)

    # Teraz zajmiemy sie generowaniem zamowien na te konferencje
    FreePlaces = random.randint(0,20) # Ile ma zostac wolnych miejsc
    TicketCount = 0
    PeopleIterator = 0
    while PeopleIterator < (Seats - FreePlaces):
        print("order %u" % OrderID)
        # isCompany?
        isCompany = random.randint(0,1)
        
        # losujemy klienta do tej konferencji
        comp = "Supere firma"
        if isCompany == 1:
            comp = fake.company()

        cursor.callproc('AddClient', (fake.email(), fake.phone_number(), comp))
        conn.commit()
        cursor.execute('SELECT Top 1 ClientID FROM dbo.CompanyClients ORDER BY ClientID DESC')
        row = cursor.fetchone()
        CompanyID = row[0]
        cursor.execute('SELECT Top 1 ClientID FROM Clients ORDER BY ClientID DESC')
        row = cursor.fetchone()
        ClientID = row[0]

        # tworzymy nowe zamowienie
        OrderID = OrderID + 1
        OrderDate = StartDate - timedelta(random.randint(30, 100))
        cursor.execute('INSERT INTO Orders VALUES (%u,\'%s\')' % (ClientID,OrderDate))

        # Ile osob w zamowieniu?
        NumOfPeople = random.randint(1,5) + random.randint(15,20) * isCompany
        for person in range(1, NumOfPeople):
            # tworzymy nowa osobe
            PersonID += 1
            PeopleIterator += 1
            Name = fake.first_name()
            Last_name = fake.first_name()
            if isCompany :
                cursor.execute('INSERT INTO People VALUES ( %u , \'%s\' , \'%s\')' % (CompanyID,Name,Last_name))
                conn.commit()
            else :
                cursor.execute('INSERT INTO People VALUES ( NULL , \'%s\' , \'%s\')' %  (Name,Last_name))
                conn.commit()

            if random.randint(0, 2) == 1 :
                cursor.execute('INSERT INTO Students VALUES (%u)' % (PersonID))
                conn.commit()

            cursor.execute('SELECT cd.ConferenceDayID FROM ConferenceDays AS cd WHERE ConferenceID = %u' % (ConferenceID))
            for day in cursor: 
                # decydujemy, czy dostanie tego dnia bilet
                if random.randint(0, 2) != 1 :
                    TicketCount += 1
                    if TicketCount > Seats - FreePlaces : # jezeli braklo miejsc na konfie 
                        break
                    cursor.execute('INSERT INTO Tickets VALUES ( %u, %u, %u, %u )' % (OrderID, PersonID, ConferenceID, day[0]))
                    conn.commit()
                    # teraz wybieramy mu warsztaty
                    #cursor.execute('')
                    #cursor.execute('INSERT INTO dbo.WorkshopReservations VALUES (%u, )
                    # TODO 
            
            # koniec przydzielnia biletow dla jednej osoby
        # teraz jeszcze dodajemy payment 
        cursor.execute('SELECT dbo.OrderCost(%u)' % (OrderID))
        row = cursor.fetchone()
        Cost = row[0] 

        PaymentID += 1
        cursor.execute('INSERT INTO Payments VALUES (%u, %u,\'%s\',%u,\'%s\')' % (PaymentID, OrderID,OrderDate,Cost,fake.iban()))
        conn.commit()

conn.close()
