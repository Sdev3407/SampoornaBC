page 50064 "ILE- Flock Check"
{
    DeleteAllowed = false;
    Editable = true;
    InsertAllowed = false;
    ModifyAllowed = true;
    PageType = List;
    SourceTable = 32;
    ApplicationArea = All;
    UsageCategory = Lists;
    Permissions = tabledata "Item Ledger Entry" = m;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Entry Type"; Rec."Entry Type")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Item Type"; Rec."Item Type")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Item Name"; Rec."Item Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Location Name"; Rec."Location Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Flock No."; Rec."Flock No.")
                {
                    ApplicationArea = All;
                    Editable = EditBool;
                    Enabled = EditBool;
                    TableRelation = "Production Order"."No." WHERE(Status = CONST(Released),
                                                                  "Location Code" = FIELD("Location Code"));

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        ProductionOrder_Rec.RESET;
                        ProductionOrder_Rec.SETRANGE(Status, ProductionOrder_Rec.Status::Released);
                        ProductionOrder_Rec.SETRANGE("Location Code", Rec."Location Code");
                        IF ProductionOrder_Rec.FINDSET THEN BEGIN
                            IF PAGE.RUNMODAL(99000815, ProductionOrder_Rec) = ACTION::LookupOK THEN
                                Rec."Flock No." := ProductionOrder_Rec."No.";
                        END;
                    end;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Data Entry Type"; Rec."Data Entry Type")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Alternate Quantity"; Rec."Alternate Quantity")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetCurrRecord()
    begin
        ///Pru_gk
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETRANGE("Edit Flock No. ILE", TRUE);
        IF UserSetup.FINDFIRST THEN
            EditBool := TRUE
        ELSE
            EditBool := FALSE;
        //Pru_gk
    end;

    trigger OnAfterGetRecord()
    begin
        ///Pru_gk
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETRANGE("Edit Flock No. ILE", TRUE);
        IF UserSetup.FINDFIRST THEN
            EditBool := TRUE
        ELSE
            EditBool := FALSE;
        //Pru_gk
    end;

    trigger OnOpenPage()
    begin
        //<<PRU_RC
        UserSetup.GET(USERID);
        Rec.FILTERGROUP(2);
        Rec.SETFILTER("Global Dimension 1 Code", UserSetup."Global Dimension 1 Code");
        Rec.SETFILTER("Global Dimension 2 Code", UserSetup."Global Dimension 2 Code");
        IF NOT UserSetup."HO Users" THEN
            Rec.SETFILTER("Location Code", UserSetup."Shortcut Dimension 3 Code");
        Rec.FILTERGROUP(0);
        //>>PRU_RC

        ///Pru_gk
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETRANGE("Edit Flock No. ILE", TRUE);
        IF UserSetup.FINDFIRST THEN
            EditBool := TRUE
        ELSE
            EditBool := FALSE;
        //Pru_gk
    end;

    var
        UserSetup: Record 91;
        EditBool: Boolean;
        ProductionOrder_Rec: Record 5405;
}

