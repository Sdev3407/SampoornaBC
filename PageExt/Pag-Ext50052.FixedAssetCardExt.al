pageextension 50052 FixedAssetCardExt extends "Fixed Asset Card"
{
    layout
    {
        addafter(General)
        {
            group(SFPL)
            {
                field("WIP Assets"; Rec."WIP Assets")
                {
                    ApplicationArea = All;

                }
                field("Old No. Series"; Rec."Old No. Series")
                {
                    ApplicationArea = all;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = all;
                }
                field("Project Code"; Rec."Project Code")
                {
                    ApplicationArea = All;
                    ShowMandatory = True;
                }
                field("Project Name"; "Project Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Sub Location"; Rec."Sub Location")
                {
                    ApplicationArea = All;
                    ShowMandatory = True;
                }
                field("Sub Location Name"; Rec."Sub Location Name")
                {
                    ApplicationArea = All;
                    Editable = False;
                }
                field(Section; Rec.Section)
                {
                    ApplicationArea = All;
                    ShowMandatory = True;
                }
                field("Section Name"; Rec."Section Name")
                {
                    ApplicationArea = All;
                    Editable = False;
                }
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}