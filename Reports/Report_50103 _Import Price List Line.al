report 50103 "Import Price List Lines"
{

    ProcessingOnly = true;

    dataset
    {
        dataitem(DataItem1000000000; 2000000026)
        {
            DataItemTableView = SORTING(Number);

            trigger OnAfterGetRecord()
            begin
                ImportSheet(Number);
            end;

            trigger OnPreDataItem()
            begin
                ExcelBuf.OpenBook(ServerFileName, SheetName);
                ExcelBuf.ReadSheet;
                SETRANGE(Number, 2, ExcelBuf.COUNT);
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
        trigger OnQueryClosePage(CloseAction: Action): Boolean
        var
            FileMgt: Codeunit "File Management";
        begin
            IF CloseAction = ACTION::OK THEN BEGIN
                ServerFileName := FileMgt.UploadFile(Text006, ExcelFileExtensionTok);
                IF ServerFileName = '' THEN
                    EXIT(FALSE);

                SheetName := ExcelBuf.SelectSheetsName(ServerFileName);
                IF SheetName = '' THEN
                    EXIT(FALSE);

            END;
        end;
    }
    labels
    {
    }

    trigger OnPostReport()
    begin
        ExcelBuf.DELETEALL;
        MESSAGE('Import Data');
    end;

    var
        OutputJnlLine: Record "Item Journal Line";

        ExcelBuf: Record "Excel Buffer" temporary;
        ServerFileName: Text;
        SheetName: Text[250];
        Text005: Label 'Imported from Excel ';
        Text006: Label 'Import Excel File';
        ExcelFileExtensionTok: Label '.xlsx', Locked = true;
        FileName: Text;
        ResNo: Code[20];
        CountData: Integer;
        LastNoSeries: Code[20];
        Rec_Item: Record Item;
        "Type Slect": Option " ",Lines,Update;
        ColText1: array[12] of Text[250];
        seyinteg: Integer;
        DimSetID: Integer;
        CText1: array[3] of Text;
        ReservationEntry1: Record "Reservation Entry";
        // ReservationEntry: Record "Reservation Entry";

        ReservationEntry: Record "Reservation Entry";
        GlobalDocNo: Code[20];
        GlobalBatchName: Code[20];
        GlobalTemplname: Code[20];
        BatchName: Code[20];
        Templname: Code[20];
        LineNum: Integer;
        LOC_Code: Code[10];
        Entry_Num: Integer;
        LineNo: Integer;
        ItemNum: Code[20];
        LocationCode: Code[10];
        VarItemNo: Code[20];
        ILE: Record "Item Ledger Entry";
        pagerec: Page 6510;
        line: Integer;
        ItemJournalLine: Record "Item Journal Line";
        TrackSpec: Record "Tracking Specification";
        ResEntry: Record "Reservation Entry";
        ResEntry1: Record "Reservation Entry";
        ILeRec1: Record "Item Ledger Entry";
        REntry: Record "Reservation Entry";
        RelProdUrder: Record "Production Order";
        VarLotNo: Code[50];
        ItemtrackCode: Record "Item Tracking Code";
        Rec_Item1: Record Item;
        PLLine: Record "Price List Line";
        PLLine1: Record "Price List Line";
        T7002: Record "Price List Line";
        saleprice: Record "Sales Price";

    procedure ImportSheet(RowNum: Integer)
    begin

        CLEAR(ColText1);
        Clear(VarItemNo);
        Clear(LOC_Code);
        Clear(line);
        ExcelBuf.SETRANGE(ExcelBuf."Row No.", RowNum);
        IF ExcelBuf.FINDSET THEN
            REPEAT
                ColText1[ExcelBuf."Column No."] := ExcelBuf."Cell Value as Text";
            UNTIL ExcelBuf.NEXT = 0;
        IF ColText1[1] <> '' THEN BEGIN
            // if SheetName <> '' then begin
            LineNo := GetEntryNo(GlobalDocNo);

            PLLine.Reset();
            if PLLine.FindLast() then begin
                PLLine.Init();
                PLLine."Price List Code" := GlobalDocNo;
                PLLine."Line No." := LineNo;
                PLLine.Insert();
            end;
            if ColText1[1] <> '' then begin
                Evaluate(PLLine."Asset Type", ColText1[1]);
                PLLine.Validate("Asset Type");
            end;
            if ColText1[2] <> '' then begin
                PLLine.validate("Product No1", ColText1[2]);
            end;
            if ColText1[3] <> '' then begin
                PLLine.validate(Description, ColText1[3]);
            end;
            if ColText1[4] <> '' then begin
                PLLine.validate("Source No.", ColText1[4]);
            end;
            if ColText1[5] <> '' then begin
                PLLine.validate(PLLine."Variant Code", ColText1[5]);
            end;
            if ColText1[6] <> '' then begin
                PLLine.validate("Unit of Measure Code", ColText1[6]);
            end;
            if ColText1[7] <> '' then begin
                Evaluate(PLLine."Unit Price", ColText1[7]);
                PLLine.validate("Unit Price");
            end;
            if ColText1[8] <> '' then begin
                Evaluate(PLLine."Starting Date", ColText1[8]);
                //  PLLine.validate("Staring Data");
                // PLLine."Starting Date" := ColText1[8];
            end;
            IF ColText1[5] <> '' THEN BEGIN
                //PRU-VG
                T7002.RESET;
                //                T7002.SETRANGE(T7002."Price List Code", GlobalDocNo);
                T7002.SETRANGE(T7002."Product No.", PLLine."Product No.");
                T7002.SETRANGE("Unit of Measure Code", PLLine."Unit of Measure Code");
                T7002.SETFILTER("Variant Code", '%1|%2', PLLine."Variant Code", '');
                T7002.SETRANGE("Ending Date", 0D);
                IF T7002.FINDFIRST THEN BEGIN
                    //  Message('%1..', T7002."Variant Code");
                    IF T7002."Starting Date" < PLLine."Starting Date" THEN BEGIN
                        // Message('%1.....%2...', T7002."Starting Date", PLLine."Starting Date");
                        T7002."Ending Date" := CALCDATE('-1D', PLLine."Starting Date");
                        T7002."Ending Data" := CALCDATE('-1D', PLLine."Starting Date");
                        T7002.MODIFY;
                    END;
                END;
            END ELSE BEGIN
                //PRU-VG
                T7002.RESET;
                //T7002.SETRANGE(T7002."Price List Code", GlobalDocNo);
                T7002.SETRANGE(T7002."Product No.", PLLine."Product No.");
                T7002.SETRANGE("Unit of Measure Code", PLLine."Unit of Measure Code");
                T7002.SETFILTER("Variant Code", '%1', '');
                T7002.SETRANGE("Ending Date", 0D);
                IF T7002.FINDFIRST THEN BEGIN
                    REPEAT
                        // Message('%1..', PLLine."Starting Date");
                        IF T7002."Starting Date" <= PLLine."Starting Date" THEN BEGIN
                            T7002."Ending Date" := CALCDATE('-1D', PLLine."Starting Date");
                            T7002."Ending Data" := CALCDATE('-1D', PLLine."Starting Date");
                            T7002.MODIFY;
                        END;
                    UNTIL T7002.NEXT = 0;
                END;
                //PRU-VG
            END;

            //PLLine."Ending Date" := T7002."Ending Date";

            /*
             if ColText1[9] <> '' then begin
                 Evaluate(PLLine."Ending Data", ColText1[9]);
                 PLLine.validate("Ending Data");
             end;
             */
            if ColText1[10] <> '' then begin
                Evaluate(PLLine.MRP, ColText1[10]);
                PLLine.validate(MRP);
            end;
            if ColText1[11] <> '' then begin
                Evaluate(PLLine."MRP PRICE", ColText1[11]);
                PLLine.validate("MRP PRICE");
            end;
            if ColText1[12] <> '' then begin
                Evaluate(PLLine."Discount Perc/Amount", ColText1[12]);
                PLLine.validate("Discount Perc/Amount");
            end;
            PLLine.MODIFY(TRUE);
            /////////////////////////////////
        end;

    END;

    procedure GetDocNo(Salescode: Code[20])
    begin
        GlobalDocNo := Salescode;
    end;

    local procedure GetEntryNo(DocNo: Code[20]): Integer
    var
        NextSalesLine: Record "Price List Line";

    begin
        NextSalesLine.Reset();
        NextSalesLine.SetRange(NextSalesLine."Price List Code", DocNo);
        if NextSalesLine.FindLast() then
            exit(NextSalesLine."Line No." + 10000)
        else
            exit(10000);

    end;

}