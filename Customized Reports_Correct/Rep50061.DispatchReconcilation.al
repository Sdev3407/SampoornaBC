report 50061 "Dispatch Reconcilation"
{
    UsageCategory = Administration;
    Caption = 'Dispatch Reconcilation Report';
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'ReportLayout\DispatchReconcilation.rdl';
    dataset
    {
        dataitem("Sales Shipment Header"; "Sales Shipment Header")
        {
            column(No; "Sales Shipment Header"."No.")
            {
            }
            column(SystemCreatedAt; SystemCreatedAt)
            { }
            column(CustomerName; "Sales Shipment Header"."Sell-to Customer Name")
            {
            }
            column(LocationCode; "Sales Shipment Header"."Location Code")
            {
            }
            column(PostingDate; "Sales Shipment Header"."Posting Date")
            {
            }
            column(SendForApprovalDateTime; SendForApprovalDateTime)
            {
            }
            column(OrderApprovalDateTime; OrderApprovalDateTime)
            {
            }
            column(EntryDateTime; EntryDateTime)
            {
            }
            column(LocName; LocName)
            {
            }
            column(StartDate; StartDate)
            {
            }
            column(EndDate; EndDate)
            {
            }
            column(HoursDiff; HoursDiff)
            {
            }
            column(ReportDate; ReportDate)
            {
            }

            trigger OnAfterGetRecord()
            begin
                CLEAR(SendForApprovalDateTime);
                CLEAR(OrderApprovalDateTime);
                PostedApprovalEntry.RESET;
                PostedApprovalEntry.SETRANGE("Document No.", "Sales Shipment Header"."No.");
                IF PostedApprovalEntry.FINDFIRST THEN
                    SendForApprovalDateTime := PostedApprovalEntry."Date-Time Sent for Approval";
                OrderApprovalDateTime := PostedApprovalEntry."Last Date-Time Modified";

                CLEAR(EntryDateTime);
                ItemLedgerEntry.RESET;
                ItemLedgerEntry.SETRANGE("Document No.", "Sales Shipment Header"."No.");
                IF ItemLedgerEntry.FINDFIRST THEN
                    EntryDateTime := ItemLedgerEntry.SystemCreatedAt;

                CLEAR(LocName);
                Location.RESET;
                Location.SETRANGE(Code, "Sales Shipment Header"."Location Code");
                IF Location.FINDFIRST THEN
                    LocName := Location.Name;


                IF (EntryDateTime <> 0DT) AND (OrderApprovalDateTime <> 0DT) THEN BEGIN
                    TimeDiff := EntryDateTime - OrderApprovalDateTime;
                    HoursDiff := ((TimeDiff / 1000) / 60) / 60;
                    //MESSAGE('%1',HoursDiff);
                END;
            end;

            trigger OnPreDataItem()
            begin
                "Sales Shipment Header".SETRANGE("Sales Shipment Header"."Posting Date", ReportDate, ReportDate);
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }

        trigger OnInit()
        begin
            //"Posting Date" := CALCDATE('<-1M>', "Posting Date");
            //ReportDate := CALCDATE('-1D',WORKDATE);
        end;
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        Last := 1;
        ReportDate := CALCDATE('-1D', WORKDATE);

        //CALCDATE('-1D',WORKDATE);
    end;

    var
        PostedApprovalEntry: Record 456;
        SendForApprovalDateTime: DateTime;
        OrderApprovalDateTime: DateTime;
        ItemLedgerEntry: Record 32;
        EntryDateTime: DateTime;
        Location: Record 14;
        LocName: Text[50];
        StartDate: Date;
        EndDate: Date;
        DateTime: Boolean;
        ReportAgeing: array[6] of Date;
        ReportDate: Date;
        Last: Integer;
        I: Integer;
        TimeDiff: Duration;
        HoursDiff: Decimal;
        RecSalesShipmentHeader: Record 110;
}

