page 50083 "Navigate and Update Naration"
{
    Caption = 'Navigate';
    DataCaptionExpression = GetCaptionText;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Worksheet;
    PromotedActionCategories = 'New,Process,Report,Find By';
    SaveValues = false;
    SourceTable = 265;
    SourceTableTemporary = true;
    ApplicationArea = All;
    UsageCategory = Documents;
    Permissions = tabledata "G/L Entry" = RIMD,
    tabledata "Purch. Inv. Header" = RIMD,
    tabledata "Vendor Ledger Entry" = RIMD;
    layout
    {
        area(content)
        {
            group(Document)
            {
                Caption = 'Document';
                Visible = DocumentVisible;
                field(DocNoFilter; DocNoFilter)
                {
                    ApplicationArea = All;
                    Caption = 'Document No.';
                    Editable = true;
                    TableRelation = "G/L Entry"."Document No.";

                    trigger OnValidate()
                    begin
                        SetDocNo(DocNoFilter);
                        ContactType := ContactType::" ";
                        ContactNo := '';
                        ExtDocNo := '';
                        ClearTrackingInfo;
                        DocNoFilterOnAfterValidate;
                        FilterSelectionChanged;
                    end;
                }
                field("Line Narration"; LineNaration)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("New Line Narration"; NewLineNaration)
                {
                    ApplicationArea = All;
                }
            }
            group(Notification)
            {
                Caption = 'Notification';
                InstructionalText = 'The filter has been changed. Choose Find to update the list of related entries.';
                Visible = FilterSelectionChangedTxtVisible;
            }
            repeater(grp)
            {
                Editable = false;
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Table ID"; Rec."Table ID")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Table Name"; Rec."Table Name")
                {
                    ApplicationArea = All;
                    Caption = 'Related Entries';
                }
                field("No. of Records"; Rec."No. of Records")
                {
                    ApplicationArea = All;
                    Caption = 'No. of Entries';
                    DrillDown = true;

                    trigger OnDrillDown()
                    begin
                        ShowRecords;
                    end;
                }
            }
            group(Source)
            {
                Caption = 'Source';
                field(DocType; DocType)
                {
                    ApplicationArea = All;
                    Caption = 'Document Type';
                    Editable = false;
                    Enabled = DocTypeEnable;
                }
                field(SourceType; SourceType)
                {
                    ApplicationArea = All;
                    Caption = 'Source Type';
                    Editable = false;
                    Enabled = SourceTypeEnable;
                }
                field(SourceNo; SourceNo)
                {
                    ApplicationArea = All;
                    Caption = 'Source No.';
                    Editable = false;
                    Enabled = SourceNoEnable;
                }
                field(SourceName; SourceName)
                {
                    ApplicationArea = All;
                    Caption = 'Source Name';
                    Editable = false;
                    Enabled = SourceNameEnable;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(Process)
            {
                Caption = 'Process';
            }
        }
    }

    trigger OnInit()
    begin
        SourceNameEnable := TRUE;
        SourceNoEnable := TRUE;
        SourceTypeEnable := TRUE;
        DocTypeEnable := TRUE;
        PrintEnable := TRUE;
        ShowEnable := TRUE;
        DocumentVisible := TRUE;
        FindBasedOn := FindBasedOn::Document;
    end;

    trigger OnOpenPage()
    var
        GLEntry: Record 17;
    begin
        UpdateForm := TRUE;
        FindRecordsOnOpen;
        GLEntry.RESET;
        GLEntry.SETRANGE(GLEntry."Document No.", NewDocNo);
        IF GLEntry.FINDFIRST THEN
            LineNaration := GLEntry."Line Narration1";
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    var
        GLEntry: Record 17;
        CustLedgerEntry: Record 21;
        SalesInvoiceHeader: Record 112;
        VendorLedgerEntry: Record 25;
        PurchInvHeader: Record 122;
    begin
        UpdateLineNarration;
    end;

    var
        Text000: Label 'The business contact type was not specified.';
        Text001: Label 'There are no posted records with this external document number.';
        Text002: Label 'Counting records...';
        Text003: Label 'Posted Sales Invoice';
        Text004: Label 'Posted Sales Credit Memo';
        Text005: Label 'Posted Sales Shipment';
        Text006: Label 'Issued Reminder';
        Text007: Label 'Issued Finance Charge Memo';
        Text008: Label 'Posted Purchase Invoice';
        Text009: Label 'Posted Purchase Credit Memo';
        Text010: Label 'Posted Purchase Receipt';
        Text011: Label 'The document number has been used more than once.';
        Text012: Label 'This combination of document number and posting date has been used more than once.';
        Text013: Label 'There are no posted records with this document number.';
        Text014: Label 'There are no posted records with this combination of document number and posting date.';
        Text015: Label 'The search results in too many external documents. Specify a business contact no.';
        Text016: Label 'The search results in too many external documents. Use Navigate from the relevant ledger entries.';
        Text017: Label 'Posted Return Receipt';
        Text018: Label 'Posted Return Shipment';
        Text019: Label 'Posted Transfer Shipment';
        Text020: Label 'Posted Transfer Receipt';
        Text021: Label 'Sales Order';
        Text022: Label 'Sales Invoice';
        Text023: Label 'Sales Return Order';
        Text024: Label 'Sales Credit Memo';
        Text025: Label 'Posted Assembly Order';
        sText003: Label 'Posted Service Invoice';
        sText004: Label 'Posted Service Credit Memo';
        sText005: Label 'Posted Service Shipment';
        sText021: Label 'Service Order';
        sText022: Label 'Service Invoice';
        sText024: Label 'Service Credit Memo';
        Text99000000: Label 'Production Order';
        [SecurityFiltering(SecurityFilter::Filtered)]
        Cust: Record 18;
        [SecurityFiltering(SecurityFilter::Filtered)]
        Vend: Record 23;
        SOSalesHeader: Record 36;
        SISalesHeader: Record 36;
        SROSalesHeader: Record 36;
        SCMSalesHeader: Record 36;
        [SecurityFiltering(SecurityFilter::Filtered)]
        SalesShptHeader: Record 110;
        [SecurityFiltering(SecurityFilter::Filtered)]
        SalesInvHeader: Record 112;
        [SecurityFiltering(SecurityFilter::Filtered)]
        ReturnRcptHeader: Record 6660;
        [SecurityFiltering(SecurityFilter::Filtered)]
        SalesCrMemoHeader: Record 114;
        SOServHeader: Record 5900;
        SIServHeader: Record 5900;
        SCMServHeader: Record 5900;
        [SecurityFiltering(SecurityFilter::Filtered)]
        ServShptHeader: Record 5990;
        [SecurityFiltering(SecurityFilter::Filtered)]
        ServInvHeader: Record 5992;
        [SecurityFiltering(SecurityFilter::Filtered)]
        ServCrMemoHeader: Record 5994;
        [SecurityFiltering(SecurityFilter::Filtered)]
        IssuedReminderHeader: Record 297;
        [SecurityFiltering(SecurityFilter::Filtered)]
        IssuedFinChrgMemoHeader: Record 304;
        [SecurityFiltering(SecurityFilter::Filtered)]
        PurchRcptHeader: Record 120;
        [SecurityFiltering(SecurityFilter::Filtered)]
        PurchInvHeader: Record 122;
        [SecurityFiltering(SecurityFilter::Filtered)]
        ReturnShptHeader: Record 6650;
        [SecurityFiltering(SecurityFilter::Filtered)]
        PurchCrMemoHeader: Record 124;
        [SecurityFiltering(SecurityFilter::Filtered)]
        ProductionOrderHeader: Record 5405;
        [SecurityFiltering(SecurityFilter::Filtered)]
        PostedAssemblyHeader: Record 910;
        [SecurityFiltering(SecurityFilter::Filtered)]
        TransShptHeader: Record 5744;
        [SecurityFiltering(SecurityFilter::Filtered)]
        TransRcptHeader: Record 5746;
        [SecurityFiltering(SecurityFilter::Filtered)]
        PostedWhseRcptLine: Record 7319;
        [SecurityFiltering(SecurityFilter::Filtered)]
        PostedWhseShptLine: Record 7323;
        [SecurityFiltering(SecurityFilter::Filtered)]
        GLEntry: Record 17;
        [SecurityFiltering(SecurityFilter::Filtered)]
        VATEntry: Record 254;
        [SecurityFiltering(SecurityFilter::Filtered)]
        CustLedgEntry: Record 21;
        [SecurityFiltering(SecurityFilter::Filtered)]
        DtldCustLedgEntry: Record 379;
        [SecurityFiltering(SecurityFilter::Filtered)]
        VendLedgEntry: Record 25;
        [SecurityFiltering(SecurityFilter::Filtered)]
        DtldVendLedgEntry: Record 380;
        [SecurityFiltering(SecurityFilter::Filtered)]
        ItemLedgEntry: Record 32;
        [SecurityFiltering(SecurityFilter::Filtered)]
        PhysInvtLedgEntry: Record 281;
        [SecurityFiltering(SecurityFilter::Filtered)]
        ResLedgEntry: Record 203;
        [SecurityFiltering(SecurityFilter::Filtered)]
        JobLedgEntry: Record 169;
        [SecurityFiltering(SecurityFilter::Filtered)]
        JobWIPEntry: Record 1004;
        [SecurityFiltering(SecurityFilter::Filtered)]
        JobWIPGLEntry: Record 1005;
        [SecurityFiltering(SecurityFilter::Filtered)]
        ValueEntry: Record 5802;
        [SecurityFiltering(SecurityFilter::Filtered)]
        BankAccLedgEntry: Record 271;
        [SecurityFiltering(SecurityFilter::Filtered)]
        CheckLedgEntry: Record 272;
        [SecurityFiltering(SecurityFilter::Filtered)]
        ReminderEntry: Record 300;
        [SecurityFiltering(SecurityFilter::Filtered)]
        FALedgEntry: Record 5601;
        [SecurityFiltering(SecurityFilter::Filtered)]
        MaintenanceLedgEntry: Record 5625;
        [SecurityFiltering(SecurityFilter::Filtered)]
        InsuranceCovLedgEntry: Record 5629;
        [SecurityFiltering(SecurityFilter::Filtered)]
        CapacityLedgEntry: Record 5832;
        [SecurityFiltering(SecurityFilter::Filtered)]
        ServLedgerEntry: Record 5907;
        [SecurityFiltering(SecurityFilter::Filtered)]
        WarrantyLedgerEntry: Record 5908;
        [SecurityFiltering(SecurityFilter::Filtered)]
        WhseEntry: Record 7312;
        TempRecordBuffer: Record 6529 temporary;
        [SecurityFiltering(SecurityFilter::Filtered)]
        CostEntry: Record 1104;
        [SecurityFiltering(SecurityFilter::Filtered)]
        IncomingDocument: Record 130;
        GSTTdsTcsEntry: Record "GST TDS/TCS Entry";
        ProvisionalEntry: Record "Provisional Entry";
        // ApplicationManagement: Codeunit applc
        ItemTrackingNavigateMgt: Codeunit 6529;
        Window: Dialog;
        DocNoFilter: Code[250];
        PostingDateFilter: Text[250];
        NewDocNo: Code[20];
        ContactNo: Code[250];
        ExtDocNo: Code[250];
        NewPostingDate: Date;
        DocType: Text[50];
        SourceType: Text[30];
        SourceNo: Code[20];
        SourceName: Text[50];
        ContactType: Option " ",Vendor,Customer;
        DocExists: Boolean;
        NewSerialNo: Code[20];
        NewLotNo: Code[20];
        SerialNoFilter: Code[1000];
        LotNoFilter: Code[1000];
        TaxEntry: Record "Tax Entity";
        //  ExciseEntry: Record "Excise Entry";
        //    RG23APartI: Record "RG 23 A Part I";
        //  RG23CPartI: Record 13721;
        TDSEntry: Record "TDS Entry";
        // RG23APartII: Record 13720;
        // RG23CPartII: Record 13722;
        //   ServiceTaxEntry: Record "Service Tax Entry";
        //  PLA: Record "PLA Entry";
        TCSEntry: Record "TCS Entry";
        //     DetailedTaxEntry: Record "Tax Entry";
        //   RG23D: Record 16537;
        // FBTEntry: Record 16541;
        ////    SvcTaxDistribution: Record 16576;
        //PostedCapitalizeCWIPHeader: Record 16599;
        GSTLedgerEntry: Record "GST Ledger Entry";
        DetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry";
        ServiceTransferShptHeader: Record "Service Transfer Shpt. Header";
        ServiceTransferRcptHeader: Record "Service Transfer Rcpt. Header";
        DetailedCrAdjstmntEntry: Record "Detailed Cr. Adjstmnt. Entry";
        PostedGSTDistributionHeader: Record "Posted GST Distribution Header";
        DetailedGSTDistEntry: Record "Detailed GST Dist. Entry";
        PostedJnlBankCharges: Record "Posted Jnl. Bank Charges";
        PostedGSTLiabilityAdj: Record "Posted GST Liability Adj.";
        [InDataSet]
        ShowEnable: Boolean;
        [InDataSet]
        PrintEnable: Boolean;
        [InDataSet]
        DocTypeEnable: Boolean;
        [InDataSet]
        SourceTypeEnable: Boolean;
        [InDataSet]
        SourceNoEnable: Boolean;
        [InDataSet]
        SourceNameEnable: Boolean;
        UpdateForm: Boolean;
        FindBasedOn: Option Document,"Business Contact","Item Reference";
        [InDataSet]
        DocumentVisible: Boolean;
        [InDataSet]
        BusinessContactVisible: Boolean;
        [InDataSet]
        ItemReferenceVisible: Boolean;
        [InDataSet]
        FilterSelectionChangedTxtVisible: Boolean;
        PageCaptionTxt: Label 'Selected - %1';
        LineNaration: Text;
        NewLineNaration: Text[100];


    procedure SetDoc(PostingDate: Date; DocNo: Code[20])
    begin
        NewDocNo := DocNo;
        NewPostingDate := PostingDate;
    end;

    local procedure FindExtRecords()
    var
        [SecurityFiltering(SecurityFilter::Filtered)]
        VendLedgEntry2: Record 25;
        FoundRecords: Boolean;
        DateFilter2: Code[250];
        DocNoFilter2: Code[250];
    begin
        FoundRecords := FALSE;
        CASE ContactType OF
            ContactType::Vendor:
                BEGIN
                    VendLedgEntry2.SETCURRENTKEY("External Document No.");
                    VendLedgEntry2.SETFILTER("External Document No.", ExtDocNo);
                    VendLedgEntry2.SETFILTER("Vendor No.", ContactNo);
                    IF VendLedgEntry2.FINDSET THEN BEGIN
                        REPEAT
                            MakeExtFilter(
                              DateFilter2,
                              VendLedgEntry2."Posting Date",
                              DocNoFilter2,
                              VendLedgEntry2."Document No.");
                        UNTIL VendLedgEntry2.NEXT = 0;
                        SetPostingDate(DateFilter2);
                        SetDocNo(DocNoFilter2);
                        FindRecords;
                        FoundRecords := TRUE;
                    END;
                END;
            ContactType::Customer:
                BEGIN
                    Rec.DELETEALL;
                    Rec."Entry No." := 0;
                    FindUnpostedSalesDocs(SOSalesHeader."Document Type"::Order, Text021, SOSalesHeader);
                    FindUnpostedSalesDocs(SISalesHeader."Document Type"::Invoice, Text022, SISalesHeader);
                    FindUnpostedSalesDocs(SROSalesHeader."Document Type"::"Return Order", Text023, SROSalesHeader);
                    FindUnpostedSalesDocs(SCMSalesHeader."Document Type"::"Credit Memo", Text024, SCMSalesHeader);
                    IF SalesShptHeader.READPERMISSION THEN BEGIN
                        SalesShptHeader.RESET;
                        SalesShptHeader.SETCURRENTKEY("Sell-to Customer No.", "External Document No.");
                        SalesShptHeader.SETFILTER("Sell-to Customer No.", ContactNo);
                        SalesShptHeader.SETFILTER("External Document No.", ExtDocNo);
                        InsertIntoDocEntry(
                          DATABASE::"Sales Shipment Header", 0, Text005, SalesShptHeader.COUNT);
                    END;
                    IF SalesInvHeader.READPERMISSION THEN BEGIN
                        SalesInvHeader.RESET;
                        SalesInvHeader.SETCURRENTKEY("Sell-to Customer No.", "External Document No.");
                        SalesInvHeader.SETFILTER("Sell-to Customer No.", ContactNo);
                        SalesInvHeader.SETFILTER("External Document No.", ExtDocNo);
                        InsertIntoDocEntry(
                          DATABASE::"Sales Invoice Header", 0, Text003, SalesInvHeader.COUNT);
                    END;
                    IF ReturnRcptHeader.READPERMISSION THEN BEGIN
                        ReturnRcptHeader.RESET;
                        ReturnRcptHeader.SETCURRENTKEY("Sell-to Customer No.", "External Document No.");
                        ReturnRcptHeader.SETFILTER("Sell-to Customer No.", ContactNo);
                        ReturnRcptHeader.SETFILTER("External Document No.", ExtDocNo);
                        InsertIntoDocEntry(
                          DATABASE::"Return Receipt Header", 0, Text017, ReturnRcptHeader.COUNT);
                    END;
                    IF SalesCrMemoHeader.READPERMISSION THEN BEGIN
                        SalesCrMemoHeader.RESET;
                        SalesCrMemoHeader.SETCURRENTKEY("Sell-to Customer No.", "External Document No.");
                        SalesCrMemoHeader.SETFILTER("Sell-to Customer No.", ContactNo);
                        SalesCrMemoHeader.SETFILTER("External Document No.", ExtDocNo);
                        InsertIntoDocEntry(
                          DATABASE::"Sales Cr.Memo Header", 0, Text004, SalesCrMemoHeader.COUNT);
                    END;
                    FindUnpostedServDocs(SOServHeader."Document Type"::Order, sText021, SOServHeader);
                    FindUnpostedServDocs(SIServHeader."Document Type"::Invoice, sText022, SIServHeader);
                    FindUnpostedServDocs(SCMServHeader."Document Type"::"Credit Memo", sText024, SCMServHeader);
                    IF ServShptHeader.READPERMISSION THEN BEGIN
                        IF ExtDocNo = '' THEN BEGIN
                            ServShptHeader.RESET;
                            ServShptHeader.SETCURRENTKEY("Customer No.");
                            ServShptHeader.SETFILTER("Customer No.", ContactNo);
                            InsertIntoDocEntry(
                              DATABASE::"Service Shipment Header", 0, sText005, ServShptHeader.COUNT);
                        END;
                    END;
                    IF ServInvHeader.READPERMISSION THEN BEGIN
                        IF ExtDocNo = '' THEN BEGIN
                            ServInvHeader.RESET;
                            ServInvHeader.SETCURRENTKEY("Customer No.");
                            ServInvHeader.SETFILTER("Customer No.", ContactNo);
                            InsertIntoDocEntry(
                              DATABASE::"Service Invoice Header", 0, sText003, ServInvHeader.COUNT);
                        END;
                    END;
                    IF ServCrMemoHeader.READPERMISSION THEN BEGIN
                        IF ExtDocNo = '' THEN BEGIN
                            ServCrMemoHeader.RESET;
                            ServCrMemoHeader.SETCURRENTKEY("Customer No.");
                            ServCrMemoHeader.SETFILTER("Customer No.", ContactNo);
                            InsertIntoDocEntry(
                              DATABASE::"Service Cr.Memo Header", 0, sText004, ServCrMemoHeader.COUNT);
                        END;
                    END;

                    DocExists := FINDFIRST;

                    UpdateFormAfterFindRecords;
                    FoundRecords := DocExists;
                END;
            ELSE
                ERROR(Text000);
        END;

        IF NOT FoundRecords THEN BEGIN
            SetSource(0D, '', '', 0, '');
            MESSAGE(Text001);
        END;
    end;

    local procedure FindRecords()
    begin
        Window.OPEN(Text002);
        Rec.RESET;
        Rec.DELETEALL;
        Rec."Entry No." := 0;
        FindIncomingDocumentRecords;
        CheckReadPermissionToInsertDocEntry;

        DocExists := Rec.FINDFIRST;

        SetSource(0D, '', '', 0, '');
        IF DocExists THEN BEGIN
            IF (NoOfRecords(DATABASE::"Cust. Ledger Entry") + NoOfRecords(DATABASE::"Vendor Ledger Entry") <= 1) AND
               (NoOfRecords(DATABASE::"Sales Invoice Header") + NoOfRecords(DATABASE::"Sales Cr.Memo Header") +
                NoOfRecords(DATABASE::"Sales Shipment Header") + NoOfRecords(DATABASE::"Issued Reminder Header") +
                NoOfRecords(DATABASE::"Issued Fin. Charge Memo Header") + NoOfRecords(DATABASE::"Purch. Inv. Header") +
                NoOfRecords(DATABASE::"Return Shipment Header") + NoOfRecords(DATABASE::"Return Receipt Header") +
                NoOfRecords(DATABASE::"Purch. Cr. Memo Hdr.") + NoOfRecords(DATABASE::"Purch. Rcpt. Header") +
                NoOfRecords(DATABASE::"Service Invoice Header") + NoOfRecords(DATABASE::"Service Cr.Memo Header") +
                NoOfRecords(DATABASE::"Service Shipment Header") +
                NoOfRecords(DATABASE::"Transfer Shipment Header") + NoOfRecords(DATABASE::"Transfer Receipt Header") +
                NoOfRecords(DATABASE::"Service Transfer Shpt. Header") +
                NoOfRecords(DATABASE::"Service Transfer Rcpt. Header") <= 1)
            THEN BEGIN
                // Service Management
                IF NoOfRecords(DATABASE::"Service Ledger Entry") = 1 THEN BEGIN
                    ServLedgerEntry.FINDFIRST;
                    IF ServLedgerEntry.Type = ServLedgerEntry.Type::"Service Contract" THEN
                        SetSource(
                          ServLedgerEntry."Posting Date", FORMAT(ServLedgerEntry."Document Type"), ServLedgerEntry."Document No.",
                          2, ServLedgerEntry."Service Contract No.")
                    ELSE
                        SetSource(
                          ServLedgerEntry."Posting Date", FORMAT(ServLedgerEntry."Document Type"), ServLedgerEntry."Document No.",
                          2, ServLedgerEntry."Service Order No.")
                END;
                IF NoOfRecords(DATABASE::"Warranty Ledger Entry") = 1 THEN BEGIN
                    WarrantyLedgerEntry.FINDFIRST;
                    SetSource(
                      WarrantyLedgerEntry."Posting Date", '', WarrantyLedgerEntry."Document No.",
                      2, WarrantyLedgerEntry."Service Order No.")
                END;

                // Sales
                IF NoOfRecords(DATABASE::"Cust. Ledger Entry") = 1 THEN BEGIN
                    CustLedgEntry.FINDFIRST;
                    SetSource(
                      CustLedgEntry."Posting Date", FORMAT(CustLedgEntry."Document Type"), CustLedgEntry."Document No.",
                      1, CustLedgEntry."Customer No.");
                END;
                IF NoOfRecords(DATABASE::"Detailed Cust. Ledg. Entry") = 1 THEN BEGIN
                    DtldCustLedgEntry.FINDFIRST;
                    SetSource(
                      DtldCustLedgEntry."Posting Date", FORMAT(DtldCustLedgEntry."Document Type"), DtldCustLedgEntry."Document No.",
                      1, DtldCustLedgEntry."Customer No.");
                END;
                IF NoOfRecords(DATABASE::"Sales Invoice Header") = 1 THEN BEGIN
                    SalesInvHeader.FINDFIRST;
                    SetSource(
                      SalesInvHeader."Posting Date", FORMAT(Rec."Table Name"), SalesInvHeader."No.",
                      1, SalesInvHeader."Bill-to Customer No.");
                END;
                IF NoOfRecords(DATABASE::"Sales Cr.Memo Header") = 1 THEN BEGIN
                    SalesCrMemoHeader.FINDFIRST;
                    SetSource(
                      SalesCrMemoHeader."Posting Date", FORMAT(Rec."Table Name"), SalesCrMemoHeader."No.",
                      1, SalesCrMemoHeader."Bill-to Customer No.");
                END;
                IF NoOfRecords(DATABASE::"Return Receipt Header") = 1 THEN BEGIN
                    ReturnRcptHeader.FINDFIRST;
                    SetSource(
                      ReturnRcptHeader."Posting Date", FORMAT(Rec."Table Name"), ReturnRcptHeader."No.",
                      1, ReturnRcptHeader."Sell-to Customer No.");
                END;
                IF NoOfRecords(DATABASE::"Sales Shipment Header") = 1 THEN BEGIN
                    SalesShptHeader.FINDFIRST;
                    SetSource(
                      SalesShptHeader."Posting Date", FORMAT(Rec."Table Name"), SalesShptHeader."No.",
                      1, SalesShptHeader."Sell-to Customer No.");
                END;
                IF NoOfRecords(DATABASE::"Posted Whse. Shipment Line") = 1 THEN BEGIN
                    PostedWhseShptLine.FINDFIRST;
                    SetSource(
                      PostedWhseShptLine."Posting Date", FORMAT(Rec."Table Name"), PostedWhseShptLine."No.",
                      1, PostedWhseShptLine."Destination No.");
                END;
                IF NoOfRecords(DATABASE::"Issued Reminder Header") = 1 THEN BEGIN
                    IssuedReminderHeader.FINDFIRST;
                    SetSource(
                      IssuedReminderHeader."Posting Date", FORMAT(Rec."Table Name"), IssuedReminderHeader."No.",
                      1, IssuedReminderHeader."Customer No.");
                END;
                IF NoOfRecords(DATABASE::"Issued Fin. Charge Memo Header") = 1 THEN BEGIN
                    IssuedFinChrgMemoHeader.FINDFIRST;
                    SetSource(
                      IssuedFinChrgMemoHeader."Posting Date", FORMAT(Rec."Table Name"), IssuedFinChrgMemoHeader."No.",
                      1, IssuedFinChrgMemoHeader."Customer No.");
                END;

                IF NoOfRecords(DATABASE::"Service Invoice Header") = 1 THEN BEGIN
                    ServInvHeader.FINDFIRST;
                    SetSource(
                      ServInvHeader."Posting Date", FORMAT(Rec."Table Name"), ServInvHeader."No.",
                      1, ServInvHeader."Bill-to Customer No.");
                END;
                IF NoOfRecords(DATABASE::"Service Cr.Memo Header") = 1 THEN BEGIN
                    ServCrMemoHeader.FINDFIRST;
                    SetSource(
                      ServCrMemoHeader."Posting Date", FORMAT(Rec."Table Name"), ServCrMemoHeader."No.",
                      1, ServCrMemoHeader."Bill-to Customer No.");
                END;
                IF NoOfRecords(DATABASE::"Service Shipment Header") = 1 THEN BEGIN
                    ServShptHeader.FINDFIRST;
                    SetSource(
                      ServShptHeader."Posting Date", FORMAT(Rec."Table Name"), ServShptHeader."No.",
                      1, ServShptHeader."Customer No.");
                END;

                // Purchase
                IF NoOfRecords(DATABASE::"Vendor Ledger Entry") = 1 THEN BEGIN
                    VendLedgEntry.FINDFIRST;
                    SetSource(
                      VendLedgEntry."Posting Date", FORMAT(VendLedgEntry."Document Type"), VendLedgEntry."Document No.",
                      2, VendLedgEntry."Vendor No.");
                END;
                IF NoOfRecords(DATABASE::"Detailed Vendor Ledg. Entry") = 1 THEN BEGIN
                    DtldVendLedgEntry.FINDFIRST;
                    SetSource(
                      DtldVendLedgEntry."Posting Date", FORMAT(DtldVendLedgEntry."Document Type"), DtldVendLedgEntry."Document No.",
                      2, DtldVendLedgEntry."Vendor No.");
                END;
                IF NoOfRecords(DATABASE::"Purch. Inv. Header") = 1 THEN BEGIN
                    PurchInvHeader.FINDFIRST;
                    SetSource(
                      PurchInvHeader."Posting Date", FORMAT(Rec."Table Name"), PurchInvHeader."No.",
                      2, PurchInvHeader."Pay-to Vendor No.");
                END;
                IF NoOfRecords(DATABASE::"Purch. Cr. Memo Hdr.") = 1 THEN BEGIN
                    PurchCrMemoHeader.FINDFIRST;
                    SetSource(
                      PurchCrMemoHeader."Posting Date", FORMAT(Rec."Table Name"), PurchCrMemoHeader."No.",
                      2, PurchCrMemoHeader."Pay-to Vendor No.");
                END;
                IF NoOfRecords(DATABASE::"Return Shipment Header") = 1 THEN BEGIN
                    ReturnShptHeader.FINDFIRST;
                    SetSource(
                      ReturnShptHeader."Posting Date", FORMAT(Rec."Table Name"), ReturnShptHeader."No.",
                      2, ReturnShptHeader."Buy-from Vendor No.");
                END;
                IF NoOfRecords(DATABASE::"Purch. Rcpt. Header") = 1 THEN BEGIN
                    PurchRcptHeader.FINDFIRST;
                    SetSource(
                      PurchRcptHeader."Posting Date", FORMAT(Rec."Table Name"), PurchRcptHeader."No.",
                      2, PurchRcptHeader."Buy-from Vendor No.");
                END;
                IF NoOfRecords(DATABASE::"Posted Whse. Receipt Line") = 1 THEN BEGIN
                    PostedWhseRcptLine.FINDFIRST;
                    SetSource(
                      PostedWhseRcptLine."Posting Date", FORMAT(Rec."Table Name"), PostedWhseRcptLine."No.",
                      2, '');
                END;
            END ELSE BEGIN
                IF DocNoFilter <> '' THEN
                    IF PostingDateFilter = '' THEN
                        MESSAGE(Text011)
                    ELSE
                        MESSAGE(Text012);
            END;
        END ELSE
            IF PostingDateFilter = '' THEN
                MESSAGE(Text013)
            ELSE
                MESSAGE(Text014);

        IF UpdateForm THEN
            UpdateFormAfterFindRecords;
        Window.CLOSE;
    end;

    local procedure FindJobRecords()
    begin
        IF JobLedgEntry.READPERMISSION THEN BEGIN
            JobLedgEntry.RESET;
            JobLedgEntry.SETCURRENTKEY("Document No.", "Posting Date");
            JobLedgEntry.SETFILTER("Document No.", DocNoFilter);
            JobLedgEntry.SETFILTER("Posting Date", PostingDateFilter);
            InsertIntoDocEntry(
              DATABASE::"Job Ledger Entry", 0, JobLedgEntry.TABLECAPTION, JobLedgEntry.COUNT);
        END;
        IF JobWIPEntry.READPERMISSION THEN BEGIN
            JobWIPEntry.RESET;
            JobWIPEntry.SETFILTER("Document No.", DocNoFilter);
            JobWIPEntry.SETFILTER("WIP Posting Date", PostingDateFilter);
            InsertIntoDocEntry(
              DATABASE::"Job WIP Entry", 0, JobWIPEntry.TABLECAPTION, JobWIPEntry.COUNT);
        END;
        IF JobWIPGLEntry.READPERMISSION THEN BEGIN
            JobWIPGLEntry.RESET;
            JobWIPGLEntry.SETCURRENTKEY("Document No.", "Posting Date");
            JobWIPGLEntry.SETFILTER("Document No.", DocNoFilter);
            JobWIPGLEntry.SETFILTER("Posting Date", PostingDateFilter);
            InsertIntoDocEntry(
              DATABASE::"Job WIP G/L Entry", 0, JobWIPGLEntry.TABLECAPTION, JobWIPGLEntry.COUNT);
        END;
    end;

    local procedure FindIncomingDocumentRecords()
    begin
        IF IncomingDocument.READPERMISSION THEN BEGIN
            IncomingDocument.RESET;
            IncomingDocument.SETFILTER("Document No.", DocNoFilter);
            IncomingDocument.SETFILTER("Posting Date", PostingDateFilter);
            InsertIntoDocEntry(
              DATABASE::"Incoming Document", 0, IncomingDocument.TABLECAPTION, IncomingDocument.COUNT);
        END;
    end;

    local procedure UpdateFormAfterFindRecords()
    begin
        ShowEnable := DocExists;
        PrintEnable := DocExists;
        CurrPage.UPDATE(FALSE);
        DocExists := Rec.FINDFIRST;
        IF DocExists THEN;
    end;

    local procedure InsertIntoDocEntry(DocTableID: Integer; DocType: Option; DocTableName: Text[1024]; DocNoOfRecords: Integer)
    begin
        IF DocNoOfRecords = 0 THEN
            EXIT;
        Rec.INIT;
        Rec."Entry No." := Rec."Entry No." + 1;
        Rec."Table ID" := DocTableID;
        Rec."Document Type" := DocType;
        Rec."Table Name" := COPYSTR(DocTableName, 1, MAXSTRLEN(Rec."Table Name"));
        Rec."No. of Records" := DocNoOfRecords;
        Rec.INSERT;
    end;

    local procedure NoOfRecords(TableID: Integer): Integer
    begin
        Rec.SETRANGE("Table ID", TableID);
        IF NOT Rec.FINDFIRST THEN
            Rec.INIT;
        Rec.SETRANGE("Table ID");
        EXIT(Rec."No. of Records");
    end;

    local procedure SetSource(PostingDate: Date; DocType2: Text[50]; DocNo: Text[50]; SourceType2: Integer; SourceNo2: Code[20])
    begin
        IF SourceType2 = 0 THEN BEGIN
            DocType := '';
            SourceType := '';
            SourceNo := '';
            SourceName := '';
        END ELSE BEGIN
            DocType := DocType2;
            SourceNo := SourceNo2;
            Rec.SETRANGE("Document No.", DocNo);
            Rec.SETRANGE("Posting Date", PostingDate);
            DocNoFilter := Rec.GETFILTER("Document No.");
            PostingDateFilter := Rec.GETFILTER("Posting Date");
            CASE SourceType2 OF
                1:
                    BEGIN
                        SourceType := Cust.TABLECAPTION;
                        IF NOT Cust.GET(SourceNo) THEN
                            Cust.INIT;
                        SourceName := Cust.Name;
                    END;
                2:
                    BEGIN
                        SourceType := Vend.TABLECAPTION;
                        IF NOT Vend.GET(SourceNo) THEN
                            Vend.INIT;
                        SourceName := Vend.Name;
                    END;
            END;
        END;
        DocTypeEnable := SourceType2 <> 0;
        SourceTypeEnable := SourceType2 <> 0;
        SourceNoEnable := SourceType2 <> 0;
        SourceNameEnable := SourceType2 <> 0;
    end;

    local procedure ShowRecords()
    begin
        IF ItemTrackingSearch THEN
            ItemTrackingNavigateMgt.Show(Rec."Table ID")
        ELSE
            CASE Rec."Table ID" OF
                DATABASE::"Incoming Document":
                    PAGE.RUN(PAGE::"Incoming Document", IncomingDocument);
                DATABASE::"Sales Header":
                    ShowSalesHeaderRecords;
                DATABASE::"Sales Invoice Header":
                    IF Rec."No. of Records" = 1 THEN
                        PAGE.RUN(GetPageId(PAGE::"Posted Sales Invoice"), SalesInvHeader)
                    ELSE
                        PAGE.RUN(GetPageId(PAGE::"Posted Sales Invoices"), SalesInvHeader);
                DATABASE::"Sales Cr.Memo Header":
                    IF rec."No. of Records" = 1 THEN
                        PAGE.RUN(GetPageId(PAGE::"Posted Sales Credit Memo"), SalesCrMemoHeader)
                    ELSE
                        PAGE.RUN(GetPageId(PAGE::"Posted Sales Credit Memos"), SalesCrMemoHeader);
                DATABASE::"Return Receipt Header":
                    IF rec."No. of Records" = 1 THEN
                        PAGE.RUN(PAGE::"Posted Return Receipt", ReturnRcptHeader)
                    ELSE
                        PAGE.RUN(0, ReturnRcptHeader);
                DATABASE::"Sales Shipment Header":
                    IF rec."No. of Records" = 1 THEN
                        PAGE.RUN(PAGE::"Posted Sales Shipment", SalesShptHeader)
                    ELSE
                        PAGE.RUN(0, SalesShptHeader);
                DATABASE::"Issued Reminder Header":
                    IF rec."No. of Records" = 1 THEN
                        PAGE.RUN(PAGE::"Issued Reminder", IssuedReminderHeader)
                    ELSE
                        PAGE.RUN(0, IssuedReminderHeader);
                DATABASE::"Issued Fin. Charge Memo Header":
                    IF rec."No. of Records" = 1 THEN
                        PAGE.RUN(PAGE::"Issued Finance Charge Memo", IssuedFinChrgMemoHeader)
                    ELSE
                        PAGE.RUN(0, IssuedFinChrgMemoHeader);
                DATABASE::"Purch. Inv. Header":
                    IF rec."No. of Records" = 1 THEN
                        PAGE.RUN(GetPageId(PAGE::"Posted Purchase Invoice"), PurchInvHeader)
                    ELSE
                        PAGE.RUN(GetPageId(PAGE::"Posted Purchase Invoices"), PurchInvHeader);
                DATABASE::"Purch. Cr. Memo Hdr.":
                    IF rec."No. of Records" = 1 THEN
                        PAGE.RUN(GetPageId(PAGE::"Posted Purchase Credit Memo"), PurchCrMemoHeader)
                    ELSE
                        PAGE.RUN(GetPageId(PAGE::"Posted Purchase Credit Memos"), PurchCrMemoHeader);
                DATABASE::"Return Shipment Header":
                    IF rec."No. of Records" = 1 THEN
                        PAGE.RUN(PAGE::"Posted Return Shipment", ReturnShptHeader)
                    ELSE
                        PAGE.RUN(0, ReturnShptHeader);
                DATABASE::"Purch. Rcpt. Header":
                    IF rec."No. of Records" = 1 THEN
                        PAGE.RUN(PAGE::"Posted Purchase Receipt", PurchRcptHeader)
                    ELSE
                        PAGE.RUN(0, PurchRcptHeader);
                DATABASE::"Production Order":
                    PAGE.RUN(0, ProductionOrderHeader);
                DATABASE::"Posted Assembly Header":
                    IF rec."No. of Records" = 1 THEN
                        PAGE.RUN(PAGE::"Posted Assembly Order", PostedAssemblyHeader)
                    ELSE
                        PAGE.RUN(0, PostedAssemblyHeader);
                DATABASE::"Transfer Shipment Header":
                    IF rec."No. of Records" = 1 THEN
                        PAGE.RUN(PAGE::"Posted Transfer Shipment", TransShptHeader)
                    ELSE
                        PAGE.RUN(0, TransShptHeader);
                DATABASE::"Transfer Receipt Header":
                    IF rec."No. of Records" = 1 THEN
                        PAGE.RUN(PAGE::"Posted Transfer Receipt", TransRcptHeader)
                    ELSE
                        PAGE.RUN(0, TransRcptHeader);
                DATABASE::"Posted Whse. Shipment Line":
                    PAGE.RUN(0, PostedWhseShptLine);
                DATABASE::"Posted Whse. Receipt Line":
                    PAGE.RUN(0, PostedWhseRcptLine);
                DATABASE::"G/L Entry":
                    PAGE.RUN(0, GLEntry);
                DATABASE::"VAT Entry":
                    PAGE.RUN(0, VATEntry);


                DATABASE::"TDS Entry":
                    PAGE.RUN(0, TDSEntry);


                DATABASE::"TCS Entry":
                    PAGE.RUN(0, TCSEntry);

                DATABASE::"Detailed Cust. Ledg. Entry":
                    PAGE.RUN(0, DtldCustLedgEntry);
                DATABASE::"Cust. Ledger Entry":
                    PAGE.RUN(0, CustLedgEntry);
                DATABASE::"Reminder/Fin. Charge Entry":
                    PAGE.RUN(0, ReminderEntry);
                DATABASE::"Vendor Ledger Entry":
                    PAGE.RUN(0, VendLedgEntry);
                DATABASE::"Detailed Vendor Ledg. Entry":
                    PAGE.RUN(0, DtldVendLedgEntry);
                DATABASE::"Item Ledger Entry":
                    PAGE.RUN(0, ItemLedgEntry);
                DATABASE::"Value Entry":
                    PAGE.RUN(0, ValueEntry);
                DATABASE::"Phys. Inventory Ledger Entry":
                    PAGE.RUN(0, PhysInvtLedgEntry);
                DATABASE::"Res. Ledger Entry":
                    PAGE.RUN(0, ResLedgEntry);
                DATABASE::"Job Ledger Entry":
                    PAGE.RUN(0, JobLedgEntry);
                DATABASE::"Job WIP Entry":
                    PAGE.RUN(0, JobWIPEntry);
                DATABASE::"Job WIP G/L Entry":
                    PAGE.RUN(0, JobWIPGLEntry);
                DATABASE::"Bank Account Ledger Entry":
                    PAGE.RUN(0, BankAccLedgEntry);
                DATABASE::"Check Ledger Entry":
                    PAGE.RUN(0, CheckLedgEntry);
                DATABASE::"FA Ledger Entry":
                    PAGE.RUN(0, FALedgEntry);
                DATABASE::"Maintenance Ledger Entry":
                    PAGE.RUN(0, MaintenanceLedgEntry);
                DATABASE::"Ins. Coverage Ledger Entry":
                    PAGE.RUN(0, InsuranceCovLedgEntry);
                DATABASE::"Capacity Ledger Entry":
                    PAGE.RUN(0, CapacityLedgEntry);
                DATABASE::"Warehouse Entry":
                    PAGE.RUN(0, WhseEntry);
                DATABASE::"Service Header":
                    ShowServiceHeaderRecords;
                DATABASE::"Service Invoice Header":
                    IF rec."No. of Records" = 1 THEN
                        PAGE.RUN(PAGE::"Posted Service Invoice", ServInvHeader)
                    ELSE
                        PAGE.RUN(0, ServInvHeader);
                DATABASE::"Service Cr.Memo Header":
                    IF rec."No. of Records" = 1 THEN
                        PAGE.RUN(PAGE::"Posted Service Credit Memo", ServCrMemoHeader)
                    ELSE
                        PAGE.RUN(0, ServCrMemoHeader);
                DATABASE::"Service Shipment Header":
                    IF rec."No. of Records" = 1 THEN
                        PAGE.RUN(PAGE::"Posted Service Shipment", ServShptHeader)
                    ELSE
                        PAGE.RUN(0, ServShptHeader);
                DATABASE::"Service Ledger Entry":
                    PAGE.RUN(0, ServLedgerEntry);
                DATABASE::"Cost Entry":
                    PAGE.RUN(0, CostEntry);
                DATABASE::"Warranty Ledger Entry":
                    PAGE.RUN(0, WarrantyLedgerEntry);
                DATABASE::"GST Ledger Entry":
                    PAGE.RUN(0, GSTLedgerEntry);
                DATABASE::"Detailed GST Ledger Entry":
                    PAGE.RUN(0, DetailedGSTLedgerEntry);
                DATABASE::"GST TDS/TCS Entry":
                    PAGE.RUN(0, GSTTdsTcsEntry);
                DATABASE::"Provisional Entry":
                    PAGE.RUN(0, ProvisionalEntry);
                DATABASE::"Service Transfer Shpt. Header":
                    IF rec."No. of Records" = 1 THEN
                        PAGE.RUN(PAGE::"Posted Serv. Transfer Shipment", ServiceTransferShptHeader)
                    ELSE
                        PAGE.RUN(0, ServiceTransferShptHeader);
                DATABASE::"Service Transfer Rcpt. Header":
                    IF rec."No. of Records" = 1 THEN
                        PAGE.RUN(PAGE::"Posted Serv. Transfer Reciept", ServiceTransferRcptHeader)
                    ELSE
                        PAGE.RUN(0, ServiceTransferRcptHeader);
                DATABASE::"Detailed Cr. Adjstmnt. Entry":
                    PAGE.RUN(0, DetailedCrAdjstmntEntry);
                DATABASE::"Posted GST Distribution Header":
                    BEGIN
                        IF rec."Document Type" = rec."Document Type"::Invoice THEN
                            PAGE.RUN(PAGE::"Posted GST Dist.- Invoice", PostedGSTDistributionHeader);
                        IF rec."Document Type" = rec."Document Type"::"Credit Memo" THEN
                            PAGE.RUN(PAGE::"Posted GST Dist.- Cr. Memo", PostedGSTDistributionHeader);
                    END;
                DATABASE::"Detailed GST Dist. Entry":
                    PAGE.RUN(PAGE::"Detailed GST Dist. Entries", DetailedGSTDistEntry);
                DATABASE::"Posted Jnl. Bank Charges":
                    PAGE.RUN(PAGE::"Posted Journal Bank Charges", PostedJnlBankCharges);
                DATABASE::"Posted GST Liability Adj.":
                    PAGE.RUN(PAGE::"Posted GST Liability Adj.", PostedGSTLiabilityAdj);
            END;
    end;

    local procedure ShowSalesHeaderRecords()
    begin
        rec.TESTFIELD("Table ID", DATABASE::"Sales Header");

        CASE Rec."Document Type" OF
            Rec."Document Type"::Order:
                IF Rec."No. of Records" = 1 THEN
                    PAGE.RUN(PAGE::"Sales Order", SOSalesHeader)
                ELSE
                    PAGE.RUN(0, SOSalesHeader);
            Rec."Document Type"::Invoice:
                IF Rec."No. of Records" = 1 THEN
                    PAGE.RUN(GetPageId(PAGE::"Sales Invoice"), SISalesHeader)
                ELSE
                    PAGE.RUN(0, SISalesHeader);
            Rec."Document Type"::"Return Order":
                IF Rec."No. of Records" = 1 THEN
                    PAGE.RUN(PAGE::"Sales Return Order", SROSalesHeader)
                ELSE
                    PAGE.RUN(0, SROSalesHeader);
            Rec."Document Type"::"Credit Memo":
                IF Rec."No. of Records" = 1 THEN
                    PAGE.RUN(GetPageId(PAGE::"Sales Credit Memo"), SCMSalesHeader)
                ELSE
                    PAGE.RUN(0, SCMSalesHeader);
        END;
    end;

    local procedure ShowServiceHeaderRecords()
    begin
        Rec.TESTFIELD("Table ID", DATABASE::"Service Header");

        CASE Rec."Document Type" OF
            Rec."Document Type"::Order:
                IF Rec."No. of Records" = 1 THEN
                    PAGE.RUN(PAGE::"Service Order", SOServHeader)
                ELSE
                    PAGE.RUN(0, SOServHeader);
            Rec."Document Type"::Invoice:
                IF Rec."No. of Records" = 1 THEN
                    PAGE.RUN(PAGE::"Service Invoice", SIServHeader)
                ELSE
                    PAGE.RUN(0, SIServHeader);
            Rec."Document Type"::"Credit Memo":
                IF Rec."No. of Records" = 1 THEN
                    PAGE.RUN(PAGE::"Service Credit Memo", SCMServHeader)
                ELSE
                    PAGE.RUN(0, SCMServHeader);
        END;
    end;

    local procedure SetPostingDate(PostingDate: Text[250])
    var

    begin
        // IF ApplicationManagement.MakeDateFilter(PostingDate) = 0 THEN;
        SETFILTER("Posting Date", PostingDate);
        PostingDateFilter := Rec.GETFILTER("Posting Date");
    end;

    local procedure SetDocNo(DocNo: Text[250])
    begin
        Rec.SETFILTER("Document No.", DocNo);
        DocNoFilter := Rec.GETFILTER("Document No.");
        PostingDateFilter := Rec.GETFILTER("Posting Date");
    end;

    local procedure ClearSourceInfo()
    begin
        IF DocExists THEN BEGIN
            DocExists := FALSE;
            Rec.DELETEALL;
            ShowEnable := FALSE;
            SetSource(0D, '', '', 0, '');
            CurrPage.UPDATE(FALSE);
        END;
    end;

    local procedure MakeExtFilter(var DateFilter: Code[250]; AddDate: Date; var DocNoFilter: Code[250]; AddDocNo: Code[20])
    begin
        IF DateFilter = '' THEN
            DateFilter := FORMAT(AddDate)
        ELSE
            IF STRPOS(DateFilter, FORMAT(AddDate)) = 0 THEN
                IF MAXSTRLEN(DateFilter) >= STRLEN(DateFilter + '|' + FORMAT(AddDate)) THEN
                    DateFilter := DateFilter + '|' + FORMAT(AddDate)
                ELSE
                    TooLongFilter;

        IF DocNoFilter = '' THEN
            DocNoFilter := AddDocNo
        ELSE
            IF STRPOS(DocNoFilter, AddDocNo) = 0 THEN
                IF MAXSTRLEN(DocNoFilter) >= STRLEN(DocNoFilter + '|' + AddDocNo) THEN
                    DocNoFilter := DocNoFilter + '|' + AddDocNo
                ELSE
                    TooLongFilter;
    end;

    local procedure FindPush()
    begin
        IF (DocNoFilter = '') AND (PostingDateFilter = '') AND
           (NOT ItemTrackingSearch) AND
           ((ContactType <> 0) OR (ContactNo <> '') OR (ExtDocNo <> ''))
        THEN
            FindExtRecords
        ELSE
            IF ItemTrackingSearch AND
               (DocNoFilter = '') AND (PostingDateFilter = '') AND
               (ContactType = 0) AND (ContactNo = '') AND (ExtDocNo = '')
            THEN
                FindTrackingRecords
            ELSE
                FindRecords;
    end;

    local procedure TooLongFilter()
    begin
        IF ContactNo = '' THEN
            ERROR(Text015);

        ERROR(Text016);
    end;

    local procedure FindUnpostedSalesDocs(DocType: Option; DocTableName: Text[100]; var SalesHeader: Record 36)
    begin
        SalesHeader."SECURITYFILTERING"(SECURITYFILTER::Filtered);
        IF SalesHeader.READPERMISSION THEN BEGIN
            SalesHeader.RESET;
            SalesHeader.SETCURRENTKEY("Sell-to Customer No.", "External Document No.");
            SalesHeader.SETFILTER("Sell-to Customer No.", ContactNo);
            SalesHeader.SETFILTER("External Document No.", ExtDocNo);
            SalesHeader.SETRANGE("Document Type", DocType);
            InsertIntoDocEntry(DATABASE::"Sales Header", DocType, DocTableName, SalesHeader.COUNT);
        END;
    end;

    local procedure FindUnpostedServDocs(DocType: Option; DocTableName: Text[100]; var ServHeader: Record 5900)
    begin
        ServHeader."SECURITYFILTERING"(SECURITYFILTER::Filtered);
        IF ServHeader.READPERMISSION THEN BEGIN
            IF ExtDocNo = '' THEN BEGIN
                ServHeader.RESET;
                ServHeader.SETCURRENTKEY("Customer No.");
                ServHeader.SETFILTER("Customer No.", ContactNo);
                ServHeader.SETRANGE("Document Type", DocType);
                InsertIntoDocEntry(DATABASE::"Service Header", DocType, DocTableName, ServHeader.COUNT);
            END;
        END;
    end;

    local procedure FindTrackingRecords()
    var
        DocNoOfRecords: Integer;
    begin
        Window.OPEN(Text002);
        Rec.DELETEALL;
        Rec."Entry No." := 0;

        CLEAR(ItemTrackingNavigateMgt);
        ItemTrackingNavigateMgt.FindTrackingRecords(SerialNoFilter, LotNoFilter, '', '');

        ItemTrackingNavigateMgt.Collect(TempRecordBuffer);
        TempRecordBuffer.SETCURRENTKEY("Table No.", "Search Record ID");
        IF TempRecordBuffer.FIND('-') THEN
            REPEAT
                TempRecordBuffer.SETRANGE("Table No.", TempRecordBuffer."Table No.");

                DocNoOfRecords := 0;
                IF TempRecordBuffer.FIND('-') THEN
                    REPEAT
                        TempRecordBuffer.SETRANGE("Search Record ID", TempRecordBuffer."Search Record ID");
                        TempRecordBuffer.FIND('+');
                        TempRecordBuffer.SETRANGE("Search Record ID");
                        DocNoOfRecords += 1;
                    UNTIL TempRecordBuffer.NEXT = 0;

                InsertIntoDocEntry(
                  TempRecordBuffer."Table No.", 0, TempRecordBuffer."Table Name", DocNoOfRecords);

                TempRecordBuffer.SETRANGE("Table No.");
            UNTIL TempRecordBuffer.NEXT = 0;

        DocExists := Rec.FIND('-');

        UpdateFormAfterFindRecords;
        Window.CLOSE;
    end;


    procedure SetTracking(SerialNo: Code[20]; LotNo: Code[20])
    begin
        NewSerialNo := SerialNo;
        NewLotNo := LotNo;
    end;

    local procedure ItemTrackingSearch(): Boolean
    begin
        EXIT((SerialNoFilter <> '') OR (LotNoFilter <> ''));
    end;

    local procedure ClearTrackingInfo()
    begin
        SerialNoFilter := '';
        LotNoFilter := '';
    end;

    local procedure ClearInfo()
    begin
        SetDocNo('');
        SetPostingDate('');
        ContactType := ContactType::" ";
        ContactNo := '';
        ExtDocNo := '';
    end;

    local procedure DocNoFilterOnAfterValidate()
    begin
        ClearSourceInfo;
    end;

    local procedure PostingDateFilterOnAfterValida()
    begin
        ClearSourceInfo;
    end;

    local procedure ExtDocNoOnAfterValidate()
    begin
        ClearSourceInfo;
    end;

    local procedure ContactTypeOnAfterValidate()
    begin
        ClearSourceInfo;
    end;

    local procedure ContactNoOnAfterValidate()
    begin
        ClearSourceInfo;
    end;

    local procedure SerialNoFilterOnAfterValidate()
    begin
        ClearSourceInfo;
    end;

    local procedure LotNoFilterOnAfterValidate()
    begin
        ClearSourceInfo;
    end;


    procedure FindRecordsOnOpen()
    begin
        IF (NewDocNo = '') AND (NewPostingDate = 0D) AND (NewSerialNo = '') AND (NewLotNo = '') THEN BEGIN
            Rec.DELETEALL;
            ShowEnable := FALSE;
            PrintEnable := FALSE;
            SetSource(0D, '', '', 0, '');
        END ELSE
            IF (NewSerialNo <> '') OR (NewLotNo <> '') THEN BEGIN
                SetSource(0D, '', '', 0, '');
                Rec.SETRANGE("Serial No. Filter", NewSerialNo);
                Rec.SETRANGE("Lot No. Filter", NewLotNo);
                SerialNoFilter := Rec.GETFILTER("Serial No. Filter");
                LotNoFilter := Rec.GETFILTER("Lot No. Filter");
                ClearInfo;
                FindTrackingRecords;
            END ELSE BEGIN
                Rec.SETRANGE("Document No.", NewDocNo);
                Rec.SETRANGE("Posting Date", NewPostingDate);
                DocNoFilter := Rec.GETFILTER("Document No.");
                PostingDateFilter := Rec.GETFILTER("Posting Date");
                ContactType := ContactType::" ";
                ContactNo := '';
                ExtDocNo := '';
                ClearTrackingInfo;
                FindRecords;
            END;
    end;


    local procedure UpdateNavigateForm(UpdateFormFrom: Boolean)
    begin
        UpdateForm := UpdateFormFrom;
    end;


    local procedure ReturnDocumentEntry(var TempDocumentEntry: Record 265 temporary)
    begin
        Rec.SETRANGE("Table ID");  // Clear filter.
        Rec.FINDSET;
        REPEAT
            TempDocumentEntry.INIT;
            TempDocumentEntry := Rec;
            TempDocumentEntry.INSERT;
        UNTIL Rec.NEXT = 0;
    end;

    local procedure UpdateFindByGroupsVisibility()
    begin
        DocumentVisible := FALSE;
        BusinessContactVisible := FALSE;
        ItemReferenceVisible := FALSE;

        CASE FindBasedOn OF
            FindBasedOn::Document:
                DocumentVisible := TRUE;
            FindBasedOn::"Business Contact":
                BusinessContactVisible := TRUE;
            FindBasedOn::"Item Reference":
                ItemReferenceVisible := TRUE;
        END;

        CurrPage.UPDATE;
    end;

    local procedure FilterSelectionChanged()
    begin
        FilterSelectionChangedTxtVisible := TRUE;
    end;

    local procedure GetCaptionText(): Text
    begin
        IF Rec."Table Name" <> '' THEN
            EXIT(STRSUBSTNO(PageCaptionTxt, Rec."Table Name"));

        EXIT('');
    end;

    local procedure GetPageId(PageId: Integer): Integer
    var
    // [SecurityFiltering(SecurityFilter::Filtered)]
    // MiniPagesMapping: Record "Mini Pages Mapping";
    begin
        //IF MiniPagesMapping.READPERMISSION THEN
        //  IF MiniPagesMapping.GET(PageId) THEN
        //    EXIT(MiniPagesMapping."Substitute Page ID");

        // EXIT(PageId);
    end;

    local procedure CheckReadPermissionToInsertDocEntry()
    begin
        IF SalesShptHeader.READPERMISSION THEN BEGIN
            SalesShptHeader.RESET;
            SalesShptHeader.SETFILTER("No.", DocNoFilter);
            SalesShptHeader.SETFILTER("Posting Date", PostingDateFilter);
            InsertIntoDocEntry(
              DATABASE::"Sales Shipment Header", 0, Text005, SalesShptHeader.COUNT);
        END;
        IF SalesInvHeader.READPERMISSION THEN BEGIN
            SalesInvHeader.RESET;
            SalesInvHeader.SETFILTER("No.", DocNoFilter);
            SalesInvHeader.SETFILTER("Posting Date", PostingDateFilter);
            InsertIntoDocEntry(
              DATABASE::"Sales Invoice Header", 0, Text003, SalesInvHeader.COUNT);
        END;
        IF ReturnRcptHeader.READPERMISSION THEN BEGIN
            ReturnRcptHeader.RESET;
            ReturnRcptHeader.SETFILTER("No.", DocNoFilter);
            ReturnRcptHeader.SETFILTER("Posting Date", PostingDateFilter);
            InsertIntoDocEntry(
              DATABASE::"Return Receipt Header", 0, Text017, ReturnRcptHeader.COUNT);
        END;
        IF SalesCrMemoHeader.READPERMISSION THEN BEGIN
            SalesCrMemoHeader.RESET;
            SalesCrMemoHeader.SETFILTER("No.", DocNoFilter);
            SalesCrMemoHeader.SETFILTER("Posting Date", PostingDateFilter);
            InsertIntoDocEntry(
              DATABASE::"Sales Cr.Memo Header", 0, Text004, SalesCrMemoHeader.COUNT);
        END;
        IF ServShptHeader.READPERMISSION THEN BEGIN
            ServShptHeader.RESET;
            ServShptHeader.SETFILTER("No.", DocNoFilter);
            ServShptHeader.SETFILTER("Posting Date", PostingDateFilter);
            InsertIntoDocEntry(
              DATABASE::"Service Shipment Header", 0, sText005, ServShptHeader.COUNT);
        END;
        IF ServInvHeader.READPERMISSION THEN BEGIN
            ServInvHeader.RESET;
            ServInvHeader.SETFILTER("No.", DocNoFilter);
            ServInvHeader.SETFILTER("Posting Date", PostingDateFilter);
            InsertIntoDocEntry(
              DATABASE::"Service Invoice Header", 0, sText003, ServInvHeader.COUNT);
        END;
        IF ServCrMemoHeader.READPERMISSION THEN BEGIN
            ServCrMemoHeader.RESET;
            ServCrMemoHeader.SETFILTER("No.", DocNoFilter);
            ServCrMemoHeader.SETFILTER("Posting Date", PostingDateFilter);
            InsertIntoDocEntry(
              DATABASE::"Service Cr.Memo Header", 0, sText004, ServCrMemoHeader.COUNT);
        END;
        IF IssuedReminderHeader.READPERMISSION THEN BEGIN
            IssuedReminderHeader.RESET;
            IssuedReminderHeader.SETFILTER("No.", DocNoFilter);
            IssuedReminderHeader.SETFILTER("Posting Date", PostingDateFilter);
            InsertIntoDocEntry(
              DATABASE::"Issued Reminder Header", 0, Text006, IssuedReminderHeader.COUNT);
        END;
        IF IssuedFinChrgMemoHeader.READPERMISSION THEN BEGIN
            IssuedFinChrgMemoHeader.RESET;
            IssuedFinChrgMemoHeader.SETFILTER("No.", DocNoFilter);
            IssuedFinChrgMemoHeader.SETFILTER("Posting Date", PostingDateFilter);
            InsertIntoDocEntry(
              DATABASE::"Issued Fin. Charge Memo Header", 0, Text007,
              IssuedFinChrgMemoHeader.COUNT);
        END;
        IF PurchRcptHeader.READPERMISSION THEN BEGIN
            PurchRcptHeader.RESET;
            PurchRcptHeader.SETFILTER("No.", DocNoFilter);
            PurchRcptHeader.SETFILTER("Posting Date", PostingDateFilter);
            InsertIntoDocEntry(
              DATABASE::"Purch. Rcpt. Header", 0, Text010, PurchRcptHeader.COUNT);
        END;
        IF PurchInvHeader.READPERMISSION THEN BEGIN
            PurchInvHeader.RESET;
            PurchInvHeader.SETFILTER("No.", DocNoFilter);
            PurchInvHeader.SETFILTER("Posting Date", PostingDateFilter);
            InsertIntoDocEntry(
              DATABASE::"Purch. Inv. Header", 0, Text008, PurchInvHeader.COUNT);
        END;
        IF ReturnShptHeader.READPERMISSION THEN BEGIN
            ReturnShptHeader.RESET;
            ReturnShptHeader.SETFILTER("No.", DocNoFilter);
            ReturnShptHeader.SETFILTER("Posting Date", PostingDateFilter);
            InsertIntoDocEntry(
              DATABASE::"Return Shipment Header", 0, Text018, ReturnShptHeader.COUNT);
        END;
        IF PurchCrMemoHeader.READPERMISSION THEN BEGIN
            PurchCrMemoHeader.RESET;
            PurchCrMemoHeader.SETFILTER("No.", DocNoFilter);
            PurchCrMemoHeader.SETFILTER("Posting Date", PostingDateFilter);
            InsertIntoDocEntry(
              DATABASE::"Purch. Cr. Memo Hdr.", 0, Text009, PurchCrMemoHeader.COUNT);
        END;
        IF ProductionOrderHeader.READPERMISSION THEN BEGIN
            ProductionOrderHeader.RESET;
            ProductionOrderHeader.SETRANGE(
              Status,
              ProductionOrderHeader.Status::Released,
              ProductionOrderHeader.Status::Finished);
            ProductionOrderHeader.SETFILTER("No.", DocNoFilter);
            InsertIntoDocEntry(
              DATABASE::"Production Order", 0, Text99000000, ProductionOrderHeader.COUNT);
        END;
        IF PostedAssemblyHeader.READPERMISSION THEN BEGIN
            PostedAssemblyHeader.RESET;
            PostedAssemblyHeader.SETFILTER("No.", DocNoFilter);
            InsertIntoDocEntry(
              DATABASE::"Posted Assembly Header", 0, Text025, PostedAssemblyHeader.COUNT);
        END;
        IF TransShptHeader.READPERMISSION THEN BEGIN
            TransShptHeader.RESET;
            TransShptHeader.SETFILTER("No.", DocNoFilter);
            TransShptHeader.SETFILTER("Posting Date", PostingDateFilter);
            InsertIntoDocEntry(
              DATABASE::"Transfer Shipment Header", 0, Text019, TransShptHeader.COUNT);
        END;
        IF TransRcptHeader.READPERMISSION THEN BEGIN
            TransRcptHeader.RESET;
            TransRcptHeader.SETFILTER("No.", DocNoFilter);
            TransRcptHeader.SETFILTER("Posting Date", PostingDateFilter);
            InsertIntoDocEntry(
              DATABASE::"Transfer Receipt Header", 0, Text020, TransRcptHeader.COUNT);
        END;
        IF PostedWhseShptLine.READPERMISSION THEN BEGIN
            PostedWhseShptLine.RESET;
            PostedWhseShptLine.SETCURRENTKEY("Posted Source No.", "Posting Date");
            PostedWhseShptLine.SETFILTER("Posted Source No.", DocNoFilter);
            PostedWhseShptLine.SETFILTER("Posting Date", PostingDateFilter);
            InsertIntoDocEntry(
              DATABASE::"Posted Whse. Shipment Line", 0,
              PostedWhseShptLine.TABLECAPTION, PostedWhseShptLine.COUNT);
        END;
        IF PostedWhseRcptLine.READPERMISSION THEN BEGIN
            PostedWhseRcptLine.RESET;
            PostedWhseRcptLine.SETCURRENTKEY("Posted Source No.", "Posting Date");
            PostedWhseRcptLine.SETFILTER("Posted Source No.", DocNoFilter);
            PostedWhseRcptLine.SETFILTER("Posting Date", PostingDateFilter);
            InsertIntoDocEntry(
              DATABASE::"Posted Whse. Receipt Line", 0,
              PostedWhseRcptLine.TABLECAPTION, PostedWhseRcptLine.COUNT);
        END;

        IF GLEntry.READPERMISSION THEN BEGIN
            GLEntry.RESET;
            GLEntry.SETCURRENTKEY("Document No.", "Posting Date");
            GLEntry.SETFILTER("Document No.", DocNoFilter);
            GLEntry.SETFILTER("Posting Date", PostingDateFilter);
            InsertIntoDocEntry(
              DATABASE::"G/L Entry", 0, GLEntry.TABLECAPTION, GLEntry.COUNT);
        END;
        IF VATEntry.READPERMISSION THEN BEGIN
            VATEntry.RESET;
            VATEntry.SETCURRENTKEY("Document No.", "Posting Date");
            VATEntry.SETFILTER("Document No.", DocNoFilter);
            VATEntry.SETFILTER("Posting Date", PostingDateFilter);
            InsertIntoDocEntry(
              DATABASE::"VAT Entry", 0, VATEntry.TABLECAPTION, VATEntry.COUNT);
        END;
        IF CustLedgEntry.READPERMISSION THEN BEGIN
            CustLedgEntry.RESET;
            CustLedgEntry.SETCURRENTKEY("Document No.");
            CustLedgEntry.SETFILTER("Document No.", DocNoFilter);
            CustLedgEntry.SETFILTER("Posting Date", PostingDateFilter);
            InsertIntoDocEntry(
              DATABASE::"Cust. Ledger Entry", 0, CustLedgEntry.TABLECAPTION, CustLedgEntry.COUNT);
        END;
        IF DtldCustLedgEntry.READPERMISSION THEN BEGIN
            DtldCustLedgEntry.RESET;
            DtldCustLedgEntry.SETCURRENTKEY("Document No.");
            DtldCustLedgEntry.SETFILTER("Document No.", DocNoFilter);
            DtldCustLedgEntry.SETFILTER("Posting Date", PostingDateFilter);
            InsertIntoDocEntry(
              DATABASE::"Detailed Cust. Ledg. Entry", 0, DtldCustLedgEntry.TABLECAPTION, DtldCustLedgEntry.COUNT);
        END;
        IF ReminderEntry.READPERMISSION THEN BEGIN
            ReminderEntry.RESET;
            ReminderEntry.SETCURRENTKEY(Type, "No.");
            ReminderEntry.SETFILTER("No.", DocNoFilter);
            ReminderEntry.SETFILTER("Posting Date", PostingDateFilter);
            InsertIntoDocEntry(
              DATABASE::"Reminder/Fin. Charge Entry", 0, ReminderEntry.TABLECAPTION, ReminderEntry.COUNT);
        END;
        IF VendLedgEntry.READPERMISSION THEN BEGIN
            VendLedgEntry.RESET;
            VendLedgEntry.SETCURRENTKEY("Document No.");
            VendLedgEntry.SETFILTER("Document No.", DocNoFilter);
            VendLedgEntry.SETFILTER("Posting Date", PostingDateFilter);
            InsertIntoDocEntry(
              DATABASE::"Vendor Ledger Entry", 0, VendLedgEntry.TABLECAPTION, VendLedgEntry.COUNT);
        END;
        IF DtldVendLedgEntry.READPERMISSION THEN BEGIN
            DtldVendLedgEntry.RESET;
            DtldVendLedgEntry.SETCURRENTKEY("Document No.");
            DtldVendLedgEntry.SETFILTER("Document No.", DocNoFilter);
            DtldVendLedgEntry.SETFILTER("Posting Date", PostingDateFilter);
            InsertIntoDocEntry(
              DATABASE::"Detailed Vendor Ledg. Entry", 0, DtldVendLedgEntry.TABLECAPTION, DtldVendLedgEntry.COUNT);
        END;
        IF ItemLedgEntry.READPERMISSION THEN BEGIN
            ItemLedgEntry.RESET;
            ItemLedgEntry.SETCURRENTKEY("Document No.");
            ItemLedgEntry.SETFILTER("Document No.", DocNoFilter);
            ItemLedgEntry.SETFILTER("Posting Date", PostingDateFilter);
            InsertIntoDocEntry(
              DATABASE::"Item Ledger Entry", 0, ItemLedgEntry.TABLECAPTION, ItemLedgEntry.COUNT);
        END;
        IF ValueEntry.READPERMISSION THEN BEGIN
            ValueEntry.RESET;
            ValueEntry.SETCURRENTKEY("Document No.");
            ValueEntry.SETFILTER("Document No.", DocNoFilter);
            ValueEntry.SETFILTER("Posting Date", PostingDateFilter);
            InsertIntoDocEntry(
              DATABASE::"Value Entry", 0, ValueEntry.TABLECAPTION, ValueEntry.COUNT);
        END;
        IF PhysInvtLedgEntry.READPERMISSION THEN BEGIN
            PhysInvtLedgEntry.RESET;
            PhysInvtLedgEntry.SETCURRENTKEY("Document No.", "Posting Date");
            PhysInvtLedgEntry.SETFILTER("Document No.", DocNoFilter);
            PhysInvtLedgEntry.SETFILTER("Posting Date", PostingDateFilter);
            InsertIntoDocEntry(
              DATABASE::"Phys. Inventory Ledger Entry", 0, PhysInvtLedgEntry.TABLECAPTION, PhysInvtLedgEntry.COUNT);
        END;
        IF ResLedgEntry.READPERMISSION THEN BEGIN
            ResLedgEntry.RESET;
            ResLedgEntry.SETCURRENTKEY("Document No.", "Posting Date");
            ResLedgEntry.SETFILTER("Document No.", DocNoFilter);
            ResLedgEntry.SETFILTER("Posting Date", PostingDateFilter);
            InsertIntoDocEntry(
              DATABASE::"Res. Ledger Entry", 0, ResLedgEntry.TABLECAPTION, ResLedgEntry.COUNT);
        END;
        FindJobRecords;
        IF BankAccLedgEntry.READPERMISSION THEN BEGIN
            BankAccLedgEntry.RESET;
            BankAccLedgEntry.SETCURRENTKEY("Document No.", "Posting Date");
            BankAccLedgEntry.SETFILTER("Document No.", DocNoFilter);
            BankAccLedgEntry.SETFILTER("Posting Date", PostingDateFilter);
            InsertIntoDocEntry(
              DATABASE::"Bank Account Ledger Entry", 0, BankAccLedgEntry.TABLECAPTION, BankAccLedgEntry.COUNT);
        END;
        IF CheckLedgEntry.READPERMISSION THEN BEGIN
            CheckLedgEntry.RESET;
            CheckLedgEntry.SETCURRENTKEY("Document No.", "Posting Date");
            CheckLedgEntry.SETFILTER("Document No.", DocNoFilter);
            CheckLedgEntry.SETFILTER("Posting Date", PostingDateFilter);
            InsertIntoDocEntry(
              DATABASE::"Check Ledger Entry", 0, CheckLedgEntry.TABLECAPTION, CheckLedgEntry.COUNT);
        END;
        IF FALedgEntry.READPERMISSION THEN BEGIN
            FALedgEntry.RESET;
            FALedgEntry.SETCURRENTKEY("Document No.", "Posting Date");
            FALedgEntry.SETFILTER("Document No.", DocNoFilter);
            FALedgEntry.SETFILTER("Posting Date", PostingDateFilter);
            InsertIntoDocEntry(
              DATABASE::"FA Ledger Entry", 0, FALedgEntry.TABLECAPTION, FALedgEntry.COUNT);
        END;
        IF MaintenanceLedgEntry.READPERMISSION THEN BEGIN
            MaintenanceLedgEntry.RESET;
            MaintenanceLedgEntry.SETCURRENTKEY("Document No.", "Posting Date");
            MaintenanceLedgEntry.SETFILTER("Document No.", DocNoFilter);
            MaintenanceLedgEntry.SETFILTER("Posting Date", PostingDateFilter);
            InsertIntoDocEntry(
              DATABASE::"Maintenance Ledger Entry", 0, MaintenanceLedgEntry.TABLECAPTION, MaintenanceLedgEntry.COUNT);
        END;
        IF InsuranceCovLedgEntry.READPERMISSION THEN BEGIN
            InsuranceCovLedgEntry.RESET;
            InsuranceCovLedgEntry.SETCURRENTKEY("Document No.", "Posting Date");
            InsuranceCovLedgEntry.SETFILTER("Document No.", DocNoFilter);
            InsuranceCovLedgEntry.SETFILTER("Posting Date", PostingDateFilter);
            InsertIntoDocEntry(
              DATABASE::"Ins. Coverage Ledger Entry", 0, InsuranceCovLedgEntry.TABLECAPTION, InsuranceCovLedgEntry.COUNT);
        END;
        IF CapacityLedgEntry.READPERMISSION THEN BEGIN
            CapacityLedgEntry.RESET;
            CapacityLedgEntry.SETCURRENTKEY("Document No.", "Posting Date");
            CapacityLedgEntry.SETFILTER("Document No.", DocNoFilter);
            CapacityLedgEntry.SETFILTER("Posting Date", PostingDateFilter);
            InsertIntoDocEntry(
              DATABASE::"Capacity Ledger Entry", 0, CapacityLedgEntry.TABLECAPTION, CapacityLedgEntry.COUNT);
        END;
        IF WhseEntry.READPERMISSION THEN BEGIN
            WhseEntry.RESET;
            WhseEntry.SETCURRENTKEY("Reference No.", "Registering Date");
            WhseEntry.SETFILTER("Reference No.", DocNoFilter);
            WhseEntry.SETFILTER("Registering Date", PostingDateFilter);
            InsertIntoDocEntry(
              DATABASE::"Warehouse Entry", 0, WhseEntry.TABLECAPTION, WhseEntry.COUNT);
        END;
        IF ServLedgerEntry.READPERMISSION THEN BEGIN
            ServLedgerEntry.RESET;
            ServLedgerEntry.SETCURRENTKEY("Document No.", "Posting Date");
            ServLedgerEntry.SETFILTER("Document No.", DocNoFilter);
            ServLedgerEntry.SETFILTER("Posting Date", PostingDateFilter);
            InsertIntoDocEntry(
              DATABASE::"Service Ledger Entry", 0, ServLedgerEntry.TABLECAPTION, ServLedgerEntry.COUNT);
        END;
        IF WarrantyLedgerEntry.READPERMISSION THEN BEGIN
            WarrantyLedgerEntry.RESET;
            WarrantyLedgerEntry.SETCURRENTKEY("Document No.", "Posting Date");
            WarrantyLedgerEntry.SETFILTER("Document No.", DocNoFilter);
            WarrantyLedgerEntry.SETFILTER("Posting Date", PostingDateFilter);
            InsertIntoDocEntry(
              DATABASE::"Warranty Ledger Entry", 0, WarrantyLedgerEntry.TABLECAPTION, WarrantyLedgerEntry.COUNT);
        END;
        IF CostEntry.READPERMISSION THEN BEGIN
            CostEntry.RESET;
            CostEntry.SETCURRENTKEY("Document No.", "Posting Date");
            CostEntry.SETFILTER("Document No.", DocNoFilter);
            CostEntry.SETFILTER("Posting Date", PostingDateFilter);
            InsertIntoDocEntry(
              DATABASE::"Cost Entry", 0, CostEntry.TABLECAPTION, CostEntry.COUNT);
        END;

        CheckTaxReadPermissionToInsertDocEntry;
        CheckGSTReadPermissionToInsertDocEntry;
    end;

    local procedure CheckTaxReadPermissionToInsertDocEntry()
    begin



        IF TDSEntry.READPERMISSION THEN BEGIN
            TDSEntry.RESET;
            TDSEntry.SETCURRENTKEY("Document No.", "Posting Date");
            TDSEntry.SETFILTER("Document No.", DocNoFilter);
            TDSEntry.SETFILTER("Posting Date", PostingDateFilter);
            InsertIntoDocEntry(
              DATABASE::"TDS Entry", 0, TDSEntry.TABLENAME, TDSEntry.COUNT);
        END;

        IF TCSEntry.READPERMISSION THEN BEGIN
            TCSEntry.RESET;
            TCSEntry.SETCURRENTKEY("Document No.", "Posting Date");
            TCSEntry.SETFILTER("Document No.", DocNoFilter);
            TCSEntry.SETFILTER("Posting Date", PostingDateFilter);
            InsertIntoDocEntry(
              DATABASE::"TCS Entry", 0, TCSEntry.TABLENAME, TCSEntry.COUNT);
        END;







    end;

    local procedure CheckGSTReadPermissionToInsertDocEntry()
    begin
        IF GSTLedgerEntry.READPERMISSION THEN BEGIN
            GSTLedgerEntry.RESET;
            GSTLedgerEntry.SETCURRENTKEY("Document No.", "Posting Date");
            GSTLedgerEntry.SETFILTER("Document No.", DocNoFilter);
            GSTLedgerEntry.SETFILTER("Posting Date", PostingDateFilter);
            InsertIntoDocEntry(
              DATABASE::"GST Ledger Entry", 0, GSTLedgerEntry.TABLECAPTION, GSTLedgerEntry.COUNT);
        END;
        IF DetailedGSTLedgerEntry.READPERMISSION THEN BEGIN
            DetailedGSTLedgerEntry.RESET;
            DetailedGSTLedgerEntry.SETCURRENTKEY("Document No.", "Posting Date");
            DetailedGSTLedgerEntry.SETFILTER("Document No.", DocNoFilter);
            DetailedGSTLedgerEntry.SETFILTER("Posting Date", PostingDateFilter);
            InsertIntoDocEntry(
              DATABASE::"Detailed GST Ledger Entry", 0, DetailedGSTLedgerEntry.TABLECAPTION, DetailedGSTLedgerEntry.COUNT);
        END;
        IF ServiceTransferShptHeader.READPERMISSION THEN BEGIN
            ServiceTransferShptHeader.RESET;
            ServiceTransferShptHeader.SETFILTER("No.", DocNoFilter);
            ServiceTransferShptHeader.SETFILTER("Shipment Date", PostingDateFilter);
            InsertIntoDocEntry(
              DATABASE::"Service Transfer Shpt. Header", 0, ServiceTransferShptHeader.TABLECAPTION, ServiceTransferShptHeader.COUNT);
        END;
        IF ServiceTransferRcptHeader.READPERMISSION THEN BEGIN
            ServiceTransferRcptHeader.RESET;
            ServiceTransferRcptHeader.SETFILTER("No.", DocNoFilter);
            ServiceTransferRcptHeader.SETFILTER("Receipt Date", PostingDateFilter);
            InsertIntoDocEntry(
              DATABASE::"Service Transfer Rcpt. Header", 0, ServiceTransferRcptHeader.TABLECAPTION, ServiceTransferRcptHeader.COUNT);
        END;
        IF DetailedCrAdjstmntEntry.READPERMISSION THEN BEGIN
            DetailedCrAdjstmntEntry.RESET;
            DetailedCrAdjstmntEntry.SETCURRENTKEY("Document No.", "Posting Date");
            DetailedCrAdjstmntEntry.SETFILTER("Document No.", DocNoFilter);
            DetailedCrAdjstmntEntry.SETFILTER("Posting Date", PostingDateFilter);
            InsertIntoDocEntry(
              DATABASE::"Detailed Cr. Adjstmnt. Entry", 0, DetailedCrAdjstmntEntry.TABLECAPTION, DetailedCrAdjstmntEntry.COUNT);
        END;
        IF PostedGSTDistributionHeader.READPERMISSION THEN BEGIN
            PostedGSTDistributionHeader.RESET;
            PostedGSTDistributionHeader.SETFILTER("No.", DocNoFilter);
            PostedGSTDistributionHeader.SETFILTER("Posting Date", PostingDateFilter);
            IF PostedGSTDistributionHeader.FINDFIRST THEN
                IF PostedGSTDistributionHeader."ISD Document Type" = PostedGSTDistributionHeader."ISD Document Type"::Invoice THEN
                    InsertIntoDocEntry(
                      DATABASE::"Posted GST Distribution Header", "Document Type"::Invoice,
                      PostedGSTDistributionHeader.TABLECAPTION, PostedGSTDistributionHeader.COUNT)
                ELSE
                    InsertIntoDocEntry(
                      DATABASE::"Posted GST Distribution Header", "Document Type"::"Credit Memo",
                      PostedGSTDistributionHeader.TABLECAPTION, PostedGSTDistributionHeader.COUNT);
        END;
        IF DetailedGSTDistEntry.READPERMISSION THEN BEGIN
            DetailedGSTDistEntry.RESET;
            DetailedGSTDistEntry.SETCURRENTKEY("Document No.", "Posting Date");
            DetailedGSTDistEntry.SETFILTER("ISD Document No.", DocNoFilter);
            DetailedGSTDistEntry.SETFILTER("Posting Date", PostingDateFilter);
            InsertIntoDocEntry(
              DATABASE::"Detailed GST Dist. Entry", 0, DetailedGSTDistEntry.TABLECAPTION, DetailedGSTDistEntry.COUNT);
        END;
        IF PostedJnlBankCharges.READPERMISSION THEN BEGIN
            PostedJnlBankCharges.RESET;
            PostedJnlBankCharges.SETCURRENTKEY("Document No.", "Posting Date");
            PostedJnlBankCharges.SETFILTER("Document No.", DocNoFilter);
            PostedJnlBankCharges.SETFILTER("Posting Date", PostingDateFilter);
            InsertIntoDocEntry(
              DATABASE::"Posted Jnl. Bank Charges", 0, PostedJnlBankCharges.TABLECAPTION, PostedJnlBankCharges.COUNT);
        END;
        IF PostedGSTLiabilityAdj.READPERMISSION THEN BEGIN
            PostedGSTLiabilityAdj.RESET;
            PostedGSTLiabilityAdj.SETCURRENTKEY("Document No.", "Posting Date");
            PostedGSTLiabilityAdj.SETFILTER("Document No.", DocNoFilter);
            PostedGSTLiabilityAdj.SETFILTER("Posting Date", PostingDateFilter);
            InsertIntoDocEntry(
              DATABASE::"Posted GST Liability Adj.", 0, PostedGSTLiabilityAdj.TABLECAPTION, PostedGSTLiabilityAdj.COUNT);
        END;
        IF GSTTdsTcsEntry.READPERMISSION THEN BEGIN
            GSTTdsTcsEntry.RESET;
            GSTTdsTcsEntry.SETCURRENTKEY("Document No.", "Posting Date");
            GSTTdsTcsEntry.SETFILTER("Document No.", DocNoFilter);
            GSTTdsTcsEntry.SETFILTER("Posting Date", PostingDateFilter);
            InsertIntoDocEntry(
              DATABASE::"GST TDS/TCS Entry", 0, GSTTdsTcsEntry.TABLECAPTION, GSTTdsTcsEntry.COUNT);
        END;
        IF ProvisionalEntry.READPERMISSION THEN BEGIN
            ProvisionalEntry.RESET;
            ProvisionalEntry.SETCURRENTKEY("Posted Document No.", "Posting Date");
            ProvisionalEntry.SETFILTER("Posted Document No.", DocNoFilter);
            ProvisionalEntry.SETFILTER("Posting Date", PostingDateFilter);
            InsertIntoDocEntry(
              DATABASE::"Provisional Entry", 0, ProvisionalEntry.TABLECAPTION, ProvisionalEntry.COUNT);
        END;
    end;

    local procedure UpdateLineNarration()
    var
        GLEntry: Record 17;
        CustLedgerEntry: Record 21;
        SalesInvoiceHeader: Record 112;
        VendorLedgerEntry: Record 25;
        PurchInvHeader: Record 122;
    begin
        IF NewLineNaration <> '' THEN BEGIN
            GLEntry.RESET;
            GLEntry.SETRANGE(GLEntry."Document No.", NewDocNo);
            IF GLEntry.FINDSET THEN
                REPEAT
                    GLEntry.VALIDATE("Line Narration1", NewLineNaration);
                    GLEntry.MODIFY;
                UNTIL GLEntry.NEXT = 0;

            CustLedgerEntry.RESET;
            CustLedgerEntry.SETRANGE(CustLedgerEntry."Document No.", NewDocNo);
            IF CustLedgerEntry.FINDSET THEN
                REPEAT
                    CustLedgerEntry.VALIDATE("Line Narration1", NewLineNaration);
                    CustLedgerEntry.MODIFY;
                UNTIL CustLedgerEntry.NEXT = 0;
            SalesInvoiceHeader.RESET;
            SalesInvoiceHeader.SETRANGE(SalesInvoiceHeader."No.", NewDocNo);
            IF SalesInvoiceHeader.FINDFIRST THEN BEGIN
                SalesInvoiceHeader.VALIDATE("Line Narration", NewLineNaration);
                SalesInvoiceHeader.MODIFY;
            END;

            VendorLedgerEntry.RESET;
            VendorLedgerEntry.SETRANGE(VendorLedgerEntry."Document No.", NewDocNo);
            IF VendorLedgerEntry.FINDSET THEN
                REPEAT
                    VendorLedgerEntry.VALIDATE("Line Narration1", NewLineNaration);
                    VendorLedgerEntry.MODIFY;
                UNTIL VendorLedgerEntry.NEXT = 0;

            PurchInvHeader.RESET;
            PurchInvHeader.SETRANGE(PurchInvHeader."No.", NewDocNo);
            IF PurchInvHeader.FINDFIRST THEN BEGIN
                PurchInvHeader.VALIDATE("Line Narration1", NewLineNaration);
                PurchInvHeader.MODIFY;
            END;
            PurchCrMemoHeader.RESET;
            PurchCrMemoHeader.SETRANGE(PurchCrMemoHeader."No.", NewDocNo);
            IF PurchCrMemoHeader.FINDFIRST THEN BEGIN
                PurchCrMemoHeader.VALIDATE("Line Narration1", NewLineNaration);
                PurchCrMemoHeader.MODIFY;
            END;

        END;
    end;
}

