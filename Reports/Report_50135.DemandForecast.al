report 50135 "DD Forecast"
{
    ApplicationArea = All;
    Caption = 'Demand Forecast New';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    UseRequestPage = true;
    AccessByPermission = tabledata "Production Forecast Entry" = RIMD;
    dataset
    {
        dataitem(Integer; Integer)
        {
            DataItemTableView = where(Number = filter(1));
            trigger OnAfterGetRecord()
            var
                SalInvLine: Record "Sales Invoice Line";
                LastEntryNo: Integer;
                SalInvHdr: Record "Sales Invoice Header";
                ProductionForecastEntry: Record "Production Forecast Entry";

            begin
                // Clear(LastEntryNo);
                Clear(ProdForcastEntry);
                SalInvLine.Reset();
                SalInvLine.SetRange(Type, SalInvLine.Type::Item);
                SalInvLine.SetFilter("Quantity (Base)", '<>%1', 0);
                SalInvLine.SetRange("Posting Date", StartDate, EndDate);
                SalInvLine.SetFilter("Shortcut Dimension 1 Code", '%1|%2', 'FEED', 'CATTLE');
                if LocationFilter <> '' then
                    SalInvLine.SetRange("Location Code", LocationFilter);
                if SalInvLine.FindSet() then begin
                    repeat
                        Clear(LastEntryNo);
                        SalInvHdr.get(SalInvLine."Document No.");
                        if SalInvHdr."Customer Posting Group" <> 'INTER BRANCH TRANSFE' then Begin
                            ProdForcastEntry.Reset();
                            ProdForcastEntry.SetCurrentKey("Entry No.");
                            if ProdForcastEntry.FindLast() then;
                            LastEntryNo := ProdForcastEntry."Entry No." + 1;

                            ProdForcastEntry.Reset();
                            ProdForcastEntry.SetCurrentKey("SalesPerson Code", "Location Code", "Item No.", "Variant Code");
                            ProdForcastEntry.SetRange("Location Code", SalInvLine."Location Code");
                            ProdForcastEntry.SetRange("Item No.", SalInvLine."No.");
                            ProdForcastEntry.SetRange("Variant Code", SalInvLine."Variant Code");
                            ProdForcastEntry.SetRange("SalesPerson Code", SalInvHdr."Salesperson Code");
                            if not ProdForcastEntry.FindFirst() then begin
                                ProdForcastEntry.Init();
                                ProdForcastEntry."Entry No." := LastEntryNo;
                                ProductionForecastEntry."Forecast Date" := SalInvLine."Posting Date";
                                ProdForcastEntry."Location Code" := SalInvLine."Location Code";
                                ProdForcastEntry."Variant Code" := SalInvLine."Variant Code";
                                ProdForcastEntry."Item No." := SalInvLine."No.";
                                ProdForcastEntry."Forecast Quantity" := SalInvLine."Quantity (Base)"; //Actual Qty
                                ProdForcastEntry."Production Forecast Name" := ForecastFilter;
                                ProdForcastEntry."SalesPerson Code" := SalInvHdr."Salesperson Code";
                                // ProdForcastEntry."SalesPerson Code" := '';
                                ProdForcastEntry.Insert(false);
                            end else begin
                                ProdForcastEntry."Forecast Quantity" += SalInvLine."Quantity (Base)"; //Actual Qty
                                ProdForcastEntry.Modify(false);
                            end;
                        End;
                    until SalInvLine.Next() = 0;
                end;

                ProductionForecastEntry.Reset();
                ProductionForecastEntry.SetRange("Production Forecast Name", ForecastFilter);
                ProductionForecastEntry.SetRange("Forecast Date", StartDate, EndDate);
                if LocationFilter <> '' then
                    ProductionForecastEntry.SetRange("Location Code", LocationFilter);
                if ProductionForecastEntry.FindSet() then begin
                    repeat
                        Clear(LastEntryNo);
                        ProdForcastEntry.Reset();
                        ProdForcastEntry.SetCurrentKey("Entry No.");
                        if ProdForcastEntry.FindLast() then;
                        LastEntryNo := ProdForcastEntry."Entry No." + 1;

                        ProdForcastEntry.Reset();
                        ProdForcastEntry.SetCurrentKey("SalesPerson Code", "Location Code", "Item No.", "Variant Code");
                        ProdForcastEntry.SetRange("Location Code", ProductionForecastEntry."Location Code");
                        ProdForcastEntry.SetRange("Item No.", ProductionForecastEntry."Item No.");
                        ProdForcastEntry.SetRange("Variant Code", ProductionForecastEntry."Variant Code");
                        ProdForcastEntry.SetRange("SalesPerson Code", ProductionForecastEntry."Salesperson Code");
                        if not ProdForcastEntry.FindFirst() then begin
                            ProdForcastEntry.Init();
                            ProdForcastEntry."Entry No." := LastEntryNo;
                            ProductionForecastEntry."Forecast Date" := ProductionForecastEntry."Forecast Date";
                            ProdForcastEntry."Location Code" := ProductionForecastEntry."Location Code";
                            ProdForcastEntry."Variant Code" := ProductionForecastEntry."Variant Code";
                            ProdForcastEntry."Item No." := ProductionForecastEntry."Item No.";
                            ProdForcastEntry."Forecast Quantity (Base)" := ProductionForecastEntry."Forecast Quantity (Base)"; //Budgeted Qty
                            ProdForcastEntry."Production Forecast Name" := ForecastFilter;
                            ProdForcastEntry."SalesPerson Code" := ProductionForecastEntry."Salesperson Code";
                            ProdForcastEntry.Insert(false);
                        end else begin
                            ProdForcastEntry."Forecast Quantity (Base)" += ProductionForecastEntry."Forecast Quantity (Base)"; //Budgeted Qty
                            ProdForcastEntry.Modify(false);
                        end;
                    until ProductionForecastEntry.Next() = 0;
                end;
            end;

            trigger OnPostDataItem()
            var
                TempExcelBuffer: Record "Excel Buffer" temporary;
                SheetNameLbl: Label 'Commercial Sales';// Sheet Name
                ExcelFileName: Label 'Commercial Sales_%1_%2'; //Excel File Name
                LastLocCode: Code[50];
                LastSPCode: Code[50];
                TotalProj: Decimal;
                TotalActual: Decimal;
                SPTotalProj: Decimal;
                SPTotalActual: Decimal;
                GTotalProj: Decimal;
                GTotalActual: Decimal;
                i: Integer;
            begin
                //Clear Buffer
                TempExcelBuffer.Reset();
                TempExcelBuffer.DeleteAll();

                ProdForcastEntry.Reset();
                ProdForcastEntry.SetCurrentKey("SalesPerson Code", "Location Code", "Item No.", "Variant Code");
                // ProdForcastEntry.SetRange("Forecast Date", StartDate, EndDate);
                // ProdForcastEntry.SetRange("Production Forecast Name", ForecastFilter);
                if ProdForcastEntry.FindFirst then begin

                    // if ProdForcastEntry."Entry No." <> 0 then
                    AddHeader(TempExcelBuffer);
                    Clear(LastLocCode);
                    Clear(LastSPCode);
                    repeat
                        i += 1;
                        if i <> 1 then
                            if LastLocCode <> ProdForcastEntry."Location Code" then begin
                                AddTotalLine(TotalProj, TotalActual, False, TempExcelBuffer, LastSPCode, false, LastLocCode);
                                Clear(TotalActual);
                                Clear(TotalProj);
                            end;
                        if i <> 1 then
                            if LastSPCode <> ProdForcastEntry."SalesPerson Code" then begin
                                AddTotalLine(SPTotalProj, SPTotalActual, false, TempExcelBuffer, LastSPCode, true, LastLocCode);
                                Clear(SPTotalActual);
                                Clear(SPTotalProj);
                            end;
                        AddLines(ProdForcastEntry, TempExcelBuffer, TotalProj, TotalActual, GTotalProj, GTotalActual, SPTotalProj, SPTotalActual);
                        LastLocCode := ProdForcastEntry."Location Code";
                        LastSPCode := ProdForcastEntry."SalesPerson Code";
                    until ProdForcastEntry.Next() = 0;
                    AddTotalLine(SPTotalProj, SPTotalActual, false, TempExcelBuffer, LastSPCode, true, LastLocCode);
                    AddTotalLine(TotalProj, TotalActual, False, TempExcelBuffer, LastSPCode, false, LastLocCode);
                    AddTotalLine(GTotalProj, GTotalActual, True, TempExcelBuffer, '', false, LastLocCode);
                    TempExcelBuffer.CreateNewBook(SheetNameLbl);
                    TempExcelBuffer.WriteSheet(SheetNameLbl, CompanyName, UserId);
                    TempExcelBuffer.CloseBook();
                    TempExcelBuffer.SetFriendlyFilename(StrSubstNo(ExcelFileName, CurrentDateTime, UserId));
                    TempExcelBuffer.OpenExcel();
                end;
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    field(StartDate; StartDate)
                    {
                        Caption = 'Start Date';
                        ApplicationArea = All;
                    }
                    field(EndDate; EndDate)
                    {
                        Caption = 'End Date';
                        ApplicationArea = All;
                        trigger OnValidate()
                        begin
                            if EndDate < StartDate then
                                Error('End Date cannot be lower than Start Date');
                        end;
                    }
                    field(ForecastFilter; ForecastFilter)
                    {
                        Caption = 'Forecast Code';
                        ApplicationArea = All;
                        TableRelation = "Production Forecast Name";
                    }
                    field(LocationFilter; LocationFilter)
                    {
                        Caption = 'Location Code';
                        ApplicationArea = All;
                        TableRelation = Location;
                    }
                    field(SalesPersonFilter; SalesPersonFilter)
                    {
                        Caption = 'SalesPerson Code';
                        ApplicationArea = All;
                        TableRelation = "Salesperson/Purchaser";
                    }

                }
            }
        }
    }
    trigger OnPreReport()
    begin
        if StartDate = 0D then
            Error('Start Date cannot be Blank');
        if EndDate = 0D then
            Error('End Date cannot be Blank');
        if EndDate < StartDate then
            Error('End Date cannot be lower than Start Date');
    end;


    var
        ProdForcastEntry: Record "Production Forecast Entry" temporary;
        Item: Record Item;
        ItemName: Text;
        StartDate: Date;
        EndDate: Date;
        SPCode: Code[50];
        SPName: Text;
        ForecastFilter: Code[20];
        LocationFilter: Code[50];
        SalesPersonFilter: Code[50];

    local procedure AddHeader(var TempExcelBuffer: Record "Excel Buffer");
    var

    begin
        TempExcelBuffer.NewRow();//Row 1
        TempExcelBuffer.NewRow();//Row 2
        TempExcelBuffer.AddColumn('COMMERCIAL SALES PROJECTION V/s ACTUAL FROM ' + Format(StartDate) + ' To ' + Format(EndDate), false, '', True, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.NewRow();
        TempExcelBuffer.AddColumn('SalesPerson Name', false, '', True, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Team', false, '', True, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Location Code', false, '', True, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Item No.', false, '', True, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Item Name', false, '', True, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Projected Quantity', false, '', True, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Actual Quantity', false, '', True, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Difference', false, '', True, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Difference (in %)', false, '', True, false, false, '', TempExcelBuffer."Cell Type"::Text);
    end;

    local procedure AddLines(RecProdForecastEntry: Record "Production Forecast Entry"; var TempExcelBuffer: Record "Excel Buffer"; var TotalProj: Decimal; Var TotalActual: Decimal; var GTotalProj: Decimal; var GTotalActual: Decimal; var SPTotalProj: Decimal; Var SPTotalActual: Decimal);
    var
        SalesPerson: Record "Salesperson/Purchaser";
        Item: Record Item;
        Diff: Decimal;
        DiffPercent: Decimal;
        Team: Record "Team Salesperson";
        TeamCode: Text;
    begin
        Clear(SalesPerson);
        Clear(Item);
        Clear(Diff);
        Clear(DiffPercent);
        Clear(TeamCode);
        if RecProdForecastEntry."SalesPerson Code" <> '' then
            SalesPerson.Get(RecProdForecastEntry."SalesPerson Code");
        Team.Reset();
        Team.SetRange("Salesperson Code", RecProdForecastEntry."SalesPerson Code");
        if Team.FindFirst() then
            TeamCode := Team."Team Code";

        Item.Get(RecProdForecastEntry."Item No.");
        Diff := (RecProdForecastEntry."Forecast Quantity" - RecProdForecastEntry."Forecast Quantity (Base)");
        if RecProdForecastEntry."Forecast Quantity (Base)" <> 0 then
            DiffPercent := (Diff / RecProdForecastEntry."Forecast Quantity (Base)") * 100;
        TempExcelBuffer.NewRow();
        TempExcelBuffer.AddColumn(SalesPerson.Name, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(TeamCode, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(RecProdForecastEntry."Location Code", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(RecProdForecastEntry."Item No.", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(Item.Description, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(RecProdForecastEntry."Forecast Quantity (Base)", false, '', false, false, false, '0.00', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn(RecProdForecastEntry."Forecast Quantity", false, '', false, false, false, '0.00', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn(Diff, false, '', false, false, false, '0.00', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn(DiffPercent, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
        TotalProj += ProdForcastEntry."Forecast Quantity (Base)";
        TotalActual += ProdForcastEntry."Forecast Quantity";
        GTotalActual += ProdForcastEntry."Forecast Quantity";
        GTotalProj += ProdForcastEntry."Forecast Quantity (Base)";
        SPTotalProj += ProdForcastEntry."Forecast Quantity (Base)";
        SPTotalActual += ProdForcastEntry."Forecast Quantity";
    end;

    local procedure AddTotalLine(TotalProjected: Decimal; TotalActual: Decimal; GrandTotal: Boolean; var TempExcelBuffer: Record "Excel Buffer"; SPCode: code[50]; SPTotal: Boolean; LocCode: Code[50])
    var
        SalesPerson: Record "Salesperson/Purchaser";
        Diff: Decimal;
        DiffPercent: Decimal;
    begin
        Diff := (TotalActual - TotalProjected);
        if TotalProjected <> 0 then
            DiffPercent := (Diff / TotalProjected) * 100;
        if SPCode <> '' then
            SalesPerson.Get(SPCode);

        TempExcelBuffer.NewRow();
        if not GrandTotal and not SPTotal then begin
            TempExcelBuffer.AddColumn('', false, '', True, false, false, '', TempExcelBuffer."Cell Type"::Text);
            TempExcelBuffer.AddColumn(LocCode + ' - Total', false, '', True, false, false, '', TempExcelBuffer."Cell Type"::Text);
        end else begin
            If SPTotal then
                TempExcelBuffer.AddColumn(SalesPerson.Name + ' - Total', false, '', True, false, false, '', TempExcelBuffer."Cell Type"::Text)
            else
                if GrandTotal then
                    TempExcelBuffer.AddColumn('Grand Total', false, '', True, false, false, '', TempExcelBuffer."Cell Type"::Text);
            TempExcelBuffer.AddColumn('', false, '', True, false, false, '', TempExcelBuffer."Cell Type"::Text);
        end;
        TempExcelBuffer.AddColumn('', false, '', True, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('', false, '', True, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(TotalProjected, false, '', True, false, false, '0.00', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn(TotalActual, false, '', True, false, false, '0.00', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn(Diff, false, '', True, false, false, '0.00', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn(DiffPercent, false, '', True, false, false, '', TempExcelBuffer."Cell Type"::Number);
    end;
}