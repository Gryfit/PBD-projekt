# Opisy tabel
## Conferences
Pole | Opis
---- | ----
StartDate | Data rozpoczęcia konferencji
EndDate | Data zakończenia konferencji
ConferenceSeats | Liczba dostępnych miejsc
ConferenceName | 
ConferenceDescription |
BasicPrice | Cena bazowa, od której liczone są zniżki
StudentDiscount | Zniżka dla studentów

## Tickets
Pole | Opis
---- | ----
TicketID | Numer biletu (jeden bilet na jeden osobodzień konferencji)
OrderID | Numer zamówienia, z którego zapłacono za bilet
ClietID | Numer klienta, który zakupił bilet
PersonID | ID osoby uprawnionej do użycia biletu
Day | Dzień konferencji, na który bilet obowiązuje

## Orders
Pole | Opis
---- | ----
OrderID | Numer zamówienia
OrderDate | Data złożenia zamówienia
PaymentDate | Data opłacenia zamówienia
OverPayment | Zwrot kosztów w wypadku nadpłaty (zniżki), może być ujemny
OrderEmail | Adres e-mail, który podano przy zamówieniu

## Clients
Pole | Opis
---- | ----
ClientID | Numer klienta (osoby prywatnej lub firmy)

## Companies
Pole | Opis
---- | ----
CompanyID | 
ClientID | Identyfikator przyporządkowany firmie, null, gdy firma nie składała nigdy zamówienia
CompanyName |
Phone | Numer, na który może zadzwonić obsługa w celu ustalenia szczegółów rezerwacji
E-mail | Adres, jw.

## People
Pole | Opis
---- | ----
LastName |
FirstName |
StudentIDCard |

## WorkshopReservations

## Workshops
Pole | Opis
---- | ----
ConferenceID | Konferencja, w ramach której odbywają się warsztaty
WorkshopDate | Data odbycia się warsztatu
WorkshopDuration | Czas trwania warsztatu
WorkshopSeats |
WorkshopName |
WorkshopDescription |
WorkshopPrice |
