pageextension 50135 TransferListExt extends "Transfer Orders"
{

    layout

    {
        modify("Direct Transfer")
        {
            Visible = false;
        }
        moveafter("No."; "Transfer-from Code")
        moveafter("Transfer-from Code"; "Transfer-to Code")
        moveafter("Transfer-to Code"; "In-Transit Code")
        moveafter("In-Transit Code"; Status)
        moveafter(Status; "Assigned User ID")
        addafter("No.")




        {
            // field("Responsibility Center"; Rec."Responsibility Center")
            // {
            //     ApplicationArea = All;

            // }
            // field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
            // {
            //     ApplicationArea = All;

            // }
            // field("New Shortcut Dimension 1 Code"; Rec."New Shortcut Dimension 1 Code")
            // {
            //     ApplicationArea = All;

            // }
            // field("New Shortcut Dimension 2 Code"; Rec."New Shortcut Dimension 2 Code")
            // {
            //     ApplicationArea = All;

            // }
            // field("Debit Note Type"; Rec."Debit Note Type")
            // {
            //     ApplicationArea = All;

            // }
            // field("Shipped"; Rec."Shipped")
            // {
            //     ApplicationArea = All;

            // }
            // field("New LOB"; Rec."New LOB")
            // {
            //     ApplicationArea = All;

            // }
            // field("New Branch"; Rec."New Branch")
            // {
            //     ApplicationArea = All;

            // }
            // field("New Dimension Set ID"; Rec."New Dimension Set ID")
            // {
            //     ApplicationArea = All;

            // }
        }
    }

    actions
    {
        // Add changes to page actions here
        modify(Post)
        {
            trigger OnBeforeAction()
            var
                FromLocation: Record 14;
                ToLocation: Record 14;
                RecTransferLine: Record 5741;
                Workflow: Record 1501;
                GeneralLedgerSetup: Record 98;
                TransferHeader: Record "Transfer Header";
            begin
                FromLocation.Get(Rec."Transfer-from Code");
                ToLocation.get(Rec."Transfer-to Code");
                If (FromLocation."Global Dimension 1 Code" = 'FEED') and (ToLocation."Global Dimension 1 Code" = 'CBF') then Begin
                    RecTransferLine.Reset();
                    RecTransferLine.SetRange("Document No.", rec."No.");
                    RecTransferLine.SetRange("Item Category Code", 'POULTRY FD|FEED SUPPLEM|PREMIX');
                    RecTransferLine.SetRange(MRP, false);
                    If RecTransferLine.FindSet() then
                        Error('MRP is missing in Line No. %1 and Item No. %2, Please contact to Sale Accounts Team', RecTransferLine."Line No.", RecTransferLine."Item No.");
                End;



                UserSetup.RESET;
                UserSetup.SETRANGE("User ID", USERID);
                UserSetup.SETFILTER(UserSetup."Access Transfer Order", '%1', UserSetup."Access Transfer Order"::Create);
                IF UserSetup.FINDFIRST THEN
                    ERROR('You do not have Permission to Post Transfer Order');
                //PRU_DD 1.10
                UserSetup.RESET;
                UserSetup.SETRANGE("User ID", USERID);
                UserSetup.SETFILTER(UserSetup."Access Transfer Order", '%1', UserSetup."Access Transfer Order"::View);
                IF UserSetup.FINDFIRST THEN
                    ERROR('You do not have Permission to Post Transfer Order');
                //PRU_DD 1.10
                UserSetup.RESET;
                UserSetup.SETRANGE("User ID", USERID);
                UserSetup.SETFILTER(UserSetup."Access Transfer Order", '%1', UserSetup."Access Transfer Order"::" ");
                IF UserSetup.FINDFIRST THEN
                    ERROR('You do not have Permission to Post Transfer Order');
                //PRU_DD 1.10
                ////PRU-VG 110619

                IF Rec."Transfer-from Code" <> '' THEN
                    FromLocation.GET(Rec."Transfer-from Code");
                IF Rec."Transfer-to Code" <> '' THEN
                    ToLocation.GET(Rec."Transfer-to Code");

                if Rec.Shipped Then begin
                    if ToLocation."Global Dimension 1 Code" <> Rec."Shortcut Dimension 1 Code" then
                        Error('LOB Code does not matched with To location');
                    if ToLocation."Global Dimension 2 Code" <> Rec."Shortcut Dimension 2 Code" then
                        Error('Branch Code does not matched with To location');
                    if rec."Transfer-to Code" <> Rec."Shortcut Dimension 3 Code" then
                        Error('LOC Code does not matched with To location');
                end;



                ////PRU-VG 110619
                //PRU_NEELESH validation of Location Agreement end date expired 1802020
                //IF "Responsibility Center" = 'CBF' THEN BEGIN  //PRU_KH_Exp1.1_28022020
                IF FromLocation.GET(Rec."Transfer-from Code") THEN BEGIN  //PRU_KH_Exp1.1_28022020
                    IF FromLocation."Responsibility Center" = 'CBF' THEN BEGIN
                        IF FromLocation."Agreement End Date" <> 0D THEN BEGIN
                            //IF FromLocation."Agreement End Date" = TODAY THEN //PRU_KH_Exp1.1_25022020
                            IF FromLocation."Agreement End Date" <= TODAY THEN //PRU_KH_Exp_1.1_25022020
                                ERROR('Agreement End Date %1 has been expired of Farm %2', FromLocation."Agreement End Date", FromLocation.Code);
                        END;  //PRU_KH_Exp1.1_28022020
                    END;
                END;
                //END;  //PRU_KH_Exp1.1_28022020

                //IF "Responsibility Center" = 'CBF' THEN BEGIN  //PRU_KH_Exp1.1_28022020
                IF FromLocation.GET(Rec."Transfer-to Code") THEN BEGIN
                    IF FromLocation."Responsibility Center" = 'CBF' THEN BEGIN  //PRU_KH_Exp1.1_28022020
                        IF FromLocation."Agreement End Date" <> 0D THEN BEGIN
                            //IF FromLocation."Agreement End Date" = TODAY THEN //PRU_KH_Exp1.1_25022020
                            IF FromLocation."Agreement End Date" <= TODAY THEN //PRU_KH_Exp1.1_25022020
                                ERROR('Agreement End Date %1 has been expired of Farm %2', FromLocation."Agreement End Date", FromLocation.Code);
                        END;
                    END;  //PRU_KH_Exp1.1_28022020
                END;
                //END;  //PRU_KH_Exp1.1_28022020
                FromLocation.GET(Rec."Transfer-to Code");
                IF (FromLocation."Responsibility Center" = 'CBF') AND (Rec.Status = Rec.Status::Open) THEN BEGIN  //PRU_KH_Exp1.1_28022020
                    Workflow.RESET;
                    Workflow.SETRANGE(Code, 'TRANSFER');
                    Workflow.SETRANGE(Enabled, TRUE);
                    IF Workflow.FINDFIRST THEN BEGIN
                        IF FromLocation.GET(Rec."Transfer-to Code") THEN BEGIN
                            IF FromLocation."Agreement End Date" <> 0D THEN BEGIN
                                //IF (FromLocation."Agreement End Date"-TODAY) <15 THEN //PRU_KH_Exp1.1_25022020
                                IF (FromLocation."Agreement End Date" - TODAY) < GeneralLedgerSetup."Before Expiry Days" THEN //PRU_KH_Exp1.1_25022020
                                    ERROR('Please send for approval');
                            END;
                        END;
                    END;
                END;
                FromLocation.GET(Rec."Transfer-from Code");
                IF (FromLocation."Responsibility Center" = 'CBF') AND (Rec.Status = Rec.Status::Open) THEN BEGIN
                    Workflow.RESET;
                    Workflow.SETRANGE(Code, 'TRANSFER');
                    Workflow.SETRANGE(Enabled, TRUE);
                    IF Workflow.FINDFIRST THEN BEGIN
                        IF FromLocation.GET(Rec."Transfer-from Code") THEN BEGIN
                            IF FromLocation."Agreement End Date" <> 0D THEN BEGIN
                                //IF (FromLocation."Agreement End Date"-TODAY) <15 THEN //PRU_KH_Exp1.1_25022020
                                IF (FromLocation."Agreement End Date" - TODAY) < GeneralLedgerSetup."Before Expiry Days" THEN //PRU_KH_Exp1.1_25022020
                                    ERROR('Please send for approval');
                            END;
                        END;
                    END;
                END;

                //PRU_NEELESH validation of Location Agreement end date expired 1802020


            end;

        }
        modify(PostAndPrint)
        {
            Visible = false;
            trigger OnBeforeAction()
            var
                FromLocation: Record 14;
                ToLocation: Record 14;
                RecTransferLine: Record 5741;
                Workflow: Record 1501;
                GeneralLedgerSetup: Record 98;
            begin
                UserSetup.RESET;
                UserSetup.SETRANGE("User ID", USERID);
                UserSetup.SETFILTER(UserSetup."Access Transfer Order", '%1', UserSetup."Access Transfer Order"::Create);
                IF UserSetup.FINDFIRST THEN
                    ERROR('You do not have Permission to Post Transfer Order');
                //PRU_DD 1.10
                UserSetup.RESET;
                UserSetup.SETRANGE("User ID", USERID);
                UserSetup.SETFILTER(UserSetup."Access Transfer Order", '%1', UserSetup."Access Transfer Order"::View);
                IF UserSetup.FINDFIRST THEN
                    ERROR('You do not have Permission to Post Transfer Order');
                //PRU_DD 1.10
                UserSetup.RESET;
                UserSetup.SETRANGE("User ID", USERID);
                UserSetup.SETFILTER(UserSetup."Access Transfer Order", '%1', UserSetup."Access Transfer Order"::" ");
                IF UserSetup.FINDFIRST THEN
                    ERROR('You do not have Permission to Post Transfer Order');
                //PRU_DD 1.10
                ////PRU-VG 110619
                IF Rec."Transfer-from Code" <> '' THEN
                    FromLocation.GET(Rec."Transfer-from Code");
                IF Rec."Transfer-to Code" <> '' THEN
                    ToLocation.GET(Rec."Transfer-to Code");
                IF FromLocation."State Code" <> ToLocation."State Code" THEN BEGIN
                    //   TESTFIELD(Structure);
                    RecTransferLine.RESET;
                    RecTransferLine.SETCURRENTKEY("Document No.", "Line No.");
                    RecTransferLine.SETRANGE("Document No.", Rec."No.");
                    RecTransferLine.SETFILTER(Quantity, '<>%1', 0);
                    //  RecTransferLine.SETFILTER("Total GST Amount", '%1', 0);
                    RecTransferLine.SETRANGE(Exempted, FALSE);
                    IF RecTransferLine.FINDFIRST THEN
                        ERROR('GST Amount not calculated in item no. %1 and line no. %2', RecTransferLine."Item No.", RecTransferLine."Line No.");

                    RecTransferLine.RESET;
                    RecTransferLine.SETRANGE("Document No.", Rec."No.");
                    RecTransferLine.SETRANGE(Exempted, TRUE);
                    RecTransferLine.SETFILTER(Quantity, '<>%1', 0);
                    //RecTransferLine.SETRANGE("GST Base Amount", 0);
                    IF RecTransferLine.FINDFIRST THEN
                        ERROR('GST Amount not calculated in item no. %1 and line no. %2', RecTransferLine."Item No.", RecTransferLine."Line No.");
                END;
                ////PRU-VG 110619

                //PRU_NEELESH validation of Location Agreement end date expired 1802020
                //IF "Responsibility Center" = 'CBF' THEN BEGIN  //PRU_KH_Exp1.1_28022020
                IF FromLocation.GET(Rec."Transfer-from Code") THEN BEGIN  //PRU_KH_Exp1.1_28022020
                    IF FromLocation."Responsibility Center" = 'CBF' THEN BEGIN
                        IF FromLocation."Agreement End Date" <> 0D THEN BEGIN
                            //IF FromLocation."Agreement End Date" = TODAY THEN //PRU_KH_Exp1.1_25022020
                            IF FromLocation."Agreement End Date" <= TODAY THEN //PRU_KH_Exp_1.1_25022020
                                ERROR('Agreement End Date %1 has been expired of Farm %2', FromLocation."Agreement End Date", FromLocation.Code);
                        END;  //PRU_KH_Exp1.1_28022020
                    END;
                END;
                //END;  //PRU_KH_Exp1.1_28022020

                //IF "Responsibility Center" = 'CBF' THEN BEGIN  //PRU_KH_Exp1.1_28022020
                IF FromLocation.GET(Rec."Transfer-to Code") THEN BEGIN
                    IF FromLocation."Responsibility Center" = 'CBF' THEN BEGIN  //PRU_KH_Exp1.1_28022020
                        IF FromLocation."Agreement End Date" <> 0D THEN BEGIN
                            //IF FromLocation."Agreement End Date" = TODAY THEN //PRU_KH_Exp1.1_25022020
                            IF FromLocation."Agreement End Date" <= TODAY THEN //PRU_KH_Exp1.1_25022020
                                ERROR('Agreement End Date %1 has been expired of Farm %2', FromLocation."Agreement End Date", FromLocation.Code);
                        END;
                    END;  //PRU_KH_Exp1.1_28022020
                END;
                //END;  //PRU_KH_Exp1.1_28022020
                FromLocation.GET(Rec."Transfer-to Code");
                IF (FromLocation."Responsibility Center" = 'CBF') AND (Rec.Status = Rec.Status::Open) THEN BEGIN  //PRU_KH_Exp1.1_28022020
                    Workflow.RESET;
                    Workflow.SETRANGE(Code, 'TRANSFER');
                    Workflow.SETRANGE(Enabled, TRUE);
                    IF Workflow.FINDFIRST THEN BEGIN
                        IF FromLocation.GET(Rec."Transfer-to Code") THEN BEGIN
                            IF FromLocation."Agreement End Date" <> 0D THEN BEGIN
                                //IF (FromLocation."Agreement End Date"-TODAY) <15 THEN //PRU_KH_Exp1.1_25022020
                                IF (FromLocation."Agreement End Date" - TODAY) < GeneralLedgerSetup."Before Expiry Days" THEN //PRU_KH_Exp1.1_25022020
                                    ERROR('Please send for approval');
                            END;
                        END;
                    END;
                END;
                FromLocation.GET(Rec."Transfer-from Code");
                IF (FromLocation."Responsibility Center" = 'CBF') AND (Rec.Status = Rec.Status::Open) THEN BEGIN
                    Workflow.RESET;
                    Workflow.SETRANGE(Code, 'TRANSFER');
                    Workflow.SETRANGE(Enabled, TRUE);
                    IF Workflow.FINDFIRST THEN BEGIN
                        IF FromLocation.GET(Rec."Transfer-from Code") THEN BEGIN
                            IF FromLocation."Agreement End Date" <> 0D THEN BEGIN
                                //IF (FromLocation."Agreement End Date"-TODAY) <15 THEN //PRU_KH_Exp1.1_25022020
                                IF (FromLocation."Agreement End Date" - TODAY) < GeneralLedgerSetup."Before Expiry Days" THEN //PRU_KH_Exp1.1_25022020
                                    ERROR('Please send for approval');
                            END;
                        END;
                    END;
                END;

                //PRU_NEELESH validation of Location Agreement end date expired 1802020
            end;


        }
    }
    trigger OnDeleteRecord(): Boolean
    begin

        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Transfer Order", '%1', UserSetup."Access Transfer Order"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to delete Transfer Order');
        //PRU_DD 1.10
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin

        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Transfer Order", '%1', UserSetup."Access Transfer Order"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Transfer Order", '%1', UserSetup."Access Transfer Order"::Edit);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to insert Transfer Order');
        //PRU_DD 1.10
    end;

    trigger OnModifyRecord(): Boolean
    begin

        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Transfer Order", '%1', UserSetup."Access Transfer Order"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to modify Transfer Order');
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
        //<<PRU_RC
        UserSetup.GET(USERID);
        Rec.FILTERGROUP(2);
        Rec.SETFILTER("Shortcut Dimension 1 Code", UserSetup."Global Dimension 1 Code");
        Rec.SETFILTER("Shortcut Dimension 2 Code", UserSetup."Global Dimension 2 Code");
        IF NOT UserSetup."HO Users" THEN
            Rec.SETFILTER("Shortcut Dimension 3 Code", UserSetup."Shortcut Dimension 3 Code");
        Rec.FILTERGROUP(0);


        //>>RPU_RC
        //PRU_DD 1.10
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Transfer Order", '%1', UserSetup."Access Transfer Order"::" ");
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to open Transfer order');

        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Transfer Order", '%1', UserSetup."Access Transfer Order"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10
    end;

    var
        UserSetup: Record 91;

    var
        myInt: Integer;
}