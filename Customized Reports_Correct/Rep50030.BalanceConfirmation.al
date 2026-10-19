report 50030 "Balance Confirmation"
{
    UsageCategory = Administration;
    Caption = 'Balance Confirmation Report';
    ApplicationArea = All;
    DefaultLayout = RDLC;

    RDLCLayout = 'ReportLayout\BalanceConfirmation.rdl';
    WordLayout = 'ReportLayout\BalanceConfirmation.docx';
    dataset
    {
        dataitem(Customer; Customer)
        {
            RequestFilterFields = "No.", "Date Filter";
            column(No_Customer; Customer."No.")
            {
            }
            column(Name_Customer; Customer.Name)
            {
            }
            column(Address_Customer; Customer.Address)
            {
            }
            column(Address2_Customer; Customer."Address 2")
            {
            }
            column(City_Customer; Customer.City)
            {
            }
            column(PhoneNo_Customer; Customer."Phone No.")
            {
            }
            column(PostCode_Customer; Customer."Post Code")
            {
            }
            column(StateCode_Customer; Cust_State)
            {
            }
            column(CountryRegionCode_Customer; Cust_Country)
            {
            }
            column(PANNo_Customer; Customer."P.A.N. No.")
            {
            }
            column(Cust_Balance; Balance)
            {
            }
            column(CurrencyCode_Customer; Customer."Currency Code")
            {
            }
            column(DRCR; DrCrCaption)
            {
            }
            column(StartDate; Format(StartDate))
            { }
            column(End_Date; FORMAT(EndDateFilter))
            {
            }
            column(GSTRegistrationNo_Customer; Customer."GST Registration No.")
            {
            }
            column(PageGroupNo; PageGroupNo)
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
                CountryName.RESET;
                IF CountryName.GET(Customer."Country/Region Code") THEN
                    Cust_Country := CountryName.Name;
                StateName.RESET;
                IF StateName.GET(Customer."State Code") THEN
                    Cust_State := StateName.Description;
                CLEAR(Balance);
                CustLedgEntryRec.RESET;
                CustLedgEntryRec.SETCURRENTKEY("Customer No.", "Posting Date");
                CustLedgEntryRec.SETRANGE("Customer No.", Customer."No.");
                CustLedgEntryRec.SETRANGE("Posting Date", 0D, EndDateFilter);
                IF CustLedgEntryRec.FINDFIRST THEN BEGIN
                    REPEAT
                        CustLedgEntryRec.CALCFIELDS("Original Amount");
                        Balance += CustLedgEntryRec."Original Amount";
                    UNTIL CustLedgEntryRec.NEXT = 0;
                END;

                IF Balance < 0 THEN
                    Balance1 := Balance * -1 ELSE
                    Balance1 := Balance;




                IF (Balance > 0) OR (Balance = 0) THEN
                    DrCrCaption := 'Dr'
                ELSE
                    DrCrCaption := 'Cr';

                //GK
                IF PrintOnlyOnePerPage THEN
                    PageGroupNo := PageGroupNo + 1;

                //MESSAGE(Customer."No.");
            end;

            trigger OnPreDataItem()
            begin
                PeriodFilter := Customer.GETFILTER("Date Filter");
                //StartDateFilter := Customer.GETRANGEMIN("Date Filter");
                //EndDateFilter := Customer.GETRANGEMAX("Date Filter");
                EndDateFilter := Customer.GETRANGEMAX("Date Filter");

                /*
                IF EndDateFilter = 0D THEN
                  EndDateVar := StartDateFilter
                ELSE
                  EndDateVar := EndDateFilter;
                  */

                //GK
                PageGroupNo := 1;
                CurrReport.NEWPAGEPERRECORD := PrintOnlyOnePerPage;

            end;
        }
    }

    requestpage
    {

        layout
        {
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
        Cust_State: Text;
        Cust_Country: Text;
        Comp_State: Text;
        Comp_Country: Text;
        PeriodFilter: Text[60];
        PeriodFilterVar1: Text;
        StartDateFilter: Date;
        EndDateFilter: Date;
        EndDateVar: Date;
        CustLedgEntryRec: Record 21;
        Balance: Decimal;
        DrCrCaption: Text;
        Balance1: Decimal;
        PageGroupNo: Integer;
        PrintOnlyOnePerPage: Boolean;
        StartDate: Date;
        EndDate: Date;

    local procedure InitializeRequest(NewPagePerCustomer: Boolean)
    begin
        PrintOnlyOnePerPage := NewPagePerCustomer;
    end;

    procedure SetReportFilter(FromDate: Date; ToDate: Date)
    begin
        StartDate := FromDate;
        EndDate := ToDate;
    end;
}

