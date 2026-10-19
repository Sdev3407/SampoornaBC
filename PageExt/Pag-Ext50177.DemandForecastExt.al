// namespace Sampoorna_BC.Sampoorna_BC;

// using Microsoft.Manufacturing.Forecast;
// using Microsoft.Finance.Analysis;
// using Microsoft.Foundation.Enums;
// using Microsoft.CRM.Team;

// pageextension 50177 DemandForecastExt extends "Demand Forecast Card"
// {
//     layout
//     {
//         addafter("Date Filter")
//         {
//             field("Forecast By SalesPerson"; Rec."Forecast By SalesPerson")
//             {
//                 ApplicationArea = Planning;
//                 Caption = 'Forecast by Sales Person';
//                 ToolTip = 'Specifies whether to create a forecast entry that includes Sales Person.';
//                 Importance = Additional;

//                 trigger OnValidate()
//                 begin
//                     SalesPersonFilterIsEnabled := Rec."Forecast By SalesPerson";
//                     if not Rec."Forecast By SalesPerson" then
//                         SalesPersonFilter := '';
//                     SetMatrix();
//                 end;
//             }
//             field("SalesPerson Filter"; "SalesPerson Filter")
//             {
//                 Caption = 'Sales Person Filter';
//                 ApplicationArea = All;
//                 Enabled = SalesPersonFilterIsEnabled;
//                 Editable = IsEditable;

//                 trigger OnValidate()
//                 var
//                     SP: Record "Salesperson/Purchaser";
//                 begin
//                     SetMatrix();
//                 end;
//             }
//             part(Matrix1; "DD Forecast Variant Matrix New")
//             {
//                 ApplicationArea = Planning;
//                 Editable = IsEditable;
//                 Visible = not IsVisible;
//             }


//         }
//         // modify(Name)
//         // {
//         //     trigger OnAfterValidate()
//         //     begin
//         //         SetMatrix1();
//         //     end;
//         // }
//         // modify("View By")
//         // {
//         //     trigger OnAfterValidate()
//         //     begin
//         //         SetMatrixColumns1("Matrix Page Step Type"::Initial);
//         //     end;
//         // }
//         modify(Matrix)
//         {
//             Visible = IsVisible;
//         }
//     }
//     trigger OnAfterGetRecord()
//     begin
//         // SalesPersonFilter := Rec.GetSalesPersonFilterBlobAsText();
//         SalesPersonFilterIsEnabled := Rec."Forecast By SalesPerson";
//     end;



//     protected procedure SetMatrix1()
//     begin
//         CurrPage.Matrix1.PAGE.Load(MatrixColumnCaptions, MatrixRecords, Rec.Name, Rec."Date Filter", Rec."Forecast Type", Rec."Quantity Type", CurrentSetLength, Rec.GetItemFilterBlobAsViewFilters(), Rec.GetLocationFilterBlobAsText(), Rec."Forecast By Locations", Rec."Forecast By Variants", Rec.GetVariantFilterBlobAsText());
//     end;

//     protected procedure SetMatrixColumns1(StepType: Enum "Matrix Page Step Type")
//     var
//         MatrixMgt: Codeunit "Matrix Management";
//     begin
//         MatrixMgt.GeneratePeriodMatrixData(StepType.AsInteger(), ArrayLen(MatrixRecords), false, Rec."View By", Rec."Date Filter", PKFirstRecInCurrSet, MatrixColumnCaptions, ColumnSet, CurrentSetLength, MatrixRecords);
//         SetMatrix1();
//     end;

//     var
//         SalesPersonFilterIsEnabled: Boolean;
//         SalesPersonFilter: Text;
//         IsVisible: Boolean;
// }
