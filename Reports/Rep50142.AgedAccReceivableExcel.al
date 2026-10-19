namespace Sampoorna_BC.Sampoorna_BC;
using Microsoft.Sales.Customer;
using Microsoft.Sales.Receivables;
using System.IO;
using Microsoft.CRM.Team;

report 50142 AgedAccReceivableExcel
{
    ApplicationArea = All;
    Caption = 'AgedAccReceivableExcel';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    dataset
    {
        dataitem("Team Salesperson"; "Team Salesperson")
        {
            DataItemTableView = sorting("Team Type", "Team Code", "Salesperson Code") order(ascending) where("Salesperson Code" = filter(<> ''), "Team Type" = filter(<> "Team Type"::" "));
            // RequestFilterFields = "Salesperson Code", "Team Code";
            dataitem(Customer; Customer)
            {
                DataItemLink = "Salesperson Code" = field("Salesperson Code");

                trigger OnAfterGetRecord()
                begin
                    Clear(TotAmt);
                    ExportLines(SheetName);
                end;

                trigger OnPostDataItem()
                begin

                end;

                trigger OnPreDataItem()
                begin
                    Customer.SetRange("Date Filter", 0D, EndingDate);
                    Customer.SetLoadFields("No.", Name, "Responsibility Center", "Customer Status", "Credit Limit (LCY)", "Salesperson Code", "Date Filter");
                    Customer.SetFilter("Team Type", '<>%1', Customer."Team Type"::" ");
                end;
            }
            trigger OnAfterGetRecord()
            var
                Reccust: Record Customer;
                SplitSheet: Boolean;
            begin
                Clear(SplitSheet);
                Teams.Get("Team Salesperson"."Team Code");
                if "Team Type" = "Team Type"::Poultry then
                    SplitSheet := true;
                if SplitSheet then begin
                    if SheetName = 'Cattle' then begin
                        AddtotalLine();
                        CreateExcelSheet(SheetName);
                        ClearRowTotAmt();
                    end;
                    if NewPagePerTeam then begin
                        if OldTeamCode <> "Team Code" then begin
                            if OldTeamCode <> '' then begin
                                AddtotalLine();
                                CreateExcelSheet(SheetName);
                                ClearRowTotAmt();
                            end;
                            // if teams.Code = 'WUP' then
                            //     Message('WUP');
                            SheetName := Teams.Name;
                            ExportHeader(SheetName);
                        end;
                        OldTeamCode := "Team Code";
                    end;
                end else begin
                    if "Team Type" = "Team Type"::Cattle then begin
                        if SheetName <> Format("Team Type") then
                            ExportHeader(Format("Team Type"));
                        SheetName := Format("Team Type");
                    end;
                end;
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(AgedAsOf; EndingDate)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Aged As Of';
                        ToolTip = 'Specifies the date that you want the aging calculated for.';
                    }
                    field(Agingby; AgingBy)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Aging by';
                        OptionCaption = ',Posting Date,';
                        ToolTip = 'Specifies if the aging will be calculated from the due date, the posting date, or the document date.';
                    }
                    field(PeriodLength; PeriodLength)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Period Length';
                        ToolTip = 'Specifies the period for which data is shown in the report. For example, enter "1M" for one month, "30D" for thirty days, "3Q" for three quarters, or "5Y" for five years.';
                    }
                    field(TotalNoofDays; TotalNoofDays)
                    {
                        Caption = 'Total No. Of Days';
                        ApplicationArea = All;
                    }

                    field(HeadingType; HeadingType)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Heading Type';
                        OptionCaption = ',Number of Days';
                        ToolTip = 'Specifies if the column heading for the three periods will indicate a date interval or the number of days overdue.';
                    }
                    field(perteam; NewPagePerTeam)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'New Page per Team';
                        ToolTip = 'Specifies if each Team''s information is printed on a new page if you have chosen two or more team to be included in the report.';
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            if EndingDate = 0D then
                EndingDate := WorkDate();
            if Format(PeriodLength) = '' then
                Evaluate(PeriodLength, '<1M>');
        end;
    }
    trigger OnPreReport()
    begin
        CalcDates();
        CreateHeadings();
        ExcelBuffer.CreateNewBook('Sheet1');
        if not NewPagePerTeam then begin
            SheetName := 'Aged_Acc_Receivable';
            ExportHeader(SheetName);
        end;
    end;

    trigger OnPostReport()
    begin
        if not NewPagePerTeam then begin
            AddtotalLine();
            CreateExcelSheet('Aged_Acc_Receivable');
        end else begin

            AddtotalLine();
            CreateExcelSheet(SheetName);
        end;

        ExcelBuffer.DeleteWorksheet('Sheet1');
        CreateExcelFile;
    end;

    procedure ExportHeader(SheetName: Text);
    begin
        ExcelBuffer.NewRow();
        ExcelBuffer.AddColumn('Cus No.', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Cus Name', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        //ExcelBuffer.AddColumn('Res Centre', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        //ExcelBuffer.AddColumn('Cus Status', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        //ExcelBuffer.AddColumn('Team Name', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Sales Person', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        //ExcelBuffer.AddColumn('Mkt No', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);


        i := 1;
        for i := 1 to Arraylength do begin
            ExcelBuffer.AddColumn(HeaderText[i], false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);

            // ExcelBuffer.AddColumn(HeaderText[2], false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
            // ExcelBuffer.AddColumn(HeaderText[3], false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
            // ExcelBuffer.AddColumn(HeaderText[4], false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
            // ExcelBuffer.AddColumn(HeaderText[5], false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        end;
        ExcelBuffer.AddColumn('Grand Total', FALSE, '', TRUE, FALSE, FALSE, '@', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Cr Limit', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Customer Status', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
    end;

    procedure ExportLines(SheetName: Text);
    var
        SalesPerson: Record "Salesperson/Purchaser";

    begin
        if GetTotalcustomerAmountLCY() then
            exit;

        ExcelBuffer.NewRow();
        ExcelBuffer.AddColumn(Customer."No.", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(Customer.Name, false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
        //ExcelBuffer.AddColumn(Customer."Responsibility Center", false, '', False, false, false, '', ExcelBuffer."Cell Type"::Text);
        //ExcelBuffer.AddColumn(Format(Customer."Customer Status"), false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
        //ExcelBuffer.AddColumn(Teams.Name, false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
        SalesPerson.Get(Customer."Salesperson Code");
        ExcelBuffer.AddColumn(SalesPerson.Name, false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
        //ExcelBuffer.AddColumn('Mkt No', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);

        i := 1;
        For i := 1 to Arraylength do begin
            Clear(RowAmt);
            RowAmt := GetcustomerAmountLCY(i);
            RowTotAmt[i] += RowAmt;
            ExcelBuffer.AddColumn(RowAmt, false, '', false, false, false, '', ExcelBuffer."Cell Type"::Number);
        end;
        // ExcelBuffer.AddColumn(GetcustomerAmountLCY(2), false, '', true, false, false, '', ExcelBuffer."Cell Type"::Number);
        // ExcelBuffer.AddColumn(GetcustomerAmountLCY(3), false, '', true, false, false, '', ExcelBuffer."Cell Type"::Number);
        // ExcelBuffer.AddColumn(GetcustomerAmountLCY(4), false, '', true, false, false, '', ExcelBuffer."Cell Type"::Number);
        // ExcelBuffer.AddColumn(GetcustomerAmountLCY(5), false, '', true, false, false, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn(TotAmt, false, '', false, false, false, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn(Customer."Credit Limit (LCY)", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn(Customer."Customer Status", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
    end;

    procedure AddtotalLine()
    var
        myInt: Integer;
        GrandtotalSUM: Decimal;
    begin
        ExcelBuffer.NewRow();
        ExcelBuffer.AddColumn('', false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Total', false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
        //ExcelBuffer.AddColumn(Customer."Responsibility Center", false, '', False, false, false, '', ExcelBuffer."Cell Type"::Text);
        //ExcelBuffer.AddColumn(Format(Customer."Customer Status"), false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
        //ExcelBuffer.AddColumn(Teams.Name, false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
        //ExcelBuffer.AddColumn('Mkt No', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);

        i := 1;
        For i := 1 to Arraylength do begin
            ExcelBuffer.AddColumn(RowTotAmt[i], false, '', false, false, false, '', ExcelBuffer."Cell Type"::Number);
            GrandtotalSUM += RowTotAmt[i];
        end;
        // ExcelBuffer.AddColumn(GetcustomerAmountLCY(2), false, '', true, false, false, '', ExcelBuffer."Cell Type"::Number);
        // ExcelBuffer.AddColumn(GetcustomerAmountLCY(3), false, '', true, false, false, '', ExcelBuffer."Cell Type"::Number);
        // ExcelBuffer.AddColumn(GetcustomerAmountLCY(4), false, '', true, false, false, '', ExcelBuffer."Cell Type"::Number);
        // ExcelBuffer.AddColumn(GetcustomerAmountLCY(5), false, '', true, false, false, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn(GrandtotalSUM, false, '', false, false, false, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn('', false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
    end;

    local procedure CalcDates()
    var
        PeriodLength2: DateFormula;


    begin
        if not Evaluate(PeriodLength2, StrSubstNo(Text032Txt, PeriodLength)) then
            Error(EnterDateFormulaErr);
        Clear(Arraylength);
        Arraylength := Round((TotalNoofDays / (CalcDate(PeriodLength, Today) - Today)), 1, '>') + 1;
        if AgingBy = AgingBy::"Due Date" then begin
            PeriodEndDate[1] := DMY2Date(31, 12, 9999);
            PeriodStartDate[1] := EndingDate + 1;
        end else begin
            PeriodEndDate[1] := EndingDate;
            PeriodStartDate[1] := CalcDate(PeriodLength2, EndingDate + 1);
        end;
        for i := 2 to Arraylength do begin
            PeriodEndDate[i] := PeriodStartDate[i - 1] - 1;
            PeriodStartDate[i] := CalcDate(PeriodLength2, PeriodEndDate[i] + 1);
        end;
        PeriodStartDate[i] := 0D;

        for i := 1 to Arraylength do begin
            Clear(RowTotAmt[i]);
            if PeriodEndDate[i] < PeriodStartDate[i] then
                Error(Text010, PeriodLength);
        end;
    end;

    local procedure CreateHeadings()
    var
        i: Integer;
    begin
        if AgingBy = AgingBy::"Due Date" then begin
            HeaderText[1] := Text000;
            i := 2;
        end else
            i := 1;
        while i < Arraylength do begin
            if HeadingType = HeadingType::"Date Interval" then
                HeaderText[i] := StrSubstNo('%1\..%2', PeriodStartDate[i], PeriodEndDate[i])
            else
                HeaderText[i] :=
                  StrSubstNo('%1 - %2 %3', EndingDate - PeriodEndDate[i] + 1, EndingDate - PeriodStartDate[i] + 1, Text002);
            i := i + 1;
        end;
        if HeadingType = HeadingType::"Date Interval" then
            HeaderText[i] := StrSubstNo('%1 %2', BeforeTok, PeriodStartDate[i - 1])
        else
            HeaderText[i] := StrSubstNo('%1 %2 %3', AfterTok, EndingDate - PeriodStartDate[i - 1] + 1, Text002);
    end;

    procedure GetcustomerAmountLCY(i: Integer): Decimal;
    var
        CustRec: Record Customer;
        CustLedeger: Record "Cust. Ledger Entry";
        CustBalance: Decimal;
    begin
        Clear(CustBalance);
        CustLedeger.Reset();
        CustLedeger.SetLoadFields("Customer No.", "Posting Date", "Remaining Amt. (LCY)", Open);
        CustLedeger.SetRange("Customer No.", Customer."No.");
        CustLedeger.SetRange("Posting Date", PeriodStartDate[i], PeriodEndDate[i]);
        CustLedeger.SetRange(Open, true);
        if CustLedeger.FindSet() then
            repeat
                CustLedeger.CalcFields("Remaining Amt. (LCY)");
                CustBalance += CustLedeger."Remaining Amt. (LCY)";
            // CustRec.Reset();
            // CustRec.get(Customer."No.");
            // CustRec.SetLoadFields("No.", "Date Filter", SFPL_Balance);
            // // CustRec.SetRange("No.", Customer."No.");
            // CustRec.SetRange("Date Filter", PeriodStartDate[i], PeriodEndDate[i]);
            // CustRec.CalcFields(SFPL_Balance);
            // // if CustRec.FindFirst() then;

            until CustLedeger.Next() = 0;
        TotAmt += CustBalance;
        exit(CustBalance);
    end;

    procedure GetTotalcustomerAmountLCY(): Boolean;
    var
        CustRec: Record Customer;
        CustLedeger: Record "Cust. Ledger Entry";
        CustBalance: Decimal;
    begin
        Clear(CustBalance);
        CustLedeger.Reset();
        CustLedeger.SetLoadFields("Customer No.", "Posting Date", "Remaining Amt. (LCY)", Open);
        CustLedeger.SetRange("Customer No.", Customer."No.");
        CustLedeger.SetRange("Posting Date", 0D, EndingDate);
        CustLedeger.SetRange(Open, true);
        if not CustLedeger.FindFirst() then
            exit(True)
        else
            exit(False);
        // CustLedeger.CalcFields("Remaining Amt. (LCY)");
        // CustBalance += CustLedeger."Remaining Amt. (LCY)";
        // CustRec.Reset();
        // CustRec.get(Customer."No.");
        // CustRec.SetLoadFields("No.", "Date Filter", SFPL_Balance);
        // // CustRec.SetRange("No.", Customer."No.");
        // CustRec.SetRange("Date Filter", PeriodStartDate[i], PeriodEndDate[i]);
        // CustRec.CalcFields(SFPL_Balance);
        // // if CustRec.FindFirst() then;
    end;


    procedure CreateExcelSheet(SheetName: Text)
    begin

        ExcelBuffer.SelectOrAddSheet(SheetName);
        ExcelBuffer.WriteSheet(SheetName, CompanyName, UserId);
        ExcelBuffer.DeleteAll();
        ExcelBuffer.ClearNewRow();
    end;

    procedure CreateExcelFile()
    var
    begin
        ExcelBuffer.CloseBook();
        ExcelBuffer.SetFriendlyFilename('Aged Accounts Receivable');
        ExcelBuffer.OpenExcel();
    end;

    procedure ClearRowTotAmt()
    begin
        for i := 1 to Arraylength do begin
            Clear(RowTotAmt[i]);
        end;
    end;

    var
        ExcelBuffer: Record "Excel Buffer" temporary;
        PeriodLength: DateFormula;
        Text032Txt: Label '-%1', Comment = 'Negating the period length: %1 is the period length';
        EndingDate: Date;
        AgingBy: Option "Due Date","Posting Date","Document Date";
        HeadingType: Option "Date Interval","Number of Days";
        NewPagePerTeam: Boolean;
        PeriodStartDate: array[1000] of Date;
        PeriodEndDate: array[1000] of Date;
        HeaderText: array[1000] of Text[30];
        Text000: Label 'Not Due';
        AfterTok: Label 'After';
        BeforeTok: Label 'Before';
        CurrencyCode: Code[10];
        Text002: Label 'days';
        Text010: Label 'The Date Formula %1 cannot be used. Try to restate it. E.g. 1M+CM instead of CM+1M.';
        EnterDateFormulaErr: Label 'Enter a date formula in the Period Length field.';
        OldTeamCode: Code[50];
        SheetName: Text;
        NewBook: Boolean;
        Teams: Record Team;
        TotalNoofDays: Integer;
        Arraylength: Integer;
        i: Integer;
        TotAmt: Decimal;
        RowTotAmt: array[1000] of Decimal;
        RowAmt: Decimal;
}
