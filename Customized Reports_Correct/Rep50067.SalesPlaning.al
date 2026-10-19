report 50067 "Sales Planing"
{
    ProcessingOnly = true;
    Caption = 'Sales Planing';
    UsageCategory = Administration;
    ApplicationArea = all;
    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            DataItemTableView = SORTING("Document Type", "No.")
                                ORDER(Ascending)
                                WHERE("Document Type" = CONST(Order));
            RequestFilterFields = "Location Code";
            dataitem("Sales Line"; "Sales Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = WHERE(Type = CONST(Item),
                                          "Responsibility Center" = FILTER('FEED | CATTLE|SWINE'));

                trigger OnAfterGetRecord()
                begin
                    CLEAR(OrderDate);
                    Location.RESET;
                    IF Location.GET("Sales Line"."Location Code") THEN;
                    CreateBody;
                    SalesHeader.RESET;
                    SalesHeader.SETRANGE("No.", SalesLine."Document No.");
                    IF SalesHeader.FINDFIRST THEN
                        OrderDate := SalesHeader."Order Date";
                end;
            }

            trigger OnAfterGetRecord()
            begin
                CLEAR(ReleasedOrderDate);
                PostedApprovalEntry.RESET;
                PostedApprovalEntry.SETRANGE("Document No.", "Sales Header"."No.");
                PostedApprovalEntry.SETFILTER(Status, 'Approved');
                IF PostedApprovalEntry.FINDFIRST THEN
                    ReleasedOrderDate := PostedApprovalEntry."Last Date-Time Modified";

                ShipToAdd := "Sales Header"."Ship-to Address" + ' ' + "Sales Header"."Ship-to Address 2";

                CLEAR(SalesPersonName);
                SalespersonPurchaser.RESET;
                SalespersonPurchaser.SETRANGE(Code, "Sales Header"."Salesperson Code");
                IF SalespersonPurchaser.FINDFIRST THEN
                    SalesPersonName := SalespersonPurchaser.Name;
            end;

            trigger OnPreDataItem()
            begin
                CreateHeader;
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

    trigger OnPostReport()
    begin
        ExcelBuffer.CreateNewBook('Sales Planing');
        ExcelBuffer.WriteSheet('Sales Planing', CompanyName, UserId);
        ExcelBuffer.CloseBook();
        ExcelBuffer.SetFriendlyFilename(StrSubstNo('Sales Planing', CurrentDateTime, UserId));
        ExcelBuffer.OpenExcel();
        //  ExcelBuffer.CreateBookAndOpenExcel('', 'Sales Planing', ' ', COMPANYNAME, USERID);
    end;

    var
        MATRIX_CaptionSet: array[100] of Code[20];
        ExcelBuffer: Record 370 temporary;
        Stdate: Date;
        EnDate: Date;
        Srno: Integer;
        DuplicateBranch: Code[20];
        Location: Record 14;
        CompanyInformation: Record 79;
        I: Integer;
        ReportName: array[10] of Text;
        OrderDate: Date;
        SalesHeader: Record 36;
        SalesLine: Record 37;
        PostedApprovalEntry: Record 454;
        ReleasedOrderDate: DateTime;
        ShipToAdd: Text;
        SalespersonPurchaser: Record 13;
        SalesPersonName: Text;

    local procedure CreateHeader()
    begin
        SetMatrixCaption;
        ExcelBuffer.NewRow;
        ExcelBuffer.AddColumn('Order Date', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Order No.', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('No.', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Description', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Quantity', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Outstanding Qty', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Total MRP Price', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('LOcation Code', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Planned Delivery Date', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Planned Shipment', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Unit of Measurement', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Location State Code', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Customer Name', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Status', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Sell To City', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Ship To Name', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Ship To Add', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Ship To City', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Released Order Date', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);//GK
        ExcelBuffer.AddColumn('Sales Person Name', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);//GK
        ExcelBuffer.AddColumn('Transporter Code', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Freight', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Mode of Transport', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Vehicle No', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Driver Mob No', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('LR No', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('LR Date', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Vehicle Type (Ton)', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Freight Amount', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
    end;

    local procedure CreateBody()
    begin
        ExcelBuffer.NewRow;
        ExcelBuffer.AddColumn("Sales Header"."Order Date", FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Date);//GK
        ExcelBuffer.AddColumn("Sales Header"."No.", FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn("Sales Line"."No.", FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn("Sales Line".Description, FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn("Sales Line".Quantity, FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn("Sales Line"."Outstanding Quantity", FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
        // ExcelBuffer.AddColumn("Sales Line"."MRP Price", FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number); //PRU SH 01082022
        ExcelBuffer.AddColumn("Sales Line"."Total MRP Price", FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn("Sales Line"."Location Code", FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn("Sales Line"."Planned Delivery Date", FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Date);
        ExcelBuffer.AddColumn("Sales Line"."Planned Shipment Date", FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Date);
        ExcelBuffer.AddColumn("Sales Line"."Unit of Measure", FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(Location."State Code", FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn("Sales Header"."Sell-to Customer Name", FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn("Sales Header".Status, FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn("Sales Header"."Sell-to City", FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn("Sales Header"."Ship-to Name", FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(ShipToAdd, FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn("Sales Header"."Ship-to City", FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(ReleasedOrderDate, FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);//GK
        ExcelBuffer.AddColumn(SalesPersonName, FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);//GK
        ExcelBuffer.AddColumn('', FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        //ExcelBuffer.AddColumn('',FALSE,'',TRUE,FALSE,TRUE,'',ExcelBuffer."Cell Type"::Text);
    end;

    local procedure SetMatrixCaption()
    begin
        ReportName[1] := 'Report Name  :';
        ReportName[2] := 'Dispatch Job';
        FOR I := 1 TO 5 DO BEGIN
            IF I = 2 THEN BEGIN
                ReportName[1] := 'Report Fillters :';
                ReportName[2] := "Sales Header".GETFILTERS;
            END ELSE
                IF I = 3 THEN BEGIN
                    ReportName[1] := 'WorkDate  :';
                    ReportName[2] := FORMAT(TODAY);
                END ELSE
                    IF I = 4 THEN BEGIN
                        ReportName[1] := 'USER  :';
                        ReportName[2] := USERID;
                    END;

            IF I <> 5 THEN BEGIN
                ExcelBuffer.NewRow;
                ExcelBuffer.AddColumn(ReportName[1], FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn(ReportName[2], FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);//GK
                ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);//GK
                ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);//GK
                ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
            END ELSE BEGIN
                ExcelBuffer.NewRow;
                ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);//GK
                ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);//GK
                ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);//GK
                ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                ReportName[1] := '';
                ReportName[2] := '';
            END;
        END;
    end;


    procedure GetDateFillter(Sdate: Date; Edate: Date)
    begin
    end;
}

