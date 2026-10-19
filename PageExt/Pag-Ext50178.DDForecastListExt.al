namespace Sampoorna_BC.Sampoorna_BC;

using Microsoft.Manufacturing.Forecast;

pageextension 50178 DDForecastListExt extends "Demand Forecast Names"
{
    actions
    {
        addafter("Edit Demand Forecast")
        {
            action("Edit Demand Forecast New")
            {
                ApplicationArea = Planning;
                Caption = 'Edit Demand Forecast New';
                Image = EditForecast;
                // ShortCutKey = 'Return';
                //Promoted = true;
                Visible = true;
                //PromotedIsBig = True;
                ToolTip = 'Open the related demand forecast.';

                trigger OnAction()
                var
                    DemandForecastCard: Page "Demand Forecast Card New";
                begin
                    DemandForecastCard.SetRecord(Rec);
                    DemandForecastCard.Run();
                end;
            }
        }
        modify("Edit Demand Forecast")
        {
            Visible = false;
        }
        modify("Edit Demand Forecast_Promoted")
        {
            Visible = False;
        }



    }



}
