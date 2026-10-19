//namespace Microsoft.Finance.Reports;
// using Microsoft.Finance.GST.Base;
// using Microsoft.Finance.TaxBase;
// using Microsoft.FixedAssets.FixedAsset;
// using Microsoft.Foundation.Company;
// using Microsoft.Foundation.Shipping;
// using Microsoft.Foundation.UOM;
// using Microsoft.Inventory.Intrastat;
// using Microsoft.Inventory.Item;
// using Microsoft.Inventory.Location;
// using Microsoft.Inventory.Transfer;
// using Microsoft.Purchases.Document;
// using Microsoft.Purchases.History;
// using Microsoft.Purchases.Payables;
// using Microsoft.Purchases.Vendor;
// using Microsoft.Sales.Customer;
// using Microsoft.Sales.History;
// using Microsoft.Sales.Receivables;
// using Microsoft.Service.History;
// using System.IO;

codeunit 50062 EwayBillJsonHandler
{
    trigger OnRun()
    begin

    end;

    procedure GetToAddressExternal(DocumentNumber: Text; IsAddress1: Boolean): Text
    var
        JsonObjectRes: JsonObject;
        JsonObjectItem: JsonObject;
        JsonArrayItem: JsonArray;
        Payload: Text;
        DocumentLineNo: Integer;
        OriginalInvoiceNo: Code[20];
        ItemChargeAssgnLineNo: Integer;
        DetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry";
        DelGSTLedgerEntryInfoCount: Integer;
        DetailedGSTLedgerEntryCount: Integer;
    begin
        DocumentNo := DocumentNumber;
        ClearVariables();
        TransType := TransType::Sales;
        SourceType := SourceType::Customer;

        "Detailed GST Ledger Entry".Reset();
        "Detailed GST Ledger Entry".SetRange("Document No.", DocumentNo);
        "Detailed GST Ledger Entry".SetRange("Document Type", DetailedGSTLedgerEntry."Document Type"::Invoice);
        "Detailed GST Ledger Entry".SetRange("Entry Type", DetailedGSTLedgerEntry."Entry Type"::"Initial Entry");
        "Detailed GST Ledger Entry".SetRange("GST Group Type", DetailedGSTLedgerEntry."GST Group Type"::Goods);
        "Detailed GST Ledger Entry".SetFilter(Type, '%1|%2', DetailedGSTLedgerEntry.Type::"Fixed Asset", DetailedGSTLedgerEntry.Type::Item);
        "Detailed GST Ledger Entry".FindFirst();
        DelGSTLedgerEntryInfo.Get("Detailed GST Ledger Entry"."Entry No.");
        InitializeVariables();
        exit(GetToAddress(IsAddress1));
    end;

    procedure GetToPlaceExternal(DocumentNumber: Text): Text
    var
        JsonObjectRes: JsonObject;
        JsonObjectItem: JsonObject;
        JsonArrayItem: JsonArray;
        Payload: Text;
        DocumentLineNo: Integer;
        OriginalInvoiceNo: Code[20];
        ItemChargeAssgnLineNo: Integer;
        DetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry";
    // DelGSTLedgerEntryInfoCount: Integer;
    // DetailedGSTLedgerEntryCount: Integer;
    begin
        DocumentNo := DocumentNumber;
        ClearVariables();
        TransType := TransType::Sales;
        SourceType := SourceType::Customer;

        "Detailed GST Ledger Entry".Reset();
        "Detailed GST Ledger Entry".SetRange("Document No.", DocumentNo);
        "Detailed GST Ledger Entry".SetRange("Document Type", DetailedGSTLedgerEntry."Document Type"::Invoice);
        "Detailed GST Ledger Entry".SetRange("Entry Type", DetailedGSTLedgerEntry."Entry Type"::"Initial Entry");
        "Detailed GST Ledger Entry".SetRange("GST Group Type", DetailedGSTLedgerEntry."GST Group Type"::Goods);
        "Detailed GST Ledger Entry".SetFilter(Type, '%1|%2', DetailedGSTLedgerEntry.Type::"Fixed Asset", DetailedGSTLedgerEntry.Type::Item);
        "Detailed GST Ledger Entry".FindFirst();
        DelGSTLedgerEntryInfo.Get("Detailed GST Ledger Entry"."Entry No.");
        InitializeVariables();
        exit(GetToPlace());
    end;

    procedure GetToPostCodeExternal(DocumentNumber: Text): Text
    var
        JsonObjectRes: JsonObject;
        JsonObjectItem: JsonObject;
        JsonArrayItem: JsonArray;
        Payload: Text;
        DocumentLineNo: Integer;
        OriginalInvoiceNo: Code[20];
        ItemChargeAssgnLineNo: Integer;
        DetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry";
    // DelGSTLedgerEntryInfoCount: Integer;
    // DetailedGSTLedgerEntryCount: Integer;
    begin
        DocumentNo := DocumentNumber;
        ClearVariables();
        TransType := TransType::Sales;
        SourceType := SourceType::Customer;

        "Detailed GST Ledger Entry".Reset();
        "Detailed GST Ledger Entry".SetRange("Document No.", DocumentNo);
        "Detailed GST Ledger Entry".SetRange("Document Type", DetailedGSTLedgerEntry."Document Type"::Invoice);
        "Detailed GST Ledger Entry".SetRange("Entry Type", DetailedGSTLedgerEntry."Entry Type"::"Initial Entry");
        "Detailed GST Ledger Entry".SetRange("GST Group Type", DetailedGSTLedgerEntry."GST Group Type"::Goods);
        "Detailed GST Ledger Entry".SetFilter(Type, '%1|%2', DetailedGSTLedgerEntry.Type::"Fixed Asset", DetailedGSTLedgerEntry.Type::Item);
        "Detailed GST Ledger Entry".FindFirst();
        DelGSTLedgerEntryInfo.Get("Detailed GST Ledger Entry"."Entry No.");
        InitializeVariables();
        exit(GetToPostCode());
    end;

    procedure GetToStateExternal(DocumentNumber: Text): Text
    var
        JsonObjectRes: JsonObject;
        JsonObjectItem: JsonObject;
        JsonArrayItem: JsonArray;
        Payload: Text;
        DocumentLineNo: Integer;
        OriginalInvoiceNo: Code[20];
        ItemChargeAssgnLineNo: Integer;
        DetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry";
    // DelGSTLedgerEntryInfoCount: Integer;
    // DetailedGSTLedgerEntryCount: Integer;
    begin
        DocumentNo := DocumentNumber;
        ClearVariables();
        TransType := TransType::Sales;
        SourceType := SourceType::Customer;

        "Detailed GST Ledger Entry".Reset();
        "Detailed GST Ledger Entry".SetRange("Document No.", DocumentNo);
        "Detailed GST Ledger Entry".SetRange("Document Type", DetailedGSTLedgerEntry."Document Type"::Invoice);
        "Detailed GST Ledger Entry".SetRange("Entry Type", DetailedGSTLedgerEntry."Entry Type"::"Initial Entry");
        "Detailed GST Ledger Entry".SetRange("GST Group Type", DetailedGSTLedgerEntry."GST Group Type"::Goods);
        "Detailed GST Ledger Entry".SetFilter(Type, '%1|%2', DetailedGSTLedgerEntry.Type::"Fixed Asset", DetailedGSTLedgerEntry.Type::Item);
        "Detailed GST Ledger Entry".FindFirst();
        DelGSTLedgerEntryInfo.Get("Detailed GST Ledger Entry"."Entry No.");
        InitializeVariables();
        exit(GetToState());
    end;

    procedure GetPlaceStateExternal(DocumentNumber: Text): Text
    var
        JsonObjectRes: JsonObject;
        JsonObjectItem: JsonObject;
        JsonArrayItem: JsonArray;
        Payload: Text;
        DocumentLineNo: Integer;
        OriginalInvoiceNo: Code[20];
        ItemChargeAssgnLineNo: Integer;
        DetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry";
    // DelGSTLedgerEntryInfoCount: Integer;
    // DetailedGSTLedgerEntryCount: Integer;
    begin
        DocumentNo := DocumentNumber;
        ClearVariables();
        TransType := TransType::Sales;
        SourceType := SourceType::Customer;

        "Detailed GST Ledger Entry".Reset();
        "Detailed GST Ledger Entry".SetRange("Document No.", DocumentNo);
        "Detailed GST Ledger Entry".SetRange("Document Type", DetailedGSTLedgerEntry."Document Type"::Invoice);
        "Detailed GST Ledger Entry".SetRange("Entry Type", DetailedGSTLedgerEntry."Entry Type"::"Initial Entry");
        "Detailed GST Ledger Entry".SetRange("GST Group Type", DetailedGSTLedgerEntry."GST Group Type"::Goods);
        "Detailed GST Ledger Entry".SetFilter(Type, '%1|%2', DetailedGSTLedgerEntry.Type::"Fixed Asset", DetailedGSTLedgerEntry.Type::Item);
        "Detailed GST Ledger Entry".FindFirst();
        DelGSTLedgerEntryInfo.Get("Detailed GST Ledger Entry"."Entry No.");
        InitializeVariables();
        exit(GetPlaceState());
    end;

    procedure GetFromStateExternal(DocumentNumber: Text): Text
    var
        JsonObjectRes: JsonObject;
        JsonObjectItem: JsonObject;
        JsonArrayItem: JsonArray;
        Payload: Text;
        DocumentLineNo: Integer;
        OriginalInvoiceNo: Code[20];
        ItemChargeAssgnLineNo: Integer;
        DetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry";
    // DelGSTLedgerEntryInfoCount: Integer;
    // DetailedGSTLedgerEntryCount: Integer;
    begin
        DocumentNo := DocumentNumber;
        ClearVariables();
        TransType := TransType::Sales;
        SourceType := SourceType::Customer;

        "Detailed GST Ledger Entry".Reset();
        "Detailed GST Ledger Entry".SetRange("Document No.", DocumentNo);
        "Detailed GST Ledger Entry".SetRange("Document Type", DetailedGSTLedgerEntry."Document Type"::Invoice);
        "Detailed GST Ledger Entry".SetRange("Entry Type", DetailedGSTLedgerEntry."Entry Type"::"Initial Entry");
        "Detailed GST Ledger Entry".SetRange("GST Group Type", DetailedGSTLedgerEntry."GST Group Type"::Goods);
        "Detailed GST Ledger Entry".SetFilter(Type, '%1|%2', DetailedGSTLedgerEntry.Type::"Fixed Asset", DetailedGSTLedgerEntry.Type::Item);
        "Detailed GST Ledger Entry".FindFirst();
        DelGSTLedgerEntryInfo.Get("Detailed GST Ledger Entry"."Entry No.");
        InitializeVariables();
        exit(GetFromState());
    end;

    procedure GetRequestJson(DocumentNumber: Text; DocType1: Option " ",Sales,Transfer,Purchase): Text
    var
        JsonObjectRes: JsonObject;
        JsonObjectItem: JsonObject;
        JsonArrayItem: JsonArray;
        Payload: Text;
        DocumentLineNo: Integer;
        OriginalInvoiceNo: Code[20];
        ItemChargeAssgnLineNo: Integer;
        DetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry";
        // DelGSTLedgerEntryInfoCount: Integer;
        // DetailedGSTLedgerEntryCount: Integer;
        PurchCredit: Record "Purch. Cr. Memo Hdr.";
        SalesInvoice: Record "Sales Invoice Header";
        TransferShip: Record "Transfer Shipment Header";
        CU50061: Codeunit 50061;
        FromPinCode: Code[20];
        ToPinCode: Code[20];
        TransID: Code[15];
        TransName: Text[100];
        LRNo: Code[100];
        LRDate: Date;
        TransMode: Text[20];
        Distance: Integer;
        PurCreditmemo: Record "Purch. Cr. Memo Line";
        CompanyInfo: Record "Company Information";
    begin
        CompanyInfo.Get;
        DocumentNo := DocumentNumber;
        ClearVariables();

        if DocType1 = DocType1::Purchase then begin
            TransType := TransType::Purchase;
            SourceType := SourceType::Vendor;
        end else begin
            TransType := TransType::Sales;
            SourceType := SourceType::Customer;
        end;
        if DocType1 = DocType1::Purchase then
            PurchCredit.Get(DocumentNumber)
        else
            if DocType1 = DocType1::Sales then
                SalesInvoice.Get(DocumentNumber)
            else
                if DocType1 = DocType1::Transfer then
                    TransferShip.Get(DocumentNumber);



        "Detailed GST Ledger Entry".Reset();
        "Detailed GST Ledger Entry".SetRange("Document No.", DocumentNo);
        "Detailed GST Ledger Entry".SetFilter("Document Type", '%1|%2', DetailedGSTLedgerEntry."Document Type"::Invoice, DetailedGSTLedgerEntry."Document Type"::"Credit Memo");
        "Detailed GST Ledger Entry".SetRange("Entry Type", DetailedGSTLedgerEntry."Entry Type"::"Initial Entry");
        "Detailed GST Ledger Entry".SetRange("GST Group Type", DetailedGSTLedgerEntry."GST Group Type"::Goods);
        "Detailed GST Ledger Entry".SetFilter(Type, '%1|%2|%3', DetailedGSTLedgerEntry.Type::"Fixed Asset", DetailedGSTLedgerEntry.Type::Item, DetailedGSTLedgerEntry.Type::"G/L Account");
        "Detailed GST Ledger Entry".FindFirst();
        DelGSTLedgerEntryInfo.Get("Detailed GST Ledger Entry"."Entry No.");
        InitializeVariables();
        // DelGSTLedgerEntryInfoCount := "Detailed GST Ledger Entry".Count();
        // DelGSTLedgerEntryInfoCount := DelGSTLedgerEntryInfo.Count();

        if DocType1 = DocType1::Transfer then
            if not (DelGSTLedgerEntryInfo."Original Doc. Type" in [DelGSTLedgerEntryInfo."Original Doc. Type"::"Transfer Shipment"]) then
                exit;

        Clear(JsonObjectRes);
        Clear(JsonArrayItem);
        Clear(Payload);

        GetSupplySubDocType();
        GetGSTAmount(DocumentNumber);

        if DocType1 in [DocType1::Sales, DocType1::Purchase] then
            if CompanyInfo.SFPLCompany in [CompanyInfo.SFPLCompany::Sampoorna] then
                if Abs(TotalInvoiceValue) < 50000 then begin
                    Message('Total Invoice Value Less Than 50000');
                    exit(Payload);
                end;
        if DocType1 = DocType1::Transfer then
            if Abs(TotalInvoiceValue) < 40000 then begin
                Message('Total Invoice Value Less Than 40000');
                exit(Payload);
            End;

        if "Detailed GST Ledger Entry".FindSet() then
            repeat
                if (DocumentNo <> "Detailed GST Ledger Entry"."Document No.") or
                    (DocumentLineNo <> "Detailed GST Ledger Entry"."Document Line No.") or
                    (OriginalInvoiceNo <> "Detailed GST Ledger Entry"."Original Invoice No.") or
                    (ItemChargeAssgnLineNo <> DelGSTLedgerEntryInfo."Item Charge Assgn. Line No.")
                then begin
                    if not ServiceDoc then begin
                        Clear(JsonObjectItem);

                        if "Detailed GST Ledger Entry".Type = Type::Item then begin
                            Item.Get("Detailed GST Ledger Entry"."No.");
                            JsonObjectItem.Add('product_name', Item.Description);
                            JsonObjectItem.Add('product_description', Item.Description);
                        end else
                            if "Detailed GST Ledger Entry".Type = Type::"Fixed Asset" then begin
                                FixedAsset.Get("Detailed GST Ledger Entry"."No.");
                                JsonObjectItem.Add('product_name', FixedAsset.Description);
                                JsonObjectItem.Add('product_description', FixedAsset.Description);
                            end else
                                if DocType1 = DocType1::Purchase then
                                    If DetailedGSTLedgerEntry."Entry Type" = Type::"G/L Account" Then begin
                                        PurCreditmemo.Get(DetailedGSTLedgerEntry."Document No.", DetailedGSTLedgerEntry."Document Line No.");
                                        JsonObjectItem.Add('product_name', PurCreditmemo.Description);
                                        JsonObjectItem.Add('product_description', PurCreditmemo.Description);
                                    end;
                        JsonObjectItem.Add('hsn_code', "Detailed GST Ledger Entry"."HSN/SAC Code");
                        JsonObjectItem.Add('quantity', Abs("Detailed GST Ledger Entry".Quantity));
                        JsonObjectItem.Add('unit_of_product', GetUOM());
                        GetTaxRate();
                        GetGSTAmount(DocumentNumber);
                        JsonObjectItem.Add('cgst_rate', CGSTTaxRate);
                        JsonObjectItem.Add('sgst_rate', SGSTTaxRate);
                        JsonObjectItem.Add('igst_rate', IGSTTaxRate);
                        JsonObjectItem.Add('cess_rate', CESSTaxRate);
                        JsonObjectItem.Add('cessNonAdvol', Abs(CessNonAdvolAmount));
                        JsonObjectItem.Add('taxable_amount', Abs("Detailed GST Ledger Entry"."GST Base Amount"));
                        JsonArrayItem.Add(JsonObjectItem);
                        TotalCGSTAmount += CGSTAmount;
                        TotalSGSTAmount += SGSTAmount;
                        TotalIGSTAmount += IGSTAmount;
                        TotalCessAmount += CessAmount;
                        TotalOtherAmount += Others;
                        TotalCessNonAdvolAmount += CessNonAdvolAmount;
                        TotalTaxableAmount += Abs("Detailed GST Ledger Entry"."GST Base Amount");
                    end;
                end;
                DocumentNo := "Detailed GST Ledger Entry"."Document No.";
                DocumentLineNo := "Detailed GST Ledger Entry"."Document Line No.";
                OriginalInvoiceNo := "Detailed GST Ledger Entry"."Original Invoice No.";
                ItemChargeAssgnLineNo := DelGSTLedgerEntryInfo."Item Charge Assgn. Line No.";
            until "Detailed GST Ledger Entry".Next() = 0;

        //CU50061.LoginBusinessUnit(GetFromGSTIN());

        JsonObjectRes.Add('access_token', CU50061.GetInfo('MIEWAY', DataScope::Module));
        JsonObjectRes.Add('userGstin', GetFromGSTIN());
        //JsonObjectRes.Add('userGstin', '05AAABC0181E1ZE');//For Testing
        JsonObjectRes.Add('supply_type', Format(SupplyType));
        JsonObjectRes.Add('sub_supply_type', Format(SubType));
        JsonObjectRes.Add('sub_supply_description', GetTransactionType());
        JsonObjectRes.Add('document_type', Format(DocType));
        JsonObjectRes.Add('document_number', "Detailed GST Ledger Entry"."Document No.");
        JsonObjectRes.Add('document_date', "Detailed GST Ledger Entry"."Posting Date");
        JsonObjectRes.Add('gstin_of_consignor', GetFromGSTIN());
        //JsonObjectRes.Add('gstin_of_consignor', '05AAABC0181E1ZE');//For Testing
        JsonObjectRes.Add('legal_name_of_consignor', GetFromOtherPartyName());
        JsonObjectRes.Add('address1_of_consignor', GetFromAddress(true));
        JsonObjectRes.Add('address2_of_consignor', GetFromAddress(false));
        JsonObjectRes.Add('place_of_consignor', GetPlaceState());
        FromPinCode := GetPostCode();
        //FromPinCode := '246474';//For Testing
        // JsonObjectRes.Add('pincode_of_consignor', GetPostCode());
        JsonObjectRes.Add('pincode_of_consignor', FromPinCode);
        JsonObjectRes.Add('state_of_consignor', UpperCase(GetFromState()));
        //JsonObjectRes.Add('state_of_consignor', 'Uttarakhand');//For testing
        JsonObjectRes.Add('actual_from_state_name', UpperCase(GetDispatchState()));
        //JsonObjectRes.Add('actual_from_state_name', 'Uttarakhand');//For Testing
        JsonObjectRes.Add('gstin_of_consignee', GetToGSTIN());
        //JsonObjectRes.Add('gstin_of_consignee', '05AAABB0639G1Z8');//For Testing
        JsonObjectRes.Add('legal_name_of_consignee', GetToOtherPartyName());
        JsonObjectRes.Add('address1_of_consignee', GetToAddress(true));
        JsonObjectRes.Add('address2_of_consignee', GetToAddress(false));
        JsonObjectRes.Add('place_of_consignee', GetToPlace());
        ToPinCode := GetToPostCode();
        //ToPinCode := '262401';//For Testing
        // JsonObjectRes.Add('pincode_of_consignee', GetToPostCode());
        JsonObjectRes.Add('pincode_of_consignee', ToPinCode);
        JsonObjectRes.Add('state_of_supply', UpperCase(GetToState()));
        JsonObjectRes.Add('actual_to_state_name', UpperCase(GetShipToState()));

        // JsonObjectRes.Add('state_of_supply', 'Uttarakhand');//For Testing
        // JsonObjectRes.Add('actual_to_state_name', 'Uttarakhand');//For Testing
        JsonObjectRes.Add('transaction_type', GetTransactionType());
        JsonObjectRes.Add('other_value', Abs(TotalOtherAmount));
        JsonObjectRes.Add('total_invoice_value', Abs(TotalInvoiceValue));
        JsonObjectRes.Add('taxable_amount', Abs(TotalTaxableAmount));
        JsonObjectRes.Add('cgst_amount', Abs(TotalCGSTAmount));
        JsonObjectRes.Add('sgst_amount', Abs(TotalSGSTAmount));
        JsonObjectRes.Add('igst_amount', Abs(TotalIGSTAmount));
        JsonObjectRes.Add('cess_amount', Abs(TotalCessAmount));
        JsonObjectRes.Add('cess_nonadvol_value', Abs(TotalCessNonAdvolAmount));
        GetTransporterDetails(TransID, TransName, LRNo, LRDate, TransMode);
        JsonObjectRes.Add('transporter_id', TransID);
        JsonObjectRes.Add('transporter_name', TransName);
        JsonObjectRes.Add('transporter_document_number', LRNo);
        if LRDate <> 0D then
            JsonObjectRes.Add('transporter_document_date', LRDate)
        Else
            JsonObjectRes.Add('transporter_document_date', '');
        JsonObjectRes.Add('transportation_mode', TransMode);
        if DocType1 = DocType1::Purchase then begin
            if PurchCredit."Distance (Km)" <> 0 Then
                JsonObjectRes.Add('transportation_distance', PurchCredit."Distance (Km)");
        end else
            if DocType1 = DocType1::Sales then begin
                if SalesInvoice."Distance (Km)" <> 0 Then
                    JsonObjectRes.Add('transportation_distance', SalesInvoice."Distance (Km)");
            end else
                if DocType1 = DocType1::Transfer then begin
                    if TransferShip."Distance (Km)" <> 0 Then
                        JsonObjectRes.Add('transportation_distance', TransferShip."Distance (Km)");
                end else
                    JsonObjectRes.Add('transportation_distance', Format(GetDistance(FromPinCode, ToPinCode), 0, '<Integer>'));
        JsonObjectRes.Add('vehicle_number', GetVehicleNo());
        JsonObjectRes.Add('vehicle_type', GetVehicleType());
        JsonObjectRes.Add('generate_status', 1);
        JsonObjectRes.Add('data_source', 'erp');
        JsonObjectRes.Add('user_ref', '');
        JsonObjectRes.Add('location_code', '');
        JsonObjectRes.Add('eway_bill_status', '');
        JsonObjectRes.Add('auto_print', 'N');
        JsonObjectRes.Add('email', '');
        // JsonObjectRes.Add('delete_record', 'N');

        JsonObjectRes.Add('itemList', JsonArrayItem);
        JsonObjectRes.WriteTo(Payload);

        exit(Payload);
    end;

    procedure UpdateVehicleJson(DocNo: Code[50];
        eway_bill_number: Text;
        TransporterDetails: Boolean) JsonBody: Text;

    var
        JsonObjectRes: JsonObject;
        Transporter: Record Vendor;
        userGstin: Code[15];
        CU50061: Codeunit 50061;
        TransName: Text;
        transporter_document_number: Code[100];
        transporter_document_date: Date;
        mode_of_transport: Text;
    begin
        "Detailed GST Ledger Entry".Reset();
        "Detailed GST Ledger Entry".SetRange("Document No.", DocNo);
        "Detailed GST Ledger Entry".SetFilter("Document Type", '%1|%2', "Detailed GST Ledger Entry"."Document Type"::Invoice, "Detailed GST Ledger Entry"."Document Type"::"Credit Memo");
        "Detailed GST Ledger Entry".SetRange("Entry Type", "Detailed GST Ledger Entry"."Entry Type"::"Initial Entry");
        "Detailed GST Ledger Entry".SetRange("GST Group Type", "Detailed GST Ledger Entry"."GST Group Type"::Goods);
        "Detailed GST Ledger Entry".SetFilter(Type, '%1|%2|%3', "Detailed GST Ledger Entry".Type::"Fixed Asset", "Detailed GST Ledger Entry".Type::Item, "Detailed GST Ledger Entry".Type::"G/L Account");
        "Detailed GST Ledger Entry".FindFirst();
        ClearVariables();
        GetSupplySubDocType();
        Clear(JsonObjectRes);

        GetTransporterDetails(userGstin, TransName, transporter_document_number, transporter_document_date, mode_of_transport);

        if not TransporterDetails then begin
            JsonObjectRes.Add('access_token', CU50061.GetInfo('MIEWAY', DataScope::Module));
            //JsonObjectRes.Add('userGstin', userGstin);//For Testing
            JsonObjectRes.Add('userGstin', GetFromGSTIN());
            //JsonObjectRes.Add('userGstin', '05AAABC0181E1ZE');//For Testing
            JsonObjectRes.Add('eway_bill_number', eway_bill_number);
            JsonObjectRes.Add('vehicle_number', GetVehicleNo());
            JsonObjectRes.Add('vehicle_type', GetVehicleType());
            JsonObjectRes.Add('place_of_consignor', GetPlaceState());
            //JsonObjectRes.Add('place_of_consignor', 'Chamoli');
            JsonObjectRes.Add('state_of_consignor', GetFromState());
            //JsonObjectRes.Add('state_of_consignor', 'Uttarakhand');//For testing
            JsonObjectRes.Add('reason_code_for_vehicle_updation', 'due to break down');
            JsonObjectRes.Add('reason_for_vehicle_updation', 'Vehicle Breakdown');
            JsonObjectRes.Add('transporter_document_number', transporter_document_number);
            JsonObjectRes.Add('transporter_document_date', transporter_document_date);
            JsonObjectRes.Add('mode_of_transport', mode_of_transport);
            JsonObjectRes.Add('data_source', 'erp');
            JsonObjectRes.WriteTo(JsonBody);
        end else begin
            if userGstin = URPTxt then begin
                Message('Transporter Unregistered');
                Exit;
            end;

            JsonObjectRes.Add('access_token', CU50061.GetInfo('MIEWAY', DataScope::Module));
            //JsonObjectRes.Add('userGstin', userGstin);//For Testing
            JsonObjectRes.Add('userGstin', GetFromGSTIN());
            //JsonObjectRes.Add('userGstin', '05AAABC0181E1ZE');//For Testing
            JsonObjectRes.Add('eway_bill_number', eway_bill_number);
            JsonObjectRes.Add('transporter_id', userGstin);
            JsonObjectRes.WriteTo(JsonBody);
        end;
    end;



    procedure GetRequestJsonEwayBillByIRN(DocumentNumber: Text): Text
    var
        JsonObjectRes: JsonObject;
        JsonObjectItem: JsonObject;
        JsonArrayItem: JsonArray;
        Payload: Text;
        DocumentLineNo: Integer;
        OriginalInvoiceNo: Code[20];
        ItemChargeAssgnLineNo: Integer;
        DetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry";
        // DelGSTLedgerEntryInfoCount: Integer;
        // DetailedGSTLedgerEntryCount: Integer;
        JsonObjectDispatchDetail: JsonObject;
        JsonObjectShipDetail: JsonObject;
        SalesInvoiceHeader: Record "Sales Invoice Header";
        DispatchShippingAgent: Record "Shipping Agent";
        State: Record State;
        DispatchStateCode: Code[10];
        DispatchState: Code[10];
        ToState: Code[10];
        DistanceTxt: Text;
        DistanceDec: Decimal;
        FromPinCode: Code[20];
        ToPinCode: Code[20];
        TransID: Code[15];
        TransName: Text[100];
        LRNo: Code[100];
        LRDate: Date;
        TransMode: Text[20];
    begin
        DocumentNo := DocumentNumber;
        ClearVariables();
        SalesInvoiceHeader.Reset();
        SalesInvoiceHeader.SetRange("No.", DocumentNumber);
        SalesInvoiceHeader.FindFirst();

        TransType := TransType::Sales;
        SourceType := SourceType::Customer;

        "Detailed GST Ledger Entry".Reset();
        "Detailed GST Ledger Entry".SetRange("Document No.", DocumentNo);
        "Detailed GST Ledger Entry".SetRange("Document Type", DetailedGSTLedgerEntry."Document Type"::Invoice);
        "Detailed GST Ledger Entry".SetRange("Entry Type", DetailedGSTLedgerEntry."Entry Type"::"Initial Entry");
        "Detailed GST Ledger Entry".SetRange("GST Group Type", DetailedGSTLedgerEntry."GST Group Type"::Goods);
        "Detailed GST Ledger Entry".SetFilter(Type, '%1|%2|%1', DetailedGSTLedgerEntry.Type::"Fixed Asset", DetailedGSTLedgerEntry.Type::Item, DetailedGSTLedgerEntry.Type::"G/L Account");
        "Detailed GST Ledger Entry".FindFirst();
        DelGSTLedgerEntryInfo.Get("Detailed GST Ledger Entry"."Entry No.");
        InitializeVariables();
        // DelGSTLedgerEntryInfoCount := "Detailed GST Ledger Entry".Count();
        // DelGSTLedgerEntryInfoCount := DelGSTLedgerEntryInfo.Count();


        Clear(JsonObjectRes);
        Clear(JsonArrayItem);
        Clear(Payload);

        GetSupplySubDocType();
        GetGSTAmount(DocumentNumber);
        FromPinCode := GetPostCode();
        ToPinCode := GetToPostCode();
        DistanceDec := GetDistance(FromPinCode, ToPinCode);

        JsonObjectRes.Add('user_gstin', GetFromGSTIN());
        JsonObjectRes.Add('irn', SalesInvoiceHeader."IRN Hash");
        GetTransporterDetails(TransID, TransName, LRNo, LRDate, TransMode);
        JsonObjectRes.Add('transporter_id', TransID);
        JsonObjectRes.Add('transporter_name', TransName);
        JsonObjectRes.Add('transporter_document_number', LRNo);
        JsonObjectRes.Add('transporter_document_date', LRDate);
        JsonObjectRes.Add('transportation_mode', TransMode);
        JsonObjectRes.Add('vehicle_number', GetVehicleNo());
        JsonObjectRes.Add('distance', FORMAT(DistanceDec, 0, '<Integer>'));
        JsonObjectRes.Add('vehicle_type', GetVehicleType());
        JsonObjectRes.Add('transporter_name', GetTransName());
        JsonObjectRes.Add('data_source', 'erp');


        DispatchShippingAgent.Get(SalesInvoiceHeader."Shipping Agent Code");

        // if State.Get(DispatchShippingAgent."State") then
        //     DispatchState := State."State Code (GST Reg. No.)";

        JsonObjectDispatchDetail.Add('company_name', DispatchShippingAgent."Name");
        JsonObjectDispatchDetail.Add('address1', DispatchShippingAgent."Internet Address");
        JsonObjectDispatchDetail.Add('address2', '');
        JsonObjectDispatchDetail.Add('location', '');
        JsonObjectDispatchDetail.Add('pincode', '');
        JsonObjectDispatchDetail.Add('state_code', DispatchState);
        JsonObjectRes.Add('dispatch_details', JsonObjectDispatchDetail);

        JsonObjectShipDetail.Add('address1', GetToAddress(true));
        JsonObjectShipDetail.Add('address2', GetToAddress(false));
        JsonObjectShipDetail.Add('location', GetToPlace());
        JsonObjectShipDetail.Add('pincode', GetToPostCode());
        JsonObjectShipDetail.Add('state_code', GetToState());
        JsonObjectRes.Add('ship_details', JsonObjectShipDetail);

        JsonObjectRes.WriteTo(Payload);

        exit(Payload);
    end;

    local procedure ClearVariables()
    begin
        SubType := SubType::" ";
        DocType := DocType::" ";
        ServiceDoc := false;
        CGSTAmount := 0;
        SGSTAmount := 0;
        IGSTAmount := 0;
        CessAmount := 0;
        CessNonAdvolAmount := 0;
        TotalInvoiceValue := 0;
    end;

    local procedure InitializeVariables()
    var
        ServInvDoc: Boolean;
        ServCrMemoDoc: Boolean;
    begin
        if "Detailed GST Ledger Entry"."Source Type" = "Detailed GST Ledger Entry"."Source Type"::Customer then
            if DelGSTLedgerEntryInfo."Ship-to Code" <> '' then
                ShipToAddress.Get("Detailed GST Ledger Entry"."Source No.", DelGSTLedgerEntryInfo."Ship-to Code")
            else
                Customer.Get("Detailed GST Ledger Entry"."Source No.")
        else
            if "Detailed GST Ledger Entry"."Source Type" = "Source Type"::Vendor then
                if DelGSTLedgerEntryInfo."Order Address Code" <> '''''' then begin
                    IF OrderAddress.get("Detailed GST Ledger Entry"."Source No.", DelGSTLedgerEntryInfo."Order Address Code") then;
                end else
                    Vendor.Get("Detailed GST Ledger Entry"."Source No.");

        if "Detailed GST Ledger Entry"."Source Type" = "Detailed GST Ledger Entry"."Source Type"::Vendor then
            if DelGSTLedgerEntryInfo."Bill to-Location(POS)" <> '' then
                Location.Get(DelGSTLedgerEntryInfo."Bill to-Location(POS)")
            else
                if "Detailed GST Ledger Entry"."Location Code" <> '' then
                    Location.Get("Detailed GST Ledger Entry"."Location Code")
                else
                    CompanyInformation.Get();

        if "Detailed GST Ledger Entry"."Source Type" = "Detailed GST Ledger Entry"."Source Type"::Customer then
            if "Detailed GST Ledger Entry"."Location Code" <> '' then
                Location.Get("Detailed GST Ledger Entry"."Location Code")
            else
                CompanyInformation.Get();

        if "Detailed GST Ledger Entry".Type = "Detailed GST Ledger Entry".Type::Item then
            Item.Get("Detailed GST Ledger Entry"."No.")
        else
            if "Detailed GST Ledger Entry".Type = "Detailed GST Ledger Entry".Type::"Fixed Asset" then
                FixedAsset.Get("Detailed GST Ledger Entry"."No.");

        if "Detailed GST Ledger Entry"."TransAction Type" = "Detailed GST Ledger Entry"."TransAction Type"::Sales then begin
            if ("Detailed GST Ledger Entry"."Document Type" = "Detailed GST Ledger Entry"."Document Type"::Invoice) and
                ServiceInvoiceHeader.Get("Detailed GST Ledger Entry"."Document No.") then
                ServInvDoc := true;

            if ("Detailed GST Ledger Entry"."Document Type" = "Detailed GST Ledger Entry"."Document Type"::"Credit Memo") and
                ServiceCrMemoHeader.Get("Detailed GST Ledger Entry"."Document No.") then
                ServCrMemoDoc := true;

            if ServInvDoc or ServCrMemoDoc then
                ServiceDoc := true;
        end;
    end;

    local procedure GetSupplySubDocType()
    begin
        if "Detailed GST Ledger Entry"."TransAction Type" = "Detailed GST Ledger Entry"."TransAction Type"::Sales then
            if "Detailed GST Ledger Entry"."Document Type" = "Detailed GST Ledger Entry"."Document Type"::"Credit Memo" then begin
                SupplyType := SupplyType::Inward;
                SubType := SubType::"Sales Returns";
                DocType := DocType::"Credit Note";
            end else
                if "Detailed GST Ledger Entry"."Document Type" = "Detailed GST Ledger Entry"."Document Type"::Invoice then begin
                    SupplyType := SupplyType::Outward;
                    case "Detailed GST Ledger Entry"."GST Customer Type" of
                        "Detailed GST Ledger Entry"."GST Customer Type"::"Deemed Export",
                        "Detailed GST Ledger Entry"."GST Customer Type"::"SEZ Development",
                           "Detailed GST Ledger Entry"."GST Customer Type"::"SEZ Unit",
                           "Detailed GST Ledger Entry"."GST Customer Type"::Registered:
                            begin
                                SubType := SubType::Supply;
                                DelGSTLedgerEntryInfo.Get("Detailed GST Ledger Entry"."Entry No.");
                                If DelGSTLedgerEntryInfo."Sales Invoice Type" in [DelGSTLedgerEntryInfo."Sales Invoice Type"::"Bill of Supply"] then
                                    DocType := DocType::"Bill of Supply";
                                If DelGSTLedgerEntryInfo."Sales Invoice Type" in [DelGSTLedgerEntryInfo."Sales Invoice Type"::Taxable] then
                                    DocType := DocType::"Tax Invoice";
                                //DocType := DocType::"Tax Invoice";
                            end;

                        "Detailed GST Ledger Entry"."GST Customer Type"::Exempted:
                            begin
                                SubType := SubType::Supply;
                                DocType := DocType::"Bill of Supply";
                            end;

                        "Detailed GST Ledger Entry"."GST Customer Type"::Export:
                            begin
                                SubType := SubType::Export;
                                DocType := DocType::"Tax Invoice";
                            end;

                        "Detailed GST Ledger Entry"."GST Customer Type"::Unregistered:
                            begin
                                SubType := SubType::"Recipient Not Known";
                                DocType := DocType::"Tax Invoice";
                            end;
                    end;
                end;
        if "Detailed GST Ledger Entry"."TransAction Type" = "Detailed GST Ledger Entry"."TransAction Type"::Purchase then
            if ("Detailed GST Ledger Entry"."Document Type" = "Detailed GST Ledger Entry"."Document Type"::"Credit Memo") and
               ("Detailed GST Ledger Entry"."GST Vendor Type" in [
                    "Detailed GST Ledger Entry"."GST Vendor Type"::Registered,
                    "Detailed GST Ledger Entry"."GST Vendor Type"::SEZ,
                    "Detailed GST Ledger Entry"."GST Vendor Type"::Exempted,
                    "Detailed GST Ledger Entry"."GST Vendor Type"::Composite,
                    "Detailed GST Ledger Entry"."GST Vendor Type"::Unregistered])
            then begin
                SupplyType := SupplyType::Outward;
                SubType := SubType::Supply;
                DocType := DocType::"Tax Invoice";
            end else
                if "Detailed GST Ledger Entry"."Document Type" = "Detailed GST Ledger Entry"."Document Type"::Invoice then begin
                    SupplyType := SupplyType::Inward;
                    case "Detailed GST Ledger Entry"."GST Vendor Type" of
                        "Detailed GST Ledger Entry"."GST Vendor Type"::Registered,
                        "Detailed GST Ledger Entry"."GST Vendor Type"::SEZ,
                        "Detailed GST Ledger Entry"."GST Vendor Type"::Unregistered:
                            begin
                                SubType := SubType::Supply;
                                DocType := DocType::"Tax Invoice";
                            end;

                        "Detailed GST Ledger Entry"."GST Vendor Type"::Exempted,
                        "Detailed GST Ledger Entry"."GST Vendor Type"::Composite:
                            begin
                                SubType := SubType::Supply;
                                DocType := DocType::"Bill of Supply";
                            end;


                        "Detailed GST Ledger Entry"."GST Vendor Type"::Import:
                            begin
                                SubType := SubType::Import;
                                DocType := DocType::"Bill of Entry";
                            end;
                    end;
                end;
    end;

    local procedure GetFromOtherPartyName() FromOtherPartyName: Text[50]
    begin
        Companyinfo.get;
        if SupplyType = SupplyType::Inward then
            case SubType of
                SubType::Supply, SubType::Import:
                    if "Detailed GST Ledger Entry"."Source Type" = "Detailed GST Ledger Entry"."Source Type"::Vendor then
                        if DelGSTLedgerEntryInfo."Order Address Code" <> '''''' then
                            FromOtherPartyName := CopyStr(OrderAddress.Name, 1, 50)
                        else
                            FromOtherPartyName := CopyStr(Vendor.Name, 1, 50);

                SubType::"Sales Returns":
                    if "Detailed GST Ledger Entry"."Source Type" = "Detailed GST Ledger Entry"."Source Type"::Customer then
                        if DelGSTLedgerEntryInfo."Ship-to Code" <> '' then
                            FromOtherPartyName := CopyStr(ShipToAddress.Name, 1, 50)
                        else
                            FromOtherPartyName := CopyStr(Customer.Name, 1, 50);
            end;

        if SupplyType = SupplyType::Outward then
            if SubType in [SubType::Supply, SubType::Export, SubType::"Recipient Not Known", SubType::Others] then
                if "Detailed GST Ledger Entry"."Source Type" = "Detailed GST Ledger Entry"."Source Type"::" " then begin
                    TransferShipmentHeader.Get("Detailed GST Ledger Entry"."Document No.");
                    Location.Get(TransferShipmentHeader."Transfer-from Code");

                    FromOtherPartyName := CopyStr(Companyinfo.Name, 1, 50);
                end else
                    if "Detailed GST Ledger Entry"."Location Code" <> '' then
                        FromOtherPartyName := CopyStr(Companyinfo.Name, 1, 50)
                    else
                        FromOtherPartyName := CopyStr(Companyinfo.Name, 1, 50);
    end;

    local procedure GetFromGSTIN() FromGSTIN: Code[15]
    begin
        if SupplyType = SupplyType::Inward then
            if "Detailed GST Ledger Entry"."GST Vendor Type" = "Detailed GST Ledger Entry"."GST Vendor Type"::Unregistered then
                FromGSTIN := URPTxt
            else
                if "Detailed GST Ledger Entry"."GST Customer Type" = "Detailed GST Ledger Entry"."GST Customer Type"::Unregistered then
                    FromGSTIN := URPTxt
                else
                    FromGSTIN := CopyStr("Detailed GST Ledger Entry"."Buyer/Seller Reg. No.", 1, 15)
        else
            FromGSTIN := CopyStr("Detailed GST Ledger Entry"."Location  Reg. No.", 1, 15);
    end;

    local procedure GetFromAddress(Address1: Boolean) FromAddress: Text[50]
    begin
        if SupplyType = SupplyType::Inward then
            case SubType of
                SubType::Supply, SubType::Import:
                    if "Detailed GST Ledger Entry"."Source Type" = "Detailed GST Ledger Entry"."Source Type"::Vendor then
                        if DelGSTLedgerEntryInfo."Order Address Code" <> '''''' then
                            if Address1 then
                                FromAddress := CopyStr(OrderAddress.Address, 1, 50)
                            else
                                FromAddress := OrderAddress."Address 2"
                        else
                            if Address1 then
                                FromAddress := CopyStr(Vendor.Address, 1, 50)
                            else
                                FromAddress := Vendor."Address 2";

                SubType::"Sales Returns":
                    if "Detailed GST Ledger Entry"."Source Type" = "Detailed GST Ledger Entry"."Source Type"::Customer then
                        if DelGSTLedgerEntryInfo."Ship-to Code" <> '' then
                            if Address1 then
                                FromAddress := CopyStr(ShipToAddress.Address, 1, 50)
                            else
                                FromAddress := ShipToAddress."Address 2"
                        else
                            if Address1 then
                                FromAddress := CopyStr(Customer.Address, 1, 50)
                            else
                                FromAddress := Customer."Address 2"
                    else
                        if SubType in [SubType::Supply, SubType::Export, SubType::"Recipient Not Known", SubType::Others] then
                            if "Detailed GST Ledger Entry"."Source Type" = "Source Type"::" " then begin
                                TransferShipmentHeader.Get("Detailed GST Ledger Entry"."Document No.");
                                Location.Get(TransferShipmentHeader."Transfer-from Code");
                                if Address1 then
                                    FromAddress := CopyStr(Location.Address, 1, 50)
                                else
                                    FromAddress := Location."Address 2";
                            end else
                                if "Detailed GST Ledger Entry"."Location Code" <> '' then
                                    if Address1 then
                                        FromAddress := CopyStr(Location.Address, 1, 50)
                                    else
                                        FromAddress := Location."Address 2"
                                else
                                    if Address1 then
                                        FromAddress := CopyStr(CompanyInformation.Address, 1, 50)
                                    else
                                        FromAddress := CompanyInformation."Address 2";

            end;

        if SupplyType = SupplyType::Outward then
            if FromAddress = '' then
                if "Detailed GST Ledger Entry"."Location Code" <> '' then
                    if Address1 then
                        FromAddress := CopyStr(Location.Address, 1, 50)
                    else
                        FromAddress := Location."Address 2"
                else
                    if Address1 then
                        FromAddress := CopyStr(CompanyInformation.Address, 1, 50)
                    else
                        FromAddress := CompanyInformation."Address 2";

        if FromAddress <> '' then
            FromAddress := DelChr(FromAddress, '=', '/\');
    end;

    procedure GetPlaceState() FromPlace: Text[30]
    begin
        if SupplyType = SupplyType::Inward then
            case SubType of
                SubType::Supply, SubType::Import:
                    if "Detailed GST Ledger Entry"."Source Type" = "Detailed GST Ledger Entry"."Source Type"::Vendor then
                        if DelGSTLedgerEntryInfo."Order Address Code" <> '''''' then
                            FromPlace := OrderAddress.City
                        else
                            FromPlace := Vendor.City;

                SubType::"Sales Returns":
                    if "Detailed GST Ledger Entry"."Source Type" = "Detailed GST Ledger Entry"."Source Type"::Customer then
                        if DelGSTLedgerEntryInfo."Ship-to Code" <> '' then
                            FromPlace := ShipToAddress.City
                        else
                            FromPlace := Customer.City;
                else
                    if SubType in [SubType::Supply, SubType::Export, SubType::"Recipient Not Known", SubType::Others] then
                        if "Detailed GST Ledger Entry"."Source Type" = "Detailed GST Ledger Entry"."Source Type"::" " then begin
                            TransferShipmentHeader.Get("Detailed GST Ledger Entry"."Document No.");
                            Location.Get(TransferShipmentHeader."Transfer-from Code");
                            FromPlace := Location.City;
                        end else
                            if "Detailed GST Ledger Entry"."Location Code" <> '' then
                                FromPlace := Location.City
                            else
                                FromPlace := CompanyInformation.City;
            end;

        if SupplyType = SupplyType::Outward then
            if FromPlace = '' then begin
                if "Detailed GST Ledger Entry"."Location Code" <> '' then
                    FromPlace := Location.City
                else
                    FromPlace := CompanyInformation.City;
            end;

    end;

    local procedure GetTransactionType() TransactionType: Text[30]
    var
        DetailedGSTLedEntryInfo: Record "Detailed GST Ledger Entry Info";
    begin
        DetailedGSTLedEntryInfo.Get("Detailed GST Ledger Entry"."Entry No.");
        if DetailedGSTLedEntryInfo."Ship-to Code" <> '' then
            TransactionType := 'Bill To- Ship To'
        else
            TransactionType := 'Regular';

        // case "Detailed GST Ledger Entry"."GST Place of Supply" of
        //     "Detailed GST Ledger Entry"."GST Place of Supply"::"Bill-to Address":
        //         TransactionType := 'Regular';
        //     "Detailed GST Ledger Entry"."GST Place of Supply"::"Ship-to Address":
        //         TransactionType := 'Bill To- Ship To';
        // end;
        if "Detailed GST Ledger Entry"."Source Type" = "Detailed GST Ledger Entry"."Source Type"::Vendor then begin
            DetailedGSTLedEntryInfo.SetRange(DetailedGSTLedEntryInfo."Entry No.", "Detailed GST Ledger Entry"."Entry No.");
            if DetailedGSTLedEntryInfo.FindFirst() then
                if DetailedGSTLedEntryInfo."Order Address Code" <> '''''' then
                    TransactionType := 'Bill From- Dispatch From'
                else
                    TransactionType := 'Regular';
        end;
        if "Detailed GST Ledger Entry"."Source Type" = "Detailed GST Ledger Entry"."Source Type"::" " then
            TransactionType := 'Regular';


    end;

    local procedure GetPostCode() FromPostCode: Code[20]
    begin
        if SupplyType = SupplyType::Inward then
            case SubType of
                SubType::Supply, SubType::Import:
                    if "Detailed GST Ledger Entry"."Source Type" = "Detailed GST Ledger Entry"."Source Type"::Vendor then
                        if DelGSTLedgerEntryInfo."Order Address Code" <> '''''' then
                            FromPostCode := OrderAddress."Post Code"
                        else
                            FromPostCode := Vendor."Post Code";

                SubType::"Sales Returns":
                    if "Detailed GST Ledger Entry"."Source Type" = "Detailed GST Ledger Entry"."Source Type"::Customer then
                        if DelGSTLedgerEntryInfo."Ship-to Code" <> '' then
                            FromPostCode := ShipToAddress."Post Code"
                        else
                            FromPostCode := Customer."Post Code";
                else
                    if SubType in [SubType::Supply, SubType::Export, SubType::"Recipient Not Known", SubType::Others] then
                        if "Detailed GST Ledger Entry"."Source Type" = "Detailed GST Ledger Entry"."Source Type"::" " then begin
                            TransferShipmentHeader.Get("Detailed GST Ledger Entry"."Document No.");
                            Location.Get(TransferShipmentHeader."Transfer-from Code");
                            FromPostCode := Location."Post Code";
                        end else
                            if "Detailed GST Ledger Entry"."Location Code" <> '' then
                                FromPostCode := Location."Post Code"
                            else
                                FromPostCode := CompanyInformation."Post Code";
            end;

        if SupplyType = SupplyType::Outward then
            if FromPostCode = '' then
                if "Detailed GST Ledger Entry"."Location Code" <> '' then
                    FromPostCode := Location."Post Code"
                else
                    FromPostCode := CompanyInformation."Post Code";
    end;

    procedure GetFromState() FromState: Text[50]
    var
        ShipToAdd: Record "Ship-to Address";
        State: Record State;
        FromStateCode: Code[10];
    begin
        if SupplyType = SupplyType::Inward then
            case SubType of
                SubType::Supply:
                    FromStateCode := DelGSTLedgerEntryInfo."Buyer/Seller State Code";

                SubType::"Sales Returns":
                    if DelGSTLedgerEntryInfo."Ship-to Code" <> '' then
                        if "Detailed GST Ledger Entry"."GST Customer Type" in [
                            "Detailed GST Ledger Entry"."GST Customer Type"::"Deemed Export",
                            "Detailed GST Ledger Entry"."GST Customer Type"::"SEZ Development",
                            "Detailed GST Ledger Entry"."GST Customer Type"::"SEZ Unit"]
                        then begin
                            ShipToAddress.Get("Detailed GST Ledger Entry"."Source No.", DelGSTLedgerEntryInfo."Ship-to Code");
                            FromStateCode := ShipToAdd.State;
                        end else
                            FromStateCode := DelGSTLedgerEntryInfo."Shipping Address State Code";
                else
                    if "Detailed GST Ledger Entry"."GST Customer Type" in [
                        "Detailed GST Ledger Entry"."GST Customer Type"::"Deemed Export",
                        "Detailed GST Ledger Entry"."GST Customer Type"::"SEZ Development",
                        "Detailed GST Ledger Entry"."GST Customer Type"::"SEZ Unit"]
                    then begin
                        Customer.Get("Detailed GST Ledger Entry"."Source No.");
                        FromStateCode := Customer."State Code";
                    end else
                        FromStateCode := DelGSTLedgerEntryInfo."Buyer/Seller State Code";
            end
        else
            if SubType in [SubType::Supply, SubType::Export, SubType::"Recipient Not Known", SubType::Others] then
                FromStateCode := DelGSTLedgerEntryInfo."Location State Code";

        if State.Get(FromStateCode) then
            FromState := State.Description;
    end;

    local procedure GetToOtherPartyName() ToOtherPartyName: Text[50]
    begin
        Companyinfo.Get;
        if SupplyType = SupplyType::Inward then
            if SubType in [SubType::Supply, SubType::Import, SubType::"Sales Returns"] then
                if "Detailed GST Ledger Entry"."Location Code" <> '' then
                    ToOtherPartyName := CopyStr(Location.Name, 1, 50)
                else
                    ToOtherPartyName := CopyStr(CompanyInformation.Name, 1, 50);

        if SupplyType = SupplyType::Outward then
            case SubType of
                SubType::Supply, SubType::Export, SubType::"Recipient Not Known":
                    if "Detailed GST Ledger Entry"."Transaction Type" = "Detailed GST Ledger Entry"."Transaction Type"::Sales Then begin
                        if "Detailed GST Ledger Entry"."Source Type" = "Detailed GST Ledger Entry"."Source Type"::Customer then
                            if DelGSTLedgerEntryInfo."Ship-to Code" <> '' then
                                ToOtherPartyName := CopyStr(ShipToAddress.Name, 1, 50)
                            else
                                ToOtherPartyName := CopyStr(Customer.Name, 1, 50)
                        else
                            if "Detailed GST Ledger Entry"."Source Type" = "Detailed GST Ledger Entry"."Source Type"::" " then begin
                                TransferShipmentHeader.Get("Detailed GST Ledger Entry"."Document No.");
                                Location.Get(TransferShipmentHeader."Transfer-to Code");
                                ToOtherPartyName := CopyStr(Companyinfo.Name, 1, 50)
                            end;
                    End else
                        if "Detailed GST Ledger Entry"."Source Type" = "Detailed GST Ledger Entry"."Source Type"::Vendor then
                            if DelGSTLedgerEntryInfo."Order Address Code" <> '''''' then
                                ToOtherPartyName := CopyStr(OrderAddress.Name, 1, 50)
                            else
                                ToOtherPartyName := CopyStr(Vendor.Name, 1, 50);



                SubType::Others:
                    if "Detailed GST Ledger Entry"."Source Type" = "Detailed GST Ledger Entry"."Source Type"::Vendor then
                        if DelGSTLedgerEntryInfo."Order Address Code" <> '''''' then
                            ToOtherPartyName := CopyStr(OrderAddress.Name, 1, 50)
                        else
                            ToOtherPartyName := CopyStr(Vendor.Name, 1, 50);
            end;
    end;

    local procedure GetToGSTIN() ToGSTIN: Code[15]
    begin
        if SupplyType = SupplyType::Inward then
            ToGSTIN := CopyStr("Detailed GST Ledger Entry"."Location  Reg. No.", 1, 15)
        else
            case SubType of
                SubType::Supply:
                    ToGSTIN := CopyStr("Detailed GST Ledger Entry"."Buyer/Seller Reg. No.", 1, 15);
                SubType::"Recipient Not Known", SubType::Export:
                    ToGSTIN := URPTxt;
                SubType::Others:
                    if "Detailed GST Ledger Entry"."GST Vendor Type" = "Detailed GST Ledger Entry"."GST Vendor Type"::Unregistered then
                        ToGSTIN := URPTxt
                    else
                        ToGSTIN := CopyStr("Detailed GST Ledger Entry"."Buyer/Seller Reg. No.", 1, 15);
            end;
    end;

    local procedure GetToAddress(ToAddress1: Boolean) ToAddress: Text[50]
    begin
        if SupplyType = SupplyType::Inward then
            if SubType in [SubType::Supply, SubType::Import, SubType::"Sales Returns"] then
                if "Detailed GST Ledger Entry"."Location Code" <> '' then
                    if ToAddress1 then
                        ToAddress := CopyStr(Location.Address, 1, 50)
                    else
                        ToAddress := CopyStr(Location."Address 2", 1, 50)
                else
                    if ToAddress1 then
                        ToAddress := CopyStr(CompanyInformation.Address, 1, 50)
                    else
                        ToAddress := CompanyInformation."Address 2";

        if SupplyType = SupplyType::Outward then
            case SubType of
                SubType::Supply, SubType::Export, SubType::"Recipient Not Known":
                    if "Detailed GST Ledger Entry"."Transaction Type" = "Detailed GST Ledger Entry"."Transaction Type"::Sales Then Begin
                        if "Detailed GST Ledger Entry"."Source Type" = "Detailed GST Ledger Entry"."Source Type"::" " then begin
                            TransferShipmentHeader.Get("Detailed GST Ledger Entry"."Document No.");
                            Location.Get(TransferShipmentHeader."Transfer-to Code");
                            if ToAddress1 then
                                ToAddress := CopyStr(Location.Address, 1, 50)
                            else
                                ToAddress := CopyStr(Location."Address 2", 1, 50)
                        end else
                            if DelGSTLedgerEntryInfo."Ship-to Code" <> '' then
                                if ToAddress1 then
                                    ToAddress := CopyStr(ShipToAddress.Address, 1, 50)
                                else
                                    ToAddress := ShipToAddress."Address 2"
                            else
                                if ToAddress1 then
                                    ToAddress := CopyStr(Customer.Address, 1, 50)
                                else
                                    ToAddress := Customer."Address 2";
                    End Else
                        if DelGSTLedgerEntryInfo."Order Address Code" <> '''''' then
                            if ToAddress1 then
                                ToAddress := CopyStr(OrderAddress.Address, 1, 50)
                            else
                                ToAddress := OrderAddress."Address 2"
                        else
                            if ToAddress1 then
                                ToAddress := CopyStr(Vendor.Address, 1, 50)
                            else
                                ToAddress := Vendor."Address 2";


                SubType::Others:
                    if DelGSTLedgerEntryInfo."Order Address Code" <> '''''' then
                        if ToAddress1 then
                            ToAddress := CopyStr(OrderAddress.Address, 1, 50)
                        else
                            ToAddress := OrderAddress."Address 2"
                    else
                        if ToAddress1 then
                            ToAddress := CopyStr(Vendor.Address, 1, 50)
                        else
                            ToAddress := Vendor."Address 2";
            end;
    end;

    local procedure GetToPlace() ToPlace: Text[30]
    begin
        if SupplyType = SupplyType::Inward then
            if SubType in [SubType::Supply, SubType::Import, SubType::"Sales Returns"] then
                if "Detailed GST Ledger Entry"."Location Code" <> '' then
                    ToPlace := Location.City
                else
                    ToPlace := CompanyInformation.City;

        if SupplyType = SupplyType::Outward then
            case SubType of
                SubType::Supply, SubType::Export, SubType::"Recipient Not Known":
                    if "Detailed GST Ledger Entry"."Transaction Type" = "Detailed GST Ledger Entry"."Transaction Type"::Sales Then Begin
                        if "Detailed GST Ledger Entry"."Source Type" = "Detailed GST Ledger Entry"."Source Type"::" " then begin
                            TransferShipmentHeader.Get("Detailed GST Ledger Entry"."Document No.");
                            Location.Get(TransferShipmentHeader."Transfer-to Code");
                            ToPlace := Location.City;
                        end else
                            if DelGSTLedgerEntryInfo."Ship-to Code" <> '' then
                                ToPlace := ShipToAddress.City
                            else
                                ToPlace := Customer.City;
                    End Else
                        if DelGSTLedgerEntryInfo."Order Address Code" <> '''''' then
                            ToPlace := OrderAddress.City
                        else
                            ToPlace := Vendor.City;

                SubType::Others:
                    if DelGSTLedgerEntryInfo."Order Address Code" <> '''''' then
                        ToPlace := OrderAddress.City
                    else
                        ToPlace := Vendor.City;
            end;
    end;

    local procedure GetToPostCode() ToPostCode: Code[20]
    begin
        if SupplyType = SupplyType::Inward then
            if SubType in [SubType::Supply, SubType::Import, SubType::"Sales Returns"] then
                if "Detailed GST Ledger Entry"."Location Code" <> '' then
                    ToPostCode := Location."Post Code"
                else
                    ToPostCode := CompanyInformation."Post Code";

        if SupplyType = SupplyType::Outward then
            case SubType of
                SubType::Supply, SubType::Export, SubType::"Recipient Not Known":
                    if "Detailed GST Ledger Entry"."Transaction Type" = "Detailed GST Ledger Entry"."Transaction Type"::Sales Then Begin
                        if "Detailed GST Ledger Entry"."Source Type" = "Detailed GST Ledger Entry"."Source Type"::" " then begin
                            TransferShipmentHeader.Get("Detailed GST Ledger Entry"."Document No.");
                            Location.Get(TransferShipmentHeader."Transfer-to Code");
                            ToPostCode := Location."Post Code";
                        end else
                            if (DelGSTLedgerEntryInfo."Ship-to Code" <> '') then
                                ToPostCode := ShipToAddress."Post Code"
                            else
                                ToPostCode := Customer."Post Code";

                    End Else
                        if DelGSTLedgerEntryInfo."Order Address Code" <> '''''' then
                            ToPostCode := OrderAddress."Post Code"
                        else
                            ToPostCode := Vendor."Post Code";


                SubType::Others:
                    if DelGSTLedgerEntryInfo."Order Address Code" <> '''''' then
                        ToPostCode := OrderAddress."Post Code"
                    else
                        ToPostCode := Vendor."Post Code";
            end;
    end;

    local procedure GetToState() ToState: Text[50]
    var
        State: Record State;
        ToStateCode: Code[10];

    begin
        if SupplyType = SupplyType::Inward then
            if SubType in [SubType::Supply, SubType::"Sales Returns"] then
                ToStateCode := DelGSTLedgerEntryInfo."Location State Code"
            else
                if SubType = SubType::Import then
                    ToStateCode := '';

        if SupplyType = SupplyType::Outward then
            case SubType of
                SubType::Supply, SubType::"Recipient Not Known", SubType::Others:
                    if DelGSTLedgerEntryInfo."Ship-to Code" <> '' then begin
                        ShipToAddress.Get("Detailed GST Ledger Entry"."Source No.", DelGSTLedgerEntryInfo."Ship-to Code");
                        ToStateCode := ShipToAddress.State;
                    End else
                        ToStateCode := DelGSTLedgerEntryInfo."Buyer/Seller State Code";

                SubType::Export:
                    if DelGSTLedgerEntryInfo."Ship-to Code" <> '' then begin
                        ShipToAddress.Get("Detailed GST Ledger Entry"."Source No.", DelGSTLedgerEntryInfo."Ship-to Code");
                        ToStateCode := ShipToAddress.State;
                    end else begin
                        Customer.Get("Detailed GST Ledger Entry"."Source No.");
                        ToStateCode := Customer."State Code";
                    end;
            end;
        if State.Get(ToStateCode) then
            ToState := State.Description;
    end;

    local procedure GetUOM() UOMDesc: Text[10]
    var
        SalesInvoiceLine: Record "Sales Invoice Line";
        SalesCrMemoLine: Record "Sales Cr.Memo Line";
        UnitOfMeasure: Record "Unit of Measure";
        TransferShipmentLine: Record "Transfer Shipment Line";
        PurchInvLine: Record "Purch. Inv. Line";
        PurchCrMemoLine: Record "Purch. Cr. Memo Line";
    begin
        if "Detailed GST Ledger Entry"."TransAction Type" = "Detailed GST Ledger Entry"."TransAction Type"::Sales then begin
            if "Detailed GST Ledger Entry"."Document Type" = "Detailed GST Ledger Entry"."Document Type"::Invoice then
                if "Detailed GST Ledger Entry"."Source Type" = "Detailed GST Ledger Entry"."Source Type"::Customer then begin
                    if SalesInvoiceLine.Get("Detailed GST Ledger Entry"."Document No.", "Detailed GST Ledger Entry"."Document Line No.") then
                        if UnitOfMeasure.Get(SalesInvoiceLine."Unit of Measure Code") then
                            UOMDesc := CopyStr(UnitOfMeasure.Description, 1, 10)
                end else
                    if "Detailed GST Ledger Entry"."Source Type" = "Detailed GST Ledger Entry"."Source Type"::" " then begin
                        TransferShipmentLine.Get("Detailed GST Ledger Entry"."Document No.", "Detailed GST Ledger Entry"."Document Line No.");
                        if UnitOfMeasure.Get(TransferShipmentLine."Unit of Measure Code") then
                            UOMDesc := CopyStr(UnitOfMeasure.Description, 1, 10)
                    end;

            if "Detailed GST Ledger Entry"."Document Type" = "Detailed GST Ledger Entry"."Document Type"::"Credit Memo" then
                if SalesCrMemoLine.Get("Detailed GST Ledger Entry"."Document No.", "Detailed GST Ledger Entry"."Document Line No.") then
                    if UnitOfMeasure.Get(SalesCrMemoLine."Unit of Measure Code") then
                        UOMDesc := CopyStr(UnitOfMeasure.Description, 1, 10);
        end else
            if "Detailed GST Ledger Entry"."TransAction Type" = "Detailed GST Ledger Entry"."TransAction Type"::Purchase then
                if "Detailed GST Ledger Entry"."Document Type" = "Detailed GST Ledger Entry"."Document Type"::Invoice then begin
                    PurchInvLine.Get("Detailed GST Ledger Entry"."Document No.", "Detailed GST Ledger Entry"."Document Line No.");
                    if UnitOfMeasure.Get(PurchInvLine."Unit of Measure Code") then
                        UOMDesc := CopyStr(UnitOfMeasure.Description, 1, 10);
                end else
                    if "Detailed GST Ledger Entry"."Document Type" = "Detailed GST Ledger Entry"."Document Type"::"Credit Memo" then begin
                        PurchCrMemoLine.Get("Detailed GST Ledger Entry"."Document No.", "Detailed GST Ledger Entry"."Document Line No.");
                        if UnitOfMeasure.Get(PurchCrMemoLine."Unit of Measure Code") then
                            UOMDesc := CopyStr(UnitOfMeasure.Description, 1, 10);
                    end;
    end;

    local procedure GetGSTAmount(DocNo: Code[50])
    var
        DetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry";
        DetailedGstLedgerEntryInfo: Record "Detailed GST Ledger Entry Info";
    begin
        DetailedGSTLedgerEntry.SetRange("Document Type", "Detailed GST Ledger Entry"."Document Type");
        DetailedGSTLedgerEntry.SetRange("Document No.", "Detailed GST Ledger Entry"."Document No.");
        DetailedGSTLedgerEntry.SetRange("Document Line No.", "Detailed GST Ledger Entry"."Document Line No.");
        if DetailedGSTLedgerEntry.FindSet() then
            repeat
                if DetailedGSTLedgerEntry."GST Component Code" = CGSTTxt then
                    CGSTAmount := DetailedGSTLedgerEntry."GST Amount";

                if DetailedGSTLedgerEntry."GST Component Code" = SGSTTxt then
                    SGSTAmount := DetailedGSTLedgerEntry."GST Amount";

                if DetailedGSTLedgerEntry."GST Component Code" = IGSTTxt then
                    IGSTAmount := DetailedGSTLedgerEntry."GST Amount";

                if DetailedGSTLedgerEntry."GST Component Code" = CESSTxt then
                    if DetailedGSTLedgerEntry."GST Customer Type" <> DetailedGSTLedgerEntry."GST Customer Type"::Exempted then begin
                        DetailedGstLedgerEntryInfo.SetRange("Entry No.", DetailedGSTLedgerEntry."Entry No.");
                        if DetailedGstLedgerEntryInfo.FindFirst() then
                            CessNonAdvolAmount := (DetailedGSTLedgerEntry.Quantity * DetailedGstLedgerEntryInfo."Cess Amount Per Unit Factor");

                        CESSAmount := ((DetailedGSTLedgerEntry."GST Amount") - (CessNonAdvolAmount));
                    end;
                GetTotalInvoiceValue(DetailedGSTLedgerEntry, DocNo);
            until DetailedGSTLedgerEntry.Next() = 0;
    end;
    //Function For Showing Other Charges In 'Others' Field
    local procedure GetOthersValue()
    var
        DetailedGstLedEntry: Record "Detailed GST Ledger Entry";
    begin
        if DetailGstLENo <> "Detailed GST Ledger Entry"."Document No." then begin
            Others := 0;
            DetailedGstLedEntry.SetRange("Document No.", "Detailed GST Ledger Entry"."Document No.");
            DetailedGstLedEntry.SetRange("GST Group Type", DetailedGstLedEntry."GST Group Type"::Service);
            if DetailedGstLedEntry.FindSet() then
                repeat
                    if ServiceNo <> DetailedGstLedEntry."No." then begin
                        Others += DetailedGstLedEntry."GST Base Amount";
                        ServiceNo := DetailedGstLedEntry."No.";
                    end;
                until DetailedGstLedEntry.Next() = 0;
            DetailGstLENo := DetailedGstLedEntry."Document No.";
            ServiceNo := '';
        end;
    end;

    local procedure GetTotalInvoiceValue(var DetailedGstLedgerEntry: Record "Detailed GST Ledger Entry"; DocNo: Code[50])
    var
        VendorLedgerEntry: Record "Vendor Ledger Entry";
        CustomerLedgerEntry: Record "Cust. Ledger Entry";
        TranshptLine: Record "Transfer Shipment Line";
        Item: Record Item;
        TaxValue: Decimal;
        location: record Location;
        location1: record Location;
        TaxrateValue: Record "Tax Rate Value";
        Intrastate: Boolean;
        TDSEntry: Record "TDS Entry";
        Invoiceamt: Decimal;
        GSTAmt: Decimal;

    begin
        Clear(Intrastate);
        if DetailedGstLedgerEntry."Transaction Type" = DetailedGstLedgerEntry."Transaction Type"::Purchase then begin
            VendorLedgerEntry.SetRange("Document No.", DetailedGstLedgerEntry."Document No.");
            if VendorLedgerEntry.Find('-') then
                VendorLedgerEntry.CalcFields("Amount (LCY)");
            TDSEntry.Reset();
            TDSEntry.SetRange("Document No.", DetailedGstLedgerEntry."Document No.");
            if TDSEntry.FindSet() then
                TDSEntry.CalcSums("TDS Amount");
            TotalInvoiceValue := VendorLedgerEntry."Amount (LCY)" - TDSEntry."TDS Amount";
        end
        else
            if DetailedGstLedgerEntry."Transaction Type" = DetailedGstLedgerEntry."Transaction Type"::Sales then begin
                CustomerLedgerEntry.SetRange("Document No.", DetailedGstLedgerEntry."Document No.");
                if CustomerLedgerEntry.Find('-') then begin
                    CustomerLedgerEntry.CalcFields("Amount (LCY)");
                    TotalInvoiceValue := CustomerLedgerEntry."Amount (LCY)";
                end else begin
                    TranshptLine.Reset();
                    TranshptLine.SetRange("Document No.", DocNo);
                    // TranshptLine.SetRange("Item No.", '<>%1', '');
                    if TranshptLine.FindSet() then
                        repeat
                            if location.get(TranshptLine."Transfer-from Code") then;
                            if location1.get(TranshptLine."Transfer-to Code") then;

                            if location."State Code" = location1."State Code" then
                                Intrastate := true;
                            if TranshptLine."GST Group Code" = '12%-GD' then begin
                                Invoiceamt += (TranshptLine.Amount * 1);
                                GSTAmt += (TranshptLine.Amount * 0.12);

                                if Intrastate then begin
                                    CGSTAmount += Round(TranshptLine.Amount * 0.06, 0.01, '=');
                                    SGSTAmount += CGSTAmount;
                                end;
                            end;
                            if TranshptLine."GST Group Code" = '18%-GD' then begin
                                Invoiceamt += (TranshptLine.Amount * 1);
                                GSTAmt += (TranshptLine.Amount * 0.18);
                                if Intrastate then begin
                                    CGSTAmount += Round(TranshptLine.Amount * 0.09, 0.01, '=');
                                    SGSTAmount += CGSTAmount;
                                end;
                            end;
                            if TranshptLine."GST Group Code" = '5%-GD' then begin
                                Invoiceamt += (TranshptLine.Amount * 1);
                                GSTAmt += (TranshptLine.Amount * 0.05);
                                if Intrastate then begin
                                    CGSTAmount += Round(TranshptLine.Amount * 0.025, 0.01, '=');
                                    SGSTAmount += CGSTAmount;
                                end;
                            end;
                            if TranshptLine."GST Group Code" = '28%-GD' then begin
                                //TotalInvoiceValue += (TranshptLine.Amount * 1.28);
                                Invoiceamt += (TranshptLine.Amount * 1);
                                GSTAmt += (TranshptLine.Amount * 0.28);
                                if Intrastate then begin
                                    CGSTAmount += Round(TranshptLine.Amount * 0.14, 0.01, '=');
                                    SGSTAmount += CGSTAmount;
                                end;
                            end;
                            TotalInvoiceValue := Invoiceamt + GSTAmt;

                        until TranshptLine.Next() = 0;

                end;

            end;

    end;


    local procedure GetTransMode() TransMode: Text[50]
    var
        SalesInvoiceHeader: Record "Sales Invoice Header";
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        PurchInvHeader: Record "Purch. Inv. Header";
        PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr.";
        TransportMethod: Record "Transport Method";
    begin
        if "Detailed GST Ledger Entry"."Transaction Type" = "Detailed GST Ledger Entry"."Transaction Type"::Sales then begin
            if "Detailed GST Ledger Entry"."Document Type" = "Detailed GST Ledger Entry"."Document Type"::Invoice then
                if "Detailed GST Ledger Entry"."Source Type" = "Detailed GST Ledger Entry"."Source Type"::Customer then begin
                    if SalesInvoiceHeader.Get("Detailed GST Ledger Entry"."Document No.") then
                        if TransportMethod.Get(SalesInvoiceHeader."Transport Method") then
                            TransMode := TransportMethod.Code;
                end else
                    if "Detailed GST Ledger Entry"."Source Type" = "Detailed GST Ledger Entry"."Source Type"::" " then begin
                        TransferShipmentHeader.Get("Detailed GST Ledger Entry"."Document No.");
                        if TransportMethod.Get(TransferShipmentHeader."Transport Method") then
                            TransMode := TransportMethod.Code;
                    end;

            if "Detailed GST Ledger Entry"."Document Type" = "Detailed GST Ledger Entry"."Document Type"::"Credit Memo" then
                if SalesCrMemoHeader.Get("Detailed GST Ledger Entry"."Document No.") then
                    if TransportMethod.Get(SalesCrMemoHeader."Transport Method") then
                        TransMode := TransportMethod.Code;
        end else
            if "Detailed GST Ledger Entry"."Transaction Type" = "Detailed GST Ledger Entry"."Transaction Type"::Purchase then
                if "Detailed GST Ledger Entry"."Document Type" = "Detailed GST Ledger Entry"."Document Type"::Invoice then begin
                    PurchInvHeader.Get("Detailed GST Ledger Entry"."Document No.");
                    if TransportMethod.Get(PurchInvHeader."Transport Method") then
                        TransMode := TransportMethod.Code;
                end else
                    if "Detailed GST Ledger Entry"."Document Type" = "Detailed GST Ledger Entry"."Document Type"::"Credit Memo" then begin
                        PurchCrMemoHdr.Get("Detailed GST Ledger Entry"."Document No.");
                        if TransportMethod.Get(PurchCrMemoHdr."Transport Method") then
                            TransMode := TransportMethod.Code;
                    end;
    end;

    local procedure GetDistance(FromCode: Code[20]; ToCode: Code[20]): Decimal
    var
        SalesInvoiceHeader: Record "Sales Invoice Header";
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        TransferShipmentHead: Record "Transfer Shipment Header";
        PurchInvHeader: Record "Purch. Inv. Header";
        PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr.";
        CU50061: Codeunit 50061;
    begin
        exit(CU50061.CalculateDistance(FromCode, ToCode));
        // if "Detailed GST Ledger Entry"."TransAction Type" = "Detailed GST Ledger Entry"."TransAction Type"::Sales then begin
        //     if "Detailed GST Ledger Entry"."Document Type" = "Detailed GST Ledger Entry"."Document Type"::Invoice then begin
        //         if "Detailed GST Ledger Entry"."Source Type" = "Detailed GST Ledger Entry"."Source Type"::Customer then
        //             if SalesInvoiceHeader.Get("Detailed GST Ledger Entry"."Document No.") then
        //                 exit(SalesInvoiceHeader."Distance (Km)");

        //         if "Detailed GST Ledger Entry"."Source Type" = "Detailed GST Ledger Entry"."Source Type"::" " then
        //             if TransferShipmentHead.Get("Detailed GST Ledger Entry"."Document No.") then
        //                 exit(TransferShipmentHead."Distance (Km)");
        //     end;

        //     if "Detailed GST Ledger Entry"."Document Type" = "Detailed GST Ledger Entry"."Document Type"::"Credit Memo" then
        //         if SalesCrMemoHeader.Get("Detailed GST Ledger Entry"."Document No.") then
        //             exit(SalesCrMemoHeader."Distance (Km)");
        // end;
        // if "Detailed GST Ledger Entry"."TransAction Type" = "Detailed GST Ledger Entry"."TransAction Type"::Purchase then begin
        //     if "Detailed GST Ledger Entry"."Document Type" = "Detailed GST Ledger Entry"."Document Type"::Invoice then
        //         if PurchInvHeader.Get("Detailed GST Ledger Entry"."Document No.") then
        //             exit(PurchInvHeader."Distance (Km)");

        //     if "Detailed GST Ledger Entry"."Document Type" = "Detailed GST Ledger Entry"."Document Type"::"Credit Memo" then
        //         if PurchCrMemoHdr.Get("Detailed GST Ledger Entry"."Document No.") then
        //             exit(PurchCrMemoHdr."Distance (Km)");
        // end;

    end;

    procedure GetTransName() TransName: Text[50]
    var
        SalesInvoiceHeader: Record "Sales Invoice Header";
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        PurchInvHeader: Record "Purch. Inv. Header";
        PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr.";
        ShippingAgent: Record "Shipping Agent";
    begin
        if "Detailed GST Ledger Entry"."TransAction Type" = "Detailed GST Ledger Entry"."TransAction Type"::Sales then begin
            if "Detailed GST Ledger Entry"."Document Type" = "Detailed GST Ledger Entry"."Document Type"::Invoice then
                if "Detailed GST Ledger Entry"."Source Type" = "Detailed GST Ledger Entry"."Source Type"::Customer then begin
                    if SalesInvoiceHeader.Get("Detailed GST Ledger Entry"."Document No.") then
                        if ShippingAgent.Get(SalesInvoiceHeader."Shipping Agent Code") then
                            TransName := ShippingAgent.Name;
                end else
                    if "Detailed GST Ledger Entry"."Source Type" = "Detailed GST Ledger Entry"."Source Type"::" " then begin
                        TransferShipmentHeader.Get("Detailed GST Ledger Entry"."Document No.");
                        if ShippingAgent.Get(TransferShipmentHeader."Shipping Agent Code") then
                            TransName := ShippingAgent.Name;
                    end;
            if "Detailed GST Ledger Entry"."Document Type" = "Detailed GST Ledger Entry"."Document Type"::"Credit Memo" then
                if SalesCrMemoHeader.Get("Detailed GST Ledger Entry"."Document No.") then
                    TransName := ShippingAgent.Name;
        end else
            if "Detailed GST Ledger Entry"."TransAction Type" = "Detailed GST Ledger Entry"."TransAction Type"::Purchase then
                if "Detailed GST Ledger Entry"."Document Type" = "Detailed GST Ledger Entry"."Document Type"::Invoice then begin
                    PurchInvHeader.Get("Detailed GST Ledger Entry"."Document No.");
                    if ShippingAgent.Get(PurchInvHeader."Shipping Agent Code") then
                        TransName := ShippingAgent.Name;
                end else
                    if "Detailed GST Ledger Entry"."Document Type" = "Detailed GST Ledger Entry"."Document Type"::"Credit Memo" then begin
                        PurchCrMemoHdr.Get("Detailed GST Ledger Entry"."Document No.");
                        if ShippingAgent.Get(PurchCrMemoHdr."Shipping Agent Code") then
                            TransName := ShippingAgent.Name;
                    end;
    end;

    procedure GetTransporterDetails(var TransID: Code[15]; var TransName: Text[100]; var LRNo: Code[100]; var LRDate: Date; var TransMode: Text[50])
    var
        SalesInvoiceHeader: Record "Sales Invoice Header";
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        TransferShipmentHead: Record "Transfer Shipment Header";
        PurchInvHeader: Record "Purch. Inv. Header";
        PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr.";
        ShippingAgent: Record "Shipping Agent";
        Transporter: Record Vendor;
    begin
        if "Detailed GST Ledger Entry"."TransAction Type" = "Detailed GST Ledger Entry"."TransAction Type"::Sales then begin
            if "Detailed GST Ledger Entry"."Document Type" = "Detailed GST Ledger Entry"."Document Type"::Invoice then
                if "Detailed GST Ledger Entry"."Source Type" = "Detailed GST Ledger Entry"."Source Type"::Customer then begin
                    if SalesInvoiceHeader.Get("Detailed GST Ledger Entry"."Document No.") then begin
                        IF SalesInvoiceHeader."Transporter Code" <> '' THEN begin
                            if Transporter.GET(SalesInvoiceHeader."Transporter Code") then begin
                                if Transporter."GST Vendor Type" in [Transporter."GST Vendor Type"::Unregistered] then
                                    TransID := URPTxt
                                else
                                    if Transporter."Transporter ID" = '' Then begin
                                        if Transporter."GST Registration No." <> '' then
                                            TransID := CopyStr(Transporter."GST Registration No.", 1, 15);
                                    end else begin
                                        TransID := CopyStr(Transporter."Transporter ID", 1, 15);
                                    end;
                            end else
                                TransID := '';
                        end;
                        TransName := SalesInvoiceHeader."Transporter Name";
                        if SalesInvoiceHeader."LR/RR No." <> '' then
                            LRNo := SalesInvoiceHeader."LR/RR No.";
                        if SalesInvoiceHeader."LR/RR Date" <> 0D then
                            LRDate := SalesInvoiceHeader."LR/RR Date";
                        if SalesInvoiceHeader."Mode of Transport" <> '' then
                            TransMode := SalesInvoiceHeader."Mode of Transport"
                        else
                            TransMode := 'Road';
                    end;
                end else
                    if "Detailed GST Ledger Entry"."Source Type" = "Detailed GST Ledger Entry"."Source Type"::" " then begin
                        if TransferShipmentHeader.Get("Detailed GST Ledger Entry"."Document No.") then begin

                            // if SalesInvoiceHeader.Get("Detailed GST Ledger Entry"."Document No.") then begin
                            IF TransferShipmentHeader."Transporter Code" <> '' THEN begin
                                if Transporter.GET(TransferShipmentHeader."Transporter Code") then begin
                                    if Transporter."GST Registration No." <> '' then
                                        TransID := CopyStr(Transporter."GST Registration No.", 1, 15);
                                end;
                            end;
                            TransName := TransferShipmentHeader."Transporter Name";
                            if TransferShipmentHeader."LR/RR No." <> '' then
                                LRNo := TransferShipmentHeader."LR/RR No.";
                            if TransferShipmentHeader."LR/RR Date" <> 0D then
                                LRDate := TransferShipmentHeader."LR/RR Date";
                            if TransferShipmentHeader."Shipment Method Code" <> '' then
                                TransMode := TransferShipmentHeader."Shipment Method Code"
                            else
                                TransMode := 'Road';
                        end;
                    end;
            // if "Detailed GST Ledger Entry"."Document Type" = "Detailed GST Ledger Entry"."Document Type"::"Credit Memo" then
            //     if SalesCrMemoHeader.Get("Detailed GST Ledger Entry"."Document No.") then
            //         TransID := CopyStr(ShippingAgent."GST Registration No.", 1, 15)
        end else
            if "Detailed GST Ledger Entry"."TransAction Type" = "Detailed GST Ledger Entry"."TransAction Type"::Purchase then
                if "Detailed GST Ledger Entry"."Document Type" = "Detailed GST Ledger Entry"."Document Type"::"Credit Memo" then begin
                    if PurchCrMemoHdr.Get("Detailed GST Ledger Entry"."Document No.") then begin
                        // if SalesInvoiceHeader.Get("Detailed GST Ledger Entry"."Document No.") then begin
                        IF PurchCrMemoHdr."Transporter Code" <> '' THEN begin
                            if Transporter.GET(PurchCrMemoHdr."Transporter Code") then begin
                                if Transporter."GST Registration No." <> '' then
                                    TransID := CopyStr(Transporter."GST Registration No.", 1, 15);
                                if Transporter.Name <> '' then
                                    TransName := Transporter.Name;
                            end;
                        end;
                        if PurchCrMemoHdr."LR/RR No." <> '' then
                            LRNo := PurchCrMemoHdr."LR/RR No.";
                        if PurchCrMemoHdr."LR/RR Date" <> 0D then
                            LRDate := PurchCrMemoHdr."LR/RR Date";
                        if PurchCrMemoHdr."Shipment Method Code" <> '' then
                            TransMode := PurchCrMemoHdr."Shipment Method Code"
                        else
                            TransMode := 'Road';
                    end;
                end;
    end;

    local procedure GetVehicleNo() VehicleNo: Code[20]
    var
        SalesInvoiceHeader: Record "Sales Invoice Header";
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        PurchInvHeader: Record "Purch. Inv. Header";
        PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr.";
    begin
        if "Detailed GST Ledger Entry"."TransAction Type" = "Detailed GST Ledger Entry"."TransAction Type"::Sales then begin
            if "Detailed GST Ledger Entry"."Document Type" = "Detailed GST Ledger Entry"."Document Type"::Invoice then
                if "Detailed GST Ledger Entry"."Source Type" = "Detailed GST Ledger Entry"."Source Type"::Customer then begin
                    if SalesInvoiceHeader.Get("Detailed GST Ledger Entry"."Document No.") then
                        VehicleNo := SalesInvoiceHeader."Vehicle No.";
                end else
                    if "Detailed GST Ledger Entry"."Source Type" = "Detailed GST Ledger Entry"."Source Type"::" " then begin
                        TransferShipmentHeader.Get("Detailed GST Ledger Entry"."Document No.");
                        VehicleNo := TransferShipmentHeader."Vehicle No.";
                    end;
            if "Detailed GST Ledger Entry"."Document Type" = "Detailed GST Ledger Entry"."Document Type"::"Credit Memo" then
                if SalesCrMemoHeader.Get("Detailed GST Ledger Entry"."Document No.") then
                    VehicleNo := SalesCrMemoHeader."Vehicle No.";
        end else
            if "Detailed GST Ledger Entry"."TransAction Type" = "Detailed GST Ledger Entry"."TransAction Type"::Purchase then
                if "Detailed GST Ledger Entry"."Document Type" = "Detailed GST Ledger Entry"."Document Type"::Invoice then begin
                    PurchInvHeader.Get("Detailed GST Ledger Entry"."Document No.");
                    VehicleNo := PurchInvHeader."Vehicle No.";
                end else
                    if "Detailed GST Ledger Entry"."Document Type" = "Detailed GST Ledger Entry"."Document Type"::"Credit Memo" then begin
                        PurchCrMemoHdr.Get("Detailed GST Ledger Entry"."Document No.");
                        VehicleNo := PurchCrMemoHdr."Vehicle No.";
                    end;
        if VehicleNo <> '' then
            VehicleNo := DelChr(VehicleNo, '=', '/\-. ');
    end;

    local procedure GetDispatchState() DispatchState: Text[50]
    var
        PurchaseHead: Record "Purchase Header";
        SalesInvoiceLine: Record "Sales Invoice Line";
        SalesInvoiceHeader: Record "Sales Invoice Header";
        State: Record State;
        TransferShipment: Record "Transfer Shipment Header";
        PurCRHeader: Record "Purch. Cr. Memo Hdr.";
    begin
        if SupplyType = SupplyType::Outward then
            if SubType in [SubType::Supply, SubType::"Recipient Not Known"] then begin
                SalesInvoiceHeader.SetRange("No.", "Detailed GST Ledger Entry"."Document No.");
                //SalesInvoiceLine.SetRange("Drop Shipment", true);
                if SalesInvoiceHeader.FindFirst() then begin
                    // PurchaseHead.SetRange("No.", SalesInvoiceLine."Order No.");
                    // if PurchaseHead.FindFirst() then
                    if State.Get(SalesInvoiceHeader."Location State Code") then
                        DispatchState := State.Description;
                end;
                TransferShipment.SetRange("No.", "Detailed GST Ledger Entry"."Document No.");
                if TransferShipment.FindFirst() Then
                    If Location.Get(TransferShipment."Transfer-from Code") then
                        if State.Get(Location."State Code") then
                            DispatchState := State.Description;

                PurCRHeader.SetRange("No.", "Detailed GST Ledger Entry"."Document No.");
                if PurCRHeader.FindFirst() Then
                    if State.Get(PurCRHeader."Location State Code") then
                        DispatchState := State.Description;

            end;
        DispatchState := DelChr(DispatchState, '>', ' ');
    end;

    local procedure GetShipToState() ShipToState: Text[50]
    var
        SalesInvoiceLine: Record "Sales Invoice Line";
        SalesInvoiceHeader: Record "Sales Invoice Header";
        State: Record State;
        ShipToStateCode: Code[10];
        TransferShipment: Record "Transfer Shipment Header";
        PurCRHeader: Record "Purch. Cr. Memo Hdr.";
        Vend: Record Vendor;
    begin
        if SupplyType = SupplyType::Outward then
            if SubType in [SubType::Supply, SubType::"Recipient Not Known"] then begin
                SalesInvoiceLine.SetRange("Document No.", "Detailed GST Ledger Entry"."Document No.");
                // SalesInvoiceLine.SetRange("Drop Shipment", true);
                if SalesInvoiceLine.FindFirst() then begin
                    SalesInvoiceHeader.Get(SalesInvoiceLine."Document No.");
                    if SalesInvoiceHeader."Ship-to Code" <> '' then begin
                        ShipToAddress.Get(SalesInvoiceHeader."Sell-to Customer No.", SalesInvoiceHeader."Ship-to Code");
                        ShipToStateCode := ShipToAddress.State;
                    end else
                        ShipToStateCode := SalesInvoiceHeader."GST Bill-to State Code"
                end;
                TransferShipment.SetRange("No.", "Detailed GST Ledger Entry"."Document No.");
                if TransferShipment.FindFirst() Then
                    If Location.Get(TransferShipment."Transfer-to Code") then
                        // if State.Get(Location."State Code") then
                        ShipToStateCode := Location."State Code";

                PurCRHeader.SetRange("No.", "Detailed GST Ledger Entry"."Document No.");
                if PurCRHeader.FindFirst() Then
                    if Vend.get(PurCRHeader."Buy-from Vendor No.") then
                        if Vend."State Code" <> '' then
                            ShipToStateCode := vend."State Code";

            end;
        // if ShipToStateCode = '' then begin

        // end;

        if State.Get(ShipToStateCode) then
            ShipToState := State.Description;
        // if ShipToState = '' then
        //     ShipToState := '05';
        ShipToState := DelChr(ShipToState, '>', ' ');
    end;

    local procedure GetVehicleType() VehicleType: Text[10]
    var
        SalesInvoiceHeader: Record "Sales Invoice Header";
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        TransferShptHeader: Record "Transfer Shipment Header";
        PurchInvHeader: Record "Purch. Inv. Header";
        PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr.";
    begin
        if "Detailed GST Ledger Entry"."TransAction Type" = "Detailed GST Ledger Entry"."TransAction Type"::Sales then begin
            if "Detailed GST Ledger Entry"."Document Type" = "Detailed GST Ledger Entry"."Document Type"::Invoice then
                if "Detailed GST Ledger Entry"."Source Type" = "Detailed GST Ledger Entry"."Source Type"::Customer then begin
                    if SalesInvoiceHeader.Get("Detailed GST Ledger Entry"."Document No.") then begin
                        VehicleType := Format(SalesInvoiceHeader."Vehicle Type");
                        if (SalesInvoiceHeader."Vehicle No." <> '') and (VehicleType = ' ') then
                            VehicleType := Format(SalesInvoiceHeader."Vehicle Type"::Regular);
                    end;
                end else
                    if "Detailed GST Ledger Entry"."Source Type" = "Detailed GST Ledger Entry"."Source Type"::" " then begin
                        if TransferShptHeader.Get("Detailed GST Ledger Entry"."Document No.") then begin
                            VehicleType := Format(TransferShptHeader."Vehicle Type");
                            if (TransferShptHeader."Vehicle No." <> '') and (VehicleType = ' ') then
                                VehicleType := Format(TransferShptHeader."Vehicle Type"::Regular);
                        End;
                    end;

            if "Detailed GST Ledger Entry"."Document Type" = "Detailed GST Ledger Entry"."Document Type"::"Credit Memo" then
                if SalesCrMemoHeader.Get("Detailed GST Ledger Entry"."Document No.") then begin
                    VehicleType := Format(SalesCrMemoHeader."Vehicle Type");
                    if (SalesCrMemoHeader."Vehicle No." <> '') and (VehicleType = ' ') then
                        VehicleType := Format(SalesCrMemoHeader."Vehicle Type"::Regular);
                end;
        end else
            if "Detailed GST Ledger Entry"."TransAction Type" = "Detailed GST Ledger Entry"."TransAction Type"::Purchase then
                if "Detailed GST Ledger Entry"."Document Type" = "Detailed GST Ledger Entry"."Document Type"::Invoice then begin
                    if PurchInvHeader.Get("Detailed GST Ledger Entry"."Document No.") then begin
                        VehicleType := Format(PurchInvHeader."Vehicle Type");
                        if (PurchInvHeader."Vehicle No." <> '') and (VehicleType = ' ') then
                            VehicleType := Format(PurchInvHeader."Vehicle Type"::Regular);
                    end;
                end else
                    if "Detailed GST Ledger Entry"."Document Type" = "Detailed GST Ledger Entry"."Document Type"::"Credit Memo" then begin
                        if PurchCrMemoHdr.Get("Detailed GST Ledger Entry"."Document No.") then begin
                            VehicleType := Format(PurchCrMemoHdr."Vehicle Type");
                            if (PurchCrMemoHdr."Vehicle No." <> '') and (VehicleType = ' ') then
                                VehicleType := Format(PurchCrMemoHdr."Vehicle Type"::Regular);
                        end;
                    end;
    end;

    local procedure GetTaxRate() TaxRate: Text[25]
    var
        DetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry";
        DetailedGstLedgerEntryInfo: Record "Detailed GST Ledger Entry Info";

    begin
        DetailedGSTLedgerEntry.SetRange("Document Type", "Detailed GST Ledger Entry"."Document Type");
        DetailedGSTLedgerEntry.SetRange("Document No.", "Detailed GST Ledger Entry"."Document No.");
        DetailedGSTLedgerEntry.SetRange("Document Line No.", "Detailed GST Ledger Entry"."Document Line No.");
        if DetailedGSTLedgerEntry.FindSet() then
            repeat
                if DetailedGSTLedgerEntry."GST Component Code" = 'SGST' then
                    SGSTTaxRate := DetailedGSTLedgerEntry."GST %";
                if DetailedGSTLedgerEntry."GST Component Code" = 'CGST' then
                    CGSTTaxRate := DetailedGSTLedgerEntry."GST %";
                if DetailedGSTLedgerEntry."GST Component Code" = 'IGST' then
                    IGSTTaxRate := DetailedGSTLedgerEntry."GST %";
                if DetailedGSTLedgerEntry."GST Component Code" = 'CESS' then begin
                    CessTaxRate := DetailedGSTLedgerEntry."GST %";
                    DetailedGstLedgerEntryInfo.SetRange("Entry No.", DetailedGSTLedgerEntry."Entry No.");
                    if DetailedGstLedgerEntryInfo.FindFirst() then
                        CESSAdvolTaxRate := DetailedGstLedgerEntryInfo."Cess Amount Per Unit Factor";
                end;
                TaxRate :=
                  Format(SGSTTaxRate) + '+' + Format(CGSTTaxRate) + '+' + Format(IGSTTaxRate) + '+' + Format(CessTaxRate) + '+' + Format(CESSAdvolTaxRate);
            until DetailedGSTLedgerEntry.Next() = 0;
    end;

    procedure WriteCancellationJSON(eway_bill_number: Text; CancelReason: Enum "Eway Cancel Reason"; CancelRemark: Text[100];
                                                                              LocGSTRegNo: Code[15]) CancelJson: Text;
    var
        CancelJsonObject: JsonObject;
        CU50061: Codeunit 50061;
        Cantext: Text;
    begin
        Clear(Cantext);
        Cantext := CancelReason.Names.Get(CancelReason.Ordinals.IndexOf(CancelReason.AsInteger()));
        Clear(CancelJson);
        CancelJsonObject.Add('access_token', CU50061.GetInfo('MIEWAY', DataScope::Module));
        CancelJsonObject.Add('userGstin', LocGSTRegNo);
        CancelJsonObject.Add('eway_bill_number', eway_bill_number);
        CancelJsonObject.Add('reason_of_cancel', Cantext);
        CancelJsonObject.Add('cancel_remarks', CancelRemark);
        CancelJsonObject.Add('data_source', 'erp');
        CancelJsonObject.WriteTo(CancelJson);
    end;
    // [EventSubscriber(ObjectType::Page, Page::"Posted Sales Inv. - Update", 'OnAfterRecordChanged', '', false, false)]
    // local procedure VehicleUpdate(var IsChanged: Boolean; var SalesInvoiceHeader: Record "Sales Invoice Header"; xSalesInvoiceHeader: Record "Sales Invoice Header")
    // begin
    //     IsChanged := true;

    // end;

    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales Inv. Header - Edit", 'OnRunOnBeforeAssignValues', '', false, false)]
    // local procedure VehicleupdatePosted(SalesInvoiceHeaderRec: Record "Sales Invoice Header"; var SalesInvoiceHeader: Record "Sales Invoice Header")
    // begin
    //     SalesInvoiceHeader."Vehicle No." := SalesInvoiceHeaderRec."Vehicle No.";
    //     SalesInvoiceHeader."Vehicle Type" := SalesInvoiceHeaderRec."Vehicle Type";
    //     SalesInvoiceHeader."Transport Method" := SalesInvoiceHeaderRec."Transport Method";
    //     SalesInvoiceHeader."Shipping Agent Code" := SalesInvoiceHeaderRec."Shipping Agent Code";
    //     SalesInvoiceHeader."Cancel Reason" := SalesInvoiceHeaderRec."Cancel Reason";
    //     SalesInvoiceHeader."Distance (Km)" := SalesInvoiceHeaderRec."Distance (Km)";
    //     SalesInvoiceHeader.EwayCancelRemarks := SalesInvoiceHeaderRec.EwayCancelRemarks;
    //     SalesInvoiceHeader.EwayExtentionReason := SalesInvoiceHeaderRec.EwayExtentionReason;
    //     SalesInvoiceHeader.EwayUpdateReason := SalesInvoiceHeaderRec.EwayUpdateReason;
    //     SalesInvoiceHeader."Cancel Reason" := SalesInvoiceHeaderRec."Cancel Reason";
    //     SalesInvoiceHeader."Dispatch From" := SalesInvoiceHeaderRec."Dispatch From";
    //     SalesInvoiceHeader."LR/RR No." := SalesInvoiceHeaderRec."LR/RR No.";
    //     SalesInvoiceHeader."LR/RR Date" := SalesInvoiceHeaderRec."LR/RR Date";
    // end;



    var
        myInt: Integer;
        DocumentNo: Code[20];
        TempExcelBuffer: Record "Excel Buffer" temporary;
        DelGSTLedgerEntryInfo: Record "Detailed GST Ledger Entry Info";
        Vendor: Record Vendor;
        OrderAddress: Record "Order Address";
        Customer: Record Customer;
        ShipToAddress: Record "Ship-to Address";
        Location: Record "Location";
        CompanyInformation: Record "Company Information";
        Item: Record Item;
        FixedAsset: Record "Fixed Asset";
        ServiceInvoiceHeader: Record "Service Invoice Header";
        ServiceCrMemoHeader: Record "Service Cr.Memo Header";
        TransferShipmentHeader: Record "Transfer Shipment Header";
        StartDate: Date;
        EndDate: Date;
        LocationRegNo: Code[15];
        SourceType: Option " ",Customer,Vendor;
        SourceNo: Code[20];
        TransType: Option " ",Sales,Purchase,Transfers;
        SupplyType: Option Inward,Outward;
        SubType: Option " ",Supply,Export,"Job Work","Recipient Not Known",Import,"Job Work Returns","Sales Returns",Others;
        DocType: Option " ","Tax Invoice","Bill of Supply","Bill of Entry","Delivery Challan","Credit Note",Others;
        CGSTAmount: Decimal;
        SGSTAmount: Decimal;
        IGSTAmount: Decimal;
        CessAmount: Decimal;
        Others: Decimal;
        ServiceNo: Code[20];
        DetailGstLENo: Code[20];
        TotalInvoiceValue: Decimal;
        CessNonAdvolAmount: Decimal;
        ServiceDoc: Boolean;
        StartDateErr: Label 'You must enter Start Date.';
        EndDateErr: Label 'You must enter End Date.';
        StartDtGreaterErr: Label 'You must not enter Start Date that is greater than End Date.';
        LocRegNoErr: Label 'You must enter Location Reg. No.';
        TransTypeErr: Label 'You must enter TransAction Type.';
        URPTxt: Label 'urp';
        SupplyTypeTxt: Label 'Supply Type';
        SubTypeTxt: Label 'Sub Type';
        DocTypeTxt: Label 'Doc Type';
        DocNoTxt: Label 'Doc No.';
        DocDateTxt: Label 'Doc Date';
        FromOtherPartyNameTxt: Label 'From Other Party Name';
        FromGSTINTxt: Label 'From GSTIN';
        FromAddress1Txt: Label 'From Address1';
        FromAddress2Txt: Label 'From Address 2';
        FromPlaceTxt: Label 'From Place';
        TransactionTypeTxt: Label 'Transaction Type';
        FromPinCodeTxt: Label 'Dispatch Pin Code';
        FromStateTxt: Label 'Bill From State';
        ToOtherPartyNameTxt: Label 'To Other Party Name';
        ToGSTINTxt: Label 'To GSTIN';
        ToAddress1Txt: Label 'To Address 1';
        ToAddress2Txt: Label 'To Address 2';
        ToPlaceTxt: Label 'To Place';
        ToPinCodeTxt: Label 'Ship To Pin Code';
        ToStateTxt: Label 'Bill To State';
        ProductTxt: Label 'Product';
        DescriptionTxt: Label 'Description';
        HSNTxt: Label 'HSN';
        UnitTxt: Label 'Unit';
        QtyTxt: Label 'Qty';
        AssessableValueTxt: Label 'Assessable Value';
        TaxRateTxt: Label 'Rate(S + C + I + Cess + CESS NONADVOL)';
        CGSTTxt: Label 'CGST';
        SGSTTxt: Label 'SGST';
        IGSTTxt: Label 'IGST';
        CESSTxt: Label 'CESS';
        CGSTAmountTxt: Label 'CGST Amount';
        SGSTAmountTxt: Label 'SGST Amount';
        IGSTAmountTxt: Label 'IGST Amount';
        CessAmountTxt: Label 'CESS Amount';
        CessNonAdvolAmountTxt: Label 'CESS Non Advol Amount';
        OthersTxt: Label 'Others';
        TotalInvoiceValueTxt: Label 'Total Invoice Value';
        TransModeTxt: Label 'Trans Mode';
        DistaceTxt: Label 'Distance (Km)';
        TransNameTxt: Label 'Trans Name';
        TransIdTxt: Label 'Trans ID';
        TransDocNoTxt: Label 'Trans Doc No';
        TransDateTxt: Label 'Trans Date';
        VehicleNoTxt: Label 'Vehicle No.';
        DispatchStateTxt: Label 'Dispatch From State';
        ShipToStateTxt: Label 'Ship To State';
        VehicleTypeTxt: Label 'Vehicle Type';
        SupplyTypeDescTxt: Label 'Supply_Type_Desc';
        TransferSourceErr: Label 'Source No. must be blank for transAction type:Transfer.';
        "Detailed GST Ledger Entry": Record "Detailed GST Ledger Entry";

        TotalCGSTAmount: Decimal;
        TotalSGSTAmount: Decimal;
        TotalIGSTAmount: Decimal;
        TotalCessAmount: Decimal;
        TotalCessNonAdvolAmount: Decimal;
        TotalOtherAmount: Decimal;
        TotalTaxableAmount: Decimal;
        TotalInvoiceAmount: Decimal;
        CGSTTaxRate: Decimal;
        SGSTTaxRate: Decimal;
        IGSTTaxRate: Decimal;
        CESSTaxRate: Decimal;
        CESSAdvolTaxRate: Decimal;
        Companyinfo: Record "Company Information";
        OrderAddressShip: Record "Order Address";


}
