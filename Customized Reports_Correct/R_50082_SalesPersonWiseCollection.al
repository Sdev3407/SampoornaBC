report 50082 "Sales Person Wise Collection"
{
    UsageCategory = Administration;
    Caption = 'SalesPerson Wise Collection Report';
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'ReportLayout\SalesPersonWiseCollection.rdl';
    dataset
    {
        dataitem("Salesperson/Purchaser"; "Salesperson/Purchaser")
        {
            // DataItemTableView = WHERE(Block = FILTER(no));
            RequestFilterFields = "Code";
            column(TeamType_Customer; TeamType)
            {
            }
            column(TeamName_Customer; TeamName)
            {
            }
            column(Name; "Salesperson/Purchaser".Name)
            {
            }
            column(Last10DaysSales; Last10DaysSales)
            {
            }
            column(Last10DaysCollection; Last10DaysCollection)
            {
            }
            column(Outstanding; Outstanding)
            {
            }
            column(AsOnDate; AsOnDate)
            {
            }

            trigger OnAfterGetRecord()
            begin
                SalesPerson := '';
                TeamType := '';
                TeamName := '';
                Outstanding := 0;
                Last10DaysSales := 0;
                Last10DaysCollection := 0;
                SalesPerson := Name;
                TeamSalesperson.RESET;
                TeamSalesperson.SETRANGE("Salesperson Code", Code);
                IF TeamSalesperson.FINDFIRST THEN BEGIN
                    IF Team.GET(TeamSalesperson."Team Code") THEN BEGIN
                        TeamType := FORMAT(Team."Team Type");
                        TeamName := Team.Name;
                    END;
                END;
                Customer1.RESET;
                Customer1.SETRANGE("Salesperson Code", Code);
                Customer1.SETRANGE("Date Filter", DummyDate, AsOnDate);
                Customer1.CALCFIELDS("Net Change");
                Customer1.SETFILTER("Net Change", '<>%1', 0);
                IF Customer1.FINDFIRST THEN
                    REPEAT
                        Customer1.CALCFIELDS("Net Change");
                        Outstanding += Customer1."Net Change";
                        CustLedgerEntry.RESET;
                        CustLedgerEntry.SETCURRENTKEY("Customer No.", "Posting Date");
                        CustLedgerEntry.SETRANGE("Date Filter", StartDate, AsOnDate);
                        CustLedgerEntry.SETRANGE("Posting Date", StartDate, AsOnDate);
                        CustLedgerEntry.SETRANGE("Customer No.", Customer1."No.");
                        IF CustLedgerEntry.FINDFIRST THEN
                            REPEAT
                                CustLedgerEntry.CALCFIELDS("Original Amount");
                                IF (CustLedgerEntry."Document Type" = CustLedgerEntry."Document Type"::Invoice) THEN
                                    Last10DaysSales += CustLedgerEntry."Original Amount";
                                IF (CustLedgerEntry."Document Type" = CustLedgerEntry."Document Type"::Payment) OR (CustLedgerEntry."Document Type" = CustLedgerEntry."Document Type"::Refund) THEN
                                    Last10DaysCollection += CustLedgerEntry."Original Amount";
                            UNTIL CustLedgerEntry.NEXT = 0;
                    UNTIL Customer1.NEXT = 0;
            end;

            trigger OnPreDataItem()
            begin
                StartDate := CALCDATE('-10D', AsOnDate);
                EndDate := AsOnDate;
                IF AsOnDate = 0D THEN
                    ERROR('As on Date should not be Blank');
                DummyDate := CALCDATE('-60Y', TODAY);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Option)
                {
                    Caption = 'Option';
                    field("As on Date"; AsOnDate)
                    {
                        Caption = 'As on Date';
                        ApplicationArea = All;
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnInit()
        begin
            AsOnDate := WORKDATE;
        end;
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        StartDate := 0D;
        EndDate := 0D;
    end;

    var
        AsOnDate: Date;
        CustLedgerEntry: Record 21;
        StartDate: Date;
        EndDate: Date;
        Outstanding: Decimal;
        EndDate1: Date;
        Last10DaysSales: Decimal;
        Last10DaysCollection: Decimal;
        Customer1: Record 18;
        DummyDate: Date;
        Team: Record 5083;
        TeamSalesperson: Record 5084;
        TeamName: Text;
        TeamType: Text;
        SalesPerson: Text;
}

