# Assets

## Procedures


## Views
```sql
FUNC_ConferenceDiscount(@ConferenceID int, @OrderDate datetime)
FUNC_IsStudent(@PersonID int)
FUNC_TicketPrice(@TicketID int)
FUNC_WorkshopsPrice(@TicketID)
```

## Functions
```sql
decimal(10,2) FUNC_ConferenceDiscount(@ConferenceID int, @OrderDate datetime)
bit           FUNC_IsStudent(@PersonID int) 
decimal(10,2) FUNC_TicketPrice(@TicketID int)
decimal(10,2) FUNC_WorkshopsPrice(@TicketID)
```
## Triggers
