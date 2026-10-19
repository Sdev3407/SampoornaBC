report 50095 "Modify Itemsiuds"
{
    Caption = 'Inventory Ageing';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;

    RDLCLayout = 'ReportLayout\StockAgingSuman.rdl';


    dataset
    {
        dataitem(Item; Item)
        {
            CalcFields = Inventory;

            column(ItemNo; "No.")
            {
                IncludeCaption = true;
            }
            column(Description; Description)
            {
                IncludeCaption = true;
            }
            column(Location_Filter; Location_Filter)
            { }
            column(AsofDate; FORMAT(AsofDate, 0, '<Day,2>/<Month,2>/<Year4>')) { }
            column(NoofPeriods; NoofPeriods) { }
            column(MonthsPerPeriod; MonthsPerPeriod) { }
            column(UOM; "Base Unit of Measure") { }
            column(Qty; Inventory) { }
            dataitem(Integer; Integer)
            {
                DataItemTableView = SORTING(Number) Order(Ascending);
                column(col_Array; Number) { }
                column(StartDateCol; PeriodstartDate.Get(Number)) { }
                column(EndDateCol; PeriodendDate.Get(Number)) { }
                column(StartDayCol; Heading) { }//ABS(PeriodstartDay.Get(Number))) { }
                column(EndDayCol; Abs(PeriodendDay.Get(Number))) { }
                column(QuantityVar; QuantityVar) { }
                column(Flag; Flag) { }
                trigger OnPreDataItem()
                begin
                    SetRange(Number, 1, NoofPeriods);
                    Flag := false;
                end;

                trigger OnAfterGetRecord()
                begin
                    if Integer.Number <> Integer.Count then begin
                        Clear(QuantityVar);
                        ILE.Reset();
                        ILE.SetRange("Item No.", Item."No.");
                        if "Location_Filter" <> '' then
                            ILE.Setfilter("Location Code", "Location_Filter");
                        ILE.SetFilter("Posting Date", '%1..%2', PeriodEndDate.Get(Integer.Number), PeriodStartDate.Get(Integer.Number));
                        ILE.CalcSums(Ile."Remaining Quantity");
                        //IF ILE.FindFirst() then
                        //   repeat
                        QuantityVar += ILE."Remaining Quantity";
                        // until ILE.Next() = 0;
                        Heading := Format(ABS(PeriodstartDay.Get(Number))) + '-' + Format(ABS(PeriodEndDay.Get(Number)));
                    end else begin
                        Clear(QuantityVar);
                        ILE.Reset();
                        ILE.SetRange("Item No.", Item."No.");
                        if "Location_Filter" <> '' then
                            ILE.Setfilter("Location Code", "Location_Filter");
                        ILE.SetFilter("Posting Date", '..%1', PeriodstartDate.Get(Integer.Number));
                        ILE.CalcSums(Ile."Remaining Quantity");
                        // IF ILE.FindFirst() then
                        //     repeat
                        QuantityVar += ILE."Remaining Quantity";
                        //until ILE.Next() = 0;
                        Heading := Format(ABS(PeriodstartDay.Get(Number))) + ' More';
                        Flag := true;
                    end;
                end;
            }

            trigger OnPreDataItem()
            var
                myInt: Integer;
            begin
                Item.Setfilter("Location Filter", Location_Filter);
                Item.SetFilter("Net Change", '<>%1', 0);
                Item.SetRange(Type, Item.Type::Inventory);
                ;
            end;
        }

    }

    requestpage
    {
        SaveValues = true;
        layout
        {
            area(Content)
            {
                group(General)
                {
                    field(AsofDate; AsofDate)
                    {
                        ApplicationArea = All;
                        Caption = 'As of Date';
                        ToolTip = 'As of Date';
                        Editable = False;
                    }

                    field(MonthsPerPeriod; MonthsPerPeriod)
                    {
                        ApplicationArea = All;
                        Caption = 'Period';
                        ToolTip = 'Period';
                    }
                    field(NoofPeriods; NoofPeriods)
                    {
                        ApplicationArea = All;
                        Caption = 'Column Length';
                        ToolTip = 'Column Length';
                    }
                    field("Location Filter"; Location_Filter)
                    {
                        ApplicationArea = All;

                        ToolTip = 'Apply Location filter';
                    }
                }
            }

        }
        actions
        {
        }
        trigger OnOpenPage()
        begin
            AsofDate := WorkDate();
        end;

    }



    trigger OnPreReport()
    begin
        If (AsofDate = 0D) OR (NoofPeriods = 0) OR (Format(MonthsPerPeriod) = '') then
            Error('Please input Values');

        CalculateDateArrays();
        CalculateDayArrays();
    end;

    local procedure CalculateDateArrays()
    var
        LocalDateFormula: DateFormula;
        LoopCnt: Integer;
        LocalDate: Date;
        DateForumlaTxt: text;
    begin
        DateForumlaTxt := '<-' + Format(MonthsPerPeriod) + '>';
        Evaluate(LocalDateFormula, DateForumlaTxt);

        PeriodstartDate.Add(AsofDate);
        LocalDate := AsofDate;
        PeriodEndDate.Add(CalcDate(LocalDateFormula, LocalDate));
        // PeriodstartDay.Add(0);
        repeat
            LocalDate := CalcDate(LocalDateFormula, LocalDate - 1);
            PeriodstartDate.Add(LocalDate);
            PeriodEndDate.Add(CalcDate(LocalDateFormula, LocalDate));
            // PeriodEndDay.Add(LocalDate - AsofDate);
            // PeriodstartDay.Add(LocalDate - AsofDate);
            LoopCnt += 1;
        until (LoopCnt >= NoofPeriods);
        PeriodEndDate.Add(CalcDate(LocalDateFormula, LocalDate));
    end;

    local procedure CalculateDayArrays()
    var
        LocalDateFormula: DateFormula;
        LoopCnt: Integer;
        LocalDate: Date;
        DateForumlaTxt: text;
    begin
        DateForumlaTxt := '<-' + Format(MonthsPerPeriod) + '>';
        Evaluate(LocalDateFormula, DateForumlaTxt);

        LocalDate := AsofDate;
        PeriodstartDay.Add(0);
        repeat
            LocalDate := CalcDate(LocalDateFormula, LocalDate);
            PeriodEndDay.Add(LocalDate - AsofDate);
            PeriodstartDay.Add(LocalDate - AsofDate - 1);
            LoopCnt += 1;
        until (LoopCnt >= NoofPeriods);
    end;

    var
        ILE: Record "Item Ledger Entry";
        AsofDate: Date;
        QuantityVar: Decimal;
        NoofPeriods: Integer;
        MonthsPerPeriod: DateFormula;
        PeriodstartDate: List of [Date];
        PeriodEndDate: List of [Date];
        PeriodstartDay: List of [Integer];
        PeriodEndDay: List of [Integer];
        Flag: Boolean;
        Heading: Text;
        Location_Filter: Code[100];


    procedure Reportfilter(FAsOnDate: Date; FPeriod: Integer; FMonthperperiod: DateFormula; FLOcationFilter: Code[100])
    begin
        Location_Filter := FLOcationFilter;
        MonthsPerPeriod := FMonthperperiod;
        NoofPeriods := FPeriod;
        AsofDate := FAsOnDate;
    end;

}