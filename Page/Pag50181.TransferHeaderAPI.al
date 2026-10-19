page 50181 "Transfer HeaderAPI"
{
    ApplicationArea = All;
    Caption = 'Transfer HeaderAPI';
    EntityName = 'TransferHeaderAPI';
    EntitySetName = 'TransferHeaderAPI';
    DelayedInsert = true;
    PageType = API;
    SourceTable = "Transfer Header";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No_"; Rec."No.")
                {
                    ApplicationArea = Location;
                    Importance = Promoted;
                    ToolTip = 'Specifies the number of the involved entry or record, according to the specified number series.';

                }
                field("Transfer_fro_Code"; Rec."Transfer-from Code")
                {
                    ApplicationArea = Location;
                    ShowMandatory = true;
                    Importance = Promoted;
                    ToolTip = 'Specifies the code of the location that items are transferred from.';
                    // trigger OnValidate()
                    // begin
                    //     if "No." = '' then begin
                    // TestNoSeries();
                    // NoSeriesMgt.InitSeries(GetNoSeriesCode(), xRec."No. Series", "Posting Date", "No.", "No. Series");
                    // end;
                    //end;
                }
                field("Transfer_to_Code"; Rec."Transfer-to Code")
                {
                    ApplicationArea = Location;
                    ShowMandatory = true;
                    Importance = Promoted;
                    ToolTip = 'Specifies the code of the location that the items are transferred to.';
                }
                field("Direct_Transfer"; Rec."Direct Transfer")
                {
                    ApplicationArea = Location;

                    Importance = Promoted;
                    ToolTip = 'Specifies that the transfer does not use an in-transit location. When you transfer directly, the Qty. to Receive field will be locked with the same value as the quantity to ship.';

                }
                field("In_Transit_Code"; Rec."In-Transit Code")
                {
                    ApplicationArea = Location;
                    ShowMandatory = not Rec."Direct Transfer";
                    Enabled = (not Rec."Direct Transfer") AND (Rec.Status = Rec.Status::Open);
                    ToolTip = 'Specifies the in-transit code for the transfer order, such as a shipping agent.';

                }
                field("PostingDate"; Rec."Posting Date")
                {
                    ApplicationArea = Location;
                    ToolTip = 'Specifies the posting date of the transfer order.';

                    // trigger OnValidate()
                    // begin
                    //     PostingDateOnAfterValidate();
                    // end;
                }
                field("Shortcut_Dimension1Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = Dimensions;
                    // Editable = EnableTransferFields;
                    Importance = Additional;
                    ToolTip = 'Specifies the code for Shortcut Dimension 1, which is one of two global dimension codes that you set up in the General Ledger Setup window.';
                }
                field("ShortcutDimension2Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = Dimensions;
                    // Editable = EnableTransferFields;
                    Importance = Additional;
                    ToolTip = 'Specifies the code for Shortcut Dimension 2, which is one of two global dimension codes that you set up in the General Ledger Setup window.';
                }

                field(Status; Rec.Status)
                {
                    ApplicationArea = Location;
                    Importance = Promoted;
                    ToolTip = 'Specifies whether the transfer order is open or has been released for warehouse handling.';
                }
                field("Vehicle_No_"; Rec."Vehicle No.")
                {
                    ApplicationArea = all;
                }

                field("LR_RR_No_"; Rec."LR/RR No.")
                {
                    ApplicationArea = all;
                }
                field("LR_RR_Date"; Rec."LR/RR Date")
                {
                    ApplicationArea = all;
                }
                field("Transporter_Code"; Rec."Transporter Code")
                {
                    ApplicationArea = All;
                }
                field("Transporter_Name"; Rec."Transporter Name")
                {
                    ApplicationArea = All;
                }
                field("Distance_Km_"; Rec."Distance (Km)")
                {
                    ApplicationArea = All;
                }

            }
        }
    }

    var
        NoSeriesMgt: Codeunit NoSeriesManagement;
}