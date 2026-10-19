pageextension 50097 PurchaseReturnOrderExt extends "Purchase Return Order"
{
    layout
    {

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

            // trigger OnLookup(var Text: Text): Boolean
            // var
            //     Cust: Record Vendor;
            //     CustList: Page "Vendor List";
            //     UserSetupRec: Record "User Setup";
            // begin
            //     Cust.Reset();
            //     Cust.SetFilter(Cust.Blocked, '%1', Cust.Blocked::" ");
            //     CustList.SETTABLEVIEW(Cust);
            //     CustList.LOOKUPMODE := TRUE;
            //     IF CustList.RUNMODAL = ACTION::LookupOK THEN begin
            //         CustList.GetRecord(Cust);
            //         Rec.Validate("Buy-from Vendor No.", Cust."No.");
            //         CurrPage.Update();
            //         UserSetupRec.Get(UserId);
            //         Rec.VALIDATE("Shortcut Dimension 1 Code", UserSetupRec."Global Dimension 1 Code");
            //         //    Clear(Rec."Shortcut Dimension 2 Code");
            //         Rec.VALIDATE("Shortcut Dimension 2 Code", UserSetupRec."Global Dimension 2 Code");
            //         IF NOT UserSetupRec."User Permission" THEN BEGIN
            //             Rec.VALIDATE("Shortcut Dimension 1 Code", UserSetupRec."Global Dimension 1 Code");
            //             Rec.VALIDATE("Shortcut Dimension 2 Code", UserSetupRec."Global Dimension 2 Code");
            //             IF NOT UserSetupRec."HO Users" THEN BEGIN
            //                 Rec.VALIDATE("Shortcut Dimension 3 Code", UserSetupRec."Shortcut Dimension 3 Code");
            //                 //   Rec.VALIDATE("Location Code", UserSetupRec."Shortcut Dimension 3 Code");
            //                 // Message(UserSetupRec."Shortcut Dimension 3 Code");
            //             END;
            //         end;
            //     END;
            // end;

        }
        // modify("Buy-from Vendor Name")
        // {
        //     trigger OnLookup(var Text: Text): Boolean
        //     var
        //         Cust: Record Vendor;
        //         CustList: Page "Vendor List";
        //         UserSetupRec: Record "User Setup";
        //     begin
        //         Cust.Reset();
        //         Cust.SetFilter(Cust.Blocked, '%1', Cust.Blocked::" ");
        //         CustList.SETTABLEVIEW(Cust);
        //         CustList.LOOKUPMODE := TRUE;
        //         IF CustList.RUNMODAL = ACTION::LookupOK THEN begin
        //             CustList.GetRecord(Cust);
        //             Rec.Validate("Buy-from Vendor No.", Cust."No.");
        //             CurrPage.Update();
        //             UserSetupRec.Get(UserId);
        //             Rec.VALIDATE("Shortcut Dimension 1 Code", UserSetupRec."Global Dimension 1 Code");
        //             //    Clear(Rec."Shortcut Dimension 2 Code");
        //             Rec.VALIDATE("Shortcut Dimension 2 Code", UserSetupRec."Global Dimension 2 Code");
        //             IF NOT UserSetupRec."User Permission" THEN BEGIN
        //                 Rec.VALIDATE("Shortcut Dimension 1 Code", UserSetupRec."Global Dimension 1 Code");
        //                 Rec.VALIDATE("Shortcut Dimension 2 Code", UserSetupRec."Global Dimension 2 Code");
        //                 IF NOT UserSetupRec."HO Users" THEN BEGIN
        //                     Rec.VALIDATE("Shortcut Dimension 3 Code", UserSetupRec."Shortcut Dimension 3 Code");
        //                     //   Rec.VALIDATE("Location Code", UserSetupRec."Shortcut Dimension 3 Code");
        //                     // Message(UserSetupRec."Shortcut Dimension 3 Code");
        //                 END;
        //             end;
        //         END;
        //     end;

        // }

        modify("Vendor Cr. Memo No.")
        {

            trigger OnBeforeValidate()
            begin
                SpecialChr(Rec."Vendor Cr. Memo No.");
            end;

        }
        modify("Location Code")
        {
            Visible = true;
            trigger OnAfterValidate()
            var
                LocRec: Record Location;
                UserSetupRec: Record "User Setup";
                PLRec: Record "Purchase Line";
            begin
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

                    UserSetupRec.Get(UserId);
                    Rec.SetHideValidationDialog(true);
                    IF UserSetupRec."User Permission" THEN BEGIN
                        Location.RESET;
                        Location.SETRANGE(Code, Rec."Location Code");
                        IF Location.FINDFIRST THEN
                            Rec.VALIDATE("Shortcut Dimension 2 Code", Location."Global Dimension 2 Code");
                    END;

                    Rec.VALIDATE("Shortcut Dimension 2 Code");
                    Rec.VALIDATE("Shortcut Dimension 3 Code", Rec."Location Code");

                end;
            END;
        }
        /*addafter("No.")
        {
           
            field("Rate Basis"; Rec."Rate Basis")
            {
                ApplicationArea = All;

            }
            field("Terms Code"; Rec."Terms Code")
            {
                ApplicationArea = All;

            }
            field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
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
        moveafter("Buy-from Vendor No."; "Buy-from Contact No.")
        moveafter("Buy-from Contact No."; "Buy-from Vendor Name")
        moveafter("Buy-from Vendor Name"; "Vendor GST Reg. No.")
        modify("Buy-from Country/Region Code")
        {
            Visible = false;
        }

        modify(BuyFromContactPhoneNo)
        {
            Visible = false;
        }
        modify(BuyFromContactMobilePhoneNo)
        {
            Visible = false;
        }
        modify(BuyFromContactEmail)
        {
            Visible = false;
        }
        moveafter("Buy-from Contact"; "No. of Archived Versions")
        moveafter("No. of Archived Versions"; "Posting Date")
        moveafter("Posting Date"; "Order Date")
        moveafter("Order Date"; "Document Date")
        moveafter("Vendor Cr. Memo No."; "Order Address Code")
        moveafter("Assigned User ID"; "Job Queue Status")
        moveafter(Status; "Reference Invoice No.")
        addafter(Status)
        {
            field("Mandi Name"; Rec."Mandi Name")
            {
                ApplicationArea = All;

            }
            field("File No."; Rec."File No.")
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
            field("Brokerage Calculation Basis"; Rec."Brokerage Calculation Basis")
            {
                ApplicationArea = all;
                
            }
            field("Brokerage Code"; Rec."Brokerage Code")
            {
                ApplicationArea = All;

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
            Visible = false;
        }
        modify("Payment Method Code")
        {
            Visible = false;
        }
        moveafter("Applies-to ID"; "Prices Including VAT")
        moveafter("Prices Including VAT"; "VAT Bus. Posting Group")
        //>>shipping
        modify("Ship-to Country/Region Code")
        {
            Visible = false;
        }
        moveafter("Ship-to Contact"; "Location Code")
        moveafter("Location Code"; "Expected Receipt Date")
        //>>foreign trade
        movebefore("Transaction Type"; "Currency Code")
        movebefore("Transaction Specification"; "Transaction Type")
        addafter("Location Code")
        {
            field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
            {
                ApplicationArea = all;
            }
        }
        //>>tax info
        modify("Invoice Type")
        {
            Visible = false;
        }
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
        // Add changes to page actions here



        modify(Post)
        {



            trigger OnAfterAction()
            begin
                UserSetup.RESET;
                UserSetup.SETRANGE("User ID", USERID);
                UserSetup.SETFILTER(UserSetup."Access Purchase Return Order", '%1', UserSetup."Access Purchase Return Order"::View);
                IF UserSetup.FINDFIRST THEN
                    ERROR('You do not have Permission to Post Purchase Return Order');
                UserSetup.RESET;
                UserSetup.SETRANGE("User ID", USERID);
                UserSetup.SETFILTER(UserSetup."Access Purchase Return Order", '%1', UserSetup."Access Purchase Return Order"::Edit);
                IF UserSetup.FINDFIRST THEN
                    ERROR('You do not have Permission to Post Purchase Return Order');

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
                Visible = true;

                Applicationarea = All;
                trigger OnAction()
                begin

                    UserSetup.RESET;
                    UserSetup.SETRANGE("User ID", USERID);
                    UserSetup.SETFILTER(UserSetup."Access Purchase Return Order", '%1', UserSetup."Access Purchase Return Order"::View);
                    IF UserSetup.FINDFIRST THEN
                        ERROR('You do not have Permission to Post Purchase Return Order');
                    UserSetup.RESET;
                    UserSetup.SETRANGE("User ID", USERID);
                    UserSetup.SETFILTER(UserSetup."Access Purchase Return Order", '%1', UserSetup."Access Purchase Return Order"::Edit);
                    IF UserSetup.FINDFIRST THEN
                        ERROR('You do not have Permission to Post Purchase Return Order');


                    CLEAR(PurchPostYesNo);
                    // PurchPostYesNo.SetSendEmail(TRUE);
                    PurchPostYesNo.Run(Rec);
                end;
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Purchase Return Order", '%1', UserSetup."Access Purchase Return Order"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10
        SetLocGSTRegNoEditable;
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Purchase Return Order", '%1', UserSetup."Access Purchase Return Order"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not  have Permission to Delete Purchase Return Order');
        //PRU_DD 1.10
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Purchase Return Order", '%1', UserSetup."Access Purchase Return Order"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10

        Rec.Validate("Shipment Method Code", 'ROAD');
        Rec.Validate("Vehicle Type", rec."Vehicle Type"::Regular);
    end;

    trigger OnModifyRecord(): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Purchase Return Order", '%1', UserSetup."Access Purchase Return Order"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have Permission to Change Purchase Return Order Details');
        //PRU_DD 1.10
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Purchase Return Order", '%1', UserSetup."Access Purchase Return Order"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10
    end;

    trigger OnOpenPage()
    var
        sdc: Page 18430;
        pa: page 6510;
    begin
        LookMode := false;
        //PRU_DD 1.10
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Purchase Return Order", '%1', UserSetup."Access Purchase Return Order"::" ");
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to open Purchase Return Order');

        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Purchase Return Order", '%1', UserSetup."Access Purchase Return Order"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10
        /*=======*/ //TARGET
        SetLocGSTRegNoEditable;
        /*<<<<<<<*/
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
        LineCount := STRLEN(ExtDocNo);
        IF Rec."GST Vendor Type" = Rec."GST Vendor Type"::Registered THEN
            IF LineCount > 16 THEN
                ERROR(Test0001);
    end;


    var
        myInt: Integer;
        UserSetup: Record 91;
        GSTLocRegNo: Boolean;
        ReferenceInvoiceNoErr: Label 'You cannot select Non GST document to GST Docment.';
        PurchaseHeader: Record 38;
        PostingDate: Date;
        PurchPostYesNo: Codeunit "Purch.-Post (Yes/No)";
        Location: Record 14;
        LookMode: Boolean;

}