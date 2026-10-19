pageextension 50133 TeamsExt extends "Teams"
{
    layout
    {
        addafter(Name)
        {
            field("Team Type"; Rec."Team Type")
            {
                ApplicationArea = All;

            }
            field("Team Phone No."; Rec."Team Phone No.")
            {
                ApplicationArea = All;

            }
            field("Managment Phone No."; Rec."Managment Phone No.")
            {
                ApplicationArea = All;
                Editable = SFPLEdit;

            }
            field("E-Mail"; Rec."E-Mail")
            {
                ApplicationArea = All;

            }
            field("Delivery OTP"; Rec."Delivery OTP")
            {
                ApplicationArea = All;
                ToolTip = 'To Activate the Delivert OTP process and get OTP to customer when the sales shipment get posted';
            }
            field(Blocked; Rec.Blocked)
            {
                ApplicationArea = all;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    trigger OnOpenPage()
    var
    Begin
        if UserId <> 'JOBQUEUE' then
            SFPLEdit := False
        else
            SFPLEdit := true;


    End;

    var
        myInt: Integer;
        SFPLEdit: Boolean;
}