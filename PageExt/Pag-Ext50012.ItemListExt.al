pageextension 50012 ItemListExt extends "Item List"
{
    layout
    {
        addafter("No.")
        {
            field("QC Enabled"; Rec."QC Enabled")
            {
                ApplicationArea = All;

            }
            field("Chicks Item"; Rec."Chicks Item")
            {
                ApplicationArea = All;

            }

            field("Net Change"; Rec."Net Change")
            {
                ApplicationArea = All;
            }
            field("Consumption Item"; Rec."Consumption Item")
            {
                ApplicationArea = All;

            }
            field(Exempted; Exempted)
            {
                ApplicationArea = All;
            }

            field("Responsibility Center"; Rec."Responsibility Center")
            {
                ApplicationArea = All;

            }
            field("Item Type"; Rec."Item Type")
            {
                ApplicationArea = All;

            }
            field("Bag Item"; Rec."Bag Item")
            {
                ApplicationArea = All;

            }
            field("Item Tolerance"; Rec."Item Tolerance")
            {
                ApplicationArea = All;

            }
            field("CBF Item"; Rec."CBF Item")
            {
                ApplicationArea = All;

            }
            field("Feed Item"; Rec."Feed Item")
            {
                ApplicationArea = All;

            }
            field("Breed Code"; Rec."Breed Code")
            {
                ApplicationArea = All;

            }
            field(Status; Rec.Status)
            {
                ApplicationArea = All;

            }
            field("ALEX Item Code"; Rec."ALEX Item Code")
            {
                ApplicationArea = All;

            }
            field("GST Discription"; Rec."GST Discription")
            {
                ApplicationArea = All;

            }
            field("Item Location"; Rec."Item Location")
            {
                ApplicationArea = All;

            }
            field("Stock Value"; Rec."Stock Value")
            {
                ApplicationArea = All;

            }
            field("GC Rate %"; Rec."GC Rate %")
            {
                ApplicationArea = All;

            }
            field("GST Group Code"; Rec."GST Group Code")
            {
                ApplicationArea = All;

            }
            field("HSN/SAC Code"; Rec."HSN/SAC Code")
            {
                ApplicationArea = All;

            }

        }
    }

    actions
    {
        // Add changes to page actions here
    }
    trigger OnDeleteRecord(): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Item Master", '%1', UserSetup."Access Item Master"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to delete the Item');
        //PRU_DD 1.10
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Item Master", '%1', UserSetup."Access Item Master"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10
    end;

    trigger OnModifyRecord(): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Item Master", '%1', UserSetup."Access Item Master"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to modify the Item');
        //PRU_DD 1.10
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Item Master", '%1', UserSetup."Access Item Master"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10
    end;

    trigger OnOpenPage()
    var
        CRMIntegrationManagement: Codeunit 5330;
    begin

        //Pru 201220 #P0272 >>
        // Commented as per Reqrired SKS
        //  IF ("Item Category Code" = '') AND ("Product Group Code" = '') THEN
        //    CLEAR(Rec);
        //<<

        //TRI A.S 19.09.13 START
        //>>PRU_RPG
        Rec.FILTERGROUP(2);
        //CLEAR(Rec); //Pru 161220 #P0272/moved
        UserSetup.GET(USERID);
        IF (UserSetup."Global Dimension 1 Code" = 'CBF') AND (UserSetup."HO Users" = FALSE) AND (UserSetup.Department = UserSetup.Department::Production) THEN BEGIN
            CLEAR(Rec);
            Rec.SETFILTER("Location Filter", UserSetup."Shortcut Dimension 3 Code");
            IF Rec.FINDFIRST THEN BEGIN
                REPEAT
                    Rec.CALCFIELDS(Inventory);
                    IF (Rec.Inventory > 0) THEN BEGIN
                        Rec.MARK := TRUE;
                    END;
                UNTIL Rec.NEXT = 0;
                Rec.MARKEDONLY(TRUE);
            END;
        END;
        Rec.FILTERGROUP(0);
        //<<PRU_RPG
        //TRI A.S 19.09.13 STOP
        //if BaseCodeunit.CheckingItemApprovalsWorkflowEnabled(Rec) Then
        //    Rec.SetRange(Status, Rec.Status::Approved);

        //PRU_DD 1.10
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Item Master", '%1', UserSetup."Access Item Master"::" ");
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to open Item Master');

        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Item Master", '%1', UserSetup."Access Item Master"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);

        //PRU_DD 1.10
    end;

    var
        myInt: Integer;
        UserSetup: Record 91;


}