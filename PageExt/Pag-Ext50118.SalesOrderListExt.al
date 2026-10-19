pageextension 50118 SalesOrderListExt extends "Sales Order List"
{
    layout
    {
        moveafter("Sell-to Customer No."; "Sell-to Customer Name")
        moveafter("External Document No."; Amount)
        moveafter(Amount; "Location Code")
        moveafter("Location Code"; Status)
        moveafter(Status; "Completely Shipped")
        addafter("Completely Shipped")
        {
            field("Last Shipping No."; rec."Last Shipping No.")
            {
                ApplicationArea = all;
            }
            field("Order Date"; Rec."Order Date")
            {
                ApplicationArea = all;
            }
        }

        modify("No.")
        {
            Style = Favorable;
            StyleExpr = ColourCondition;
        }

    }

    actions
    {
        modify(SendApprovalRequest)
        {
            ApplicationArea = all;
            Visible = false;
        }
        modify(Release)
        {
            ApplicationArea = all;
            Visible = false;
        }

    }

    var
        myInt: Integer;

    trigger OnOpenPage()
    var
        UserSetup: Record "User Setup";
    begin
        CompanyInfo.Get;
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Sales Order", '%1', UserSetup."Access Sales Order"::" ");
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to view Sales Order');
        //PRU_DD 1.10

        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Sales Order", '%1', UserSetup."Access Sales Order"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10
        //<<PRU_RC
        If CompanyInfo.SFPLCompany = CompanyInfo.SFPLCompany::Sampoorna then Begin
            UserSetup.GET(USERID);
            if (UserId <> 'JOBQUEUE') and (UserId <> 'SAM4496') and (UserId <> 'SAM1586') and (UserId <> 'SAM4834') Then begin
                if not UserSetup."Sales Team Leader" Then begin
                    if not UserSetup."Salesperson User" then begin
                        Rec.FILTERGROUP(2);
                        Rec.SETFILTER("Shortcut Dimension 1 Code", UserSetup."Global Dimension 1 Code");
                        Rec.SETFILTER("Shortcut Dimension 2 Code", UserSetup."Global Dimension 2 Code");
                        IF NOT UserSetup."HO Users" THEN
                            Rec.SETFILTER("Shortcut Dimension 3 Code", UserSetup."Shortcut Dimension 3 Code");
                    end else
                        IF UserSetup."Salesperson User" THEN begin
                            Rec.FilterGroup(2);
                            Rec.SetFilter("Salesperson Code", UserSetup."Sales Person Code");
                            Rec.SETFILTER("Shortcut Dimension 3 Code", UserSetup."Shortcut Dimension 3 Code");
                        end;
                end else
                    if UserSetup."Sales Team Leader" Then begin
                        Rec.FilterGroup(2);
                        Rec.SetFilter("Team Code", UserSetup."Sales Team Code");
                        Rec.SETFILTER("Shortcut Dimension 3 Code", UserSetup."Shortcut Dimension 3 Code");
                    end;
            end;
        end;
        //>>PRU_RC
    end;

    trigger OnAfterGetRecord()
    var
        UserSetup: Record "User Setup";
    begin

        IF Rec.Status = Rec.Status::Released THEN
            ColourCondition := TRUE
        ELSE
            ColourCondition := FALSE;

        // UserSetup.Get(UserId);
        // IF UserSetup."Salesperson User" THEN
        //     //if UserSetup."Sales Person Code" <> '' then
        //     //Rec.SETRANGE("Salesperson Code", USERID);// Suman 15-03-2025
        //     Rec.SetFilter("Salesperson Code", '%1', UserSetup."Sales Person Code");


    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    var
        UserSetup: record "User Setup";
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Sales Order", '%1', UserSetup."Access Sales Order"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var
        UserSetup: record "User Setup";
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Sales Order", '%1', UserSetup."Access Sales Order"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);

        Rec.Validate("Shipment Method Code", 'ROAD');
        Rec.Validate("Vehicle Type", rec."Vehicle Type"::Regular);
    end;

    trigger OnModifyRecord(): Boolean
    var
        UserSetup: record "User Setup";
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Sales Order", '%1', UserSetup."Access Sales Order"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have Permission to Change the Sales Order Details');
    end;

    trigger OnDeleteRecord(): Boolean
    var
        UserSetup: record "User Setup";
    begin
        //UserSetup.RESET;
        //UserSetup.SETRANGE("User ID", USERID);
        //UserSetup.SETFILTER(UserSetup."Access Sales Order", '%1', UserSetup."Access Sales Order"::View);
        //IF UserSetup.FINDFIRST THEN
        ERROR('You do not have Permission to Delete the Sales Order');
    end;

    var
        ColourCondition: Boolean;
        CompanyInfo: Record "Company Information";
}