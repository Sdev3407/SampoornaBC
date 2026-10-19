pageextension 50053 FixedAssetListExt extends "Fixed Asset List"
{
    layout
    {
        addafter(Description)
        {
            field("WIP Assets"; Rec."WIP Assets")
            {
                ApplicationArea = All;

            }
            field("Location Code"; Rec."Location Code")
            {
                ApplicationArea = all;
            }
            field("Project Code"; Rec."Project Code")
            {
                ApplicationArea = all;
            }
            field("Project Name"; Rec."Project Name")
            {
                ApplicationArea = all;
            }
            field("Sub Location"; Rec."Sub Location")
            {
                ApplicationArea = all;
            }
            field("Sub Location Name"; Rec."Sub Location Name")
            {
                ApplicationArea = all;
            }
            field(Section; Rec.Section)
            {
                ApplicationArea = all;
            }
            field("Section Name"; Rec."Section Name")
            {
                ApplicationArea = all;
            }
            field("Serial No."; Rec."Serial No.")
            {
                ApplicationArea = all;
            }
        }
    }
    actions
    {

        addafter(CalculateDepreciation)
        {

            action("Calculate Depreciation")
            {
                ApplicationArea = FixedAssets;
                Caption = 'Calculate Depreciation F';
                Ellipsis = true;
                Image = CalculateDepreciation;
                ToolTip = 'Calculate depreciation according to conditions that you specify. If the related depreciation book is set up to integrate with the general ledger, then the calculated entries are transferred to the fixed asset general ledger journal. Otherwise, the calculated entries are transferred to the fixed asset journal. You can then review the entries and post the journal.';

                trigger OnAction()
                begin
                    REPORT.RunModal(REPORT::"Calculate Depreciation SFPL", true, false, Rec);
                end;
            }
        }

    }






    var
        myInt: Integer;
}