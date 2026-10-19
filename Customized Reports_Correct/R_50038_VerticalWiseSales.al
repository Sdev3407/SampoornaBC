report 50038 "Vertical Wise Sales"
{
    UsageCategory = Administration;
    Caption = 'Vertical Wise Sales Report';
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'ReportLayout\VerticalWiseSales.rdl';


    dataset
    {
        dataitem(Integer; Integer)
        {
            DataItemTableView = SORTING(Number)
                                WHERE(Number = CONST(1));

            trigger OnAfterGetRecord()
            begin
                ResponsibilityCenter1.RESET;
                IF ResponsibilityCenter1.FINDFIRST THEN
                    REPEAT
                        "Responsibility Center".INIT;
                        "Responsibility Center".Code := ResponsibilityCenter1.Code;
                        "Responsibility Center".INSERT(TRUE);
                    UNTIL ResponsibilityCenter1.NEXT = 0;

                "Responsibility Center".INIT;
                "Responsibility Center".Code := 'ZZZZ';
                "Responsibility Center".INSERT(TRUE);
            end;

            trigger OnPreDataItem()
            begin
                StartDate := CALCDATE('-1D', AsOnDate);
                EndDate := AsOnDate;
                IF AsOnDate = 0D THEN
                    ERROR('As on Date should not be Blank');
                DummyDate := CALCDATE('-60Y', TODAY);
            end;
        }
        dataitem("Responsibility Center"; "Responsibility Center")
        {
            RequestFilterFields = "Code";
            UseTemporary = true;
            column(ResponsibilityCenter_Customer; "Responsibility Center".Code)
            {
            }
            column(Opening; Opening)
            {
            }
            column(SameDaySales; SameDaySales)
            {
            }
            column(SameDayCollection; SameDayCollection)
            {
            }
            column(Adjustment; Adjustment)
            {
            }
            column(Outstanding; Outstanding)
            {
            }
            column(StartDate; StartDate)
            {
            }
            column(AsOnDate; AsOnDate)
            {
            }

            trigger OnAfterGetRecord()
            begin

                Outstanding := 0;
                Opening := 0;
                Adjustment := 0;
                SameDaySales := 0;
                SameDayCollection := 0;

                Customer1.RESET;
                IF Code <> 'ZZZZ' THEN
                    Customer1.SETRANGE("Responsibility Center", Code)
                ELSE
                    Customer1.SETRANGE("Responsibility Center", '');
                Customer1.SETRANGE("Date Filter", DummyDate, AsOnDate);
                Customer1.CALCFIELDS("Net Change");
                Customer1.SETFILTER("Net Change", '<>%1', 0);
                IF Customer1.FINDFIRST THEN
                    REPEAT
                        Customer1.CALCFIELDS("Net Change");
                        Outstanding += Customer1."Net Change";
                    UNTIL Customer1.NEXT = 0;

                Customer1.RESET;
                IF Code <> 'ZZZZ' THEN
                    Customer1.SETRANGE("Responsibility Center", Code)
                ELSE
                    Customer1.SETRANGE("Responsibility Center", '');

                Customer1.SETRANGE("Date Filter", DummyDate, StartDate);
                Customer1.CALCFIELDS("Net Change");
                //Customer1.SETFILTER("Net Change",'<>%1',0);
                IF Customer1.FINDFIRST THEN
                    REPEAT

                        Customer1.CALCFIELDS("Net Change");
                        Opening += Customer1."Net Change";

                        CustLedgerEntry.RESET;
                        CustLedgerEntry.SETCURRENTKEY("Customer No.", "Posting Date");
                        CustLedgerEntry.SETRANGE("Date Filter", AsOnDate);
                        CustLedgerEntry.SETRANGE("Posting Date", AsOnDate);
                        CustLedgerEntry.SETRANGE("Customer No.", Customer1."No.");
                        IF CustLedgerEntry.FINDFIRST THEN
                            REPEAT
                                CustLedgerEntry.CALCFIELDS("Original Amount");
                                IF (CustLedgerEntry."Document Type" = CustLedgerEntry."Document Type"::Invoice) THEN
                                    SameDaySales += CustLedgerEntry."Original Amount";
                                IF (CustLedgerEntry."Document Type" = CustLedgerEntry."Document Type"::Payment) OR (CustLedgerEntry."Document Type" = CustLedgerEntry."Document Type"::Refund) THEN
                                    SameDayCollection += CustLedgerEntry."Original Amount";
                                IF (CustLedgerEntry."Document Type" = CustLedgerEntry."Document Type"::"Credit Memo") OR (CustLedgerEntry."Document Type" = CustLedgerEntry."Document Type"::" ") THEN
                                    Adjustment += CustLedgerEntry."Original Amount";
                            UNTIL CustLedgerEntry.NEXT = 0;
                    UNTIL Customer1.NEXT = 0;
            end;

            trigger OnPreDataItem()
            begin
                //StartDate := CALCDATE('-1D',AsOnDate);
                //EndDate := AsOnDate;
                //IF AsOnDate = 0D THEN
                //  ERROR('As on Date should not be Blank');
                //DummyDate := CALCDATE('-60Y',TODAY);
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
        Opening: Decimal;
        EndDate1: Date;
        SameDaySales: Decimal;
        SameDayCollection: Decimal;
        Customer1: Record 18;
        DummyDate: Date;
        Outstanding: Decimal;
        Adjustment: Decimal;
        ResponsibilityCenter1: Record "Responsibility Center";//5714;
}

