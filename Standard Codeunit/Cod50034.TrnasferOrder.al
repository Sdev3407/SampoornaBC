
codeunit 50034 TrnasferOrder
{
    Permissions = tabledata "Transfer Shipment Header" = rm;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Undo Transfer Shipment", 'OnAfterInsertNewShipmentLine', '', true, true)]

    local procedure UndoTRanferShipment(var TransShptLine: Record "Transfer Shipment Line"; PostedWhseShipmentLine: Record "Posted Whse. Shipment Line"; var PostedWhseShptLineFound: Boolean; DocLineNo: Integer)
    var
        TRanferShipmentline: Record "Transfer Shipment Line";
    Begin
        TRanferShipmentline.Get(TransShptLine."Document No.", DocLineNo);
        TRanferShipmentline.Amount := -TransShptLine.Amount;
        TRanferShipmentline.Modify();


    End;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post (Yes/No)", 'OnCodeOnBeforePostTransferOrder', '', true, true)]
    local procedure "TransferOrder-Post (Yes/No)_OnCodeOnBeforePostTransferOrder"
    (
        var TransHeader: Record "Transfer Header";
        var DefaultNumber: Integer;
        var Selection: Option;
        var IsHandled: Boolean
    )
    var
        TransferLine_T1: Record "Transfer Line";
        TransferLine_123: Record "Transfer Line";
        DimensionSetEntry_123: Record "Dimension Set Entry";
        SLRec: Record "Transfer Line";
        SLRec1: Record "Transfer Line";
        LocaFrom: Record Location;
        LocTo: Record Location;
        GENLe: Record "General Ledger Setup";
        CompanyInfo: Record "Company Information";
        TaxTransValue1: Record "Tax Transaction Value";
        GSTSetup1: Record "GST Setup";
        TaxComponentName1: Text;
        StarTransferLine: Record "Transfer Line";
        RecItem: Record Item;
    begin
        GENLe.Get();
        CompanyInfo.Get;
        if GENLe."St Dt" <= TransHeader."Posting Date" then begin
            SLRec.Reset();
            SLRec.SetRange("Document No.", TransHeader."No.");
            SLRec.SetFilter(SLRec."Item No.", '<>%1', '');
            SLRec.SetFilter(SLRec."Transfer-from Code", '<>%1', 'IN-TRANSIT');
            if SLRec.FindFirst() then
                repeat
                    SLRec1.Reset();
                    SLRec1.SetRange("Document No.", SLRec."Document No.");
                    //SLRec1.SetFilter("Line No.", '<>%1', SLRec."Line No.");
                    SLRec1.SetFilter("Item No.", '<>%1', '');
                    SLRec1.SetFilter(SLRec1."Transfer-from Code", '<>%1', 'IN-TRANSIT');
                    if SLRec1.FindFirst() then
                        repeat
                            Clear(LocaFrom);
                            Clear(LocTo);
                            LocaFrom.get(SLRec1."Transfer-from Code");
                            LocTo.get(SLRec1."Transfer-to Code");
                            if LocaFrom."State Code" <> LocTo."State Code" then begin
                                if SLRec.Exempted <> SLRec1.Exempted then
                                    Error('Exempted are not same all line', SLRec1."Line No.");
                            END;
                            SLRec.Testfield(SLRec."GST Group Code");
                            SLRec.TestField(SLRec."HSN/SAC Code");
                        until SLRec1.Next() = 0;

                    SLRec.Testfield(SLRec."GST Group Code");
                    SLRec.TestField(SLRec."HSN/SAC Code");
                    Clear(LocaFrom);
                    Clear(LocTo);
                    LocaFrom.get(SLRec."Transfer-from Code");
                    LocTo.get(SLRec."Transfer-to Code");
                    if LocaFrom."State Code" <> LocTo."State Code" Then begin
                        GSTSetup1.Get;
                        TaxTransValue1.Reset();
                        TaxTransValue1.SetRange("Tax Type", GSTSetup1."GST Tax Type");
                        TaxTransValue1.SetRange("Tax Record ID", SLRec.RecordId());
                        TaxTransValue1.SetRange("Value Type", TaxTransValue1."Value Type"::COMPONENT);
                        //TaxTransValue1.SetFilter(Percent, '<>%1', 0);
                        if TaxTransValue1.IsEmpty then
                            Error('GST Must be Calculated');
                    end;
                until SLRec.Next() = 0;
        END;
        If CompanyInfo.SFPLCompany in [CompanyInfo.SFPLCompany::"Star Foods"] then begin
            StarTransferLine.Reset();
            StarTransferLine.SetFilter("Item No.", '<>%1', '');
            StarTransferLine.SetRange("Document No.", TransHeader."No.");
            if StarTransferLine.FindSet() then
                repeat
                    RecItem.Get(StarTransferLine."Item No.");
                    If RecItem."Item Type" = RecItem."Item Type"::Bird then begin
                        StarTransferLine.TestField("Alternate Quantity");
                        StarTransferLine.TestField("Alternate UOM");
                    end;
                Until StarTransferLine.Next() = 0;
        end;

        TransferLine_123.RESET;
        TransferLine_123.SETRANGE("Document No.", TransHeader."No.");
        IF TransferLine_123.FINDFIRST THEN
            REPEAT
                IF TransferLine_123."Shortcut Dimension 1 Code" <> TransHeader."Shortcut Dimension 1 Code" THEN
                    ERROR('Transfer lines %1 LOB Code is not match of Transfer header LOB Code', TransferLine_123."Line No.");
                IF TransferLine_123."Shortcut Dimension 2 Code" <> TransHeader."Shortcut Dimension 2 Code" THEN
                    ERROR('Transfer lines %1 Branch is not match of Transfer header Branch', TransferLine_123."Line No.");
                If CompanyInfo.SFPLCompany = CompanyInfo.SFPLCompany::Sampoorna then
                    IF TransferLine_123."Shortcut Dimension 3 Code" <> TransHeader."Shortcut Dimension 3 Code" THEN
                        ERROR('Transfer lines %1 LOC Code is not match of Transfer header LOC Code', TransferLine_123."Line No.");
                IF TransferLine_123."Dimension Set ID" <> TransHeader."Dimension Set ID" THEN
                    ERROR('Transfer lines %1 dimension set id is not match of Transfer header dimension set id', TransferLine_123."Line No.");
                DimensionSetEntry_123.RESET;
                DimensionSetEntry_123.SETRANGE("Dimension Set ID", TransHeader."Dimension Set ID");
                IF DimensionSetEntry_123.FINDSET THEN
                    REPEAT
                        IF DimensionSetEntry_123."Dimension Code" = 'BRANCH' THEN BEGIN
                            IF DimensionSetEntry_123."Dimension Value Code" <> TransHeader."Shortcut Dimension 2 Code" THEN
                                ERROR('Transfer lines %1 Branch is not match of Transfer header Branch', TransferLine_123."Line No.");
                        END;
                        IF DimensionSetEntry_123."Dimension Code" = 'LOB' THEN BEGIN
                            IF DimensionSetEntry_123."Dimension Value Code" <> TransHeader."Shortcut Dimension 1 Code" THEN
                                ERROR('Transfer lines %1 LOB Code is not match of Transfer header LOB Code', TransferLine_123."Line No.");
                        END;
                        If CompanyInfo.SFPLCompany = CompanyInfo.SFPLCompany::Sampoorna then
                            IF DimensionSetEntry_123."Dimension Code" = 'LOC' THEN BEGIN
                                IF DimensionSetEntry_123."Dimension Value Code" <> TransHeader."Shortcut Dimension 3 Code" THEN
                                    ERROR('Transfer lines %1 LOC Code is not match of Transfer header LOC Code', TransferLine_123."Line No.");
                            END;
                    UNTIL DimensionSetEntry_123.NEXT = 0;
            UNTIL TransferLine_123.NEXT = 0;
        ///Pru_gk DMV_.01



    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnBeforeCheckIsCyclicalLoop', '', true, true)]
    local procedure "Item Jnl.-Post Line_OnBeforeCheckIsCyclicalLoop"
    (
        ItemLedgEntry: Record "Item Ledger Entry";
        OldItemLedgEntry: Record "Item Ledger Entry";
        var PrevAppliedItemLedgEntry: Record "Item Ledger Entry";
        var AppliedQty: Decimal;
        var IsHandled: Boolean
    )
    begin
        IsHandled := true;
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Shipment", 'OnBeforePostItemJournalLine', '', true, true)]
    local procedure "TransferOrder-Post Shipment_OnBeforePostItemJournalLine"
    (
        var ItemJournalLine: Record "Item Journal Line";
        TransferLine: Record "Transfer Line";
        TransferShipmentHeader: Record "Transfer Shipment Header";
        TransferShipmentLine: Record "Transfer Shipment Line";
        CommitIsSuppressed: Boolean
    )
    var
        TRansferHeader: Record "Transfer Header";
    begin
        ItemJournalLine."Chicks Item" := TransferLine."Chicks Item"; //RK-PRU
        ItemJournalLine."Alternate Quantity" := TransferLine."Alternate Quantity";//PRU-VG
        ItemJournalLine."Alternate UOM" := TransferLine."Alternate UOM";//PRU-VG
        ItemJournalLine."Shortcut Dimension 1 Code" := TransferShipmentLine."Shortcut Dimension 1 Code";
        ItemJournalLine."New Shortcut Dimension 1 Code" := TransferShipmentLine."Shortcut Dimension 1 Code";
        ItemJournalLine."Shortcut Dimension 2 Code" := TransferShipmentLine."Shortcut Dimension 2 Code";
        ItemJournalLine."New Shortcut Dimension 2 Code" := TransferShipmentLine."Shortcut Dimension 2 Code";
        ItemJournalLine."Shortcut Dimension 3 Code" := TransferShipmentHeader."Shortcut Dimension 3 Code"; //Pru_gk
        ItemJournalLine."New Shortcut Dimension 3 Code" := TransferShipmentHeader."Shortcut Dimension 3 Code"; //Pru_gk
        ItemJournalLine."Item Type" := TransferLine."Item Type";//PRU-VG
        ItemJournalLine."Debit Note Type" := TransferShipmentHeader."Debit Note Type";///Pru_gk
        ItemJournalLine.SFPLUserID := TransferShipmentHeader."SFPL User ID";

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Receipt", 'OnBeforePostItemJournalLine', '', true, true)]
    local procedure "TransferOrder-Post Receipt_OnBeforePostItemJournalLine"
    (
        var ItemJournalLine: Record "Item Journal Line";
        TransferLine: Record "Transfer Line";
        TransferReceiptHeader: Record "Transfer Receipt Header";
        TransferReceiptLine: Record "Transfer Receipt Line";
        CommitIsSuppressed: Boolean;
        TransLine: Record "Transfer Line";
        PostedWhseRcptHeader: Record "Posted Whse. Receipt Header"
    )
    begin
        ItemJournalLine."Chicks Item" := TransferLine."Chicks Item"; //RK-PRU
        ItemJournalLine."Alternate Quantity" := TransferLine."Alternate Quantity";//PRU-VG
        ItemJournalLine."Alternate UOM" := TransferLine."Alternate UOM";//PRU-VG
        ItemJournalLine."Flock No." := TransferLine."Flock No.";//PRU-VG
        ItemJournalLine."Item Type" := TransferLine."Item Type";//PRU-VG
        ItemJournalLine."Debit Note Type" := TransferReceiptHeader."Debit Note Type";//PRU-VG
        ItemJournalLine.SFPLUserID := TransferReceiptHeader."SFPL User ID";
    end;






    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Shipment", 'OnBeforeInsertTransShptHeader', '', true, true)]
    local procedure "TransferOrder-Post Shipment_OnBeforeInsertTransShptHeader"
    (
        var TransShptHeader: Record "Transfer Shipment Header";
        TransHeader: Record "Transfer Header";
        CommitIsSuppressed: Boolean
    )
    var
        FromLoc: Record Location;
        ToLOC: Record Location;
    begin
        FromLoc.Get(TransHeader."Transfer-from Code");
        ToLOC.Get(TransHeader."Transfer-To Code");
        TransShptHeader."New Shortcut Dimension 1 Code" := TransHeader."New LOB";
        TransShptHeader."New Shortcut Dimension 2 Code" := TransHeader."New Branch";
        TransShptHeader."Shortcut Dimension 3 Code" := TransHeader."Shortcut Dimension 3 Code";
        TransShptHeader."From State Code" := FromLoc."State Code";
        TransShptHeader."To State Code" := ToLOC."State Code";
        TransShptHeader."Transporter Code" := TransHeader."Transporter Code";
        TransShptHeader."Transporter Name" := TransHeader."Transporter Name";
        TransShptHeader."Freight Value" := TransHeader."Freight Value";
        TransShptHeader."SFPL User ID" := TransHeader."SFPL User ID";

    end;

    [EventSubscriber(ObjectType::Table, Database::"Transfer Shipment Line", 'OnAfterCopyFromTransferLine', '', true, true)]
    local procedure "Transfer Shipment Line_OnAfterCopyFromTransferLine"
    (
        var TransferShipmentLine: Record "Transfer Shipment Line";
        TransferLine: Record "Transfer Line"
    )
    begin
        TransferShipmentLine."Item Type" := TransferLine."Item Type";
        TransferShipmentLine."GST Exempt" := TransferLine."GST Exempt";
        TransferShipmentLine."Flock No." := TransferLine."Flock No.";
        TransferShipmentLine."Alternate Quantity" := TransferLine."Alternate Quantity";
    end;



    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Shipment", 'OnRunOnBeforeCommit', '', true, true)]
    local procedure "TransferOrder-Post Shipment_OnRunOnBeforeCommit"
        (
            var TransferHeader: Record "Transfer Header";
            var TransferShipmentHeader: Record "Transfer Shipment Header";
            PostedWhseShptHeader: Record "Posted Whse. Shipment Header";
            var SuppressCommit: Boolean
        )
    var
        GSTLedEntry: Record "GST Ledger Entry";
        ItemRec: Record Item;
        DetailGstENtry: Record "Detailed GST Ledger Entry";
        TransShipLine:
                Record "Transfer Shipment Line";
    begin
        TransferHeader.Shipped := true;

    end;




    [EventSubscriber(ObjectType::Table, Database::"Transfer Receipt Line", 'OnAfterCopyFromTransferLine', '', true, true)]
    local procedure "Transfer Receipt Line_OnAfterCopyFromTransferLine"
    (
        var TransferReceiptLine: Record "Transfer Receipt Line";
        TransferLine: Record "Transfer Line"
    )
    begin
        TransferReceiptLine."Item Type" := TransferLine."Item Type";
        TransferReceiptLine."GST Exempt" := TransferLine."GST Exempt";
        TransferReceiptLine."Flock No." := TransferLine."Flock No.";
        TransferReceiptLine."Alternate Quantity" := TransferLine."Alternate Quantity";

    end;




    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Shipment", 'OnAfterTransferOrderPostShipment', '', true, true)]
    local procedure "TransferOrder-Post Shipment_OnAfterTransferOrderPostShipment"
    (
        var TransferHeader: Record "Transfer Header";
        CommitIsSuppressed: Boolean;
        var TransferShipmentHeader: Record "Transfer Shipment Header";
        InvtPickPutaway: Boolean
    )
    var
        TLRec: Record "Transfer Line";
        THRec: Record "Transfer Header";
        TrShLi: Record "Transfer Shipment Line";
        TransferShipmentHeaderEinvoice: Record "Transfer Shipment Header";
        SMSSendTransferOrder: Codeunit 50009;
        cuSalesPost: Codeunit 50025;
        CompanyInfo: record "Company Information";
        Loc: Record Location;
        Cu50061: Codeunit EwayBill;
        ValidUpto: DateTime;
        TranshptLine: Record "Transfer Shipment Line";
        FromLoc: Record Location;
        Tolocation: Record Location;

    begin
        CompanyInfo.Get;
        Loc.Get(TransferHeader."Transfer-to Code");
        TransferHeader.SetHideValidationDialog(true);
        TransferHeader.Validate("Shortcut Dimension 1 Code", Loc."Global Dimension 1 Code");
        TransferHeader.Validate("Shortcut Dimension 2 Code", Loc."Global Dimension 2 Code");
        If CompanyInfo.SFPLCompany = CompanyInfo.SFPLCompany::Sampoorna then begin
            TransferHeader.Validate("Shortcut Dimension 3 Code", TransferHeader."Transfer-to Code");
            if CompanyInfo."Custom System Indicator Text" = 'LIVE' Then
                SMSSendTransferOrder.SMSSendTransferOrder(TransferShipmentHeader."No.");
        end; ////Pru_gk SMS
             //  << E-invoice 
        if CompanyInfo.SFPLCompany in [CompanyInfo.SFPLCompany::Sampoorna] then
            IF TransferShipmentHeader."No." <> '' THEN BEGIN
                TranshptLine.Reset();
                TranshptLine.SetRange("Document No.", TransferShipmentHeader."No.");
                TranshptLine.SetRange(Exempted, false);
                if TranshptLine.FindFirst() then
                    if CompanyInfo."Custom System Indicator Text" = 'LIVE' Then
                        Cu50061.GenerateEwayBill(TransferShipmentHeader, TransferShipmentHeader."E-Way Bill No.", TransferShipmentHeader."E-Way Generated Date", ValidUpto);
                TransferShipmentHeaderEinvoice.RESET;
                TransferShipmentHeaderEinvoice.SETRANGE(TransferShipmentHeaderEinvoice."No.", TransferShipmentHeader."No.");
                IF TransferShipmentHeaderEinvoice.FINDFIRST THEN BEGIN
                    IF cuSalesPost.CheckGST(TransferShipmentHeader."No.") THEN BEGIN
                        CLEAR(cuSalesPost);
                        if CompanyInfo."Custom System Indicator Text" = 'LIVE' Then
                            cuSalesPost.GenerateTransferEInvoice(TransferShipmentHeaderEinvoice);
                    END else
                        TransferShipmentHeader.Modify();
                END;
            END;

    end;

    [EventSubscriber(ObjectType::Table, Database::"Transfer Line", 'OnAfterIsShippedDimChanged', '', true, true)]
    local procedure "Transfer Line_OnAfterIsShippedDimChanged"
    (
        var TransferLine: Record "Transfer Line";
        var Result: Boolean
    )
    begin
        Result := false;
    end;





    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Shipment", 'OnBeforeOnRun', '', true, true)]
    local procedure "TransferOrder-Post Shipment_OnBeforeOnRun"
    (
        var TransferHeader: Record "Transfer Header";
        var HideValidationDialog: Boolean;
        var SuppressCommit: Boolean;
        var IsHandled: Boolean
        
    )
    var
        TransferLinesRec: Record "Transfer Line";
        TransheaderRec: Record "Transfer Header";
        TransferLine_T1: Record "Transfer Line";
        FromLocation: Record Location;
        Tolocation: Record Location;
        UserSetup: Record "User Setup";
        CompanyInfo: Record "Company Information";
        Item: record Item;
  
    begin
        CompanyInfo.Get;
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Transfer Order", '<>%1', UserSetup."Access Transfer Order"::Recieve);
        IF not UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to Ship transfer order');
        if FromLocation.Get(TransferHeader."Transfer-from Code") then;
        TransheaderRec.RESET;
        TransheaderRec.SETRANGE("No.", TransferHeader."No.");
        TransheaderRec.SETRANGE("Shortcut Dimension 1 Code", 'CBF');
        IF TransheaderRec.FINDFIRST THEN BEGIN
            IF (FromLocation."Location Type" = FromLocation."Location Type"::Farm) THEN BEGIN
                TransferLine_T1.RESET;
                TransferLine_T1.SETRANGE("Document No.", TransheaderRec."No.");
                TransferLine_T1.SETFILTER(Quantity, '<>%1', 0);
                TransferLine_T1.SETFILTER("In-Transit Code", '<>%1', '');
                IF TransferLine_T1.FINDFIRST THEN
                    REPEAT
                        TransferLine_T1.TESTFIELD("Flock No.");
                    UNTIL TransferLine_T1.NEXT = 0;
            END;
        END;
        // PRU_AS0.003 - 02 Aug 2019 -start
        TransferLinesRec.RESET;
        TransferLinesRec.SETRANGE("Document No.", TransferHeader."No.");
        TransferLinesRec.SETFILTER(Quantity, '<>%1', 0);
        IF TransferLinesRec.FINDSET THEN
            REPEAT
                IF TransferLinesRec."Shortcut Dimension 1 Code" <> TransferHeader."Shortcut Dimension 1 Code" THEN
                    ERROR('The Lob Code %1 does not matches Lob Code %2 on Transfer Order Lines', TransferHeader."Shortcut Dimension 1 Code", TransferLinesRec."Shortcut Dimension 1 Code");

                IF TransferLinesRec."Shortcut Dimension 2 Code" <> TransferHeader."Shortcut Dimension 2 Code" THEN
                    ERROR('The Branch Code %1 does not matches Branch Code %2 on Transfer Order Lines', TransferHeader."Shortcut Dimension 2 Code", TransferLinesRec."Shortcut Dimension 2 Code");
                // Suman 080225//
                Tolocation.Get(TransferLinesRec."Transfer-to Code");
                Item.get(TransferLinesRec."Item No.");
                If CompanyInfo.SFPLCompany in [CompanyInfo.SFPLCompany::Sampoorna] Then
                    if FromLocation."State Code" <> Tolocation."State Code" then
                        if TransferLinesRec.Exempted = false then
                            if Item."Item Tracking Code" = '' Then
                                TransferLinesRec.TestField("Appl.-to Item Entry");

                // Suman 080225//
                if StrLen(TransferLinesRec."HSN/SAC Code") < 8 then
                    Error('Please update the Valid HSN Code with 8 Digit')

            UNTIL TransferLinesRec.NEXT = 0;
        // PRU_AS0.003 - 02 Aug 2019 - END
    end;





    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Check Line", 'OnCheckDimensionsOnAfterAssignDimTableIDs', '', true, true)]
    local procedure "Gen. Jnl.-Check Line_OnCheckDimensionsOnAfterAssignDimTableIDs"
    (
        var GenJournalLine: Record "Gen. Journal Line";
        var TableID: array[10] of Integer;
        var No: array[10] of Code[20];
        var CheckDone: Boolean
    )
    begin
        CheckDone := true;
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Receipt", 'OnBeforeTransferOrderPostReceipt', '', true, true)]
    local procedure "TransferOrder-Post Receipt_OnBeforeTransferOrderPostReceipt"
    (
        var TransferHeader: Record "Transfer Header";
        var CommitIsSuppressed: Boolean;
        var ItemJnlPostLine: Codeunit "Item Jnl.-Post Line"
    )
    var
        UserSetup: Record "User Setup";
        TransferLinesRec: Record "Transfer Line";
        ToLocation: Record Location;
        TransheaderRec: Record "Transfer Header";
        TransferLine_T1: Record "Transfer Line";
    begin
        Companyinfo.Get;
        UserSetup.Get(UserId);

        if Companyinfo.SFPLCompany in [Companyinfo.SFPLCompany::"Star Foods"] then
            if UserSetup."User ID" = 'STF21030' then
                if TransferHeader."Transfer-to Code" = 'DIS001' then
                    Error('You can not Receive TRanfer Order in Dispatch Location');


        // PRU_AS0.003 - 05 JULY 2019 START
        IF TransferHeader."Transfer-to Code" <> '' THEN
            ToLocation.GET(TransferHeader."Transfer-to Code");

        TransheaderRec.RESET;
        TransheaderRec.SETRANGE("No.", TransferHeader."No.");
        TransheaderRec.SETRANGE("Shortcut Dimension 1 Code", 'CBF');
        IF TransheaderRec.FINDFIRST THEN BEGIN
            IF (ToLocation."Location Type" = ToLocation."Location Type"::Farm) THEN BEGIN
                TransferLine_T1.RESET;
                TransferLine_T1.SETRANGE("Document No.", TransferHeader."No.");
                TransferLine_T1.SETFILTER(Quantity, '<>%1', 0);
                TransferLine_T1.SETFILTER("In-Transit Code", '<>%1', '');
                IF TransferLine_T1.FINDFIRST THEN
                    REPEAT
                        TransferLine_T1.TESTFIELD("Flock No.");
                    UNTIL TransferLine_T1.NEXT = 0;
            END;
        END;
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Transfer Order", '<>%1', UserSetup."Access Transfer Order"::Ship);
        IF Not UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to Recieve transfer order');

        // PRU_AS0.003 - 05 JULY 2019 END
        // PRU_AS0.003 - 02 Aug 2019 -start
        TransferLinesRec.RESET;
        TransferLinesRec.SETRANGE("Document No.", TransferHeader."No.");
        TransferLinesRec.SETFILTER(Quantity, '<>%1', 0);
        IF TransferLinesRec.FINDSET THEN
            REPEAT
                IF TransferLinesRec."Shortcut Dimension 1 Code" <> TransferHeader."Shortcut Dimension 1 Code" THEN
                    ERROR('The Lob Code %1 does not matches Lob Code %2 on Transfer Order Lines', TransferHeader."Shortcut Dimension 1 Code", TransferLinesRec."Shortcut Dimension 1 Code");

                IF TransferLinesRec."Shortcut Dimension 2 Code" <> TransferHeader."Shortcut Dimension 2 Code" THEN
                    ERROR('The Branch Code %1 does not matches Branch Code %2 on Transfer Order Lines', TransferHeader."Shortcut Dimension 2 Code", TransferLinesRec."Shortcut Dimension 2 Code");
            UNTIL TransferLinesRec.NEXT = 0;
    end;



    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Receipt", 'OnBeforeDeleteOneTransferHeader', '', true, true)]
    local procedure "TransferOrder-Post Receipt_OnBeforeDeleteOneTransferHeader"
    (
        TransferHeader: Record "Transfer Header";
        var DeleteOne: Boolean;
        TransferReceiptHeader: Record "Transfer Receipt Header"
    )
    var
        TRRec: Record "Transfer Receipt Header";
        TRLRec: Record "Transfer Receipt Line";
        SMSSendTransferOrder: Codeunit 50009;
        FromLoc: Record Location;
        ToLOC: Record Location;
    begin
        FromLoc.Get(TransferHeader."Transfer-from Code");
        ToLOC.Get(TransferHeader."Transfer-To Code");
        CreateAndPostGLEntry(TransferReceiptHeader."No.", TransferHeader."No.");
        TransferHeader.SetHideValidationDialog(true);
        if TRRec.Get(TransferReceiptHeader."No.") then begin
            TRRec."Shortcut Dimension 3 Code" := TransferHeader."Shortcut Dimension 3 Code";
            TRRec."New Shortcut Dimension 1 Code" := TransferHeader."New LOB";
            TRRec."New Shortcut Dimension 2 Code" := TransferHeader."New Branch";
            TRRec."From State Code" := FromLoc."State Code";
            TRRec."To State Code" := ToLOC."State Code";
            TRRec."Freight Value" := TransferHeader."Freight Value";
            TRRec.Modify();
            TRLRec.Reset();
            TRLRec.SetRange("Document No.", TransferReceiptHeader."No.");
            if TRLRec.FindFirst() then
                repeat
                    TRLRec."Shortcut Dimension 3 Code" := TRRec."Shortcut Dimension 3 Code";
                    TRLRec.Modify();
                until TRLRec.Next() = 0;
        END;

    end;



    procedure CreateAndPostGLEntry("DocumentNo.": Code[20]; "DocumentNo1": Code[20])
    var
        GenJnlBatch: Record "Gen. Journal Batch";
        GenJournalLine: Record "Gen. Journal Line";
        LN: Integer;
        TransferReceiptLine: Record "Transfer Receipt Line";
        TransferReceiptHeader: Record "Transfer Receipt Header";
        Item: Record Item;
        GeneralPostingSetup: Record "General Posting Setup";
        GenJnlLine: Record 81;
        GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
        Text13700: Label 'Transfer1 - %1';
        TaxTransValue1: Record "Tax Transaction Value";
        TotalTax1: Decimal;
        SGST_Amt1: Decimal;
        SGST_perc1: Decimal;
        SGST_Amt2: Decimal;
        IGST_Amt2: Decimal;
        TaxComponentName1: Text;
        CGST_Amt1: Decimal;
        CGST_perc1: Decimal;
        IGST_Amt1: Decimal;
        CGST_Amt2: Decimal;
        IGST_perc1: Decimal;
        GSTSetup1: Record "GST Setup";
        IgstAmount: Decimal;
        CgstAmount: Decimal;
        SgstAmount: Decimal;
        GSTamt1: Decimal;
        GenJnlLine1: Record 81;
        GSTPer: Decimal;
    begin

        GenJnlLine.RESET();
        GenJnlLine.SETRANGE("Account No.", '');
        IF GenJnlLine.FINDSET THEN
            GenJnlLine.DELETEALL;
        GenJnlBatch.RESET;
        GenJnlBatch.SETRANGE("Journal Template Name", 'GENERAL');
        GenJnlBatch.SETRANGE(Name, 'DEFAULT');
        IF GenJnlBatch.FINDFIRST THEN;


        IF TransferReceiptHeader.GET("DocumentNo.") THEN;
        //    IF TransferReceiptHeader.Structure <> '' THEN BEGIN
        TransferReceiptLine.RESET;
        TransferReceiptLine.SETRANGE("Document No.", TransferReceiptHeader."No.");
        TransferReceiptLine.SetFilter("Gen. Prod. Posting Group", '<>%1', 'CONSUMABLE');
        IF TransferReceiptLine.FINDFIRST THEN
            REPEAT

                //if (PLRec1."P & F Value" = true) OR (PLRec1."Freight Value" = true) OR (PLRec1."Cutting & Loading" = true) then begin
                Clear(IgstAmount);
                Clear(CgstAmount);
                Clear(SgstAmount);
                Clear(IGST_Amt2);
                Clear(CGST_Amt2);
                Clear(SGST_Amt2);
                Clear(GSTamt1);
                GSTSetup1.Get();//PT
                TaxTransValue1.SetRange("Tax Type", GSTSetup1."GST Tax Type");
                TaxTransValue1.SetRange("Tax Record ID", TransferReceiptLine.RecordId());
                TaxTransValue1.SetRange("Value Type", TaxTransValue1."Value Type"::COMPONENT);
                TaxTransValue1.SetFilter(Percent, '<>%1', 0);
                if TaxTransValue1.FindSet() then
                    repeat
                        TaxComponentName1 := TaxTransValue1.GetAttributeColumName();
                        case TaxComponentName1 of
                            'IGST':
                                begin
                                    //     IgstPer := TaxTransValue1.Percent;
                                    //evaluate(IGST_Amt2, TaxTransValue1.Amount);
                                    IGST_Amt2 := TaxTransValue1.Amount;
                                    IgstAmount += IGST_Amt2;
                                end;
                            'CGST':
                                begin
                                    //evaluate(CGST_Amt2, TaxTransValue1.Amount);
                                    //   CgstPer := TaxTransValue1.Percent;
                                    CGST_Amt2 := TaxTransValue1.Amount;
                                    CgstAmount += CGST_Amt2;
                                end;
                            'SGST':
                                begin
                                    //evaluate(SGST_Amt2, TaxTransValue1.Amount);
                                    // SgstPer := TaxTransValue1.Percent;
                                    SGST_Amt2 := TaxTransValue1.Amount;
                                    SgstAmount += SGST_Amt2;
                                end;
                        end;
                    until TaxTransValue1.Next() = 0;

                GSTamt1 := IgstAmount + CgstAmount + SgstAmount;
                GSTPer := GSTamt1;
                IF (GSTamt1 <> 0) AND (TransferReceiptLine."GST Credit" = TransferReceiptLine."GST Credit"::"Non-Availment") and (TransferReceiptLine."GST Add on Inventory" = TransferReceiptLine."GST Add on Inventory"::" ") THEN BEGIN
                    IF GeneralPostingSetup.GET('', TransferReceiptLine."Gen. Prod. Posting Group") THEN BEGIN
                        GeneralPostingSetup.TESTFIELD("Purch. Account");
                        GeneralPostingSetup.TESTFIELD("Inventory Adjmt. Account");
                        GenJnlLine1.reset;
                        GenJnlLine1.setrange(GenJnlLine1."Journal Template Name", 'GENERAL');
                        GenJnlLine1.setrange(GenJnlLine1."Journal Batch Name", 'DEFAULT');
                        if GenJnlLine1.findlast then;
                        GenJnlLine.INIT;
                        GenJnlLine.VALIDATE("Journal Template Name", GenJnlBatch."Journal Template Name");
                        GenJnlLine.VALIDATE("Journal Batch Name", GenJnlBatch.Name);
                        GenJnlLine.VALIDATE("Line No.", GenJnlLine1."Line No." + 10000);
                        GenJnlLine.VALIDATE("Source Code", 'TRANSFER');
                        GenJnlLine.VALIDATE("Document No.", TransferReceiptLine."Document No.");
                        GenJnlLine.VALIDATE("Account Type", GenJnlLine."Account Type"::"G/L Account");
                        GenJnlLine.VALIDATE("Account No.", GeneralPostingSetup."Purch. Account");
                        GenJnlLine.VALIDATE("Posting Date", TransferReceiptHeader."Posting Date");
                        GenJnlLine.VALIDATE("External Document No.", TransferReceiptHeader."External Document No.");
                        GenJnlLine.VALIDATE(Description, STRSUBSTNO(Text13700, TransferReceiptHeader."No."));
                        GenJnlLine.VALIDATE("Bal. Account Type", GenJnlLine."Bal. Account Type"::"G/L Account");
                        GenJnlLine.VALIDATE("Bal. Account No.", GeneralPostingSetup."Inventory Adjmt. Account");
                        GenJnlLine.VALIDATE("Shortcut Dimension 1 Code", TransferReceiptHeader."Shortcut Dimension 1 Code");
                        GenJnlLine.VALIDATE("Shortcut Dimension 2 Code", TransferReceiptHeader."Shortcut Dimension 2 Code");
                        GenJnlLine.VALIDATE("Shortcut Dimension 3 Code", TransferReceiptHeader."Shortcut Dimension 3 Code");
                        GenJnlLine.VALIDATE("Dimension Set ID", TransferReceiptHeader."Dimension Set ID");
                        GenJnlLine.VALIDATE(Amount, GSTamt1);
                        GenJnlLine."System-Created Entry" := TRUE;
                        GenJnlLine.INSERT;
                    END;
                    GenJnlPostLine.RUN(GenJnlLine);
                END;
            UNTIL TransferReceiptLine.NEXT = 0;
        //  END;

        GenJnlLine.RESET();
        GenJnlLine.SETRANGE("Document No.", TransferReceiptLine."Document No.");
        IF GenJnlLine.FINDSET THEN
            GenJnlLine.DELETEALL;
    END;

    var
        Companyinfo: Record "Company Information";

}
