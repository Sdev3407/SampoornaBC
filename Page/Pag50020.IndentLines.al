page 50020 "Indent Lines"
{
    // PRU-VG 1.1  10122016  Merge Indent Functionality
    // PRU-AM 1.0  21112016  lookup indent lins and insert purchase line
    // PRU-ASH1.0 191216 : Fields Added

    AutoSplitKey = true;
    DelayedInsert = true;
    DeleteAllowed = false;
    InsertAllowed = false;
    LinksAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Indent Line";
    SourceTableView = WHERE(
                            Status = FILTER(<> Close),
                            "Remaining Qty" = FILTER(> 0));
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                }
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                }
                field(RemQty; RemQty)
                {
                    ApplicationArea = All;
                    Caption = 'Remaining Qty.';
                }
                field("PO Approve Qty"; Rec."PO Approve Qty")
                {
                    ApplicationArea = All;
                    Caption = 'On PO Line Qty.';
                }
                field("PO Received Qty"; Rec."PO Received Qty")
                {
                    ApplicationArea = All;
                }
                field("Approval User ID"; Rec."Approval User ID")
                {
                    ApplicationArea = All;
                }
                field(Location; Rec.Location)
                {
                    ApplicationArea = All;
                }
                field("Approval Status"; Rec."Approval Status")
                {
                    ApplicationArea = All;
                }
                field("Approx Cost"; Rec."Approx Cost")
                {
                    ApplicationArea = All;
                }
                field("Approved Date"; Rec."Approved Date")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetCurrRecord()
    begin
        IF RemQty = 0 THEN
            RowVisibility := FALSE
        ELSE
            RowVisibility := TRUE;
    end;

    trigger OnAfterGetRecord()
    begin
        //>-PRU-VG 2.0
        Rec.CALCFIELDS("PO Approve Qty", "PO Received Qty");
        RemQty := Rec.Quantity - (Rec."PO Approve Qty" + Rec."PO Received Qty");
        //<-PRU-VG 2.0
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Indent", '%1', UserSetup."Access Indent"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have Permission to Delete Indent');
        //PRU_DD 1.10
    end;

    trigger OnInit()
    begin
        //PRU-AM 1.0
        CurrPage.LOOKUPMODE := TRUE;
        //END
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Indent", '%1', UserSetup."Access Indent"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have Permissiont to create Indent');
        //PRU_DD 1.10
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Indent", '%1', UserSetup."Access Indent"::Edit);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have Permission to Create Indent');

        //PRU_DD 1.10
    end;

    trigger OnModifyRecord(): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Indent", '%1', UserSetup."Access Indent"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have Permission to Change Indent Details');
        //PRU_DD 1.10
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Indent", '%1', UserSetup."Access Indent"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have Permission to Create Indent');
        //PRU_DD 1.10
    end;

    trigger OnOpenPage()
    begin
        //SETFILTER("Approval Status",'%1',"Approval Status"::Approved);
        //CALCFIELDS("Remaining Qty");
        UpdateIndentLines;
        //SETFILTER("Remaining Qty",'>%1',0);
        //TRI A.S 19.09.13 START
        // Rec.FILTERGROUP(2);
        // userset.GET(USERID);
        // IF userset."Responsibility Center" <> 'HO' THEN BEGIN
        //     RespCntr.GET(userset."Responsibility Center");
        //     userset.TESTFIELD("Responsibility Center");
        //     Rec.SETFILTER("Responsibility Center", '%1|%2', userset."Responsibility Center", 'HO');
        //     Rec.FILTERGROUP(0);
        // END;
        //TRI A.S 19.09.13 STOP

        //PRU_DD 1.10
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Indent", '%1', UserSetup."Access Indent"::" ");
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to open Indent');

        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Indent", '%1', UserSetup."Access Indent"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        //PRU-AM 1.0
        IF CloseAction = ACTION::LookupOK THEN
            LookupOKOnPush;
        //END
    end;

    var
        UserSetupRec: Record 91;
        ResponsibilityCenterRec: Record 5714;
        RecPurchHeader: Record 38;
        IndentLine: Record "Indent Line";
        RecPurchLine1: Record 39;
        LineNo: Integer;
        RecPurchLine: Record 39;
        RemQty: Decimal;
        RowVisibility: Boolean;
        ItemVendor: Record 99;
        userset: Record 91;
        RespCntr: Record 5714;
        Text50002: Label 'Item No. %1 can not be purchased from Vendor No. %2. Vendor No. %2 is not an Approved Vendor.';
        UserSetup: Record 91;

    procedure SetPurchHeader(PurchHeader: Record "Purchase Header")
    begin
        //PRU-AM 1.0
        //UpdateIndentLines;
        RecPurchHeader := PurchHeader;

        //END
    end;


    local procedure UpdateIndentLines()
    begin
        //PRU-AM 1.0
        /*
        IF IndentLine.GET(DocNo,LNo) THEN
        BEGIN
          IndentLine."Qty. For PO" :=0;
          RecPostedIndentLine.MODIFY;
        END;
         */
        //END
        IF IndentLine.FINDSET THEN
            REPEAT
                IndentLine.CALCFIELDS("PO Approve Qty", "PO Received Qty");
                IndentLine."Remaining Qty" := IndentLine.Quantity - (IndentLine."PO Approve Qty" + IndentLine."PO Received Qty");
                IndentLine.MODIFY;
            UNTIL IndentLine.NEXT = 0;

    end;

    local procedure LookupOKOnPush()
    var
        PurchHeader: Record 38;
        LocPurchLine: Record 39;
    begin
        //PRU-AM 1.0
        RecPurchLine1.RESET;
        RecPurchLine1.SETRANGE("Document Type", RecPurchHeader."Document Type");
        RecPurchLine1.SETRANGE("Document No.", RecPurchHeader."No.");
        IF RecPurchLine1.FINDLAST THEN
            LineNo := RecPurchLine1."Line No." + 10000
        ELSE
            LineNo := 10000;
        //SETRANGE("Close For RFQ",FALSE);
        //SETFILTER("Remaining Qty",'<>%1',0);
        CurrPage.SETSELECTIONFILTER(Rec);
        Rec.SETAUTOCALCFIELDS("PO Approve Qty", "PO Received Qty");
        IF Rec.FINDFIRST THEN
            REPEAT
                //TESTFIELD("Qty. For PO");
                IF (Rec.Quantity - (Rec."PO Approve Qty" + Rec."PO Received Qty")) <> 0 THEN BEGIN
                    //PRU-Vg 2.2
                    /*IF Type= Type::Item THEN BEGIN
                      ItemVendor.RESET;
                      ItemVendor.SETRANGE("Item No.","No.");
                      ItemVendor.SETRANGE("Vendor No.",RecPurchHeader."Buy-from Vendor No.");
                      IF NOT ItemVendor.FINDFIRST THEN
                        ERROR(Text50002,"No.",RecPurchHeader."Buy-from Vendor No.");
                    END;*/
                    //PRU-VG 2.2

                    RecPurchLine.INIT;
                    RecPurchLine."Document Type" := RecPurchHeader."Document Type";
                    RecPurchLine."Document No." := RecPurchHeader."No.";
                    IF Rec.Type = Rec.Type::Item THEN
                        RecPurchLine.Type := RecPurchLine.Type::Item
                    ELSE
                        IF Rec.Type = Rec.Type::"Fixed Asset" THEN
                            RecPurchLine.Type := RecPurchLine.Type::"Fixed Asset";

                    RecPurchLine."Line No." := LineNo;
                    RecPurchLine.VALIDATE("No.", Rec."No.");
                    RecPurchLine."Description 2" := Rec."Description 2";
                    RecPurchLine.VALIDATE("Location Code", Rec.Location);
                    //RecPurchLine.VALIDATE("PO Qty","Qty. For PO");
                    RecPurchLine."Indent No." := Rec."Document No.";
                    RecPurchLine."Indent Line No." := Rec."Line No.";
                    RecPurchLine.VALIDATE(Quantity, (Rec.Quantity - (Rec."PO Approve Qty" + Rec."PO Received Qty")));
                    //MESSAGE('%1',RecPurchLine."Line Discount %");
                    /*PurchHeader.RESET;
                    PurchHeader.SETRANGE("Document Type",PurchHeader."Document Type"::"Blanket Order");
                    PurchHeader.SETRANGE(Status,PurchHeader.Status::Released);
                    PurchHeader.SETRANGE("Buy-from Vendor No.",RecPurchHeader."Buy-from Vendor No.");
                    IF PurchHeader.FINDFIRST THEN BEGIN
                      LocPurchLine.RESET;
                      LocPurchLine.SETRANGE("Document No.",PurchHeader."No.");
                      LocPurchLine.SETRANGE(Type,Type::Item);
                      LocPurchLine.SETRANGE("No.","No.");
                      IF LocPurchLine.FINDFIRST THEN BEGIN
                        RecPurchLine."Terms & Condition" := LocPurchLine."Terms & Condition";
                        RecPurchLine."Freight Terms" := LocPurchLine."Freight Terms";
                        RecPurchLine."Packing Terms" := LocPurchLine."Packing Terms";
                        RecPurchLine."Final Inspection" := LocPurchLine."Final Inspection";
                        RecPurchLine."Others Condition" := LocPurchLine."Others Condition";
                        RecPurchLine."Delivery Term Code" := LocPurchLine."Delivery Term Code";
                        RecPurchLine."Warranty Term Code" := LocPurchLine."Warranty Term Code";
                      END;
                    END;*/
                    //RecPurchLine."Qty. to Receive" := 0;
                    //RecPurchLine."Qty. to Invoice" := 0;
                    RecPurchLine.INSERT;
                    //IF RecPurchLine."Direct Unit Cost" = 0 THEN BEGIN
                    //RecPurchLine.VALIDATE("Direct Unit Cost","Direct Unit Cost");
                    //RecPurchLine.MODIFY;
                    //END;

                END;
                LineNo += 10000;
            //"Qty. For PO":=0;  }
            //MODIFY;
            UNTIL Rec.NEXT = 0;
        Rec.RESET;
        //PRU-AM 1.0 End

    end;
}

