page 50059 "Assign Indent"
{
    // PRU-VG 1.1  10122016  Merge Indent Functionality
    // Pru-AM 1.0  22112016  Page fields editable/non editable
    // PRU-VG 2.0  28112016  Approving All indent Lines

    DeleteAllowed = false;
    PageType = Document;
    SourceTable = "Indent Header";
    ApplicationArea = All;
    UsageCategory = Documents;
    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = PageEdit;
                field("Indent No."; Rec."Indent No.")
                {
                    ApplicationArea = All;

                    trigger OnAssistEdit()
                    begin
                        /*
                        IF AssistEdit(xRec) THEN
                          CurrPage.UPDATE;
                        */

                    end;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Indent Date"; Rec."Indent Date")
                {
                    ApplicationArea = All;
                }
                field("Requested Delivery Date"; Rec."Requested Delivery Date")
                {
                    ApplicationArea = All;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                }
                field("Approval Status"; Rec."Approval Status")
                {
                    ApplicationArea = All;
                    Caption = 'Status';
                    Editable = false;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
                field("From Location"; Rec."From Location")
                {
                    ApplicationArea = All;
                }
                field("Required Location"; Rec."Required Location")
                {
                    ApplicationArea = All;
                }
                field("Required Location Name"; Rec."Required Location Name")
                {
                    ApplicationArea = All;
                }
                field("Assigned User ID"; Rec."Assigned User ID")
                {
                    ApplicationArea = All;
                }
            }
            part(IndentLine; 50022)
            {
                ApplicationArea = All;
                Caption = 'Requisition Request Lines';
                Editable = PageEdit;
                SubPageLink = "Document No." = FIELD("Indent No.");
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                action("Close Indent")
                {
                    Image = Close;
                    Promoted = true;
                    PromotedCategory = Process;
                    ApplicationArea = All;
                    trigger OnAction()
                    begin
                        //TESTFIELD("Indent Status","Indent Status"::Open);
                        //TESTFIELD("Approval Status","Approval Status"::Open);
                        IF Rec."Approval Status" = Rec."Approval Status"::Closed THEN
                            ERROR('Document is already closed');
                        IndentLine.RESET;
                        IndentLine.SETRANGE("Document No.", Rec."Indent No.");
                        //IndentLine.SETFILTER(Status,'%1',IndentLine.Status::Open);
                        IF IndentLine.FINDFIRST THEN BEGIN
                            //IF CONFIRM(Text50001,FALSE,"Indent No.") THEN
                            //BEGIN

                            IndentLine1.RESET;
                            IndentLine1.SETRANGE("Document No.", Rec."Indent No.");
                            IndentLine1.FINDSET;
                            IndentLine1.MODIFYALL("Approval Status", IndentLine1."Approval Status"::Closed);
                            Rec."Approval Status" := Rec."Approval Status"::Closed;
                            Rec.MODIFY;
                            //END;
                        END;
                        /*ELSE
                          BEGIN
                            IndentLine1.RESET;
                            IndentLine1.SETRANGE("Document No.","Indent No.");
                            IndentLine1.FINDSET;
                            IndentLine1.MODIFYALL("Approval Status",IndentLine1."Approval Status"::Closed);
                            "Approval Status" := "Approval Status"::Closed;   //PRUSB-1.00 Commented
                            MODIFY;
                          END;*/
                        //formEditable:=NOT ("Indent Status" = "Indent Status"::Closed); //PRU-AM 1.0
                        //SubformEditable :=NOT ("Indent Status"= "Indent Status"::Closed);   //PRUSB-1.00 Commented
                        PageEdit := FALSE;
                        //CurrPage.EDITABLE(FALSE);
                        CurrPage.UPDATE(FALSE);

                    end;
                }
                action("Re-Open Indent")
                {
                    Image = ReOpen;
                    Promoted = true;
                    PromotedCategory = Process;
                    ApplicationArea = All;
                    trigger OnAction()
                    begin
                        Rec.TESTFIELD("Approval Status", Rec."Approval Status"::Closed);
                        Usersetup.GET(USERID);
                        //IF NOT Usersetup."Allow Indent Line Re-open" THEN    //PRUSB-1.00 Commented
                        // ERROR(Text50003)
                        //ELSE
                        BEGIN
                            IF CONFIRM(Text50000, FALSE, Rec."Indent No.") THEN BEGIN
                                //IF CONFIRM(Text50002,FALSE,"Indent No.") THEN
                                //BEGIN
                                IndentLine1.RESET;
                                IndentLine1.SETRANGE("Document No.", Rec."Indent No.");
                                IndentLine1.FINDSET;
                                IndentLine1.MODIFYALL(Status, IndentLine1.Status::Open);
                                //END;
                                Rec."Approval Status" := Rec."Approval Status"::Open;
                                Rec.MODIFY;
                            END;
                        END;
                        //formEditable:=NOT ("Indent Status" = "Indent Status"::Closed); //PRU-AM 1.0
                        //SubformEditable :=NOT ("Indent Status" ="Indent Status"::Closed);  //PRUSB-1.00 COMMENTED
                        PageEdit := TRUE;
                        CurrPage.UPDATE(FALSE);
                    end;
                }
                action("Approve Indent Lines")
                {
                    Image = Approve;
                    Promoted = true;
                    PromotedCategory = Process;
                    ApplicationArea = All;
                    trigger OnAction()
                    var
                        IndentLine_Loc: Record "Indent Line";
                    begin
                        //PRU-VG 2.0
                        RecLocation.GET(Rec."Required Location");
                        IF (RecLocation.Grade = RecLocation.Grade::C) OR (RecLocation.Grade = RecLocation.Grade::D) THEN
                            ERROR('Fram Location is %1', RecLocation.Grade);

                        CLEAR(TotalRemainingQty);
                        CLEAR(IndentLineQty);
                        CLEAR(TotalRemainingQty1);

                        IndentLine.RESET;
                        IndentLine.SETRANGE("Document No.", Rec."Indent No.");
                        IndentLine.SETFILTER("Chicks Item", '%1', TRUE);
                        IF IndentLine.FINDFIRST THEN
                            REPEAT
                                IndentLineQty := IndentLine.Quantity;
                            UNTIL IndentLine.NEXT = 0;

                        ILE.RESET;
                        ILE.SETRANGE("Location Code", Rec."Required Location");
                        ILE.SETFILTER("Chicks Item", '%1', TRUE);
                        ILE.SETRANGE("Item No.", IndentLine."No.");
                        ILE.SETFILTER("Remaining Quantity", '>%1', 0);
                        IF ILE.FINDSET THEN BEGIN
                            ILE.CALCSUMS("Remaining Quantity");
                            TotalRemainingQty := RecLocation.Capicity - ILE."Remaining Quantity";

                            IF RecLocation.Capicity > 0 THEN
                                IF TotalRemainingQty < IndentLineQty THEN
                                    ERROR('Qty must not be greater than %1', TotalRemainingQty);
                        END;
                        //-RK-PRU

                        IF Usersetup.GET(USERID) THEN;
                        Rec.TESTFIELD("Required Location");
                        IF Rec."Approval Status" = Rec."Approval Status"::Closed THEN
                            ERROR('Approval Status must be open');
                        IF NOT Usersetup."Allow Indent Line Approval" THEN
                            ERROR(Text50004);
                        IF Usersetup."Allow Indent Line Approval" THEN BEGIN
                            IndentLine_Loc.RESET;
                            IndentLine_Loc.SETRANGE("Document No.", Rec."Indent No.");
                            //IndentLine_Loc.SETRANGE("Approval Status",IndentLine_Loc."Approval Status"::Open);
                            IndentLine_Loc.SETFILTER("Approval Status", '%1|%2', IndentLine_Loc."Approval Status"::Open, IndentLine_Loc."Approval Status"::"Pending Approval");
                            IF IndentLine_Loc.FINDFIRST THEN
                                REPEAT
                                    IndentLine_Loc.TESTFIELD(Quantity);
                                UNTIL IndentLine_Loc.NEXT = 0;
                            IndentLine_Loc.RESET;
                            IndentLine_Loc.SETRANGE("Document No.", Rec."Indent No.");
                            //IndentLine_Loc.SETRANGE("Approval Status",IndentLine_Loc."Approval Status"::Open);
                            IndentLine_Loc.SETFILTER("Approval Status", '%1|%2', IndentLine_Loc."Approval Status"::Open, IndentLine_Loc."Approval Status"::"Pending Approval");
                            IF IndentLine_Loc.FINDFIRST THEN BEGIN
                                REPEAT
                                    IndentLine_Loc."Approval Status" := IndentLine_Loc."Approval Status"::Approved;
                                    IndentLine_Loc."Approval User ID" := USERID;
                                    IndentLine_Loc."Approved Date" := WORKDATE;
                                    IndentLine_Loc.MODIFY;
                                UNTIL IndentLine_Loc.NEXT = 0;
                                Rec."Approval Status" := Rec."Approval Status"::Approved;
                                Rec."Approval User ID" := USERID;
                                Rec.MODIFY;
                            END;
                        END;

                        //PRU-VG 2.0
                    end;
                }
                action(Print)
                {
                    Caption = 'Print';
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = "Report";
                    ApplicationArea = All;
                    trigger OnAction()
                    begin
                        IndentHeader.RESET;
                        IndentHeader.SETRANGE("Indent No.", Rec."Indent No.");
                        IF IndentHeader.FINDFIRST THEN
                            REPORT.RUNMODAL(50010, TRUE, FALSE, IndentHeader);
                    end;
                }
                action(Send)
                {
                    Caption = 'Send';
                    Visible = false;
                    ApplicationArea = All;
                    trigger OnAction()
                    begin
                        //SendRecords;
                    end;
                }
                action("Send Approval Request")
                {
                    Caption = 'Send Approval Request';
                    Visible = false;
                    ApplicationArea = All;
                    trigger OnAction()
                    begin
                        Usersetup.GET(USERID);

                        IF NOT Usersetup."Allow Indent Line Approval" THEN BEGIN
                            Rec.TESTFIELD("Assigned User ID");
                            RecordLink.INIT;
                            RecordLink."Link ID" := GetLastLinkNo;
                            IndentHeader.GET(Rec."Indent No.");
                            RecordLink.URL1 := GETURL(CURRENTCLIENTTYPE, COMPANYNAME, OBJECTTYPE::Page, 50004, IndentHeader);
                            RecordLink.Description := 'Indent Order - ' + Rec."Indent No.";
                            RecordLink.Type := RecordLink.Type::Note;
                            RecordLink.Created := CURRENTDATETIME;
                            RecordLink."User ID" := USERID;
                            RecordLink.Company := COMPANYNAME;
                            RecordLink.Notify := TRUE;
                            RecordLink."To User ID" := Rec."Assigned User ID";
                            RecordLink.INSERT;
                            Rec."Approval Status" := Rec."Approval Status"::"Pending Approval";
                            IndentLine.RESET;
                            IndentLine.SETRANGE("Document No.", Rec."Indent No.");
                            IF IndentLine.FINDFIRST THEN BEGIN
                                //IndentLine."Approval Status" := IndentLine."Approval Status"::"Pending Approval";
                                IndentLine.MODIFYALL(IndentLine."Approval Status", IndentLine."Approval Status"::"Pending Approval");
                            END;
                            CurrPage.SAVERECORD;
                        END;
                        IF Usersetup."Allow Indent Line Approval" THEN BEGIN
                            Rec."Approval Status" := Rec."Approval Status"::Approved;
                            IndentLine.RESET;
                            IndentLine.SETRANGE("Document No.", Rec."Indent No.");
                            IF IndentLine.FINDFIRST THEN BEGIN
                                //IndentLine."Approval Status" := IndentLine."Approval Status"::"Pending Approval";
                                IndentLine.MODIFYALL(IndentLine."Approval Status", IndentLine."Approval Status"::Approved);
                            END;
                            CurrPage.SAVERECORD;
                        END;
                    end;
                }
                action("Issue Indent")
                {
                    ApplicationArea = All;
                    Caption = 'Issue Indent';
                    Image = IssueFinanceCharge;
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = false;

                    trigger OnAction()
                    begin
                        IF Rec."Approval Status" = Rec."Approval Status"::Issued THEN
                            ERROR('Document is already Issued');
                        IndentLine.RESET;
                        IndentLine.SETRANGE("Document No.", Rec."Indent No.");
                        //IF IndentLine.FINDFIRST THEN
                        IF IndentLine.FINDFIRST THEN BEGIN
                            REPEAT
                                Rec.TESTFIELD("From Location");
                                Rec.TESTFIELD("Required Location");
                                Rec.PostItemReclassJnl(IndentLine);
                                IndentLine."Approval Status" := IndentLine."Approval Status"::Issued;
                                IndentLine.MODIFY;
                            UNTIL IndentLine.NEXT = 0;
                            Rec."Approval Status" := Rec."Approval Status"::Issued;
                            CurrPage.SAVERECORD;
                        END;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        IF Rec."Indent Status" = Rec."Indent Status"::Closed THEN
            CurrPage.EDITABLE(FALSE);
    end;

    trigger OnAfterGetRecord()
    begin
        IF Rec."Indent Status" = Rec."Indent Status"::Closed THEN
            PageEdit := FALSE
        ELSE
            PageEdit := TRUE;
        //CurrPage.EDITABLE(FALSE);
        IF Rec."Approval Status" = Rec."Approval Status"::Approved THEN
            PageEdit := FALSE
        ELSE
            PageEdit := TRUE;
        IF Rec."Approval Status" = Rec."Approval Status"::Issued THEN
            PageEdit := FALSE
        ELSE
            PageEdit := TRUE;
    end;

    trigger OnOpenPage()
    begin
        Rec.FILTERGROUP(2);
        IF Rec."Indent Status" = Rec."Indent Status"::Closed THEN
            PageEdit := FALSE
        ELSE
            PageEdit := TRUE;
        IF Rec."Approval Status" = Rec."Approval Status"::Approved THEN
            PageEdit := FALSE
        ELSE
            PageEdit := TRUE;
        IF Rec."Approval Status" = Rec."Approval Status"::Issued THEN
            PageEdit := FALSE
        ELSE
            PageEdit := TRUE;


        /*
        //TRI A.S 19.09.13 START
          FILTERGROUP(2);
          userset.GET(USERID);
          IF NOT userset."HO Users" THEN BEGIN
            RespCntr.GET(userset."Responsibility Center");
            userset.TESTFIELD("Responsibility Center");
            SETFILTER("Responsibility Center",'%1|%2',userset."Responsibility Center",'');
            FILTERGROUP(0);
        END;
        //TRI A.S 19.09.13 STOP
        IF userset."Store Locations" <> '' THEN
          SETFILTER("From Location",userset."Store Locations");
        */

        Usersetup.GET(USERID);
        Rec.FILTERGROUP(2);
        Rec.SETRANGE("Assigned User ID", USERID);
        Rec.FILTERGROUP(0);

    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        IF Rec."Indent No." <> '' THEN
            Rec.TESTFIELD("Shortcut Dimension 1 Code");
    end;

    var
        IndentLine: Record "Indent Line";
        IndentLine1: Record "Indent Line";
        Usersetup: Record 91;
        RespCntr: Record 5714;
        userset: Record 91;
        PageEdit: Boolean;
        IndentHeader: Record "Indent Header";
        RecordLink: Record 2000000068;
        T83: Record 83;
        Text50000: Label 'Do you want to Re-open the Indent';
        Text50001: Label 'All the Indent Lines are not closed, Do you still want to close the Indent %1';
        Text50002: Label 'Do you want to Re-open all the Indent associated lines';
        Text50003: Label 'You are not authorized to re-open the indent.';
        Text50004: Label 'You do not have permission to approve the Indent line.';
        RecLocation: Record 14;
        TotalRemainingQty: Decimal;
        IndentLineQty: Decimal;
        TotalRemainingQty1: Decimal;
        ILE: Record 32;

    local procedure GetLastLinkNo(): Integer
    var
        RL: Record 2000000068;
    begin
        RL.RESET;
        IF RL.FINDLAST THEN
            EXIT(RL."Link ID" + 1)
        ELSE
            EXIT(1);
    end;
}

