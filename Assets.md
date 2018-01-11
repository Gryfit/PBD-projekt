# Assets

## Procedures


## Views
```sql
VIEW_OrderTickets           [OrderID OrderDate Email Phone TicketsOrdered StudentTickets]
VIEW_ConferencePopularity   [ConferenceID PercentSold SeatsSold Seats]
VIEW_WorkshopPopularity     [WorkshopID PercentSold SeatsSold Seats]
VIEW_AvaliableWorkshops     [WorkshopID ConferenceID ConferenceDayID]
VIEW_PaymentSummary         [ClientID Email Phone OrderID TicketID TicketPrice]
```
---
ToDo:
```sql
FUNC
```

## Functions
```sql
decimal(10,2) FUNC_ConferenceDiscount(@ConferenceID int, @OrderDate datetime)
bit           FUNC_IsStudent(@PersonID int) 
decimal(10,2) FUNC_TicketPrice(@TicketID int)
decimal(10,2) FUNC_WorkshopsPrice(@TicketID)
```
## Triggers
