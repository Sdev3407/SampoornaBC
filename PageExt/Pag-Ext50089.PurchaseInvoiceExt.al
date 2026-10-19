pageextension 50089 PurchaseInvoiceExt extends "Purchase Invoice"
{
    layout
    {
        addafter("GST Vendor Type")
        {
            field("SFPL User ID"; Rec."SFPL User ID")
            {
                ApplicationArea = All;
            }
        }

        modify("Incoming Document Entry No.")
        {
            Visible = false;
        }
        modify("Buy-from Vendor Name")
        {
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
                        Rec.VALIDATE("Shortcut Dimension 3 Code", UserSetupRec."Shortcut Dimension 3 Code");
                        //   Rec.VALIDATE("Location Code", UserSetupRec."Shortcut Dimension 3 Code");
                        // Message(UserSetupRec."Shortcut Dimension 3 Code");
                    END;
                end;
            end;



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
                If CompanyInfo.SFPLCompany = CompanyInfo.SFPLCompany::Sampoorna then
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
            END;
        }
        /*
        addafter("Against Original Invoice Date")
        {

            field("Terms Code"; Rec."Terms Code")
            {
                ApplicationArea = All;

            }
            field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
            {
                ApplicationArea = All;

            }

            field("Brokerage Rate"; Rec."Brokerage Rate")
            {
                ApplicationArea = All;

            }
        }
        */
        moveafter("Buy-from Vendor Name"; "Vendor GST Reg. No.")
        modify("Buy-from")
        {
            Visible = false;
        }
        moveafter("Vendor GST Reg. No."; "Posting Date")
        moveafter("Posting Date"; "Document Date")
        moveafter("Document Date"; "Vendor Invoice No.")
        moveafter("Purchaser Code"; "Location Code")
        addafter("Vendor GST Reg. No.")
        {
            field("P.A.N No."; rec."P.A.N No.")
            {
                ApplicationArea = All;
                Editable = false;

            }
        }
        modify("Vendor Invoice No.")
        {
            trigger OnBeforeValidate()
            begin
                SpecialChr(Rec."Vendor Invoice No.");

            end;
        }
        addafter("Location Code")
        {
            field("Brokerage Calculation Basis"; Rec."Brokerage Calculation Basis")
            {
                ApplicationArea = All;
                Visible = FieldVisible;

            }

            field("Brokerage Code"; Rec."Brokerage Code")
            {
                ApplicationArea = All;
                Visible = FieldVisible;

            }
            field("Brokerage Rate"; "Brokerage Rate")
            {
                ApplicationArea = all;
                Visible = FieldVisible;
            }
            field("Rate Basis"; Rec."Rate Basis")
            {
                ApplicationArea = All;
                Visible = FieldVisible;
            }
        }
        moveafter("Rate Basis"; "Bill of Entry No.")
        moveafter("Bill of Entry No."; "Bill of Entry Date")
        moveafter("Bill of Entry Date"; "Bill of Entry Value")
        moveafter("Bill of Entry Value"; "Payment Terms Code")
        moveafter("Payment Terms Code"; "Due Date")
        addafter("Due Date")
        {
            field("Mandi Name"; Rec."Mandi Name")
            {
                ApplicationArea = All;
                Visible = FieldVisible;
            }
            field("File No."; Rec."File No.")
            {
                ApplicationArea = All;
                Visible = FieldVisible;
            }
            field("Due Date calculation"; Rec."Due Date calculation")
            {
                ApplicationArea = All;

            }
        }

        moveafter("Due Date calculation"; "Payment Method Code")
        moveafter("Payment Method Code"; Status)
        moveafter(Status; "Invoice Type")
        addafter("Invoice Type")
        {
            field("Against Original Invoice No."; Rec."Against Original Invoice No.")
            {
                ApplicationArea = All;
                Visible = false;

            }
            field("Against Original Invoice Date"; Rec."Against Original Invoice Date")
            {
                ApplicationArea = All;
                Visible = false;

            }
            field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
            {
                ApplicationArea = All;

            }
            field("Creditors Type"; Rec."Creditors Type")
            {
                ApplicationArea = All;
                Visible = FieldVisible;

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
        movebefore("Pay-to City"; "Pay-to Contact")

        moveafter("On Hold"; "Prices Including VAT")
        moveafter("Prices Including VAT"; "VAT Bus. Posting Group")
        //>>tax info
        moveafter("Location State Code"; "Location GST Reg. No.")
        moveafter("Location GST Reg. No."; "GST Vendor Type")
        addafter("GST Vendor Type")
        {
            field("GST Input Service Distribution"; rec."GST Input Service Distribution")
            {
                ApplicationArea = all;
                Visible = false;
            }
        }

        //moveafter("GST Vendor Type"; "Invoice Type")
        moveafter("GST Input Service Distribution"; "Associated Enterprises")
        moveafter("Associated Enterprises"; "Without Bill Of Entry")
        moveafter("Without Bill Of Entry"; "GST Order Address State")
        moveafter("GST Order Address State"; "Order Address GST Reg. No.")
        moveafter("Shipping Agent Code"; "Distance (Km)")
        moveafter("Supply Finish Date"; "POS as Vendor State")
        moveafter("POS as Vendor State"; "POS Out Of India")
        modify("GST Invoice")
        {
            Visible = true;
        }

        modify("Nature of Supply")
        {
            Visible = false;
        }
    }

    actions
    {

        // Add changes to page actions here
        modify(Preview)
        {
            trigger OnBeforeAction()
            var
                PurcLIne: Record "Purchase Line";
                PurRece: Record "Purch. Rcpt. Header";
            begin
                PurcLIne.Reset();
                PurcLIne.SetRange("Document No.", Rec."No.");
                PurcLIne.Setfilter("No.", '<>%1', '');
                PurcLIne.Setfilter("Receipt No.", '<>%1', '');
                if PurcLIne.FindFirst() then begin
                    PurRece.Get(PurcLIne."Receipt No.");
                    if Rec."Payment Terms Code" <> PurRece."Payment Terms Code" then
                        Error('Please update the Payment Term code as per Purchase Order No. %1, Payment Term code must be same as %2', PurRece."Order No.", PurRece."Payment Terms Code");
                end;
            end;
        }
        modify(Post)
        {
            Visible = TRUE;
            trigger OnBeforeAction()
            var
                SHLoc: Record 36;
                DOCAtt: Record "Document Attachment";
                PurchaseOrder1: Page 50;
                PurcLIne: Record "Purchase Line";
                PurRece: Record "Purch. Rcpt. Header";
            begin
                CompanyInfo.get;

                CLEAR(PurchaseOrder);
                PurchaseOrder1.UpdateVendorGST(Rec."Buy-from Vendor No.");
                UserSetup.RESET;
                UserSetup.SETRANGE("User ID", USERID);
                UserSetup.SETFILTER(UserSetup."Access Purchase Invoice", '%1', UserSetup."Access Purchase Invoice"::Edit);
                IF UserSetup.FINDFIRST THEN
                    ERROR('You do not have Permission to Post Purchase Invoice');
                //PRU_DD 1.10
                UserSetup.RESET;
                UserSetup.SETRANGE("User ID", USERID);
                UserSetup.SETFILTER(UserSetup."Access Purchase Invoice", '%1', UserSetup."Access Purchase Invoice"::View);
                IF UserSetup.FINDFIRST THEN
                    ERROR('You do not have Permission to Post Purchase Invoice');
                //PRU_DD 1.10
                If CompanyInfo.SFPLCompany in [CompanyInfo.SFPLCompany::Sampoorna] then Begin
                    TestField("Brokerage Code");// suman 09-04-2024
                    IF Rec."Creditors Type" = 0 THEN
                        ERROR('Please enter the creditor type');
                End;

                PurcLIne.Reset();
                PurcLIne.SetRange("Document No.", Rec."No.");
                PurcLIne.Setfilter("No.", '<>%1', '');
                PurcLIne.Setfilter("Receipt No.", '<>%1', '');
                if PurcLIne.FindFirst() then begin
                    PurRece.Get(PurcLIne."Receipt No.");

                    if Rec."Payment Terms Code" <> PurRece."Payment Terms Code" then
                        Error('Please update the Payment Term code as per Purchase Order No. %1, Payment Term code must be same as %2', PurRece."Order No.", PurRece."Payment Terms Code");
                end;

                //                    IF ((Rec."Responsibility Center" <> 'FEED') AND (Rec."Responsibility Center" <> 'CATTLE')) AND (Rec."Posting Date" > 20220331D) THEN begin
                //S.M         Rec.TESTFIELD("Incoming Document Entry No.");
                DOCAtt.Reset();
                DOCAtt.SetRange("No.", Rec."No.");
                if not DOCAtt.FindFirst() then
                    Error('Please attached the document');

            end;

        }
        addafter(Post)
        {
            action("Post1")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'P&ost1';
                Image = PostOrder;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ShortCutKey = 'F9';
                Visible = false;
                ToolTip = 'Finalize the document or journal by posting the amounts and quantities to the related accounts in your company books.';

                trigger OnAction()
                var
                    SHLoc: Record 36;
                    DOCAtt: Record "Document Attachment";
                    PurchaseOrder: Page "Purchase Order";
                    PurcLIne: Record "Purchase Line";
                    PurRece: Record "Purch. Rcpt. Header";
                begin

                    CLEAR(PurchaseOrder);
                    PurchaseOrder.UpdateVendorGST(Rec."Buy-from Vendor No.");
                    UserSetup.RESET;
                    UserSetup.SETRANGE("User ID", USERID);
                    UserSetup.SETFILTER(UserSetup."Access Purchase Invoice", '%1', UserSetup."Access Purchase Invoice"::Edit);
                    IF UserSetup.FINDFIRST THEN
                        ERROR('You do not have Permission to Post Purchase Invoice');
                    //PRU_DD 1.10
                    UserSetup.RESET;
                    UserSetup.SETRANGE("User ID", USERID);
                    UserSetup.SETFILTER(UserSetup."Access Purchase Invoice", '%1', UserSetup."Access Purchase Invoice"::View);
                    IF UserSetup.FINDFIRST THEN
                        ERROR('You do not have Permission to Post Purchase Invoice');
                    //PRU_DD 1.10
                    TestField("Brokerage Code");// suman 09-04-2024
                    IF Rec."Creditors Type" = 0 THEN
                        ERROR('Please enter the creditor type');


                    PurcLIne.Reset();
                    PurcLIne.SetRange("Document No.", Rec."No.");
                    PurcLIne.Setfilter("No.", '<>%1', '');
                    PurcLIne.Setfilter("Receipt No.", '<>%1', '');
                    if PurcLIne.FindFirst() then begin
                        PurRece.Get(PurcLIne."Receipt No.");
                        if Rec."Payment Terms Code" <> PurRece."Payment Terms Code" then
                            Error('Please update the Payment Term code as per Purchase Order No. %1, Payment Term code must be same as %2', PurRece."Order No.", PurRece."Payment Terms Code");
                    end;

                    //                    IF ((Rec."Responsibility Center" <> 'FEED') AND (Rec."Responsibility Center" <> 'CATTLE')) AND (Rec."Posting Date" > 20220331D) THEN begin
                    //S.M         Rec.TESTFIELD("Incoming Document Entry No.");
                    DOCAtt.Reset();
                    DOCAtt.SetRange("No.", Rec."No.");
                    if not DOCAtt.FindFirst() then
                        Error('Please attached the document');


                    //       END;
                    CODEUNIT.Run(CODEUNIT::"Purch.-Post", Rec);

                end;
            }
        }

        modify(PostAndPrint)
        {
            Visible = false;
        }

        addafter(PostAndPrint)
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
                    PPIRec: Record "Purch. Inv. Header";
                    GLEntry: Record "G/L Entry";
                    DOCAtt: Record "Document Attachment";
                    PurchaseOrder: Page 50;
                    PurcLIne: Record "Purchase Line";
                    PurRece: Record "Purch. Rcpt. Header";
                begin
                    CompanyInfo.get;
                    orderNo := Rec."No.";
                    UserSetup.RESET;
                    UserSetup.SETRANGE("User ID", USERID);
                    UserSetup.SETFILTER(UserSetup."Access Purchase Invoice", '%1', UserSetup."Access Purchase Invoice"::Edit);
                    IF UserSetup.FINDFIRST THEN
                        ERROR('You do not have Permission to Post Purchase Invoice');
                    //PRU_DD 1.10
                    UserSetup.RESET;
                    UserSetup.SETRANGE("User ID", USERID);
                    UserSetup.SETFILTER(UserSetup."Access Purchase Invoice", '%1', UserSetup."Access Purchase Invoice"::View);
                    IF UserSetup.FINDFIRST THEN
                        ERROR('You do not have Permission to Post Purchase Invoice');
                    //PRU_DD 1.10
                    //                  IF ((Rec."Responsibility Center" <> 'FEED') AND (Rec."Responsibility Center" <> 'CATTLE')) AND (Rec."Posting Date" > 20220331D) THEN begin
                    //               Rec.TESTFIELD("Incoming Document Entry No.");
                    If CompanyInfo.SFPLCompany in [CompanyInfo.SFPLCompany::Sampoorna] then
                        IF Rec."Creditors Type" = 0 THEN
                            ERROR('Please enter the creditor type');

                    PurcLIne.Reset();
                    PurcLIne.SetRange("Document No.", Rec."No.");
                    PurcLIne.Setfilter("No.", '<>%1', '');
                    PurcLIne.Setfilter("Receipt No.", '<>%1', '');
                    if PurcLIne.FindFirst() then begin
                        PurRece.Get(PurcLIne."Receipt No.");

                        if Rec."Payment Terms Code" <> PurRece."Payment Terms Code" then
                            Error('Please update the Payment Term code as per Purchase Order No. %1, Payment Term code must be same as %2', PurRece."Order No.", PurRece."Payment Terms Code");
                    end;

                    if (rec."Shortcut Dimension 1 Code" = 'FEED') and (rec."Shortcut Dimension 1 Code" = 'CATTLE') then
                        Rec.TestField("Brokerage Code");// suman 09-04-2024
                    DOCAtt.Reset();
                    DOCAtt.SetRange("Document Type", Rec."Document Type");
                    DOCAtt.SetRange("Table ID", Database::"Purchase Header");
                    DOCAtt.SetRange("No.", Rec."No.");
                    if not DOCAtt.FindFirst() then
                        //page.RunModal(1173, DOCAtt);
                    Error('Please attached the document');

                    PurchaseOrder.UpdateVendorGST(Rec."Buy-from Vendor No.");
                    //                END;
                    If CompanyInfo.SFPLCompany in [CompanyInfo.SFPLCompany::Sampoorna] then begin
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
                    end else begin

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
                                REPORT.RUNMODAL(REPORT::"Posted Voucher", false, TRUE, GLEntry);
                        end;

                    end;
                end;
            }
        }
    }
    trigger OnAfterGetRecord()
    begin

        SetLocGSTRegNoEditable;
    end;

    trigger OnOpenPage()
    var
    Begin
        FieldVisible := true;
        CompanyInfo.Get;
        If CompanyInfo.SFPLCompany = CompanyInfo.SFPLCompany::"Star Foods" then
            FieldVisible := false;

    End;

    trigger OnDeleteRecord(): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Purchase Invoice", '%1', UserSetup."Access Purchase Invoice"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You can not delete the record');
        //PRU_DD 1.10
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Purchase Invoice", '%1', UserSetup."Access Purchase Invoice"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10
    end;

    trigger OnModifyRecord(): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Purchase Invoice", '%1', UserSetup."Access Purchase Invoice"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You can not modify the record');
        //PRU_DD 1.10
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Purchase Invoice", '%1', UserSetup."Access Purchase Invoice"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10
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

    local procedure SpecialChr(ExtDocNo: Text[25])
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
        Pos30: Integer;
        LineCount: Integer;
        Test0001: Label 'You can not enter vendor invoice no. more than 16 character.';
        PurchaseHeaderlocal: Record 38;
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
        CLEAR(Pos30);


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
        //Pos30 := STRPOS(ExtDocNo,'');

        IF (Pos1 > 0) OR (Pos2 > 0) OR (Pos3 > 0) OR (Pos4 > 0) OR (Pos5 > 0) OR (Pos6 > 0) OR (Pos7 > 0) OR (Pos8 > 0) OR (Pos9 > 0) OR (Pos10 > 0)
          OR (Pos11 > 0) OR (Pos12 > 0) OR (Pos13 > 0) OR (Pos14 > 0) OR (Pos15 > 0) OR (Pos16 > 0) OR (Pos17 > 0) OR (Pos18 > 0) OR (Pos19 > 0) OR (Pos20 > 0)
          OR (Pos21 > 0) OR (Pos22 > 0) OR (Pos23 > 0) OR (Pos24 > 0) OR (Pos25 > 0) OR (Pos26 > 0) OR (Pos27 > 0) OR (Pos28 > 0) OR (Pos29 > 0) THEN
            ERROR('Special character Not Allowed');
        LineCount := STRLEN(ExtDocNo);
        IF Rec."GST Vendor Type" = Rec."GST Vendor Type"::Registered THEN
            IF LineCount > 16 THEN
                ERROR(Test0001);
    end;

    var
        myInt: Integer;

        PurchLine: Record "Purchase Line";
        UserSetup: Record 91;
        GSTLocRegNo: Boolean;
        IsRateChangeEnabled: Boolean;
        ReferenceInvoiceNoErr: Label 'You cannot select Non GST document to GST Docment.';
        ReferenceNoErr: Label 'Reference Invoice No is  required where Invoice Type is Debit Note and Supplementary.';
        PurchaseHeader: Record 38;
        PostingDate: Date;
        PurchaseOrder: Page 50;
        PurchSetup: Record 312;
        Location: Record 14;
        LookMode: Boolean;
        CompanyInfo: Record "Company Information";
        FieldVisible: Boolean;



    LOCAL procedure Post(PostingCodeunitID: Integer)
    begin
        Rec.SendToPosting(PostingCodeunitID);
        IF Rec."Job Queue Status" = Rec."Job Queue Status"::"Scheduled for Posting" THEN
            CurrPage.CLOSE;
        CurrPage.UPDATE(FALSE);
    end;

}