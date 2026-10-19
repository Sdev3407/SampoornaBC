report 50045 "Transfer Order 2016"
{
    UsageCategory = Administration;
    Caption = 'Transfer Order 2016 Report';
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'ReportLayout\TransferOrder2016.rdl';

    dataset
    {
        dataitem("Transfer Shipment Header"; "Transfer Shipment Header")
        {
            column(bool2; bool2)
            {
            }
            column(bool1; bool1)
            {
            }
            column(InvoiceType; InvoiceType)
            { }
            column(Copytype; CopyType)
            {
            }
            column(CompanyAddr1; CompanyAddr[1])
            {
            }
            column(CompanyAddr2; CompanyAddr[2])
            {
            }
            column(CompanyAddr3; CompanyAddr[3])
            {
            }
            column(CompanyAddr4; CompanyAddr[4])
            {
            }
            column(Companyinfo; CompanyInfo.Name)
            {
            }
            column(Toll_Free_Label; Toll_Free)
            {
            }
            column(Email_Label; Email)
            {
            }
            column(CIN_Label; CIN)
            {
            }
            column(TCGI_Label; TCGI)
            {
            }
            column(InvoiceDate_Label; InvoiceDate)
            {
            }
            column(T_Name_Label; T_Name)
            {
            }
            column(LR_Date_Label; LR_Date)
            {
            }
            column(RegrNo_Label; RegrNo)
            {
            }
            column(Check_Post_Label; Check_Post)
            {
            }
            column(PermitIn_Label; PermitIn)
            {
            }
            column(PermitOut_Lable; PermitOut)
            {
            }
            column(TotalWeight_Label; TotalWeight)
            {
            }
            column(NoCase_Label; NoofCase)
            {
            }
            column(NoCase_Value; NoCase)
            {
            }
            column(No_TransferHeader; "No.")
            {
            }
            column(SellerContact; SellerContact)
            {
            }
            column(BuyerContact; BuyerContact)
            {
            }
            column(BuyerTin; BuyerTin)
            {
            }


            column(FormCode_TransferHeader; "Transfer Shipment Header"."Transfer-from Code")
            {
            }
            column(BuyerEmail; BuyerEmail)
            {
            }
            column(PostingDate_TransferHeader; "Posting Date")
            {
            }
            column(BuyerCst; BuyerCst)
            {
            }
            column(TransferfromName; "Transfer-from Name")
            {
            }
            column(TransferfromAddress; "Transfer-from Address")
            {
            }
            column(TransferfromAddress2; "Transfer-from Address 2")
            {
            }
            column(TransferfromCity; "Transfer-from City" + ' - ' + "Transfer-from Post Code")
            {
            }
            column(TransfertoName; "Transfer-to Name")
            {
            }
            column(TransfertoAddress; "Transfer-to Address")
            {
            }
            column(TransfertoAddress2; "Transfer-to Address 2")
            {
            }
            column(TransfertoCity; "Transfer-to City" + ' - ' + "Transfer-to Post Code")
            {
            }
            column(CompName; CompanyInfo.Name)
            {
            }
            column(CompanyName2; CompanyName2)
            {
            }
            column(CompanyName1; CompanyName1)
            {
            }
            column(CompAddr; CompanyInfo.Address)
            {
            }
            column(CompAddr2; CompanyInfo."Address 2")
            {
            }
            column(CompPics; CompanyInfo.Picture)
            {
            }
            column(CompCity; CompanyInfo.City + ' - ' + CompanyInfo."Post Code")
            {
            }
            column(CompPhone; 'Phone No. :' + CompanyInfo."Phone No.")
            {
            }
            column(AmtInWords; AmtInWords[1])
            {
            }
            column(DriverMobNo_TransferHeader; '')
            {
            }
            column(DriverName_TransferHeader; '')
            {
            }
            column(LRRRNo_TransferHeader; "Transfer Shipment Header"."LR/RR No.")
            {
            }
            column(LogisticVendorNo_TransferHeader; '')
            {
            }
            column(LogisticVendorName_TransferHeader; '')
            {
            }
            column(VehicleNo_TransferHeader; "Transfer Shipment Header"."Vehicle No.")
            {
            }
            column(CheckPostName_TransferHeader; '')
            {
            }
            column(PermitIn_TransferHeader; '')
            {
            }
            column(PermitOut_TransferHeader; '')
            {
            }
            column(LR_Date_TransferHeader; "Transfer Shipment Header"."LR/RR Date")
            {
            }
            column(BuyerVatTin; BuyerVatTin)
            {
            }
            column(BuyerCSTNo; BuyerCSTNo)
            {
            }
            column(CompVat; CompanyInfo."VAT Registration No.")
            {
            }
            /*  //PRU SH 01082022
            column(CompTin; CompanyInfo."T.I.N. No.")
            {
            }
            column(CompCst; CompanyInfo."C.S.T No.")
            {
            }
            */  //PRU SH 01082022
            column(CompTin; CompTin)
            {
            }
            column(CompCst; CompCst)
            {
            }
            column(CompPan; CompanyInfo."P.A.N. No.")
            {
            }
            column(SellerTin; SellerTin)
            {
            }
            column(SellerCst; SellerCSTNo)
            {
            }
            column(BuyerGST; BuyerGST)
            {
            }
            column(SellerGST; SellerGST)
            {
            }
            column(BuyStateDesc; BuyStateDesc)
            {
            }
            column(SelStateDesc; SelStateDesc)
            {
            }
            column(BuyStateGSTCode; BuyStateGSTCode)
            {
            }
            column(SelStateGSTCode; SelStateGSTCode)
            {
            }
            column(BillToCap; BillToCap)
            {
            }
            column(CustCodeCap; CustCodeCap)
            {
            }
            column(NameCap; NameCap)
            {
            }
            column(AddressCap; AddressCap)
            {
            }
            column(ContactCap; ContactCap)
            {
            }
            column(StateCap; StateCap)
            {
            }
            column(StateCodeCap; StateCodeCap)
            {
            }
            column(GSTINCap; GSTINCap)
            {
            }
            column(ConsigCap; ConsigCap)
            {
            }
            column(IGSTCap; IGSTCap)
            {
            }
            column(CGSTCap; CGSTCap)
            {
            }
            column(SGSTCap; SGSTCap)
            {
            }
            column(HSNCodeCap; HSNCodeCap)
            {
            }
            column(CorpCap; CorpCap)
            {
            }
            column(TransferOrderNo_TransferShipmentHeader; "Transfer Shipment Header"."Transfer Order No.")
            {
            }
            column(EInvNo; "Transfer Shipment Header"."E-Invoice No.")
            {
            }
            column(QRCode; "Transfer Shipment Header"."E-Invoice QR Code")
            {
            }
            column(ComNote; ComNote)
            {

            }
            column(DocExemp; DocExemp)
            {

            }
            dataitem("Transfer Shipment Line"; "Transfer Shipment Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                column(ItemNo; "Item No.")
                {
                }
                column(Descripton; "Transfer Shipment Line"."Description 2" + '-' + "Transfer Shipment Line".Description)
                {
                }
                column(UnitPrice; "Transfer Shipment Line"."Unit Price")
                {
                }
                column(Quantity; Quantity)
                {
                }
                column(ActualWeight; ActualWeight * Quantity)
                {
                }
                column(UOM; "Transfer Shipment Line"."Unit of Measure Code")
                {
                }
                column(Amount; Amount)
                {
                }
                column(SNO; Sno)
                {
                }
                column(SerialNo; SerialNo)
                {
                }
                column(LotNo; LotNo)
                {
                }
                column(ItemHSNCode; ItemHSNCode)
                {
                }
                column(IGSTPer; IGSTPer)
                {
                }
                column(CGSTPer; CGSTPer)
                {
                }
                column(SGSTPer; SGSTPer)
                {
                }
                column(IGSTAmt; IGSTAmt)
                {
                }
                column(CGSTAmt; CGSTAmt)
                {
                }
                column(SGSTAmt; SGSTAmt)
                {
                }
                column(TotalIGSTAmt; TotalIGSTAmt)
                {
                }
                column(LineAmount; LineAmount)
                {
                }
                column(TotalAmount; TotalAmount)
                {
                }
                column(ItemType; ItemType)
                {
                }

                trigger OnAfterGetRecord()
                begin

                    Clear(ItemType);
                    Clear(ItemHSNCode);
                    ItemRec.RESET;
                    ItemRec.SETRANGE("No.", "Item No.");
                    IF ItemRec.FindFirst() THEN begin
                        ItemHSNCode := ItemRec."HSN/SAC Code";
                        ItemType := ItemRec."Item Type";
                    end;
                    Sno += 1;
                    SerialNo := '';
                    LotNo := '';
                    LotIndex := 0;
                    SrNoIndex := 0;

                    ReservationEntry.RESET;
                    ReservationEntry.SETRANGE(ReservationEntry."Source ID", "Document No.");
                    ReservationEntry.SETRANGE(ReservationEntry."Source Ref. No.", "Line No.");
                    ReservationEntry.SETFILTER(ReservationEntry."Source Subtype", '<>%1', 0);
                    ReservationEntry.SETCURRENTKEY(ReservationEntry."Lot No.");
                    IF ReservationEntry.FINDFIRST THEN
                        REPEAT
                            IF (ReservationEntry."Lot No." <> '') AND (ReservationEntry."Lot No." <> PreLotNo) THEN BEGIN
                                LotIndex := LotIndex + 1;
                                IF LotIndex = 1 THEN
                                    LotNo := LotNo + ReservationEntry."Lot No."
                                ELSE
                                    LotNo := LotNo + ' , ' + ReservationEntry."Lot No.";
                            END;

                            IF ReservationEntry."Serial No." <> '' THEN BEGIN
                                SrNoIndex := SrNoIndex + 1;
                                IF SrNoIndex = 1 THEN
                                    SerialNo := SerialNo + ReservationEntry."Serial No."
                                ELSE
                                    SerialNo := SerialNo + ' , ' + ReservationEntry."Serial No.";
                            END;
                            PreLotNo := ReservationEntry."Lot No.";
                        UNTIL ReservationEntry.NEXT = 0;




                    Clear(IGSTAmt);
                    Clear(IGSTPer);
                    Clear(CGSTAmt);
                    Clear(CGSTPer);
                    Clear(SGSTAmt);
                    Clear(SGSTPer);
                    Clear(TotalIGSTAmt);
                    //Pru-AJ 1.0
                    DetGSTLedEntry.RESET;
                    DetGSTLedEntry.SETRANGE("Document No.", "Transfer Shipment Header"."No.");
                    // DetGSTLedEntry.SETRANGE("Original Doc. Type", DetGSTLedEntry."Original Doc. Type"::"Transfer Shipment");  //PRU SH 01082022
                    DetGSTLedEntry.SETRANGE("Document Line No.", "Transfer Shipment Line"."Line No.");
                    IF DetGSTLedEntry.FINDFIRST THEN
                        REPEAT
                            IF DetGSTLedEntry."GST Component Code" = 'IGST' THEN BEGIN
                                IGSTAmt := DetGSTLedEntry."GST Amount" * (-1);
                                IGSTPer := DetGSTLedEntry."GST %";
                            END;
                            IF DetGSTLedEntry."GST Component Code" = 'CGST' THEN BEGIN
                                CGSTAmt += DetGSTLedEntry."GST Amount" * (-1);
                                CGSTPer += DetGSTLedEntry."GST %";
                            END;
                            IF ((DetGSTLedEntry."GST Component Code" = 'SGST') OR (DetGSTLedEntry."GST Component Code" = 'UTGST')) THEN BEGIN
                                SGSTAmt += DetGSTLedEntry."GST Amount" * (-1);
                                SGSTPer += DetGSTLedEntry."GST %";
                            END;
                        UNTIL DetGSTLedEntry.NEXT = 0;
                    TotalIGSTAmt := TotalIGSTAmt + IGSTAmt;
                    LineAmount := 0;
                    LineAmount := Amount + IGSTAmt;
                    TotalAmount := TotalAmount + Amount + IGSTAmt;
                    Check.InitTextVariable;
                    Check.FormatNoText1(AmtInWords, Round(TotalAmount, 0.01), '');
                    //DetGSTLedEntry.


                end;
            }

            trigger OnAfterGetRecord()
            var
                LocFrom: Record Location;
                LocTo: Record Location;
                transline: Record "Transfer Shipment Line";



            begin
                LocFrom.Get("Transfer Shipment Header"."Transfer-from Code");
                LocTo.get("Transfer Shipment Header"."Transfer-to Code");
                if LocFrom."GST Registration No." <> LocTo."GST Registration No." then begin
                    //Pru 161220 #P0272 >>
                    IF "Posting Date" > 20200930D THEN BEGIN
                        DetailedGSTLedgerEntry.RESET;
                        DetailedGSTLedgerEntry.SETRANGE("Document No.", "Transfer Shipment Header"."No.");
                        DetailedGSTLedgerEntry.SETFILTER("GST Amount", '<>%1', 0);
                        IF DetailedGSTLedgerEntry.FINDFIRST THEN BEGIN
                            "Transfer Shipment Header".TESTFIELD("E-Invoice No.");
                        END;
                    END;

                END else begin
                    ComNote := 'Transfer of Goods to own locations within the same state';

                end;
                DocExemp := false;
                transline.Reset();
                transline.SetRange("Document No.", "Transfer Shipment Header"."No.");
                //transline.SetRange("Line No.", "Transfer Shipment Line"."Line No.");
                transline.SetRange(Exempted, TRUE);
                if transline.FindFirst() then
                    DocExemp := true;


                Clear(InvoiceType);
                if LocFrom."State Code" = LocTo."State Code" then
                    InvoiceType := 'DELIVERY CHALLAN';
                if LocFrom."State Code" <> LocTo."State Code" then begin
                    if DocExemp then
                        InvoiceType := 'BILL OF SUPPLY';
                    if not DocExemp then
                        InvoiceType := 'TAX INVOICE';

                end;


                //<<
                //PRU SH 01082022

                //Pru-AJ 1.0 >>>>>>>>>
                FormatAddr.Company(CompanyAddr, CompanyInfo);
                //Pru-AJ 1.0 <<<<<<<<<<<<<<
                CLEAR(bool2);
                CLEAR(bool1);
                LocationRec.RESET;
                LocationRec.SETRANGE(LocationRec.Code, "Transfer-to Code");
                IF LocationRec.FINDFIRST THEN BEGIN
                    //   BuyerVatTin := LocationRec."T.I.N. No.";
                    //  BuyerCSTNo := LocationRec."C.S.T No.";
                    BuyerContact := LocationRec.Contact;
                    //BuyerTin := LocationRec."T.I.N. No.";
                    //BuyerCst := LocationRec."C.S.T No.";
                    BuyerEmail := LocationRec."E-Mail";
                    BuyerGST := LocationRec."GST Registration No.";
                    StateRec.RESET;
                    StateRec.SETRANGE(Code, LocationRec."State Code");
                    IF StateRec.FINDFIRST THEN BEGIN
                        BuyStateDesc := StateRec.Description;
                        BuyStateGSTCode := StateRec."State Code (GST Reg. No.)";
                    END;
                END;
                //PRU SH 01082022
                LocationRec.RESET;
                LocationRec.SETRANGE(LocationRec.Code, "Transfer-from Code");
                IF LocationRec.FINDFIRST THEN BEGIN
                    SellerContact := LocationRec.Contact;
                    // SellerCSTNo := LocationRec."C.S.T No.";  //PRU SH 01082022
                    // SellerTin := LocationRec."T.I.N. No.";  //PRU SH 01082022
                    SellerGST := LocationRec."GST Registration No.";
                    StateRec.RESET;
                    StateRec.SETRANGE(Code, LocationRec."State Code");
                    IF StateRec.FINDFIRST THEN BEGIN
                        SelStateDesc := StateRec.Description;
                        SelStateGSTCode := StateRec."State Code (GST Reg. No.)";
                    END;
                END;

                IF BuyerGST <> '' THEN BEGIN
                    CompanyName1 := CompanyInfo.Name;
                    bool1 := TRUE;
                END;
                IF BuyerGST = '' THEN BEGIN
                    CompanyName1 := "Transfer Shipment Header"."Transfer-to Name";
                    bool1 := FALSE;
                END;


                IF SellerGST <> '' THEN BEGIN
                    CompanyName2 := CompanyInfo.Name;
                    bool2 := TRUE;
                END;

                IF SellerGST = '' THEN BEGIN
                    CompanyName2 := "Transfer Shipment Header"."Transfer-from Name";
                    bool2 := FALSE;
                END;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("Copy Type"; CopyType)
                {
                    ApplicationArea = All;
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        Sno := 0;
        CompanyInfo.GET;
        CompanyInfo.CALCFIELDS(CompanyInfo.Picture);
        IF CopyType = 0 THEN
            CopyType := CopyType::"Original for Recipient";
        //MESSAGE(FORMAT(CopyType));
    end;

    var
        CompanyName2: Text;
        bool2: Boolean;
        bool1: Boolean;
        NoOfFixedLine: Integer;
        NoOfBlankLine: Integer;
        CompanyInfo: Record 79;
        TransferLine: Record 5741;
        TotalAmount: Decimal;
        Check: Report CheckPrint1;
        AmtInWords: array[2] of Text;
        Sno: Integer;
        ReservationEntry: Record 337;
        SerialNo: Text;
        SrIndex: Integer;
        LotNo: Text;
        LotIndex: Integer;
        SrNoIndex: Integer;
        PreLotNo: Text;
        ItemRec: Record 27;
        ActualWeight: Decimal;
        LocationRec: Record 14;
        BuyerVatTin: Text;
        BuyerCSTNo: Text;
        BuyerContact: Text;
        BuyerTin: Text;
        BuyerCst: Text;
        BuyerEmail: Text;
        SellerContact: Text;
        InvoiceDate: Label 'InvoiceDate';
        T_Name: Label 'Transpoter Name';
        LR_Date: Label 'LR Date';
        RegrNo: Label 'Vehicle No';
        Check_Post: Label 'Check Post';
        PermitIn: Label 'Permit In';
        PermitOut: Label 'Permit Out';
        PageTitle: Label 'Stock Transfer Outward';
        ItemNo: Label 'Item No';
        Description: Label 'Description of Goods';
        Toll_Free: Label '';
        Email: Label '';
        CIN: Label 'CIN : L52109DL1977PLC025405';
        TCGI: Label 'This is a Computer Generated Invoice';
        TotalWeight: Label 'Total Weight';
        NoofCase: Label 'No of Case';
        NoCase: Decimal;
        SellerVat: Text;
        SellerCSTNo: Text;
        SellerTin: Text;
        SellerCst: Text;
        ItemUnitOfMeasure: Record 5404;
        BillToCap: Label 'Bill To: ';
        CustCodeCap: Label 'Customer Code';
        NameCap: Label 'Name:';
        AddressCap: Label 'Address:';
        ContactCap: Label 'Contact Details';
        StateCap: Label 'State:';
        StateCodeCap: Label 'State Code:';
        GSTINCap: Label 'GSTIN/Unique ID:';
        ConsigCap: Label 'Consigner Name:';
        BuyerGST: Code[15];
        SellerGST: Code[15];
        ItemHSNCode: Code[8];
        DetGSTLedEntry: Record "Detailed GST Ledger Entry";//16419;
        IGSTPer: Decimal;
        CGSTPer: Decimal;
        SGSTPer: Decimal;
        IGSTAmt: Decimal;
        CGSTAmt: Decimal;
        SGSTAmt: Decimal;
        StateRec: Record State;
        BuyStateDesc: Text[50];
        SelStateGSTCode: Code[2];
        SelStateDesc: Text[50];
        BuyStateGSTCode: Code[2];
        CompanyAddr: array[8] of Text[50];
        RespCenter: Record 5714;
        FormatAddr: Codeunit 365;
        CorpOffcCap: Label 'CORP OFFICE:';
        IGSTCap: Label 'IGST';
        CGSTCap: Label 'CGST';
        SGSTCap: Label 'SGST/UTGST';
        HSNCodeCap: Label 'HSN Code';
        CorpCap: Label 'CORP OFFICE: ';
        LineAmount: Decimal;
        TotalIGSTAmt: Decimal;
        CopyType: Option " ","Original for Recipient","Duplicate for Transporter","Triplicate for Supplier","Extra Copy";
        Copy_type: Label 'Please Select the Copy Type';
        CompanyName1: Text;
        DetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry";//16419;
        CompTin: Code[10];
        CompCst: Code[10];
        ItemType: Option " ",Feed,Vaccination,Medicine,Bird,Chick,Egg,GEN,"Other Suppliment",Premix,"Feed Suppliment",Bardana,RM,Scrap;
        Text100: Label '"Transfer of Goods to own locations within the same state"';
        ComNote: Text;
        ComNote1: Text;
        DocExemp: Boolean;
        ShipLoc: Record Location;
        ReceLoc: Record Location;
        InvoiceType: text;
}

