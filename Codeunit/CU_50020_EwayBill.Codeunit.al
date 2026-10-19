codeunit 50020 "Eway-Bill"
{

    trigger OnRun()
    begin
        IF ISNULL(StringBuilder) THEN
            Initialize;

        IF IsInvoice THEN
            WITH SalesInvoiceHeader DO BEGIN
                IF "GST Customer Type" IN ["GST Customer Type"::Unregistered, "GST Customer Type"::" "]
                THEN
                    ERROR(UnRegCusrErr);
                DocumentNo := "No.";
                WriteFileHeader;
                JsonTextWriter.WriteEndObject;
                JsonTextWriter.Flush;
                //MESSAGE(StringBuilder.ToString);
            END;

        IF DocumentNo <> '' THEN
            ExportAsJson(DocumentNo)
        ELSE
            ERROR(RecIsEmptyErr);
    end;

    var
        SalesInvoiceHeader: Record 112;
        SalesCrMemoHeader: Record 114;
        StringBuilder: DotNet StringBuilder;
        StringWriter: DotNet StringWriter;
        JsonTextWriter: DotNet JsonTextWriter;
        JsonFormatting: DotNet Formatting;
        GlobalNULL: Variant;
        UnRegCusrErr: Label 'E-Invoicing is not applicable for Unregistered Customer.';
        RecIsEmptyErr: Label 'Record variable uninitialized.';
        IsInvoice: Boolean;
        SalesLinesErr: Label 'E-Invoice allowes only 100 lines per Invoice. Curent transaction is having %1 lines.', Comment = '%1 = Sales Lines count';
        DocumentNo: Text[20];
        FromPostcode: Integer;
        FromStatecode: Integer;
        ToPostcode: Integer;
        ToStatecode: Integer;
        GSTLineAmount: Decimal;
        TotalIGST: Decimal;
        TotalSGST: Decimal;
        TotalCGST: Decimal;
        ItemNo: Integer;
        HSNSAC: Integer;
        UOM: Text[8];
        OTHTxt: Label 'OTH';
        ShiptoAddress: Record 222;
        SalesInvLine: Record 113;
        Othchrg: Decimal;

    local procedure Initialize()
    begin
        StringBuilder := StringBuilder.StringBuilder;
        StringWriter := StringWriter.StringWriter(StringBuilder);
        JsonTextWriter := JsonTextWriter.JsonTextWriter(StringWriter);
        JsonTextWriter.Formatting := JsonFormatting.Indented;

        CLEAR(GlobalNULL);
    end;

    local procedure WriteFileHeader()
    var
        Location: Record 14;
        State: Record State;
        Customer: Record 18;
        DetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry";
        Vendor: Record 23;
    begin
        Location.RESET;
        Location.GET(SalesInvoiceHeader."Location Code");
        State.RESET;
        State.GET(Location."State Code");
        JsonTextWriter.WriteStartObject;
        JsonTextWriter.WritePropertyName('Version');
        JsonTextWriter.WriteValue('1.0.1020');
        JsonTextWriter.WritePropertyName('billLists');
        JsonTextWriter.WriteStartArray;
        JsonTextWriter.WriteStartObject;
        // Seller Details
        JsonTextWriter.WritePropertyName('userGstin');
        JsonTextWriter.WriteValue(Location."GST Registration No.");
        JsonTextWriter.WritePropertyName('supplyType');
        JsonTextWriter.WriteValue('O');
        JsonTextWriter.WritePropertyName('subSupplyType');
        JsonTextWriter.WriteValue(1);
        JsonTextWriter.WritePropertyName('docType');
        IF SalesInvoiceHeader."Invoice Type" = SalesInvoiceHeader."Invoice Type"::Taxable THEN BEGIN
            JsonTextWriter.WriteValue('INV')
        END ELSE
            if SalesInvoiceHeader."Invoice Type" = SalesInvoiceHeader."Invoice Type"::"Bill of Supply" then
                JsonTextWriter.WriteValue('BIL');
        JsonTextWriter.WritePropertyName('docNo');
        JsonTextWriter.WriteValue(SalesInvoiceHeader."No.");
        JsonTextWriter.WritePropertyName('docDate');
        JsonTextWriter.WriteValue(FORMAT(SalesInvoiceHeader."Posting Date", 0, '<Day,2>/<Month,2>/<Year4>'));
        JsonTextWriter.WritePropertyName('transType');
        JsonTextWriter.WriteValue(1);
        JsonTextWriter.WritePropertyName('fromGstin');
        JsonTextWriter.WriteValue(Location."GST Registration No.");
        JsonTextWriter.WritePropertyName('fromTrdName');
        JsonTextWriter.WriteValue(Location.Name);
        JsonTextWriter.WritePropertyName('fromAddr1');
        JsonTextWriter.WriteValue(Location.Address);
        JsonTextWriter.WritePropertyName('fromAddr2');
        JsonTextWriter.WriteValue(Location."Address 2");
        JsonTextWriter.WritePropertyName('fromPlace');
        JsonTextWriter.WriteValue(Location.City);
        EVALUATE(FromPostcode, Location."Post Code");
        EVALUATE(FromStatecode, State."State Code (GST Reg. No.)");
        JsonTextWriter.WritePropertyName('fromPincode');
        JsonTextWriter.WriteValue(FromPostcode);
        JsonTextWriter.WritePropertyName('fromStateCode');
        JsonTextWriter.WriteValue(FromStatecode);
        JsonTextWriter.WritePropertyName('actualFromStateCode');
        JsonTextWriter.WriteValue(FromStatecode);
        // Buyer Ditails
        IF SalesInvoiceHeader."Ship-to Code" <> '' THEN BEGIN
            ShiptoAddress.RESET;
            ShiptoAddress.SETRANGE(ShiptoAddress.Code, SalesInvoiceHeader."Ship-to Code");
            ShiptoAddress.SETRANGE(ShiptoAddress."Customer No.", SalesInvoiceHeader."Sell-to Customer No.");
            IF ShiptoAddress.FINDFIRST THEN;
            State.RESET;
            State.GET(ShiptoAddress.State);
            EVALUATE(ToPostcode, ShiptoAddress."Post Code");
            EVALUATE(ToStatecode, State."State Code (GST Reg. No.)");
            JsonTextWriter.WritePropertyName('toGstin');
            JsonTextWriter.WriteValue(ShiptoAddress."GST Registration No.");
            JsonTextWriter.WritePropertyName('toTrdName');
            JsonTextWriter.WriteValue(ShiptoAddress.Name);
            JsonTextWriter.WritePropertyName('toAddr1');
            JsonTextWriter.WriteValue(ShiptoAddress.Address);
            JsonTextWriter.WritePropertyName('toAddr2');
            JsonTextWriter.WriteValue(ShiptoAddress."Address 2");
            JsonTextWriter.WritePropertyName('toPlace');
            JsonTextWriter.WriteValue(ShiptoAddress.City);
            JsonTextWriter.WritePropertyName('toPincode');
            JsonTextWriter.WriteValue(ToPostcode);
            JsonTextWriter.WritePropertyName('toStateCode');
            JsonTextWriter.WriteValue(ToStatecode);
            JsonTextWriter.WritePropertyName('actualToStateCode');
            JsonTextWriter.WriteValue(ToStatecode);
        END ELSE BEGIN
            Customer.RESET;
            Customer.GET(SalesInvoiceHeader."Sell-to Customer No.");
            State.RESET;
            State.GET(Customer."State Code");
            EVALUATE(ToPostcode, Customer."Post Code");
            EVALUATE(ToStatecode, State."State Code (GST Reg. No.)");
            JsonTextWriter.WritePropertyName('toGstin');
            JsonTextWriter.WriteValue(Customer."GST Registration No.");
            JsonTextWriter.WritePropertyName('toTrdName');
            JsonTextWriter.WriteValue(Customer.Name);
            JsonTextWriter.WritePropertyName('toAddr1');
            JsonTextWriter.WriteValue(Customer.Address);
            JsonTextWriter.WritePropertyName('toAddr2');
            JsonTextWriter.WriteValue(Customer."Address 2");
            JsonTextWriter.WritePropertyName('toPlace');
            JsonTextWriter.WriteValue(Customer.City);
            JsonTextWriter.WritePropertyName('toPincode');
            JsonTextWriter.WriteValue(ToPostcode);
            JsonTextWriter.WritePropertyName('toStateCode');
            JsonTextWriter.WriteValue(ToStatecode);
            JsonTextWriter.WritePropertyName('actualToStateCode');
            JsonTextWriter.WriteValue(ToStatecode);
        END;
        // Inv Value Details
        DetailedGSTLedgerEntry.RESET;
        DetailedGSTLedgerEntry.SETRANGE(DetailedGSTLedgerEntry."Document Type", DetailedGSTLedgerEntry."Document Type"::Invoice);
        DetailedGSTLedgerEntry.SETRANGE(DetailedGSTLedgerEntry."Transaction Type", DetailedGSTLedgerEntry."Transaction Type"::Sales);
        DetailedGSTLedgerEntry.SETRANGE(DetailedGSTLedgerEntry."Document No.", DocumentNo);
        IF DetailedGSTLedgerEntry.FINDSET THEN
            REPEAT
                IF DetailedGSTLedgerEntry."GST Component Code" = 'IGST' THEN BEGIN
                    GSTLineAmount += ABS(DetailedGSTLedgerEntry."GST Base Amount");
                    TotalIGST += ABS(DetailedGSTLedgerEntry."GST Amount");
                END;
                IF DetailedGSTLedgerEntry."GST Component Code" = 'SGST' THEN BEGIN
                    TotalSGST += ABS(DetailedGSTLedgerEntry."GST Amount");
                    GSTLineAmount += ABS(DetailedGSTLedgerEntry."GST Base Amount") / 2;
                END;
                IF DetailedGSTLedgerEntry."GST Component Code" = 'CGST' THEN BEGIN
                    TotalCGST += ABS(DetailedGSTLedgerEntry."GST Amount");
                    GSTLineAmount += ABS(DetailedGSTLedgerEntry."GST Base Amount") / 2;
                END;
            UNTIL DetailedGSTLedgerEntry.NEXT = 0;
        SalesInvLine.RESET;
        SalesInvLine.SETRANGE(SalesInvLine."Posting Date", SalesInvoiceHeader."Posting Date");
        SalesInvLine.SETRANGE(SalesInvLine."Document No.", SalesInvoiceHeader."No.");
        SalesInvLine.SETRANGE(SalesInvLine.Type, SalesInvLine.Type::"G/L Account");
        SalesInvLine.SETRANGE(SalesInvLine."No.", GetRoundingAccount);
        IF SalesInvLine.FINDFIRST THEN
            Othchrg := SalesInvLine.Amount;
        //MESSAGE(GetRoundingAccount);
        JsonTextWriter.WritePropertyName('totalValue');
        JsonTextWriter.WriteValue(GSTLineAmount + TotalCGST + TotalIGST + TotalSGST);
        JsonTextWriter.WritePropertyName('cgstValue');
        JsonTextWriter.WriteValue(TotalCGST);
        JsonTextWriter.WritePropertyName('sgstValue');
        JsonTextWriter.WriteValue(TotalSGST);
        JsonTextWriter.WritePropertyName('igstValue');
        JsonTextWriter.WriteValue(TotalIGST);
        JsonTextWriter.WritePropertyName('cessValue');
        JsonTextWriter.WriteValue(0);
        JsonTextWriter.WritePropertyName('TotNonAdvolVal');
        JsonTextWriter.WriteValue(0);
        JsonTextWriter.WritePropertyName('OthValue');
        JsonTextWriter.WriteValue(ABS(Othchrg));
        JsonTextWriter.WritePropertyName('totInvValue');
        JsonTextWriter.WriteValue(TotalCGST + TotalIGST + TotalSGST + GSTLineAmount + Othchrg);
        // Transport Details
        JsonTextWriter.WritePropertyName('transMode');
        JsonTextWriter.WriteValue(1);
        JsonTextWriter.WritePropertyName('transDistance');
        JsonTextWriter.WriteValue(SalesInvoiceHeader."Distance (Km)");
        IF SalesInvoiceHeader."Transporter Code" <> '' THEN
            Vendor.GET(SalesInvoiceHeader."Transporter Code");
        JsonTextWriter.WritePropertyName('transporterName');
        JsonTextWriter.WriteValue(Vendor.Name);
        JsonTextWriter.WritePropertyName('transporterId');
        JsonTextWriter.WriteValue(Vendor."GST Registration No.");
        JsonTextWriter.WritePropertyName('transDocNo');
        JsonTextWriter.WriteValue(DELCHR(SalesInvoiceHeader."LR/RR No.", '=', '/\-.'));
        JsonTextWriter.WritePropertyName('transDocDate');
        JsonTextWriter.WriteValue(FORMAT(SalesInvoiceHeader."LR/RR Date", 0, '<Day,2>/<Month,2>/<Year4>'));
        JsonTextWriter.WritePropertyName('vehicleNo');
        JsonTextWriter.WriteValue(SalesInvoiceHeader."Vehicle No.");
        JsonTextWriter.WritePropertyName('vehicleType');
        JsonTextWriter.WriteValue('R');
        JsonTextWriter.WritePropertyName('mainHsnCode');
        JsonTextWriter.WriteValue(0);
        // Read Item Details
        ReadItemList;
        JsonTextWriter.WriteEndObject;
        JsonTextWriter.WriteEndArray;
        //END;
    end;

    local procedure WriteBchDtls(Nm: Text[20]; ExpDt: Text[10]; WrDt: Text[10])
    begin
        JsonTextWriter.WritePropertyName('Nm');
        IF Nm <> '' THEN
            JsonTextWriter.WriteValue(Nm)
        ELSE
            JsonTextWriter.WriteValue(GlobalNULL);
        JsonTextWriter.WritePropertyName('ExpDt');
        IF ExpDt <> '' THEN
            JsonTextWriter.WriteValue(ExpDt)
        ELSE
            JsonTextWriter.WriteValue(GlobalNULL);
        JsonTextWriter.WritePropertyName('WrDt');
        IF WrDt <> '' THEN
            JsonTextWriter.WriteValue(WrDt)
        ELSE
            JsonTextWriter.WriteValue(GlobalNULL);
    end;

    local procedure ExportAsJson(FileName: Text[20])
    var
        TempFile: File;
        ToFile: Variant;
        NewStream: InStream;
        instr: InStream;
        outstr: OutStream;
        temblob: Codeunit "Temp Blob";
    begin
        //TempFile.CREATETEMPFILE;

        //TempFile.Write(StringBuilder.ToString);
        // TempFile.WRITE(StringBuilder.ToString);
        temblob.CreateOutStream(outstr, TextEncoding::Windows);

        outstr.WriteText(StringBuilder.ToString);
        //   TempFile.CREATEINSTREAM(NewStream);
        temblob.CreateInStream(instr, TextEncoding::Windows);
        ToFile := FileName + '.json';
        DOWNLOADFROMSTREAM(instr, 'e-Invoice', '', 'JSON files|*.json|All files (*.*)|*.*', ToFile);
        //  TempFile.CLOSE;
    end;


    procedure SetSalesInvHeader(SalesInvoiceHeaderBuff: Record 112)
    begin
        SalesInvoiceHeader := SalesInvoiceHeaderBuff;
        IsInvoice := TRUE;
    end;


    procedure SetCrMemoHeader(SalesCrMemoHeaderBuff: Record 114)
    begin
        SalesCrMemoHeader := SalesCrMemoHeaderBuff;
        IsInvoice := FALSE;
    end;

    local procedure ReadItemList()
    var
        SalesInvoiceLine: Record 113;
        SalesCrMemoLine: Record 115;
        AssAmt: Decimal;
        CgstRt: Decimal;
        SgstRt: Decimal;
        IgstRt: Decimal;
        CesRt: Decimal;
        CesNonAdval: Decimal;
        StateCes: Decimal;
        FreeQty: Decimal;
        UnitofMeasure: Record 204;
    begin
        IF IsInvoice THEN BEGIN
            SalesInvoiceLine.SETRANGE("Document No.", DocumentNo);
            SalesInvoiceLine.SETRANGE(SalesInvoiceLine.Type, SalesInvoiceLine.Type::Item);
            IF SalesInvoiceLine.FINDSET THEN BEGIN
                IF SalesInvoiceLine.COUNT > 100 THEN
                    ERROR(SalesLinesErr, SalesInvoiceLine.COUNT);
                JsonTextWriter.WritePropertyName('ItemList');
                JsonTextWriter.WriteStartArray;
                //JsonTextWriter.WritePropertyName('Item');
                REPEAT
                    JsonTextWriter.WriteStartObject;
                    //IF SalesInvoiceLine."GST Assessable Value (LCY)" <> 0 THEN
                    //AssAmt := SalesInvoiceLine."GST Assessable Value (LCY)"
                    //ELSE
                    AssAmt := SalesInvoiceLine.Amount;
                    // IF SalesInvoiceLine."Free Supply" THEN
                    //   FreeQty := SalesInvoiceLine.Quantity
                    // ELSE
                    FreeQty := 0;
                    EVALUATE(HSNSAC, SalesInvoiceLine."HSN/SAC Code");
                    ItemNo += 1;
                    GetGSTCompRate(SalesInvoiceLine."Document No.", SalesInvoiceLine."Line No.",
                    CgstRt, SgstRt, IgstRt, CesRt, CesNonAdval, StateCes);
                    JsonTextWriter.WritePropertyName('itemNo');
                    JsonTextWriter.WriteValue(ItemNo);
                    JsonTextWriter.WritePropertyName('productName');
                    JsonTextWriter.WriteValue(SalesInvoiceLine.Description + ' ' + SalesInvoiceLine."Description 2");
                    JsonTextWriter.WritePropertyName('productDesc');
                    JsonTextWriter.WriteValue('');
                    JsonTextWriter.WritePropertyName('hsnCode');
                    JsonTextWriter.WriteValue(HSNSAC);
                    JsonTextWriter.WritePropertyName('quantity');
                    JsonTextWriter.WriteValue(SalesInvoiceLine.Quantity);
                    //        UnitofMeasure.RESET;
                    //        UnitofMeasure.GET(SalesInvoiceLine."Unit of Measure");
                    CLEAR(UOM);
                    IF SalesInvoiceLine."Unit of Measure Code" <> '' THEN BEGIN
                        UnitofMeasure.GET(SalesInvoiceLine."Unit of Measure Code");
                        UOM := COPYSTR(UnitofMeasure."E-Invoicing UOM Code", 1, 8)
                    END ELSE
                        UOM := OTHTxt;
                    JsonTextWriter.WritePropertyName('qtyUnit');
                    //MESSAGE('%1,%2',UnitofMeasure."E-invoice UOM",SalesInvoiceLine."Unit of Measure");
                    JsonTextWriter.WriteValue(UOM);
                    JsonTextWriter.WritePropertyName('taxableAmount');
                    JsonTextWriter.WriteValue(SalesInvoiceLine."Line Amount");
                    JsonTextWriter.WritePropertyName('sgstRate');
                    JsonTextWriter.WriteValue(SgstRt);
                    JsonTextWriter.WritePropertyName('cgstRate');
                    JsonTextWriter.WriteValue(CgstRt);
                    JsonTextWriter.WritePropertyName('igstRate');
                    JsonTextWriter.WriteValue(IgstRt);
                    JsonTextWriter.WritePropertyName('cessRate');
                    JsonTextWriter.WriteValue(CesRt);
                    JsonTextWriter.WritePropertyName('cessNonAdvol');
                    JsonTextWriter.WriteValue(CesNonAdval);
                    JsonTextWriter.WriteEndObject;
                UNTIL SalesInvoiceLine.NEXT = 0;
                JsonTextWriter.WriteEndArray;

            END;
        END;
    end;

    local procedure WriteItem(PrdNm: Text[100]; PrdDesc: Text[100]; HsnCd: Text[8]; Barcde: Text[30]; Qty: Decimal; FreeQty: Decimal; Unit: Text[3]; UnitPrice: Decimal; TotAmt: Decimal; Discount: Decimal; OthChrg: Decimal; AssAmt: Decimal; CgstRt: Decimal; SgstRt: Decimal; IgstRt: Decimal; CesRt: Decimal; CesNonAdval: Decimal; StateCes: Decimal; TotItemVal: Decimal; SILineNo: Integer)
    var
        ValueEntry: Record 5802;
        ItemLedgerEntry: Record 32;
        ValueEntryRelation: Record 6508;
        ItemTrackingManagement: Codeunit 6500;
        InvoiceRowID: Text[250];
    begin
        JsonTextWriter.WriteStartObject;
        JsonTextWriter.WritePropertyName('PrdNm');
        IF PrdNm <> '' THEN
            JsonTextWriter.WriteValue(PrdNm)
        ELSE
            JsonTextWriter.WriteValue(GlobalNULL);
        JsonTextWriter.WritePropertyName('PrdDesc');
        IF PrdDesc <> '' THEN
            JsonTextWriter.WriteValue(PrdDesc)
        ELSE
            JsonTextWriter.WriteValue(GlobalNULL);
        JsonTextWriter.WritePropertyName('HsnCd');
        IF HsnCd <> '' THEN
            JsonTextWriter.WriteValue(HsnCd)
        ELSE
            JsonTextWriter.WriteValue(GlobalNULL);
        JsonTextWriter.WritePropertyName('Barcde');
        IF Barcde <> '' THEN
            JsonTextWriter.WriteValue(Barcde)
        ELSE
            JsonTextWriter.WriteValue(GlobalNULL);
        JsonTextWriter.WritePropertyName('Qty');
        JsonTextWriter.WriteValue(Qty);
        JsonTextWriter.WritePropertyName('FreeQty');
        JsonTextWriter.WriteValue(FreeQty);

        JsonTextWriter.WritePropertyName('Unit');
        IF Unit <> '' THEN
            JsonTextWriter.WriteValue(Unit)
        ELSE
            JsonTextWriter.WriteValue(GlobalNULL);
        JsonTextWriter.WritePropertyName('UnitPrice');
        JsonTextWriter.WriteValue(UnitPrice);
        JsonTextWriter.WritePropertyName('TotAmt');
        JsonTextWriter.WriteValue(TotAmt);
        JsonTextWriter.WritePropertyName('Discount');
        JsonTextWriter.WriteValue(Discount);
        JsonTextWriter.WritePropertyName('OthChrg');
        JsonTextWriter.WriteValue(OthChrg);
        JsonTextWriter.WritePropertyName('AssAmt');
        JsonTextWriter.WriteValue(AssAmt);
        JsonTextWriter.WritePropertyName('CgstRt');
        JsonTextWriter.WriteValue(CgstRt);
        JsonTextWriter.WritePropertyName('SgstRt');
        JsonTextWriter.WriteValue(SgstRt);
        JsonTextWriter.WritePropertyName('IgstRt');
        JsonTextWriter.WriteValue(IgstRt);
        JsonTextWriter.WritePropertyName('CesRt');
        JsonTextWriter.WriteValue(CesRt);
        JsonTextWriter.WritePropertyName('CesNonAdval');
        JsonTextWriter.WriteValue(CesNonAdval);
        JsonTextWriter.WritePropertyName('StateCes');
        JsonTextWriter.WriteValue(StateCes);
        JsonTextWriter.WritePropertyName('TotItemVal');
        JsonTextWriter.WriteValue(TotItemVal);
        IF IsInvoice THEN
            InvoiceRowID := ItemTrackingManagement.ComposeRowID(DATABASE::"Sales Invoice Line", 0, DocumentNo, '', 0, SILineNo)
        ELSE
            InvoiceRowID := ItemTrackingManagement.ComposeRowID(DATABASE::"Sales Cr.Memo Line", 0, DocumentNo, '', 0, SILineNo);
        ValueEntryRelation.SETCURRENTKEY("Source RowId");
        ValueEntryRelation.SETRANGE("Source RowId", InvoiceRowID);
        IF ValueEntryRelation.FINDSET THEN BEGIN
            JsonTextWriter.WritePropertyName('BchDtls');
            JsonTextWriter.WriteStartObject;
            REPEAT
                ValueEntry.GET(ValueEntryRelation."Value Entry No.");
                ItemLedgerEntry.GET(ValueEntry."Item Ledger Entry No.");
                WriteBchDtls(
                  COPYSTR(ItemLedgerEntry."Lot No." + ItemLedgerEntry."Serial No.", 1, 20),
                  FORMAT(ItemLedgerEntry."Expiration Date", 0, '<Year4>-<Month,2>-<Day,2>'),
                  FORMAT(ItemLedgerEntry."Warranty Date", 0, '<Year4>-<Month,2>-<Day,2>'));
            UNTIL ValueEntryRelation.NEXT = 0;
            JsonTextWriter.WriteEndObject;
        END;

        JsonTextWriter.WriteEndObject;
    end;

    local procedure GetGSTCompRate(DocNo: Code[20]; LineNo: Integer; var CgstRt: Decimal; var SgstRt: Decimal; var IgstRt: Decimal; var CesRt: Decimal; var CesNonAdval: Decimal; var StateCes: Decimal)
    var
        DetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry";
    //    GSTComponent: Record 16405;
    begin
        DetailedGSTLedgerEntry.SETRANGE("Document No.", DocNo);
        DetailedGSTLedgerEntry.SETRANGE("Document Line No.", LineNo);

        DetailedGSTLedgerEntry.SETRANGE("GST Component Code", 'CGST');
        IF DetailedGSTLedgerEntry.FINDFIRST THEN
            CgstRt := DetailedGSTLedgerEntry."GST %"
        ELSE
            CgstRt := 0;

        DetailedGSTLedgerEntry.SETRANGE("GST Component Code", 'SGST');
        IF DetailedGSTLedgerEntry.FINDFIRST THEN
            SgstRt := DetailedGSTLedgerEntry."GST %"
        ELSE
            SgstRt := 0;

        DetailedGSTLedgerEntry.SETRANGE("GST Component Code", 'IGST');
        IF DetailedGSTLedgerEntry.FINDFIRST THEN
            IgstRt := DetailedGSTLedgerEntry."GST %"
        ELSE
            IgstRt := 0;

        CesRt := 0;
        CesNonAdval := 0;
        DetailedGSTLedgerEntry.SETRANGE("GST Component Code", 'CESS');
        IF DetailedGSTLedgerEntry.FINDFIRST THEN
            IF DetailedGSTLedgerEntry."GST %" > 0 THEN
                CesRt := DetailedGSTLedgerEntry."GST %"
            ELSE
                CesNonAdval := ABS(DetailedGSTLedgerEntry."GST Amount");

        DetailedGSTLedgerEntry.SETRANGE("GST Component Code", 'INTERCESS');
        IF DetailedGSTLedgerEntry.FINDFIRST THEN
            CesRt := DetailedGSTLedgerEntry."GST %";

        StateCes := 0;
        DetailedGSTLedgerEntry.SETRANGE("GST Component Code");
        IF DetailedGSTLedgerEntry.FINDSET THEN
            REPEAT
                IF NOT (DetailedGSTLedgerEntry."GST Component Code" IN ['CGST', 'SGST', 'IGST', 'CESS', 'INTERCESS'])
                THEN
                    //    IF GSTComponent.GET(DetailedGSTLedgerEntry."GST Component Code") THEN
                    //IF GSTComponent."Exclude from Reports" THEN
                    StateCes := DetailedGSTLedgerEntry."GST %";
            UNTIL DetailedGSTLedgerEntry.NEXT = 0;
    end;

    local procedure GetGSTVal(var AssVal: Decimal; var CgstVal: Decimal; var SgstVal: Decimal; var IgstVal: Decimal; var CesVal: Decimal; var StCesVal: Decimal; var CesNonAdval: Decimal; var Disc: Decimal; var OthChrg: Decimal; var TotInvVal: Decimal)
    var
        SalesInvoiceLine: Record 113;
        SalesCrMemoLine: Record 115;
        GSTLedgerEntry: Record "GST Ledger Entry";
        DetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry";
        CurrExchRate: Record 330;
        CustLedgerEntry: Record 21;
        //  GSTComponent: Record GST C
        TotGSTAmt: Decimal;
    begin
        GSTLedgerEntry.SETRANGE("Document No.", DocumentNo);

        GSTLedgerEntry.SETRANGE("GST Component Code", 'CGST');
        IF GSTLedgerEntry.FINDSET THEN BEGIN
            REPEAT
                CgstVal += ABS(GSTLedgerEntry."GST Amount");
            UNTIL GSTLedgerEntry.NEXT = 0;
        END ELSE
            CgstVal := 0;

        GSTLedgerEntry.SETRANGE("GST Component Code", 'SGST');
        IF GSTLedgerEntry.FINDSET THEN BEGIN
            REPEAT
                SgstVal += ABS(GSTLedgerEntry."GST Amount")
            UNTIL GSTLedgerEntry.NEXT = 0;
        END ELSE
            SgstVal := 0;

        GSTLedgerEntry.SETRANGE("GST Component Code", 'IGST');
        IF GSTLedgerEntry.FINDSET THEN BEGIN
            REPEAT
                IgstVal += ABS(GSTLedgerEntry."GST Amount")
            UNTIL GSTLedgerEntry.NEXT = 0;
        END ELSE
            IgstVal := 0;

        CesVal := 0;
        CesNonAdval := 0;

        GSTLedgerEntry.SETRANGE("GST Component Code", 'INTERCESS');
        IF GSTLedgerEntry.FINDSET THEN
            REPEAT
                CesVal += ABS(GSTLedgerEntry."GST Amount")
            UNTIL GSTLedgerEntry.NEXT = 0;

        DetailedGSTLedgerEntry.Reset();
        DetailedGSTLedgerEntry.SETRANGE("Document No.", DocumentNo);
        DetailedGSTLedgerEntry.SETRANGE("GST Component Code", 'CESS');
        IF DetailedGSTLedgerEntry.FINDFIRST THEN
            REPEAT
                IF DetailedGSTLedgerEntry."GST %" > 0 THEN
                    CesVal += ABS(DetailedGSTLedgerEntry."GST Amount")
                ELSE
                    CesNonAdval += ABS(DetailedGSTLedgerEntry."GST Amount");
            UNTIL GSTLedgerEntry.NEXT = 0;

        GSTLedgerEntry.SETFILTER("GST Component Code", '<>CGST|<>SGST|<>IGST|<>CESS|<>INTERCESS');
        IF GSTLedgerEntry.FINDSET THEN BEGIN
            REPEAT
                // IF GSTComponent.GET(GSTLedgerEntry."GST Component Code") THEN
                //IF GSTComponent."Exclude from Reports" THEN
                StCesVal += ABS(GSTLedgerEntry."GST Amount");
            UNTIL GSTLedgerEntry.NEXT = 0;
        END;

        IF IsInvoice THEN BEGIN
            SalesInvoiceLine.SETRANGE("Document No.", DocumentNo);
            IF SalesInvoiceLine.FINDSET THEN BEGIN
                REPEAT
                    AssVal += SalesInvoiceLine.Amount;
                    DetailedGSTLedgerEntry.Reset();
                    DetailedGSTLedgerEntry.SETRANGE("Document No.", SalesInvoiceLine."Document No.");
                    DetailedGSTLedgerEntry.SETRANGE(DetailedGSTLedgerEntry."Document Line No.", SalesInvoiceLine."Line No.");
                    IF DetailedGSTLedgerEntry.FINDFIRST THEN
                        REPEAT
                            TotGSTAmt += DetailedGSTLedgerEntry."GST Amount"
                        until DetailedGSTLedgerEntry.next = 0;
                    //  TotGSTAmt += SalesInvoiceLine."Total GST Amount";
                    Disc += SalesInvoiceLine."Inv. Discount Amount";
                UNTIL SalesInvoiceLine.NEXT = 0;
            END;

            AssVal := ROUND(
                CurrExchRate.ExchangeAmtFCYToLCY(
                  WORKDATE, SalesInvoiceHeader."Currency Code", AssVal, SalesInvoiceHeader."Currency Factor"), 0.01, '=');
            TotGSTAmt := ROUND(
                CurrExchRate.ExchangeAmtFCYToLCY(
                  WORKDATE, SalesInvoiceHeader."Currency Code", TotGSTAmt, SalesInvoiceHeader."Currency Factor"), 0.01, '=');
            Disc := ROUND(
                CurrExchRate.ExchangeAmtFCYToLCY(
                  WORKDATE, SalesInvoiceHeader."Currency Code", Disc, SalesInvoiceHeader."Currency Factor"), 0.01, '=');
        END ELSE BEGIN
            SalesCrMemoLine.SETRANGE("Document No.", DocumentNo);
            IF SalesCrMemoLine.FINDSET THEN BEGIN
                REPEAT
                    AssVal += SalesCrMemoLine.Amount;
                    DetailedGSTLedgerEntry.Reset();
                    DetailedGSTLedgerEntry.SETRANGE("Document No.", SalesCrMemoLine."Document No.");
                    DetailedGSTLedgerEntry.SETRANGE(DetailedGSTLedgerEntry."Document Line No.", SalesCrMemoLine."Line No.");
                    IF DetailedGSTLedgerEntry.FINDFIRST THEN
                        REPEAT
                            TotGSTAmt += DetailedGSTLedgerEntry."GST Amount"
                        until DetailedGSTLedgerEntry.next = 0;
                    //  TotGSTAmt += SalesCrMemoLine."Total GST Amount";
                    Disc += SalesCrMemoLine."Inv. Discount Amount";
                UNTIL SalesCrMemoLine.NEXT = 0;
            END;

            AssVal := ROUND(
                CurrExchRate.ExchangeAmtFCYToLCY(
                  WORKDATE, SalesCrMemoHeader."Currency Code", AssVal, SalesCrMemoHeader."Currency Factor"), 0.01, '=');
            TotGSTAmt := ROUND(
                CurrExchRate.ExchangeAmtFCYToLCY(
                  WORKDATE, SalesCrMemoHeader."Currency Code", TotGSTAmt, SalesCrMemoHeader."Currency Factor"), 0.01, '=');
            Disc := ROUND(
                CurrExchRate.ExchangeAmtFCYToLCY(
                  WORKDATE, SalesCrMemoHeader."Currency Code", Disc, SalesCrMemoHeader."Currency Factor"), 0.01, '=');
        END;

        CustLedgerEntry.SETCURRENTKEY("Document No.");
        CustLedgerEntry.SETRANGE("Document No.", DocumentNo);
        IF IsInvoice THEN BEGIN
            CustLedgerEntry.SETRANGE("Document Type", CustLedgerEntry."Document Type"::Invoice);
            CustLedgerEntry.SETRANGE("Customer No.", SalesInvoiceHeader."Bill-to Customer No.");
        END ELSE BEGIN
            CustLedgerEntry.SETRANGE("Document Type", CustLedgerEntry."Document Type"::"Credit Memo");
            CustLedgerEntry.SETRANGE("Customer No.", SalesCrMemoHeader."Bill-to Customer No.");
        END;
        IF CustLedgerEntry.FINDFIRST THEN BEGIN
            CustLedgerEntry.CALCFIELDS("Amount (LCY)");
            TotInvVal := ABS(CustLedgerEntry."Amount (LCY)");
        END;

        OthChrg := 0;
    end;

    local procedure GetRoundingAccount(): Code[20]
    var
        CustomerPostingGroup: Record 92;
        Customer: Record 18;
    begin
        Customer.RESET;
        IF Customer.GET(SalesInvoiceHeader."Sell-to Customer No.") THEN;
        CustomerPostingGroup.RESET;
        IF CustomerPostingGroup.GET(Customer."Customer Posting Group") THEN
            EXIT(CustomerPostingGroup."Invoice Rounding Account");
    end;
    // PRU SH 250822
}

