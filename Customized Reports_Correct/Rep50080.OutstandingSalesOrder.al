report 50080 "Outstanding Sales Order"
{
    UsageCategory = Administration;
    Caption = 'Outstanding Sales Order Report';
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'ReportLayout\OutstandingSalesOrder.rdl';

    dataset
    {
        dataitem("Sales Line"; "Sales Line")
        {
            DataItemTableView = WHERE(Type = CONST(Item),
                                      "Shortcut Dimension 1 Code" = FILTER('FEED'),
                                      "No." = FILTER(<> ''));
            RequestFilterFields = "Location Code", "Shortcut Dimension 2 Code";
            column(DocumentNo; "Sales Line"."Document No.")
            {
            }
            column(Quantity; "Sales Line"."Outstanding Quantity")
            {
            }
            column(PostingDate; "Sales Line"."Posting Date")
            {
            }
            column(LocName; LocName)
            {
            }
            column(ItemName; "Sales Line".Description)
            {
            }
            column(CustomerName; CustomerName)
            {
            }
            column(ReportDate; ReportDate)
            {
            }
            column(SalesOrderNo; SalesOrderNo)
            {
            }
            column(OrderDate; OrderDate)
            {
            }
            column(ABC; ABC)
            {
            }
            column(QTY; QTY)
            {
            }
            column(SentForApproval; SentForApproval)
            {
            }
            column(TimeModified; TimeModified)
            {
            }

            trigger OnAfterGetRecord()
            begin
                CLEAR(SalesOrderNo);
                SalesLine.RESET;
                SalesLine.SETRANGE("Document No.", "Document No.");
                SalesLine.SETRANGE("Shortcut Dimension 1 Code", 'FEED');
                SalesLine.SETFILTER("No.", '<>%1', '');
                IF SalesLine.FINDFIRST THEN
                    REPEAT
                        //IF ((SalesLine.Type = SalesLine.Type::Item) OR (SalesLine."Document Type" = SalesLine."Document Type"::Order)) THEN
                        IF SalesLine."Document Type" = SalesLine."Document Type"::Order THEN BEGIN
                            SalesOrderNo := SalesLine."Document No.";
                        END;
                    UNTIL SalesLine.NEXT = 0;
                //=========================================
                ABC := FALSE;
                CLEAR(OrderDate);
                SalesHeader.RESET;
                SalesHeader.SETRANGE("No.", "Document No.");
                IF SalesHeader.FINDFIRST THEN
                    REPEAT
                        IF SalesHeader.Status = SalesHeader.Status::Released THEN BEGIN
                            ABC := TRUE;
                            OrderDate := SalesHeader."Order Date";
                        END;
                    UNTIL SalesHeader.NEXT = 0;
                IF OrderDate > ReportDate THEN
                    CurrReport.SKIP;
                ///

                //=========================================
                CLEAR(CustomerName);
                Customer.RESET;
                Customer.SETRANGE("No.", "Sales Line"."Sell-to Customer No.");
                IF Customer.FINDFIRST THEN
                    CustomerName := Customer.Name;
                //===============================================
                CLEAR(LocName);
                Dimenstion.RESET;
                Dimenstion.SETFILTER("Dimension Code", '%1', 'BRANCH');
                Dimenstion.SETRANGE(Blocked, FALSE);
                Dimenstion.SETRANGE(Code, "Sales Line"."Shortcut Dimension 2 Code");
                IF Dimenstion.FINDFIRST THEN
                    LocName := Dimenstion.Name;

                /*Location.RESET;
                Location.SETRANGE(Code,"Sales Line"."Location Code");
                IF Location.FINDFIRST THEN
                  LocName := Location.Name;*/
                CLEAR(SentForApproval);
                CLEAR(TimeModified);
                PostedApprovalEntry.RESET;
                PostedApprovalEntry.SETRANGE("Document No.", "Sales Line"."Document No.");
                PostedApprovalEntry.SETRANGE(Status, PostedApprovalEntry.Status::Approved);
                IF PostedApprovalEntry.FINDFIRST THEN
                    SentForApproval := PostedApprovalEntry."Date-Time Sent for Approval";
                TimeModified := PostedApprovalEntry."Last Date-Time Modified";

            end;

            trigger OnPreDataItem()
            begin
                //"Sales Line".SETRANGE("Sales Line"."Posting Date",ReportDate);
                "Sales Line".SETFILTER("Outstanding Quantity", '<>%1', 0);
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
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        //Last := 1;
        ReportDate := CALCDATE('-1D', WORKDATE);
    end;

    var
        Location: Record 14;
        LocName: Text[50];
        Item: Record 27;
        Customer: Record 18;
        CustomerName: Text[100];
        ReportDate: Date;
        Last: Integer;
        SalesLine: Record 37;
        SalesOrderNo: Code[20];
        SalesHeader: Record 36;
        OrderDate: Date;
        ABC: Boolean;
        QTY: Decimal;
        Dimenstion: Record 349;
        PostedApprovalEntry: Record 454;
        SentForApproval: DateTime;
        TimeModified: DateTime;
}

