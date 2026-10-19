pageextension 50137 TransferOrderSubformExt extends "Transfer Order Subform"
{
    layout
    {
        modify(Description)
        {
            Editable = DisableEditableStar;
        }
        modify("Transfer Price")
        {
            ApplicationArea = All;
            Editable = Editable;
        }
        modify("GST Add on Inventory")
        {

            Visible = False;
        }
        addafter("Item No.")
        {
            field(Exempted; Rec.Exempted)
            {
                ApplicationArea = all;

            }
            field("Breed Code"; Rec."Breed Code")
            {
                ApplicationArea = All;
                Visible = False;
            }
            field("RPO Created"; Rec."RPO Created")
            {
                ApplicationArea = All;
                Visible = False;

            }
            field("Chicks Item"; Rec."Chicks Item")
            {
                ApplicationArea = All;
                Visible = False;

            }
            field("Alternate Quantity"; Rec."Alternate Quantity")
            {
                ApplicationArea = All;
                Visible = False;

            }
            field("Alternate UOM"; Rec."Alternate UOM")
            {
                ApplicationArea = All;
                Visible = False;

            }
            field("Weak Bird Quantity"; Rec."Weak Bird Quantity")
            {
                ApplicationArea = All;
                Visible = False;

            }
            field("Transit Mortality Quantity"; Rec."Transit Mortality Quantity")
            {
                ApplicationArea = All;
                Visible = False;
            }
            field("Flock No."; Rec."Flock No.")
            {
                ApplicationArea = All;
            }
            field("Item Type"; Rec."Item Type")
            {
                ApplicationArea = All;
                Visible = False;

            }

            field("Flock Description"; Rec."Flock Description")
            {
                ApplicationArea = All;
                Visible = False;

            }
            field("Location State code"; Rec."Location State code")
            {
                ApplicationArea = All;
                Visible = False;

            }
            field("Derived From Line No."; "Derived From Line No.")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Total Taxable Value"; Rec."Total Taxable Value")
            {
                ApplicationArea = All;

            }
            field("New LOB"; Rec."New LOB")
            {
                ApplicationArea = All;
                Visible = False;

            }
            field("New Branch"; Rec."New Branch")
            {
                ApplicationArea = All;
                Visible = False;

            }
            field("New Dimension Set ID"; Rec."New Dimension Set ID")
            {
                ApplicationArea = All;
                Visible = False;

            }
            field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
            {
                ApplicationArea = All;

            }
        }

    }

    actions
    {
        addafter("Item &Tracking Lines")
        {
            action(CopyLines)
            {
                Caption = 'Copy Transfer Receipt Lines';
                ApplicationArea = All;
                trigger OnAction()
                begin
                    CopyLines();
                end;
            }
        }
        // Add changes to page actions here
    }

    trigger OnDeleteRecord(): Boolean
    var
        ReserveTransferLine: Codeunit 99000836;
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Transfer Order", '%1', UserSetup."Access Transfer Order"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have Permission to Delete Transfer Orders');
        //PRU_DD 1.10
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Transfer Order", '%1', UserSetup."Access Transfer Order"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have Permission to Create Transfer Orders');
        //PRU_DD 1.10
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Transfer Order", '%1', UserSetup."Access Transfer Order"::Edit);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have Permission to Create Transfer Orders');
        //PRU_DD 1.10

    end;

    trigger OnModifyRecord(): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Transfer Order", '%1', UserSetup."Access Transfer Order"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have Permission to Modify Transfer Order Details');
        //PRU_DD 1.10
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin

        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Transfer Order", '%1', UserSetup."Access Transfer Order"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10

    end;

    trigger OnOpenPage()
    begin

        CompanyInfo.Get;
        //PRU_DD 1.10
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Transfer Order", '%1', UserSetup."Access Transfer Order"::" ");
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to open Transfer Order');

        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Transfer Order", '%1', UserSetup."Access Transfer Order"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10
        IF USERID <> 'SAM304' THEN
            UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Global Dimension 1 Code", '%1', 'FEED');
        IF UserSetup.FINDFIRST THEN
            Editable := FALSE
        ELSE
            Editable := TRUE;
        DisableEditableSfpl := True;
        DisableEditableStar := true;

        if CompanyInfo.SFPLCompany in [CompanyInfo.SFPLCompany::Sampoorna] then
            DisableEditableSfpl := False
        else
            DisableEditableStar := False;


    end;

    procedure CopyLines()
    var
        TransferHeader: Record "Transfer Header";
        TransReceiptLine: Record "Transfer Receipt Line";
        TransReceiptLine1: Record "Transfer Receipt Line";
        PosTransReciptLine: Page "Posted Transfer Receipt Lines";
        ItemList: Page "Item List";
    begin

        TransferHeader.Get(Rec."Document No.");
        TransferHeader.TestField(Status, TransferHeader.Status::Open);
        TransReceiptLine.Reset();
        TransReceiptLine.SetFilter("Quantity (Base)", '<>0');
        TransReceiptLine.SetFilter("Item No.", '<>%1', '');
        TransReceiptLine.SetRange("Transfer-to Code", TransferHeader."Transfer-from Code");
        PosTransReciptLine.SetTableView(TransReceiptLine);
        PosTransReciptLine.LookupMode(true);
        if PosTransReciptLine.RunModal = ACTION::LookupOK then begin
            PosTransReciptLine.SetSelectionFilter(TransReceiptLine1);
            Window.Open(Text002 + Text003);
            if TransReceiptLine1.FindSet() then
                repeat
                    CreateLines(TransReceiptLine1, TransferHeader);
                until TransReceiptLine1.Next() = 0;
            Window.Close();
        end;
    end;

    local procedure CreateLines(RecTransferRecLine: Record "Transfer Receipt Line"; TransferHeader1: Record "Transfer Header")
    var
        LastLineNo: Integer;
        TransferLine: Record "Transfer Line";

    begin
        Clear(LastLineNo);
        // if RecTransferRecLine.FindFirst() then begin
        TransferLine.Reset();
        TransferLine.SetRange("Document No.", TransferHeader1."No.");
        if TransferLine.FindLast() then;
        LastLineNo += TransferLine."Line No.";
        // TransferLine.LockTable();
        // repeat
        LastLineNo += 10000;
        LineCount := LineCount + 1;
        Window.Update(1, LineCount);
        TransferLine."Document No." := TransferHeader1."No.";
        TransferLine."Line No." := LastLineNo;
        TransferLine.Insert(true);
        TransferLine."Item No." := RecTransferRecLine."Item No.";
        TransferLine.Validate("Item No.");
        TransferLine.Validate(Quantity, RecTransferRecLine.Quantity);
        TransferLine.Modify(true);
        // until RecTransferRecLine.Next() = 0;
        // end;

    end;

    var

        CompanyInfo: Record "Company Information";
        myInt: Integer;
        UserSetup: Record 91;
        Editable: Boolean;
        DisableEditableStar: Boolean;
        DisableEditableSfpl: Boolean;
        TransferHeader: Record 5740;
        LineCount: Integer;
        Window: Dialog;
        Text002: Label 'Creating Transfer Order Lines\';
        Text003: Label 'Inserted lines             #1######';
}