namespace Sampoorna_BC.Sampoorna_BC;

using Microsoft.Manufacturing.Forecast;
using Microsoft.CRM.Team;

tableextension 50098 ProdForecastEntryExt extends "Production Forecast Entry"
{
    fields
    {
        field(50000; "SalesPerson Code"; Code[50])
        {
            Caption = 'SalesPerson Code';
            DataClassification = ToBeClassified;
            TableRelation = "Salesperson/Purchaser".Code;
        }
        modify("Forecast Quantity (Base)")
        {
            trigger OnAfterValidate()
            var
                ProdForecast: Record "Production Forecast Name";
            begin
                // if Rec."Production Forecast Name" <> '' then begin
                //     ProdForecast.Get(Rec."Production Forecast Name");
                //     if ProdForecast."SalesPerson Filter" <> '' then
                //         Rec."SalesPerson Code" := ProdForecast."SalesPerson Filter";
                // end;
            end;
        }
    }

}
