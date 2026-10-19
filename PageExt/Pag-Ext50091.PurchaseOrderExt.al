pageextension 50091 PurchaseOrderExt extends "Purchase Order"
{
    layout
    {
        addafter("GST Vendor Type")
        {
            field("SFPL User ID"; Rec."SFPL User ID")
            {
                ApplicationArea = All;
            }
            field(Amount; Rec.Amount)
            {
                ApplicationArea = All;
            }
            field("Completely Received"; "Completely Received")
            {
                ApplicationArea = All;
            }
            field("Amt. Rcd. Not Invoiced (LCY)"; "Amt. Rcd. Not Invoiced (LCY)")
            {
                ApplicationArea = All;
            }
        }
        addafter("Shortcut Dimension 2 Code")
        {
            field(ShortcutDimCode3; ShortcutDimCode[3])
            {
                ApplicationArea = Dimensions;
                CaptionClass = '1,2,3';
                TableRelation = "Dimension Value".Code where("Global Dimension No." = const(3),
                                                                  "Dimension Value Type" = const(Standard),
                                                                  Blocked = const(false));
                Visible = True;


                trigger OnValidate()
                begin
                    ValidateShortcutDimension(3);
                end;
            }
            field("Created From Web"; Rec."Created From Web")
            {
                ApplicationArea = All;
            }
        }
        addafter("No.")
        {
            field("PO Type"; Rec."PO Type")
            {
                ApplicationArea = All;
                Visible = VisibleSFPL;
                Editable = True;
                trigger OnValidate()
                var
                    myInt: Integer;
                begin
                    Enablecontrol();
                end;
            }
        }
        moveafter("Buy-from Vendor Name"; "Vendor GST Reg. No.")
        moveafter("Vendor GST Reg. No."; "Order Address Code")
        moveafter("Order Address Code"; "Buy-from City")
        moveafter("Buy-from City"; "No. of Archived Versions")
        moveafter("No. of Archived Versions"; "Posting Date")
        moveafter("Posting Date"; "Order Date")
        moveafter("Order Date"; "Document Date")
        moveafter("Document Date"; "Vendor Invoice No.")
        moveafter("Vendor Invoice No."; "Purchaser Code")

        addafter("Vendor GST Reg. No.")
        {
            field("P.A.N No."; rec."P.A.N No.")
            {
                ApplicationArea = All;
                Editable = false;

            }


            field("Service Type"; Rec."Service Type")
            {
                ApplicationArea = All;
                Editable = true;
                ShowMandatory = IsService;
                Visible = VisibleSFPL;
            }
        }



        modify("Order Date")
        {
            //Editable = OrdeDateEdit;
            trigger OnBeforeValidate()

            begin
                CompanyInfo.get;
                if CompanyInfo.SFPLCompany in [CompanyInfo.SFPLCompany::Sampoorna] Then Begin
                    IF Rec."Order Date" > TODAY() THEN
                        ERROR('You can not select the Future date');

                    IF Rec."Order Date" < (Today() - 2) THEN
                        if Rec."PO Type" = Rec."PO Type"::Goods Then
                            ERROR('You can not select the back date');
                End;
            end;

            trigger OnAfterValidate()
            begin
                Rec."PO Expiration Date" := Rec."Order Date" + 10;
            end;
        }

        modify("Shortcut Dimension 1 Code")
        {
            trigger OnAfterValidate()
            begin
                TestField("Shortcut Dimension 1 Code");
            end;
        }
        modify("Shortcut Dimension 2 Code")
        {
            trigger OnAfterValidate()
            begin
                TestField("Shortcut Dimension 2 Code");
            end;
        }
        modify("Document Date")
        {
            trigger OnBeforeValidate()
            begin
                CLEAR(PostingDate);
                PurchaseHeader.RESET;
                PurchaseHeader.SETRANGE("No.", Rec."No.");
                IF PurchaseHeader.FINDFIRST THEN
                    PostingDate := PurchaseHeader."Posting Date";
                IF Rec."Document Date" > PostingDate THEN
                    ERROR('Document date should not be Greater than posting date');
                CurrPage.UPDATE;
            end;
        }
        modify("Vendor Invoice No.")
        {
            trigger OnBeforeValidate()
            begin
                SpecialChr(Rec."Vendor Invoice No.");
            end;
        }
        modify("Buy-from Vendor No.")
        {

            trigger OnAfterValidate()
            var
                UserSetupRec: Record "User Setup";

            begin
                UpdateVendorGST(Rec."Buy-from Vendor No.");
                UserSetupRec.Get(UserId);
                if UserId <> 'JOBQUEUE' Then begin
                    Rec.VALIDATE("Shortcut Dimension 1 Code", UserSetupRec."Global Dimension 1 Code");
                    //    Clear(Rec."Shortcut Dimension 2 Code");
                    Rec.VALIDATE("Shortcut Dimension 2 Code", UserSetupRec."Global Dimension 2 Code");
                    IF NOT UserSetupRec."User Permission" THEN BEGIN
                        Rec.VALIDATE("Shortcut Dimension 1 Code", UserSetupRec."Global Dimension 1 Code");
                        Rec.VALIDATE("Shortcut Dimension 2 Code", UserSetupRec."Global Dimension 2 Code");
                        IF NOT UserSetupRec."HO Users" THEN BEGIN
                            Rec.VALIDATE("Shortcut Dimension 3 Code", UserSetupRec."Shortcut Dimension 3 Code");
                            //   Rec.VALIDATE("Location Code", UserSetupRec."Shortcut Dimension 3 Code");
                            // Message(UserSetupRec."Shortcut Dimension 3 Code");
                        END;
                    end;
                end;
            end;



        }
        modify("Location Code")
        {
            Visible = true;
            Editable = true;

            trigger OnBeforeValidate()
            var
                LocRec: Record Location;
            begin

            end;

            trigger OnAfterValidate()
            var
                UserSetupRec: Record "User Setup";
            begin
                CompanyInfo.Get;
                UserSetupRec.Get(USERID);
                if UserId <> 'JOBQUEUE' Then begin
                    Rec.VALIDATE("Shortcut Dimension 1 Code", UserSetupRec."Global Dimension 1 Code");
                    If Companyinfo.SFPLCompany <> Companyinfo.SFPLCompany::Vetadd Then
                        Rec.VALIDATE("Shortcut Dimension 2 Code", UserSetupRec."Global Dimension 2 Code");
                    Rec.SetHideValidationDialog(true);
                    IF UserSetupRec."User Permission" THEN BEGIN
                        Location.RESET;
                        Location.SETRANGE(Code, Rec."Location Code");
                        IF Location.FINDFIRST THEN
                            Rec.VALIDATE("Shortcut Dimension 2 Code", Location."Global Dimension 2 Code");
                    END;

                    Rec.VALIDATE("Shortcut Dimension 2 Code");
                    if CompanyInfo.SFPLCompany in [CompanyInfo.SFPLCompany::Sampoorna] then
                        Rec.VALIDATE("Shortcut Dimension 3 Code", Rec."Location Code");
                end;
            end;

            trigger OnLookup(var Text: Text): Boolean
            var
                Cust: Record Location;
                CustList: Page "Location List";
                UserSetupRec: Record "User Setup";
                Location: Record Location;
            begin
                CompanyInfo.Get;
                LookMode := true;
                if UserId <> 'JOBQUEUE' then begin
                    Cust.Reset();
                    Cust.SetRange("Use As In-Transit", false);
                    Cust.SetRange(Block, false);

                    if rec."Shortcut Dimension 2 Code" <> '' then
                        Cust.SetFilter(Cust."Global Dimension 2 Code", '%1', rec."Shortcut Dimension 2 Code");
                    CustList.SETTABLEVIEW(Cust);
                    CustList.LOOKUPMODE := TRUE;
                    IF CustList.RUNMODAL = ACTION::LookupOK THEN begin
                        CustList.GetRecord(Cust);
                        rec.Validate("Location Code", Cust.Code);

                        UserSetupRec.Get(USERID);
                        Rec.VALIDATE("Shortcut Dimension 1 Code", UserSetupRec."Global Dimension 1 Code");
                        If Companyinfo.SFPLCompany <> Companyinfo.SFPLCompany::Vetadd Then
                            Rec.VALIDATE("Shortcut Dimension 2 Code", UserSetupRec."Global Dimension 2 Code");
                        Rec.SetHideValidationDialog(true);
                        IF UserSetupRec."User Permission" THEN BEGIN
                            Location.RESET;
                            Location.SETRANGE(Code, Rec."Location Code");
                            IF Location.FINDFIRST THEN
                                Rec.VALIDATE("Shortcut Dimension 2 Code", Location."Global Dimension 2 Code");
                        END;

                        Rec.VALIDATE("Shortcut Dimension 2 Code");
                        if CompanyInfo.SFPLCompany in [CompanyInfo.SFPLCompany::Sampoorna] then
                            Rec.VALIDATE("Shortcut Dimension 3 Code", Rec."Location Code");
                    end;

                end;
            END;
        }
        modify("Buy-from Vendor Name")
        {
            trigger OnAfterValidate()
            begin
                UpdateVendorGST(Rec."Buy-from Vendor No.");
            end;


        }
        addafter("Purchaser Code")//"Buy-from Vendor Name")
        {
            field("Due Date calculation"; Rec."Due Date calculation")
            {
                ApplicationArea = All;

            }

            field("Brokerage Code"; Rec."Brokerage Code")
            {
                //Visible = VisibleSFPL;
                ApplicationArea = All;

            }
            field("Brokerage Calculation Basis"; Rec."Brokerage Calculation Basis")
            {
                ApplicationArea = all;
                Visible = VisibleSFPL;
            }
            field("Brokerage Rate"; Rec."Brokerage Rate")
            {
                ApplicationArea = All;
                Visible = VisibleSFPL;

            }
            field("Rate Basis"; Rec."Rate Basis")
            {
                ApplicationArea = All;

            }
            field(Freight; Rec.Freight)
            {
                ApplicationArea = All;
                Visible = VisibleStarFoods;
            }
            field("Insurance Type"; Rec."Insurance Type")
            {
                ApplicationArea = all;
                Visible = VisibleStarFoods;
            }
            field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
            {
                ApplicationArea = All;

                trigger OnValidate()
                begin
                    CompanyInfo.Get;
                    If CompanyInfo.SFPLCompany in [CompanyInfo.SFPLCompany::Sampoorna] then
                        Rec.TestField("Shortcut Dimension 3 Code");

                    //ValidateShortcutDimension(3);
                    ShortcutDimCode[3] := rec."Shortcut Dimension 3 Code";
                    Rec.ValidateShortcutDimCode(3, ShortcutDimCode[3]);
                end;

            }
            field("PO Expiration Date"; Rec."PO Expiration Date")
            {
                ApplicationArea = All;
                Editable = POExpiration;
                Visible = VisibleSFPL;
                trigger OnValidate()
                var
                    NewExpirationDate: Date;
                begin
                    // if Rec.Status = Enum::"Purchase Document Status"::Expired then
                    //     Error('The Document already exipred');

                    NewExpirationDate := xRec."PO Expiration Date" + 7;

                    if Rec."PO Expiration Date" > NewExpirationDate then
                        Error('You Can not extend the PO more then the %1', NewExpirationDate);
                end;
            }


        }
        moveafter("Rate Basis"; Status)
        addafter(Status)
        {
            field("Terms Code"; Rec."Terms Code")
            {
                ApplicationArea = All;

            }

        }
        moveafter("Terms Code"; "Bill of Entry Value")
        moveafter("Bill of Entry Value"; "Bill of Entry Date")
        moveafter("Bill of Entry Date"; "Bill of Entry No.")
        addafter("Bill of Entry No.")
        {
            field("Mandi Name"; Rec."Mandi Name")
            {
                ApplicationArea = All;
                Visible = VisibleSFPL;
            }
            field("File No."; Rec."File No.")
            {
                ApplicationArea = All;
            }
        }


        moveafter("File No."; "Due Date")
        moveafter("Due Date"; "Payment Method Code")
        moveafter("Payment Method Code"; "Payment Terms Code")
        moveafter("Payment Terms Code"; "Location Code")
        addafter("Location Code")
        {

            field("Creditors Type"; Rec."Creditors Type")
            {
                ApplicationArea = All;
                Visible = VisibleSFPL;

            }
            field("Line Narration1"; Rec."Line Narration1")
            {
                ApplicationArea = All;

            }
        }
        addfirst("Invoice Details")
        {
            field("Pay-to Vendor No."; rec."Pay-to Vendor No.")
            {
                ApplicationArea = all;
            }
        }
        moveafter("Pay-to Vendor No."; "Pay-to Contact No.")
        moveafter("Pay-to Contact No."; "Pay-to Name")
        moveafter("Pay-to Name"; "Pay-to Address")
        moveafter("Pay-to Address"; "Pay-to Address 2")
        moveafter("Pay-to Address 2"; "Pay-to Post Code")
        moveafter("Pay-to Post Code"; "Pay-to City")
        moveafter("Pay-to City"; "Pay-to Contact")
        moveafter("Pay-to Contact"; "Payment Reference")
        moveafter("Payment Reference"; "Creditor No.")
        moveafter("Creditor No."; "On Hold")
        moveafter("On Hold"; "Prices Including VAT")
        moveafter("Prices Including VAT"; "VAT Bus. Posting Group")
        //>>>shipping
        moveafter("Ship-to Address 2"; "Ship-to Post Code")
        moveafter("Ship-to Post Code"; "Ship-to Contact")
        moveafter("Ship-to Contact"; "Ship-to City")
        moveafter("Ship-to City"; "Inbound Whse. Handling Time")
        moveafter("Inbound Whse. Handling Time"; "Shipment Method Code")
        moveafter("Shipment Method Code"; "Lead Time Calculation")
        moveafter("Lead Time Calculation"; "Requested Receipt Date")
        moveafter("Requested Receipt Date"; "Promised Receipt Date")
        moveafter("Promised Receipt Date"; "Expected Receipt Date")
        moveafter("Expected Receipt Date"; "Sell-to Customer No.")
        moveafter("Sell-to Customer No."; "Ship-to Code")
        moveafter("Ship-to Code"; "Bill to-Location(POS)")
        //>>foreign trade
        moveafter("Transaction Type"; "Transaction Specification")
        //>>tax info
        moveafter("Location State Code"; "Location GST Reg. No.")
        moveafter("Location GST Reg. No."; "GST Vendor Type")
        moveafter("GST Vendor Type"; "Invoice Type")
        moveafter("Invoice Type"; "Associated Enterprises")
        moveafter("Associated Enterprises"; "Without Bill Of Entry")
        moveafter("Without Bill Of Entry"; "GST Order Address State")
        moveafter("GST Order Address State"; "Order Address GST Reg. No.")
        moveafter("Shipping Agent Code"; "Distance (Km)")
        moveafter("Payment Date"; "POS as Vendor State")
        moveafter("POS as Vendor State"; "POS Out Of India")

    }

    actions
    {
        // Add changes to page actions here

        addafter(Post)
        {
            action("ApplyEntries")
            {
                Image = ApplyEntries;
                Caption = 'Apply Entries';
                Promoted = true;
                PromotedCategory = Process;
                Ellipsis = True;
                PromotedIsBig = true;

                trigger OnAction()
                var
                Begin
                    Codeunit.Run(Codeunit::"Purchase Header Apply", Rec)
                End;
            }

            action("Import Serial No.")
            {
                Ellipsis = true;
                Image = Import;
                Promoted = true;
                ApplicationArea = all;
                PromotedIsBig = true;
                Visible = true;
                trigger OnAction()
                var
                    Report50110: Report "Import Purchae Order";
                begin

                    CLEAR(Report50110);
                    Report50110.GetDocNo(Rec."No.");
                    Report50110.RUN;
                end;
            }
        }


        modify(Approve)
        {
            trigger OnBeforeAction()
            begin

                // --------------- MSZ 14/04/2021   SKS-----------
                IF Rec."No." <> '' THEN BEGIN
                    // CheckApprovalEntry.RESET;
                    // CheckApprovalEntry.SETRANGE(CheckApprovalEntry."Document No.", Rec."No.");
                    // CheckApprovalEntry.SETRANGE(CheckApprovalEntry."Sequence No.", 1);
                    // CheckApprovalEntry.SETRANGE(CheckApprovalEntry.Status, CheckApprovalEntry.Status::Approved);
                    // IF CheckApprovalEntry.FINDFIRST THEN BEGIN
                    //     DeleteApprovalEntry.RESET;
                    //     DeleteApprovalEntry.SETRANGE(DeleteApprovalEntry."Document No.", Rec."No.");
                    //     DeleteApprovalEntry.SETRANGE(DeleteApprovalEntry."Sequence No.", 1);
                    //     DeleteApprovalEntry.SETRANGE(DeleteApprovalEntry.Status, DeleteApprovalEntry.Status::Open);
                    //     IF DeleteApprovalEntry.FINDSET THEN
                    //         DeleteApprovalEntry.DELETEALL;
                    //END;
                END;
                // +++++++++++++++MSZ 14/04/2021  SKS+++++++++++++++
            end;
        }
        modify(Reject)
        {
            trigger OnBeforeAction()
            begin

                IF Rec."No." <> '' THEN BEGIN
                    CheckApprovalEntry.RESET;
                    CheckApprovalEntry.SETRANGE(CheckApprovalEntry."Document No.", Rec."No.");
                    CheckApprovalEntry.SETRANGE(CheckApprovalEntry."Sequence No.", 1);
                    CheckApprovalEntry.SETRANGE(CheckApprovalEntry.Status, CheckApprovalEntry.Status::Rejected);
                    IF CheckApprovalEntry.FINDFIRST THEN BEGIN
                        DeleteApprovalEntry.RESET;
                        DeleteApprovalEntry.SETRANGE(DeleteApprovalEntry."Document No.", Rec."No.");
                        DeleteApprovalEntry.SETRANGE(DeleteApprovalEntry."Sequence No.", 1);
                        DeleteApprovalEntry.SETRANGE(DeleteApprovalEntry.Status, DeleteApprovalEntry.Status::Open);
                        IF DeleteApprovalEntry.FINDSET THEN
                            DeleteApprovalEntry.DELETEALL;
                    END;
                END;
                // +++++++++++++++MSZ 14/04/2021  SKS+++++++++++++++
            end;
        }
        modify(Release)
        {
            trigger OnBeforeAction()

            begin
                if Rec."PO Type" in [Rec."PO Type"::Goods] Then begin
                    Rec.TESTFIELD("Brokerage Code");//PRU-VG1.0
                    Rec.TESTFIELD("Rate Basis");//PRU-VG1.0
                end;

                Rec.TESTFIELD("Payment Terms Code");//PRU-VG1.0
                //Rec.TESTFIELD("Shortcut Dimension 3 Code");//PRU-VG
                // if rec.Status = Rec.Status::Expired then
                //     Error('You Can not Release the Document if it is Expired');
            end;
        }
        modify(Reopen)
        {
            trigger OnBeforeAction()
            begin
                // if rec.Status = Rec.Status::Expired then
                //     Error('You Can not Re-open the Document if it is Expired');


            end;
        }
        addafter(MoveNegativeLines)
        {
            action("Short Close")
            {
                Image = Close;

                Applicationarea = All;
                trigger OnAction()
                var
                    PurchaseLine: Record 39;
                    T39_Loc: Record 39;
                begin
                    //PRU-Vg 2.0
                    PurchaseLine.RESET;
                    PurchaseLine.SETRANGE("Document No.", Rec."No.");
                    PurchaseLine.CALCSUMS(PurchaseLine.Quantity, PurchaseLine."Quantity Received");
                    IF (PurchaseLine.Quantity <> PurchaseLine."Quantity Received") THEN BEGIN
                        Rec.Status := Rec.Status::"Short Close";
                        Rec.MODIFY;
                        T39_Loc.RESET;
                        T39_Loc.SETRANGE("Document No.", Rec."No.");
                        IF T39_Loc.FINDFIRST THEN
                            REPEAT
                                T39_Loc."Short Closed" := TRUE;
                                T39_Loc.MODIFY;
                            UNTIL T39_Loc.NEXT = 0;
                        MESSAGE(TextPartial);
                    END;
                    //PRU-Vg 2.0
                end;
            }

        }
        modify(SendApprovalRequest)
        {
            trigger OnBeforeAction()
            begin
                CompanyInfo.Get;
                Rec.TESTFIELD("Payment Terms Code");//PRU-VG1.0
                If CompanyInfo.SFPLCompany = CompanyInfo.SFPLCompany::Sampoorna Then begin
                    if Rec."PO Type" in [Rec."PO Type"::Goods] Then begin
                        Rec.TESTFIELD("Brokerage Code");//PRU-VG1.0
                        Rec.TESTFIELD("Rate Basis");//PRU-VG1.0
                    end;
                    Rec.TESTFIELD("Shortcut Dimension 3 Code");//PRU-VG
                end;
                // UserSetup.Reset();
                // UserSetup.SetRange("User ID", USERID);
                // UserSetup.SetFilter("Access Purchase Order", '<>%1', UserSetup."Access Purchase Order"::Edit);
                // if UserSetup.FindFirst() then
                //     Error('You Can not Send for approval, Please contact to Purchaser');

                // if rec.Block then
                //     Error('You can not send for approval old order')

            end;
        }
        addlast(Warehouse)
        {
            action("Get Indent Lines")
            {
                Image = GetLines;
                Promoted = true;
                PromotedCategory = Process;

                Applicationarea = All;
                trigger OnAction()
                var
                    IndentLines: Page "Indent Lines";
                    T120: Record 120;
                    T122: Record 122;
                begin
                    //PRU-AM 1.0
                    /*T120.RESET;
                    T120.SETRANGE("Order No.","No.");
                    IF T120.FINDFIRST THEN
                      ERROR(Text50000);
                    T122.RESET;
                    T122.SETRANGE("Order No.","No.");
                    IF T122.FINDFIRST THEN
                      ERROR(Text50001);*/
                    IndentLines.SetPurchHeader(Rec);
                    IndentLines.RUNMODAL;
                    //End

                end;
            }
        }
        modify(Post)
        {
            trigger OnBeforeAction()
            var
                SHLoc: Record 36;
            begin
                CompanyInfo.Get;
                UserSetup.RESET;
                UserSetup.SETRANGE("User ID", USERID);
                UserSetup.SETFILTER(UserSetup."Access Purchase Order", '%1', UserSetup."Access Purchase Order"::View);
                IF UserSetup.FINDFIRST THEN
                    ERROR('You are not allowed to post Purchase Order');
                //PRU_DD 1.10
                UserSetup.RESET;
                UserSetup.SETRANGE("User ID", USERID);
                UserSetup.SETFILTER(UserSetup."Access Purchase Order", '%1', UserSetup."Access Purchase Order"::Edit);
                IF UserSetup.FINDFIRST THEN
                    If Rec."PO Type" = Rec."PO Type"::Goods Then
                        ERROR('You are not allowed to post Purchase Order');
                //PRU_DD 1.10
                //PRU_DD 1.10



                //+RK-PRU
                CLEAR(PLQty);

                RPurchLine.RESET;
                RPurchLine.SETRANGE("Document No.", Rec."No.");
                RPurchLine.SETFILTER("Chicks Item", '%1', TRUE);
                IF RPurchLine.FINDFIRST THEN
                    REPEAT
                        PLQty += RPurchLine."Qty. to Receive";
                    UNTIL RPurchLine.NEXT = 0;

                IF RecLocation.GET(RPurchLine."Location Code") THEN
                    IF (RecLocation.Grade = RecLocation.Grade::C) OR (RecLocation.Grade = RecLocation.Grade::D) THEN
                        ERROR('Farm Grade is %1', RecLocation.Grade);

                CLEAR(TotalRemainingQty);
                CLEAR(TotalRemainingQty1);

                ILE.RESET;
                ILE.SETRANGE("Location Code", RPurchLine."Location Code");
                ILE.SETRANGE("Item No.", RPurchLine."No.");
                ILE.SETFILTER("Chicks Item", '%1', TRUE);
                ILE.SETFILTER("Remaining Quantity", '>%1', 0);
                IF ILE.FINDFIRST THEN
                    REPEAT
                        TotalRemainingQty += ILE."Remaining Quantity";
                    UNTIL ILE.NEXT = 0;

                TotalRemainingQty1 := RecLocation.Capicity - TotalRemainingQty;

                IF RecLocation.Capicity <> 0 THEN BEGIN
                    IF TotalRemainingQty1 < PLQty THEN
                        ERROR('Qty must not be greater than %1', TotalRemainingQty1);
                    //-RK-PRU
                END;
                If CompanyInfo.SFPLCompany = CompanyInfo.SFPLCompany::Sampoorna Then begin
                    if Rec."PO Type" in [Rec."PO Type"::Goods] Then begin
                        Rec.TESTFIELD("Brokerage Code");//PRU-VG1.0
                        Rec.TESTFIELD("Rate Basis");//PRU-VG1.0
                    end;
                    Rec.TESTFIELD("Payment Terms Code");//PRU-VG1.0
                End;                           //PRU-VG
                CLEAR(RecLocation);
                RecLocation.GET(Rec."Location Code");
                GeneralLedgerSetup.GET;
                IF RecLocation."Liquidation Date" <> 0D THEN BEGIN
                    SHLoc.RESET;
                    SHLoc.SETRANGE("Document Type", Rec."Document Type");
                    SHLoc.SETRANGE("No.", Rec."No.");
                    SHLoc.SETRANGE("Posting Date", RecLocation."Liquidation Date", CALCDATE(GeneralLedgerSetup."Liquidation Date Formula", RecLocation."Liquidation Date"));
                    IF SHLoc.FINDFIRST THEN
                        ERROR('Purchase Order cannot be posted before %1', CALCDATE(GeneralLedgerSetup."Liquidation Date Formula", RecLocation."Liquidation Date"));
                    //PRU-VG
                END;
                if Rec.Status = Rec.Status::"Short Close" then
                    Error('You can not post the Entry in Short Closed PO, Please contact with Purchaser')
            end;
        }
        modify(Preview)
        {
            trigger OnBeforeAction()
            begin
                CompanyInfo.Get;
                If CompanyInfo.SFPLCompany = CompanyInfo.SFPLCompany::Sampoorna Then begin
                    if Rec."PO Type" in [Rec."PO Type"::Goods] Then begin
                        Rec.TESTFIELD("Brokerage Code");//PRU-VG1.0
                        Rec.TESTFIELD("Rate Basis");//PRU-VG1.0
                    end;
                    Rec.TESTFIELD("Payment Terms Code");//PRU-VG1.0
                End;
            end;
        }
        modify("Post and &Print")
        {
            trigger OnBeforeAction()
            begin
                CompanyInfo.Get;
                UserSetup.RESET;
                UserSetup.SETRANGE("User ID", USERID);
                UserSetup.SETFILTER(UserSetup."Access Purchase Order", '%1', UserSetup."Access Purchase Order"::View);
                IF UserSetup.FINDFIRST THEN
                    ERROR('You are not allowed to post Purchase Order');
                //PRU_DD 1.10
                UserSetup.RESET;
                UserSetup.SETRANGE("User ID", USERID);
                UserSetup.SETFILTER(UserSetup."Access Purchase Order", '%1', UserSetup."Access Purchase Order"::Edit);
                IF UserSetup.FINDFIRST THEN
                    If Rec."PO Type" = Rec."PO Type"::Goods Then
                        ERROR('You are not allowed to post Purchase Order');
                //PRU_DD 1.10

                //+RK-PRU
                CLEAR(PLQty);

                RPurchLine.RESET;
                RPurchLine.SETRANGE("Document No.", Rec."No.");
                RPurchLine.SETFILTER("Chicks Item", '%1', TRUE);
                IF RPurchLine.FINDFIRST THEN
                    REPEAT
                        PLQty += RPurchLine."Qty. to Receive";
                    UNTIL RPurchLine.NEXT = 0;

                IF RecLocation.GET(RPurchLine."Location Code") THEN
                    IF (RecLocation.Grade = RecLocation.Grade::C) OR (RecLocation.Grade = RecLocation.Grade::D) THEN
                        ERROR('Farm Grade is %1', RecLocation.Grade);

                CLEAR(TotalRemainingQty);
                CLEAR(TotalRemainingQty1);

                ILE.RESET;
                ILE.SETRANGE("Location Code", RPurchLine."Location Code");
                ILE.SETRANGE("Item No.", RPurchLine."No.");
                ILE.SETFILTER("Chicks Item", '%1', TRUE);
                ILE.SETFILTER("Remaining Quantity", '>%1', 0);
                IF ILE.FINDFIRST THEN
                    REPEAT
                        TotalRemainingQty += ILE."Remaining Quantity";
                    UNTIL ILE.NEXT = 0;

                TotalRemainingQty1 := RecLocation.Capicity - TotalRemainingQty;

                IF RecLocation.Capicity <> 0 THEN BEGIN
                    IF TotalRemainingQty1 < PLQty THEN
                        ERROR('Qty must not be greater than %1', TotalRemainingQty1);
                    //-RK-PRU
                END;
                If CompanyInfo.SFPLCompany = CompanyInfo.SFPLCompany::Sampoorna Then begin
                    if Rec."PO Type" in [Rec."PO Type"::Goods] Then begin
                        Rec.TESTFIELD("Brokerage Code");//PRU-VG1.0
                        Rec.TESTFIELD("Rate Basis");//PRU-VG1.0
                    end;
                    Rec.TESTFIELD("Payment Terms Code");//PRU-VG1.0
                End;
            end;
        }
        modify("Post &Batch")
        {
            trigger OnBeforeAction()
            begin
                CompanyInfo.Get;
                If CompanyInfo.SFPLCompany = CompanyInfo.SFPLCompany::Sampoorna Then begin
                    if Rec."PO Type" in [Rec."PO Type"::Goods] Then begin
                        Rec.TESTFIELD("Brokerage Code");//PRU-VG1.0
                        Rec.TESTFIELD("Rate Basis");//PRU-VG1.0
                    end;
                    Rec.TESTFIELD("Payment Terms Code");//PRU-VG1.0
                End;
            end;
        }

    }
    trigger OnDeleteRecord(): Boolean
    begin
        //UserSetup.RESET;
        //UserSetup.SETRANGE("User ID", USERID);
        //UserSetup.SETFILTER(UserSetup."Access Purchase Order", '%1', UserSetup."Access Purchase Order"::View);
        //IF UserSetup.FINDFIRST THEN
        if UserId <> 'JOBQUEUE' then
            ERROR('You can not delete the puchase order');
        //PRU_DD 1.10
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var
        USERSETUP: Record "User Setup";
    begin
        CompanyInfo.Get;
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Purchase Order", '%1', UserSetup."Access Purchase Order"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);

        // UserSetup.RESET;
        // UserSetup.SETRANGE("User ID", USERID);
        // UserSetup.SETFILTER(UserSetup."Access Purchase Order", '%1', UserSetup."Access Purchase Order"::Receive);
        // IF UserSetup.FINDFIRST THEN
        //     If Rec."PO Type" = Rec."PO Type"::Goods Then
        //         ERROR('You can not Create the puchase order');

        // UserSetup.RESET;
        // UserSetup.SETRANGE("User ID", USERID);
        // UserSetup.SETFILTER(UserSetup."Access Purchase Order", '%1', UserSetup."Access Purchase Order"::Invoice);
        // IF UserSetup.FINDFIRST THEN
        //     If Rec."PO Type" = Rec."PO Type"::Goods Then
        //         ERROR('You can not Create the puchase order');


        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Purchase Order", '%1', UserSetup."Access Purchase Order"::"Receive & Invoice");
        UserSetup.SetFilter(UserSetup."Global Dimension 1 Code", '%1|%2', 'CATTLE', 'FEED');
        IF UserSetup.FINDFIRST THEN
            if UserId <> 'JOBQUEUE' Then
                If Rec."PO Type" = Rec."PO Type"::Goods Then
                    ERROR('You can not Create the puchase order');
        //PRU_DD 1.10
        USERSETUP.get(USERID);
        CompanyInfo.get;
        If CompanyInfo.SFPLCompany = CompanyInfo.SFPLCompany::Sampoorna Then
            if not USERSETUP."HO Users" then
                Rec.Validate("Location Code", USERSETUP."Shortcut Dimension 3 Code");

        Rec."PO Expiration Date" := Today() + 10;

    end;

    trigger OnModifyRecord(): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Purchase Order", '%1', UserSetup."Access Purchase Order"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You can not modify the puchase order');
        //PRU_DD 1.10
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    var
        USERSETUP: record "User Setup";
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Purchase Order", '%1', UserSetup."Access Purchase Order"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);

        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Purchase Order", '%1', UserSetup."Access Purchase Order"::Receive);
        IF UserSetup.FINDFIRST THEN
            if UserId <> 'JOBQUEUE' Then
                If Rec."PO Type" = Rec."PO Type"::Goods Then
                    ERROR('You can not Create the puchase order');

        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Purchase Order", '%1', UserSetup."Access Purchase Order"::Invoice);
        IF UserSetup.FINDFIRST THEN
            if UserId <> 'JOBQUEUE' Then
                If Rec."PO Type" = Rec."PO Type"::Goods Then
                    ERROR('You can not Create the puchase order');

        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Purchase Order", '%1', UserSetup."Access Purchase Order"::"Receive & Invoice");
        UserSetup.SetFilter(UserSetup."Global Dimension 1 Code", '%1|%2', 'CATTLE', 'FEED');
        IF UserSetup.FINDFIRST THEN
            if UserId <> 'JOBQUEUE' Then
                If Rec."PO Type" = Rec."PO Type"::Goods Then
                    ERROR('You can not Create the puchase order');

        USERSETUP.get(USERID);
        if not USERSETUP."HO Users" then
            Rec.Validate("Location Code", USERSETUP."Shortcut Dimension 3 Code");
        //PRU_DD 1.10
    end;

    trigger OnOpenPage()
    begin
        OrdeDateEdit := False;
        StarVisibility := false;
        VisibleSFPL := False;
        VisibleStarFoods := false;
        CompanyInfo.get;

        if Rec."Posted Sales Shipment No." <> '' then begin
            Rec.Validate("Shortcut Dimension 1 Code");
            Rec.Validate("Shortcut Dimension 2 Code");
            If CompanyInfo.SFPLCompany = CompanyInfo.SFPLCompany::Sampoorna Then
                Rec.Validate("Shortcut Dimension 3 Code");
        end;


        //PRU_DD 1.10
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Purchase Order", '%1', UserSetup."Access Purchase Order"::" ");
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to open Purchase Order');

        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Purchase Order", '%1', UserSetup."Access Purchase Order"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10
        /*=======*/ ///TARGET
        SetLocGSTRegNoEditable;
        /*<<<<<<<*/
        If CompanyInfo.SFPLCompany = CompanyInfo.SFPLCompany::"Star Foods" Then begin
            OrdeDateEdit := True;
            StarVisibility := True;
            VisibleStarFoods := True;
        end
        else
            VisibleSFPL := True;
        POExpiration := true;
        if Rec."No." <> '' Then begin
            User.Get(Rec.SystemCreatedBy);
            if ((User."User Name" <> UserId) or (Rec.Status = enum::"Purchase Document Status"::Expired)) then
                POExpiration := false;
        end;


    end;

    trigger OnAfterGetRecord()
    begin
        ShowShortcutDimCode(ShortcutDimCode);
        // if Rec."Posted Sales Shipment No." <> '' then begin
        //     Rec.Status := Rec.Status::Released;
        //     Rec.Modify();
        // end;
    end;

    trigger OnAfterGetCurrRecord()
    begin
        Enablecontrol();
    end;

    local procedure SaveInvoiceDiscountAmount()
    var
        DocumentTotals: Codeunit 57;
    begin
        CurrPage.SAVERECORD;
        DocumentTotals.PurchaseRedistributeInvoiceDiscountAmountsOnDocument(Rec);
        CurrPage.UPDATE(FALSE);
    end;

    local procedure SetLocGSTRegNoEditable()
    begin


        IsRateChangeEnabled := Rec."Rate Change Applicable";
    end;

    local procedure SpecialChr(ExtDocNo: Text[16])
    var
        Pos1: Integer;
        Pos2: Integer;
        Pos3: Integer;
        Pos4: Integer;
        Pos5: Integer;
        Pos6: Integer;
        Pos7: Integer;
        Pos8: Integer;
        Pos9: Integer;
        Pos10: Integer;
        Pos11: Integer;
        Pos12: Integer;
        Pos13: Integer;
        Pos14: Integer;
        Pos15: Integer;
        Pos16: Integer;
        Pos17: Integer;
        Pos18: Integer;
        Pos19: Integer;
        Pos20: Integer;
        Pos21: Integer;
        Pos22: Integer;
        Pos23: Integer;
        Pos24: Integer;
        Pos25: Integer;
        Pos26: Integer;
        Pos27: Integer;
        Pos28: Integer;
        Pos29: Integer;
    begin

        CLEAR(Pos1);
        CLEAR(Pos2);
        CLEAR(Pos3);
        CLEAR(Pos4);
        CLEAR(Pos5);
        CLEAR(Pos6);
        CLEAR(Pos7);
        CLEAR(Pos8);
        CLEAR(Pos9);
        CLEAR(Pos10);
        CLEAR(Pos11);
        CLEAR(Pos12);
        CLEAR(Pos13);
        CLEAR(Pos14);
        CLEAR(Pos15);
        CLEAR(Pos16);
        CLEAR(Pos17);
        CLEAR(Pos18);
        CLEAR(Pos19);
        CLEAR(Pos20);
        CLEAR(Pos21);
        CLEAR(Pos22);
        CLEAR(Pos23);
        CLEAR(Pos24);
        CLEAR(Pos25);
        CLEAR(Pos26);
        CLEAR(Pos27);
        CLEAR(Pos28);
        CLEAR(Pos29);
        //CLEAR(Pos30);


        Pos1 := STRPOS(ExtDocNo, ' ');
        Pos2 := STRPOS(ExtDocNo, '@');
        Pos3 := STRPOS(ExtDocNo, '!');
        Pos4 := STRPOS(ExtDocNo, '#');
        Pos5 := STRPOS(ExtDocNo, '`');
        Pos6 := STRPOS(ExtDocNo, '~');
        Pos7 := STRPOS(ExtDocNo, '$');
        Pos8 := STRPOS(ExtDocNo, '%');
        Pos9 := STRPOS(ExtDocNo, '^');
        Pos10 := STRPOS(ExtDocNo, '&');
        Pos11 := STRPOS(ExtDocNo, ',');
        Pos12 := STRPOS(ExtDocNo, '.');
        Pos13 := STRPOS(ExtDocNo, '\');
        Pos14 := STRPOS(ExtDocNo, '"');
        Pos15 := STRPOS(ExtDocNo, ';');
        Pos16 := STRPOS(ExtDocNo, '  ');
        Pos17 := STRPOS(ExtDocNo, '*');
        Pos18 := STRPOS(ExtDocNo, '<');
        Pos19 := STRPOS(ExtDocNo, '>');
        Pos20 := STRPOS(ExtDocNo, '{');
        Pos21 := STRPOS(ExtDocNo, '}');
        Pos22 := STRPOS(ExtDocNo, '(');
        Pos23 := STRPOS(ExtDocNo, ')');
        Pos24 := STRPOS(ExtDocNo, '[');
        Pos25 := STRPOS(ExtDocNo, ']');
        Pos26 := STRPOS(ExtDocNo, '=');
        Pos27 := STRPOS(ExtDocNo, '+');
        Pos28 := STRPOS(ExtDocNo, '?');
        Pos29 := STRPOS(ExtDocNo, '_');
        //Pos30 := STRPOS(ExtDocNo,'?');

        IF (Pos1 > 0) OR (Pos2 > 0) OR (Pos3 > 0) OR (Pos4 > 0) OR (Pos5 > 0) OR (Pos6 > 0) OR (Pos7 > 0) OR (Pos8 > 0) OR (Pos9 > 0) OR (Pos10 > 0)
          OR (Pos11 > 0) OR (Pos12 > 0) OR (Pos13 > 0) OR (Pos14 > 0) OR (Pos15 > 0) OR (Pos16 > 0) OR (Pos17 > 0) OR (Pos18 > 0) OR (Pos19 > 0) OR (Pos20 > 0)
          OR (Pos21 > 0) OR (Pos22 > 0) OR (Pos23 > 0) OR (Pos24 > 0) OR (Pos25 > 0) OR (Pos26 > 0) OR (Pos27 > 0) OR (Pos28 > 0) OR (Pos29 > 0) THEN
            ERROR('Special character Not Allowed');

    end;


    procedure UpdateVendorGST(VendorNo: Code[20])
    var
        UpdateGSTDetailsFromPortal: Codeunit 50023;
        Status: Text;
        Lastdate: Date;
        GSTName: Text;
        GSTAddr: Text;
        GStAddr2: Text;
        GSTStCode: Code[40];
        GStpCode: Code[20];
        Vendor: Record 23;
        GSTMsg001: Label 'Vendor Current Gst Status is %1.';
        ENDDate: Date;
    begin
        // SKS <<
        Vendor.RESET;
        IF Vendor.GET(VendorNo) THEN BEGIN
            IF Vendor."GST Registration No." <> '' THEN BEGIN
                UpdateGSTDetailsFromPortal.UpdateVendor(Vendor."No.", Vendor."GST Registration No.", Status, Lastdate, GSTName, GSTAddr, GStAddr2, GSTStCode, GStpCode, ENDDate);
                IF Vendor."Last Updated Date" <> TODAY THEN BEGIN
                    Vendor."GST Status" := Status;
                    Vendor."Last Updated Date" := Lastdate;
                    Vendor."GST Name" := GSTName;
                    Vendor."GST Address" := GSTAddr;
                    Vendor."GST Address 2" := GStAddr2;
                    Vendor."GST State Code" := GSTStCode;
                    Vendor."GST Post Code" := GStpCode;
                    Vendor."Last Updated Date" := ENDDate;
                    Vendor.MODIFY;
                    IF Status <> '' THEN BEGIN
                        IF Status <> 'Active' THEN
                            MESSAGE(GSTMsg001, Status);
                    END;
                END ELSE
                    IF Status <> 'Active' THEN
                        MESSAGE(GSTMsg001, Status);
            END;
        END;
        //SKS >>
    end;



    var
        ShortcutDimCode: array[8] of Code[20];
        DimMgt: Codeunit DimensionManagement;
        LookMode: Boolean;
        myInt: Integer;
        TextPartial: Label 'Document Short Closed, If require create new order for remaining Qty.  ';
        UserSetup: Record 91;
        PLQty: Decimal;
        RPurchLine: Record 39;
        RecLocation: Record 14;
        TotalRemainingQty: Decimal;
        TotalRemainingQty1: Decimal;
        ILE: Record 32;
        GeneralLedgerSetup: Record 98;
        GSTLocRegNo: Boolean;
        IsRateChangeEnabled: Boolean;
        ReferenceInvoiceNoErr: Label 'You cannot select Non GST document to GST Docment.';
        ReferenceNoErr: Label 'Reference Invoice No is  required where Invoice Type is Debit Note and Supplementary.';
        PurchaseHeader: Record 38;
        PostingDate: Date;
        CheckApprovalEntry: Record 454;
        DeleteApprovalEntry: Record 454;
        BrokerageEdit: Boolean;
        Location: Record 14;
        CompanyInfo: Record "Company Information";
        OrdeDateEdit: Boolean;
        VisibleSFPL: Boolean;
        VisibleStarFoods: Boolean;
        StarVisibility: Boolean;
        POExpiration: Boolean;
        User: Record User;
        IsService: Boolean;

    procedure Enablecontrol()
    var
    begin
        IsService := False;
        if Rec."PO Type" <> Rec."PO Type"::Goods then
            IsService := True;
        if Rec."PO Type" = Rec."PO Type"::Goods then
            If Rec.Status = Rec.Status::Open Then
                Rec.Validate("Service Type", Rec."Service Type"::" ");

    end;

    local procedure ValidateShortcutDimension(DimIndex: Integer)
    var
        AssembleToOrderLink: Record "Assemble-to-Order Link";
    begin
        Rec.ValidateShortcutDimCode(DimIndex, ShortcutDimCode[DimIndex]);
        //AssembleToOrderLink.UpdateAsmDimFromSalesLine(Rec);
    end;

    procedure ShowShortcutDimCode(var ShortcutDimCode: array[8] of Code[20])
    begin
        DimMgt.GetShortcutDimensions(Rec."Dimension Set ID", ShortcutDimCode);
    end;
}