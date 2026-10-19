Report 50027 "Outstanding Letter"
{
    Caption = 'Outstanding Letter';
    DefaultLayout = RDLC;
    UsageCategory = Administration;
    ApplicationArea = All;
    RDLCLayout = 'ReportLayout\OutstandingLetter.rdl';

    dataset
    {
        dataitem(Customer; Customer)
        {
            CalcFields = "Net Change";
            RequestFilterFields = "No.";
            column(Name; Name)
            { }
            column(No_; "No.") { }
            column(Address; Address) { }
            column(Address_2; "Address 2") { }
            column(City_Customer; Customer.City)
            {
            }
            column(Contact; Contact) { }
            column(Phone_No_; "Phone No.") { }
            column(PhoneNo_Customer; Customer."Phone No.")
            {
            }
            column(PostCode_Customer; Customer."Post Code")
            {
            }
            column(StateCode_Customer; Cust_State)
            {
            }
            column(numtext2; numtext2[1]) { }
            column(CountryRegionCode_Customer; Cust_Country)
            {
            }
            // column(PANNo_Customer; Customer."P.A.N. No.")
            // { }
            column(Net_Change; "Net Change")
            { }
            column(CreditDays; CreditDays)
            { }
            column(TypeofPAN; TypeofPAN)
            { }

            trigger OnAfterGetRecord()
            begin
                Clear(CreditDays);
                Clear(TypeofPAN);
                CountryName.RESET;
                IF CountryName.GET(Customer."Country/Region Code") THEN
                    Cust_Country := CountryName.Name;
                StateName.RESET;
                IF StateName.GET(Customer."State Code") THEN
                    Cust_State := StateName.Description;
                if CopyStr(Customer."P.A.N. No.", 4, 1) = 'P' then
                    TypeofPAN := 'Individual'
                else
                    if CopyStr(Customer."P.A.N. No.", 4, 1) = 'C' then
                        TypeofPAN := 'Company'
                    Else
                        if CopyStr(Customer."P.A.N. No.", 4, 1) = 'H' then
                            TypeofPAN := 'Hindu Undivided Family'
                        Else
                            if CopyStr(Customer."P.A.N. No.", 4, 1) = 'A' then
                                TypeofPAN := 'Association of Persons'
                            Else
                                if CopyStr(Customer."P.A.N. No.", 4, 1) = 'G' then
                                    TypeofPAN := 'Government Agency'
                                Else
                                    if CopyStr(Customer."P.A.N. No.", 4, 1) = 'J' then
                                        TypeofPAN := 'Artificial Juridical Person'
                                    Else
                                        if CopyStr(Customer."P.A.N. No.", 4, 1) = 'L' then
                                            TypeofPAN := 'Local Authority'
                                        Else
                                            if CopyStr(Customer."P.A.N. No.", 4, 1) = 'F' then
                                                TypeofPAN := 'Firm'
                                            Else
                                                if CopyStr(Customer."P.A.N. No.", 4, 1) = 'T' then
                                                    TypeofPAN := 'Trust';
                CustLedgerEntry.Reset();
                CustLedgerEntry.SetCurrentKey("Posting Date");
                CustLedgerEntry.SetAscending("Posting Date", false);
                CustLedgerEntry.SetRange("Customer No.", Customer."No.");
                //CustLedgerEntry.SetRange("Document Type", CustLedgerEntry."Document Type"::Invoice);
                CustLedgerEntry.CalcFields("Remaining Amount");
                CustLedgerEntry.CalcFields(Amount);
                CustLedgerEntry.SetFilter("Remaining Amount", '<>%1', 0);
                CustLedgerEntry.SetFilter(Amount, '>%1', 0);
                if CustLedgerEntry.FindLast() then
                    CreditDays := (WorkDate() - CustLedgerEntry."Posting Date");

                check1.InitTextVariable;
                check1.FormatNoText1(numtext2, Customer."Net Change", '');

            end;
        }
    }

    var
        TypeofPAN: text;
        CreditDays: Integer;
        CustLedgerEntry: Record "Cust. Ledger Entry";
        CountryName: Record "Country/Region";
        StateName: Record State;
        Cust_State: Text;
        Cust_Country: Text;
        numtext2: array[2] of Text;
        check1: Report CheckPrint1;
        text001: Label 'This is to inform you that your above-named proprietorship firm doing business with us since long but according to our records, your payment of %1/- (Rupees Two Lakh Eighty Four Thousands Two Hundred Eighty Nine Only) is overdue from the period of more than 60 days. We had sent you reminders for deposit of outstanding payment but We have not received any favorable response from your side till date.';
        text002: Label 'You are our valuable customer and we want to serve you with diligently to maintain our healthy & better relation.';
        text003: Label 'We once again requesting you to clear the pending dues with us within a period of 7 days, else we will initiate legal action for recovery of due payment in competent court of law & you shall be fully responsible for all kinds of cost and consequences arising thereof. ';

}