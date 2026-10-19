pageextension 50087 PurchaseCreditMemoExt extends "Purchase Credit Memo"
{
    layout
    {


        modify("Vendor Cr. Memo No.")
        {

            trigger OnBeforeValidate()
            begin
                SpecialChr(Rec."Vendor Cr. Memo No.");
            end;

        }

        modify("Buy-from Vendor Name")
        {
            trigger OnLookup(var Text: Text): Boolean
            var
                Cust: Record Vendor;
                CustList: Page "Vendor List";
                UserSetupRec: Record "User Setup";
            begin
                CompanyInfo.Get;
                Cust.Reset();
                Cust.SetFilter(Cust.Blocked, '%1', Cust.Blocked::" ");
                CustList.SETTABLEVIEW(Cust);
                CustList.LOOKUPMODE := TRUE;
                IF CustList.RUNMODAL = ACTION::LookupOK THEN begin
                    CustList.GetRecord(Cust);
                    Rec.Validate("Buy-from Vendor No.", Cust."No.");
                    CurrPage.Update();
                    UserSetupRec.Get(UserId);
                    Rec.VALIDATE("Shortcut Dimension 1 Code", UserSetupRec."Global Dimension 1 Code");
                    //    Clear(Rec."Shortcut Dimension 2 Code");
                    Rec.VALIDATE("Shortcut Dimension 2 Code", UserSetupRec."Global Dimension 2 Code");
                    IF NOT UserSetupRec."User Permission" THEN BEGIN
                        Rec.VALIDATE("Shortcut Dimension 1 Code", UserSetupRec."Global Dimension 1 Code");
                        Rec.VALIDATE("Shortcut Dimension 2 Code", UserSetupRec."Global Dimension 2 Code");
                        IF NOT UserSetupRec."HO Users" THEN BEGIN
                            If CompanyInfo.SFPLCompany = CompanyInfo.SFPLCompany::Sampoorna then
                                Rec.VALIDATE("Shortcut Dimension 3 Code", UserSetupRec."Shortcut Dimension 3 Code");
                            //   Rec.VALIDATE("Location Code", UserSetupRec."Shortcut Dimension 3 Code");
                            // Message(UserSetupRec."Shortcut Dimension 3 Code");
                        END;
                    end;
                END;
            end;

        }
        modify("Buy-from Vendor No.")
        {
            trigger OnAfterValidate()
            var
                UserSetupRec: Record "User Setup";
            begin
                UserSetupRec.Get(UserId);
                Rec.VALIDATE("Shortcut Dimension 1 Code", UserSetupRec."Global Dimension 1 Code");
                //    Clear(Rec."Shortcut Dimension 2 Code");
                Rec.VALIDATE("Shortcut Dimension 2 Code", UserSetupRec."Global Dimension 2 Code");
                IF NOT UserSetupRec."User Permission" THEN BEGIN
                    Rec.VALIDATE("Shortcut Dimension 1 Code", UserSetupRec."Global Dimension 1 Code");
                    Rec.VALIDATE("Shortcut Dimension 2 Code", UserSetupRec."Global Dimension 2 Code");
                    IF NOT UserSetupRec."HO Users" THEN BEGIN
                        If CompanyInfo.SFPLCompany = CompanyInfo.SFPLCompany::Sampoorna then
                            Rec.VALIDATE("Shortcut Dimension 3 Code", UserSetupRec."Shortcut Dimension 3 Code");
                        //   Rec.VALIDATE("Location Code", UserSetupRec."Shortcut Dimension 3 Code");
                        // Message(UserSetupRec."Shortcut Dimension 3 Code");
                    END;
                end;
            end;

            trigger OnLookup(var Text: Text): Boolean
            var
                Cust: Record Vendor;
                CustList: Page "Vendor List";
                UserSetupRec: Record "User Setup";
            begin
                Cust.Reset();
                Cust.SetFilter(Cust.Blocked, '%1', Cust.Blocked::" ");
                CustList.SETTABLEVIEW(Cust);
                CustList.LOOKUPMODE := TRUE;
                IF CustList.RUNMODAL = ACTION::LookupOK THEN begin
                    CustList.GetRecord(Cust);
                    Rec.Validate("Buy-from Vendor No.", Cust."No.");
                    CurrPage.Update();
                    UserSetupRec.Get(UserId);
                    Rec.VALIDATE("Shortcut Dimension 1 Code", UserSetupRec."Global Dimension 1 Code");
                    //    Clear(Rec."Shortcut Dimension 2 Code");
                    Rec.VALIDATE("Shortcut Dimension 2 Code", UserSetupRec."Global Dimension 2 Code");
                    IF NOT UserSetupRec."User Permission" THEN BEGIN
                        Rec.VALIDATE("Shortcut Dimension 1 Code", UserSetupRec."Global Dimension 1 Code");
                        Rec.VALIDATE("Shortcut Dimension 2 Code", UserSetupRec."Global Dimension 2 Code");
                        IF NOT UserSetupRec."HO Users" THEN BEGIN
                            If CompanyInfo.SFPLCompany = CompanyInfo.SFPLCompany::Sampoorna then
                                Rec.VALIDATE("Shortcut Dimension 3 Code", UserSetupRec."Shortcut Dimension 3 Code");
                            //   Rec.VALIDATE("Location Code", UserSetupRec."Shortcut Dimension 3 Code");
                            // Message(UserSetupRec."Shortcut Dimension 3 Code");
                        END;
                    end;
                END;
            end;

        }
        /* addafter("No.")
         {
            
             field("Rate Basis"; Rec."Rate Basis")
             {
                 ApplicationArea = All;

             }
             field("Terms Code"; Rec."Terms Code")
             {
                 ApplicationArea = All;

             }
            
             field("Against Original Invoice Date"; Rec."Against Original Invoice Date")
             {
                 ApplicationArea = All;

             }
             field("Against Original Invoice No."; Rec."Against Original Invoice No.")
             {
                 ApplicationArea = All;

             }
          
             
             
         }*/
        moveafter("Buy-from Vendor Name"; "Vendor GST Reg. No.")
        modify("Buy-from")
        {
            Visible = false;
        }
        modify("Location Code")
        {
            Visible = true;

            trigger OnAfterValidate()
            var
                LocRec: Record Location;
                UserSetupRec: Record "User Setup";
            begin
                CompanyInfo.Get;
                UserSetupRec.Get(USERID);
                Rec.VALIDATE("Shortcut Dimension 1 Code", UserSetupRec."Global Dimension 1 Code");
                Rec.VALIDATE("Shortcut Dimension 2 Code", UserSetupRec."Global Dimension 2 Code");
                Rec.SetHideValidationDialog(true);
                IF UserSetupRec."User Permission" THEN BEGIN
                    Location.RESET;
                    Location.SETRANGE(Code, Rec."Location Code");
                    IF Location.FINDFIRST THEN
                        Rec.VALIDATE("Shortcut Dimension 2 Code", Location."Global Dimension 2 Code");
                END;

                Rec.VALIDATE("Shortcut Dimension 2 Code");
                If CompanyInfo.SFPLCompany = CompanyInfo.SFPLCompany::Sampoorna then
                    Rec.VALIDATE("Shortcut Dimension 3 Code", Rec."Location Code");
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

                    UserSetupRec.Get(UserId);
                    Rec.SetHideValidationDialog(true);
                    IF UserSetupRec."User Permission" THEN BEGIN
                        Location.RESET;
                        Location.SETRANGE(Code, Rec."Location Code");
                        IF Location.FINDFIRST THEN
                            Rec.VALIDATE("Shortcut Dimension 2 Code", Location."Global Dimension 2 Code");
                    END;

                    Rec.VALIDATE("Shortcut Dimension 2 Code");
                    If CompanyInfo.SFPLCompany = CompanyInfo.SFPLCompany::Sampoorna then
                        Rec.VALIDATE("Shortcut Dimension 3 Code", Rec."Location Code");

                end;
            END;
        }

        moveafter("Vendor GST Reg. No."; "Posting Date")
        moveafter("Posting Date"; "Document Date")
        moveafter("Document Date"; "Vendor Cr. Memo No.")
        moveafter("Vendor Cr. Memo No."; "Payment Terms Code")
        moveafter("Payment Terms Code"; Status)
        moveafter(Status; "Location Code")
        addafter("Vendor GST Reg. No.")
        {
            field("P.A.N No."; rec."P.A.N No.")
            {
                ApplicationArea = all;
                Editable = false;
            }
        }
        addafter("Location Code")
        {
            field("Mandi Name"; Rec."Mandi Name")
            {
                ApplicationArea = All;

            }
            field("File No."; Rec."File No.")
            {
                ApplicationArea = All;

            }
            field("Due Date calculation"; Rec."Due Date calculation")
            {
                ApplicationArea = All;

            }
        }
        moveafter("Due Date calculation"; "Invoice Type")
        addafter("Invoice Type")
        {
            field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
            {
                ApplicationArea = All;

            }
            field("Creditors Type"; Rec."Creditors Type")
            {
                ApplicationArea = All;

            }
            field("Line Narration1"; Rec."Line Narration1")
            {
                ApplicationArea = All;

            }
            field("Brokerage Code"; Rec."Brokerage Code")
            {
                ApplicationArea = All;
                // trigger OnLookup(var Text: Text): Boolean
                // var
                //     Cust: Record Vendor;
                //     CustList: Page "Vendor List";
                // begin
                //     Cust.Reset();
                //     Cust.SetFilter(Cust.Broker, '%1', true);
                //     Cust.SetFilter(Cust.Blocked, '%1', Cust.Blocked::" ");
                //     CustList.SETTABLEVIEW(Cust);
                //     CustList.LOOKUPMODE := TRUE;
                //     IF CustList.RUNMODAL = ACTION::LookupOK THEN begin
                //         CustList.GetRecord(Cust);
                //         Rec.Validate("Brokerage Code", Cust."No.");
                //     END;
                // end;
            }
            field("Brokerage Calculation Basis"; Rec."Brokerage Calculation Basis")
            {
                ApplicationArea = all;

            }
            field("Brokerage Rate"; Rec."Brokerage Rate")
            {
                ApplicationArea = All;
            }
        }
        //>>
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
        modify("Currency Code")
        {
            Visible = false;
        }
        movebefore("Payment Discount %"; "Due Date")
        modify("Tax Liable")
        {
            Visible = false;
        }
        modify("Tax Area Code")
        {
            Visible = false;
        }
        modify("Vendor Posting Group")
        {
            Visible = false;
        }
        modify("Payment Terms Code")
        {
            Visible = true;
        }
        modify("Payment Method Code")
        {
            Visible = false;
        }
        moveafter("Pmt. Discount Date"; "Prices Including VAT")
        moveafter("Prices Including VAT"; "VAT Bus. Posting Group")
        //>>tax info
        modify("Without Bill Of Entry")
        {
            Visible = false;
        }
        addafter("Location GST Reg. No.")
        {
            field("GST Vendor Type"; rec."GST Vendor Type")
            {
                ApplicationArea = all;
            }

        }
        moveafter("Location State Code"; "Location GST Reg. No.")
        addafter("GST Vendor Type")
        {
            field("GST Input Service Distribution"; rec."GST Input Service Distribution")
            {
                ApplicationArea = all;
            }
            field("SFPL User ID"; Rec."SFPL User ID")
            {
                ApplicationArea = All;
            }
        }
        //moveafter("GST Vendor Type"; "Invoice Type")
        moveafter("GST Input Service Distribution"; "Associated Enterprises")
        moveafter("Associated Enterprises"; "Bill of Entry No.")
        moveafter("Bill of Entry No."; "Bill of Entry Date")
        moveafter("Bill of Entry Date"; "Bill of Entry Value")
        moveafter("Bill of Entry Value"; "GST Order Address State")
        moveafter("GST Order Address State"; "Order Address GST Reg. No.")
        moveafter("Shipping Agent Code"; "Distance (Km)")
        moveafter("Supply Finish Date"; "POS as Vendor State")
        moveafter("POS as Vendor State"; "POS Out Of India")
        modify("GST Invoice")
        {
            Visible = false;
        }

        modify("Nature of Supply")
        {
            Visible = false;
        }
    }

    actions
    {

        modify(PostAndPrint)
        {
            Visible = false;
        }
        addafter(PostAndPrint)
        {
            action("Post&Print")
            {
                Caption = 'Post  & Print';
                Image = PostPrint;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ShortCutKey = 'Shift+F9';

                Applicationarea = All;
                trigger OnAction()
                var
                    SalesReceivablesSetup: Record 311;
                    orderNo: Code[20];
                    PPIRec: Record "Purch. Cr. Memo Hdr.";
                    GLEntry: Record "G/L Entry";
                begin
                    orderNo := Rec."No.";

                    //PruRaj_RQ_0.01
                    PL.RESET;
                    PL.SETRANGE("Document Type", PL."Document Type"::"Credit Memo");
                    PL.SETRANGE("Document No.", Rec."No.");
                    PL.SETRANGE(Type, PL.Type::Item);
                    PL.SETRANGE("Return Shipment No.", '');
                    IF PL.FINDSET THEN
                        REPEAT
                            CLEAR(RemQty);
                            RecItem.Get(PL."No.");
                            if RecItem.Type in [RecItem.Type::Inventory] Then begin
                                ILE.RESET;
                                ILE.SETRANGE("Item No.", PL."No.");
                                ILE.SETRANGE("Posting Date", 0D, Rec."Posting Date");
                                ILE.SETRANGE("Location Code", PL."Location Code");
                                IF ILE.FINDSET THEN BEGIN
                                    ILE.CALCSUMS("Remaining Quantity");
                                    RemQty := ILE."Remaining Quantity";
                                END;
                                IF RemQty < PL.Quantity THEN
                                    ERROR('Stock Not Available for Item No %1 of %2 Location', PL."No.", PL."Location Code");
                            end;
                        UNTIL PL.NEXT = 0;

                    //PruRaj_RQ_0.01

                    UserSetup.RESET;
                    UserSetup.SETRANGE("User ID", USERID);
                    UserSetup.SETFILTER(UserSetup."Access Purchase Credit Memo", '%1', UserSetup."Access Purchase Credit Memo"::View);
                    IF UserSetup.FINDFIRST THEN
                        ERROR('You can not Post Purchase Credit Memo');
                    //PRU_DD 1.10
                    UserSetup.RESET;
                    UserSetup.SETRANGE("User ID", USERID);
                    UserSetup.SETFILTER(UserSetup."Access Purchase Credit Memo", '%1', UserSetup."Access Purchase Credit Memo"::Edit);
                    IF UserSetup.FINDFIRST THEN
                        ERROR('You do not have Permission to Post Purchase Credit Memo');

                    if (rec."Shortcut Dimension 1 Code" = 'FEED') and (rec."Shortcut Dimension 1 Code" = 'CATTLE') then
                        Rec.TestField("Brokerage Code");// suman 09-04-2024

                    SalesReceivablesSetup.GET;
                    SalesReceivablesSetup."Print Report" := TRUE;
                    SalesReceivablesSetup.MODIFY;
                    Post(CODEUNIT::"Purch.-Post (Yes/No)");
                    SalesReceivablesSetup.GET;
                    SalesReceivablesSetup."Print Report" := FALSE;
                    SalesReceivablesSetup.MODIFY;

                    PPIRec.Reset();
                    PPIRec.SetRange("Pre-Assigned No.", orderNo);
                    if PPIRec.FindFirst() then begin
                        GLEntry.Reset();
                        GLEntry.SETCURRENTKEY("Document No.", "Posting Date");
                        GLEntry.SETRANGE("Document No.", PPIRec."No.");
                        GLEntry.SETRANGE("Posting Date", rec."Posting Date");
                        GLEntry.SETFILTER("Source Code", '<>%1', 'INVTPCOST');
                        IF GLEntry.FINDFIRST THEN
                            REPORT.RUNMODAL(REPORT::"Posted Voucher1", false, TRUE, GLEntry);
                    end;
                end;
            }
        }
        // Add changes to page actions here
        addafter("Co&mments")
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
                    PurchaseLine.CALCSUMS(PurchaseLine.Quantity, PurchaseLine."Return Qty. Shipped");
                    IF (PurchaseLine.Quantity <> PurchaseLine."Return Qty. Shipped") THEN BEGIN
                        //    Status := Status::
                        //  MODIFY;
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

        modify(Post)
        {
            trigger OnBeforeAction()
            begin


                //PruRaj_RQ_0.01
                PL.RESET;
                PL.SETRANGE("Document Type", PL."Document Type"::"Credit Memo");
                PL.SETRANGE("Document No.", Rec."No.");
                PL.SETRANGE(Type, PL.Type::Item);
                PL.SETRANGE("Return Shipment No.", '');
                IF PL.FINDSET THEN
                    REPEAT
                        CLEAR(RemQty);
                        RecItem.Get(PL."No.");
                        if RecItem.Type in [RecItem.Type::Inventory] Then begin
                            ILE.RESET;
                            ILE.SETRANGE("Item No.", PL."No.");
                            ILE.SETRANGE("Posting Date", 0D, Rec."Posting Date");
                            ILE.SETRANGE("Location Code", PL."Location Code");
                            IF ILE.FINDSET THEN BEGIN
                                ILE.CALCSUMS("Remaining Quantity");
                                RemQty := ILE."Remaining Quantity";
                            END;
                            IF RemQty < PL.Quantity THEN
                                ERROR('Stock Not Available for Item No %1 of %2 Location', PL."No.", PL."Location Code");
                        end;
                    UNTIL PL.NEXT = 0;

                //PruRaj_RQ_0.01

                UserSetup.RESET;
                UserSetup.SETRANGE("User ID", USERID);
                UserSetup.SETFILTER(UserSetup."Access Purchase Credit Memo", '%1', UserSetup."Access Purchase Credit Memo"::View);
                IF UserSetup.FINDFIRST THEN
                    ERROR('You can not Post Purchase Credit Memo');
                //PRU_DD 1.10
                UserSetup.RESET;
                UserSetup.SETRANGE("User ID", USERID);
                UserSetup.SETFILTER(UserSetup."Access Purchase Credit Memo", '%1', UserSetup."Access Purchase Credit Memo"::Edit);
                IF UserSetup.FINDFIRST THEN
                    ERROR('You do not have Permission to Post Purchase Credit Memo');
                //PRU_DD 1.10

                Rec.TESTFIELD("Payment Terms Code");
                if (rec."Shortcut Dimension 1 Code" = 'FEED') and (rec."Shortcut Dimension 1 Code" = 'CATTLE') then
                    Rec.TestField("Brokerage Code");// suman 09-04-2024
            end;
        }
        addafter(Post)
        {
            action("Post & Email Send")
            {
                Caption = 'Post & Email Send';
                Image = PostOrder;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ShortCutKey = 'F9';
                Visible = false;// 29-11-2023

                Applicationarea = All;
                trigger OnAction()
                begin
                    if (rec."Shortcut Dimension 1 Code" = 'FEED') and (rec."Shortcut Dimension 1 Code" = 'CATTLE') then
                        Rec.TestField("Brokerage Code");// suman 09-04-2024
                                                        //PruRaj_RQ_0.01
                    PL.RESET;
                    PL.SETRANGE("Document Type", PL."Document Type"::"Credit Memo");
                    PL.SETRANGE("Document No.", Rec."No.");
                    PL.SETRANGE(Type, PL.Type::Item);
                    PL.SETRANGE("Return Shipment No.", '');
                    IF PL.FINDSET THEN
                        REPEAT
                            CLEAR(RemQty);
                            RecItem.Get(PL."No.");
                            if RecItem.Type in [RecItem.Type::Inventory] Then begin
                                ILE.RESET;
                                ILE.SETRANGE("Item No.", PL."No.");
                                ILE.SETRANGE("Posting Date", 0D, Rec."Posting Date");
                                ILE.SETRANGE("Location Code", PL."Location Code");
                                IF ILE.FINDSET THEN BEGIN
                                    ILE.CALCSUMS("Remaining Quantity");
                                    RemQty := ILE."Remaining Quantity";
                                END;
                                IF RemQty < PL.Quantity THEN
                                    ERROR('Stock Not Available for Item No %1 of %2 Location', PL."No.", PL."Location Code");
                            end;
                        UNTIL PL.NEXT = 0;

                    //PruRaj_RQ_0.01

                    UserSetup.RESET;
                    UserSetup.SETRANGE("User ID", USERID);
                    UserSetup.SETFILTER(UserSetup."Access Purchase Credit Memo", '%1', UserSetup."Access Purchase Credit Memo"::View);
                    IF UserSetup.FINDFIRST THEN
                        ERROR('You can not Post Purchase Credit Memo');
                    //PRU_DD 1.10
                    UserSetup.RESET;
                    UserSetup.SETRANGE("User ID", USERID);
                    UserSetup.SETFILTER(UserSetup."Access Purchase Credit Memo", '%1', UserSetup."Access Purchase Credit Memo"::Edit);
                    IF UserSetup.FINDFIRST THEN
                        ERROR('You do not have Permission to Post Purchase Credit Memo');
                    //PRU_DD 1.10

                    Rec.TESTFIELD("Payment Terms Code");

                    CLEAR(PurchPostYesNo);
                    //    PurchPostYesNo.SetSendEmail(TRUE);
                    PurchPostYesNo.Run(Rec);
                end;
            }

        }
    }

    trigger OnDeleteRecord(): Boolean
    begin

        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Purchase Credit Memo", '%1', UserSetup."Access Purchase Credit Memo"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have Permission to Delete Purchase Credit Memo');
        //PRU_DD 1.10
        ////06072019
    end;

    trigger OnOpenPage()
    begin
        LookMode := false;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin

        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Purchase Credit Memo", '%1', UserSetup."Access Purchase Credit Memo"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have Permission to enter Purchase Credit Memo Details');
        //PRU_DD 1.10
        ////06072019

        Rec."Applies-to Doc. Type" := Rec."Applies-to Doc. Type"::Invoice;
        Rec.Validate("Shipment Method Code", 'ROAD');
        Rec.Validate("Vehicle Type", rec."Vehicle Type"::Regular);
    end;

    trigger OnModifyRecord(): Boolean
    begin

        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Purchase Credit Memo", '%1', UserSetup."Access Purchase Credit Memo"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have Permission to change Purchase Credit Memo Details');
        //PRU_DD 1.10
        ///06072019
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        //06072019
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Purchase Credit Memo", '%1', UserSetup."Access Purchase Credit Memo"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10



        //////"Responsibility Center" := UserMgt.GetPurchasesFilter;
    end;

    LOCAL procedure Post(PostingCodeunitID: Integer)
    begin
        Rec.SendToPosting(PostingCodeunitID);
        IF Rec."Job Queue Status" = Rec."Job Queue Status"::"Scheduled for Posting" THEN
            CurrPage.CLOSE;
        CurrPage.UPDATE(FALSE);
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
        Test0001: Label 'You can not enter vendor invoice no. more than 16 character.';
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
        IF Rec."GST Vendor Type" = Rec."GST Vendor Type"::Registered THEN
            IF StrLen(ExtDocNo) > 16 THEN
                ERROR(Test0001);
    end;


    var
        myInt: Integer;
        UserSetup: Record 91;
        TextPartial: Label 'Document Short Closed, If require create new order for remaining Qty.  ';
        GSTLocRegNo: Boolean;
        IsRateChangeEnabled: Boolean;
        ReferenceInvoiceNoErr: Label 'You cannot select Non GST document to GST Docment.';
        PL: Record 39;
        ILE: Record 32;
        RemQty: Decimal;
        PurchaseHeader: Record 38;
        PostingDate: Date;
        PurchPostYesNo: Codeunit "Purch.-Post (Yes/No)";
        Location: Record 14;
        PurchLine: Record "Purchase Line";
        LookMode: Boolean;
        CompanyInfo: Record "Company Information";
        RecItem: Record Item;
}