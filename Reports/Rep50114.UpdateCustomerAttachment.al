report 50114 "Update Customer Attachment"
{
    Caption = 'Customer Aging Summary';
    DefaultLayout = RDLC;
    RDLCLayout = 'ReportLayout\CustomerAgingSummary.rdl';
    AdditionalSearchTerms = 'customer balance,payment due';
    ApplicationArea = Basic, Suite;
    UsageCategory = ReportsAndAnalysis;
    DataAccessIntent = ReadOnly;

    dataset
    {
        dataitem(Customer; Customer)
        {
            column(No_Customer; "No.")
            {
            }
            column(Name_Customer; Name)
            {
            }
            column(Salesperson_Code; SalesPersonName)
            { }
            column(Team_Code; TeamName)
            { }
            column(OldVsNewDifference_Customer; OldVsNewDifference)
            {
            }
            column(TotalOldVsNewDifference_Customer; TotalOldVsNewDifference)
            {
            }

            dataitem(TempCustLedgerEntry; "Cust. Ledger Entry")
            {
                UseTemporary = true;
                column(Description_TempCustLedgerEntry; Description)
                {
                }
                column(PostingDate_TempCustLedgerEntry; "Posting Date")
                {
                }
                column(SalesLCY_TempCustLedgerEntry; "Sales (LCY)")
                {
                }
                column(YourReference_TempCustLedgerEntry; "Your Reference")
                {
                }
                column(Title_TempCustLedgerEntry; "Customer Name")
                {
                }

                trigger OnPreDataItem()
                begin
                    SetRange("Customer No.", Customer."No.");
                end;
            }

            trigger OnAfterGetRecord()
            var
                Date_1_Amt: Decimal;
                Date_2_Amt: Decimal;
                HasBalance_Date1: Boolean;
                HasBalance_Date2: Boolean;
            begin
                Clear(SalesPersonName);
                Clear(TeamName);
                OldVsNewDifference := 0;
                InsertTempCustLedgerEntries(Customer, Date_1_StartDt_List, Date_1_EndDt_List, 'Date 1', Date_1_Amt, HasBalance_Date1);
                InsertTempCustLedgerEntries(Customer, Date_2_StartDt_List, Date_2_EndDt_List, 'Date 2', Date_2_Amt, HasBalance_Date2);
                OldVsNewDifference := Date_1_Amt - Date_2_Amt;
                TotalOldVsNewDifference += OldVsNewDifference;

                if not HasBalance_Date1 and not HasBalance_Date2 then
                    CurrReport.Skip();

                RecSalesPer.Reset();
                RecSalesPer.SetRange(Code, Customer."Salesperson Code");
                if RecSalesPer.FindFirst() then
                    SalesPersonName := RecSalesPer.Name;
                Recteam.Reset();
                Recteam.SetRange("Salesperson Code", Customer."Salesperson Code");
                if Recteam.FindFirst() then begin
                    RecSalesTeam.Get(Recteam."Team Code");
                    TeamName := RecSalesTeam.Name;
                end;
            end;

            trigger OnPreDataItem()
            begin
                TotalOldVsNewDifference := 0;
            end;
        }

    }


    requestpage
    {
        layout
        {
            area(content)
            {
                group(Group)
                {
                    field(Date_1_req; Date1)
                    {
                        ApplicationArea = All;
                        Caption = 'Date 1';
                        ToolTip = 'Specifies the first date for the report filter.';
                    }
                    field(Date_2_req; Date2)
                    {
                        ApplicationArea = All;
                        Caption = 'Date 2';
                        ToolTip = 'Specifies the second date for the report filter.';
                    }
                    field(NoOfDays_req; NoOfDays)
                    {
                        ApplicationArea = All;
                        Caption = 'No. of Days';
                        ToolTip = 'Specifies the number of days for the aging period.';
                        trigger OnValidate()
                        var
                            DateExpTxt: Label '<-%1D>', Comment = '%1 is a number of days.';
                            ErrNoOfDaysLbl: Label 'Number of Days must be greater than zero.', Comment = 'Error message for invalid No. of Days.';
                            ErrDate1Lbl: Label 'Please enter a valid Date 1 before specifying Number of Days.', Comment = 'Error message for missing Date 1.';
                            ErrDate2Lbl: Label 'Please enter a valid Date 2 before specifying Number of Days.', Comment = 'Error message for missing Date 2.';
                        begin
                            if NoOfDays <= 0 then
                                Error(ErrNoOfDaysLbl);

                            if Date1 = 0D then
                                Error(ErrDate1Lbl);

                            if Date2 = 0D then
                                Error(ErrDate2Lbl);

                            FromDate_1 := CalcDate(StrSubstNo(DateExpTxt, NoOfDays - 1), Date1);
                            FromDate_2 := CalcDate(StrSubstNo(DateExpTxt, NoOfDays - 1), Date2);
                        end;
                    }
                    field(Frequency_req; Difference)
                    {
                        ApplicationArea = All;
                        Caption = 'Frequency';
                        ToolTip = 'Specifies the frequency for the aging buckets.';
                    }
                }
            }
        }
    }

    trigger OnPreReport()
    var
        DateExpTxt: Label '<-%1D>', Comment = '%1 is a number of days.';
        ErrDate1Lbl: Label 'Please enter a valid Date 1.', Comment = 'Error message for missing Date 1.';
        ErrDate2Lbl: Label 'Please enter a valid Date 2.', Comment = 'Error message for missing Date 2.';
        ErrNoOfDaysLbl: Label 'Number of Days must be greater than zero.', Comment = 'Error message for invalid No. of Days.';
        ErrFrequencyLbl: Label 'Frequency must be greater than zero.', Comment = 'Error message for invalid Frequency.';
        ErrDateOrderLbl: Label 'Date 1 must be greater than or equal to Date 2.', Comment = 'Error message for invalid date order.';
    begin
        if Date1 = 0D then
            Error(ErrDate1Lbl);
        if Date2 = 0D then
            Error(ErrDate2Lbl);

        if Date1 > Date2 then
            Error(ErrDateOrderLbl);

        if NoOfDays <= 0 then
            Error(ErrNoOfDaysLbl);

        if Difference <= 0 then
            Error(ErrFrequencyLbl);
        FromDate_1 := CalcDate(StrSubstNo(DateExpTxt, NoOfDays - 1), Date1);
        FromDate_2 := CalcDate(StrSubstNo(DateExpTxt, NoOfDays - 1), Date2);

        CalculateDates();
    end;

    local procedure InsertTempCustLedgerEntries(Customer: Record Customer; StartDateList1: List of [Date];
                                                EndDateList1: List of [Date]; Option: text;
                                                var BracketAmt: Decimal; var HasBalance: Boolean)
    var
        DtldCustLedgEntry: Record "Detailed Cust. Ledg. Entry";
        FromDt: Date;
        ToDt: Date;
        i: Integer;
        FilterDate: Date;
        Balance: Decimal;
        IsEndingBracket: Boolean;
        DataAsOnDateLbl: Label 'Data as on Date %1', Comment = '%1 is a formatted date.';
        AfterDaysLbl: Label 'After %1 Days', Comment = '%1 is a number of days.';
    begin
        Balance := 0;
        IsEndingBracket := false;
        foreach FromDt in StartDateList1 do begin
            FilterDate := 0D;
            i := StartDateList1.IndexOf(FromDt);
            ToDt := EndDateList1.Get(i);

            IsEndingBracket := ((Option = 'Date 1') and (FromDt < FromDate_1)) or
                                       ((Option = 'Date 2') and (FromDt < FromDate_2));

            if FromDt <> 0D then
                FilterDate := FromDt
            else
                FilterDate := ToDt;

            DtldCustLedgEntry.SetCurrentKey("Customer No.", "Posting Date");
            DtldCustLedgEntry.Reset();
            DtldCustLedgEntry.SetRange("Customer No.", Customer."No.");
            DtldCustLedgEntry.SetRange("Posting Date", FromDt, ToDt);
            DtldCustLedgEntry.CalcSums("Amount (LCY)");

            TempCustLedgerEntry.Init();
            TempCustLedgerEntry.SetRange("Customer No.", Customer."No.");
            TempCustLedgerEntry.SetRange("Posting Date", FilterDate);
            TempCustLedgerEntry.SetRange("Your Reference", Option);
            if not TempCustLedgerEntry.FindFirst() then begin
                EntryNo += 1;
                TempCustLedgerEntry."Entry No." := EntryNo;
                TempCustLedgerEntry."Customer No." := Customer."No.";
                TempCustLedgerEntry."Posting Date" := FilterDate;
                if Option = 'Date 1' then
                    TempCustLedgerEntry."Customer Name" := StrSubstNo(DataAsOnDateLbl, Format(Date1, 0, '<Day,2>/<Month,2>/<Year4>'))
                else
                    TempCustLedgerEntry."Customer Name" := StrSubstNo(DataAsOnDateLbl, Format(Date2, 0, '<Day,2>/<Month,2>/<Year4>'));

                if IsEndingBracket then
                    TempCustLedgerEntry.Description := StrSubstNo(AfterDaysLbl, Format(NoOfDays))
                else begin
                    TempCustLedgerEntry.Description := GetDateText(ToDt, Option);
                    BracketAmt += DtldCustLedgEntry."Amount (LCY)";
                end;
                TempCustLedgerEntry."Sales (LCY)" := DtldCustLedgEntry."Amount (LCY)";
                TempCustLedgerEntry."Your Reference" := CopyStr(Option, 1, MaxStrLen(TempCustLedgerEntry."Your Reference"));
                TempCustLedgerEntry.Insert();
            end else begin
                TempCustLedgerEntry."Sales (LCY)" += DtldCustLedgEntry."Amount (LCY)";
                TempCustLedgerEntry.Modify();
            end;
            Balance += DtldCustLedgEntry."Amount (LCY)";
        end;

        HasBalance := Balance <> 0;
        InsertBalanceEntry(Customer, Balance, Option);
    end;

    local procedure InsertBalanceEntry(Customer: Record Customer; Balance: Decimal; Option: Text)
    var
        BalanceLbl: Label 'Balance', Comment = 'Label for balance entry.';
    begin
        EntryNo += 1;
        TempCustLedgerEntry."Entry No." := EntryNo;
        TempCustLedgerEntry."Customer No." := Customer."No.";
        TempCustLedgerEntry."Posting Date" := 17000101D;
        TempCustLedgerEntry.Description := BalanceLbl;
        TempCustLedgerEntry."Sales (LCY)" := Balance;
        TempCustLedgerEntry."Your Reference" := CopyStr(Option, 1, MaxStrLen(TempCustLedgerEntry."Your Reference"));
        TempCustLedgerEntry.Insert();
    end;


    local procedure CalculateDates()
    var
        StartDate: Date;
        EndDate: Date;
        BucketCount: Integer;
        i: Integer;
        NoOfDaysLbl: label '%1-%2 Days', Comment = '%1 and %2 are number of days.';
    begin
        Clear(Date_1_StartDt_List);
        Clear(Date_2_StartDt_List);
        Clear(Date_1_EndDt_List);
        Clear(Date_2_EndDt_List);

        if (NoOfDays <= 0) or (Difference <= 0) then
            exit;

        if FromDate_1 > 0D then begin
            Date_1_StartDt_List.Add(0D);
            Date_1_EndDt_List.Add(FromDate_1 - 1);
        end;

        BucketCount := NoOfDays div Difference;
        if (NoOfDays mod Difference) <> 0 then
            BucketCount += 1;

        EndDate := Date1;
        for i := 1 to BucketCount do begin
            if i = BucketCount then
                StartDate := FromDate_1
            else
                StartDate := EndDate - Difference + 1;
            if StartDate < FromDate_1 then
                StartDate := FromDate_1;
            Date_1_StartDt_List.Add(StartDate);
            Date_1_EndDt_List.Add(EndDate);
            if i = BucketCount then
                DaysDict.Add(EndDate, StrSubstNo(NoOfDaysLbl, Format(((i - 1) * Difference) + 1), Format(NoOfDays)))
            else
                DaysDict.Add(EndDate, StrSubstNo(NoOfDaysLbl, Format(((i - 1) * Difference) + 1), Format(i * Difference)));
            EndDate := StartDate - 1;
        end;

        if FromDate_2 > 0D then begin
            Date_2_StartDt_List.Add(0D);
            Date_2_EndDt_List.Add(FromDate_2 - 1);
        end;

        EndDate := Date2;
        for i := 1 to BucketCount do begin
            if i = BucketCount then
                StartDate := FromDate_2
            else
                StartDate := EndDate - Difference + 1;
            if StartDate < FromDate_2 then
                StartDate := FromDate_2;
            Date_2_StartDt_List.Add(StartDate);
            Date_2_EndDt_List.Add(EndDate);
            if i = BucketCount then
                DaysDict2.Add(EndDate, StrSubstNo(NoOfDaysLbl, Format(((i - 1) * Difference) + 1), Format(NoOfDays)))
            else
                DaysDict2.Add(EndDate, StrSubstNo(NoOfDaysLbl, Format(((i - 1) * Difference) + 1), Format(i * Difference)));
            EndDate := StartDate - 1;
        end;
    end;

    local procedure GetDateText(FromDate: Date; option: text): Text[100]
    begin
        if option = 'Date 1' then
            exit(DaysDict.Get(FromDate))
        else
            exit(DaysDict2.Get(FromDate));
    end;


    var
        Date1: Date;
        Date2: Date;
        FromDate_1: Date;
        FromDate_2: Date;
        NoOfDays: Integer;
        Difference: Integer;
        EntryNo: Integer;
        OldVsNewDifference: Decimal;
        TotalOldVsNewDifference: Decimal;
        Date_1_StartDt_List: List of [Date];
        Date_2_StartDt_List: List of [Date];
        Date_1_EndDt_List: List of [Date];
        Date_2_EndDt_List: List of [Date];
        DaysDict: Dictionary of [Date, Text[100]];
        DaysDict2: Dictionary of [Date, Text[100]];
        SalesPersonName: Text;
        TeamName: text;
        RecSalesPer: Record "Salesperson/Purchaser";
        Recteam: Record "Team Salesperson";
        RecSalesTeam: Record Team;


}
