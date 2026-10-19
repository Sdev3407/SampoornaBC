tableextension 50035 GenJournalLine1Ext extends "Gen. Journal Line"
{
    fields
    {

        modify("TDS Section Code")
        {
            trigger OnAfterValidate()
            var
                ASection: Record "Allowed Sections";
            begin
                if "TDS Section Code" <> '' then
                    if "Account Type" = "Account Type"::Vendor then
                        if Not ASection.Get("Account No.", "TDS Section Code") then
                            Error('Please select allowed Section for this vendor');
            end;
        }
        modify("TCS Nature of Collection")
        {
            trigger OnAfterValidate()
            var
                SalesHeader: Record "Sales Header";
                TCSSetup_R: Record "TCS Setup";
                ASection: Record "Allowed NOC";
            begin
                if "TCS Nature of Collection" <> '' then
                    if "Account Type" = "Account Type"::Customer then
                        if Not ASection.Get("Account No.", "TCS Nature of Collection") then
                            Error('Please select allowed Section for this Customer');
            end;
        }
        modify("Bal. Account No.")
        {

            trigger OnAfterValidate()
            var
                UserSetupRec: Record "User Setup";
                Cust: Record Customer;
                Vend: Record Vendor;
                FixedAssetRec: Record "Fixed Asset";
                DefaultDimension: Record 352;
            begin
                ////Pru_gk
                UserSetupRec.GET(USERID);
                If UserId <> 'JOBQUEUE' Then begin
                    IF "Journal Template Name" <> 'ASSETS' THEN BEGIN
                        UserSetupRec.TESTFIELD("Global Dimension 1 Code");
                        IF NOT UserSetupRec."User Permission" THEN BEGIN
                            UserSetupRec.TESTFIELD("Global Dimension 2 Code");
                            Rec.VALIDATE("Shortcut Dimension 2 Code", UserSetupRec."Global Dimension 2 Code");
                            IF NOT UserSetupRec."HO Users" THEN BEGIN
                                UserSetupRec.TESTFIELD("Shortcut Dimension 3 Code");
                                Rec.VALIDATE("Shortcut Dimension 3 Code", UserSetupRec."Shortcut Dimension 3 Code");
                            END;
                        END;
                        Rec.VALIDATE("Shortcut Dimension 2 Code", UserSetupRec."Global Dimension 2 Code");
                        Rec.VALIDATE("Shortcut Dimension 1 Code", UserSetupRec."Global Dimension 1 Code");
                        Rec.VALIDATE("Shortcut Dimension 3 Code", UserSetupRec."Shortcut Dimension 3 Code");
                        ////Pru_gk
                    END;
                    IF "Account Type" = "Account Type"::"Fixed Asset" THEN BEGIN
                        FixedAssetRec.RESET;
                        if FixedAssetRec.GET("Account No.") then;
                        Rec.VALIDATE("Shortcut Dimension 1 Code", FixedAssetRec."Global Dimension 1 Code");
                        Rec.VALIDATE("Shortcut Dimension 2 Code", FixedAssetRec."Global Dimension 2 Code");
                        DefaultDimension.RESET;
                        DefaultDimension.SETRANGE("Table ID", 5600);
                        DefaultDimension.SETRANGE("No.", "Account No.");
                        DefaultDimension.SETRANGE("Dimension Code", 'LOC');
                        IF DefaultDimension.FINDFIRST THEN
                            Rec.VALIDATE("Shortcut Dimension 3 Code", DefaultDimension."Dimension Value Code");

                        ///MESSAGE('%1',FixedAssetRec."Global Dimension 2 Code");
                        ////Rec.VALIDATE("Shortcut Dimension 3 Code",FixedAssetRec.
                    END;


                    //GK19102021
                    IF "Account Type" = "Account Type"::Customer THEN BEGIN
                        IF "Account No." <> '' THEN begin
                            Cust.get("Account No.");
                            "Responsibility Center" := Cust."Responsibility Center";
                        END;
                    END;

                    IF "Account Type" = "Account Type"::Vendor THEN BEGIN
                        IF "Account No." <> '' THEN begin
                            Vend.get("Account No.");
                            "Responsibility Center" := Vend."Responsibility Center";
                        END;
                    END;
                end;
            end;
        }

        modify("Location Code")
        {
            trigger OnAfterValidate()
            var
                UserSetupRec: Record "User Setup";
                Cust: Record Customer;
                Vend: Record Vendor;
                FixedAssetRec: Record "Fixed Asset";
                DefaultDimension: Record 352;
            begin
                ////Pru_gk
                UserSetupRec.GET(USERID);
                IF "Journal Template Name" <> 'ASSETS' THEN BEGIN
                    UserSetupRec.TESTFIELD("Global Dimension 1 Code");
                    IF NOT UserSetupRec."User Permission" THEN BEGIN
                        UserSetupRec.TESTFIELD("Global Dimension 2 Code");
                        Rec.VALIDATE("Shortcut Dimension 2 Code", UserSetupRec."Global Dimension 2 Code");
                        IF NOT UserSetupRec."HO Users" THEN BEGIN
                            UserSetupRec.TESTFIELD("Shortcut Dimension 3 Code");
                            Rec.VALIDATE("Shortcut Dimension 3 Code", UserSetupRec."Shortcut Dimension 3 Code");
                        END;
                    END;
                    Rec.VALIDATE("Shortcut Dimension 2 Code", UserSetupRec."Global Dimension 2 Code");
                    Rec.VALIDATE("Shortcut Dimension 1 Code", UserSetupRec."Global Dimension 1 Code");
                    Rec.VALIDATE("Shortcut Dimension 3 Code", UserSetupRec."Shortcut Dimension 3 Code");
                    ////Pru_gk
                END;
                IF "Account Type" = "Account Type"::"Fixed Asset" THEN BEGIN
                    FixedAssetRec.RESET;
                    if FixedAssetRec.GET("Account No.") then;
                    Rec.VALIDATE("Shortcut Dimension 1 Code", FixedAssetRec."Global Dimension 1 Code");
                    Rec.VALIDATE("Shortcut Dimension 2 Code", FixedAssetRec."Global Dimension 2 Code");
                    DefaultDimension.RESET;
                    DefaultDimension.SETRANGE("Table ID", 5600);
                    DefaultDimension.SETRANGE("No.", "Account No.");
                    DefaultDimension.SETRANGE("Dimension Code", 'LOC');
                    IF DefaultDimension.FINDFIRST THEN
                        Rec.VALIDATE("Shortcut Dimension 3 Code", DefaultDimension."Dimension Value Code");

                    ///MESSAGE('%1',FixedAssetRec."Global Dimension 2 Code");
                    ////Rec.VALIDATE("Shortcut Dimension 3 Code",FixedAssetRec.
                END;


                //GK19102021
                IF "Account Type" = "Account Type"::Customer THEN BEGIN
                    IF "Account No." <> '' THEN begin
                        Cust.get("Account No.");
                        "Responsibility Center" := Cust."Responsibility Center";
                    END;
                END;

                IF "Account Type" = "Account Type"::Vendor THEN BEGIN
                    IF "Account No." <> '' THEN begin
                        Vend.get("Account No.");
                        "Responsibility Center" := Vend."Responsibility Center";
                    END;
                END;
            end;
        }

        modify("Account No.")
        {

            trigger OnAfterValidate()
            var
                UserSetupRec: Record "User Setup";
                Cust: Record Customer;
                Vend: Record Vendor;
                FixedAssetRec: Record "Fixed Asset";
                DefaultDimension: Record 352;
            begin
                ////Pru_gk
                UserSetupRec.GET(USERID);
                if UserId <> 'JOBQUEUE' Then begin
                    IF "Journal Template Name" <> 'ASSETS' THEN BEGIN
                        UserSetupRec.TESTFIELD("Global Dimension 1 Code");
                        IF NOT UserSetupRec."User Permission" THEN BEGIN
                            UserSetupRec.TESTFIELD("Global Dimension 2 Code");
                            Rec.VALIDATE("Shortcut Dimension 2 Code", UserSetupRec."Global Dimension 2 Code");
                            IF NOT UserSetupRec."HO Users" THEN BEGIN
                                UserSetupRec.TESTFIELD("Shortcut Dimension 3 Code");
                                Rec.VALIDATE("Shortcut Dimension 3 Code", UserSetupRec."Shortcut Dimension 3 Code");
                            END;
                        END;
                        Rec.VALIDATE("Shortcut Dimension 2 Code", UserSetupRec."Global Dimension 2 Code");
                        Rec.VALIDATE("Shortcut Dimension 1 Code", UserSetupRec."Global Dimension 1 Code");
                        Rec.VALIDATE("Shortcut Dimension 3 Code", UserSetupRec."Shortcut Dimension 3 Code");
                        ////Pru_gk
                    END;
                    IF "Account Type" = "Account Type"::"Fixed Asset" THEN BEGIN
                        FixedAssetRec.RESET;
                        if FixedAssetRec.GET("Account No.") then;
                        Rec.VALIDATE("Shortcut Dimension 1 Code", FixedAssetRec."Global Dimension 1 Code");
                        Rec.VALIDATE("Shortcut Dimension 2 Code", FixedAssetRec."Global Dimension 2 Code");
                        DefaultDimension.RESET;
                        DefaultDimension.SETRANGE("Table ID", 5600);
                        DefaultDimension.SETRANGE("No.", "Account No.");
                        DefaultDimension.SETRANGE("Dimension Code", 'LOC');
                        IF DefaultDimension.FINDFIRST THEN
                            Rec.VALIDATE("Shortcut Dimension 3 Code", DefaultDimension."Dimension Value Code");

                        ///MESSAGE('%1',FixedAssetRec."Global Dimension 2 Code");
                        ////Rec.VALIDATE("Shortcut Dimension 3 Code",FixedAssetRec.
                    END;
                end;

                //GK19102021
                IF "Account Type" = "Account Type"::Customer THEN BEGIN
                    IF "Account No." <> '' THEN begin
                        Cust.get("Account No.");
                        "Responsibility Center" := Cust."Responsibility Center";
                    END;
                END;

                IF "Account Type" = "Account Type"::Vendor THEN BEGIN
                    IF "Account No." <> '' THEN begin
                        Vend.get("Account No.");
                        "Responsibility Center" := Vend."Responsibility Center";
                    END;
                END;
            end;
        }
        modify("Recipient Bank Account")
        {
            trigger OnAfterValidate()
            var
                CustomerBankAccount: Record "Customer Bank Account";
                VendorBankAccount: Record "Vendor Bank Account";
            begin
                CASE "Account Type" OF
                    "Account Type"::Customer:
                        BEGIN
                            IF "Recipient Bank Account" <> '' THEN BEGIN
                                CustomerBankAccount.RESET;
                                CustomerBankAccount.SETRANGE(CustomerBankAccount.Code, Rec."Recipient Bank Account");
                                CustomerBankAccount.SETRANGE(CustomerBankAccount."Customer No.", Rec."Account No.");
                                IF CustomerBankAccount.FINDFIRST THEN
                                    Rec."Recipient Bank Account No." := CustomerBankAccount."Bank Account No."
                            END ELSE
                                "Recipient Bank Account No." := '';
                        END;
                    "Account Type"::Vendor:
                        BEGIN
                            IF "Recipient Bank Account" <> '' THEN BEGIN
                                VendorBankAccount.RESET;
                                VendorBankAccount.SETRANGE(VendorBankAccount.Code, Rec."Recipient Bank Account");
                                VendorBankAccount.SETRANGE(VendorBankAccount."Vendor No.", Rec."Account No.");
                                IF VendorBankAccount.FINDFIRST THEN
                                    Rec."Recipient Bank Account No." := VendorBankAccount."Bank Account No."
                            END ELSE
                                "Recipient Bank Account No." := '';
                        END;
                END;

            end;
        }

        field(50010; "Responsibility Center"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50011; "Shortcut Dimension 3 Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,3';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));

            trigger OnValidate()
            var
                UserSetupRec: Record 91;
                Location: Record Location;
            begin
                ValidateShortcutDimCode(3, "Shortcut Dimension 3 Code");
                UserSetupRec.GET(USERID);
                IF UserSetupRec."User Permission" THEN BEGIN
                    Location.RESET;
                    Location.SETRANGE(Code, "Shortcut Dimension 3 Code");
                    IF Location.FINDFIRST THEN
                        VALIDATE("Shortcut Dimension 2 Code", Location."Global Dimension 2 Code");

                END;
            end;
        }
        field(50012; "Bal.Account Name"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(50013; CheckPayment; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50014; CheckRefund; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50015; CheckBlankPayment; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50017; "Line Narration1"; Text[100])
        {
            DataClassification = ToBeClassified;
            Description = 'PRU_AS0.005';
        }
        field(50018; "Creditors Type"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PruRaj';
            OptionCaption = ' ,SOYA CREDITORS,OTHER GRAIN CREDITORS,MEDICINE CREDITORS,CAPEX CREDITORS,SERVICE CREDITORS,IMPORT CREDITORS,MISCELLANEOUS CREDITORS,Maize Creditors,BAJRA Creditors,Wheat Creditors,Mustard DOC Creditors,D.D.G.S Creditors,DEOILED RICE BRAN Creditors,Birds Creditor,Chicks Creditor,Gen Item,Hatching Egg Outside,Premix,Rice Bran Oil,Rice Bran Polish,Rice Kanni,Lime Stone Power,Gaur Meal,Chicken Waste Meal,P.P Bags,Other';
            OptionMembers = " ","SOYA CREDITORS","OTHER GRAIN CREDITORS","MEDICINE CREDITORS","CAPEX CREDITORS","SERVICE CREDITORS","IMPORT CREDITORS","MISCELLANEOUS CREDITORS","Maize Creditors","BAJRA Creditors","Wheat Creditors","Mustard DOC Creditors","D.D.G.S Creditors","DEOILED RICE BRAN Creditors","Birds Creditor","Chicks Creditor","Gen Item","Hatching Egg Outside",Premix,"Rice Bran Oil","Rice Bran Polish","Rice Kanni","Lime Stone Power","Gaur Meal","Chicken Waste Meal","P.P Bags",Other;
        }
        field(50019; "Flock Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Production Order"."No." WHERE(Status = FILTER(Released));

            trigger OnValidate()
            var
                ProductionOrder: Record 5405;
            begin

            end;
        }
        field(50020; "FEED Freight Charge"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50021; "Recipient Bank Account No."; Code[20])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                CASE "Account Type" OF
                    "Account Type"::Customer:
                        BEGIN

                        END;
                    "Account Type"::Vendor:
                        BEGIN

                        END;
                END;
            end;
        }
        field(50022; "Payment Mode"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,NEFT,RTGS,Cheque,Internal Bank Trans.';
            OptionMembers = " ",NEFT,RTGS,Cheque,"Internal Bank Trans.";
        }
        field(50023; "Applied PO No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50024; "Team Code"; Code[20])
        {
            Caption = 'Team Code';
            DataClassification = ToBeClassified;
        }

        field(50025; "Security Group Code"; Code[20])
        {
            Caption = 'Security Group Code';
            DataClassification = ToBeClassified;
            TableRelation = "SFPL_Security Group".Code where("Vendor No." = field("Account No."));

            trigger OnValidate()
            var
                Securitygroup: Record "SFPL_Security Group";

            begin
                if "Security Group Code" <> '' then begin
                    Securitygroup.Reset();
                    Securitygroup.SetCurrentKey(Code, "Vendor No.", "Posting Group");
                    Securitygroup.SetRange(Code, "Security Group Code");
                    Securitygroup.SetRange("Vendor No.", "Account No.");
                    if Securitygroup.FindFirst() then
                        "Posting Group" := Securitygroup."Posting Group";


                end;
            end;
        }
        field(50026; "User ID"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        // field(50027; "SFPL Account No."; Code[20])
        // {
        //     Caption = 'SFPL Account No.';
        //     TableRelation = if ("Account Type" = const("G/L Account")) "G/L Account" where("Account Type" = const(Posting),
        //                                                                                   Blocked = const(false))
        //     else
        //     if ("Account Type" = const(Customer)) Customer WHERE(Blocked = Filter(" "))
        //     else
        //     if ("Account Type" = const(Vendor)) Vendor WHERE(Blocked = Filter(" "))
        //     else
        //     if ("Account Type" = const("Bank Account")) "Bank Account"
        //     else
        //     if ("Account Type" = const("Fixed Asset")) "Fixed Asset"
        //     else
        //     if ("Account Type" = const("IC Partner")) "IC Partner"
        //     else
        //     if ("Account Type" = const("Allocation Account")) "Allocation Account"
        //     else
        //     if ("Account Type" = const(Employee)) Employee;

        //     trigger OnValidate()
        //     begin
        //         Rec.validate("Account No.", rec."SFPL Account No.");
        //     end;
        // }
        // field(50028; "SFPL Bal. Account No."; Code[20])
        // {
        //     Caption = 'SFPL Bal. Account No.';
        //     TableRelation = if ("Bal. Account Type" = const("G/L Account")) "G/L Account" where("Account Type" = const(Posting),
        //                                                                                        Blocked = const(false))
        //     else
        //     if ("Bal. Account Type" = const(Customer)) Customer WHERE(Blocked = Filter(" "))
        //     else
        //     if ("Bal. Account Type" = const(Vendor)) Vendor WHERE(Blocked = Filter(" "))
        //     else
        //     if ("Bal. Account Type" = const("Bank Account")) "Bank Account"
        //     else
        //     if ("Bal. Account Type" = const("Fixed Asset")) "Fixed Asset"
        //     else
        //     if ("Bal. Account Type" = const("IC Partner")) "IC Partner"
        //     else
        //     if ("Bal. Account Type" = const("Allocation Account")) "Allocation Account"
        //     else
        //     if ("Bal. Account Type" = const(Employee)) Employee;

        //     trigger OnValidate()
        //     begin
        //         Rec.Validate("Bal. Account No.", rec."SFPL Bal. Account No.");
        //     end;
        // }
    }
    trigger OnAfterInsert()
    var
        UserSetupRec: Record "User Setup";
        FixedAssetRec: Record "Fixed Asset";
        DefaultDimension: Record "Default Dimension";
    begin
        If UserId <> 'JOBQUEUE' Then begin
            IF "Journal Template Name" <> 'ASSETS' THEN BEGIN
                UserSetupRec.GET(USERID);
                UserSetupRec.TESTFIELD("Global Dimension 1 Code");
                IF NOT UserSetupRec."User Permission" THEN BEGIN
                    UserSetupRec.TESTFIELD("Global Dimension 2 Code");
                    Rec.VALIDATE("Shortcut Dimension 2 Code", UserSetupRec."Global Dimension 2 Code");
                    IF NOT UserSetupRec."HO Users" THEN BEGIN
                        UserSetupRec.TESTFIELD("Shortcut Dimension 3 Code");


                        Rec.VALIDATE("Shortcut Dimension 3 Code", UserSetupRec."Shortcut Dimension 3 Code");
                    END;
                END;
                Rec.VALIDATE("Shortcut Dimension 1 Code", UserSetupRec."Global Dimension 1 Code");

            END;

            IF (("Source Code" = 'FAGLJNL') AND ("Account Type" = "Account Type"::"Fixed Asset")) THEN BEGIN
                FixedAssetRec.RESET;
                if FixedAssetRec.GET("Account No.") then;
                Rec.VALIDATE("Shortcut Dimension 1 Code", FixedAssetRec."Global Dimension 1 Code");
                Rec.VALIDATE("Shortcut Dimension 2 Code", FixedAssetRec."Global Dimension 2 Code");
                DefaultDimension.RESET;
                DefaultDimension.SETRANGE("Table ID", 5600);
                DefaultDimension.SETRANGE("No.", "Account No.");
                DefaultDimension.SETRANGE("Dimension Code", 'LOC');
                IF DefaultDimension.FINDFIRST THEN
                    Rec.VALIDATE("Shortcut Dimension 3 Code", DefaultDimension."Dimension Value Code");

                ///MESSAGE('%1',FixedAssetRec."Global Dimension 2 Code");
                ////Rec.VALIDATE("Shortcut Dimension 3 Code",FixedAssetRec.
            END;
        end;
    end;

}