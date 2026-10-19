namespace Sampoorna_BC.Sampoorna_BC;

using Microsoft.Manufacturing.Forecast;
using Microsoft.CRM.Team;

tableextension 50101 ForLocVarExt extends "Forecast Item Variant Loc"
{
    fields
    {
        field(50000; "SalesPerson Code"; Code[50])
        {
            Caption = 'SalesPerson Code';
            DataClassification = ToBeClassified;
        }
        field(50001; "SalesPerson Filter"; Code[50])
        {
            Caption = 'SalesPerson Filter';
            FieldClass = FlowFilter;
            TableRelation = "Salesperson/Purchaser";
        }
        field(60000; "Prod. Forecast Qty (Base) New"; Decimal)
        {
            CalcFormula = sum("Production Forecast Entry"."Forecast Quantity (Base)" where("Item No." = field("No."),
                                                                                            "Production Forecast Name" = field("Production Forecast Name"),
                                                                                            "Forecast Date" = field("Date Filter"),
                                                                                            "Location Code" = field("Location Filter"),
                                                                                            "Component Forecast" = field("Component Forecast"),
                                                                                            "Variant Code" = field("Variant Filter"),
                                                                                            "SalesPerson Code" = field("SalesPerson Filter")));
            Caption = 'Prod. Forecast Quantity (Base)';
            DecimalPlaces = 0 : 5;
            FieldClass = FlowField;
        }

    }
}
