pageextension 50000 CompanyInfoExt extends "Company Information"
{
    layout
    {

        addafter("Company Status")
        {


            field("SFPL_C.I.N No."; Rec."SFPL_C.I.N No.")
            {
                Caption = 'C.I.N No.';
                ApplicationArea = All;
            }
            field("SFPL_FSSAI No."; Rec."SFPL_FSSAI No.")
            {
                ApplicationArea = all;
                Caption = 'FSSAI No.';
                Visible = Visible;
            }
            field(SFPLCompany; Rec.SFPLCompany)
            {
                ApplicationArea = All;
                Caption = 'Company';
            }
            field("API Key"; Rec."API Key")
            {
                ApplicationArea = All;

            }
            field("Project ID"; Rec."Project ID")
            {
                ApplicationArea = All;
            }

        }
        addafter(Picture)
        {
            field(Watermark; Rec.Watermark)
            { }

        }
        addafter("Company Badge")
        {
            field("Disable PAN Varification API"; "Disable PAN Varification API")
            { ApplicationArea = All; }
            field(Password; Rec.Password)
            {
                ApplicationArea = All;
                ExtendedDatatype = Masked;
            }
        }
    }
    actions
    {
        addafter(Currencies)
        {
            action(testSMS)
            {
                ApplicationArea = All;
                //Caption = 'Generate API Key';

                trigger OnAction()
                var
                    SMSdetails: Codeunit 50007;
                begin
                    smsdetails.APISMSSingalNo('9759785217', '482913 is your Mcava Meats login code. It is valid for 5 minutes. Do not share it with anyone. Avl02uMTIQl',
                    '', '', '1777179281549475666')
                end;
            }




        }
    }
    trigger OnOpenPage()
    var
        Companyinfo: Record "Company Information";
        Code: Page 372;
    begin
        Visible := True;
        Companyinfo.Get;
        if Companyinfo.SFPLCompany = Companyinfo.SFPLCompany::Sampoorna then
            Visible := false;

    end;

    var
        Visible: Boolean;
        Code5005: Codeunit 50005;

}
