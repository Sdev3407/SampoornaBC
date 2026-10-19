report 50012 "RGP/NRGP/RRGP Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'ReportLayout\50012Report.rdl';
    PreviewMode = PrintLayout;
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(CopyLoop; Integer)
        {

            DataItemTableView = sorting(Number);

            column(DocumentCaptionCopyText; StrSubstNo(Text002, CopyText))
            { }
            column(OutputNo; OutputNo)
            { }
            dataitem("Gate Pass Header"; "Gate Pass Header")
            {
                DataItemTableView = SORTING("Document Type", "No.")
                                WHERE(Posted = FILTER(true));
                RequestFilterFields = "Document Type", "No.";
                column(UserID_GatePassHeader; "Gate Pass Header"."User ID")
                {
                }
                column(GSTIN; GSTIN)
                {
                }
                column(CompOld; CompOld)
                {
                }
                column(OldPic; CompanyInformationOld.Picture)
                {
                }
                column(CompanyInfPicture; CompanyInf.Picture)
                {
                }
                column(CompanyInfName; CompName1)
                {
                }
                column(CompName2; CompName2)
                {
                }
                // column(CompanyAddress; CompAddress + CompanyInf.City + ', ' + CompanyInf."State Code" + ' - ' + CompanyInf."Post Code")
                column(CompanyAddress; CompAddress + CompanyInf.City + ', ' + CompanyInf.County + ' - ' + CompanyInf."Post Code")
                {
                }
                column(CompanyPhone; 'Ph. : ' + CompanyInf."Phone No." + '   Fax : ' + CompanyInf."Fax No.")
                {
                }
                column(CompanyWebsite; 'Website : ' + CompanyInf."Home Page")
                {
                }
                column(CompanyInf_EMail; CompEmailPhoneNo)
                {
                }
                column(TextOne; Text1)
                {
                }
                column("To"; 'To')
                {
                }
                column(Name; Name)
                {
                }
                column(AddressAddressOne; Address + ' ' + Address1 + ' ')
                {
                }
                column(ConsingneeTINNoTINNo; 'Consingnee TIN No. ' + TINNo)
                {
                }
                column(CompanyInfTINNo; '')
                {
                }
                column(CompanyInfCSTNo; '')
                {
                }
                column(DoubleQuote; '')
                {
                }
                column(TaxSaleInvoiceDate; 'Tax / Sale Invoice Date :')
                {
                }
                column(GatePassHeaderDocumentType; "Gate Pass Header"."Document Type")
                {
                }
                column(GatePassHeaderNo; "Gate Pass Header"."No.")
                {
                }
                column(GatePassHeaderPostingDate; "Gate Pass Header"."Posting Date")
                {
                }
                column(RGPNo; "RGP No.")
                {
                }
                column(Pending_Qty; "Pending Qty")
                {

                }
                column(Total_Qty; "Total Qty")
                {

                }
                column(DateOfReturn; "Date Of Return")
                {
                }
                column(SrNo; 'Sr.N')
                {
                }
                column(ItemCode; 'Item Code')
                {
                }
                column(ItemDescription; 'Item Description')
                {
                }
                column(PartNo; 'PartNo')
                {
                }
                column(UOM; 'UOM')
                {
                }
                column(Quantity; 'Quantity')
                {
                }
                column(RGPQty; 'RGP Qty')
                {
                }
                column(VAlue; 'Value')
                {
                }
                column(Purpose; 'Purpose')
                {
                }
                column(LRRRNo; "LR/RR No.")
                {
                }
                column(ModeofTransport; "Mode of Transport")
                {
                }
                column(RoadPermitNo; "Road Permit No.")
                {
                }
                column(MValue; Mvalue)
                {
                }
                column(LRDate; "LR Date")
                {
                }
                column(TransportCompany; "Transport Company")
                {
                }
                column(Prepared_By; "User ID")
                {
                }
                column(DriverName; "Driver Name")
                {
                }
                column(DriverPhoneNo; "Driver Phone No.")
                {
                }
                column(EmpName; '')
                {
                }
                column(GSTRegistrationNo_CompanyInf; CompGSTIN)
                {
                }
                dataitem("Gate Pass Line"; "Gate Pass Line")
                {
                    DataItemLinkReference = "Gate Pass Header";
                    DataItemLink = "Document Type" = FIELD("Document Type"),
                               "Document No." = FIELD("No.");
                    DataItemTableView = SORTING("Document Type", "Document No.", "Line No.");

                    column(SrN; SrN)
                    {
                    }
                    column(ItemNo; "Item No.")
                    {
                    }
                    column(GatepassLineDescription; "Gate pass Line".Description)
                    {
                    }
                    // column(ItemMagnaRicoCode; Item."Magna Rico Code")
                    // {
                    // }
                    column(ItemMagnaRicoCode; "Gate pass Line"."Unit Cost")
                    {
                    }
                    column(GatepassLineUnitofMeasureCode; "Gate pass Line"."Unit of Measure Code")
                    {
                    }
                    column(GatepassLineQuantity; "Gate pass Line".Quantity)
                    {
                    }
                    column(RGPQtyOne; "RGP Qty.")
                    {
                    }
                    column(Remarks; Remarks)
                    {
                    }

                    trigger OnAfterGetRecord();
                    begin
                        /*
                        ItemRec.RESET;
                        ItemRec.SETRANGE(ItemRec."No.","Gate pass Line"."Item No.");
                        IF ItemRec.FINDFIRST THEN  BEGIN
                        "ItemNo.":=ItemRec."No.";
                         Itemdesc:=ItemRec.Description;
                         END;
                         */
                        IF Item.GET("Gate pass Line"."Item No.") THEN;

                        SrN += 1;
                        IF "Gate pass Line".Value = 0 THEN BEGIN
                            Mvalue := "Gate pass Line".Quantity * "Gate pass Line"."Unit Cost";
                        END ELSE BEGIN
                            Mvalue := "Gate pass Line".Value;
                        END;

                    end;

                    trigger OnPreDataItem();
                    begin
                        CurrReport.CREATETOTALS(Mvalue);
                    end;
                }

                trigger OnAfterGetRecord();
                begin

                    SrN := 0;

                    Name := '';
                    Address := '';
                    Address1 := '';
                    TINNo := '';
                    GSTIN := '';
                    IF Vendor.GET("Gate Pass Header"."Code") THEN BEGIN
                        Name := Vendor.Name;
                        Address := Vendor.Address;
                        Address1 := Vendor."Address 2" + ' ' + Vendor.City;
                        GSTIN := Vendor."GST Registration No.";
                    END;

                    IF Customer.GET("Gate Pass Header"."Code") THEN BEGIN
                        Name := Customer.Name;
                        Address := Customer.Address;
                        Address1 := Customer."Address 2" + ' ' + Customer.City;
                        GSTIN := Customer."GST Registration No.";
                    END;

                    IF "Gate Pass Header"."Document Type" = "Gate Pass Header"."Document Type"::NRGP THEN
                        Text1 := 'Non-Returnable Material Gate Pass'
                    ELSE
                        IF "Gate Pass Header"."Document Type" = "Gate Pass Header"."Document Type"::RGP THEN
                            Text1 := 'Returnable Material Gate Pass'
                        ELSE
                            IF "Gate Pass Header"."Document Type" = "Gate Pass Header"."Document Type"::RRGP THEN
                                Text1 := 'Re-Returnable Material Gate Pass'
                            ELSE
                                Text1 := '';

                    //CORP::PK 040619 >>>
                    CompName1 := '';
                    CompName2 := '';
                    CompAddress := '';
                    CompEmailPhoneNo := '';
                    CompGSTIN := '';
                    CINNO := '';
                    PANNo := '';
                    IF "Gate Pass Header"."Posting Date" <= 20190530D THEN BEGIN
                        CompName1 := CompanyInformationOld.Name;
                        CompName2 := CompanyInformationOld."Name 2";
                        CompAddress := CompanyInformationOld.Address + ' ,' + CompanyInformationOld."Address 2";
                        CompEmailPhoneNo := CompanyInformationOld."E-Mail" + ', PH. -' + CompanyInformationOld."Phone No." + '-' + CompanyInformationOld."Phone No. 2";
                        CompGSTIN := CompanyInformationOld."GST Registration No.";
                        CINNO := CompanyInformationOld."Registration No.";
                        PANNo := CompanyInformationOld."P.A.N. No.";
                        CompOld := TRUE;
                    END ELSE BEGIN
                        CompName1 := CompanyInf.Name;
                        CompName2 := CompanyInf."Name 2";
                        CompAddress := CompanyInf.Address + ' ,' + CompanyInf."Address 2";
                        CompEmailPhoneNo := CompanyInf."E-Mail" + ', PH. -' + CompanyInf."Phone No." + '-' + CompanyInf."Phone No. 2";
                        CompGSTIN := CompanyInf."GST Registration No.";
                        CINNO := CompanyInf."Registration No.";
                        PANNo := CompanyInf."P.A.N. No.";
                        CompOld := FALSE;
                    END;
                    //CORP::PK 040619 <<<
                end;

                trigger OnPreDataItem();
                begin
                    CompanyInf.GET;
                    CompanyInf.CALCFIELDS(Picture);
                    CompanyInformationOld.GET;
                    CompanyInformationOld.CALCFIELDS(Picture);
                end;
            }
            trigger OnPreDataItem()
            begin
                NoOfLoops := ABS(NoOfCopies);
                IF NoOfLoops <= 0 THEN
                    NoOfLoops := 1;
                // CopyText := '';
                SETRANGE(Number, 1, NoOfLoops);
                OutputNo := 1;
                CopyText := 'Original for Receipient';
            end;

            trigger OnAfterGetRecord()
            begin
                if Number = 1 then
                    CopyText := 'Original for Receipient';
                // CopyText := DocumentCaption(OutputNo);
                IF Number > 1 THEN BEGIN
                    OutputNo += 1;
                    CopyText := DocumentCaption(OutputNo);
                END;
            end;
        }
    }
    requestpage
    {

        layout
        {
            area(Content)
            {
                group(Options)
                {
                    field(NoOfCopies; NoOfCopies)
                    {
                        Caption = 'No. of Copies';
                        ApplicationArea = All;
                    }
                }
            }
        }
    }

    labels
    {
    }
    procedure DocumentCaption(OutNo: Integer): Text;
    var
    begin
        if OutNo = 2 then
            Exit('Duplicate For Gate');
        if OutNo = 3 then
            Exit('Triplicate For Receiveing ');
    end;

    trigger OnInitReport()
    begin
        NoOfCopies := 3;
    end;

    var
        CompanyInf: Record "Company Information";
        FormatAddr: Codeunit "Format Address";
        CompanyInfo: Record "Company Information";
        SrN: Integer;
        Item: Record "Item";
        Vendor: Record "Vendor";
        Customer: Record "Customer";
        Name: Text[50];
        Address: Text[100];
        Address1: Text[100];
        TINNo: Code[20];
        ItemRec: Record "Item";
        GateLineRec: Record "Gate Pass Line";
        PartNo: Code[10];
        Mvalue: Decimal;
        Text1: Text[50];
        "ItemNo.": Code[10];
        Itemdesc: Text[50];
        Empdesc: Text[50];
        //CompanyInformationOld : Record "Company Information Old";
        CompanyInformationOld: Record "Company Information";
        CompName1: Text;
        CompName2: Text;
        CompAddress: Text;
        CompEmailPhoneNo: Text;
        CompGSTIN: Text;
        CINNO: Text;
        PANNo: Text;
        IECNo: Text;
        CompOld: Boolean;
        GSTIN: Code[20];
        NoOfCopies: Integer;
        NoOfLoops: Integer;
        CopyText: Text;
        OutputNo: Integer;
        Text003: Label 'COPY';
        Text002: Label '%1', Comment = '%1 = Document No.';
}

