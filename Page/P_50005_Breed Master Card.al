page 50005 "Breed Master Card"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Breed Master";
    // ApplicationArea = All;
    //  UsageCategory = Documents;
    layout
    {
        area(content)
        {
            group(General)
            {
                field("Breed Code"; Rec."Breed Code")
                {
                    ApplicationArea = All;

                    trigger OnAssistEdit()
                    begin
                        IF Rec.AssistEdit(xRec) THEN
                            CurrPage.UPDATE;
                    end;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
            }
            part("Breed Variation"; "Breed Variation")
            {
                ApplicationArea = All;
                SubPageLink = "Breed Code" = FIELD("Breed Code");
            }
        }
        area(factboxes)
        {
            systempart(Notes; Notes)
            {
                ApplicationArea = All;
            }
            systempart("My Notes"; MyNotes)
            {
                ApplicationArea = All;
            }
            systempart(Links; Links)
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        EditParentBreed := Rec."Is This Sub Breed";
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Breed Master", '%1', UserSetup."Access Breed Master"::Edit);
        IF UserSetup.FINDFIRST THEN
            ERROR('You can not delete the record');
        //PRU_DD 1.10
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Breed Master", '%1', UserSetup."Access Breed Master"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to insert new breed master');
        //PRU_DD 1.10
    end;

    trigger OnModifyRecord(): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Breed Master", '%1', UserSetup."Access Breed Master"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You can not modify the record');
        //PRU_DD 1.10
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Breed Master", '%1', UserSetup."Access Breed Master"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10
    end;

    trigger OnOpenPage()
    begin
        Rec.FILTERGROUP(2);
        Userset.GET(USERID);
        Userset.TESTFIELD("Responsibility Center");
        Rec.SETFILTER("Responsibility Center", '%1|%2', Userset."Responsibility Center", '');
        Rec.FILTERGROUP(0);


        //PRU_DD 1.10
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Breed Master", '%1', UserSetup."Access Breed Master"::" ");
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to open Breed Master');

        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Breed Master", '%1', UserSetup."Access Breed Master"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10
    end;

    var
        EditParentBreed: Boolean;
        Userset: Record 91;
        UserSetup: Record 91;
}

