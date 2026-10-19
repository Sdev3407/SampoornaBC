report 50075 "Application Entry Report"
{
    ProcessingOnly = true;
    Caption = 'Application Entry Report';
    UsageCategory = Administration;
    ApplicationArea = all;
    dataset
    {
        dataitem(Item; Item)
        {
            RequestFilterFields = "No.", "Date Filter";
            dataitem("Item Ledger Entry"; "Item Ledger Entry")
            {
                DataItemLink = "Item No." = FIELD("No."),
                               "Posting Date" = FIELD("Date Filter");
                DataItemTableView = SORTING("Entry No.")
                                    ORDER(Ascending);
                RequestFilterFields = "Location Code", "Entry No.";
                dataitem("Item Application Entry"; "Item Application Entry")
                {
                    DataItemLink = "Item Ledger Entry No." = FIELD("Entry No.");

                    trigger OnAfterGetRecord()
                    begin
                        CLEAR(ApplDocNo);
                        CLEAR(ApplEntryNo);
                        CLEAR(ApplItemNo);
                        CLEAR(ApplItemQty);
                        CLEAR(ApplEntryBaseQty);
                        CLEAR(ApplEntryNo);
                        CLEAR(ApplEntryNumTxt);

                        IF "Item Application Entry"."Outbound Item Entry No." = 0 THEN
                            CurrReport.SKIP;

                        IF "Item Application Entry"."Outbound Item Entry No." = "Item Ledger Entry"."Entry No." THEN BEGIN
                            ILERec.GET("Item Application Entry"."Inbound Item Entry No.");
                            ApplDocNo := ILERec."Document No.";
                            ApplEntryNo := ILERec."Entry No.";
                            ApplItemNo := ILERec."Item No.";
                            ApplItemQty := ABS("Item Ledger Entry".Quantity);
                            ApplEntryBaseQty := ILERec.Quantity;
                            ApplEntryNo := ILERec."Entry No.";
                            ApplEntryNumTxt := FORMAT(ApplEntryNo);
                        END;

                        IF ("Item Application Entry"."Outbound Item Entry No." <> "Item Ledger Entry"."Entry No.") THEN BEGIN
                            ILERec.GET("Item Application Entry"."Outbound Item Entry No.");
                            ApplDocNo := ILERec."Document No.";
                            ApplEntryNo := ILERec."Entry No.";
                            ApplItemNo := ILERec."Item No.";
                            ApplItemQty := ABS("Item Ledger Entry".Quantity);
                            ApplEntryBaseQty := ILERec.Quantity;
                            ApplEntryNo := ILERec."Entry No.";
                            ApplEntryNumTxt := FORMAT(ApplEntryNo);
                        END;
                        CurRowNo += 1;
                        EnterCell(CurRowNo, 1, "Item Ledger Entry"."Document No.", FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                        EnterCell(CurRowNo, 2, "Item Ledger Entry"."Item No.", FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                        EnterCell(CurRowNo, 3, "Item Ledger Entry"."Location Code", FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                        EnterCell(CurRowNo, 4, FORMAT("Item Ledger Entry"."Entry No."), FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                        EnterCell(CurRowNo, 5, FORMAT("Item Ledger Entry".Quantity), FALSE, FALSE, FALSE, '#,##0.00', ExcelBuffer."Cell Type"::Number);
                        EnterCell(CurRowNo, 6, '           ', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                        EnterCell(CurRowNo, 7, ApplDocNo, FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                        EnterCell(CurRowNo, 8, ApplItemNo, FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                        EnterCell(CurRowNo, 9, FORMAT(ABS("Item Application Entry".Quantity)), FALSE, FALSE, FALSE, '#,##0.00', ExcelBuffer."Cell Type"::Number);
                        EnterCell(CurRowNo, 10, FORMAT(ApplEntryBaseQty), FALSE, FALSE, FALSE, '#,##0.00', ExcelBuffer."Cell Type"::Number);
                        EnterCell(CurRowNo, 11, ApplEntryNumTxt, FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    /*ItemApplEntrRec.RESET;
                    ItemApplEntrRec.SETRANGE("Item Ledger Entry No.","Item Ledger Entry"."Entry No.");
                    ItemApplEntrRec.SETRANGE("Outbound Item Entry No.",0);
                    IF ItemApplEntrRec.FINDFIRST THEN
                    CurrReport.SKIP;
                    
                    ILEDocNo := "Item Ledger Entry"."Document No.";
                    ILEItemNo := "Item Ledger Entry"."Item No.";
                    ILELocNo := "Item Ledger Entry"."Location Code";
                    ILEEntryNum := "Item Ledger Entry"."Entry No.";
                    ILEQty := "Item Ledger Entry".Quantity;
                    
                    IF "Item Ledger Entry"."Entry Type" = "Item Ledger Entry"."Entry Type"::" " THEN
                      ILEEntryType := '';
                    IF "Item Ledger Entry"."Entry Type" = "Item Ledger Entry"."Entry Type"::"Assembly Consumption" THEN
                      ILEEntryType := 'Assembly Consumption';
                    IF "Item Ledger Entry"."Entry Type" = "Item Ledger Entry"."Entry Type"::"Assembly Output" THEN
                      ILEEntryType := 'Assembly Output';
                    IF "Item Ledger Entry"."Entry Type" = "Item Ledger Entry"."Entry Type"::Consumption THEN
                      ILEEntryType := 'Consumption';
                    IF "Item Ledger Entry"."Entry Type" = "Item Ledger Entry"."Entry Type"::"Negative Adjmt." THEN
                      ILEEntryType := 'Negative Adjmt.';
                    IF "Item Ledger Entry"."Entry Type" = "Item Ledger Entry"."Entry Type"::Output THEN
                      ILEEntryType := 'Output';
                    IF "Item Ledger Entry"."Entry Type" = "Item Ledger Entry"."Entry Type"::"Positive Adjmt." THEN
                      ILEEntryType := 'Positive Adjmt.';
                    IF "Item Ledger Entry"."Entry Type" = "Item Ledger Entry"."Entry Type"::Purchase THEN
                      ILEEntryType := 'Purchase';
                    IF "Item Ledger Entry"."Entry Type" = "Item Ledger Entry"."Entry Type"::Sale THEN
                      ILEEntryType := 'Sale';
                    IF "Item Ledger Entry"."Entry Type" = "Item Ledger Entry"."Entry Type"::Transfer THEN
                      ILEEntryType := 'Transfer';
                    
                    GD1Code := "Item Ledger Entry"."Global Dimension 1 Code";
                    */

                end;
            }

            trigger OnPreDataItem()
            begin
                //StartDate := Item.GETRANGEMIN("Date Filter");
                //EndDate := Item.GETRANGEMAX("Date Filter");
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
        ExcelBuffer.CreateNewBook('Application Entry Report');
        ExcelBuffer.WriteSheet('Application Entry Report', CompanyName, UserId);
        ExcelBuffer.CloseBook();
        ExcelBuffer.SetFriendlyFilename(StrSubstNo('GC Statement', CurrentDateTime, UserId));
        ExcelBuffer.OpenExcel();
        // ExcelBuffer.CreateBookAndOpenExcel('', 'Application Entry Report', 'Application Entry Report', COMPANYNAME, USERID);
        //ExcelBuffer.GiveUserControl;
    end;

    trigger OnPreReport()
    begin
        CompInfo.GET;
        CompInfo.CALCFIELDS(Picture);

        ExcelBuffer.DELETEALL;
        CurRowNo := 1;
        EnterCell(CurRowNo, 3, 'Item Detail', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        EnterCell(CurRowNo, 9, 'Application Entry detail', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        CurRowNo += 1;
        EnterCell(CurRowNo, 1, 'Document No.', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        EnterCell(CurRowNo, 2, 'Item No', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        EnterCell(CurRowNo, 3, 'Location', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        EnterCell(CurRowNo, 4, 'Entry No', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        EnterCell(CurRowNo, 5, 'Quantity', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        EnterCell(CurRowNo, 6, '           ', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        EnterCell(CurRowNo, 7, 'Document No.', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        EnterCell(CurRowNo, 8, 'Item No', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        EnterCell(CurRowNo, 9, 'Apply Item Quantity', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        EnterCell(CurRowNo, 10, 'Entry Base Quantity', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        EnterCell(CurRowNo, 11, 'Apply Entry No.', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
    end;

    var
        ExcelBuffer: Record 370 temporary;
        CurRowNo: Integer;
        CompInfo: Record 79;
        StartDate: Date;
        EndDate: Date;
        ItemApplEntrRec: Record 339;
        ILERec: Record 32;
        ILEDocNo: Code[20];
        ILEItemNo: Code[20];
        ILELocNo: Code[20];
        ILEEntryNum: Integer;
        ILEQty: Decimal;
        ILEEntryType: Text;
        GD1Code: Code[20];
        ApplDocNo: Code[20];
        ApplItemNo: Code[20];
        ApplItemQty: Decimal;
        ApplEntryBaseQty: Decimal;
        ApplEntryNo: Integer;
        ApplEntryNumTxt: Text;

    local procedure EnterCell(RowNo: Integer; ColumnNo: Integer; CellValue: Text[250]; Bold: Boolean; Italic: Boolean; UnderLine: Boolean; Format: Text[30]; CellType: Option)
    begin
        ExcelBuffer.INIT;
        ExcelBuffer.VALIDATE("Row No.", RowNo);
        ExcelBuffer.VALIDATE("Column No.", ColumnNo);
        ExcelBuffer."Cell Value as Text" := CellValue;
        ExcelBuffer.Formula := '';
        ExcelBuffer.Bold := Bold;
        ExcelBuffer.Italic := Italic;
        ExcelBuffer.Underline := UnderLine;
        ExcelBuffer.NumberFormat := Format;
        ExcelBuffer."Cell Type" := CellType;
        ExcelBuffer.INSERT;
    end;
}

