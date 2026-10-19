report 50121 "Re-Apply Item Appl. Entries"
{
    ApplicationArea = All;
    Caption = 'Re-Apply Item Appl. Entries';
    UsageCategory = Administration;
    ProcessingOnly = true;
    dataset
    {

    }
    requestpage
    {
        SaveValues = True;
        layout
        {
            area(Content)
            {
                group(Filters)
                {
                    field(FromDate; FromDate)
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the starting date for the period in which you want to re-apply item application entries.';
                    }
                    field(ToDate; ToDate)
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the ending date for the period in which you want to re-apply item application entries.';
                    }
                    field(ItemNo; ItemNo)
                    {
                        ApplicationArea = All;
                        TableRelation = Item;
                        ToolTip = 'Specifies the item number for which you want to re-apply item application entries.';
                        trigger OnValidate()
                        var
                            ItemRec: Record Item;
                        begin
                            if ItemNo <> '' then
                                if not ItemRec.Get(ItemNo) then
                                    Error('The Item No. %1 does not exist.', ItemNo);
                        end;
                    }
                    field(LocationCode; LocationCode)
                    {
                        ApplicationArea = All;
                        TableRelation = "Location";
                        ToolTip = 'Specifies the location code for which you want to re-apply item application entries.';
                        trigger OnValidate()
                        var
                            LocationRec: Record Location;
                        begin
                            // if LocationCode <> '' then
                            //     if not LocationRec.Get(LocationCode) then
                            //         Error('The Location Code %1 does not exist.', LocationCode);
                        end;
                    }

                }
            }
        }
    }



    var
        ItemLedgerEntry: Record "Item Ledger Entry";
        RecordToShow: Record "Item Ledger Entry";
        TempOriginalItemLedgEntry: Record "Item Ledger Entry" temporary;
        TempItemLedgEntry: Record "Item Ledger Entry" temporary;
        TempUnapplyItem: Record Item temporary;
        Apply: Codeunit "Item Jnl.-Post Line";
        ShowApplied: Boolean;
        ShowQuantity: Boolean;
        MaxToApply: Decimal;
        ApplQty: Decimal;
        Qty: Decimal;
        TotalApplied: Decimal;
        Text001: Label 'Applied Entries';
        Text002: Label 'Unapplied Entries';
        RemoveAppButtonVisible: Boolean;
        ItemNo: Code[20];
        LocationCode: Code[100];
        FromDate: Date;
        ToDate: Date;
        Window: Dialog;
        TotalCount: Integer;
        CurrentCount: Integer;
        ErrItemNo: Label 'Please specify an Item No. to re-apply item application entries.';
        ErrFromDate: Label 'Please specify a From Date to re-apply item application entries.';
        ErrToDate: Label 'Please specify a To Date to re-apply item application entries.';
        ErrFromDateGreater: Label 'The From Date must be earlier than or equal to the To Date.';


    trigger OnPreReport()
    begin
        if ItemNo = '' then
            Error(ErrItemNo);

        if FromDate = 0D then
            Error(ErrFromDate);
        if ToDate = 0D then
            Error(ErrToDate);
        if FromDate > ToDate then
            Error(ErrFromDateGreater);
    end;


    trigger OnPostReport()
    begin
        if not TempOriginalItemLedgEntry.IsTemporary then
            Error('This report cannot be run in the background.');

        Window.Open('#1##############################\\@2@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@');
        ItemLedgerEntry.Reset();
        ItemLedgerEntry.SetLoadFields("Posting Date", "Item No.",
        "Location Code", "Variant Code", "Entry Type", Positive, Open,
        "Remaining Quantity", "Shipped Qty. Not Returned", "Entry No.", "Applied Entry to Adjust", "Applies-to Entry");
        ItemLedgerEntry.SetRange("Item No.", ItemNo);
        if LocationCode <> '' then
            ItemLedgerEntry.Setfilter("Location Code", LocationCode);
        ItemLedgerEntry.SetRange("Posting Date", FromDate, ToDate);
        ItemLedgerEntry.SetFilter("Entry Type", '%1|%2|%3',
            ItemLedgerEntry."Entry Type"::Sale,
            ItemLedgerEntry."Entry Type"::Consumption,
            ItemLedgerEntry."Entry Type"::"Negative Adjmt.");

        ItemLedgerEntry.SetFilter(ItemLedgerEntry."Document Type", '%1|%2|%3|%4|%5|%6|%7',
            ItemLedgerEntry."Document Type"::" ",
            ItemLedgerEntry."Document Type"::"Purchase Return Shipment",
            ItemLedgerEntry."Document Type"::"Purchase Credit Memo",
            ItemLedgerEntry."Document Type"::"Sales Invoice",
            ItemLedgerEntry."Document Type"::"Sales Shipment",
            ItemLedgerEntry."Document Type"::"Sales Return Receipt",
            ItemLedgerEntry."Document Type"::"Sales Credit Memo");

        //ItemLedgerEntry.SetRange("Entry No.", 10341, 10342);
        // Count total entries for progress bar
        TotalCount := ItemLedgerEntry.Count;
        CurrentCount := 0;

        //unapply all entries
        if ItemLedgerEntry.FindSet() then
            repeat
                CurrentCount += 1;
                Window.Update(1, StrSubstNo('Unapplying entries for Item No. %1', ItemLedgerEntry."Item No."));
                Window.Update(2, CurrentCount);

                Clear(Apply);
                Apply.SetCalledFromApplicationWorksheet(true);
                SetRecordToShow(ItemLedgerEntry, Apply, true);
                if not TempOriginalItemLedgEntry.IsEmpty then begin
                    Window.Update(1, StrSubstNo('Re-applying entries for Item No. %1', ItemLedgerEntry."Item No."));
                    UnapplyRec();
                    InsertUnapplyItem(ItemLedgerEntry."Item No.");
                    ReapplyTouchedEntries();
                end;
            until ItemLedgerEntry.Next() = 0;
        Window.Close();
    end;


    local procedure InsertUnapplyItem(ItemNo: Code[20])
    begin
        if not TempUnapplyItem.Get(ItemNo) then begin
            TempUnapplyItem.Init();
            TempUnapplyItem."No." := ItemNo;
            TempUnapplyItem.Insert();
        end;
    end;

    local procedure UnblockItems()
    var
        Item: Record Item;
    begin
        if TempUnapplyItem.FindSet() then
            repeat
                Item.Get(TempUnapplyItem."No.");
                if Item."Application Wksh. User ID" = UpperCase(UserId) then begin
                    Item."Application Wksh. User ID" := '';
                    Item.Modify();
                end;
            until TempUnapplyItem.Next() = 0;

        TempUnapplyItem.DeleteAll();
    end;

    local procedure ReapplyTouchedEntries()
    begin
        Apply.RestoreTouchedEntries(TempUnapplyItem);

        if Apply.AnyTouchedEntries() then begin
            UnblockItems();
            Reapplyall();
        end;
    end;

    local procedure Reapplyall()
    begin
        Apply.RedoApplications();
        Apply.CostAdjust();
        Apply.ClearApplicationLog();
    end;

    procedure SetRecordToShow(var RecordToSet: Record "Item Ledger Entry"; var ApplyCodeunit: Codeunit "Item Jnl.-Post Line"; newShowApplied: Boolean)
    begin
        RecordToShow.Copy(RecordToSet);
        Apply := ApplyCodeunit;
        ShowApplied := newShowApplied;

        Show();
    end;

    local procedure Show()
    var
        ItemLedgEntry: Record "Item Ledger Entry";
        Apprec: Record "Item Application Entry";
    begin
        ItemLedgEntry.Get(RecordToShow."Entry No.");
        ShowQuantity := not ((ItemLedgEntry."Entry Type" in [ItemLedgEntry."Entry Type"::Sale, ItemLedgEntry."Entry Type"::Consumption, ItemLedgEntry."Entry Type"::Output]) and ItemLedgEntry.Positive);

        MaxToApply := 0;
        if not ShowQuantity then
            MaxToApply := ItemLedgEntry.Quantity + Apprec.Returned(ItemLedgEntry."Entry No.");
        SetMyView(RecordToShow, ShowApplied, ShowQuantity, MaxToApply);
    end;

    local procedure SetMyView(ItemLedgEntry: Record "Item Ledger Entry"; ShowApplied: Boolean; ShowQuantity: Boolean; MaxToApply: Decimal)
    var
        IncludeEntry: Boolean;
    begin
        InitView();
        case ShowQuantity of
            true:
                case ShowApplied of
                    true:
                        ShowQuantityApplied(ItemLedgEntry);
                    false:
                        begin
                            ShowQuantityOpen(ItemLedgEntry);
                            ShowCostOpen(ItemLedgEntry, MaxToApply);
                        end;
                end;
            false:
                case ShowApplied of
                    true:
                        ShowCostApplied(ItemLedgEntry);
                    false:
                        ShowCostOpen(ItemLedgEntry, MaxToApply);
                end;
        end;

        if TempItemLedgEntry.FindSet() then
            repeat
                IncludeEntry := true;
                if TempItemLedgEntry."Entry Type" = TempItemLedgEntry."Entry Type"::Transfer then
                    IncludeEntry := TempItemLedgEntry."Document Type" <> TempItemLedgEntry."Document Type"::"Transfer Shipment";
                if IncludeEntry then begin
                    TempOriginalItemLedgEntry.Init();
                    TempOriginalItemLedgEntry := TempItemLedgEntry;
                    TempOriginalItemLedgEntry.Insert();
                end;
            until TempItemLedgEntry.Next() = 0;
    end;

    local procedure InitView()
    begin
        TempOriginalItemLedgEntry.DeleteAll();
        TempItemLedgEntry.Reset();
        TempItemLedgEntry.DeleteAll();
    end;

    local procedure ShowQuantityApplied(ItemLedgEntry: Record "Item Ledger Entry")
    var
        ItemApplnEntry: Record "Item Application Entry";
    begin
        InitApplied();
        if ItemLedgEntry.Positive then begin
            ItemApplnEntry.Reset();
            ItemApplnEntry.SetCurrentKey("Inbound Item Entry No.", "Outbound Item Entry No.", "Cost Application");
            ItemApplnEntry.SetRange("Inbound Item Entry No.", ItemLedgEntry."Entry No.");
            ItemApplnEntry.SetFilter("Outbound Item Entry No.", '<>%1&<>%2', ItemLedgEntry."Entry No.", 0);
            if ItemApplnEntry.Find('-') then
                repeat
                    InsertTempEntry(ItemApplnEntry."Outbound Item Entry No.", ItemApplnEntry.Quantity, true);
                until ItemApplnEntry.Next() = 0;
        end else begin
            ItemApplnEntry.Reset();
            ItemApplnEntry.SetCurrentKey("Outbound Item Entry No.", "Item Ledger Entry No.", "Cost Application");
            ItemApplnEntry.SetRange("Outbound Item Entry No.", ItemLedgEntry."Entry No.");
            ItemApplnEntry.SetRange("Item Ledger Entry No.", ItemLedgEntry."Entry No.");
            if ItemApplnEntry.Find('-') then
                repeat
                    InsertTempEntry(ItemApplnEntry."Inbound Item Entry No.", -ItemApplnEntry.Quantity, true);
                until ItemApplnEntry.Next() = 0;
        end;
    end;

    local procedure ShowQuantityOpen(ItemLedgEntry: Record "Item Ledger Entry")
    var
        ItemApplnEntry: Record "Item Application Entry";
        ItemLedgEntry2: Record "Item Ledger Entry";
    begin
        if ItemLedgEntry."Remaining Quantity" <> 0 then begin
            ItemLedgEntry2.SetCurrentKey("Item No.", Open, "Variant Code", Positive, "Location Code", "Posting Date");
            ItemLedgEntry2.SetRange("Item No.", ItemLedgEntry."Item No.");
            ItemLedgEntry2.SetRange("Location Code", ItemLedgEntry."Location Code");
            ItemLedgEntry2.SetRange(Positive, not ItemLedgEntry.Positive);
            ItemLedgEntry2.SetRange(Open, true);
            if ItemLedgEntry2.Find('-') then
                repeat
                    if (QuantityAvailable(ItemLedgEntry2) <> 0) and
                       not ItemApplnEntry.ExistsBetween(ItemLedgEntry."Entry No.", ItemLedgEntry2."Entry No.")
                    then
                        InsertTempEntry(ItemLedgEntry2."Entry No.", 0, true);
                until ItemLedgEntry2.Next() = 0;
        end;
    end;

    local procedure ShowCostApplied(ItemLedgEntry: Record "Item Ledger Entry")
    var
        ItemApplnEntry: Record "Item Application Entry";
    begin
        InitApplied();
        if ItemLedgEntry.Positive then begin
            ItemApplnEntry.Reset();
            ItemApplnEntry.SetCurrentKey("Inbound Item Entry No.", "Outbound Item Entry No.", "Cost Application");
            ItemApplnEntry.SetRange("Inbound Item Entry No.", ItemLedgEntry."Entry No.");
            ItemApplnEntry.SetFilter("Item Ledger Entry No.", '<>%1', ItemLedgEntry."Entry No.");
            ItemApplnEntry.SetFilter("Outbound Item Entry No.", '<>%1', 0);
            ItemApplnEntry.SetRange("Cost Application", true);
            // we want to show even average cost application
            if ItemApplnEntry.Find('-') then
                repeat
                    InsertTempEntry(ItemApplnEntry."Outbound Item Entry No.", ItemApplnEntry.Quantity, false);
                until ItemApplnEntry.Next() = 0;
        end else begin
            ItemApplnEntry.Reset();
            ItemApplnEntry.SetCurrentKey("Outbound Item Entry No.", "Item Ledger Entry No.", "Cost Application");
            ItemApplnEntry.SetRange("Outbound Item Entry No.", ItemLedgEntry."Entry No.");
            ItemApplnEntry.SetFilter("Item Ledger Entry No.", '<>%1', ItemLedgEntry."Entry No.");
            ItemApplnEntry.SetRange("Cost Application", true);
            // we want to show even average cost application
            if ItemApplnEntry.Find('-') then
                repeat
                    InsertTempEntry(ItemApplnEntry."Inbound Item Entry No.", -ItemApplnEntry.Quantity, false);
                until ItemApplnEntry.Next() = 0;
        end;
    end;

    local procedure ShowCostOpen(ItemLedgEntry: Record "Item Ledger Entry"; MaxToApply: Decimal)
    var
        ItemApplnEntry: Record "Item Application Entry";
        ItemLedgEntry2: Record "Item Ledger Entry";
    begin
        ItemLedgEntry2.SetCurrentKey("Item No.", Positive, "Location Code", "Variant Code");
        ItemLedgEntry2.SetRange("Item No.", ItemLedgEntry."Item No.");
        ItemLedgEntry2.SetRange("Location Code", ItemLedgEntry."Location Code");
        ItemLedgEntry2.SetRange(Positive, not ItemLedgEntry.Positive);
        ItemLedgEntry2.SetFilter("Shipped Qty. Not Returned", '<%1&>=%2', 0, -MaxToApply);
        if (MaxToApply <> 0) and ItemLedgEntry.Positive then
            ItemLedgEntry2.SetFilter("Shipped Qty. Not Returned", '<=%1', -MaxToApply);
        if ItemLedgEntry2.Find('-') then
            repeat
                if (CostAvailable(ItemLedgEntry2) <> 0) and
                   not ItemApplnEntry.ExistsBetween(ItemLedgEntry."Entry No.", ItemLedgEntry2."Entry No.")
                then
                    InsertTempEntry(ItemLedgEntry2."Entry No.", 0, true);
            until ItemLedgEntry2.Next() = 0;
    end;

    local procedure InsertTempEntry(EntryNo: Integer; AppliedQty: Decimal; ShowQuantity: Boolean)
    var
        ItemLedgEntry: Record "Item Ledger Entry";
        IsHandled: Boolean;
    begin
        ItemLedgEntry.Get(EntryNo);

        IsHandled := false;
        if IsHandled then
            exit;

        if ShowQuantity then
            if AppliedQty * ItemLedgEntry.Quantity < 0 then
                exit;

        if not TempItemLedgEntry.Get(EntryNo) then begin
            TempItemLedgEntry.Reset();
            TempItemLedgEntry := ItemLedgEntry;
            TempItemLedgEntry.CalcFields("Reserved Quantity");
            TempItemLedgEntry.Quantity := AppliedQty;
            TempItemLedgEntry.Insert();
        end else begin
            TempItemLedgEntry.Quantity := TempItemLedgEntry.Quantity + AppliedQty;
            TempItemLedgEntry.Modify();
        end;

        TotalApplied := TotalApplied + AppliedQty;
    end;

    local procedure InitApplied()
    begin
        Clear(TotalApplied);
    end;

    local procedure RemoveApplications(Inbound: Integer; OutBound: Integer)
    var
        Application: Record "Item Application Entry";
    begin
        Application.SetCurrentKey("Inbound Item Entry No.", "Outbound Item Entry No.");
        Application.SetRange("Inbound Item Entry No.", Inbound);
        Application.SetRange("Outbound Item Entry No.", OutBound);
        if Application.FindSet() then
            repeat
                Apply.UnApply(Application);
                Apply.LogUnapply(Application);
            until Application.Next() = 0;
    end;

    local procedure UnapplyRec()
    var
        Applyrec: Record "Item Ledger Entry";
        AppliedItemLedgEntry: Record "Item Ledger Entry";
    begin
        Applyrec.Get(RecordToShow."Entry No.");
        //TempItemLedgEntry.Copy(TempOriginalItemLedgEntry, true);
        if TempOriginalItemLedgEntry.FindSet() then begin
            repeat
                AppliedItemLedgEntry.Get(TempOriginalItemLedgEntry."Entry No.");
                if AppliedItemLedgEntry."Entry No." <> 0 then
                    if Applyrec.Positive then
                        RemoveApplications(Applyrec."Entry No.", AppliedItemLedgEntry."Entry No.")
                    else
                        RemoveApplications(AppliedItemLedgEntry."Entry No.", Applyrec."Entry No.");
            until TempOriginalItemLedgEntry.Next() = 0;

            BlockItem(Applyrec."Item No.");
        end;
        // Show();
    end;

    procedure ApplyRec()
    var
        Applyrec: Record "Item Ledger Entry";
        AppliedItemLedgEntry: Record "Item Ledger Entry";
    begin
        Applyrec.Get(RecordToShow."Entry No.");
        TempItemLedgEntry.Copy(TempOriginalItemLedgEntry, true);
        if TempItemLedgEntry.FindSet() then
            repeat
                AppliedItemLedgEntry.Get(TempItemLedgEntry."Entry No.");
                if AppliedItemLedgEntry."Entry No." <> 0 then begin
                    Apply.ReApply(Applyrec, AppliedItemLedgEntry."Entry No.");
                    Apply.LogApply(Applyrec, AppliedItemLedgEntry);
                end;
            until TempItemLedgEntry.Next() = 0;

        if Applyrec.Positive then
            RemoveDuplicateApplication(Applyrec."Entry No.");

        Show();
    end;

    local procedure RemoveDuplicateApplication(ItemLedgerEntryNo: Integer)
    var
        ItemApplicationEntry: Record "Item Application Entry";
    begin
        ItemApplicationEntry.SetCurrentKey("Inbound Item Entry No.", "Item Ledger Entry No.", "Outbound Item Entry No.", "Cost Application");
        ItemApplicationEntry.SetRange("Inbound Item Entry No.", ItemLedgerEntryNo);
        ItemApplicationEntry.SetRange("Item Ledger Entry No.", ItemLedgerEntryNo);
        ItemApplicationEntry.SetFilter("Outbound Item Entry No.", '<>0');
        if not ItemApplicationEntry.IsEmpty() then begin
            ItemApplicationEntry.SetRange("Outbound Item Entry No.", 0);
            ItemApplicationEntry.DeleteAll();
        end
    end;

    local procedure BlockItem(ItemNo: Code[20])
    var
        Item: Record Item;
        IsHandled: Boolean;
    begin
        IsHandled := false;
        if IsHandled then
            exit;

        Item.Get(ItemNo);
        if Item."Application Wksh. User ID" <> UpperCase(UserId) then
            Item.CheckBlockedByApplWorksheet();

        Item."Application Wksh. User ID" := UserId;
        Item.Modify(true);
    end;

    local procedure GetApplQty()
    var
        ItemLedgEntry: Record "Item Ledger Entry";
    begin
        ItemLedgEntry.Get(TempOriginalItemLedgEntry."Entry No.");
        ApplQty := TempOriginalItemLedgEntry.Quantity;
        Qty := ItemLedgEntry.Quantity;
    end;

    local procedure QuantityAvailable(ILE: Record "Item Ledger Entry"): Decimal
    begin
        ILE.CalcFields("Reserved Quantity");
        exit(ILE."Remaining Quantity" - ILE."Reserved Quantity");
    end;

    local procedure CostAvailable(ILE: Record "Item Ledger Entry"): Decimal
    var
        Apprec: Record "Item Application Entry";
    begin
        if ILE."Shipped Qty. Not Returned" <> 0 then
            exit(-ILE."Shipped Qty. Not Returned");

        exit(ILE."Remaining Quantity" + Apprec.Returned(ILE."Entry No."));
    end;

    procedure CaptionExpr(): Text
    begin
        if ShowApplied then
            exit(Text001);

        exit(Text002);
    end;


}
