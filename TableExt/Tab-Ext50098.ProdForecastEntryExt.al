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
        
    }

}
