namespace Sampoorna_BC.Sampoorna_BC;

using Microsoft.Manufacturing.Forecast;
using Microsoft.CRM.Team;

tableextension 50103 ProdForecastNameExt extends "Production Forecast Name"
{
    fields
    {
        field(50000; "SalesPerson Filter"; Code[50])
        {
            Caption = 'Sales Person Filter';
            TableRelation = "Salesperson/Purchaser";
        }
        field(50001; "Forecast By SalesPerson"; Boolean)
        {
            Caption = 'Forecast by Sales Person';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                if not "Forecast By SalesPerson" then begin
                    "SalesPerson Filter" := '';
                    Modify();
                end;
            end;
        }
    }
}
