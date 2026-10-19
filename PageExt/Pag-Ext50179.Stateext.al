pageextension 50179 "Stateext" extends States
{

    layout
    {
        addafter(Description)
        {
            field("From PIN Code"; Rec."From PIN Code")
            {
                ApplicationArea = All;
            }
            field("To PIN Code"; Rec."To PIN Code")
            {
                ApplicationArea = All;
            }
            field("Union Territory";Rec."Union Territory")
            {
                ApplicationArea = All;
            }
        }
    }

}