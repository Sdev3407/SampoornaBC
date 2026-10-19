report 50083 "Dispatch Report Item Wise"
{
    ProcessingOnly = true;
    Caption = 'Dispatch Report Item Wise';
    UsageCategory = Administration;
    ApplicationArea = all;
    dataset
    {
        dataitem("Sales Shipment Header"; "Sales Shipment Header")
        {
            RequestFilterFields = "Posting Date", "Location Code";
            dataitem("Sales Shipment Line"; "Sales Shipment Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = WHERE(Type = CONST(Item),
                                          "Responsibility Center" = FILTER('FEED | CATTLE'));

                trigger OnAfterGetRecord()
                begin
                    CLEAR(OrderDate);
                    Location.RESET;
                    IF Location.GET("Sales Shipment Line"."Location Code") THEN;
                    CreateBody;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                CLEAR(DispatchDate);
                ItemLedgerEntry.RESET;
                ItemLedgerEntry.SETRANGE("Document No.", "Sales Shipment Header"."No.");
                IF ItemLedgerEntry.FINDFIRST THEN
                    DispatchDate := ItemLedgerEntry.SystemCreatedAt;

                ShipToAdd := "Sales Shipment Header"."Ship-to Address" + ' ' + "Sales Shipment Header"."Ship-to Address 2";

                CLEAR(SalesPerson);
                SalespersonPurchaser.RESET;
                SalespersonPurchaser.SETRANGE(Code, "Sales Shipment Header"."Salesperson Code");
                IF SalespersonPurchaser.FINDFIRST THEN
                    SalesPerson := SalespersonPurchaser.Name;
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
        ExcelBuffer.CreateNewBook('Dispatch Detail Item Wise');
        ExcelBuffer.WriteSheet('Dispatch Detail Item Wise', CompanyName, UserId);
        ExcelBuffer.CloseBook();
        ExcelBuffer.SetFriendlyFilename(StrSubstNo('Dispatch Detail Item Wise', CurrentDateTime, UserId));
        ExcelBuffer.OpenExcel();
        //ExcelBuffer.CreateBookAndOpenExcel('', 'Dispatch Detail Item Wise', ' ', COMPANYNAME, USERID);
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
        SalesShipmentHeader: Record 110;
        SalesShipmentLine: Record 111;
        ItemLedgerEntry: Record 32;
        DispatchDate: DateTime;
        ShipToAdd: Text;
        SalesPerson: Text;
        SalespersonPurchaser: Record 13;

    local procedure CreateHeader()
    begin
        SetMatrixCaption;
        ExcelBuffer.NewRow;
        ExcelBuffer.AddColumn('Item No.', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Item Dicription', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('UOM', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('QTY', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Location', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Customer Name', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Posting Date', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Dispatch Date & Time', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Sales Person Name', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);

    end;

    local procedure CreateBody()
    begin
        ExcelBuffer.NewRow;
        ExcelBuffer.AddColumn("Sales Shipment Line"."No.", FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn("Sales Shipment Line".Description, FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn("Sales Shipment Line"."Unit of Measure", FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn("Sales Shipment Line".Quantity, FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn("Sales Shipment Line"."Location Code", FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn("Sales Shipment Header"."Sell-to Customer Name", FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn("Sales Shipment Header"."Posting Date", FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(DispatchDate, FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(SalesPerson, FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
    end;

    local procedure SetMatrixCaption()
    begin
        ReportName[1] := 'Report Name  :';
        ReportName[2] := 'Dispatch Job';
        FOR I := 1 TO 5 DO BEGIN
            IF I = 2 THEN BEGIN
                ReportName[1] := 'Report Fillters :';
                ReportName[2] := "Sales Shipment Header".GETFILTERS;
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
                ReportName[1] := '';
                ReportName[2] := '';
            END;
        END;
    end;


    procedure GetDateFillter(Sdate: Date; Edate: Date)
    begin
    end;
}

