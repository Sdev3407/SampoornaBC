pageextension 50126 ShiptoAddressExt extends "Ship-to Address"
{
    layout
    {
        modify("Shipment Method Code")
        {
            Visible = false;
        }
        modify("Shipping Agent Code")
        {
            Visible = false;
        }
        modify("Shipping Agent Service Code")
        {
            Visible = false;
        }
        modify("Service Zone Code")
        {
            Visible = false;
        }
        modify(GLN)
        {
            Visible = false;
        }
        modify(County)
        {
            Visible = false;
        }
        modify("Fax No.")
        {
            Visible = false;
        }
        modify("Home Page")
        {
            Visible = false;
        }
        modify("Location Code")
        {
            Visible = false;
        }
        modify(State)
        {
            ShowMandatory = true;
        }
        modify("Post Code")
        {
            ShowMandatory = true;
        }
        modify("Phone No.")
        {
            ShowMandatory = true;
        }
        addafter("Location Code")
        {
            field(Landmark; Rec.Landmark)
            {
                ApplicationArea = all;
                ShowMandatory = true;
            }
        }

    }

    actions
    {
        // Add changes to page actions here
    }



    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Ship to Address", '%1', UserSetup."Access Ship to Address"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        if ((Rec.State <> '') and (rec.Landmark <> '') and (rec."Post Code" <> '')) then begin

            exit(true); // or false
        end else
            if (Rec.State = '') then
                Error('Please update the %1 field', Rec.FieldCaption(State))
            else if (Rec.Landmark = '') then
                Error('Please update the %1 field', Rec.FieldCaption(Landmark))
            else if (rec."Post Code" = '') then
                Error('Please update the %1 field', Rec.FieldCaption("Post Code"));
        exit(false);
    end;



    var
        myInt: Integer;
        UserSetup: Record 91;
}