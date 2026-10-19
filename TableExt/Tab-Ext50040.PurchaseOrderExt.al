tableextension 50040 PurchaseOrderExt extends "Purchase Header"
{
    fields
    {
        modify("Buy-from Vendor No.")
        {

            trigger OnAfterValidate()
            var
                Vend: Record Vendor;
                UserSetup: Record "User Setup";
            begin
                Vend.Get("Buy-from Vendor No.");
                "Creditors Type" := Vend."Creditors Type"; //PruRaj
                "P.A.N No." := Vend."P.A.N. No.";

                //UserSetup.GET(USERID);
                //VALIDATE("Location Code", UserSetup."Shortcut Dimension 3 Code");//PRU-VG
                //if not UserSetup."HO Users" then
                //  Validate("Location Code", UserSetup."Shortcut Dimension 3 Code");
            end;

            trigger OnBeforeValidate()
            var
                RecVendor: Record vendor;
            begin
                RecVendor.Get("Buy-from Vendor No.");
                if rec."Document Type" = Rec."Document Type"::Order then
                    if RecVendor."E-Mail" = '' then
                        Message('Please update the Email of the Vendor Code %1', RecVendor."No.");
            end;
        }
        modify("Posting Date")
        {
            trigger OnAfterValidate()
            begin
                Validate("Due Date calculation");
            end;
        }
        modify("Document Date")
        {
            trigger OnAfterValidate()
            begin
                Validate("Due Date calculation");
            end;
        }
        modify("No.")
        {
            trigger OnBeforeValidate()
            var
                UserSetup: Record "User Setup";
                PurchSetup: Record 5714;

            begin

                IF "Document Type" = "Document Type"::"Credit Memo" THEN BEGIN
                    UserSetup.RESET;
                    UserSetup.SETRANGE("User ID", USERID);
                    UserSetup.SETFILTER(UserSetup."Access Purchase Credit Memo", '%1', UserSetup."Access Purchase Credit Memo"::View);
                    IF UserSetup.FINDFIRST THEN
                        if UserId <> 'JOBQUEUE' Then
                            ERROR('You can not create Purchase credit memo');
                END;
                //PRU_DD 1.10

                IF "Document Type" = "Document Type"::Invoice THEN BEGIN
                    UserSetup.RESET;
                    UserSetup.SETRANGE("User ID", USERID);
                    UserSetup.SETFILTER(UserSetup."Access Purchase Invoice", '%1', UserSetup."Access Purchase Invoice"::View);
                    IF UserSetup.FINDFIRST THEN
                        if UserId <> 'JOBQUEUE' Then
                            ERROR('You can not create Purchase Invoice');
                END;
                //PRU_DD 1.10

                IF "Document Type" = "Document Type"::Order THEN BEGIN
                    UserSetup.RESET;
                    UserSetup.SETRANGE("User ID", USERID);
                    UserSetup.SETFILTER(UserSetup."Access Purchase Order", '%1', UserSetup."Access Purchase Order"::View);
                    IF UserSetup.FINDFIRST THEN
                        if UserId <> 'JOBQUEUE' Then
                            ERROR('You can not create Purchase Order');
                END;
                //PRU_DD 1.10

                IF "Document Type" = "Document Type"::Quote THEN BEGIN
                    UserSetup.RESET;
                    UserSetup.SETRANGE("User ID", USERID);
                    UserSetup.SETFILTER(UserSetup."Access Purchase Quote", '%1', UserSetup."Access Purchase Quote"::Edit);
                    IF UserSetup.FINDFIRST THEN
                        if UserId <> 'JOBQUEUE' Then
                            ERROR('You can not create Purchase Quote');
                END;
                //PRU_DD 1.10

                IF "Document Type" = "Document Type"::"Return Order" THEN BEGIN
                    UserSetup.RESET;
                    UserSetup.SETRANGE("User ID", USERID);
                    UserSetup.SETFILTER(UserSetup."Access Purchase Return Order", '%1', UserSetup."Access Purchase Return Order"::View);
                    IF UserSetup.FINDFIRST THEN
                        if UserId <> 'JOBQUEUE' Then
                            ERROR('You can not create Purchase Return Order');
                END;
                //PRU_DD 1.10
            end;


        }
        modify("Location Code")
        {

            trigger OnBeforeValidate()
            var
                LocRec: Record Location;
                CompanyInfo: Record "Company Information";
            begin
                CompanyInfo.Get;
                if UserId <> 'JOBQUEUE' then begin
                    If CompanyInfo.SFPLCompany in [CompanyInfo.SFPLCompany::Sampoorna] Then
                        if rec."Shortcut Dimension 2 Code" <> '' then begin
                            if LocRec.Get(rec."Location Code") then begin
                                if LocRec."Global Dimension 2 Code" <> Rec."Shortcut Dimension 2 Code" then
                                    Error('Dimension is not same in this location code %1', LocRec."Global Dimension 2 Code");
                            end;
                        END;
                end;

            end;

            trigger OnAfterValidate()
            var
                UserSetup: Record "User Setup";
                PurchSetup: Record "Purchases & Payables Setup";
            begin
                UserSetup.GET(USERID);
                UserSetup.TESTFIELD("Responsibility Center");
                //       PurchSetup.GET;

            end;
        }
        modify("Sell-to Customer No.")
        {
            trigger OnAfterValidate()
            var
                UserSetup: Record "User Setup";
            begin
                IF NOT Trading THEN BEGIN
                    UserSetup.GET(USERID);
                    IF "Sell-to Customer No." <> '' THEN
                        // if UserId <> 'JOBQUEUE' Then
                        //     VALIDATE("Location Code", UserSetup."Shortcut Dimension 3 Code")
                        //VALIDATE("Location Code",UserSetupMgt.GetLocation(1,'',"Responsibility Center"))
                        //ELSE
                        VALIDATE("Ship-to Code", '');
                END;
            end;
        }
        field(50000; "Brokerage Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-VG1.0';
            TableRelation = Vendor."No." WHERE(Broker = Const(true), Blocked = Filter(" "));
        }
        field(50001; "Rate Basis"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-VG1.0';
            OptionCaption = ' ,EX,FOR,CIF,FOB,N/A';
            OptionMembers = " ",EX,"FOR",CIF,FOB,"N/A";
        }
        field(50002; "Terms Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Terms and Conditions1";
        }
        field(50003; "Shortcut Dimension 3 Code"; Code[20])
        {
            CaptionClass = '1,2,3';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(3, "Shortcut Dimension 3 Code");
            end;
        }
        field(50004; "Against Original Invoice No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50005; "Against Original Invoice Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50006; "Creditors Type"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PruRaj';
            OptionCaption = ' ,SOYA CREDITORS,OTHER GRAIN CREDITORS,MEDICINE CREDITORS,CAPEX CREDITORS,SERVICE CREDITORS,IMPORT CREDITORS,MISCELLANEOUS CREDITORS,Maize Creditors,BAJRA Creditors,Wheat Creditors,Mustard DOC Creditors,D.D.G.S Creditors,DEOILED RICE BRAN Creditors,Birds Creditor,Chicks Creditor,Gen Item,Hatching Egg Outside,Premix,Rice Bran Oil,Rice Bran Polish,Rice Kanni,Lime Stone Power,Gaur Meal,Chicken Waste Meal,P.P Bags,Other,ANIMAL FEED SUPLEMENT';
            OptionMembers = " ","SOYA CREDITORS","OTHER GRAIN CREDITORS","MEDICINE CREDITORS","CAPEX CREDITORS","SERVICE CREDITORS","IMPORT CREDITORS","MISCELLANEOUS CREDITORS","Maize Creditors","BAJRA Creditors","Wheat Creditors","Mustard DOC Creditors","D.D.G.S Creditors","DEOILED RICE BRAN Creditors","Birds Creditor","Chicks Creditor","Gen Item","Hatching Egg Outside",Premix,"Rice Bran Oil","Rice Bran Polish","Rice Kanni","Lime Stone Power","Gaur Meal","Chicken Waste Meal","P.P Bags",Other,"ANIMAL FEED SUPLEMENT";
        }
        field(50007; "Line Narration1"; Text[100])
        {
            DataClassification = ToBeClassified;
            Description = 'Pru_Neelesh';
        }
        field(50008; "Mandi Name"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'Pru_gk MDN_0.1';
            TableRelation = "Mandi master" WHERE(Blocked = FILTER(false));
        }
        field(50009; "File No."; Text[100])
        {
            DataClassification = ToBeClassified;
            Description = 'Pru_gk MDN_0.1';
        }
        field(50010; "Due Date calculation"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Posting Date,Document Date';
            OptionMembers = "Posting Date","Document Date";

            trigger OnValidate()
            var
                PaymentTerms: Record "Payment Terms";
            begin
                IF "Due Date calculation" = "Due Date calculation"::"Posting Date" THEN BEGIN
                    IF ("Payment Terms Code" <> '') AND ("Document Date" <> 0D) THEN BEGIN
                        PaymentTerms.GET("Payment Terms Code");
                        IF (("Document Type" IN ["Document Type"::"Return Order", "Document Type"::"Credit Memo"]) AND
                            NOT PaymentTerms."Calc. Pmt. Disc. on Cr. Memos")
                        THEN BEGIN
                            IF ("Document Type" <> "Document Type"::"Credit Memo") OR ("Document Type" <> "Document Type"::"Return Order") THEN//PRU_NEELESH
                                                                                                                                               //VALIDATE("Due Date","Document Date"); original //PRU_NEELESH
                                VALIDATE("Due Date", "Posting Date");//PRU_NEELESH
                            VALIDATE("Pmt. Discount Date", 0D);
                            VALIDATE("Payment Discount %", 0);
                        END ELSE BEGIN
                            IF ("Document Type" <> "Document Type"::"Credit Memo") OR ("Document Type" <> "Document Type"::"Return Order") THEN//PRU_NEELESH
                                                                                                                                               //"Due Date" := CALCDATE(PaymentTerms."Due Date Calculation","Document Date");original //PRU_NEELESH
                                "Due Date" := CALCDATE(PaymentTerms."Due Date Calculation", "Posting Date"); //PRU_NEELESH
                            "Pmt. Discount Date" := CALCDATE(PaymentTerms."Discount Date Calculation", "Document Date");
                            IF NOT UpdateDocumentDate THEN
                                VALIDATE("Payment Discount %", PaymentTerms."Discount %")
                        END;
                    END ELSE BEGIN
                        IF ("Document Type" <> "Document Type"::"Credit Memo") OR ("Document Type" <> "Document Type"::"Return Order") THEN//PRU_NEELESH
                                                                                                                                           // VALIDATE("Due Date","Document Date"); original //PRU_NEELESH
                            VALIDATE("Due Date", "Posting Date"); //PRU_NEELESH
                        IF NOT UpdateDocumentDate THEN BEGIN
                            VALIDATE("Pmt. Discount Date", 0D);
                            VALIDATE("Payment Discount %", 0);
                        END;
                    END;
                    IF xRec."Payment Terms Code" = "Prepmt. Payment Terms Code" THEN
                        VALIDATE("Prepmt. Payment Terms Code", "Payment Terms Code");

                    IF ("Document Type" <> "Document Type"::"Credit Memo") OR ("Document Type" <> "Document Type"::"Return Order") THEN//PRU_NEELESH
                        "Due Date" := CALCDATE(PaymentTerms."Due Date Calculation", "Posting Date") //PRU_NEELESH
                    ELSE
                        VALIDATE("Due Date", "Posting Date"); // original PRU_NEELESH
                    IF ("Document Type" = "Document Type"::"Credit Memo") OR ("Document Type" = "Document Type"::"Return Order") THEN  //PRU_NEELESH
                        "Due Date" := "Posting Date"; //PRU_NEELESH
                END;
                IF "Due Date calculation" = "Due Date calculation"::"Document Date" THEN BEGIN

                    IF ("Payment Terms Code" <> '') AND ("Document Date" <> 0D) THEN BEGIN
                        PaymentTerms.GET("Payment Terms Code");
                        IF (("Document Type" IN ["Document Type"::"Return Order", "Document Type"::"Credit Memo"]) AND
                            NOT PaymentTerms."Calc. Pmt. Disc. on Cr. Memos")
                        THEN BEGIN
                            IF ("Document Type" <> "Document Type"::"Credit Memo") OR ("Document Type" <> "Document Type"::"Return Order") THEN//PRU_NEELESH
                                                                                                                                               //VALIDATE("Due Date","Document Date"); original //PRU_NEELESH
                                VALIDATE("Due Date", "Document Date");//PRU_NEELESH
                            VALIDATE("Pmt. Discount Date", 0D);
                            VALIDATE("Payment Discount %", 0);
                        END ELSE BEGIN
                            IF ("Document Type" <> "Document Type"::"Credit Memo") OR ("Document Type" <> "Document Type"::"Return Order") THEN//PRU_NEELESH
                                                                                                                                               //"Due Date" := CALCDATE(PaymentTerms."Due Date Calculation","Document Date");original //PRU_NEELESH
                                "Due Date" := CALCDATE(PaymentTerms."Due Date Calculation", "Document Date"); //PRU_NEELESH
                            "Pmt. Discount Date" := CALCDATE(PaymentTerms."Discount Date Calculation", "Document Date");
                            IF NOT UpdateDocumentDate THEN
                                VALIDATE("Payment Discount %", PaymentTerms."Discount %")
                        END;
                    END ELSE BEGIN
                        IF ("Document Type" <> "Document Type"::"Credit Memo") OR ("Document Type" <> "Document Type"::"Return Order") THEN//PRU_NEELESH
                                                                                                                                           // VALIDATE("Due Date","Document Date"); original //PRU_NEELESH
                            VALIDATE("Due Date", "Document Date"); //PRU_NEELESH
                        IF NOT UpdateDocumentDate THEN BEGIN
                            VALIDATE("Pmt. Discount Date", 0D);
                            VALIDATE("Payment Discount %", 0);
                        END;
                    END;
                    IF xRec."Payment Terms Code" = "Prepmt. Payment Terms Code" THEN
                        VALIDATE("Prepmt. Payment Terms Code", "Payment Terms Code");

                    IF ("Document Type" <> "Document Type"::"Credit Memo") OR ("Document Type" <> "Document Type"::"Return Order") THEN//PRU_NEELESH
                        "Due Date" := CALCDATE(PaymentTerms."Due Date Calculation", "Document Date") //PRU_NEELESH
                    ELSE
                        VALIDATE("Due Date", "Document Date"); // original PRU_NEELESH
                    IF ("Document Type" = "Document Type"::"Credit Memo") OR ("Document Type" = "Document Type"::"Return Order") THEN  //PRU_NEELESH
                        "Due Date" := "Document Date"; //PRU_NEELESH

                END;
            end;
        }
        field(50011; "Brokerage Rate"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50012; "Posted Sales Shipment No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50013; "P.A.N No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50014; "Same GST"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50015; "Created From Web"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50016; "SFPL User ID"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50017; "Brokerage Calculation Basis"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'Suman';
            OptionCaption = ' ,Quantity Basis,Value Basis';
            OptionMembers = " ","Quantity Basis","Value Basis";
        }


        //SIM-----------Code Added-------------
        field(50050; "Transporter Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50051; "LR/RR No."; code[20])
        {
            DataClassification = EndUserIdentifiableInformation;
        }
        field(50052; "LR/RR Date"; Date)
        {
            DataClassification = EndUserIdentifiableInformation;
        }
        Field(50058; "PO Expiration Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        Field(50059; "PO Sent"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        Field(50060; "Block"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50061; "Insurance Type"; Option)
        {
            OptionMembers = ,"By Us","By You";
        }
        field(50062; "Freight"; Option)
        {
            OptionMembers = ,"By Us","By You";
        }
        field(50063; "PO Type"; Option)
        {
            OptionMembers = "Goods","Service";

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                TestStatusOpen();
            end;
        }
        field(50064; "Service Type"; Option)
        {
            OptionMembers = " ","Logistics";

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                TestStatusOpen();
            end;
        }


        field(18179; "Mode of Transport"; Text[20])
        {
            Caption = 'Mode of Transport';
            DataClassification = CustomerContent;
        }
        //SIM-----------Code Added-------------
    }
    var
        UpdateDocumentDate: Boolean;



    trigger OnBeforeInsert()
    var
        UserSetup: Record 91;
    begin
        IF "Document Type" = "Document Type"::"Credit Memo" THEN BEGIN
            UserSetup.RESET;
            UserSetup.SETRANGE("User ID", USERID);
            UserSetup.SETFILTER(UserSetup."Access Purchase Credit Memo", '%1', UserSetup."Access Purchase Credit Memo"::View);
            IF UserSetup.FINDFIRST THEN
                ERROR('You do not have Permission to create Purchase Credit Memo');
        END;
        //PRU_DD 1.10

        IF "Document Type" = "Document Type"::Invoice THEN BEGIN
            UserSetup.RESET;
            UserSetup.SETRANGE("User ID", USERID);
            UserSetup.SETFILTER(UserSetup."Access Purchase Invoice", '%1', UserSetup."Access Purchase Invoice"::View);
            IF UserSetup.FINDFIRST THEN
                ERROR('You do not have Permission to create Purchase Invoice');
        END;
        //PRU_DD 1.10

        IF "Document Type" = "Document Type"::Order THEN BEGIN
            UserSetup.RESET;
            UserSetup.SETRANGE("User ID", USERID);
            UserSetup.SETFILTER(UserSetup."Access Purchase Order", '%1', UserSetup."Access Purchase Order"::View);
            IF UserSetup.FINDFIRST THEN
                ERROR('You do not have Permission to create Purchase Order');
        END;
        //PRU_DD 1.10

        IF "Document Type" = "Document Type"::Quote THEN BEGIN
            UserSetup.RESET;
            UserSetup.SETRANGE("User ID", USERID);
            UserSetup.SETFILTER(UserSetup."Access Purchase Quote", '%1', UserSetup."Access Purchase Quote"::View);
            IF UserSetup.FINDFIRST THEN
                ERROR('You do not have Permission to create Purchase Quote');
        END;
        //PRU_DD 1.10

        IF "Document Type" = "Document Type"::"Return Order" THEN BEGIN
            UserSetup.RESET;
            UserSetup.SETRANGE("User ID", USERID);
            UserSetup.SETFILTER(UserSetup."Access Purchase Return Order", '%1', UserSetup."Access Purchase Return Order"::View);
            IF UserSetup.FINDFIRST THEN
                ERROR('You do not have Permission to create Purchase Return Order');
        END;
        //PRU_DD 1.10
    end;

    procedure InitPostingNoSeries1()
    var
        PostingNoSeries: Code[20];
        GLSetup: Record "General Ledger Setup";
        GenJournalTemplate: Record "Gen. Journal Template";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        SalesSetup1: Record "Responsibility Center";
        UserSetup: Record "User Setup";
        PurchSetup1: Record "Responsibility Center";
        PurchSetup: Record "Purchases & Payables Setup";
        Location: Record 14;
        Page: Page 9204;
    begin
        PurchSetup.GET;
        UserSetup.GET(USERID);
        UserSetup.TESTFIELD("Responsibility Center");
        PurchSetup1.GET(UserSetup."Responsibility Center");
        if not UserSetup."HO Users" then
            Validate("Location Code", UserSetup."Shortcut Dimension 3 Code");
        GLSetup.GetRecordOnce();
        if GLSetup."Journal Templ. Name Mandatory" then begin
            if "Journal Templ. Name" = '' then begin
                if not IsCreditDocType() then
                    GenJournalTemplate.Get(PurchSetup."P. Invoice Template Name")
                else
                    GenJournalTemplate.Get(PurchSetup."P. Cr. Memo Template Name");
                "Journal Templ. Name" := GenJournalTemplate.Name;
            end else
                if GenJournalTemplate.Name = '' then
                    GenJournalTemplate.Get("Journal Templ. Name");
            PostingNoSeries := GenJournalTemplate."Posting No. Series";
        end else
            if IsCreditDocType() then
                PostingNoSeries := PurchSetup."Posted Credit Memo Nos."
            else
                PostingNoSeries := PurchSetup."Posted Invoice Nos.";

        case "Document Type" of
            "Document Type"::Quote, "Document Type"::Order, "Document Type"::"Blanket Order":
                begin
                    "Posting No. Series" := PurchSetup1."Posted Purch. Invoice Nos.";
                    "Receiving No. Series" := PurchSetup1."Posted Purch. Receipt Nos.";
                    if "Document Type" = "Document Type"::Order then begin
                        NoSeriesMgt.SetDefaultSeries("Prepayment No. Series", PurchSetup1."Posted Prepmt. Inv. Nos.");
                        NoSeriesMgt.SetDefaultSeries("Prepmt. Cr. Memo No. Series", PurchSetup1."Posted Prepmt. Cr. Memo Nos.");
                    end;
                    //Message('%1..%2No', PurchSetup1."Posted Purch. Invoice Nos.", PurchSetup1."Posted Purch. Receipt Nos.");
                    IF "Location Code" <> '' THEN BEGIN
                        Location.GET("Location Code");
                        IF Location."Purch. Invoice Nos." <> '' THEN
                            NoSeriesMgt.SetDefaultSeries("Posting No. Series", Location."Purch. Invoice Nos.");
                        IF Location."Purch. Receipt Nos." <> '' THEN
                            NoSeriesMgt.SetDefaultSeries("Posting No. Series", Location."Purch. Receipt Nos.");
                    END;
                    // Message('%1..%2..%3..%4check1', "Document Type", "Posting No. Series", "Receiving No. Series", "Location Code");

                end;
            "Document Type"::Invoice:
                begin
                    if ("No. Series" <> '') and (PurchSetup1."Invoice Nos." = PostingNoSeries) then
                        "Posting No. Series" := "No. Series"
                    else
                        NoSeriesMgt.SetDefaultSeries("Posting No. Series", PurchSetup1."Posted Purch. Invoice Nos.");
                    if PurchSetup."Receipt on Invoice" then
                        NoSeriesMgt.SetDefaultSeries("Receiving No. Series", PurchSetup1."Posted Purch. Receipt Nos.");
                    //   IF Trading THEN BEGIN
                    IF "Location Code" <> '' THEN BEGIN
                        Location.GET("Location Code");
                        IF Location."Purh. Invoice Nos. (Trading)" <> '' THEN
                            "Posting No. Series" := Location."Purh. Invoice Nos. (Trading)"
                        ELSE
                            "Posting No. Series" := PurchSetup1."Posted PInvoice Nos. (Trading)";
                        IF PurchSetup."Receipt on Invoice" THEN BEGIN
                            IF Location."Purch. Rcpt. Nos. (Trading)" <> '' THEN
                                "Receiving No. Series" := Location."Purch. Rcpt. Nos. (Trading)"
                            ELSE
                                "Receiving No. Series" := PurchSetup1."Posted Purch. Rcpt. (Trading)";
                        END;
                    END ELSE BEGIN
                        "Posting No. Series" := PurchSetup1."Posted PInvoice Nos. (Trading)";
                        IF PurchSetup."Receipt on Invoice" THEN
                            "Receiving No. Series" := PurchSetup1."Posted Purch. Rcpt. (Trading)";
                    END;
                    // END;
                end;
            "Document Type"::"Return Order":
                begin
                    NoSeriesMgt.SetDefaultSeries("Posting No. Series", PurchSetup1."Posted Purch. Credit Memo Nos.");
                    NoSeriesMgt.SetDefaultSeries("Return Shipment No. Series", PurchSetup1."Posted Purch. Credit Memo Nos.");
                    IF Trading THEN BEGIN
                        IF "Location Code" <> '' THEN BEGIN
                            Location.GET("Location Code");
                            IF Location."Purch Cr. Memo Nos. (Trading)" <> '' THEN
                                "Posting No. Series" := Location."Purch Cr. Memo Nos. (Trading)"
                            ELSE
                                "Posting No. Series" := PurchSetup1."Posted Purch Cr. Memo(Trading)";
                            IF Location."Purch. Rcpt. Nos. (Trading)" <> '' THEN
                                "Return Shipment No. Series" := Location."Purch. Ret Shpt Nos. (Trading)"
                            ELSE
                                "Return Shipment No. Series" := PurchSetup1."Posted PRet Shpt Nos.(Trading)";
                        END ELSE BEGIN
                            "Posting No. Series" := PurchSetup1."Posted Purch Cr. Memo(Trading)";
                            "Return Shipment No. Series" := PurchSetup1."Posted PRet Shpt Nos.(Trading)";
                        END;
                    END;
                end;
            "Document Type"::"Credit Memo":
                begin
                    if ("No. Series" <> '') and (PurchSetup1."Credit Memo Nos." = PurchSetup1."Posted Purch. Credit Memo Nos.") then
                        "Posting No. Series" := "No. Series"
                    else
                        NoSeriesMgt.SetDefaultSeries("Posting No. Series", PurchSetup1."Posted Purch. Credit Memo Nos.");
                    if PurchSetup."Return Shipment on Credit Memo" then
                        NoSeriesMgt.SetDefaultSeries("Return Shipment No. Series", PurchSetup1."Posted Purch.Return Shpt. Nos.");
                    IF Trading THEN BEGIN
                        IF "Location Code" <> '' THEN BEGIN
                            Location.GET("Location Code");
                            IF Location."Purch Cr. Memo Nos. (Trading)" <> '' THEN
                                "Posting No. Series" := Location."Purch Cr. Memo Nos. (Trading)"
                            ELSE
                                "Posting No. Series" := PurchSetup1."Posted Purch Cr. Memo(Trading)";
                            IF PurchSetup."Return Shipment on Credit Memo" THEN BEGIN
                                IF Location."Purch. Rcpt. Nos. (Trading)" <> '' THEN
                                    "Return Shipment No. Series" := Location."Purch. Ret Shpt Nos. (Trading)"
                                ELSE
                                    "Return Shipment No. Series" := PurchSetup1."Posted PRet Shpt Nos.(Trading)";
                            END;
                        END ELSE BEGIN
                            "Posting No. Series" := PurchSetup1."Posted Purch Cr. Memo(Trading)";
                            IF PurchSetup."Return Shipment on Credit Memo" THEN
                                "Return Shipment No. Series" := PurchSetup1."Posted PRet Shpt Nos.(Trading)";
                        END;
                    END;
                END;

        end;
        Message('%1..%2', "Posting No. Series", "Receiving No. Series");
    end;

    //OnAfterInitPostingNoSeries(Rec, xRec);
    //end;
}