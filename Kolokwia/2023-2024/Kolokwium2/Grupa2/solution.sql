create database Enterprise
go

use Enterprise
go

create table Invoices (
    InvoiceID int primary key identity(1,1),
	Brutto money,
	Netto money,
	AccountNumber text
)
go