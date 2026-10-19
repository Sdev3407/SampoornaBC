pageextension 50073 GSTRegistrationNosExt extends "GST Registration Nos."
{
    layout
    {
        addafter("Code")
        {

            field("E-Invoicing User Name"; Rec."E-Invoicing User Name")
            {
                ApplicationArea = All;

            }
            field("E-Invoicing User Password"; Rec."E-Invoicing User Password")
            {
                ApplicationArea = All;

            }
            field("E-Way Bill User Name"; Rec."E-Way Bill User Name")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the E-Way Bill User Name field.', Comment = '%';
            }
            field("E-Way User Password"; Rec."E-Way User Password")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the E-Way User Password field.', Comment = '%';
            }
            field("Login USER ID"; Rec."Login USER ID")
            {
                ApplicationArea = All;
            }

        }
    }

    actions
    {
        addfirst(Processing)
        {
            action("OTP Send and Varify")
            {
                Caption = 'OTP Send and Varify';
                ApplicationArea = all;
                trigger OnAction()
                var
                    CUIMS: Codeunit IMS;
                begin
                    CUIMS.OTPReqeust(Rec.Code, Rec."Login USER ID");
                end;
            }

        }
    }

    var
        myInt: Integer;

}