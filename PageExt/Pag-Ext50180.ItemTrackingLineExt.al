pageextension 50180 "ItemTrackingLineExt" extends "Item Tracking Lines"
{

    layout
    {
        addbefore(AvailabilityLotNo)
        {
            field("Lot Type"; Rec."Lot Type")
            {
                ApplicationArea = All;
                Visible = Visible;

                trigger OnValidate()
                var
                    Time1: Time;
                    ItemJn: Record "Item Journal Line";
                begin
                    Time1 := Time;
                    if (Rec."Source Type" = 83) And (Rec."Source Subtype" = 6) then
                        If Rec."Lot Type" = Rec."Lot Type"::LB then
                            if (Rec."Source Type" = 83) And (Rec."Source Subtype" = 6) then
                                if (Format(Time1) >= '19:00:00.000') and (Format(Time1) <= '23:59:00.000') then
                                    rec.Validate("Lot Date", (Today() + 1))
                                else
                                    rec.Validate("Lot Date", (Today()));
                end;
            }
            field("Lot Date"; Rec."Lot Date")
            {
                ApplicationArea = All;
                Visible = Visible;
            }
            field("Mfg Date"; Rec."Manufacturing Date")
            {
                ApplicationArea = ItemTracking;
                Editable = ExpirationDateEditable;
                ToolTip = 'Specifies the Manufacturing date, if any, of the item carrying the item tracking number.';
                Visible = false;

                trigger OnValidate()
                begin
                    MarkItemTrackingLinesWithTheSameLotAsModified();
                    CurrPage.Update();
                end;
            }
            field("New Manufacturing Date"; Rec."New Manufacturing Date")
            {
                ApplicationArea = ItemTracking;
                Editable = NewExpirationDateEditable;
                ToolTip = 'Specifies a new eManufacturing date.';
                Visible = NewExpirationDateVisible;
            }

        }

    }
    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        Visible := False;
        CompanyInfo.Get;
        If CompanyInfo.SFPLCompany = CompanyInfo.SFPLCompany::"Star Foods" then
            Visible := true;


    end;

    trigger OnClosePage()
    var
        ItemLedgerEntry: Record "Item Ledger Entry";
        PurchRcptLine: Record "Purch. Rcpt. Line";
        TransferReceiptLine: Record "Transfer Receipt Line";
        Reservation: Record "Reservation Entry";
        TransferHeader: Record "Transfer Header";
        Transferline: Record "Transfer Line";
        FromLocation: Record Location;
        tolocation: Record Location;
        Items: Record Item;
        DocNo: Text;
        TRPrice: Decimal;
        PRPrice: Decimal;
        RecQty: Decimal;
        Price: Decimal;
        i: Integer;
        CompanyInfo: Record "Company Information";
    Begin

        CompanyInfo.Get;

        CLEAR(TRPrice);
        CLEAR(PRPrice);
        i := 0;
        // If rec."Source Type" =5741 then
        // If rec."Source Subtype" =0 then
        // if rec.find
        If CompanyInfo.SFPLCompany in [CompanyInfo.SFPLCompany::Sampoorna] Then
            if (rec."Source Type" = 5741) Then begin
                Reservation.Reset();
                Reservation.SetRange("Source Type", 5741);
                Reservation.SetRange("Source Subtype", 0);
                Reservation.SetRange("Source ID", Rec."Source ID");
                Reservation.SetRange("Item No.", rec."Item No.");
                If Reservation.FindFirst() then
                    TransferHeader.Get(Reservation."Source ID");
                Reservation.SetRange("Location Code", TransferHeader."Transfer-from Code");
                If Reservation.FindFirst() then
                    repeat
                        i += 1;
                        FromLocation.Get(TransferHeader."Transfer-from Code");
                        tolocation.Get(TransferHeader."Transfer-to Code");
                        Transferline.Get(TransferHeader."No.", Reservation."Source Ref. No.");
                        Items.Get(Reservation."Item No.");
                        if FromLocation."State Code" <> tolocation."State Code" then begin
                            if Items.Exempted = false Then Begin
                                Rec.TestField("Appl.-to Item Entry");
                                ItemLedgerEntry.RESET;
                                ItemLedgerEntry.SETRANGE("Location Code", TransferHeader."Transfer-from Code");
                                ItemLedgerEntry.SETRANGE("Item No.", Rec."Item No.");
                                ItemLedgerEntry.SetRange("Unit of Measure Code", Items."Base Unit of Measure");
                                ItemLedgerEntry.SetRange("Entry No.", Rec."Appl.-to Item Entry");
                                ItemLedgerEntry.SETFILTER("Remaining Quantity", '<>%1', 0);
                                //ItemLedgerEntry.SETFILTER("Document Type", '%1|%2', ItemLedgerEntry."Document Type"::"Purchase Receipt", ItemLedgerEntry."Document Type"::"Transfer Receipt");
                                IF ItemLedgerEntry.FINDFIRST THEN
                                    DocNo := ItemLedgerEntry."Document No.";
                                //======================TransferReceiptLine=============
                                //CLEAR(TRPrice);
                                //CLEAR(PRPrice);
                                TransferReceiptLine.RESET;
                                TransferReceiptLine.SETRANGE("Document No.", DocNo);
                                TransferReceiptLine.SETRANGE("Item No.", Rec."Item No.");
                                IF TransferReceiptLine.FINDFIRST THEN
                                    TRPrice += TransferReceiptLine."Unit Price";
                                //===================PurchRcptLine==================
                                PurchRcptLine.RESET;
                                PurchRcptLine.SETRANGE("Document No.", DocNo);
                                PurchRcptLine.SETRANGE("No.", Rec."Item No.");
                                IF PurchRcptLine.FINDFIRST THEN
                                    PRPrice += PurchRcptLine."Unit Cost";

                                if (ItemLedgerEntry."Entry Type" = ItemLedgerEntry."Entry Type"::"Positive Adjmt.") and (ItemLedgerEntry."Entry Type" = ItemLedgerEntry."Entry Type"::Purchase) then begin
                                    ItemLedgerEntry.CalcFields("Cost Amount (Actual)");
                                    PRPrice += (ItemLedgerEntry."Cost Amount (Actual)" / ItemLedgerEntry.Quantity);

                                end;
                            End;
                        End;
                    Until Reservation.Next() = 0;
                Price := (PRPrice + TRPrice);
                If Price <> 0 then begin
                    Transferline.Validate("Transfer Price", (Price / i));
                    Transferline.Modify();
                end;
                // IF TRPrice <> 0 THEN
                //     Rec.VALIDATE("Transfer Price", TRPrice)
                // ELSE
                //     IF PRPrice <> 0 THEN
                //         Rec.VALIDATE("Transfer Price", PRPrice);
            End;
    End;

    local procedure MarkItemTrackingLinesWithTheSameLotAsModified()
    var
        TempTrackingSpecification: Record "Tracking Specification" temporary;
    begin
        TempTrackingSpecification.Copy(Rec);

        Rec.SetFilter("Entry No.", '<>%1', Rec."Entry No.");
        Rec.SetRange("Item No.", Rec."Item No.");
        Rec.SetRange("Variant Code", Rec."Variant Code");
        Rec.SetRange("Lot No.", Rec."Lot No.");
        Rec.SetRange("Buffer Status", 0);
        if Rec.FindSet() then
            repeat
                if TempItemTrackLineModify.Get(Rec."Entry No.") then
                    TempItemTrackLineModify.Delete();
                if TempItemTrackLineInsert.Get(Rec."Entry No.") then begin
                    TempItemTrackLineInsert.TransferFields(Rec);
                    TempItemTrackLineInsert.Modify();
                end else begin
                    TempItemTrackLineModify.TransferFields(Rec);
                    TempItemTrackLineModify.Insert();
                end;
            until Rec.Next() = 0;

        Rec.Copy(TempTrackingSpecification);
    end;


    var
        CompanyInfo: Record "Company Information";
        Visible: Boolean;

}