report 50064 "Customer Ageing"
{
    Caption = 'Customer Ageing';
    ProcessingOnly = true;
    UsageCategory = Administration;
    ApplicationArea = all;
    dataset
    {
        dataitem(Customer; Customer)
        {
            DataItemTableView = SORTING("No.")
                                ORDER(Ascending)
                                WHERE("Net Change" = FILTER(<> 0));
            RequestFilterFields = "No.";
            column(Name_Vendor; Customer.Name)
            {
            }
            column(No_Vendor; Customer."No.")
            {
            }
            dataitem(DataItem1170000001; 13)
            {
                DataItemLink = Code = FIELD("Salesperson Code");
            }

            trigger OnAfterGetRecord()
            begin
                IF PrintHeade THEN
                    DateCalculationForHeader;

                //
                CLEAR(Grandtotal);
                amttotal := 0;
                CLEAR(Totalamt);
                CustLedgerEntry.RESET;
                CustLedgerEntry.SETRANGE("Customer No.", Customer."No.");
                CustLedgerEntry.SETRANGE("Posting Date", StartDate, EndDate);
                CustLedgerEntry.SETFILTER("Global Dimension 1 Code", Customer.GETFILTER("Global Dimension 1 Filter"));
                IF CustLedgerEntry.FINDSET THEN
                    REPEAT
                        CustLedgerEntry.CALCFIELDS("Remaining Amount");
                        CustomerNo := Customer."No.";
                        amttotal += CustLedgerEntry."Remaining Amount";
                    UNTIL CustLedgerEntry.NEXT = 0;

                //Grandtotal += amttotal;
                //IF amttotal <> 0 THEN
                DateCalculationForLine;

                IF amttotal = 0 THEN
                    CurrReport.SKIP;


                //ExcelBuf.AddColumn(Totalamt,FALSE,'',FALSE,FALSE,FALSE,'@',ExcelBuf."Cell Type"::Number);
            end;

            trigger OnPreDataItem()
            begin
                ExcelBuf.NewRow;
                ExcelBuf.AddColumn('Customer No.', FALSE, '', TRUE, FALSE, FALSE, '@', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn('Customer Name', FALSE, '', TRUE, FALSE, FALSE, '@', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn('Responsibility Centre', FALSE, '', TRUE, FALSE, FALSE, '@', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn('Customer Type', FALSE, '', TRUE, FALSE, FALSE, '@', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn('Customer Status', FALSE, '', TRUE, FALSE, FALSE, '@', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn('Team Name', FALSE, '', TRUE, FALSE, FALSE, '@', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn('Sales Person', FALSE, '', TRUE, FALSE, FALSE, '@', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn('E-Mail', FALSE, '', TRUE, FALSE, FALSE, '@', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn('Mkt no', FALSE, '', TRUE, FALSE, FALSE, '@', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn('Credit Limit(LCY)', FALSE, '', TRUE, FALSE, FALSE, '@', ExcelBuf."Cell Type"::Text);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Option)
                {
                    Caption = 'Option';
                    field("As on Date"; AsOnDate_gDte)
                    {
                        ApplicationArea = All;
                    }
                    field(HeadingType; HeadingType)
                    {
                        Caption = 'Heading Type';
                        OptionCaption = 'Date Interval,Number of Days';
                        Visible = true;
                        ApplicationArea = All;
                    }
                    field(PeriodLength; PeriodLength)
                    {
                        Caption = 'Period Length';
                        ApplicationArea = All;
                    }
                    field(TotalNoofDays; TotalNoofDays)
                    {
                        Caption = 'Total No. Of Days';
                        ApplicationArea = All;
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            //IF PeriodStartDate[2] = 0D THEN
            //PeriodStartDate[2] := WORKDATE;
            //IF FORMAT(PeriodLength) = '' THEN
            //  EVALUATE(PeriodLength,'<1D>');
            //
        end;
    }

    labels
    {
        No_lbl = 'No.';
        AccountName_lbl = 'Account Name';
        MobileNo_lbl = 'Mobile No.';
        Before_lbl = 'After';
        Zero_lbl = '{0-30}';
        ThirtyOne_lbl = '{31-60}';
        SixtyOne_lbl = '{61-90}';
        NintyOne_lbl = '{91-180}';
        OneHundredTwentyOne_lbl = '{181-270}';
        greaterthanOnehundredfiftyone_lbl = '{>=270}';
        Title_lbl = 'AGEING ANALYSIS(PAYABLES)';
        GSTIN_lbl = 'GSTIN :';
        Total_lbl = 'Grand Total';
        SecondTitleLine_lbl = 'CUSTOMER BALANCE From ‘starting date’ to ‘ending date’; as on ‘work date’';
        TotalAmt_lbl = 'Total Amt.';
    }

    trigger OnInitReport()
    begin
        AsOnDate_gDte := TODAY;
    end;

    trigger OnPostReport()
    begin
        ExcelBuf.CreateNewBook('Customer Ageing');
        ExcelBuf.WriteSheet('Customer Ageing', CompanyName, UserId);
        ExcelBuf.CloseBook();
        ExcelBuf.SetFriendlyFilename(StrSubstNo('Customer Ageing', CurrentDateTime, UserId));
        ExcelBuf.OpenExcel();
        //ExcelBuf.CreateBookAndOpenExcel('', 'Customer Ageing', 'Purchase_Invoices Excel', '', USERID);
        // ExcelBuf.GiveUserControl;
    end;

    trigger OnPreReport()
    begin
        IF AsOnDate_gDte = 0D THEN
            ERROR('Please Select As On Date.');

        CompanyInformation_gRec.GET;
        CompanyAddress_gTxt := CompanyInformation_gRec.Address;
        IF CompanyInformation_gRec."Address 2" <> '' THEN
            CompanyAddress_gTxt += ',' + CompanyInformation_gRec."Address 2";
        IF CompanyInformation_gRec.City <> '' THEN
            CompanyAddress_gTxt += ',' + CompanyInformation_gRec.City;
        IF CompanyInformation_gRec."Post Code" <> '' THEN
            CompanyAddress_gTxt += '-' + CompanyInformation_gRec."Post Code";


        CLEAR(ExcelBuf);
        ExcelBuf.DELETEALL;

        PrintHeade := TRUE;
    end;

    var
        Starting_gDte: Date;
        Ending_gDte: Date;
        Text010: Label 'The Date Formula %1 cannot be used. Try to restate it. E.g. 1M+CM instead of CM+1M.';
        Amount270_gDec: Decimal;
        BeforeAmount_gDec: Decimal;
        PeriodLength: Integer;
        CompanyInformation_gRec: Record 79;
        CompanyAddress_gTxt: Text;
        SrNo_gInt: Integer;
        TotalAmt_gDec: Decimal;
        Text020: Label 'Customer Ageing From %1 to %2; as on %3';
        AsOnDate_gDte: Date;
        "Filter": Code[20];
        HeadingType: Option "Date Interval","Number of Days";
        HeadingText: array[22] of Text;
        SalespersonPurchaser: Record 13;
        SalesPersonName: Text[50];
        TeamSalesperson: Record 5084;
        TeamName: Text[50];
        Amount0_30_gDec: Decimal;
        Amount31_60_gDec: Decimal;
        Amount61_90_gDec: Decimal;
        Amount91_180_gDec: Decimal;
        Amount181_270_gDec: Decimal;
        ExcelBuf: Record 370 temporary;
        TotalNoofDays: Integer;
        i: Integer;
        Header: Text;
        Header1: Text;
        StartDate: Date;
        EndDate: Date;
        PrintHeade: Boolean;
        CustLedgerEntry: Record 21;
        CustomerNo: Code[20];
        ABC: Decimal;
        PrintLine: Boolean;
        Amt: Decimal;
        TeamSalesperson11: Record 5084;
        TeamName1: Text[50];
        TeamCode1: Code[20];
        NoofDays: Text;
        oldValue: Text;
        amttotal: Decimal;
        I1: Integer;
        Totalamt: Decimal;
        Grandtotal: Decimal;


    procedure DateCalculationForHeader()
    begin
        PrintHeade := FALSE;
        CustomerNo := '';
        oldValue := '0';
        EndDate := 0D;
        StartDate := 0D;
        FOR i := PeriodLength TO TotalNoofDays DO BEGIN
            IF PeriodLength < TotalNoofDays THEN BEGIN
                IF StartDate = 0D THEN
                    EndDate := AsOnDate_gDte
                ELSE
                    EndDate := StartDate;
                StartDate := (AsOnDate_gDte - i);
                NoofDays := oldValue + ' - ' + FORMAT(i - 1);
                HeadingText[1] := (NoofDays);
                oldValue := FORMAT(i);
                i += PeriodLength - 1;
            END;
            ExcelHeader;
        END;
        IF StartDate <> 0D THEN
            EndDate := AsOnDate_gDte
        ELSE
            EndDate := StartDate;
        StartDate := 0D;
        HeadingText[1] := ('Above');
        i += PeriodLength;
        ExcelHeader;
        //

        ExcelBuf.AddColumn('Grand Total', FALSE, '', TRUE, FALSE, FALSE, '@', ExcelBuf."Cell Type"::Text);
    end;

    procedure DateCalculationForLine()
    var
        SalespersonPurchaserM: Record 13;
        NameM: Text;
        PhoneM: Text;
        TeamSalespersonM: Record 5084;
        TeamNameM: Text;
    begin
        SalespersonPurchaserM.RESET;
        SalespersonPurchaserM.SETRANGE(Code, Customer."Salesperson Code");
        IF SalespersonPurchaserM.FINDFIRST THEN
            NameM := SalespersonPurchaserM.Name;
        PhoneM := SalespersonPurchaserM."Phone No.";

        TeamSalespersonM.RESET;
        TeamSalespersonM.SETRANGE("Salesperson Code", Customer."Salesperson Code");
        IF TeamSalespersonM.FINDFIRST THEN
            TeamNameM := TeamSalespersonM."Team Code";
        //
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn(Customer."No.", FALSE, '', FALSE, FALSE, FALSE, '@', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(Customer.Name, FALSE, '', FALSE, FALSE, FALSE, '@', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(Customer."Responsibility Center", FALSE, '', FALSE, FALSE, FALSE, '@', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(Customer."Customer Type", FALSE, '', FALSE, FALSE, FALSE, '@', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(Customer."Customer Status", FALSE, '', FALSE, FALSE, FALSE, '@', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(TeamNameM, FALSE, '', FALSE, FALSE, FALSE, '@', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(NameM, FALSE, '', FALSE, FALSE, FALSE, '@', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(Customer."E-Mail", FALSE, '', FALSE, FALSE, FALSE, '@', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(PhoneM, FALSE, '', FALSE, FALSE, FALSE, '@', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(Customer."Credit Limit (LCY)", FALSE, '', FALSE, FALSE, FALSE, '@', ExcelBuf."Cell Type"::Number);
        CustomerNo := '';
        EndDate := 0D;
        StartDate := 0D;
        FOR i := PeriodLength TO TotalNoofDays DO BEGIN
            IF PeriodLength < TotalNoofDays THEN BEGIN
                IF StartDate = 0D THEN
                    EndDate := AsOnDate_gDte
                ELSE
                    EndDate := (StartDate - 1);
                StartDate := (AsOnDate_gDte - i + 1);
                Header := (FORMAT(StartDate) + '_' + FORMAT(EndDate));
                i += PeriodLength - 1;
            END ELSE BEGIN
                IF StartDate <> 0D THEN
                    EndDate := AsOnDate_gDte
                ELSE
                    EndDate := (StartDate - 1);
                StartDate := (AsOnDate_gDte - i + 1);
                Header := (FORMAT(StartDate) + '_' + FORMAT(EndDate));
                i += PeriodLength;
            END;
            ExcelLine;
        END;
        /*IF StartDate <> 0D THEN
             EndDate := AsOnDate_gDte
           ELSE
             EndDate := StartDate;
             StartDate := 0D;
             ExcelLine;*/
        //
        EndDate := (StartDate - 1);
        StartDate := 0D;
        ExcelLine;


        ExcelBuf.AddColumn(Totalamt, FALSE, '', FALSE, FALSE, FALSE, '@', ExcelBuf."Cell Type"::Number);

    end;


    procedure ExcelHeader()
    begin
        ExcelBuf.AddColumn(HeadingText[1], FALSE, '', TRUE, FALSE, FALSE, '@', ExcelBuf."Cell Type"::Text);
    end;


    procedure ExcelLine()
    begin
        Amt := 0;
        CustLedgerEntry.RESET;
        CustLedgerEntry.SETRANGE("Customer No.", Customer."No.");
        CustLedgerEntry.SETRANGE("Posting Date", StartDate, EndDate);
        CustLedgerEntry.SETFILTER("Global Dimension 1 Code", Customer.GETFILTER("Global Dimension 1 Filter"));
        IF CustLedgerEntry.FINDSET THEN
            REPEAT
                CustLedgerEntry.CALCFIELDS("Remaining Amount");
                CustomerNo := Customer."No.";
                Amt += CustLedgerEntry."Remaining Amount";
            UNTIL CustLedgerEntry.NEXT = 0;

        Totalamt += Amt;
        ExcelBuf.AddColumn(Amt, FALSE, '', FALSE, FALSE, FALSE, '@', ExcelBuf."Cell Type"::Number);
    end;
}

