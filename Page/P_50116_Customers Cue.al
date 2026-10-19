page 50116 "Customers Cue"
{
    Caption = 'My Customers';
    PageType = ListPart;
    SourceTable = 18;
    SourceTableTemporary = true;
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Reapeater)
            {
                field("Customer Balance"; Rec."Customer Cue Balance")
                {
                    ApplicationArea = All;
                    Caption = 'Customer Balance';
                }
                field(MTDAmt; Rec.MTDAmt)
                {
                    ApplicationArea = All;
                }
                field(YTDAmt; Rec.YTDAmt)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Open)
            {
                Caption = 'Open';
                ApplicationArea = All;
                Enabled = false;
                Image = ViewDetails;
                RunObject = Page 21;
                RunPageMode = View;
                RunPageView = SORTING("No.");
                ShortCutKey = 'Return';
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        GetCustomer;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        //CLEAR(Cust);
    end;

    trigger OnOpenPage()
    begin
        //SETRANGE("User ID",USERID);
        CLEAR(CustTotal);
        Customer.RESET;
        IF Customer.FINDFIRST THEN
            REPEAT
                Customer.CALCFIELDS("Balance (LCY)");
                CustTotal += Customer."Balance (LCY)";
            UNTIL Customer.NEXT = 0;

        CLEAR(VendTotal);
        Vendor.RESET;
        IF Vendor.FINDFIRST THEN
            REPEAT
                Vendor.CALCFIELDS("Balance (LCY)");
                VendTotal += Vendor."Balance (LCY)";
            UNTIL Vendor.NEXT = 0;


        //

        AsOnDate := WORKDATE;
        Day := DATE2DMY(AsOnDate, 1);
        Month := DATE2DMY(AsOnDate, 2);
        Year := DATE2DMY(AsOnDate, 3);
        StaringDate := DMY2DATE(1, Month, Year);

        CLEAR(MTDAmt1);
        CustLedgerEntry.RESET;
        CustLedgerEntry.SETRANGE("Posting Date", StaringDate, AsOnDate);
        CustLedgerEntry.SETFILTER("Document Type", '%1|%2', CustLedgerEntry."Document Type"::Invoice, CustLedgerEntry."Document Type"::"Credit Memo");
        IF CustLedgerEntry.FINDFIRST THEN
            REPEAT
                CustLedgerEntry.CALCFIELDS("Original Amount");
                MTDAmt1 += CustLedgerEntry."Original Amount";
            UNTIL CustLedgerEntry.NEXT = 0;



        //
        AsOnDate := WORKDATE;
        Day := DATE2DMY(AsOnDate, 1);
        Month := DATE2DMY(AsOnDate, 2);
        Year := DATE2DMY(AsOnDate, 3);
        StaringDate := DMY2DATE(1, 4, Year);

        CLEAR(YTDAmt1);
        CustLedgerEntry.RESET;
        CustLedgerEntry.SETRANGE("Posting Date", StaringDate, AsOnDate);
        CustLedgerEntry.SETFILTER("Document Type", '%1|%2', CustLedgerEntry."Document Type"::Invoice, CustLedgerEntry."Document Type"::"Credit Memo");
        IF CustLedgerEntry.FINDFIRST THEN
            REPEAT
                CustLedgerEntry.CALCFIELDS("Original Amount");
                YTDAmt1 += CustLedgerEntry."Original Amount";
            UNTIL CustLedgerEntry.NEXT = 0;

        Rec.INIT;
        Rec."No." := '';
        Rec."Customer Cue Balance" := CustTotal;
        Rec.MTDAmt := MTDAmt1;
        Rec.YTDAmt := YTDAmt1;
        Rec.INSERT;
    end;

    var
        Cust: Record 18;
        CustTotal: Decimal;
        VendTotal: Decimal;
        Customer: Record 18;
        Vendor: Record 23;
        CustLedgerEntry: Record 21;
        MTDAmt1: Decimal;
        YTDAmt1: Decimal;
        AsOnDate: Date;
        Day: Integer;
        Month: Integer;
        Year: Integer;
        StaringDate: Date;

    local procedure GetCustomer()
    begin
        /*CLEAR(Cust);
        IF Cust.GET("Customer No.") THEN
          Cust.CALCFIELDS("Balance (LCY)");*/

    end;
}
