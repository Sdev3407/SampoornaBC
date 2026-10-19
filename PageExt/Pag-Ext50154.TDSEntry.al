pageextension 50154 TDSEntry extends "TDS Entries"
{
    layout
    {
        modify("TDS %")
        {
            Visible = false;
        }
        addafter("TDS %")
        {
            field(TDSPer; TDSPer)
            {
                DecimalPlaces = 0 : 3;
                ApplicationArea = all;
                Caption = 'TDS %';
            }
        }
    }
    trigger OnOpenPage()
    begin
        TDSPer := Rec."TDS %";
    end;

    trigger OnAfterGetRecord()
    begin
        TDSPer := Rec."TDS %";
    end;

    var
        TDSPer: Decimal;
}