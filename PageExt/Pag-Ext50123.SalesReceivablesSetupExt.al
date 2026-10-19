pageextension 50123 SalesReceivablesSetupExt extends "Sales & Receivables Setup"
{
    layout
    {
        addafter("Invoice Rounding")
        {

            field("SMS Send Type"; Rec."SMS Send Type")
            {
                ApplicationArea = All;

            }
            field("SMS HTTP URL"; Rec."SMS HTTP URL")
            {
                ApplicationArea = All;

            }
            field("SMS Email Server"; Rec."SMS Email Server")
            {
                ApplicationArea = All;

            }
            field("SMS User"; Rec."SMS User")
            {
                ApplicationArea = All;

            }
            field("SMS Password"; Rec."SMS Password")
            {
                ApplicationArea = All;

            }
            field("SMS Sender Phone"; Rec."SMS Sender Phone")
            {
                ApplicationArea = All;

            }
            field("SMS local Country code"; Rec."SMS local Country code")
            {
                ApplicationArea = All;

            }
            field("Sender ID"; Rec."Sender ID")
            {
                ApplicationArea = All;

            }
            field("Customer ID"; Rec."Customer ID")
            {
                ApplicationArea = All;

            }
            field("Entity ID"; Rec."Entity ID")
            {
                ApplicationArea = All;

            }
            field("From Date"; Rec."From Date")
            {
                ApplicationArea = All;

            }
            field("To Date"; Rec."To Date")
            {
                ApplicationArea = All;

            }
            field("Send Sms"; Rec."Send Sms")
            {
                ApplicationArea = All;

            }
            field("E-Invoicing Token Validity"; Rec."E-Invoicing Token Validity")
            {
                ApplicationArea = All;

            }
            field("E-Invoicing User Name"; Rec."E-Invoicing User Name")
            {
                ApplicationArea = All;

            }
            field("E-Invoicing User Password"; Rec."E-Invoicing User Password")
            {
                ApplicationArea = All;

            }
            field("Client ID"; Rec."Client ID")
            {
                ApplicationArea = All;

            }
            field("Client Secret"; Rec."Client Secret")
            {
                ApplicationArea = All;

            }
            field("E-Invoicing Token"; Rec."E-Invoicing Token")
            {
                ApplicationArea = All;

            }
            field("Process No Series"; Rec."Process No Series")
            {
                ApplicationArea = All;

            }
            field("Tocken Date"; Rec."Tocken Date")
            {
                ApplicationArea = All;

            }
            field("GST Tocken"; Rec."GST Tocken")
            {
                ApplicationArea = All;

            }
            field("Print Report"; Rec."Print Report")
            {
                ApplicationArea = All;

            }
            field("UPI ID"; Rec."UPI ID")
            {
                ApplicationArea = All;

            }
        }
    }


    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}