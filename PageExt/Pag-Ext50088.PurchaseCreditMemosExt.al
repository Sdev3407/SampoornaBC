pageextension 50088 PurchaseCreditMemosExt extends "Purchase Credit Memos"
{
    layout
    {
        moveafter("Vendor Authorization No."; "Posting Date")
        modify("Vendor Cr. Memo No.")
        {
            Visible = false;
        }
        modify("Due Date")
        {
            Visible = false;
        }
        modify(amount)
        {
            Visible = false;
        }







    }

    actions
    {
        modify(Preview)
        {
            trigger OnBeforeAction()
            var
                myInt: Integer;
            begin

            end;
        }
        // Add changes to page actions here
        modify(Post)
        {
            trigger OnBeforeAction()
            begin
                if (rec."Shortcut Dimension 1 Code" = 'FEED') and (rec."Shortcut Dimension 1 Code" = 'CATTLE') then begin
                    Rec.TestField("Brokerage Code");// suman 09-04-2024
                    Rec.TestField("Brokerage Rate");
                end;
                //PruRaj_RQ_0.01
                PL.RESET;
                PL.SETRANGE("Document Type", PL."Document Type"::"Credit Memo");
                PL.SETRANGE("Document No.", Rec."No.");
                PL.SETRANGE(Type, PL.Type::Item);
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
                UserSetup.SETFILTER(UserSetup."Access Purchase Credit Memo", '%1', UserSetup."Access Purchase Credit Memo"::Edit);
                IF UserSetup.FINDFIRST THEN
                    ERROR('You do  not have Permission to Post Purchase Credit Memo');
                //PRU_DD 1.10
                UserSetup.RESET;
                UserSetup.SETRANGE("User ID", USERID);
                UserSetup.SETFILTER(UserSetup."Access Purchase Credit Memo", '%1', UserSetup."Access Purchase Credit Memo"::View);
                IF UserSetup.FINDFIRST THEN
                    ERROR('You do  not have Permission to Post Purchase Credit Memo');
                //PRU_DD 1.10

            end;
        }
    }
    trigger OnDeleteRecord(): Boolean
    begin

        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Purchase Credit Memo", '%1', UserSetup."Access Purchase Credit Memo"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You can not delete the record');
        //PRU_DD 1.10
        ////07062019
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin

        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Purchase Credit Memo", '%1', UserSetup."Access Purchase Credit Memo"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10
        ////07062019
        Rec.Validate("Shipment Method Code", 'ROAD');
        Rec.Validate("Vehicle Type", rec."Vehicle Type"::Regular);
    end;

    trigger OnModifyRecord(): Boolean
    begin

        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Purchase Credit Memo", '%1', UserSetup."Access Purchase Credit Memo"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You can not modify the record');
        //PRU_DD 1.10
        ////07062019
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin

        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Purchase Credit Memo", '%1', UserSetup."Access Purchase Credit Memo"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10
        ////07062019
    end;

    trigger OnOpenPage()
    begin
        Companyinfo.Get;
        //<<PRU_RC
        If CompanyInfo.SFPLCompany = CompanyInfo.SFPLCompany::Sampoorna then begin
            UserSetup.GET(USERID);
            Rec.FILTERGROUP(2);
            Rec.SETFILTER("Shortcut Dimension 1 Code", UserSetup."Global Dimension 1 Code");
            IF NOT UserSetup."HO Users" THEN
                Rec.SETFILTER("Shortcut Dimension 2 Code", UserSetup."Global Dimension 2 Code");
            Rec.SETFILTER("Shortcut Dimension 3 Code", UserSetup."Shortcut Dimension 3 Code");
            Rec.FILTERGROUP(0);
        end;
        //>>RPU_RC

        //PRU_DD 1.10
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Purchase Credit Memo", '%1', UserSetup."Access Purchase Credit Memo"::" ");
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to open Purchase Credit Memo');

        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Purchase Credit Memo", '%1', UserSetup."Access Purchase Credit Memo"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10

    end;


    var
        myInt: Integer;
        UserSetup: Record 91;
        PL: Record 39;
        ILE: Record 32;
        RemQty: Decimal;
        Companyinfo: Record "Company Information";
        RecItem: Record Item;
}