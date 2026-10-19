namespace Sampoorna_BC.Sampoorna_BC;
using Microsoft.Purchases.Setup;
using Microsoft.Foundation.NoSeries;
using Microsoft.Utilities;
using Microsoft.Foundation.BatchProcessing;
using System.Automation;
using Microsoft.Finance.Dimension;
using Microsoft.Purchases.Document;

report 50134 CreatePurchaseOrders
{
    ApplicationArea = All;
    AccessByPermission = tabledata PostedImportBuffer = rimd;
    Caption = 'CreatePurchaseOrders';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    dataset
    {
        dataitem(POImportBuffer; "PO Import Buffer")
        {
            // DataItemTableView = where("Order Created" = filter(false));
            RequestFilterFields = "Vendor Name", "Location Code";
            trigger OnAfterGetRecord()
            begin
                if not POImportBuffer."Order Created" then
                    CreateOrders;
            end;

            trigger OnPostDataItem()
            begin
                MovePostedRecord();
            end;
        }
    }
    procedure CreateOrders()
    var
        PPsetup: Record "Purchases & Payables Setup";
        RecPH: Record "Purchase Header";
        PO_No: Code[50];
        NoSeriesMgt: Codeunit NoSeriesManagement;
        RecPL: Record "Purchase Line";
        RecPL1: Record "Purchase Line";
        LastLineNo: Integer;
        DimValue: Record "Dimension Value";
        PostPPImport: Record PostedImportBuffer;
        PostPPImport1: Record PostedImportBuffer;
        POImportBuffer2: Record "PO Import Buffer";

    begin
        if POImportBuffer."Vendor No." = '' then
            CurrReport.Skip();
        RecPH.Reset();
        RecPH.SetRange("Vendor Invoice No.", POImportBuffer."Vendor Invoice No.");
        RecPH.SetRange("Buy-from Vendor No.", POImportBuffer."Vendor No.");
        RecPH.SetRange("Document Type", RecPH."Document Type"::Order);
        // RecPH.SetRange(Status, RecPH.Status::Open);
        if not RecPH.FindFirst() then begin
            // Purchase Header ++

            PPsetup.GET;
            RecPH.INIT;
            CLEAR(PO_No);
            PO_No := NoSeriesMgt.GetNextNo(PPsetup."Order Nos.", WORKDATE, TRUE);
            RecPH."No." := PO_No;
            RecPH."Document Type" := RecPH."Document Type"::Order;
            RecPH.VALIDATE("Buy-from Vendor No.", POImportBuffer."Vendor No.");

            RecPH."Document Date" := WorkDate();
            RecPH."Posting Date" := WORKDATE;
            // RecPH."Order Date" := POImportBuffer."Order Date";
            RecPH.Validate("Document Date");
            RecPH.Validate("Posting Date");
            RecPH.Validate("Order Date", POImportBuffer."Order Date");
            RecPH.Validate("PO Expiration Date", (POImportBuffer."Order Date" + 11));
            RecPH.Validate("Brokerage Code", POImportBuffer."Brokerage Vendor No.");
            RecPH.Validate("Brokerage Rate", POImportBuffer."Brokerage Rate");
            RecPH.Validate("Mandi Name", POImportBuffer."Mandi Name");
            RecPH.Validate("Rate Basis", POImportBuffer."Rate Basis");
            RecPH.Validate("Terms Code", POImportBuffer."Terms Code");
            RecPH.Validate("Payment Method Code", POImportBuffer."Payment Method");
            RecPH.Validate("Vendor Invoice No.", POImportBuffer."Vendor Invoice No.");
            RecPH.Validate("Payment Terms Code", POImportBuffer."Payment Terms Code");
            RecPH.Validate("Creditors Type", POImportBuffer."Creditors Type");
            RecPH."No. Series" := PPsetup."Order Nos.";
            RecPH.Validate("Responsibility Center", POImportBuffer."Shortcut Dimension 1 Code");
            RecPH.INSERT(TRUE);
            // DimValue.Reset();
            // DimValue.SetRange("Global Dimension No.", 2);
            // DimValue.SetRange(Name, POImportBuffer."Loc Code");
            // if DimValue.FindFirst() then
            //     RecPH.Validate("Shortcut Dimension 2 Code", DimValue.Code);
            RecPH.VALIDATE("Location Code", POImportBuffer."Location Code");

            RecPH.Validate("Shortcut Dimension 1 Code", POImportBuffer."Shortcut Dimension 1 Code");
            RecPH.validate("Shortcut Dimension 2 Code", POImportBuffer."Shortcut Dimension 2 Code");
            RecPH.Validate("Shortcut Dimension 3 Code", POImportBuffer."Location Code");

            RecPH.MODIFY(TRUE);
        end;
        if RecPH.Status = RecPH.Status::Open then begin
            //Purchase Header--

            Clear(LastLineNo);
            //Purchase Line++
            RecPL.RESET;
            RecPL.SETRANGE("Document Type", RecPL."Document Type"::Order);
            RecPL.SETRANGE("Document No.", RecPH."No.");
            IF not RecPL.FindFirst() THEN
                RecPL.SetRange("No.");
            if RecPL.FindLast() then
                LastLineNo := RecPL."Line No." + 10000
            else
                LastLineNo := 10000;

            RecPL1.INIT;
            RecPL1.VALIDATE("Document Type", RecPL1."Document Type"::Order);
            RecPL1.VALIDATE("Document No.", RecPH."No.");
            RecPL1.VALIDATE("Buy-from Vendor No.", RecPH."Buy-from Vendor No.");
            RecPL1.VALIDATE("Line No.", LastLineNo);
            RecPL1.VALIDATE(Type, RecPL.Type::Item);
            RecPL1.VALIDATE("No.", POImportBuffer."No.");
            // RecPL1.Validate("Location Code", POImportBuffer."Location Code");
            RecPL1.VALIDATE(Quantity, POImportBuffer.Quantity);
            RecPL1.VALIDATE("Direct Unit Cost", POImportBuffer."Unit Price");
            RecPL1.INSERT(TRUE);

            POImportBuffer."Order Line No." := LastLineNo;
            POImportBuffer."Order No." := RecPH."No.";
            POImportBuffer."Order Created" := true;
            POImportBuffer.Modify(true);

            POImportBuffer2.Reset();
            POImportBuffer2.SetRange("Vendor Invoice No.", RecPH."Vendor Invoice No.");
            POImportBuffer2.SetRange("Order Created", false);
            if not POImportBuffer2.FindFirst() then begin
                if ApprovalsMgmt.CheckPurchaseApprovalPossible(RecPH) then
                    ApprovalsMgmt.OnSendPurchaseDocForApproval(RecPH)
                else
                    PerformManualRelease(RecPH);
            end;
        end else
            RecPH.TestField(Status, RecPH.Status::Open);
    END;

    procedure PerformManualRelease(var PurchaseHeader: Record "Purchase Header")
    var
        BatchProcessingMgt: Codeunit "Batch Processing Mgt.";
        NoOfSelected: Integer;
        NoOfSkipped: Integer;
    begin
        NoOfSelected := PurchaseHeader.Count();
        PurchaseHeader.SetFilter(Status, '<>%1', PurchaseHeader.Status::Released);
        NoOfSkipped := NoOfSelected - PurchaseHeader.Count;
        BatchProcessingMgt.BatchProcess(PurchaseHeader, Codeunit::"Purchase Manual Release", Enum::"Error Handling Options"::"Show Error", NoOfSelected, NoOfSkipped);
    end;

    procedure MovePostedRecord()
    var

        POImpBuffer: Record "PO Import Buffer";
        PostPPImport1: Record PostedImportBuffer;
        PostPPImport: Record PostedImportBuffer;
    begin
        POImpBuffer.Reset();
        POImpBuffer.SetRange("Batch Name", POImportBuffer."Batch Name");
        POImpBuffer.SetRange("Order Created", true);
        if POImpBuffer.FindSet() then begin
            repeat
                PostPPImport1.Reset();
                if PostPPImport1.FindLast() then;

                PostPPImport.Reset();
                PostPPImport.Init();
                PostPPImport."Line No." := PostPPImport1."Line No." + 1;
                PostPPImport."Batch Name" := POImpBuffer."Batch Name";
                PostPPImport.Insert(true);
                PostPPImport.TransferFields(POImpBuffer);
                if PostPPImport.Modify(true) then
                    POImpBuffer.Delete();
            until POImpBuffer.Next() = 0;
        end;
    end;

    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        PO: Page "Purchase Order";
        CU80: Codeunit 80;
}
