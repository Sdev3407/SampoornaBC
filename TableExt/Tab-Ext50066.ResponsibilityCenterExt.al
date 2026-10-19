tableextension 50066 ResponsibilityCenterExt extends "Responsibility Center"
{
    fields
    {
        field(50000; "Quote Nos."; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Quote Nos.';
            Description = 'Sales No. Series';
            TableRelation = "No. Series";
        }
        field(50001; "Order Nos."; Code[10])
        {
            DataClassification = ToBeClassified;
            AccessByPermission = TableData 110 = R;
            Caption = 'Order Nos.';
            Description = 'Sales No. Series';
            TableRelation = "No. Series";
        }
        field(50002; "Invoice Nos."; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Invoice Nos.';
            Description = 'Sales No. Series';
            TableRelation = "No. Series";
        }
        field(50003; "Posted Invoice Nos."; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Posted Invoice Nos.';
            Description = 'Sales No. Series';
            TableRelation = "No. Series";
        }
        field(50004; "Credit Memo Nos."; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Credit Memo Nos.';
            Description = 'Sales No. Series';
            TableRelation = "No. Series";
        }
        field(50005; "Posted Credit Memo Nos."; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Posted Credit Memo Nos.';
            Description = 'Sales No. Series';
            TableRelation = "No. Series";
        }
        field(50006; "Posted Shipment Nos."; Code[10])
        {
            DataClassification = ToBeClassified;
            AccessByPermission = TableData 110 = R;
            Caption = 'Posted Shipment Nos.';
            Description = 'Sales No. Series';
            TableRelation = "No. Series";
        }
        field(50007; "Reminder Nos."; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Reminder Nos.';
            Description = 'Sales No. Series';
            TableRelation = "No. Series";
        }
        field(50008; "Issued Reminder Nos."; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Issued Reminder Nos.';
            Description = 'Sales No. Series';
            TableRelation = "No. Series";
        }
        field(50009; "Fin. Chrg. Memo Nos."; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Fin. Chrg. Memo Nos.';
            Description = 'Sales No. Series';
            TableRelation = "No. Series";
        }
        field(50010; "Issued Fin. Chrg. M. Nos."; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Issued Fin. Chrg. M. Nos.';
            Description = 'Sales No. Series';
            TableRelation = "No. Series";
        }
        field(50011; "Posted Prepmt. Inv. Nos."; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Posted Prepmt. Inv. Nos.';
            Description = 'Sales No. Series';
            TableRelation = "No. Series";
        }
        field(50012; "Posted Prepmt. Cr. Memo Nos."; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Posted Prepmt. Cr. Memo Nos.';
            Description = 'Sales No. Series';
            TableRelation = "No. Series";
        }
        field(50013; "Blanket Order Nos."; Code[10])
        {
            DataClassification = ToBeClassified;
            AccessByPermission = TableData 110 = R;
            Caption = 'Blanket Order Nos.';
            Description = 'Sales No. Series';
            TableRelation = "No. Series";
        }
        field(50014; "Direct Debit Mandate Nos."; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Direct Debit Mandate Nos.';
            Description = 'Sales No. Series';
            TableRelation = "No. Series";
        }
        field(50015; "Posted Return Receipt Nos."; Code[10])
        {
            DataClassification = ToBeClassified;
            AccessByPermission = TableData 6660 = R;
            Caption = 'Posted Return Receipt Nos.';
            Description = 'Sales No. Series';
            TableRelation = "No. Series";
        }
        field(50016; "Return Order Nos."; Code[10])
        {
            DataClassification = ToBeClassified;
            AccessByPermission = TableData 6660 = R;
            Caption = 'Return Order Nos.';
            Description = 'Sales No. Series';
            TableRelation = "No. Series";
        }
        field(50017; "Third Party Nos."; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Third Party Nos.';
            Description = 'Sales No. Series';
            TableRelation = "No. Series";
        }
        field(50018; "Posted Invoice Nos. (Trading)"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Posted Invoice Nos. (Trading)';
            Description = 'Sales No. Series';
            TableRelation = "No. Series";
        }
        field(50019; "Posted Ret Rcpt Nos. (Trading)"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Posted Ret Rcpt Nos. (Trading)';
            Description = 'Sales No. Series';
            TableRelation = "No. Series";
        }
        field(50021; "Posted Sales Shpt. (Trading)"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Posted Sales Shpt. (Trading)';
            Description = 'Sales No. Series';
            TableRelation = "No. Series";
        }
        field(50022; "Posted Sale Cr. Memo (Trading)"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Posted Sale Cr. Memo (Trading)';
            Description = 'Sales No. Series';
            TableRelation = "No. Series";
        }
        field(50023; "Posted Inv. Nos. (Exempt)"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Posted Inv. Nos. (Exempt)';
            Description = 'Sales No. Series';
            TableRelation = "No. Series";
        }
        field(50024; "Posted Cr. Memo Nos. (Exempt)"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Posted Cr. Memo Nos. (Exempt)';
            Description = 'Sales No. Series';
            TableRelation = "No. Series";
        }
        field(50025; "Posted Inv. No. (Export)"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Posted Inv. No. (Export)';
            Description = 'Sales No. Series';
            TableRelation = "No. Series";
        }
        field(50026; "Posted Cr. Memo No. (Export)"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Posted Cr. Memo No. (Export)';
            Description = 'Sales No. Series';
            TableRelation = "No. Series";
        }
        field(50027; "Posted Inv. No. (Supp)"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Posted Inv. No. (Supp)';
            Description = 'Sales No. Series';
            TableRelation = "No. Series";
        }
        field(50028; "Posted Cr. Memo No. (Supp)"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Posted Cr. Memo No. (Supp)';
            Description = 'Sales No. Series';
            TableRelation = "No. Series";
        }
        field(50029; "Posted Inv. No. (Debit Note)"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Posted Inv. No. (Debit Note)';
            Description = 'Sales No. Series';
            TableRelation = "No. Series";
        }
        field(50030; "Posted Inv. No. (Non-GST)"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Posted Inv. No. (Non-GST)';
            Description = 'Sales No. Series';
            TableRelation = "No. Series";
        }
        field(50031; "Posted Cr. Memo No. (Non-GST)"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Posted Cr. Memo No. (Non-GST)';
            Description = 'Sales No. Series';
            TableRelation = "No. Series";
        }
        field(50032; "Purch. Quote Nos."; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Quote Nos.';
            Description = 'Purchase No.Series';
            TableRelation = "No. Series";
        }
        field(50033; "Purch. Order Nos."; Code[10])
        {
            DataClassification = ToBeClassified;
            AccessByPermission = TableData 120 = R;
            Caption = 'Order Nos.';
            Description = 'Purchase No.Series';
            TableRelation = "No. Series";
        }
        field(50034; "Purch. Invoice Nos."; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Invoice Nos.';
            Description = 'Purchase No.Series';
            TableRelation = "No. Series";
        }
        field(50035; "Posted Purch. Invoice Nos."; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Posted Invoice Nos.';
            Description = 'Purchase No.Series';
            TableRelation = "No. Series";
        }
        field(50036; "Purch. Credit Memo Nos."; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Credit Memo Nos.';
            Description = 'Purchase No.Series';
            TableRelation = "No. Series";
        }
        field(50037; "Posted Purch. Credit Memo Nos."; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Posted Credit Memo Nos.';
            Description = 'Purchase No.Series';
            TableRelation = "No. Series";
        }
        field(50038; "Posted Purch. Receipt Nos."; Code[10])
        {
            DataClassification = ToBeClassified;
            AccessByPermission = TableData 120 = R;
            Caption = 'Posted Receipt Nos.';
            Description = 'Purchase No.Series';
            TableRelation = "No. Series";
        }
        field(50039; "Blanket Purch. Order Nos."; Code[10])
        {
            DataClassification = ToBeClassified;
            AccessByPermission = TableData 120 = R;
            Caption = 'Blanket Order Nos.';
            Description = 'Purchase No.Series';
            TableRelation = "No. Series";
        }
        field(50040; "Posted Purch.Prepmt. Inv. Nos."; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Posted Prepmt. Inv. Nos.';
            Description = 'Purchase No.Series';
            TableRelation = "No. Series";
        }
        field(50041; "Posted P.Prepmt. Cr. Memo Nos."; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Posted Prepmt. Cr. Memo Nos.';
            Description = 'Purchase No.Series';
            TableRelation = "No. Series";
        }
        field(50042; "Posted Purch.Return Shpt. Nos."; Code[10])
        {
            DataClassification = ToBeClassified;
            AccessByPermission = TableData 6650 = R;
            Caption = 'Posted Return Shpt. Nos.';
            Description = 'Purchase No.Series';
            TableRelation = "No. Series";
        }
        field(50043; "Purch. Return Order Nos."; Code[10])
        {
            DataClassification = ToBeClassified;
            AccessByPermission = TableData 6650 = R;
            Caption = 'Return Order Nos.';
            Description = 'Purchase No.Series';
            TableRelation = "No. Series";
        }
        field(50044; "Purch. Third Party Nos."; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Third Party Nos.';
            Description = 'Purchase No.Series';
            TableRelation = "No. Series";
        }
        field(50045; "Posted Delivery Challan Nos."; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Posted Delivery Challan Nos.';
            Description = 'Purchase No.Series';
            TableRelation = "No. Series";
        }
        field(50046; "Subcontracting Order Nos."; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Subcontracting Order Nos.';
            Description = 'Purchase No.Series';
            TableRelation = "No. Series";
        }
        field(50047; "Posted SC Comp. Rcpt. Nos."; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Posted SC Comp. Rcpt. Nos.';
            Description = 'Purchase No.Series';
            TableRelation = "No. Series";
        }
        field(50048; "Delivery Challan Nos."; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Delivery Challan Nos.';
            Description = 'Purchase No.Series';
            TableRelation = "No. Series";
        }
        field(50049; "Posted PInvoice Nos. (Trading)"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Posted Invoice Nos. (Trading)';
            Description = 'Purchase No.Series';
            TableRelation = "No. Series";
        }
        field(50050; "Posted PRet Shpt Nos.(Trading)"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Posted Ret Shpt Nos. (Trading)';
            Description = 'Purchase No.Series';
            TableRelation = "No. Series";
        }
        field(50051; "Posted Purch. Rcpt. (Trading)"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Posted Purch. Rcpt. (Trading)';
            Description = 'Purchase No.Series';
            TableRelation = "No. Series";
        }
        field(50052; "Posted Purch Cr. Memo(Trading)"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Posted Purch Cr. Memo(Trading)';
            Description = 'Purchase No.Series';
            TableRelation = "No. Series";
        }
        field(50053; "Multiple Subcon. Order Det Nos"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Multiple Subcon. Order Det Nos';
            Description = 'Purchase No.Series';
            TableRelation = "No. Series";
        }
        field(50054; "Posted Purch. Inv.(Unreg)"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Posted Purch. Inv.(Unreg)';
            Description = 'Purchase No.Series';
            TableRelation = "No. Series";
        }
        field(50055; "Posted Purch Cr. Memo(Unreg)"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Posted Purch Cr. Memo(Unreg)';
            Description = 'Purchase No.Series';
            TableRelation = "No. Series";
        }
        field(50056; "Posted Purch Inv.(Unreg Supp)"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Posted Purch Inv.(Unreg Supp)';
            Description = 'Purchase No.Series';
            TableRelation = "No. Series";
        }
        field(50057; "Pst. Pur. Inv(Unreg. Deb.Note)"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Pst. Pur. Inv(Unreg. Deb.Note)';
            Description = 'Purchase No.Series';
            TableRelation = "No. Series";
        }
        field(50058; "Simulated Order Nos."; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Simulated Order Nos.';
            Description = 'Manufacturing No. Series';
            TableRelation = "No. Series";
        }
        field(50059; "Planned Order Nos."; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Planned Order Nos.';
            Description = 'Manufacturing No. Series';
            TableRelation = "No. Series";
        }
        field(50060; "Firm Planned Order Nos."; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Firm Planned Order Nos.';
            Description = 'Manufacturing No. Series';
            TableRelation = "No. Series";
        }
        field(50061; "Released Order Nos."; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Released Order Nos.';
            Description = 'Manufacturing No. Series';
            TableRelation = "No. Series";
        }
        field(50062; "Work Center Nos."; Code[10])
        {
            DataClassification = ToBeClassified;
            AccessByPermission = TableData 99000758 = R;
            Caption = 'Work Center Nos.';
            Description = 'Manufacturing No. Series';
            TableRelation = "No. Series";
        }
        field(50063; "Machine Center Nos."; Code[10])
        {
            DataClassification = ToBeClassified;
            AccessByPermission = TableData 99000758 = R;
            Caption = 'Machine Center Nos.';
            Description = 'Manufacturing No. Series';
            TableRelation = "No. Series";
        }
        field(50064; "Routing Nos."; Code[10])
        {
            DataClassification = ToBeClassified;
            AccessByPermission = TableData 99000760 = R;
            Caption = 'Routing Nos.';
            Description = 'Manufacturing No. Series';
            TableRelation = "No. Series";
        }
        field(50065; "Transfer Order Nos."; Code[10])
        {
            DataClassification = ToBeClassified;
            AccessByPermission = TableData 5740 = R;
            Caption = 'Transfer Order Nos.';
            Description = 'Inventory No. Series';
            TableRelation = "No. Series";
        }
        field(50066; "Posted Transfer Shpt. Nos."; Code[10])
        {
            DataClassification = ToBeClassified;
            AccessByPermission = TableData 5740 = R;
            Caption = 'Posted Transfer Shpt. Nos.';
            Description = 'Inventory No. Series';
            TableRelation = "No. Series";
        }
        field(50067; "Posted Transfer Rcpt. Nos."; Code[10])
        {
            DataClassification = ToBeClassified;
            AccessByPermission = TableData 5740 = R;
            Caption = 'Posted Transfer Rcpt. Nos.';
            Description = 'Inventory No. Series';
            TableRelation = "No. Series";
        }
        field(50068; "Nonstock Item Nos."; Code[10])
        {
            DataClassification = ToBeClassified;
            AccessByPermission = TableData 5718 = R;
            Caption = 'Nonstock Item Nos.';
            Description = 'Inventory No. Series';
            TableRelation = "No. Series";
        }
        field(50069; "Inventory Put-away Nos."; Code[10])
        {
            DataClassification = ToBeClassified;
            AccessByPermission = TableData 7340 = R;
            Caption = 'Inventory Put-away Nos.';
            Description = 'Inventory No. Series';
            TableRelation = "No. Series";
        }
        field(50070; "Inventory Pick Nos."; Code[10])
        {
            DataClassification = ToBeClassified;
            AccessByPermission = TableData 7342 = R;
            Caption = 'Inventory Pick Nos.';
            Description = 'Inventory No. Series';
            TableRelation = "No. Series";
        }
        field(50071; "Posted Invt. Put-away Nos."; Code[10])
        {
            DataClassification = ToBeClassified;
            AccessByPermission = TableData 7340 = R;
            Caption = 'Posted Invt. Put-away Nos.';
            Description = 'Inventory No. Series';
            TableRelation = "No. Series";
        }
        field(50072; "Posted Invt. Pick Nos."; Code[10])
        {
            DataClassification = ToBeClassified;
            AccessByPermission = TableData 7342 = R;
            Caption = 'Posted Invt. Pick Nos.';
            Description = 'Inventory No. Series';
            TableRelation = "No. Series";
        }
        field(50073; "Inventory Movement Nos."; Code[10])
        {
            DataClassification = ToBeClassified;
            AccessByPermission = TableData 7331 = R;
            Caption = 'Inventory Movement Nos.';
            Description = 'Inventory No. Series';
            TableRelation = "No. Series";
        }
        field(50074; "Registered Invt. Movement Nos."; Code[10])
        {
            DataClassification = ToBeClassified;
            AccessByPermission = TableData 7331 = R;
            Caption = 'Registered Invt. Movement Nos.';
            Description = 'Inventory No. Series';
            TableRelation = "No. Series";
        }
        field(50075; "Internal Movement Nos."; Code[10])
        {
            DataClassification = ToBeClassified;
            AccessByPermission = TableData 7331 = R;
            Caption = 'Internal Movement Nos.';
            Description = 'Inventory No. Series';
            TableRelation = "No. Series";
        }
        field(50076; "Third Party Nos.(Inventory)"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Third Party Nos.';
            Description = 'Inventory No. Series';
            TableRelation = "No. Series";
        }
        field(50077; "Inward Gate Entry Nos."; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Inward Gate Entry Nos.';
            Description = 'Inventory No. Series';
            TableRelation = "No. Series";
        }
        field(50078; "Outward Gate Entry Nos."; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Outward Gate Entry Nos.';
            Description = 'Inventory No. Series';
            TableRelation = "No. Series";
        }
        field(50079; "Posted Shpt. Nos. (Captive)"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Posted Shpt. Nos. (Captive)';
            Description = 'Inventory No. Series';
            TableRelation = "No. Series";
        }
        field(50080; "Transfer Order Nos. (Captive)"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Transfer Order Nos. (Captive)';
            Description = 'Inventory No. Series';
            TableRelation = "No. Series";
        }
        field(50081; "Service Transfer Order Nos."; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Service Transfer Order Nos.';
            Description = 'Inventory No. Series';
            TableRelation = "No. Series";
        }
        field(50082; "Posted Serv. Trans. Shpt. Nos."; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Posted Serv. Trans. Shpt. Nos.';
            Description = 'Inventory No. Series';
            TableRelation = "No. Series";
        }
        field(50083; "Posted Serv. Trans. Rcpt. Nos."; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Posted Serv. Trans. Rcpt. Nos.';
            Description = 'Inventory No. Series';
            TableRelation = "No. Series";
        }
        field(50084; "Parameter No"; Code[10])
        {
            DataClassification = ToBeClassified;
            Description = 'Nav Farm No. Series';
            TableRelation = "No. Series";
        }
        field(50085; "Parameter Template No"; Code[10])
        {
            DataClassification = ToBeClassified;
            Description = 'Nav Farm No. Series';
            TableRelation = "No. Series";
        }
        field(50086; "Breed Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            Description = 'Nav Farm No. Series';
            TableRelation = "No. Series";
        }
        field(50087; "Data Sheet Nos"; Code[10])
        {
            DataClassification = ToBeClassified;
            Description = 'Nav Farm No. Series';
            TableRelation = "No. Series";
        }
        field(50088; "Hatchery Nos"; Code[10])
        {
            DataClassification = ToBeClassified;
            Description = 'Nav Farm No. Series';
            TableRelation = "No. Series";
        }
        field(50089; "RGP Nos."; Code[10])
        {
            DataClassification = ToBeClassified;
            Description = 'Inventory No. Series';
            TableRelation = "No. Series";
        }
        field(50090; "NRGP Nos."; Code[10])
        {
            DataClassification = ToBeClassified;
            Description = 'Inventory No. Series';
            TableRelation = "No. Series";
        }
        field(50091; "Indent No. Series"; Code[10])
        {
            DataClassification = ToBeClassified;
            Description = 'Inventory No. Series';
            TableRelation = "No. Series";
        }
        field(50092; "GC Statement Nos."; Code[10])
        {
            DataClassification = ToBeClassified;
            Description = 'Nav Farm No. Series';
            TableRelation = "No. Series";
        }
        field(50093; "Hatchery Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            Description = 'Nav Farm No. Series';
            TableRelation = "No. Series";
        }
    }
}