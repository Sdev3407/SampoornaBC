pageextension 50181 "HSNSACExt" extends "HSN/SAC"
{

    layout
    {
        addafter(Type)
        {
            field("E-Way Bill Applicable"; Rec."E-Way Bill Applicable")
            {
                ApplicationArea = All;

            }


        }

    }
    trigger OnOpenPage()
    var
        myInt: Integer;
    begin


    end;

    var
        CompanyInfo: Record "Company Information";
        Visible: Boolean;

}