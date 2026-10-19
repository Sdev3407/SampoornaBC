pageextension 50051 ApprovalRequestEntriesExt extends "Approval Request Entries"
{
    layout
    {
        addafter("Document Type")
        {
            field("Order Qty"; Rec."Order Qty")
            {
                ApplicationArea = All;

            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }
    trigger OnOpenPage()
    begin
        IF Usersetup.GET(USERID) THEN
            IF NOT Usersetup."Approval Administrator" THEN BEGIN
                Rec.FILTERGROUP(2);
                Rec.SETCURRENTKEY("Approver ID");
                Rec.SETFILTER("Approver ID", '=%1', Usersetup."User ID");
                Rec.FILTERGROUP(0);
            END;
    end;

    var
        myInt: Integer;
        Usersetup: Record 91;
}