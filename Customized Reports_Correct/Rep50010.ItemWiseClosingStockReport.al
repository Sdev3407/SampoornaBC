report 50010 "Item Wise Closing Stock Report"
{
    ApplicationArea = All;
    Caption = 'Item Wise Closing Stock Report(Detailed Entry Wise)';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    DataAccessIntent = ReadOnly;

    dataset
    {
        dataitem(ItemLedgerEntry; "Item Ledger Entry")
        {
            DataItemTableView = sorting("Item No.", "Posting Date");

            trigger OnPreDataItem()
            begin
                ItemLedgerEntry.SetRange("Entry No.", 0);
                FillExcelHeader();
            end;

            trigger OnPostDataItem()
            begin
                RunItemLocationProcessing();

                if ExcelBuf.FindFirst() then begin
                    ExcelBuf.CreateNewBook('Closing Stock');
                    ExcelBuf.WriteSheet('Item Wise Closing Stock', CompanyName(), UserId());
                    ExcelBuf.CloseBook();
                    ExcelBuf.OpenExcel();
                end else
                    Message('No data found for the selected filters.');
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(Options)
                {
                    Caption = 'Options';

                    field(AsOnDate; AsOnDate)
                    {
                        ApplicationArea = All;
                        Caption = 'As On Date';
                        ToolTip = 'Specifies the date up to which the closing stock is calculated.';
                    }

                    field(LocationFilter; LocationFilter)
                    {
                        ApplicationArea = All;
                        Caption = 'Location Filter';
                        ToolTip = 'Specifies the location(s) to filter. Use | to separate multiple e.g. LOC-A|LOC-B. Leave blank for all.';
                        TableRelation = "Location".Code;
                    }

                    field(ItemFilter; ItemFilter)
                    {
                        ApplicationArea = All;
                        Caption = 'Item Filter';
                        ToolTip = 'Specifies the item(s) to filter. Use | to separate multiple e.g. ITEM-A|ITEM-B. Leave blank for all.';
                        TableRelation = "Item"."No.";
                    }
                }
            }
        }
    }

    var
        CompanyInfo: Record "Company Information";
        ExcelBuf: Record "Excel Buffer" temporary;
        AsOnDate: Date;
        LocationFilter: Text;
        ItemFilter: Text;
        PeriodText: Text;

        DictRemainingQty: Dictionary of [Text, Decimal];
        DictRemainingValue: Dictionary of [Text, Decimal];

        DictCostAmount: Dictionary of [Integer, Decimal];
        DictAppQty: Dictionary of [Integer, Decimal];

        Loc: Record Location;

    trigger OnInitReport()
    begin
        CompanyInfo.Get();
    end;

    trigger OnPreReport()
    begin
        ExcelBuf.DeleteAll();
        Clear(PeriodText);
    end;

    local procedure BuildRemainingQtyDict()
    var
        ILE: Record "Item Ledger Entry";
        DictKey: Text;
        ExistingVal: Decimal;
    begin
        Clear(DictRemainingQty);

        ILE.Reset();
        ILE.SetCurrentKey("Item No.", "Location Code", "Posting Date");
        ILE.SetLoadFields("Item No.", "Location Code", Quantity, "Posting Date");
        if ItemFilter <> '' then
            ILE.SetFilter("Item No.", ItemFilter);
        if LocationFilter <> '' then
            ILE.SetFilter("Location Code", LocationFilter);
        if AsOnDate <> 0D then
            ILE.SetFilter("Posting Date", '..%1', AsOnDate);

        if ILE.FindSet() then
            repeat
                DictKey := ILE."Item No." + '|' + ILE."Location Code";
                ExistingVal := 0;
                if DictRemainingQty.Get(DictKey, ExistingVal) then
                    DictRemainingQty.Set(DictKey, ExistingVal + ILE.Quantity)
                else
                    DictRemainingQty.Add(DictKey, ILE.Quantity);
            until ILE.Next() = 0;
    end;

    local procedure BuildValueEntryDicts()
    var
        VE: Record "Value Entry";
        DictKey: Text;
        ExistingLocVal: Decimal;
        ExistingEntryVal: Decimal;
    begin
        Clear(DictRemainingValue);
        Clear(DictCostAmount);

        VE.Reset();
        VE.SetCurrentKey("Item No.", "Posting Date");
        VE.SetLoadFields("Item No.", "Location Code", "Item Ledger Entry No.", "Cost Amount (Actual)", "Posting Date");
        if ItemFilter <> '' then
            VE.SetFilter("Item No.", ItemFilter);
        if LocationFilter <> '' then
            VE.SetFilter("Location Code", LocationFilter);
        if AsOnDate <> 0D then
            VE.SetFilter("Posting Date", '..%1', AsOnDate);

        if VE.FindSet() then
            repeat
                DictKey := VE."Item No." + '|' + VE."Location Code";

                ExistingLocVal := 0;
                if DictRemainingValue.Get(DictKey, ExistingLocVal) then
                    DictRemainingValue.Set(DictKey, ExistingLocVal + VE."Cost Amount (Actual)")
                else
                    DictRemainingValue.Add(DictKey, VE."Cost Amount (Actual)");

                ExistingEntryVal := 0;
                if DictCostAmount.Get(VE."Item Ledger Entry No.", ExistingEntryVal) then
                    DictCostAmount.Set(VE."Item Ledger Entry No.", ExistingEntryVal + VE."Cost Amount (Actual)")
                else
                    DictCostAmount.Add(VE."Item Ledger Entry No.", VE."Cost Amount (Actual)");
            until VE.Next() = 0;
    end;

    local procedure BuildAppQtyDict()
    var
        ItemAppEntry: Record "Item Application Entry";
        ExistingVal: Decimal;
    begin
        Clear(DictAppQty);

        ItemAppEntry.Reset();
        ItemAppEntry.SetCurrentKey("Inbound Item Entry No.");
        ItemAppEntry.SetLoadFields("Inbound Item Entry No.", Quantity, "Posting Date");
        if AsOnDate <> 0D then
            ItemAppEntry.SetFilter("Posting Date", '..%1', AsOnDate);

        if ItemAppEntry.FindSet() then
            repeat
                ExistingVal := 0;
                if DictAppQty.Get(ItemAppEntry."Inbound Item Entry No.", ExistingVal) then
                    DictAppQty.Set(ItemAppEntry."Inbound Item Entry No.", ExistingVal + ItemAppEntry.Quantity)
                else
                    DictAppQty.Add(ItemAppEntry."Inbound Item Entry No.", ItemAppEntry.Quantity);
            until ItemAppEntry.Next() = 0;
    end;

    local procedure RunItemLocationProcessing()
    var
        ILE: Record "Item Ledger Entry";
        DictKey: Text;
        TotalQty: Decimal;
        TotalRemValue: Decimal;
    begin
        BuildRemainingQtyDict();
        BuildValueEntryDicts();
        BuildAppQtyDict();

        ILE.Reset();
        ILE.SetCurrentKey("Item No.", "Location Code", "Posting Date");
        ILE.SetLoadFields(
            "Entry No.", "Posting Date", "Document No.", "Entry Type",
            "Item No.", Description, Quantity,
            "Global Dimension 1 Code", "Global Dimension 2 Code", "Location Code");
        if ItemFilter <> '' then
            ILE.SetFilter("Item No.", ItemFilter);
        if LocationFilter <> '' then
            ILE.SetFilter("Location Code", LocationFilter);
        if AsOnDate <> 0D then
            ILE.SetFilter("Posting Date", '..%1', AsOnDate);
        ILE.SetFilter(Quantity, '>0');

        if ILE.FindSet() then
            repeat
                DictKey := ILE."Item No." + '|' + ILE."Location Code";
                TotalQty := 0;
                TotalRemValue := 0;
                DictRemainingQty.Get(DictKey, TotalQty);
                DictRemainingValue.Get(DictKey, TotalRemValue);

                if (TotalQty > 0) or (TotalRemValue > 0) then
                    WriteILERow(ILE, TotalQty, TotalRemValue);
            until ILE.Next() = 0;
    end;

    local procedure WriteILERow(ILE: Record "Item Ledger Entry"; TotalQty: Decimal; TotalRemValue: Decimal)
    var
        CostAmountVal: Decimal;
        RemainingQtyVal: Decimal;
        RemainingAmountVal: Decimal;
        RemainingUnitCostVal: Decimal;
    begin
        if not DictCostAmount.Get(ILE."Entry No.", CostAmountVal) then
            CostAmountVal := 0;

        if not DictAppQty.Get(ILE."Entry No.", RemainingQtyVal) then
            RemainingQtyVal := 0;

        if TotalQty <> 0 then
            RemainingAmountVal := RemainingQtyVal * (CostAmountVal / ILE.Quantity);

        if (RemainingQtyVal = 0) and (RemainingAmountVal = 0) then
            exit;

        if RemainingQtyVal <> 0 then
            RemainingUnitCostVal := RemainingAmountVal / RemainingQtyVal
        else
            RemainingUnitCostVal := 0;

        Loc.get(ILE."Location Code");

        ExcelBuf.NewRow();
        ExcelBuf.AddColumn(ILE."Posting Date", false, '', false, false, false, 'DD/MM/YYYY', ExcelBuf."Cell Type"::Date);
        ExcelBuf.AddColumn(ILE."Document No.", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(Format(ILE."Entry Type"), false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(ILE."Item No.", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(ILE."Item Name", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(ILE.Quantity, false, '', false, false, false, '#,##0.00', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(CostAmountVal, false, '', false, false, false, '#,##0.00', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(RemainingUnitCostVal, false, '', false, false, false, '#,##0.00', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(RemainingQtyVal, false, '', false, false, false, '#,##0.00', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(RemainingAmountVal, false, '', false, false, false, '#,##0.00', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(ILE."Global Dimension 1 Code", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(ILE."Global Dimension 2 Code", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(ILE."Location Code", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(Loc.Name, false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(ILE."Entry No.", false, '', false, false, false, '', ExcelBuf."Cell Type"::Number);
    end;

    local procedure FillExcelHeader()
    var
        ItemFilterTxt: Text;
        LocationFilterTxt: Text;
    begin
        ItemFilterTxt := ItemFilter;
        if ItemFilterTxt = '' then
            ItemFilterTxt := 'All';

        LocationFilterTxt := LocationFilter;
        if LocationFilterTxt = '' then
            LocationFilterTxt := 'All';

        ExcelBuf.NewRow();
        ExcelBuf.AddColumn(CompanyInfo.Name, false, '', true, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow();
        ExcelBuf.AddColumn('Item Wise Closing Stock Report', false, '', true, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow();
        ExcelBuf.AddColumn('Period: ' + PeriodText, false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow();
        ExcelBuf.AddColumn('Item Filter: ' + ItemFilterTxt, false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow();
        ExcelBuf.AddColumn('Location Filter: ' + LocationFilterTxt, false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow();
        ExcelBuf.NewRow();
        ExcelBuf.AddColumn('Posting Date', false, '', true, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Document No.', false, '', true, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Entry Type', false, '', true, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Item No.', false, '', true, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Item Name', false, '', true, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Quantity', false, '', true, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Cost Amount', false, '', true, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Remaining Unit Cost', false, '', true, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Remaining Qty', false, '', true, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Remaining Amount', false, '', true, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('LOB Code', false, '', true, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Branch Code', false, '', true, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Location Code', false, '', true, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Location Name', false, '', true, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Entry No.', false, '', true, false, false, '', ExcelBuf."Cell Type"::Text);
    end;
}