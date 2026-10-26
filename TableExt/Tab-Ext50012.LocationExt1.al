
tableextension 50012 LocationExt1 extends Location
{
    fields
    {
        field(50000; "Farm Type"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'RK-PRU 1.0';
            OptionCaption = ' ,Own Farm, Integration Farm';
            OptionMembers = " ","Own Farm"," Integration Farm";
        }
        field(50001; Farmer; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'RK-PRU 1.0';
        }
        field(50002; "Global Dimension 1 Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            Description = 'RK-PRU 1.0';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(50003; "Global Dimension 2 Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            CaptionClass = '1,1,2';
            Description = 'RK-PRU 1.0';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(50004; "Shortcut Dimension 3 Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            Description = 'RK-PRU 1.0';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));
        }
        field(50005; "Flock Prefix"; Code[10])
        {
            DataClassification = ToBeClassified;
            Description = 'RK-PRU 1.0';
        }
        field(50006; "Farmer Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            Description = 'RK-PRU 1.0';
        }
        field(50007; "Aadhar No."; Code[12])
        {
            DataClassification = ToBeClassified;
            Description = 'RK-PRU 1.0';
        }
        field(50008; "Farmer Group"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'RK-PRU 1.0';
            OptionCaption = ' ,PFG';
            OptionMembers = " ",PFG;
        }
        field(50009; "Payment Type"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'RK-PRU 1.0';
            OptionCaption = ' ,RTGS,NEFT,UPI';
            OptionMembers = " ",RTGS,NEFT,UPI;
        }
        field(50010; "Bank Name"; Text[30])
        {
            DataClassification = ToBeClassified;
            Description = 'RK-PRU 1.0';
        }
        field(50011; "IFSC Code"; Code[30])
        {
            DataClassification = ToBeClassified;
            Description = 'RK-PRU 1.0';
        }
        field(50012; "Total Sq.Ft Area"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'RK-PRU 1.0';

            trigger OnValidate()
            begin
                IF "Per Bird Sq. Ft" <> 0 THEN
                    Capicity := "Total Sq.Ft Area" / "Per Bird Sq. Ft";
            end;
        }
        field(50013; "Tds%"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'RK-PRU 1.0';
        }
        field(50014; "P.A.N"; Code[10])
        {
            DataClassification = ToBeClassified;
            Description = 'RK-PRU 1.0';

            trigger OnValidate()
            var
                p_gText: Text;
                p_gText1: Text;
                p_gText2: Text;
                p_gTextG: Text;
                p_gTextG1: Text;
                p_gTextG2: Text;
                p_gTextG3: Text;
                p_gTextG4: Text;
                p_gTextG5: Text;
                p_gTextG6: Text;
            begin
                IF "P.A.N" <> '' THEN//GK
                    IF (STRLEN("P.A.N") <> 10) AND ("P.A.N" <> '') THEN
                        ERROR(Text50000);//

                p_gText := '';
                p_gText := COPYSTR("P.A.N", 1, 1);
                p_gTextG := '';
                p_gTextG := COPYSTR("P.A.N", 2, 1);
                p_gTextG1 := '';
                p_gTextG1 := COPYSTR("P.A.N", 3, 1);
                p_gTextG2 := '';
                p_gTextG2 := COPYSTR("P.A.N", 4, 1);
                p_gTextG3 := '';
                p_gTextG3 := COPYSTR("P.A.N", 5, 1);
                p_gText1 := '';
                p_gText1 := COPYSTR("P.A.N", 6, 1);
                p_gTextG4 := '';
                p_gTextG4 := COPYSTR("P.A.N", 7, 1);
                p_gTextG5 := '';
                p_gTextG5 := COPYSTR("P.A.N", 8, 1);
                p_gTextG6 := '';
                p_gTextG6 := COPYSTR("P.A.N", 9, 1);
                p_gText2 := '';
                p_gText2 := COPYSTR("P.A.N", 10);
                //

                IF NOT (p_gText IN ['A' .. 'Z']) THEN
                    ERROR('First charecter need to be Alphabet');

                IF NOT (p_gTextG IN ['A' .. 'Z']) THEN
                    ERROR('Secound charecter need to be Alphabet');

                IF NOT (p_gTextG1 IN ['A' .. 'Z']) THEN
                    ERROR('Third charecter need to be Alphabet');

                IF NOT (p_gTextG2 IN ['A' .. 'Z']) THEN
                    ERROR('Fourth charecter need to be Alphabet');

                IF NOT (p_gTextG3 IN ['A' .. 'Z']) THEN
                    ERROR('Fifth charecter need to be Alphabet');

                IF NOT (FORMAT(p_gText1) IN ['0' .. '9']) THEN
                    ERROR('Sixth charecter need to be number');

                IF NOT (FORMAT(p_gTextG4) IN ['0' .. '9']) THEN
                    ERROR('Seventh charecter need to be number');

                IF NOT (FORMAT(p_gTextG5) IN ['0' .. '9']) THEN
                    ERROR('Eight charecter need to be number');

                IF NOT (FORMAT(p_gTextG6) IN ['0' .. '9']) THEN
                    ERROR('Ninth charecter need to be number');

                IF NOT (p_gText2 IN ['A' .. 'Z']) THEN
                    ERROR('last charecter need to be Alphabet');
            end;
        }
        field(50015; "Security Check 1"; Code[10])
        {
            DataClassification = ToBeClassified;
            Description = 'RK-PRU 1.0';
        }
        field(50016; "Security Check 2"; Code[10])
        {
            DataClassification = ToBeClassified;
            Description = 'RK-PRU 1.0';
        }
        field(50017; "Security Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'RK-PRU 1.0';
        }
        field(50018; "Bank Branch"; Code[25])
        {
            DataClassification = ToBeClassified;
            Description = 'RK-PRU 1.0';
        }
        field(50019; "Account No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'RK-PRU 1.0';
        }
        field(50020; Mandal; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'RK-PRU 1.0';
        }
        field(50021; "Date of Agreement"; Date)
        {
            DataClassification = ToBeClassified;
            Description = 'RK-PRU 1.0';
        }
        field(50022; Own; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'RK-PRU 1.0';
        }
        field(50023; Lease; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'RK-PRU 1.0';
        }
        field(50024; "Own Rental"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'RK-PRU 1.0';
        }
        field(50025; "Agreement End Date"; Date)
        {
            DataClassification = ToBeClassified;
            Description = 'RK-PRU 1.0';
        }
        field(50026; "Incoming Document Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
            Description = 'RK-PRU 1.0';
        }
        field(50027; "Document Type"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'RK-PRU 1.0';
            OptionCaption = ' ';
            OptionMembers = " ";
        }
        field(50028; Block; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'RK-PRU 1.0';
        }
        field(50029; "Per Bird Sq. Ft"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'RK-PRU 1.0';

            trigger OnValidate()
            begin
                IF "Total Sq.Ft Area" <> 0 THEN
                    Capicity := "Total Sq.Ft Area" / "Per Bird Sq. Ft";
            end;
        }
        field(50030; Capicity; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'RK-PRU 1.0';
        }
        field(50031; Grade; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,A,B,C,D';
            OptionMembers = " ",A,B,C,D;
        }
        field(50032; "Responsibility Center"; Code[10])
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-VG-RC';
            TableRelation = "Responsibility Center";
        }
        field(50033; "Rejection Location"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-VG';
        }
        field(50034; "Farmer Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-VG';
            TableRelation = Vendor;

            trigger OnValidate()
            var
                Vendor: Record Vendor;
            begin

                //RK-PRU
                Vendor.GET("Farmer Code");
                "Farmer Name" := Vendor.Name;
                //RK-PRU
            end;
        }
        field(50035; "Liquidation Date"; Date)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-VG';

        }
        field(50036; "Shed Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Normal,EC,Super Deluxe';
            OptionMembers = " ",Normal,EC,"Super Deluxe";
        }
        field(50037; "Dimension Set ID"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50038; "Shortcut Dimension 1 Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate()
            begin
                //ValidateShortcutDimCode(3,"Shortcut Dimension 3 Code");
                Rec.ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");

            end;
        }
        field(50039; "Shortcut Dimension 2 Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            CaptionClass = '1,1,2';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
            end;
        }
        field(50040; "Location Type"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU_AS0.003';
            OptionMembers = " ",HO,Store,Farm;
        }
        field(50041; "Location Mail ID"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50042; "Electricity Connection Number"; Code[30])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                Location_T: Record 14;
                AllReadyLoc: Text;
            begin
                //Pru_gk
                Location_T.RESET;
                Location_T.SETRANGE("Electricity Connection Number", "Electricity Connection Number");
                Location_T.SETFILTER(Code, '<>%1', Code);
                IF Location_T.FINDFIRST THEN
                    REPEAT
                        AllReadyLoc += Location_T.Code + ',';
                    UNTIL Location_T.NEXT = 0;
                IF AllReadyLoc <> '' THEN
                    MESSAGE('This Electricity Connection Number is already being used in all these locations. %1', AllReadyLoc);
                //Pru_gk
            end;
        }
        field(50043; "Farm address"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50044; "Farm address 2"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50045; "Line No."; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Line Name (CBF)"."Line Code" WHERE("Branch Code" = FIELD("Global Dimension 2 Code"));
        }
        field(60001; "E-Invoicing User Name"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(60002; "E-Invoicing User Password"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50046; "Region Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Region Code';
            TableRelation = Region;

        }
        field(50047; "Posted Serv. Trans. Shpt. Nos."; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Posted Serv. Trans. Shpt. Nos.';
            TableRelation = "No. Series";
        }
        field(50048; "Posted Serv. Trans. Rcpt. Nos."; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Posted Serv. Trans. Rcpt. Nos.';
            TableRelation = "No. Series";
        }
        field(50049; "GST Liability Invoice1"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'GST Liability Invoice';
            TableRelation = "No. Series";
        }

        field(50050; "Purch. Inv. Nos. (Unreg)"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Purch. Inv. Nos. (Unreg)';
            TableRelation = "No. Series";
        }
        field(50051; "Purch. Cr. Memo Nos. (Unreg)"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Purch. Cr. Memo Nos. (Unreg)';
            TableRelation = "No. Series";
        }
        field(50052; "Purch. Inv. Nos. (Unreg Supp)"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Purch. Inv. Nos. (Unreg Supp)';
            TableRelation = "No. Series";
        }
        field(50053; "Pur. Inv. Nos.(Unreg Deb.Note)"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Pur. Inv. Nos.(Unreg Deb.Note)';
            TableRelation = "No. Series";
        }
        field(50054; "GST Transfer Shipment No."; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'GST Transfer Shipment No.';
            TableRelation = "No. Series";
        }
        /*
        field(50055; "Posted Dist. Invoice Nos."; Code[10])
        {DataClassification = ToBeClassified;
            Caption = 'Posted Dist. Invoice Nos.';
            TableRelation = "No. Series";
        }
        field(50056; "Posted Dist. Cr. Memo Nos."; Code[10])
        {DataClassification = ToBeClassified;
            Caption = 'Posted Dist. Cr. Memo Nos.';
            TableRelation = "No. Series";
        }
        */
        field(50057; "Receipt Nos. for Bonded Loc."; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Receipt Nos. for Bonded Loc.';
            TableRelation = "No. Series";
        }

        field(50058; "Purch. Inv. Nos. (Reg)"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Purch. Inv. Nos. (Reg)';
            TableRelation = "No. Series";
        }
        field(50059; "Purch. Inv. Nos. (Reg Supp)"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Purch. Inv. Nos. (Reg Supp)';
            TableRelation = "No. Series";
        }
        field(50060; "Pur. Inv. Nos.(Reg Deb.Note)"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Pur. Inv. Nos.(Reg Deb.Note)';
            TableRelation = "No. Series";
        }
        field(50061; "Purch. Cr. Memo Nos. (Reg)"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Purch. Cr. Memo Nos. (Reg)';
            TableRelation = "No. Series";
        }
        field(50062; "Purch. Invoice Nos."; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Purch. Invoice Nos.';
            TableRelation = "No. Series";
        }
        field(50063; "Purch. Receipt Nos."; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Purch. Receipt Nos.';
            TableRelation = "No. Series";
        }
        field(50064; "Sales Invoice Nos."; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Sales Invoice Nos.';
            TableRelation = "No. Series";
        }
        field(50065; "Sales Shipment Nos."; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Sales Shipment Nos.';
            TableRelation = "No. Series";
        }

        field(50066; "Sales Shipment Nos. (Captive)"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Sales Shipment Nos. (Captive)';
            TableRelation = "No. Series";
        }
        field(50067; "Purch. Credit Memo Nos."; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Purch. Credit Memo Nos.';
            TableRelation = "No. Series";
        }
        field(50068; "Sales Return Receipt Nos."; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Sales Return Receipt Nos.';
            TableRelation = "No. Series";
        }
        field(50069; "Sales Credit Memo Nos."; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Sales Credit Memo Nos.';
            TableRelation = "No. Series";
        }
        field(50070; "Purch. Ret. Shipment Nos."; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Purch. Ret. Shipment Nos.';
            TableRelation = "No. Series";
        }
        field(50071; "Transfer Shipment Nos."; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Transfer Shipment Nos.';
            TableRelation = "No. Series";
        }
        field(50072; "Transfer Receipt Nos."; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Transfer Receipt Nos.';
            TableRelation = "No. Series";
        }
        field(50073; "Purh. Invoice Nos. (Trading)"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Purh. Invoice Nos. (Trading)';
            TableRelation = "No. Series";
        }
        field(50074; "Sales Invoice Nos. (Trading)"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Sales Invoice Nos. (Trading)';
            TableRelation = "No. Series";
        }
        field(50075; "Sales Ret Rcpt Nos. (Trading)"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Sales Ret Rcpt Nos. (Trading)';
            TableRelation = "No. Series";
        }
        field(50076; "Purch. Ret Shpt Nos. (Trading)"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Purch. Ret Shpt Nos. (Trading)';
            TableRelation = "No. Series";
        }
        field(50077; "Purch. Rcpt. Nos. (Trading)"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Purch. Rcpt. Nos. (Trading)';
            TableRelation = "No. Series";
        }
        field(50078; "Sales Shpt. Nos. (Trading)"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Sales Shpt. Nos. (Trading)';
            TableRelation = "No. Series";
        }
        field(50079; "Purch Cr. Memo Nos. (Trading)"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Purch Cr. Memo Nos. (Trading)';
            TableRelation = "No. Series";
        }
        field(50080; "Sale Cr. Memo Nos. (Trading)"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Sale Cr. Memo Nos. (Trading)';
            TableRelation = "No. Series";
        }

        field(50081; "Posted Serv. Shipment Nos."; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Posted Serv. Shipment Nos.';
            TableRelation = "No. Series";
        }
        field(50082; "Posted Serv. Invoice Nos."; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Posted Serv. Invoice Nos.';
            TableRelation = "No. Series";
        }
        field(50083; "Posted Serv. Cr. Memo Nos."; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Posted Serv. Cr. Memo Nos.';
            TableRelation = "No. Series";
        }
        field(50084; "Serv. Shipment Nos. (Trading)"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Serv. Shipment Nos. (Trading)';
            TableRelation = "No. Series";
        }
        field(50085; "Serv. Invoice Nos. (Trading)"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Serv. Invoice Nos. (Trading)';
            TableRelation = "No. Series";
        }
        field(50086; "Serv. Cr. Memo Nos. (Trading)"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Serv. Cr. Memo Nos. (Trading)';
            TableRelation = "No. Series";
        }

        field(50087; "Sales Inv. Nos. (Exempt)"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Sales Inv. Nos. (Exempt)';
            TableRelation = "No. Series";
        }
        field(50088; "Sales Cr. Memo Nos. (Exempt)"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Sales Cr. Memo Nos. (Exempt)';
            TableRelation = "No. Series";
        }
        field(50089; "Sales Inv. No. (Export)"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Sales Inv. No. (Export)';
            TableRelation = "No. Series";
        }
        field(50090; "Sales Cr. Memo No. (Export)"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Sales Cr. Memo No. (Export)';
            TableRelation = "No. Series";
        }
        field(50091; "Sales Inv. No. (Supp)"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Sales Inv. No. (Supp)';
            TableRelation = "No. Series";
        }
        field(50092; "Sales Cr. Memo No. (Supp)"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Sales Cr. Memo No. (Supp)';
            TableRelation = "No. Series";
        }
        field(50093; "Sales Inv. No. (Debit Note)"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Sales Inv. No. (Debit Note)';
            TableRelation = "No. Series";
        }
        field(50094; "Serv. Inv. Nos. (Exempt)"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Serv. Inv. Nos. (Exempt)';
            TableRelation = "No. Series";
        }
        field(50095; "Serv. Cr. Memo Nos. (Exempt)"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Serv. Cr. Memo Nos. (Exempt)';
            TableRelation = "No. Series";
        }
        field(50096; "Serv. Inv. Nos. (Export)"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Serv. Inv. Nos. (Export)';
            TableRelation = "No. Series";
        }
        field(50097; "Serv. Cr. Memo Nos. (Export)"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Serv. Cr. Memo Nos. (Export)';
            TableRelation = "No. Series";
        }
        field(50098; "Serv. Inv. Nos. (Supp)"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Serv. Inv. Nos. (Supp)';
            TableRelation = "No. Series";
        }
        field(50099; "Serv. Cr. Memo Nos. (Supp)"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Serv. Cr. Memo Nos. (Supp)';
            TableRelation = "No. Series";
        }
        field(50100; "Serv. Inv. Nos. (Debit Note)"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Serv. Inv. Nos. (Debit Note)';
            TableRelation = "No. Series";
        }
        field(50101; "Sales Inv. Nos. (Non-GST)"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Sales Inv. Nos. (Non-GST)';
            TableRelation = "No. Series";
        }
        field(50102; "Old No. Series"; Code[20])
        {
            TableRelation = "No. Series".Code;
            DataClassification = ToBeClassified;
        }
        field(50103; "Old Location No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50104; "Vendor No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Vendor;
        }
        field(50105; "Status"; Option)
        {

            DataClassification = ToBeClassified;
            Description = 'PRU_NEELESH';
            Editable = false;
            OptionCaption = 'Open,Pending Approval,Approved';
            OptionMembers = Open,"Pending Approval",Approved;
        }
        field(50106; "Stock Report For Managment"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50107; "Send mail Report 50136"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }
    trigger OnInsert()
    begin
        //PRU-VG
        UserSetup.GET(USERID);
        VALIDATE("Responsibility Center", UserSetup."Responsibility Center");
        //PRU-VG
    end;

    var
        UserSetup: Record "User Setup";
        Text000: label 'You cannot delete the %1 %2, because they contain items.';
        Text001: label 'You cannot delete the %1 %2, because one or more Warehouse Activity Lines exist for this %1.';
        Text002: label '%1 must be Yes, because the bins contain items.';
        Text003: label 'Cancelled.';
        Text004: label 'The total quantity of items in the warehouse is 0, but the Adjustment Bin contains a negative quantity and other bins contain a positive quantity.\';
        Text005: label 'Do you still want to delete this %1?';
        Text006: label 'You cannot change the %1 until the inventory stored in %2 %3 is 0.';
        Text007: label 'You have to delete all Adjustment Warehouse Journal Lines first before you can change the %1.';
        Text008: label '%1 must be %2, because one or more %3 exist.';
        Text009: label 'You cannot change %1 because there are one or more open ledger entries on this location.';
        Text010: label 'Checking item ledger entries for open entries...';
        Text011: label 'You cannot change the %1 to %2 until the inventory stored in this bin is 0.';
        Text012: label 'Before you can use Online Map, you must fill in the Online Map Setup window.\See Setting Up Online Map in Help.';
        Text013: label 'You cannot delete %1 because there are one or more ledger entries on this location.';
        Text014: label 'You cannot change %1 because one or more %2 exist.';
        Text16500: label 'The T.I.N. no. for the state %1 should be start with %2.';
        Text50000: label 'P.A.N. no. should not be less then 10 characters.';

    procedure ValidateShortcutDimCode(FieldNumber: Integer; VAR ShortcutDimCode: Code[20])
    var
        OldDimSetID: Integer;
        DimMgt: Codeunit DimensionManagement;
    begin
        OldDimSetID := "Dimension Set ID";
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
        IF Code <> '' THEN
            MODIFY;

        IF OldDimSetID <> "Dimension Set ID" THEN BEGIN
            MODIFY;
        END;
    END;
}