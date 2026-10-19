page 50106 "Mail Send Process"
{
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            group(General)
            {
                field(Customer; Customer)
                {
                    ApplicationArea = All;
                    Caption = 'Customer';
                    TableRelation = Customer WHERE(Blocked = FILTER(' '));

                    trigger OnValidate()
                    begin
                        IF SalesPersonCode <> '' THEN
                            ERROR('You cannot enter the value on Customer Code');
                    end;
                }
                field(SalesPersonCode; SalesPersonCode)
                {
                    ApplicationArea = All;
                    Caption = 'SalesPerson Code';
                    TableRelation = "Salesperson/Purchaser" WHERE(Blocked = FILTER(false));

                    trigger OnValidate()
                    begin
                        IF Customer <> '' THEN
                            ERROR('You cannot enter the value on Salesperson Code');
                    end;
                }
                field(Fromdate; Fromdate)
                {
                    ApplicationArea = All;
                    Caption = 'From Date';
                }
                field(Todate; Todate)
                {
                    ApplicationArea = All;
                    Caption = 'To Date';
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action(SendMail)
            {
                // Caption = 'Send Mail';
                // Image = SendEmailPDF;
                // Promoted = true;
                // PromotedCategory = Process;
                // ApplicationArea = All;
                // trigger OnAction()
                // var
                //     TaxInvoiceAutomailer: Codeunit 50010;
                // begin
                //     IF Fromdate = 0D THEN
                //         ERROR('From Date Must have a value');
                //     IF Todate = 0D THEN
                //         ERROR('To Date Must have a value');
                //     IF (Customer = '') AND (SalesPersonCode = '') THEN
                //         TaxInvoiceAutomailer.TaxInvoicedatewiseWiseMailSend(Fromdate, Todate);
                //     IF Customer <> '' THEN
                //         TaxInvoiceAutomailer.TaxInvoiceCustomerWiseMailSend(Customer, Fromdate, Todate);
                //     IF SalesPersonCode <> '' THEN
                //         TaxInvoiceAutomailer.TaxInvoiceSalespersonWiseMailSend(SalesPersonCode, Fromdate, Todate);
                // end;
            }
        }
    }

    var
        Customer: Code[20];
        SalesPersonCode: Code[20];
        Fromdate: Date;
        Todate: Date;
}

