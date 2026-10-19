namespace Sampoorna_BC.Sampoorna_BC;

using System.Utilities;
using Microsoft.Purchases.Document;
using Microsoft.Finance.Dimension;
using Microsoft.Sales.History;
using Microsoft.Foundation.Company;

report 50133 "Performance Report Auto"
{
    ApplicationArea = All;
    Caption = 'Performance Report Auto';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'ReportLayout\PerformanceReportAuto.rdl';

    dataset
    {
        dataitem("GC Statement"; "GC Statement")

        {
            DataItemTableView = SORTING("No.")
                                    WHERE(Posted = filter(true));
            column(StartDate; StartDate)
            { }
            column(EndDate; EndDate)
            { }
            column(Region; RegionName)
            { }
            column(Company; Company)
            { }
            column(No_; "No.")
            {

            }
            column(Chick_Housed; "Chick Housed")
            {

            }
            column(FCR; FCR)
            { }
            column(CFCR; CFCR)
            { }
            column(TOTAL_COST_OF_PRODUCTION2; "TOTAL COST OF PRODUCTION2")
            { }
            column(TOTAL_AMOUNT_PAYABLE; "TOTAL AMOUNT PAYABLE")
            { }
            column(Feed_Consumption_kgs_; "Feed Consumption(kgs)")
            { }
            column(Birds_Sold__kg_; "Birds Sold (kg)")
            { }
            column(Birds_Sold__Nos_; "Birds Sold (Nos)")
            { }
            column(Mortality; Mortality)
            { }
            column(Mean_Age; "Mean Age")
            { }
            column(Mortality__; "Mortality %")
            { }
            column(EEF; EEF)
            { }
            column(Production_Cost; "Production Cost")
            { }
            column(BranchName; BranchName)
            { }
            column(Sale_Amount; "Sale Amount")
            { }

            trigger OnPreDataItem()
            begin
                SetRange("GC Statement"."Liquidation Date", StartDate, EndDate);
                If RecRegion <> '' Then
                    SetRange("GC Statement".Region, RecRegion);
            end;


            trigger OnAfterGetRecord()
            var
                Dimension: Record "Dimension Value";
                VarRegion: Record Region;

            begin
                CompanyInfo.Get;
                Company := CompanyInfo.Name;

                Dimension.Reset();
                Dimension.SetRange("Global Dimension No.", 2);
                Dimension.SetRange(Code, "Shortcut Dimension 2 Code");
                if Dimension.FindFirst() Then
                    BranchName := Dimension.Name;
                if RecRegion <> '' Then begin
                    VarRegion.Reset();
                    VarRegion.SetRange(VarRegion."Region Code", "GC Statement".Region);
                    if VarRegion.FindFirst() Then
                        RegionName := VarRegion."Region Name"
                end else
                    RegionName := 'All Region'

            end;
        }
    }
    requestpage
    {

        layout
        {
            area(Content)
            {
                field(StartDate; StartDate)
                {
                    ApplicationArea = All;
                    Caption = 'Start Date';
                }
                field(EndDate; EndDate)
                {
                    ApplicationArea = All;
                    Caption = 'End Date';
                }
                field(RecRegion; RecRegion)
                {
                    ApplicationArea = All;
                    Caption = 'Region';
                }
            }
        }
        trigger OnOpenPage()
        var
            myInt: Integer;
        begin

            StartDate := CalcDate('-CM', Today);
            EndDate := Today() - 1;


        end;

    }
    procedure SetReportFilter(FromDate: Date; ToDate: Date; GCRegion: Text[10])
    begin
        StartDate := FromDate;
        EndDate := ToDate;
        RecRegion := GCRegion;
    end;



    var
        Company: Text;
        CompanyInfo: record "Company Information";
        BranchName: Text;
        StartDate: Date;
        EndDate: Date;
        FCR: Decimal;
        RecRegion: text[10];
        RegionName: Text;
}