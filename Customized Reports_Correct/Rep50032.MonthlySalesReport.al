report 50032 "Monthly Sales Report"
{
    ProcessingOnly = true;
    UsageCategory = Administration;
    Caption = 'Monthly Sales Report';
    ApplicationArea = all;
    dataset
    {
        dataitem(Integer; Integer)
        {
            MaxIteration = 1;

            trigger OnAfterGetRecord()
            begin
                Team.RESET;
                IF TeamType <> TeamType::" " THEN
                    Team.SETFILTER(Team."Team Type", '%1', TeamType);
                Team.SETFILTER(Team.Code, TeamCodeFilter);
                IF Team.FINDSET THEN BEGIN
                    Team.SETCURRENTKEY("Team Type");
                    REPEAT
                        CreateBody(FORMAT(Team."Team Type"));
                    UNTIL Team.NEXT = 0;
                END;
            end;

            trigger OnPostDataItem()
            begin
                PrintLastTotal;
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
                field("Start date"; StartingDate)
                {
                    ApplicationArea = All;
                }
                field("End date"; EndingDate)
                {
                    ApplicationArea = All;
                }
                field("Team Type"; TeamType)
                {
                    ApplicationArea = All;
                }
                field("Team Code"; TeamCodeFilter)
                {
                    TableRelation = Team.Code;
                    ApplicationArea = All;
                }
                field("Sales Person Code"; SalesPersonFilter)
                {
                    TableRelation = "Salesperson/Purchaser".Code;
                    ApplicationArea = All;
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPostReport()
    begin
        ExcelBuffer.CreateNewBook('Month Wise Sales Report');
        ExcelBuffer.WriteSheet('Month Wise Sales Report', CompanyName, UserId);
        ExcelBuffer.CloseBook();
        ExcelBuffer.SetFriendlyFilename(StrSubstNo('Month Wise Sales Report', CurrentDateTime, UserId));
        ExcelBuffer.OpenExcel();
        //ExcelBuffer.CreateBookAndOpenExcel('', 'Month Wise Sales Report', ' ', COMPANYNAME, USERID);
    end;

    trigger OnPreReport()
    begin
        IF (StartingDate = 0D) OR (EndingDate = 0D) THEN
            ERROR('Starting Date and Ending Date must have value');
        CreateHeader;
        CreateMonthHeader;
    end;

    var
        StartingDate: Date;
        EndingDate: Date;
        ExcelBuffer: Record 370 temporary;
        Team: Record 5083;
        TeamSalesperson: Record 5084;
        DuplicateTeam: Text;
        NoOfmonth: Integer;
        Counter: Integer;
        TeamTypeGrand: array[10] of Decimal;
        I: Integer;
        TotalDueValue: array[10] of Decimal;
        PreviousTeamCode: Code[20];
        TeamType: Option " ",Cattle,Poultry;
        TeamCodeFilter: Code[20];
        SalesPersonFilter: Code[1024];

    local procedure CreateMonthHeader()
    var
        DateCalendar: Record 2000000007;
    begin
        DateCalendar.RESET;
        DateCalendar.SETRANGE(DateCalendar."Period Type", DateCalendar."Period Type"::Month);
        DateCalendar.SETRANGE(DateCalendar."Period Start", CALCDATE('-CM', StartingDate), EndingDate);
        IF DateCalendar.FINDSET THEN BEGIN
            REPEAT
                NoOfmonth += 1;
                ExcelBuffer.AddColumn(DateCalendar."Period Name" + ' ' + FORMAT(DATE2DMY(DateCalendar."Period Start", 3)), FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
            UNTIL DateCalendar.NEXT = 0;
        END;
        ExcelBuffer.AddColumn('Grand Total', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('1-15 Days', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('16-30 Days', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('31-45 Days', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('46-60 Days', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('61-120 Days', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('121-180 Days', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('< 181 Days', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Balance', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Limit', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        //ExcelBuffer.NewRow;
    end;

    local procedure CreateHeader()
    begin
        ExcelBuffer.AddColumn('Date Filters : Month Wise Sales Report', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.NewRow;
        ExcelBuffer.AddColumn('Date Filters :' + ' ' + FORMAT(StartingDate) + '..' + FORMAT(EndingDate), FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.NewRow;
        ExcelBuffer.AddColumn('USER ID :' + ' ' + USERID, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.NewRow;
        ExcelBuffer.AddColumn('Team Type', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Team Name', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Sales Person Name', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Customer Name', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        //ExcelBuffer.AddColumn('',FALSE,'',TRUE,FALSE,TRUE,'',ExcelBuffer."Cell Type"::Text);
    end;

    local procedure CreateBody(TeamType: Text)
    begin
        IF DuplicateTeam <> TeamType THEN BEGIN
            IF DuplicateTeam <> '' THEN BEGIN
                ExcelBuffer.NewRow;
                ExcelBuffer.AddColumn(DuplicateTeam + ' ' + 'Team Total', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
                ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
                ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
                FOR I := 1 TO NoOfmonth DO BEGIN
                    ExcelBuffer.AddColumn(TeamTypeGrand[I], FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
                END;
                ExcelBuffer.AddColumn(TotalDueValue[8], FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
                ExcelBuffer.AddColumn(TotalDueValue[1], FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
                ExcelBuffer.AddColumn(TotalDueValue[2], FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
                ExcelBuffer.AddColumn(TotalDueValue[3], FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
                ExcelBuffer.AddColumn(TotalDueValue[4], FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
                ExcelBuffer.AddColumn(TotalDueValue[5], FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
                ExcelBuffer.AddColumn(TotalDueValue[6], FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
                ExcelBuffer.AddColumn(TotalDueValue[7], FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
            END;
            InitializeTotal;
            ExcelBuffer.NewRow;
            ExcelBuffer.AddColumn(TeamType, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
            //ExcelBuffer.NewRow;
            //ExcelBuffer.AddColumn(team.Code + 'Team Total',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuffer."Cell Type"::Text);
            ExcelBuffer.NewRow;
            ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
            ExcelBuffer.AddColumn(Team.Code, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
            ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
            ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
            TeamGrandTotal(Team.Code);
            PrintTeamSalesPerson(Team.Code);
            DuplicateTeam := TeamType;
        END ELSE BEGIN
            ExcelBuffer.NewRow;
            ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
            ExcelBuffer.AddColumn(Team.Code + ' ' + 'Totals', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
            ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
            ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
            TeamGrandTotal(Team.Code);
            PrintTeamSalesPerson(Team.Code);
        END;
    end;

    local procedure PrintTeamSalesPerson(TeamCode: Code[30])
    var
        TeamSalesperson: Record 5084;
        SalespersonPurchaser: Record 13;
    begin
        TeamSalesperson.RESET;
        TeamSalesperson.SETRANGE(TeamSalesperson."Team Code", TeamCode);
        TeamSalesperson.SETFILTER(TeamSalesperson."Salesperson Code", SalesPersonFilter);
        IF TeamSalesperson.FINDSET THEN BEGIN
            REPEAT
                SalespersonPurchaser.RESET;
                IF SalespersonPurchaser.GET(TeamSalesperson."Salesperson Code") THEN BEGIN
                    IF NOT SalespersonPurchaser.Blocked THEN BEGIN
                        TeamSalesperson.CALCFIELDS("Salesperson Name");
                        ExcelBuffer.NewRow;
                        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                        ExcelBuffer.AddColumn(TeamSalesperson."Salesperson Name" + ' ' + 'Totals', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                        TeamGrandTotalSalesCode(TeamSalesperson."Salesperson Code");
                        PrintBodyData(TeamSalesperson."Salesperson Code");
                    END;
                END;
            UNTIL TeamSalesperson.NEXT = 0;
        END;
    end;

    local procedure PrintBodyData(SalesPersonCode: Code[30])
    var
        CustLedgerEntry: Record 21;
        DuplicateCustomer: Code[20];
    begin
        DuplicateCustomer := '';
        CustLedgerEntry.RESET;
        CustLedgerEntry.SETRANGE(CustLedgerEntry."Salesperson Code", SalesPersonCode);
        CustLedgerEntry.SETFILTER(CustLedgerEntry."Document Type", '%1|%2', CustLedgerEntry."Document Type"::Invoice, CustLedgerEntry."Document Type"::"Credit Memo");
        CustLedgerEntry.SETCURRENTKEY("Customer No.");
        IF CustLedgerEntry.FINDSET THEN BEGIN
            REPEAT
                IF DuplicateCustomer <> CustLedgerEntry."Customer No." THEN BEGIN
                    IF NOT SkipZeroLine(SalesPersonCode, CustLedgerEntry."Customer No.") THEN BEGIN
                        ExcelBuffer.NewRow;
                        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                        ExcelBuffer.AddColumn(CustLedgerEntry."Customer Name", FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                        DuplicateCustomer := CustLedgerEntry."Customer No.";
                        MonthlyValue(SalesPersonCode, CustLedgerEntry."Customer No.");
                        PrintDueValue(SalesPersonCode, CustLedgerEntry."Customer No.");
                    END;
                END;
            UNTIL CustLedgerEntry.NEXT = 0;
        END;
    end;

    local procedure MonthlyValue(SalesPCode: Code[20]; CustomerNo: Code[20])
    var
        DateCalendar: Record 2000000007;
        CustLedgerEntry: Record 21;
    begin
        Counter := 0;
        DateCalendar.RESET;
        DateCalendar.SETRANGE(DateCalendar."Period Type", DateCalendar."Period Type"::Month);
        DateCalendar.SETRANGE(DateCalendar."Period Start", CALCDATE('-CM', StartingDate), EndingDate);
        IF DateCalendar.FINDSET THEN BEGIN
            REPEAT
                Counter += 1;
                IF Counter = NoOfmonth THEN
                    ExcelBuffer.AddColumn(PrintValue(SalesPCode, CustomerNo, DateCalendar."Period Start", EndingDate), FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number)
                ELSE
                    IF Counter = 1 THEN
                        ExcelBuffer.AddColumn(PrintValue(SalesPCode, CustomerNo, StartingDate, DateCalendar."Period End"), FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number)
                    ELSE
                        ExcelBuffer.AddColumn(PrintValue(SalesPCode, CustomerNo, DateCalendar."Period Start", DateCalendar."Period End"), FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);

            UNTIL DateCalendar.NEXT = 0;
        END;
    end;

    local procedure PrintValue(SalesPCode: Code[20]; CustomerNo: Code[20]; SDate: Date; EDate: Date) ColumnValue: Decimal
    var
        CustLedgerEntry: Record 21;
        SalesInvoiceLine: Record 113;
        SalesCrMemoLine: Record 115;
        InvQty: Decimal;
        CrQty: Decimal;
        NewEndDate: Date;
        NewEndD: Text;
    begin
        ColumnValue := 0;
        InvQty := 0;
        CrQty := 0;
        //IF CustomerNo = 'SFC03933' THEN
        //MESSAGE('Done')
        NewEndD := DELCHR(FORMAT(EDate), '=', 'C');
        EVALUATE(NewEndDate, NewEndD);
        CustLedgerEntry.RESET;
        CustLedgerEntry.SETRANGE(CustLedgerEntry."Customer No.", CustomerNo);
        CustLedgerEntry.SETRANGE(CustLedgerEntry."Posting Date", SDate, EDate);
        CustLedgerEntry.SETRANGE(CustLedgerEntry."Salesperson Code", SalesPCode);
        CustLedgerEntry.SETFILTER(CustLedgerEntry."Document Type", '%1|%2', CustLedgerEntry."Document Type"::Invoice, CustLedgerEntry."Document Type"::"Credit Memo");
        CustLedgerEntry.SETCURRENTKEY("Customer No.");
        IF CustLedgerEntry.FINDSET THEN BEGIN
            REPEAT
                CustLedgerEntry.CALCFIELDS("Order Qty", "Order Memo Qty");
                InvQty += CustLedgerEntry."Order Qty";
                CrQty += CustLedgerEntry."Order Memo Qty";
            UNTIL CustLedgerEntry.NEXT = 0;
        END;
        ColumnValue := (InvQty - CrQty);
        IF ColumnValue <> 0 THEN
            ColumnValue := ColumnValue / 1000;
        TeamTypeGrand[Counter] += ColumnValue;
    end;

    local procedure PrintDueValue(SalesPCode: Code[20]; CustomerNo: Code[20])
    var
        CustLedgerEntry: Record 21;
        SalesInvoiceLine: Record 113;
        SalesCrMemoLine: Record 115;
        InvQty: Decimal;
        CrQty: Decimal;
        DueDays: Integer;
        DueValue: array[10] of Decimal;
        TotalInvQty: Decimal;
        TotalCrQty: Decimal;
        TotalColValue: Decimal;
        Customer: Record 18;
        CustomerBal: Decimal;
    begin
        DueValue[1] := 0;
        DueValue[2] := 0;
        DueValue[3] := 0;
        DueValue[4] := 0;
        DueValue[5] := 0;
        DueValue[6] := 0;
        DueValue[7] := 0;
        TotalColValue := 0;
        TotalCrQty := 0;
        TotalInvQty := 0;
        CustomerBal := 0;
        CustLedgerEntry.RESET;
        CustLedgerEntry.SETRANGE(CustLedgerEntry."Customer No.", CustomerNo);
        CustLedgerEntry.SETRANGE(CustLedgerEntry."Salesperson Code", SalesPCode);
        CustLedgerEntry.SETRANGE(CustLedgerEntry."Posting Date", StartingDate, EndingDate);
        CustLedgerEntry.SETFILTER(CustLedgerEntry."Document Type", '%1|%2', CustLedgerEntry."Document Type"::Invoice, CustLedgerEntry."Document Type"::"Credit Memo");
        CustLedgerEntry.SETCURRENTKEY("Customer No.");
        IF CustLedgerEntry.FINDSET THEN BEGIN
            REPEAT
                CustLedgerEntry.CALCFIELDS("Remaining Amount", "Order Qty", "Order Memo Qty");
                TotalInvQty += CustLedgerEntry."Order Qty";
                TotalCrQty += CustLedgerEntry."Order Memo Qty";
                IF CustLedgerEntry."Remaining Amount" <> 0 THEN BEGIN
                    DueDays := (EndingDate - CustLedgerEntry."Posting Date");
                    IF CustLedgerEntry."Document Type" = CustLedgerEntry."Document Type"::Invoice THEN BEGIN
                        IF DueDays < 16 THEN
                            DueValue[1] += CustLedgerEntry."Remaining Amount";
                        IF (DueDays > 15) AND (DueDays < 31) THEN
                            DueValue[2] += CustLedgerEntry."Remaining Amount";
                        IF (DueDays > 30) AND (DueDays < 46) THEN
                            DueValue[3] += CustLedgerEntry."Remaining Amount";
                        IF (DueDays > 45) AND (DueDays < 61) THEN
                            DueValue[4] += CustLedgerEntry."Remaining Amount";
                        IF (DueDays > 60) AND (DueDays < 121) THEN
                            DueValue[5] += CustLedgerEntry."Remaining Amount";
                        IF (DueDays > 120) AND (DueDays < 181) THEN
                            DueValue[6] += CustLedgerEntry."Remaining Amount";
                        IF (DueDays > 180) THEN
                            DueValue[7] += CustLedgerEntry."Remaining Amount";
                        CustomerBal += CustLedgerEntry."Remaining Amount";
                    END;
                END;
            UNTIL CustLedgerEntry.NEXT = 0;
        END;
        TotalColValue := TotalInvQty - TotalCrQty;
        IF TotalColValue <> 0 THEN
            TotalColValue := TotalColValue / 1000;
        Customer.RESET;
        IF Customer.GET(CustomerNo) THEN;
        Customer.CALCFIELDS(Balance);
        ExcelBuffer.AddColumn(TotalColValue, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn(DueValue[1], FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn(DueValue[2], FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn(DueValue[3], FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn(DueValue[4], FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn(DueValue[5], FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn(DueValue[6], FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn(DueValue[7], FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn(CustomerBal, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn(Customer."Credit Limit (LCY)", FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
        TotalDueValue[1] += DueValue[1];
        TotalDueValue[2] += DueValue[2];
        TotalDueValue[3] += DueValue[3];
        TotalDueValue[4] += DueValue[4];
        TotalDueValue[5] += DueValue[5];
        TotalDueValue[6] += DueValue[6];
        TotalDueValue[7] += DueValue[7];
        TotalDueValue[8] += TotalColValue;
    end;

    local procedure TeamGrandTotal(TeamCode: Code[20])
    var
        TeamSalesperson: Record 5084;
        AllSalesPersod: Code[1024];
        DateCalendar: Record 2000000007;
        SalespersonPurchaser: Record 13;
    begin
        TeamSalesperson.RESET;//GK
        TeamSalesperson.SETRANGE(TeamSalesperson."Team Code", TeamCode);
        IF TeamSalesperson.FINDSET THEN
            REPEAT
                SalespersonPurchaser.RESET;
                SalespersonPurchaser.SETRANGE(SalespersonPurchaser.Code, TeamSalesperson."Salesperson Code");
                SalespersonPurchaser.SETRANGE(SalespersonPurchaser.Blocked, FALSE);
                IF SalespersonPurchaser.FINDFIRST THEN
                    AllSalesPersod += '|' + TeamSalesperson."Salesperson Code";
            UNTIL TeamSalesperson.NEXT = 0;
        Counter := 0;
        DateCalendar.RESET;
        DateCalendar.SETRANGE(DateCalendar."Period Type", DateCalendar."Period Type"::Month);
        DateCalendar.SETRANGE(DateCalendar."Period Start", CALCDATE('-CM', StartingDate), EndingDate);
        IF DateCalendar.FINDSET THEN BEGIN
            REPEAT
                Counter += 1;

                IF Counter = 1 THEN
                    ExcelBuffer.AddColumn(TeamGrandTotalValue(StartingDate, DateCalendar."Period End", AllSalesPersod), FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number)
                ELSE
                    IF Counter = NoOfmonth THEN
                        ExcelBuffer.AddColumn(TeamGrandTotalValue(DateCalendar."Period Start", EndingDate, AllSalesPersod), FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number)
                    ELSE
                        ExcelBuffer.AddColumn(TeamGrandTotalValue(DateCalendar."Period Start", DateCalendar."Period End", AllSalesPersod), FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);

            UNTIL DateCalendar.NEXT = 0;
        END;
        PrintDueValueTotal(DELSTR(AllSalesPersod, 1, 1));
    end;

    local procedure TeamGrandTotalValue(Date1: Date; Date2: Date; SalesCodes: Code[1024]) SalesWiseTotal: Decimal
    var
        CustLedgerEntry: Record 21;
        TotalInv: Decimal;
        TotalCr: Decimal;
        TotalGrand: Decimal;
    begin
        IF NoOfmonth = 1 THEN
            Date2 := EndingDate;
        SalesWiseTotal := 0;
        TotalCr := 0;
        TotalInv := 0;
        IF SalesCodes <> '' THEN
            SalesCodes := DELSTR(SalesCodes, 1, 1);
        CustLedgerEntry.RESET;
        CustLedgerEntry.SETFILTER(CustLedgerEntry."Document Type", '%1|%2', CustLedgerEntry."Document Type"::Invoice, CustLedgerEntry."Document Type"::"Credit Memo");
        CustLedgerEntry.SETRANGE(CustLedgerEntry."Posting Date", Date1, Date2);
        CustLedgerEntry.SETFILTER(CustLedgerEntry."Salesperson Code", SalesCodes);
        IF CustLedgerEntry.FINDSET THEN
            REPEAT
                CustLedgerEntry.CALCFIELDS("Order Memo Qty", "Order Qty");
                TotalCr += CustLedgerEntry."Order Memo Qty";
                TotalInv += CustLedgerEntry."Order Qty";
            UNTIL CustLedgerEntry.NEXT = 0;

        SalesWiseTotal := TotalInv - TotalCr;
        IF SalesWiseTotal <> 0 THEN
            SalesWiseTotal := SalesWiseTotal / 1000;
    end;

    local procedure InitializeTotal()
    begin
        TotalDueValue[1] := 0;
        TotalDueValue[2] := 0;
        TotalDueValue[3] := 0;
        TotalDueValue[4] := 0;
        TotalDueValue[5] := 0;
        TotalDueValue[6] := 0;
        TotalDueValue[7] := 0;
        TotalDueValue[8] := 0;
        TotalDueValue[9] := 0;
        TotalDueValue[10] := 0;
        FOR I := 1 TO NoOfmonth DO BEGIN
            TeamTypeGrand[I] := 0;
        END;
        //GK
    end;

    local procedure PrintLastTotal()
    begin
        ExcelBuffer.NewRow;
        ExcelBuffer.AddColumn(FORMAT(Team."Team Type") + ' ' + 'Team Total', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        FOR I := 1 TO NoOfmonth DO BEGIN
            ExcelBuffer.AddColumn(TeamTypeGrand[I], FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        END;
        ExcelBuffer.AddColumn(TotalDueValue[8], FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn(TotalDueValue[1], FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn(TotalDueValue[2], FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn(TotalDueValue[3], FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn(TotalDueValue[4], FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn(TotalDueValue[5], FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn(TotalDueValue[6], FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn(TotalDueValue[7], FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
    end;

    local procedure PrintDueValueTotal(SalesPCode: Code[1024])
    var
        CustLedgerEntry: Record 21;
        SalesInvoiceLine: Record 113;
        SalesCrMemoLine: Record 115;
        InvQty: Decimal;
        CrQty: Decimal;
        DueDays: Integer;
        DueValueTotal: array[10] of Decimal;
        TotalInvQty: Decimal;
        TotalCrQty: Decimal;
        TotalColValue: Decimal;
        Customer: Record 18;
    begin
        DueValueTotal[1] := 0;
        DueValueTotal[2] := 0;
        DueValueTotal[3] := 0;
        DueValueTotal[4] := 0;
        DueValueTotal[5] := 0;
        DueValueTotal[6] := 0;
        DueValueTotal[7] := 0;
        TotalColValue := 0;
        TotalCrQty := 0;
        TotalInvQty := 0;
        CustLedgerEntry.RESET;
        //CustLedgerEntry.SETRANGE(CustLedgerEntry."Customer No.",CustomerNo);
        CustLedgerEntry.SETFILTER(CustLedgerEntry."Salesperson Code", SalesPCode);
        CustLedgerEntry.SETRANGE(CustLedgerEntry."Posting Date", StartingDate, EndingDate);
        CustLedgerEntry.SETFILTER(CustLedgerEntry."Document Type", '%1|%2', CustLedgerEntry."Document Type"::Invoice, CustLedgerEntry."Document Type"::"Credit Memo");
        CustLedgerEntry.SETCURRENTKEY("Customer No.");
        IF CustLedgerEntry.FINDSET THEN BEGIN
            REPEAT
                CustLedgerEntry.CALCFIELDS("Remaining Amount", "Order Qty", "Order Memo Qty");
                TotalInvQty += CustLedgerEntry."Order Qty";
                TotalCrQty += CustLedgerEntry."Order Memo Qty";
                IF CustLedgerEntry."Remaining Amount" <> 0 THEN BEGIN
                    DueDays := (EndingDate - CustLedgerEntry."Posting Date");
                    IF CustLedgerEntry."Document Type" = CustLedgerEntry."Document Type"::Invoice THEN BEGIN
                        IF DueDays < 16 THEN
                            DueValueTotal[1] += CustLedgerEntry."Remaining Amount";
                        IF (DueDays > 15) AND (DueDays < 31) THEN
                            DueValueTotal[2] += CustLedgerEntry."Remaining Amount";
                        IF (DueDays > 30) AND (DueDays < 46) THEN
                            DueValueTotal[3] += CustLedgerEntry."Remaining Amount";
                        IF (DueDays > 45) AND (DueDays < 61) THEN
                            DueValueTotal[4] += CustLedgerEntry."Remaining Amount";
                        IF (DueDays > 60) AND (DueDays < 121) THEN
                            DueValueTotal[5] += CustLedgerEntry."Remaining Amount";
                        IF (DueDays > 120) AND (DueDays < 181) THEN
                            DueValueTotal[6] += CustLedgerEntry."Remaining Amount";
                        IF (DueDays > 180) THEN
                            DueValueTotal[7] += CustLedgerEntry."Remaining Amount";
                    END;
                END;
            UNTIL CustLedgerEntry.NEXT = 0;
        END;
        TotalColValue := TotalInvQty - TotalCrQty;
        IF TotalColValue <> 0 THEN
            TotalColValue := TotalColValue / 1000;
        Customer.RESET;
        //IF Customer.GET(CustomerNo) THEN;
        //Customer.CALCFIELDS(Balance);
        ExcelBuffer.AddColumn(TotalColValue, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn(DueValueTotal[1], FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn(DueValueTotal[2], FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn(DueValueTotal[3], FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn(DueValueTotal[4], FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn(DueValueTotal[5], FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn(DueValueTotal[6], FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn(DueValueTotal[7], FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
        //ExcelBuffer.AddColumn(Customer.Balance,FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuffer."Cell Type"::Number);
        //ExcelBuffer.AddColumn(Customer."Credit Limit (LCY)",FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuffer."Cell Type"::Number);
    end;

    local procedure TeamGrandTotalSalesCode(TeamCode: Code[20])
    var
        TeamSalesperson: Record 5084;
        AllSalesPersod: Code[1024];
        DateCalendar: Record 2000000007;
    begin

        Counter := 0;
        DateCalendar.RESET;
        DateCalendar.SETRANGE(DateCalendar."Period Type", DateCalendar."Period Type"::Month);
        DateCalendar.SETRANGE(DateCalendar."Period Start", CALCDATE('-CM', StartingDate), EndingDate);
        IF DateCalendar.FINDSET THEN BEGIN
            REPEAT
                Counter += 1;
                IF (Counter = 1) AND (NoOfmonth = 1) THEN
                    ExcelBuffer.AddColumn(SalesGrandTotalValue(StartingDate, EndingDate, TeamCode), FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number)
                ELSE
                    IF Counter = 1 THEN BEGIN
                        ExcelBuffer.AddColumn(SalesGrandTotalValue(StartingDate, DateCalendar."Period End", TeamCode), FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number)
                    END ELSE
                        IF Counter = NoOfmonth THEN
                            ExcelBuffer.AddColumn(SalesGrandTotalValue(DateCalendar."Period Start", EndingDate, TeamCode), FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number)
                        ELSE
                            ExcelBuffer.AddColumn(SalesGrandTotalValue(DateCalendar."Period Start", DateCalendar."Period End", TeamCode), FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);

            UNTIL DateCalendar.NEXT = 0;
        END;
        PrintDueValueTotalSalesCode(TeamCode);
    end;

    local procedure SalesGrandTotalValue(Date1: Date; Date2: Date; SalesCodes: Code[1024]) SalesWiseTotal: Decimal
    var
        CustLedgerEntry: Record 21;
        TotalInvS: Decimal;
        TotalCrS: Decimal;
        TotalGrandS: Decimal;
    begin
        SalesWiseTotal := 0;
        TotalCrS := 0;
        TotalInvS := 0;
        CustLedgerEntry.RESET;
        CustLedgerEntry.SETFILTER(CustLedgerEntry."Document Type", '%1|%2', CustLedgerEntry."Document Type"::Invoice, CustLedgerEntry."Document Type"::"Credit Memo");
        CustLedgerEntry.SETRANGE(CustLedgerEntry."Posting Date", Date1, Date2);
        CustLedgerEntry.SETFILTER(CustLedgerEntry."Salesperson Code", SalesCodes);
        IF CustLedgerEntry.FINDSET THEN
            REPEAT
                CustLedgerEntry.CALCFIELDS("Order Memo Qty", "Order Qty");
                TotalCrS += CustLedgerEntry."Order Memo Qty";
                TotalInvS += CustLedgerEntry."Order Qty";
            UNTIL CustLedgerEntry.NEXT = 0;

        SalesWiseTotal := TotalInvS - TotalCrS;
        IF SalesWiseTotal <> 0 THEN
            SalesWiseTotal := SalesWiseTotal / 1000;
    end;

    local procedure PrintDueValueTotalSalesCode(SalesPCode: Code[1024])
    var
        CustLedgerEntry: Record 21;
        SalesInvoiceLine: Record 113;
        SalesCrMemoLine: Record 115;
        InvQty: Decimal;
        CrQty: Decimal;
        DueDays: Integer;
        DueValueTotals: array[10] of Decimal;
        TotalInvQtys: Decimal;
        TotalCrQtys: Decimal;
        TotalColValues: Decimal;
        Customer: Record 18;
    begin
        DueValueTotals[1] := 0;
        DueValueTotals[2] := 0;
        DueValueTotals[3] := 0;
        DueValueTotals[4] := 0;
        DueValueTotals[5] := 0;
        DueValueTotals[6] := 0;
        DueValueTotals[7] := 0;
        TotalColValues := 0;
        TotalCrQtys := 0;
        TotalInvQtys := 0;
        CustLedgerEntry.RESET;
        //CustLedgerEntry.SETRANGE(CustLedgerEntry."Customer No.",CustomerNo);
        CustLedgerEntry.SETFILTER(CustLedgerEntry."Salesperson Code", SalesPCode);
        CustLedgerEntry.SETRANGE(CustLedgerEntry."Posting Date", StartingDate, EndingDate);
        CustLedgerEntry.SETFILTER(CustLedgerEntry."Document Type", '%1|%2', CustLedgerEntry."Document Type"::Invoice, CustLedgerEntry."Document Type"::"Credit Memo");
        CustLedgerEntry.SETCURRENTKEY("Customer No.");
        IF CustLedgerEntry.FINDSET THEN BEGIN
            REPEAT
                CustLedgerEntry.CALCFIELDS("Remaining Amount", "Order Qty", "Order Memo Qty");
                TotalInvQtys += CustLedgerEntry."Order Qty";
                TotalCrQtys += CustLedgerEntry."Order Memo Qty";
                IF CustLedgerEntry."Remaining Amount" <> 0 THEN BEGIN
                    DueDays := (EndingDate - CustLedgerEntry."Posting Date");
                    IF CustLedgerEntry."Document Type" = CustLedgerEntry."Document Type"::Invoice THEN BEGIN
                        IF DueDays < 16 THEN
                            DueValueTotals[1] += CustLedgerEntry."Remaining Amount";
                        IF (DueDays > 15) AND (DueDays < 31) THEN
                            DueValueTotals[2] += CustLedgerEntry."Remaining Amount";
                        IF (DueDays > 30) AND (DueDays < 46) THEN
                            DueValueTotals[3] += CustLedgerEntry."Remaining Amount";
                        IF (DueDays > 45) AND (DueDays < 61) THEN
                            DueValueTotals[4] += CustLedgerEntry."Remaining Amount";
                        IF (DueDays > 60) AND (DueDays < 121) THEN
                            DueValueTotals[5] += CustLedgerEntry."Remaining Amount";
                        IF (DueDays > 120) AND (DueDays < 181) THEN
                            DueValueTotals[6] += CustLedgerEntry."Remaining Amount";
                        IF (DueDays > 180) THEN
                            DueValueTotals[7] += CustLedgerEntry."Remaining Amount";
                    END;
                END;
            UNTIL CustLedgerEntry.NEXT = 0;
        END;
        TotalColValues := TotalInvQtys - TotalCrQtys;
        IF TotalColValues <> 0 THEN
            TotalColValues := TotalColValues / 1000;
        Customer.RESET;
        //IF Customer.GET(CustomerNo) THEN;
        //Customer.CALCFIELDS(Balance);
        ExcelBuffer.AddColumn(TotalColValues, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn(DueValueTotals[1], FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn(DueValueTotals[2], FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn(DueValueTotals[3], FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn(DueValueTotals[4], FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn(DueValueTotals[5], FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn(DueValueTotals[6], FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn(DueValueTotals[7], FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
        //ExcelBuffer.AddColumn(Customer.Balance,FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuffer."Cell Type"::Number);
        //ExcelBuffer.AddColumn(Customer."Credit Limit (LCY)",FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuffer."Cell Type"::Number);
    end;

    local procedure SkipZeroLine(SalesPCode: Code[20]; CustomerNo: Code[20]) PrintLine: Boolean
    var
        CustLedgerEntry: Record 21;
        SalesInvoiceLine: Record 113;
        SalesCrMemoLine: Record 115;
        InvQty: Decimal;
        CrQty: Decimal;
        DueDays: Integer;
        DueValue: array[10] of Decimal;
        TotalInvQty: Decimal;
        TotalCrQty: Decimal;
        TotalColValue: Decimal;
        Customer: Record 18;
        CustomerBal: Decimal;
    begin
        PrintLine := FALSE;
        DueValue[1] := 0;
        DueValue[2] := 0;
        DueValue[3] := 0;
        DueValue[4] := 0;
        DueValue[5] := 0;
        DueValue[6] := 0;
        DueValue[7] := 0;
        TotalColValue := 0;
        TotalCrQty := 0;
        TotalInvQty := 0;
        CustomerBal := 0;
        CustLedgerEntry.RESET;
        CustLedgerEntry.SETRANGE(CustLedgerEntry."Customer No.", CustomerNo);
        CustLedgerEntry.SETRANGE(CustLedgerEntry."Salesperson Code", SalesPCode);
        CustLedgerEntry.SETRANGE(CustLedgerEntry."Posting Date", StartingDate, EndingDate);
        CustLedgerEntry.SETFILTER(CustLedgerEntry."Document Type", '%1|%2', CustLedgerEntry."Document Type"::Invoice, CustLedgerEntry."Document Type"::"Credit Memo");
        CustLedgerEntry.SETCURRENTKEY("Customer No.");
        IF CustLedgerEntry.FINDSET THEN BEGIN
            REPEAT
                CustLedgerEntry.CALCFIELDS("Remaining Amount", "Order Qty", "Order Memo Qty");
                TotalInvQty += CustLedgerEntry."Order Qty";
                TotalCrQty += CustLedgerEntry."Order Memo Qty";
                IF CustLedgerEntry."Remaining Amount" <> 0 THEN BEGIN
                    //DueDays := (EndingDate - CustLedgerEntry."Posting Date");
                    IF CustLedgerEntry."Document Type" = CustLedgerEntry."Document Type"::Invoice THEN BEGIN
                        //        IF DueDays < 16 THEN
                        //          DueValue[1] += CustLedgerEntry."Remaining Amount";
                        //        IF (DueDays > 15) AND (DueDays < 31) THEN
                        //          DueValue[2] += CustLedgerEntry."Remaining Amount";
                        //        IF (DueDays > 30) AND (DueDays < 46) THEN
                        //          DueValue[3] += CustLedgerEntry."Remaining Amount";
                        //        IF (DueDays > 45) AND (DueDays < 61) THEN
                        //          DueValue[4] += CustLedgerEntry."Remaining Amount";
                        //        IF (DueDays > 60) AND (DueDays < 121) THEN
                        //          DueValue[5] += CustLedgerEntry."Remaining Amount";
                        //        IF (DueDays > 120) AND (DueDays < 181) THEN
                        //          DueValue[6] += CustLedgerEntry."Remaining Amount";
                        //        IF (DueDays > 180) THEN
                        //          DueValue[7] += CustLedgerEntry."Remaining Amount";
                        CustomerBal += CustLedgerEntry."Remaining Amount";
                    END;
                END;
            UNTIL CustLedgerEntry.NEXT = 0;
        END;
        TotalColValue := TotalInvQty - TotalCrQty;
        IF TotalColValue <> 0 THEN
            TotalColValue := TotalColValue / 1000;
        //MESSAGE('TotalInvQty-%1',TotalInvQty);


        // ExcelBuffer.AddColumn(TotalColValue,FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuffer."Cell Type"::Number);
        // ExcelBuffer.AddColumn(DueValue[1],FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuffer."Cell Type"::Number);
        // ExcelBuffer.AddColumn(DueValue[2],FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuffer."Cell Type"::Number);
        // ExcelBuffer.AddColumn(DueValue[3],FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuffer."Cell Type"::Number);
        // ExcelBuffer.AddColumn(DueValue[4],FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuffer."Cell Type"::Number);
        // ExcelBuffer.AddColumn(DueValue[5],FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuffer."Cell Type"::Number);
        // ExcelBuffer.AddColumn(DueValue[6],FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuffer."Cell Type"::Number);
        // ExcelBuffer.AddColumn(DueValue[7],FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuffer."Cell Type"::Number);
        // ExcelBuffer.AddColumn(CustomerBal,FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuffer."Cell Type"::Number);
        // ExcelBuffer.AddColumn(Customer."Credit Limit (LCY)",FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuffer."Cell Type"::Number);
        // TotalDueValue[1] += DueValue[1];
        // TotalDueValue[2] += DueValue[2];
        // TotalDueValue[3] += DueValue[3];
        // TotalDueValue[4] += DueValue[4];
        // TotalDueValue[5] += DueValue[5];
        // TotalDueValue[6] += DueValue[6];
        // TotalDueValue[7] += DueValue[7];
        //TotalDueValue[8] += TotalColValue;
        IF (TotalColValue = 0) AND (CustomerBal = 0) THEN
            PrintLine := TRUE
        ELSE
            PrintLine := FALSE;
        //MESSAGE('%1,%2',TotalColValue,CustomerBal);
    end;

}

