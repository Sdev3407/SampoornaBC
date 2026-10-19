report 50049 "VLE Account Statement1"
{

    Caption = 'VLE Account Statement Report';

    DefaultLayout = RDLC;
    RDLCLayout = 'ReportLayout\VLEAccountStatement.rdl';


    dataset
    {
        dataitem(Vendor; Vendor)
        {
            RequestFilterFields = "No.";
            column(No_Vendor; Vendor."No.")
            {
            }
            dataitem(CopyLoop; 2000000026)
            {
                DataItemTableView = SORTING(Number);
                column(AmountInword2; numtext2[1])
                {
                }
                column(DrCrCap; DrCrCap)
                {
                }
                column(CopyLoopNumber; CopyLoop.Number)
                {
                }
                column(OutputNo; OutputNo)
                {
                }
                column(CopyText; CopyText)
                {
                }
                column(PageNoofLoop; Number)
                {
                }
                column(DocumentCaptionCopyText; STRSUBSTNO(Text000, CopyText))
                {
                }
                column(CompanyAddr1; CompanyAddr[1])
                {
                }
                column(CompanyAddr2; CompanyAddr[2])
                {
                }
                column(CompanyAddr3; CompanyAddr[3])
                {
                }
                column(CompanyAddr4; CompanyAddr[4])
                {
                }
                column(CompanyAddr5; CompanyAddr[5])
                {
                }
                column(CompanyAddr6; CompanyAddr[6])
                {
                }
                column(CompanyInfoPicture; CompanyInfo.Picture)
                {
                }
                column(PhoneNo_Comp; CompanyInfo."Phone No.")
                {
                }
                column(Email_Comp; CompanyInfo."E-Mail")
                {
                }
                column(GSTIN_Comp; CompanyInfo."GST Registration No.")
                {
                }
                column(VendorAddr1; Vendor.Name)
                {
                }
                column(VendorAddr2; Vendor."Name 2")
                {
                }
                column(VendorAddr3; Vendor.Address)
                {
                }
                column(VendorAddr4; Vendor."Address 2")
                {
                }
                column(VendorAddr5; Vendor.City)
                {
                }
                column(VendorAddr6; Vendor."Post Code")
                {
                }
                column(VendorAddr7; Vendor.County + VendorAddress)
                {
                }
                column(PhoneNo_Vendor; Vendor."Phone No.")
                {
                }
                column(Email_Vendor; Vendor."E-Mail")
                {
                }
                column(TinNo_Vendor; Vendor."GST Registration No.")
                {
                }
                column(TodayDT; CURRENTDATETIME)
                {
                }
                column(VendDrCrCaption; VendDrCrCaption)
                {
                }
                column(PrintDate; PrintDate)
                {
                }
                column(VendOpeningBalance; VendOpeningBalance)
                {
                }
                column(RunningExist; RunningExist)
                {
                }

                dataitem("Vendor Ledger Entry"; "Vendor Ledger Entry")
                {
                    DataItemLink = "Vendor No." = FIELD("No."), "Posting Date" = field("Date Filter");
                    DataItemLinkReference = Vendor;
                    DataItemTableView = SORTING("Posting Date") WHERE(Reversed = CONST(false));
                    column(VendorNo_VLE; "Vendor Ledger Entry"."Vendor No.")
                    {
                    }
                    column(PostingDate_VLE; "Vendor Ledger Entry"."Posting Date")
                    {
                    }
                    column(DocType_VLE; "Vendor Ledger Entry"."Document Type")
                    {
                    }
                    column(ExtDocNo_VLE; "Vendor Ledger Entry"."External Document No.")
                    {
                    }
                    column(DocNo_VLE; "Vendor Ledger Entry"."Document No.")
                    {
                    }
                    column(Desc_VLE; "Vendor Ledger Entry"."Line Narration1")
                    {
                    }
                    column(DrAmnt_VLE; "Vendor Ledger Entry"."Debit Amount")
                    {
                    }
                    column(CrAmnt_VLE; "Vendor Ledger Entry"."Credit Amount")
                    {
                    }
                    column(VendRunningBalance; VendRunningBalance)
                    {
                    }
                    column(DrCrCaption; DrCrCaption)
                    {
                    }
                    column(AmountWords; numtext1[1])
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        /////CLEAR(VendRunningBalance);

                        //-->Running Balance
                        RunningExist := FALSE;
                        "Vendor Ledger Entry".CALCFIELDS("Debit Amount");
                        "Vendor Ledger Entry".CALCFIELDS("Credit Amount");
                        VendRunningBalance := (VendRunningBalance + "Vendor Ledger Entry"."Debit Amount" - "Vendor Ledger Entry"."Credit Amount");

                        IF VendRunningBalance > 0 THEN
                            DrCrCaption := 'Dr'
                        ELSE
                            DrCrCaption := 'Cr';

                        //<--Running Balance

                        //-->Amount in Words

                        Check1.InitTextVariable;
                        Check1.FormatNoText1(numtext1, ABS(VendRunningBalance), '');

                        //<--Amount in Words
                    end;

                    trigger OnPreDataItem()
                    begin
                        CLEAR(VendRunningBalance);
                        VendRunningBalance := VendOpeningBalance;
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    IF Number > 1 THEN
                        CopyText := Text003;
                    CurrReport.PAGENO := 1;

                    OutputNo += 1;
                end;

                trigger OnPreDataItem()
                begin
                    NoOfLoops := ABS(NoOfCopies) + 1;
                    IF NoOfLoops <= 0 THEN
                        NoOfLoops := 1;
                    CopyText := '';
                    SETRANGE(Number, 1, NoOfLoops);

                    OutputNo := 1;
                end;
            }

            trigger OnAfterGetRecord()
            var
                Pos: Integer;
            begin
                Clear(Pos);
                IF (SaveReport) OR (SaveReportPdf) THEN
                    CurrReport.QUIT;
                CompanyInfo.CALCFIELDS(Picture);
                FormatAddr.Company(CompanyAddr, CompanyInfo);
                FormatAddr.Vendor(VendorAddr, Vendor);
                RunningExist := FALSE;
                //-->Opening Balance
                VendOpeningBalance := 0.0;
                VLERec.RESET;
                CLEAR(VendOpeningBalance);
                VLERec.SETRANGE("Vendor No.", Vendor."No.");
                if StartDate <> 0D then
                    VLERec.SETFILTER("Posting Date", '<%1', StartDate)
                else begin
                    Pos := STRPOS(GETFILTER("Date Filter"), '..');
                    IF (Pos < 2) THEN
                        VLERec.SETFILTER("Posting Date", '<%1', GETRANGEMAX("Date Filter"))
                END;
                IF VLERec.FINDSET THEN
                    REPEAT
                        VLERec.CALCFIELDS("Original Amt. (LCY)");
                        VendOpeningBalance := VendOpeningBalance + VLERec."Original Amt. (LCY)";
                    UNTIL VLERec.NEXT = 0;

                //<--Opening Balance
                //->Opening Balance Dr Cr Caption
                IF VendOpeningBalance > 0 THEN
                    VendDrCrCaption := TRUE
                ELSE
                    VendDrCrCaption := FALSE;
                //<-Opening Balance Dr Cr Caption

                //
                //MESSAGE('%1|%2',VendDrCrCaption,VendOpeningBalance);

                IF CountryRegionRec.GET(Vendor."Country/Region Code") THEN
                    VendorAddress := CountryRegionRec.Name;
                CLEAR(RunningExist);

                VendorLedgerEntry.RESET;
                VendorLedgerEntry.COPYFILTERS("Vendor Ledger Entry");
                VendorLedgerEntry.SETRANGE(VendorLedgerEntry."Vendor No.", Vendor."No.");
                if StartDate <> 0D then
                    VendorLedgerEntry.SETRANGE(VendorLedgerEntry."Posting Date", StartDate, EndDate)
                else
                    VendorLedgerEntry.SETRANGE(VendorLedgerEntry."Posting Date", Vendor."Date Filter");
                IF NOT VendorLedgerEntry.FINDFIRST THEN BEGIN
                    RunningExist := TRUE;
                END;
                //MESSAGE(FORMAT(RunningExist));
                IF RunningExist THEN BEGIN
                    Check1.InitTextVariable;
                    Check1.FormatNoText(numtext2, ABS(VendOpeningBalance), '');
                    IF VendOpeningBalance > 0 THEN
                        DrCrCap := 'Dr'
                    ELSE
                        DrCrCap := 'Cr';
                END;
                //MESSAGE(numtext1[1]);
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
                    field(SaveReportPdf1; SaveReportPdf1)
                    {
                        Caption = 'Send Mail';
                        ApplicationArea = all;
                    }
                    field(StartDate; StartDate)
                    {
                        Caption = 'Starting Date';
                        ApplicationArea = All;
                    }
                    field(EndDate; EndDate)
                    {
                        Caption = 'Ending Date';
                        ApplicationArea = All;
                    }
                    field(NoOfCopies; NoOfCopies)
                    {
                        Caption = 'No. of Copy';
                        ApplicationArea = All;
                    }
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

    trigger OnPreReport()
    var
        SalesReceivablesSetup: Record 311;
        RecVendor: Record 23;
        PDFVendor: Record 23;
        AutoMailReport: Codeunit 50019;
        Ven1: Record Vendor;
    begin
        //Message('%1..%2..%3..%4', SaveReportPdf1, Vendor.GETFILTER("No."), StartDate, EndDate);
        StartDate := Vendor.GetRangeMin("Date Filter");
        EndDate := Vendor.GetRangeMax("Date Filter");
        IF StartDate <> 0D THEN BEGIN
            IF EndDate = 0D THEN
                ERROR('You Must Specify the End Date');
            //     Vendor.SetRange("Date Filter", StartDate, EndDate);
        END;
        //ELSE
        //  ERROR('You Must Specify the Start Date');
        PrintDate := 'Period From ' + FORMAT(StartDate) + ' To ' + FORMAT(EndDate);
        CompanyInfo.GET;
        //MESSAGE('%1,%2',StartDate,EndDate);
        // << Save pdf

    end;

    var
        StartDate: Date;
        EndDate: Date;
        NoOfCopies: Integer;
        NoOfLoops: Integer;
        CopyText: Text[50];
        OutputNo: Integer;
        Text003: Label 'COPY';
        CompanyAddr: array[8] of Text[50];
        CompanyInfo: Record 79;
        FormatAddr: Codeunit 365;
        Text000: Label 'Vendor Statement %1';
        VendorAddr: array[9] of Text;
        VendOpeningBalance: Decimal;
        VendRunningBalance: Decimal;
        VLERec: Record 25;
        DrCrCaption: Text;
        check1: Report 50101;
        numtext1: array[2] of Text;
        AmountInWords: Text;
        RunningDrBalance: Decimal;
        VendDrCrCaption: Boolean;
        VendorAddress: Text;
        CountryRegionRec: Record 9;
        PrintDate: Text[50];
        ReportPre: Boolean;
        SaveReport: Boolean;
        SaveReportPdf: Boolean;
        RunningBailForblank: Decimal;
        VendorLedgerEntry: Record 25;
        RunningExist: Boolean;
        numtext2: array[2] of Text;
        DrCrCap: Text;
        SaveReportPdf1: Boolean;


    procedure SetReportPreview(IsPreview: Boolean)
    begin
        SaveReport := IsPreview;
    end;

    procedure SetReportFilter(FromDate: Date; ToDate: Date)
    begin
        StartDate := FromDate;
        EndDate := ToDate;
    end;


    procedure SavePDF(PDF: Boolean)
    begin
        SaveReportPdf1 := true;
        SaveReportPdf := true;
    end;
}

