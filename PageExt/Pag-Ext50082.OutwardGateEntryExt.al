pageextension 50082 OutwardGateEntryExt extends "Outward Gate Entry"
{
    layout
    {
        addafter("Vehicle No.")
        {
            field("Posting No. Series"; Rec."Posting No. Series")
            {
                ApplicationArea = all;
            }
            field("Gross Weight"; Rec."Gross Weight")
            {
                ApplicationArea = All;
            }
            field("Tier Weight"; Rec."Tier Weight")
            {
                ApplicationArea = All;
            }
            field("Net Weight"; Rec."Net Weight")
            {
                ApplicationArea = All;
            }
            field("Per Bag Freight Charges"; Rec."Per Bag Freight Charges")
            {
                ApplicationArea = All;
            }
            field("Total Freight Amount"; Rec."Total Freight Amount")
            {
                ApplicationArea = All;
            }
            field("Transporter Name"; Rec."Transporter Name")
            {
                ApplicationArea = All;
            }
            field("No. of Bags"; Rec."No. of Bags")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
        modify("Po&st")
        {
            Visible = false;
        }
        // Add changes to page actions he
        addafter("Po&st")
        {
            action("Post")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Po&st';
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                ShortCutKey = 'F9';
                trigger OnAction()
                var
                    GateENtryPost: Codeunit "Gate Entry- Post (Yes/No)";
                    UserSetup: Record "User Setup";
                    AllowPostingFrom: Date;
                    AllowPostingTo: Date;
                    CompanyInfo: Record "Company Information";
                begin
                    CompanyInfo.Get();
                    //GK27052021-
                    CLEAR(AllowPostingFrom);
                    CLEAR(AllowPostingTo);
                    IF UserSetup.GET(USERID) THEN
                        AllowPostingFrom := UserSetup."Allow Posting From";
                    AllowPostingTo := UserSetup."Allow Posting To";
                    if CompanyInfo.SFPLCompany in [CompanyInfo.SFPLCompany::Sampoorna] Then
                        IF NOT ((AllowPostingFrom <= Rec."Posting Date") AND (AllowPostingTo >= Rec."Posting Date")) THEN
                            ERROR('Posting Date is not within your range of allowed posting dates.');
                    //GK27052021+
                    GateENtryPost.Run(Rec);
                end;
            }
        }
    }

    trigger OnDeleteRecord(): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Gate In & Gate Out", '%1', UserSetup."Access Gate In & Gate Out"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Gate In & Gate Out", '%1', UserSetup."Access Gate In & Gate Out"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Gate In & Gate Out", '%1', UserSetup."Access Gate In & Gate Out"::Edit);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have Permission to Enter Gate Entry Details');
        //PRU_DD 1.10
    end;

    trigger OnModifyRecord(): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Gate In & Gate Out", '%1', UserSetup."Access Gate In & Gate Out"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not  have Permission to Change Gate Entry Details');
        //PRU_DD 1.10
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Gate In & Gate Out", '%1', UserSetup."Access Gate In & Gate Out"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10
    end;

    trigger OnOpenPage()
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Gate In & Gate Out", '%1', UserSetup."Access Gate In & Gate Out"::" ");
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to view Outward Gate Entry');
        //PRU_DD 1.10
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Gate In & Gate Out", '%1', UserSetup."Access Gate In & Gate Out"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10
    end;

    var
        UserSetup: Record 91;
        AllowPostingFrom: Date;
        AllowPostingTo: Date;
}