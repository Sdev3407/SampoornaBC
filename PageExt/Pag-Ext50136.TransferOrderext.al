pageextension 50136 TransferOrderext extends "Transfer Order"
{
    layout
    {

        modify("Load Unreal Prof Amt on Invt.")
        {
            Visible = false;
        }
        modify("No.")
        {
            Visible = true;
        }
        modify("Direct Transfer")
        {
            Visible = false;
        }
        moveafter("No."; "Transfer-from Code")
        moveafter("Transfer-from Code"; "Transfer-to Code")
        //moveafter("External Document No.";"In-Transit Code")
        addafter("Transfer-to Code")
        {
            field("External Document No."; rec."External Document No.")
            {
                ApplicationArea = all;
            }
            field("Freight Value"; Rec."Freight Value")
            {
                ApplicationArea = all;
            }
        }
        moveafter("External Document No."; "In-Transit Code")
        moveafter("In-Transit Code"; "Posting Date")
        moveafter("Posting Date"; "Assigned User ID")
        moveafter("Assigned User ID"; Status)
        moveafter(Status; "Vehicle No.")
        moveafter("Vehicle No."; "LR/RR No.")
        addafter("LR/RR No.")
        {
            field("Debit Note Type"; rec."Debit Note Type")
            {
                ApplicationArea = all;
            }
            field(Shipped; rec.Shipped)
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("New LOB"; rec."New LOB")
            {
                ApplicationArea = all;
                Editable = DimEdit;
            }
            field("New Branch"; rec."New Branch")
            {
                ApplicationArea = all;
                Editable = DimEdit;
            }
            field("Shortcut Dimension 3 Code"; rec."Shortcut Dimension 3 Code")
            {
                ApplicationArea = all;
            }
        }
        //Transfer form
        //SIM
        addlast(General)
        {
            field("Transporter Code"; Rec."Transporter Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Transporter Code field.', Comment = '%';
                // trigger OnLookup(var Text: Text): Boolean
                // var
                //     Cust: Record Vendor;
                //     CustList: Page "Vendor List";
                //     UserSetupRec: Record "User Setup";
                // begin
                //     // Cust.Reset();
                //     // Cust.SetFilter(Cust.Transporter, '%1', true);
                //     // CustList.SETTABLEVIEW(Cust);
                //     // CustList.LOOKUPMODE := TRUE;
                //     // IF CustList.RUNMODAL = ACTION::LookupOK THEN begin
                //     //     CustList.GetRecord(Cust);
                //     //     Rec.Validate("Transporter Code", Cust."No.");
                //     // END;
                //     exit(LookupTransporterName(text));
                // END;

            }
            field("Transporter Name"; Rec."Transporter Name")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Transporter Name field.', Comment = '%';
            }
        }
        //SIM
        modify("Trsf.-from Country/Region Code")
        {
            Visible = false;
        }
        moveafter("Transfer-from Name"; "Transfer-from Name 2")
        moveafter("Transfer-from Name 2"; "Transfer-from Address")
        moveafter("Transfer-from Address"; "Transfer-from Address 2")
        moveafter("Transfer-from Address 2"; "Transfer-from Post Code")
        moveafter("Transfer-from Post Code"; "Transfer-from City")
        moveafter("Transfer-from City"; "Transfer-from Contact")
        moveafter("Transfer-from Contact"; "Shipment Date")
        moveafter("Shipment Date"; "Outbound Whse. Handling Time")
        moveafter("Outbound Whse. Handling Time"; "Shipment Method Code")
        moveafter("Shipment Method Code"; "Shipping Agent Code")
        moveafter("Shipment Method Code"; "Shipping Agent Code")
        moveafter("Shipping Agent Code"; "Shipping Agent Service Code")
        moveafter("Shipping Agent Service Code"; "Shipping Time")
        moveafter("Shipping Time"; "Shipping Advice")


        //Transfer to
        modify("Trsf.-to Country/Region Code")
        {
            Visible = false;
        }
        moveafter("Transfer-to Name"; "Transfer-to Name 2")
        moveafter("Transfer-to Name 2"; "Transfer-to Address")
        moveafter("Transfer-to Address"; "Transfer-to Address 2")
        moveafter("Transfer-to Address 2"; "Transfer-to Post Code")
        moveafter("Transfer-to Post Code"; "Transfer-to City")
        moveafter("Transfer-to City"; "Transfer-to Contact")
        moveafter("Transfer-to Contact"; "Receipt Date")
        moveafter("Receipt Date"; "Inbound Whse. Handling Time")
        addafter("Inbound Whse. Handling Time")
        {
            field("Vendor Invoice No."; rec."Vendor Invoice No.")
            {
                ApplicationArea = all;
            }
            field("Posting Date2"; "Posting Date")
            {
                ApplicationArea = All;
            }
            field("SFPL User ID"; Rec."SFPL User ID")
            {
                ApplicationArea = All;
            }

        }

        modify("Partner VAT ID")
        {
            Visible = false;
        }



    }

    actions
    {
        // Add changes to page actions here
        addafter(Dimensions)
        {
        }
        modify("Re&lease")
        {
            trigger OnBeforeAction()
            var
                Workflow: Record 1501;
                FromLocation: Record 14;
            begin
                //PRU_NEELESH
                Rec.TESTFIELD(Status, Rec.Status::Open);
                Workflow.RESET;
                Workflow.SETRANGE(Code, 'TRANSFER');
                Workflow.SETRANGE(Enabled, TRUE);
                IF Workflow.FINDFIRST THEN BEGIN
                    IF FromLocation.GET(Rec."Transfer-to Code") THEN BEGIN
                        IF (FromLocation."Agreement End Date" <> 0D) AND (FromLocation."Responsibility Center" = 'CBF') THEN BEGIN
                            IF (FromLocation."Agreement End Date" - TODAY) < 15 THEN
                                ERROR('Please send for approval');
                        END;
                    END;
                END;

                Workflow.RESET;
                Workflow.SETRANGE(Code, 'TRANSFER');
                Workflow.SETRANGE(Enabled, TRUE);
                IF Workflow.FINDFIRST THEN BEGIN
                    IF FromLocation.GET(Rec."Transfer-from Code") THEN BEGIN
                        IF (FromLocation."Agreement End Date" <> 0D) AND (FromLocation."Responsibility Center" = 'CBF') THEN BEGIN
                            IF (FromLocation."Agreement End Date" - TODAY) < 15 THEN
                                ERROR('Please send for approval');
                        END;
                    END;
                END;
                //PRU_NEELESH
            end;
        }


        modify(Post)
        {
            trigger OnBeforeAction()
            var
                SHLoc: Record 5740;
                GeneralLedgerSetup: Record 98;
                FromLocation: Record 14;
                ToLocation: Record 14;
                RecTransferLine: Record 5741;
                TransferLine: Record 5741;
                Workflow: Record 1501;
                TransferHeader_Loc: Record 5740;
                TransferNo_Loc: Code[20];
                PLRec1: Record "Transfer Line";
                TaxTransValue1: Record "Tax Transaction Value";
                TotalTax1: Decimal;
                SGST_Amt1: Decimal;
                SGST_perc1: Decimal;
                SGST_Amt2: Decimal;
                IGST_Amt2: Decimal;
                TaxComponentName1: Text;
                CGST_Amt1: Decimal;
                CGST_perc1: Decimal;
                IGST_Amt1: Decimal;
                CGST_Amt2: Decimal;
                IGST_perc1: Decimal;
                GSTSetup1: Record "GST Setup";
                IgstAmount: Decimal;
                CgstAmount: Decimal;
                SgstAmount: Decimal;
                GSTamt1: Decimal;
                TimeChecking: Boolean;
                Time1: Time;
            begin
                CompanyInfo.Get;
                //>>PRU_RPG NDF_0.1
                Time1 := Time;
                TimeChecking := false;
                Rec.TESTFIELD("Shortcut Dimension 1 Code");
                Rec.TESTFIELD("Shortcut Dimension 2 Code");
                if CompanyInfo.SFPLCompany = CompanyInfo.SFPLCompany::Sampoorna then
                    Rec.TESTFIELD("Shortcut Dimension 3 Code");

                If CompanyInfo.SFPLCompany in [CompanyInfo.SFPLCompany::Sampoorna] then begin
                    UserSetup1.Reset();
                    UserSetup1.SetRange("User ID", UserId);
                    UserSetup1.SetFilter("Global Dimension 1 Code", '%1|%2|%3', 'CBF', 'BREEDER', 'HATCH');
                    if not UserSetup1.FindFirst() then begin
                        UserSetup.Reset();
                        UserSetup.SetRange(UserSetup."User ID", UserId);
                        UserSetup.SetRange("Tax Details Permission", True);
                        if not UserSetup.FindFirst() then
                            If Rec."Posting Date" <> Today then Begin
                                if (Format(Time1) <= '12:30:00.000') Then
                                    TimeChecking := True;
                                if not TimeChecking Then
                                    Error('You can not post the Entry in back date, Current Date and Time in %1', CurrentDateTime);
                            end;


                    end;

                end;
                //<<PRU_RPG NDF_0.1

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
                UserSetup.SETFILTER(UserSetup."Access Transfer Order", '%1', UserSetup."Access Transfer Order"::Edit);
                IF UserSetup.FINDFIRST THEN
                    ERROR('You do not have Permission to Post Transfer Order');
                //PRU_DD 1.10
                //+RK-PRU
                /*
                IF "Posting Date" > 310518D THEN
                  ERROR('No Transfer Order Cannot Be Posted After 31/05/2018');
                */




                Reclocation.GET(Rec."Transfer-to Code");

                IF (Reclocation.Grade = Reclocation.Grade::C) OR (Reclocation.Grade = Reclocation.Grade::D) THEN
                    ERROR('Farm Grade is %1', Reclocation.Grade);

                CLEAR(TotalRemainingQty);
                CLEAR(TrflineQty);
                CLEAR(TotalRemainingQty1);

                TrfLine.RESET;
                TrfLine.SETRANGE("Document No.", Rec."No.");
                TrfLine.SETFILTER("Chicks Item", '%1', TRUE);
                IF TrfLine.FINDFIRST THEN
                    REPEAT
                        TrflineQty += TrfLine."Qty. to Ship";
                    UNTIL TrfLine.NEXT = 0;

                ILE.RESET;
                ILE.SETRANGE("Location Code", Rec."Transfer-to Code");
                ILE.SETRANGE("Item No.", TrfLine."Item No.");
                ILE.SETFILTER("Chicks Item", '%1', TRUE);
                ILE.SETFILTER("Remaining Quantity", '>%1', 0);
                IF ILE.FINDSET THEN BEGIN
                    ILE.CALCSUMS("Remaining Quantity");
                    TotalRemainingQty := Reclocation.Capicity - ILE."Remaining Quantity";

                    IF Reclocation.Capicity > 0 THEN
                        IF TotalRemainingQty < TrflineQty THEN
                            ERROR('Qty must not be greater than %1', TotalRemainingQty);
                    //-RK-PRU
                END;
                //  Message('%1..%2..%3..%4', TrflineQty, Reclocation.Capicity, ILE."Remaining Quantity", TotalRemainingQty);
                //PRU-VG
                CLEAR(Reclocation);
                Reclocation.GET(Rec."Transfer-to Code");
                GeneralLedgerSetup.GET;
                IF Reclocation."Liquidation Date" <> 0D THEN BEGIN
                    SHLoc.RESET;
                    SHLoc.SETRANGE("No.", Rec."No.");
                    SHLoc.SETRANGE("Posting Date", Reclocation."Liquidation Date", CALCDATE(GeneralLedgerSetup."Liquidation Date Formula", Reclocation."Liquidation Date"));
                    IF SHLoc.FINDFIRST THEN
                        ERROR('Transfer Order cannot be posted before %1', CALCDATE(GeneralLedgerSetup."Liquidation Date Formula", Reclocation."Liquidation Date"));
                END;
                If CompanyInfo.SFPLCompany in [CompanyInfo.SFPLCompany::Sampoorna] then begin
                    if Rec.Shipped Then begin
                        if Reclocation."Global Dimension 1 Code" <> Rec."Shortcut Dimension 1 Code" then
                            Error('LOB Code does not matched with To location');
                        if Reclocation."Global Dimension 2 Code" <> Rec."Shortcut Dimension 2 Code" then
                            Error('Branch Code does not matched with To location');
                        if rec."Transfer-to Code" <> Rec."Shortcut Dimension 3 Code" then
                            Error('LOC Code does not matched with To location');
                    end;
                end;

                RecTransferLine.RESET;
                RecTransferLine.SETRANGE("Document No.", Rec."No.");
                IF RecTransferLine.FINDSET THEN
                    REPEAT
                        IF Rec."Transfer-from Code" <> '' THEN
                            FromLocation.GET(Rec."Transfer-from Code");
                        IF Rec."Transfer-to Code" <> '' THEN
                            ToLocation.GET(Rec."Transfer-to Code");
                        //IF FromLocation."State Code" <> ToLocation."State Code" THEN
                        //   TESTFIELD(Structure);
                        //   RecTransferLine."Total Taxable Value" := RecTransferLine."Total GST Amount" + RecTransferLine."GST Base Amount";
                        RecTransferLine.MODIFY;
                    UNTIL RecTransferLine.NEXT = 0;
                ////PRU_NEELESH
                //PRU_NEELESH validation of Location Agreement end date expired 1802020
                IF FromLocation.GET(Rec."Transfer-from Code") THEN BEGIN  //PRU_KH_Exp1.1_28022020
                    IF FromLocation."Responsibility Center" = 'CBF' THEN BEGIN
                        IF FromLocation."Agreement End Date" <> 0D THEN BEGIN
                            IF FromLocation."Agreement End Date" <= TODAY THEN //PRU_KH_Exp_1.1_25022020
                                ERROR('Agreement End Date %1 has been expired of Farm %2', FromLocation."Agreement End Date", FromLocation.Code);
                        END;  //PRU_KH_Exp1.1_28022020
                    END;
                END;

                IF FromLocation.GET(Rec."Transfer-to Code") THEN BEGIN
                    IF FromLocation."Responsibility Center" = 'CBF' THEN BEGIN  //PRU_KH_Exp1.1_28022020
                        IF FromLocation."Agreement End Date" <> 0D THEN BEGIN
                            IF FromLocation."Agreement End Date" <= TODAY THEN //PRU_KH_Exp1.1_25022020
                                ERROR('Agreement End Date %1 has been expired of Farm %2', FromLocation."Agreement End Date", FromLocation.Code);
                        END;
                    END;  //PRU_KH_Exp1.1_28022020
                END;
                FromLocation.GET(Rec."Transfer-to Code");
                GeneralLedgerSetup.GET; //PRU_gk
                IF (FromLocation."Responsibility Center" = 'CBF') AND (Rec.Status = Rec.Status::Open) THEN BEGIN  //PRU_KH_Exp1.1_28022020
                    Workflow.RESET;
                    Workflow.SETRANGE(Code, 'TRANSFER');
                    Workflow.SETRANGE(Enabled, TRUE);
                    IF Workflow.FINDFIRST THEN BEGIN
                        IF FromLocation.GET(Rec."Transfer-to Code") THEN BEGIN
                            IF FromLocation."Agreement End Date" <> 0D THEN BEGIN
                                IF (FromLocation."Agreement End Date" - TODAY) < GeneralLedgerSetup."Before Expiry Days" THEN //PRU_KH_Exp1.1_25022020
                                    ERROR('Then Farm code %1 has been blocked due to farm agreement date near to expired', FromLocation.Code);
                            END;
                        END;
                    END;
                END;
                GeneralLedgerSetup.GET;  //PRU_gk
                FromLocation.GET(Rec."Transfer-from Code");
                IF (FromLocation."Responsibility Center" = 'CBF') AND (Rec.Status = Rec.Status::Open) THEN BEGIN
                    Workflow.RESET;
                    Workflow.SETRANGE(Code, 'TRANSFER');
                    Workflow.SETRANGE(Enabled, TRUE);
                    IF Workflow.FINDFIRST THEN BEGIN
                        IF FromLocation.GET(Rec."Transfer-from Code") THEN BEGIN
                            IF FromLocation."Agreement End Date" <> 0D THEN BEGIN
                                IF (FromLocation."Agreement End Date" - TODAY) < GeneralLedgerSetup."Before Expiry Days" THEN //PRU_KH_Exp1.1_25022020
                                    ERROR('Then Farm code %1 has been blocked due to farm agreement date near to expired', FromLocation.Code);
                            END;
                        END;
                    END;
                END;

                //PRU_NEELESH validation of Location Agreement end date expired 1802020

                /*

                                CLEAR(TransferNo_Loc);  //PRU_RPG NDF_0.1
                                TransferNo_Loc := Rec."No.";  //PRU_RPG NDF_0.1

                                //<<PRU_RPG NDF_0.1
                                TransferHeader_Loc.RESET;
                                TransferHeader_Loc.SETRANGE("No.", TransferNo_Loc);
                                IF TransferHeader_Loc.FINDSET THEN BEGIN
                                    TransferHeader_Loc.VALIDATE("Shortcut Dimension 1 Code");
                                    TransferHeader_Loc.VALIDATE("Shortcut Dimension 2 Code");
                                    TransferHeader_Loc.VALIDATE("Shortcut Dimension 3 Code");
                                    TransferHeader_Loc.MODIFY;
                                END;
                                */
                // CurrPage.UPDATE(FALSE);
                //<<PRU_RPG NDF_0.1

            end;

            trigger OnAfterAction()
            var
                TransferHeader_Loc: Record "Transfer Header";
                TransferNo_Loc: Code[20];
            begin
                CLEAR(TransferNo_Loc);  //PRU_RPG NDF_0.1
                TransferNo_Loc := Rec."No.";  //PRU_RPG NDF_0.1
                //<<PRU_RPG NDF_0.1
                TransferHeader_Loc.RESET;
                TransferHeader_Loc.SETRANGE("No.", TransferNo_Loc);
                IF TransferHeader_Loc.FINDSET THEN BEGIN
                    TransferHeader_Loc.VALIDATE("Shortcut Dimension 1 Code");
                    TransferHeader_Loc.VALIDATE("Shortcut Dimension 2 Code");
                    if CompanyInfo.SFPLCompany = CompanyInfo.SFPLCompany::Sampoorna then
                        TransferHeader_Loc.VALIDATE("Shortcut Dimension 3 Code");
                    TransferHeader_Loc.MODIFY;
                END;
                CurrPage.UPDATE(FALSE);
                //<<PRU_RPG NDF_0.1
            end;
        }
        modify(PostAndPrint)
        {
            Visible = false;
            trigger OnBeforeAction()
            var
                SHLoc: Record 5740;
                GeneralLedgerSetup: Record 98;
                FromLocation: Record 14;
                ToLocation: Record 14;
                RecTransferLine: Record 5741;
                Workflow: Record 1501;
                PLRec1: Record "Transfer Line";
                TaxTransValue1: Record "Tax Transaction Value";
                TotalTax1: Decimal;
                SGST_Amt1: Decimal;
                SGST_perc1: Decimal;
                SGST_Amt2: Decimal;
                IGST_Amt2: Decimal;
                TaxComponentName1: Text;
                CGST_Amt1: Decimal;
                CGST_perc1: Decimal;
                IGST_Amt1: Decimal;
                CGST_Amt2: Decimal;
                IGST_perc1: Decimal;
                GSTSetup1: Record "GST Setup";
                IgstAmount: Decimal;
                CgstAmount: Decimal;
                SgstAmount: Decimal;
                GSTamt1: Decimal;
            begin
                //+RK-PRU
                /*
                IF "Posting Date" > 310518D THEN
                  ERROR('No Transfer Order Cannot Be Posted After 31/05/2018');
                */
                Reclocation.GET(Rec."Transfer-to Code");

                IF (Reclocation.Grade = Reclocation.Grade::C) OR (Reclocation.Grade = Reclocation.Grade::D) THEN
                    ERROR('Farm Grade is %1', Reclocation.Grade);

                CLEAR(TotalRemainingQty);
                CLEAR(TrflineQty);
                CLEAR(TotalRemainingQty1);

                TrfLine.RESET;
                TrfLine.SETRANGE("Document No.", Rec."No.");
                TrfLine.SETFILTER("Chicks Item", '%1', TRUE);
                IF TrfLine.FINDFIRST THEN
                    REPEAT
                        TrflineQty += TrfLine."Qty. to Ship";
                    UNTIL TrfLine.NEXT = 0;

                ILE.RESET;
                ILE.SETRANGE("Location Code", Rec."Transfer-to Code");
                ILE.SETRANGE("Item No.", TrfLine."Item No.");
                ILE.SETFILTER("Chicks Item", '%1', TRUE);
                ILE.SETFILTER("Remaining Quantity", '>%1', 0);
                IF ILE.FINDSET THEN BEGIN
                    ILE.CALCSUMS("Remaining Quantity");
                    TotalRemainingQty := Reclocation.Capicity - ILE."Remaining Quantity";

                    IF TotalRemainingQty < TrflineQty THEN
                        ERROR('Qty must not be greater than %1', TotalRemainingQty);
                    //-RK-PRU
                END;
                //PRU-VG
                CLEAR(Reclocation);
                Reclocation.GET(Rec."Transfer-to Code");
                GeneralLedgerSetup.GET;
                IF Reclocation."Liquidation Date" <> 0D THEN BEGIN
                    SHLoc.RESET;
                    SHLoc.SETRANGE("No.", Rec."No.");
                    SHLoc.SETRANGE("Posting Date", Reclocation."Liquidation Date", CALCDATE(GeneralLedgerSetup."Liquidation Date Formula", Reclocation."Liquidation Date"));
                    IF SHLoc.FINDFIRST THEN
                        ERROR('Transfer Order cannot be posted before %1', CALCDATE(GeneralLedgerSetup."Liquidation Date Formula", Reclocation."Liquidation Date"));
                END;
                //PRU-VG

                ////PRU-VG 110619
                IF Rec."Transfer-from Code" <> '' THEN
                    FromLocation.GET(Rec."Transfer-from Code");
                IF Rec."Transfer-to Code" <> '' THEN
                    ToLocation.GET(Rec."Transfer-to Code");
                IF FromLocation."State Code" <> ToLocation."State Code" THEN BEGIN
                    //   TESTFIELD(Structure);


                    PLRec1.Reset();
                    PLRec1.SetRange(PLRec1."Document No.", Rec."No.");
                    RecTransferLine.SETFILTER(Quantity, '<>%1', 0);
                    if PLRec1.FindSet() then
                        repeat
                            //if (PLRec1."P & F Value" = true) OR (PLRec1."Freight Value" = true) OR (PLRec1."Cutting & Loading" = true) then begin
                            Clear(GSTamt1);
                            Clear(IGST_Amt2);
                            Clear(CGST_Amt2);
                            Clear(SGST_Amt2);
                            Clear(IgstAmount);
                            Clear(CgstAmount);
                            Clear(SgstAmount);
                            GSTSetup1.Get();//PT
                            TaxTransValue1.SetRange("Tax Type", GSTSetup1."GST Tax Type");
                            TaxTransValue1.SetRange("Tax Record ID", PLRec1.RecordId());
                            TaxTransValue1.SetRange("Value Type", TaxTransValue1."Value Type"::COMPONENT);
                            TaxTransValue1.SetFilter(Percent, '<>%1', 0);
                            if TaxTransValue1.FindSet() then
                                repeat
                                    TaxComponentName1 := TaxTransValue1.GetAttributeColumName();
                                    case TaxComponentName1 of
                                        'IGST':
                                            begin
                                                //     IgstPer := TaxTransValue1.Percent;
                                                evaluate(IGST_Amt2, TaxTransValue1."Column Value");
                                                IgstAmount += IGST_Amt2;
                                            end;
                                        'CGST':
                                            begin
                                                evaluate(CGST_Amt2, TaxTransValue1."Column Value");
                                                //   CgstPer := TaxTransValue1.Percent;
                                                CgstAmount += CGST_Amt2;
                                            end;
                                        'SGST':
                                            begin
                                                evaluate(SGST_Amt2, TaxTransValue1."Column Value");
                                                // SgstPer := TaxTransValue1.Percent;
                                                SgstAmount += SGST_Amt2;
                                            end;
                                    end;
                                until TaxTransValue1.Next() = 0;
                            GSTamt1 := IgstAmount + CgstAmount + SgstAmount;
                            if GSTamt1 = 0 then
                                ERROR('GST Amount not calculated in item no. %1 and line no. %2', PLRec1."Item No.", PLRec1."Line No.");
                        until PLRec1.Next = 0;
                    /*
                                        RecTransferLine.RESET;
                                        RecTransferLine.SETCURRENTKEY("Document No.", "Line No.");
                                        RecTransferLine.SETRANGE("Document No.", Rec."No.");
                                        RecTransferLine.SETFILTER(Quantity, '<>%1', 0);
                                        //   RecTransferLine.SETFILTER("Total GST Amount", '%1', 0);
                                        RecTransferLine.SETRANGE(Exempted, FALSE);
                                        IF RecTransferLine.FINDFIRST THEN
                                            ERROR('GST Amount not calculated in item no. %1 and line no. %2', RecTransferLine."Item No.", RecTransferLine."Line No.");

                                        RecTransferLine.RESET;
                                        RecTransferLine.SETRANGE("Document No.", Rec."No.");
                                        RecTransferLine.SETRANGE(Exempted, TRUE);
                                        RecTransferLine.SETFILTER(Quantity, '<>%1', 0);
                                        // RecTransferLine.SETRANGE("GST Base Amount", 0);
                                        IF RecTransferLine.FINDFIRST THEN
                                            ERROR('GST Amount not calculated in item no. %1 and line no. %2', RecTransferLine."Item No.", RecTransferLine."Line No.");
                      */
                END;
                ////PRU-VG 110619
                //PRU_NEELESH validation of Location Agreement end date expired 1802020
                IF FromLocation.GET(Rec."Transfer-from Code") THEN BEGIN  //PRU_KH_Exp1.1_28022020
                    IF FromLocation."Responsibility Center" = 'CBF' THEN BEGIN
                        IF FromLocation."Agreement End Date" <> 0D THEN BEGIN
                            //IF FromLocation."Agreement End Date" = TODAY THEN //PRU_KH_Exp1.1_25022020
                            IF FromLocation."Agreement End Date" <= TODAY THEN //PRU_KH_Exp_1.1_25022020
                                ERROR('Agreement End Date %1 has been expired of Farm %2', FromLocation."Agreement End Date", FromLocation.Code);
                        END;  //PRU_KH_Exp1.1_28022020
                    END;
                END;

                IF FromLocation.GET(Rec."Transfer-to Code") THEN BEGIN
                    IF FromLocation."Responsibility Center" = 'CBF' THEN BEGIN  //PRU_KH_Exp1.1_28022020
                        IF FromLocation."Agreement End Date" <> 0D THEN BEGIN
                            IF FromLocation."Agreement End Date" <= TODAY THEN //PRU_KH_Exp1.1_25022020
                                ERROR('Agreement End Date %1 has been expired of Farm %2', FromLocation."Agreement End Date", FromLocation.Code);
                        END;
                    END;  //PRU_KH_Exp1.1_28022020
                END;

                IF (FromLocation."Responsibility Center" = 'CBF') AND (Rec.Status = Rec.Status::Open) THEN BEGIN  //PRU_KH_Exp1.1_28022020
                    Workflow.RESET;
                    Workflow.SETRANGE(Code, 'TRANSFER');
                    Workflow.SETRANGE(Enabled, TRUE);
                    IF Workflow.FINDFIRST THEN BEGIN
                        IF FromLocation.GET(Rec."Transfer-to Code") THEN BEGIN
                            IF FromLocation."Agreement End Date" <> 0D THEN BEGIN
                                IF (FromLocation."Agreement End Date" - TODAY) < GeneralLedgerSetup."Before Expiry Days" THEN //PRU_KH_Exp1.1_25022020
                                    ERROR('Please send for approval');
                            END;
                        END;
                    END;
                END;

                IF (Rec."Responsibility Center" = 'CBF') AND (Rec.Status = Rec.Status::Open) THEN BEGIN
                    Workflow.RESET;
                    Workflow.SETRANGE(Code, 'TRANSFER');
                    Workflow.SETRANGE(Enabled, TRUE);
                    IF Workflow.FINDFIRST THEN BEGIN
                        IF FromLocation.GET(Rec."Transfer-from Code") THEN BEGIN
                            IF FromLocation."Agreement End Date" <> 0D THEN BEGIN
                                IF (FromLocation."Agreement End Date" - TODAY) < GeneralLedgerSetup."Before Expiry Days" THEN //PRU_KH_Exp1.1_25022020
                                    ERROR('Then Farm code %1 has been blocked due to farm agreement date near to expired', FromLocation.Code);
                            END;
                        END;
                    END;
                END;

                //PRU_NEELESH validation of Location Agreement end date expired 1802020

            end;
        }

        addafter(PostAndPrint)
        {

            action("Post With Prod. Order")
            {
                Caption = 'Post With Prod. Order';
                Ellipsis = true;
                Enabled = PostwithProdBtnVisible;
                Image = PostOrder;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ShortCutKey = 'F9';
                Visible = PostwithProdBtnVisible;

                trigger OnAction()
                var
                    FromLocation: Record 14;
                    ToLocation: Record 14;
                    RecTransferLine: Record 5741;
                begin
                    //PRU_DD 1.10
                    UserSetup.RESET;
                    UserSetup.SETRANGE("User ID", USERID);
                    UserSetup.SETFILTER(UserSetup."TO Post With Prod.Order", '%1', FALSE);
                    IF UserSetup.FINDFIRST THEN
                        ERROR('You do not have permission to do Post With Prod.Order');

                    /*
                    IF "Posting Date" > 310518D THEN
                      ERROR('No Transfer Order Cannot Be Posted After 31/05/2018');
                    */
                    TL.RESET;
                    TL.SETRANGE("Document No.", Rec."No.");
                    TL.SETFILTER("Qty. to Receive", '<>%1', 0);
                    //T50004.SETRANGE("Item No.",ParaActualPlan."Item No.");
                    TL.SETRANGE("RPO Created", FALSE);
                    TL.SETRANGE("Completely Shipped", TRUE);
                    IF TL.FINDSET THEN
                        REPEAT
                            TL.TESTFIELD("Breed Code");
                        UNTIL TL.NEXT = 0;

                    ////PRU-VG 110619
                    IF Rec."Transfer-from Code" <> '' THEN
                        FromLocation.GET(Rec."Transfer-from Code");
                    IF Rec."Transfer-to Code" <> '' THEN
                        ToLocation.GET(Rec."Transfer-to Code");
                    IF FromLocation."State Code" <> ToLocation."State Code" THEN BEGIN
                        //      TESTFIELD(Structure);
                        RecTransferLine.RESET;
                        RecTransferLine.SETCURRENTKEY("Document No.", "Line No.");
                        RecTransferLine.SETRANGE("Document No.", Rec."No.");
                        RecTransferLine.SETFILTER(Quantity, '<>%1', 0);
                        //    RecTransferLine.SETFILTER("Total GST Amount", '%1', 0);
                        RecTransferLine.SETRANGE(Exempted, FALSE);
                        IF RecTransferLine.FINDFIRST THEN
                            ERROR('GST Amount not calculated in item no. %1 and line no. %2', RecTransferLine."Item No.", RecTransferLine."Line No.");

                        RecTransferLine.RESET;
                        RecTransferLine.SETRANGE("Document No.", Rec."No.");
                        RecTransferLine.SETRANGE(Exempted, TRUE);
                        RecTransferLine.SETFILTER(Quantity, '<>%1', 0);
                        //  RecTransferLine.SETRANGE("GST Base Amount", 0);
                        IF RecTransferLine.FINDFIRST THEN
                            ERROR('GST Amount not calculated in item no. %1 and line no. %2', RecTransferLine."Item No.", RecTransferLine."Line No.");
                    END;
                    ////PRU-VG 110619

                    CODEUNIT.RUN(CODEUNIT::"TransferOrder-Post Prod.", Rec);//PRU-VG

                end;
            }

        }

        addafter("Inventory - Inbound Transfer")
        {
            group("Request Approval")
            {
                Caption = 'Request Approval';
                Image = SendApprovalRequest;
                action(SendApprovalRequest)
                {
                    ApplicationArea = all;
                    Caption = 'Send A&pproval Request';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category9;
                    ToolTip = 'Send an approval request.';

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit 50016;
                        T_14: Record 14;
                        Count1: Integer;
                        Count2: Integer;
                        WorkflowEventHandling: Codeunit 50015;
                        Workflow: Record 1501;
                        Tab_14: Record 14;
                        GeneralLedgerSetup: Record 98;
                    begin
                        //PRU_NEELESH
                        GeneralLedgerSetup.GET;  ///Pru_gk
                        Workflow.RESET;
                        Workflow.SETRANGE(Code, 'TRANSFER');
                        Workflow.SETRANGE(Enabled, TRUE);
                        IF Workflow.FINDFIRST THEN BEGIN
                            CLEAR(Count1);
                            CLEAR(Count2);
                            Rec.TESTFIELD("Transfer-to Code");
                            Rec.TESTFIELD("Transfer-from Code");
                            T_14.GET(Rec."Transfer-to Code");
                            IF T_14."Responsibility Center" = 'CBF' THEN BEGIN
                                IF (T_14."Agreement End Date" <> 0D) THEN
                                    Count1 := T_14."Agreement End Date" - TODAY;
                            END;
                            Tab_14.GET(Rec."Transfer-from Code");
                            IF Tab_14."Responsibility Center" = 'CBF' THEN BEGIN
                                IF (Tab_14."Agreement End Date" <> 0D) THEN
                                    Count2 := Tab_14."Agreement End Date" - TODAY;

                            END;
                            IF ((Count1 > 0) AND (Count1 < GeneralLedgerSetup."Before Expiry Days")) OR ((Count2 > 0) AND (Count2 < GeneralLedgerSetup."Before Expiry Days")) THEN BEGIN //PRU_KH_Exp1.1_26022020
                                                                                                                                                                                         //Pru SHIKHA

                                IF ApprovalsMgmt.CheckTransHeadrequestApprovalsWorkflowEnabled(Rec) THEN
                                    WorkflowEventHandling.RunWorkflowOnSendTransHeadrequestForApproval(Rec);
                            END;
                            //  ApprovalsMgmt.OnSendTransferDocForApproval(Rec);

                        END; //PRU_KH_Exp1.1_28022020
                        //PRU_NEELESH
                    end;
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = all;
                    Caption = 'Cancel Approval Re&quest';
                    Image = CancelApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category9;
                    ToolTip = 'Cancel the approval request.';

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit 50016;
                        WorkflowEventHandling: Codeunit 50015;
                        Workflow: Record 1501;
                    begin
                        //PRU_NEELESH
                        Workflow.RESET;
                        Workflow.SETRANGE(Code, 'TRANSFER');
                        Workflow.SETRANGE(Enabled, TRUE);
                        IF Workflow.FINDFIRST THEN BEGIN
                            WorkflowEventHandling.RunWorkflowOnCancelTransHeadrequestApprovalRequest(Rec);
                        END;
                        //PRU_NEELESH
                    end;
                }
            }

            action(Approve)
            {
                ApplicationArea = all;
                Caption = 'Approve';
                Image = Approve;
                Promoted = true;
                PromotedCategory = Category5;
                PromotedIsBig = true;
                ToolTip = 'Approve the requested changes.';
                Visible = ApproverVisible;

                trigger OnAction()
                var
                    ApprovalsMgmt: Codeunit 1535;
                begin
                    ApprovalsMgmt.ApproveRecordApprovalRequest(Rec.RECORDID);//PRU_NEELESH
                end;
            }
            action(Reject)
            {
                ApplicationArea = all;
                Caption = 'Reject';
                Image = Reject;
                Promoted = true;
                PromotedCategory = Category5;
                PromotedIsBig = true;
                ToolTip = 'Reject the approval request.';
                Visible = ApproverVisible;

                trigger OnAction()
                var
                    ApprovalsMgmt: Codeunit 1535;
                begin
                    ApprovalsMgmt.RejectRecordApprovalRequest(Rec.RECORDID);//PRU_NEELESH
                end;
            }
            action(Delegate)
            {
                ApplicationArea = all;
                Caption = 'Delegate';
                Image = Delegate;
                Promoted = true;
                PromotedCategory = Category5;
                ToolTip = 'Delegate the approval to a substitute approver.';
                Visible = false;

                trigger OnAction()
                var
                    ApprovalsMgmt: Codeunit 1535;
                begin
                    ApprovalsMgmt.DelegateRecordApprovalRequest(Rec.RECORDID);//PRU_NEELESH
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    var
        ApprovalEntry: Record 454;
    begin
        //PRU_NEELESH
        ApprovalEntry.RESET;
        ApprovalEntry.SETRANGE("Table ID", 5740);
        IF ApprovalEntry.FINDFIRST THEN
            IF ApprovalEntry."Approver ID" = USERID THEN
                ApproverVisible := FALSE
            ELSE
                ApproverVisible := TRUE;
        //PRU_NEELESH
        //PRU_NEELESH 0.0001 Dim Edit 09072020
        TrfLine.RESET;
        TrfLine.SETRANGE("Document No.", Rec."No.");
        TrfLine.SETFILTER("Quantity Shipped", '>%1', 0);
        IF TrfLine.FINDFIRST THEN
            //IF Status = Status::Released THEN
            DimEdit := FALSE
        ELSE
            DimEdit := TRUE;
        //PRU_NEELESH 0.0001 Dim Edit 09072020
    end;

    trigger OnAfterGetRecord()
    var
        ApprovalEntry: Record 454;
    begin
        //PRU_NEELESH
        ApprovalEntry.RESET;
        ApprovalEntry.SETRANGE("Table ID", 5740);
        IF ApprovalEntry.FINDFIRST THEN
            IF ApprovalEntry."Approver ID" = USERID THEN
                ApproverVisible := FALSE
            ELSE
                ApproverVisible := TRUE;
        //PRU_NEELESH
        //PRU_NEELESH 0.0001 Dim Edit 09072020

        TrfLine.RESET;
        TrfLine.SETRANGE("Document No.", Rec."No.");
        TrfLine.SETFILTER("Quantity Shipped", '>%1', 0);
        IF TrfLine.FINDFIRST THEN
            //IF Status = Status::Released THEN
            DimEdit := FALSE
        ELSE
            DimEdit := TRUE;

        //PRU_NEELESH 0.0001 Dim Edit 09072020
    end;

    trigger OnDeleteRecord(): Boolean
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
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Transfer Order", '%1', UserSetup."Access Transfer Order"::Edit);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have Permission to Create Transfer Orders');
        //PRU_DD 1.10


        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Transfer Order", '%1', UserSetup."Access Transfer Order"::Recieve);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have Permission to Create Transfer Order');

        Rec.Validate("Vehicle Type", rec."Vehicle Type"::Regular);
    end;

    trigger OnModifyRecord(): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Transfer Order", '%1', UserSetup."Access Transfer Order"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have Permission to Change Transfer Order Details');
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
    var
        ApprovalEntry: Record 454;
    begin
        PostwithProdBtnVisible := FALSE; // PRU_AS 10 AUG 2019
        //<<PRU_RC
        UserSetup.GET(USERID);
        Rec.FILTERGROUP(2);
        Rec.SETFILTER("Shortcut Dimension 1 Code", UserSetup."Global Dimension 1 Code");
        IF NOT UserSetup."User Permission" THEN BEGIN
            Rec.SETFILTER("Shortcut Dimension 2 Code", UserSetup."Global Dimension 2 Code");
            IF NOT UserSetup."HO Users" THEN
                Rec.SETFILTER("Shortcut Dimension 3 Code", UserSetup."Shortcut Dimension 3 Code");
        END;
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
        //PRU_NEELESH
        ApprovalEntry.RESET;
        ApprovalEntry.SETRANGE("Table ID", 5740);
        IF ApprovalEntry.FINDFIRST THEN
            IF ApprovalEntry."Approver ID" = USERID THEN
                ApproverVisible := FALSE
            ELSE
                ApproverVisible := TRUE;
        //PRU_NEELESH
        //PRU_NEELESH 0.0001 Dim Edit 09072020
        TrfLine.RESET;
        TrfLine.SETRANGE("Document No.", Rec."No.");
        TrfLine.SETFILTER("Quantity Shipped", '>%1', 0);
        IF TrfLine.FINDFIRST THEN
            //IF Status = Status::Released THEN
            DimEdit := FALSE
        ELSE
            DimEdit := TRUE;
        //PRU_NEELESH 0.0001 Dim Edit 09072020
    end;

    var
        myInt: Integer;
        TL: Record 5741;
        ILE: Record 32;
        Reclocation: Record 14;
        TotalRemainingQty: Decimal;
        TrfLine: Record 5741;
        TrflineQty: Decimal;
        TotalRemainingQty1: Decimal;
        UserSetup: Record 91;
        PostwithProdBtnVisible: Boolean;
        ApproverVisible: Boolean;
        DimEdit: Boolean;
        CompanyInfo: Record "Company Information";
        UserSetup1: Record "User Setup";

    procedure LookupTransporterName(var VendorName: Text): Boolean
    var
        Vendor: Record Vendor;
        LookupStateManager: Codeunit "Lookup State Manager";
        RecVariant: Variant;
        SearchVendorName: Text;
    begin
        SearchVendorName := VendorName;
        Vendor.Setrange(Transporter, true);
        if Rec."Transporter Code" <> '' then
            Vendor.Get(Rec."Transporter Code");

        if Vendor.LookupVendor(Vendor) then begin
            if Rec."Transporter Code" = Vendor."No." then
                VendorName := SearchVendorName
            else
                VendorName := Vendor."No.";
            RecVariant := Vendor;
            LookupStateManager.SaveRecord(RecVariant);
            exit(true);
        end;
    end;
}