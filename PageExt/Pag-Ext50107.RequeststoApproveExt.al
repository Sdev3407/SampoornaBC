pageextension 50107 RequeststoApproveExt extends "Requests to Approve"
{
    layout
    {
        addafter("Due Date")
        {
            field("Document Type"; Rec."Document Type")
            {
                ApplicationArea = all;
            }
            field("Document No."; Rec."Document No.")
            {
                ApplicationArea = all;
            }
            field("Order Qty"; Rec."Order Qty")
            {
                ApplicationArea = All;

            }

        }
    }


    actions
    {

        modify(Approve)
        {
            trigger OnAfterAction()
            begin
                Clear(custNo);
                Clear(VendNo);
                //  Message('%1', Rec."Record ID to Approve");
                if COPYSTR((Format(Rec."Record ID to Approve")), 1, 8) = 'Customer' then
                    custNo := COPYSTR((Format(Rec."Record ID to Approve")), 11, 20);

                //>> For Customer
                RecCustomer.Reset();
                RecCustomer.SetRange(RecCustomer."No.", custNo);
                if RecCustomer.FindFirst() then begin
                    RecCustomer.Status := RecCustomer.Status::Approved;
                    RecCustomer.Modify();
                end;

                IF Rec."Document No." <> '' THEN BEGIN
                    CheckApprovalEntry.RESET;
                    CheckApprovalEntry.SETRANGE(CheckApprovalEntry."Document No.", Rec."Document No.");
                    CheckApprovalEntry.SETRANGE(CheckApprovalEntry."Sequence No.", 1);
                    CheckApprovalEntry.SETRANGE(CheckApprovalEntry.Status, CheckApprovalEntry.Status::Approved);
                    IF CheckApprovalEntry.FINDFIRST THEN BEGIN
                        DeleteApprovalEntry.RESET;
                        DeleteApprovalEntry.SETRANGE(DeleteApprovalEntry."Document No.", Rec."Document No.");
                        DeleteApprovalEntry.SETRANGE(DeleteApprovalEntry."Sequence No.", 1);
                        DeleteApprovalEntry.SETRANGE(DeleteApprovalEntry.Status, DeleteApprovalEntry.Status::Open);
                        IF DeleteApprovalEntry.FINDSET THEN
                            DeleteApprovalEntry.DELETEALL;
                    END;
                END;

            end;
        }
        modify(Reject)
        {
            trigger OnAfterAction()
            begin
                Clear(custNo);
                if COPYSTR((Format(Rec."Record ID to Approve")), 1, 8) = 'Customer' then
                    custNo := COPYSTR((Format(Rec."Record ID to Approve")), 11, 20);
                //>> For Customer

                RecCustomer.Reset();
                RecCustomer.SetRange(RecCustomer."No.", custNo);
                if RecCustomer.FindFirst() then begin
                    RecCustomer.Status := RecCustomer.Status::Open;
                    RecCustomer.Modify();
                end;

                IF Rec."Document No." <> '' THEN BEGIN
                    CheckApprovalEntry.RESET;
                    CheckApprovalEntry.SETRANGE(CheckApprovalEntry."Document No.", Rec."Document No.");
                    CheckApprovalEntry.SETRANGE(CheckApprovalEntry."Sequence No.", 1);
                    CheckApprovalEntry.SETRANGE(CheckApprovalEntry.Status, CheckApprovalEntry.Status::Rejected);
                    IF CheckApprovalEntry.FINDFIRST THEN BEGIN
                        DeleteApprovalEntry.RESET;
                        DeleteApprovalEntry.SETRANGE(DeleteApprovalEntry."Document No.", Rec."Document No.");
                        DeleteApprovalEntry.SETRANGE(DeleteApprovalEntry."Sequence No.", 1);
                        DeleteApprovalEntry.SETRANGE(DeleteApprovalEntry.Status, DeleteApprovalEntry.Status::Open);
                        IF DeleteApprovalEntry.FINDSET THEN
                            DeleteApprovalEntry.DELETEALL;
                    END;
                END;

            end;

        }

    }

    trigger OnOpenPage()
    var
        Salesorder: Record 36;
        Purchaseorder: Record 38;
    begin
        if Rec."Table ID" = 36 Then begin
            if rec."Document No." = Salesorder."No." then
                Lob := Salesorder."Shortcut Dimension 1 Code"
            else
                if Rec."Table ID" = 38 then begin
                    if rec."Document No." = Purchaseorder."No." then
                        Lob := Salesorder."Shortcut Dimension 1 Code"

                end;
        end;

    end;


    var
        RecCustomer: Record Customer;
        custNo: Code[20];
        VendNo: code[20];
        RecVendor: Record Vendor;
        CheckApprovalEntry: Record "Approval Entry";
        DeleteApprovalEntry: Record "Approval Entry";
        Lob: Text;
}