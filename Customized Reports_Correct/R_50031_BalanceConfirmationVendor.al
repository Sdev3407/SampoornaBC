report 50031 "Balance Confirmation_Vendor"
{
    UsageCategory = Administration;
    Caption = 'Balance Confirmation Vendor Report';
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'ReportLayout\BalanceConfirmationVendor.rdl';
    dataset
    {
        dataitem(Vendor; Vendor)
        {
            RequestFilterFields = "No.", "Date Filter";
            column(No_Vendor; Vendor."No.")
            {
            }
            column(Name_Vendor; Vendor.Name)
            {
            }
            column(Address_Vendor; Vendor.Address)
            {
            }
            column(Address2_Vendor; Vendor."Address 2")
            {
            }
            column(City_Vendor; Vendor.City)
            {
            }
            column(PhoneNo_Vendor; Vendor."Phone No.")
            {
            }
            column(PostCode_Vendor; Vendor."Post Code")
            {
            }
            column(StateCode_Vendor; Vend_State)
            {
            }
            column(CountryRegionCode_Vendor; Vend_Country)
            {
            }
            column(PANNo_Vendor; Vendor."P.A.N. No.")
            {
            }
            column(Vend_Balance; Balance)
            {
            }
            column(CurrencyCode_Vendor; Vendor."Currency Code")
            {
            }
            column(DRCR; DrCrCaption)
            {
            }
            column(End_Date; FORMAT(EndDateFilter))
            {
            }
            column(GSTRegistrationNo_Vendor; Vendor."GST Registration No.")
            {
            }
            dataitem("Company Information"; "Company Information")
            {
                column(Name_CompanyInformation; "Company Information".Name)
                {
                }
                column(Address_CompanyInformation; "Company Information".Address)
                {
                }
                column(Address2_CompanyInformation; "Company Information"."Address 2")
                {
                }
                column(Picture_CompanyInformation; "Company Information".Picture)
                {
                }
                column(City_CompanyInformation; "Company Information".City)
                {
                }
                column(PostCode_CompanyInformation; "Company Information"."Post Code")
                {
                }
                column(State_CompanyInformation; Comp_State)
                {
                }
                column(CountryRegionCode_CompanyInformation; Comp_Country)
                {
                }
                column(PANNo_CompanyInformation; "Company Information"."P.A.N. No.")
                {
                }
                column(GSTRegistrationNo_CompanyInformation; "Company Information"."GST Registration No.")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    CountryName.RESET;

                    IF CountryName.GET("Company Information"."Country/Region Code") THEN
                        Comp_Country := CountryName.Name;
                    StateName.RESET;

                    IF StateName.GET("Company Information"."State Code") THEN
                        Comp_State := StateName.Description;

                end;
            }

            trigger OnAfterGetRecord()
            begin
                IF SendEmailGlobal THEN
                    CurrReport.QUIT;
                CountryName.RESET;
                IF CountryName.GET(Vendor."Country/Region Code") THEN
                    Vend_Country := CountryName.Name;
                StateName.RESET;
                IF StateName.GET(Vendor."State Code") THEN
                    Vend_State := StateName.Description;
                CLEAR(Balance);
                VendLedgEntryRec.RESET;
                VendLedgEntryRec.SETCURRENTKEY("Vendor No.", "Posting Date");
                VendLedgEntryRec.SETRANGE("Vendor No.", Vendor."No.");
                VendLedgEntryRec.SETRANGE("Posting Date", 0D, EndDateFilter);
                IF VendLedgEntryRec.FINDSET THEN BEGIN
                    REPEAT
                        VendLedgEntryRec.CALCFIELDS("Original Amount");
                        Balance += VendLedgEntryRec."Original Amount";
                    UNTIL VendLedgEntryRec.NEXT = 0;
                END;

                IF Balance < 0 THEN
                    Balance1 := Balance * -1 ELSE
                    Balance1 := Balance;




                IF (Balance > 0) OR (Balance = 0) THEN
                    DrCrCaption := 'Dr'
                ELSE
                    DrCrCaption := 'Cr';
            end;

            trigger OnPreDataItem()
            var
                Ven: Record Vendor;
            begin
                IF EndDateFilter = 0D THEN BEGIN
                    PeriodFilter := Vendor.GETFILTER("Date Filter");
                    //StartDateFilter := Vendor.GETRANGEMIN("Date Filter");
                    //EndDateFilter := Customer.GETRANGEMAX("Date Filter");
                    StartDateFilter := 0D;
                    EndDateFilter := Vendor.GETRANGEMAX("Date Filter");
                END;
                /*
                IF EndDateFilter = 0D THEN
                  EndDateVar := StartDateFilter
                ELSE
                  EndDateVar := EndDateFilter;
                  */
                IF SendEmailGlobal THEN BEGIN
                    CLEAR(AutoMailReport);
                    if Ven.Get(Vendor.GETFILTER("No.")) then
                        AutoMailReport.SendEmailConfirmation(Ven, StartDateFilter, EndDateFilter);
                END;

            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        CountryName: Record 9;
        StateName: Record State;
        Vend_State: Text;
        Vend_Country: Text;
        Comp_State: Text;
        Comp_Country: Text;
        PeriodFilter: Text[60];
        PeriodFilterVar1: Text;
        StartDateFilter: Date;
        EndDateFilter: Date;
        EndDateVar: Date;
        VendLedgEntryRec: Record 25;
        Balance: Decimal;
        DrCrCaption: Text;
        Balance1: Decimal;
        SendEmailGlobal: Boolean;
        SaveReportPdf: Boolean;
        AutoMailReport: Codeunit 50019;

    procedure SendEmailAsPdf(SendEmail: Boolean)
    begin
        SendEmailGlobal := SendEmail;
    end;


    procedure SetReportFilter(FromDate: Date; ToDate: Date)
    begin
        PeriodFilter := FORMAT(FromDate);
        EndDateFilter := ToDate;
    end;


    procedure SavePDF(PDF: Boolean)
    begin
        SaveReportPdf := PDF;
    end;
}

