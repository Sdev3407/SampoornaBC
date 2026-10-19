pageextension 50134 "Team salespeople" extends "Team Salespeople"
{
    layout
    {
        addbefore("Salesperson Code")
        {
            field("Team Code"; Rec."Team Code")
            {
                ApplicationArea = All;
            }
        }
    }
}