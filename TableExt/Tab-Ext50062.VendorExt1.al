tableextension 50062 VendorExt1 extends Vendor
{
    fields
    {
        modify("P.A.N. No.")
        {
            trigger OnAfterValidate()
            var
                p_gText: Text[30];
                p_gText1: Text[30];
                p_gText2: Text[30];
                p_gTextG: Text[30];
                p_gTextG1: Text[30];
                p_gTextG2: Text[30];
                p_gTextG3: Text[30];
                p_gTextG4: Text[30];
                p_gTextG5: Text[30];
                p_gTextG6: Text[30];
                UpdatePANDeatil: Codeunit 50060;

                Text50000: Label 'P.A.N. no. should not be less then 10 characters.';
            begin
                IF Rec."P.A.N. No." <> '' THEN//GK
                 begin
                    IF (STRLEN(Rec."P.A.N. No.") <> 10) AND (Rec."P.A.N. No." <> '') THEN
                        ERROR(Text50000);//GK

                    p_gText := '';
                    p_gText := COPYSTR(Rec."P.A.N. No.", 1, 1);
                    p_gTextG := '';
                    p_gTextG := COPYSTR(Rec."P.A.N. No.", 2, 1);
                    p_gTextG1 := '';
                    p_gTextG1 := COPYSTR(Rec."P.A.N. No.", 3, 1);
                    p_gTextG2 := '';
                    p_gTextG2 := COPYSTR(Rec."P.A.N. No.", 4, 1);
                    p_gTextG3 := '';
                    p_gTextG3 := COPYSTR(Rec."P.A.N. No.", 5, 1);
                    p_gText1 := '';
                    p_gText1 := COPYSTR(Rec."P.A.N. No.", 6, 1);
                    p_gTextG4 := '';
                    p_gTextG4 := COPYSTR(Rec."P.A.N. No.", 7, 1);
                    p_gTextG5 := '';
                    p_gTextG5 := COPYSTR(Rec."P.A.N. No.", 8, 1);
                    p_gTextG6 := '';
                    p_gTextG6 := COPYSTR(Rec."P.A.N. No.", 9, 1);
                    p_gText2 := '';
                    p_gText2 := COPYSTR(Rec."P.A.N. No.", 10);
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
                    //
                END;
                // if CopyStr(Rec."P.A.N. No.", 4, 1) = 'P' Then begin
                //     if (Rec."P.A.N. No." <> 'PANAPPLIED') and (Rec."P.A.N. No." <> '') and (Rec."P.A.N. No." <> 'PANNOTAVBL') and (Rec."P.A.N. No." <> 'PANNOTAVBL') then
                //         UpdateVendor(Rec."No.", Rec."P.A.N. No.");
                // end else
                //     Rec.Validate("PAN Link Status", "PAN Link Status"::Operative);


            END;

        }
        field(50000; Farmer; Boolean)
        {
            DataClassification = ToBeClassified;

        }
        field(50001; Broker; Boolean)
        {
            DataClassification = ToBeClassified;

        }
        field(50002; "Aadhar No."; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(50003; MSME; Text[30])
        {
            DataClassification = ToBeClassified;

        }
        field(50004; "Type of Enterprise"; Option)
        {
            DataClassification = ToBeClassified;

            OptionCaption = ' ,A,B,C,D,E,F';
            OptionMembers = " ",A,B,C,D,E,F;
        }
        field(50005; "Creditors Type"; Option)
        {
            DataClassification = ToBeClassified;

            OptionCaption = ' ,SOYA CREDITORS,OTHER GRAIN CREDITORS,MEDICINE CREDITORS,CAPEX CREDITORS,SERVICE CREDITORS,IMPORT CREDITORS,MISCELLANEOUS CREDITORS,Maize Creditors,BAJRA Creditors,Wheat Creditors,Mustard DOC Creditors,D.D.G.S Creditors,DEOILED RICE BRAN Creditors,Birds Creditor,Chicks Creditor,Gen Item,Hatching Egg Outside,Premix,Rice Bran Oil,Rice Bran Polish,Rice Kanni,Lime Stone Power,Gaur Meal,Chicken Waste Meal,P.P Bags,Other';
            OptionMembers = " ","SOYA CREDITORS","OTHER GRAIN CREDITORS","MEDICINE CREDITORS","CAPEX CREDITORS","SERVICE CREDITORS","IMPORT CREDITORS","MISCELLANEOUS CREDITORS","Maize Creditors","BAJRA Creditors","Wheat Creditors","Mustard DOC Creditors","D.D.G.S Creditors","DEOILED RICE BRAN Creditors","Birds Creditor","Chicks Creditor","Gen Item","Hatching Egg Outside",Premix,"Rice Bran Oil","Rice Bran Polish","Rice Kanni","Lime Stone Power","Gaur Meal","Chicken Waste Meal","P.P Bags",Other;
        }
        field(50006; Status; Option)
        {
            DataClassification = ToBeClassified;

            Editable = false;
            OptionCaption = 'Open,Pending Approval,Approved';
            OptionMembers = Open,"Pending Approval",Approved;
        }
        field(50007; "TDS 194Q"; Boolean)
        {
            DataClassification = ToBeClassified;

        }
        field(50009; "GST Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50010; "GST Address"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(50011; "GST Address 2"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50012; "GST Post Code"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50013; "GST State Code"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50014; "GST Status"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50015; "Last Updated Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50016; "Vendor Cue Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50017; MTDAmt; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50018; YTDAmt; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50019; "G/L Reco Vendor"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50020; "TAN No."; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50021; "Old Vendor No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50022; "Incoming Document Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50023; "Transporter ID"; Code[20])
        {
            //TableRelation = "No. Series".Code;
            DataClassification = ToBeClassified;
        }
        field(50024; "Constitution of Business"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Foreign Company,Foreign Limited Liability Partnership,Government Department,Hindu Undivided Family,Limited Liability Partnership,Local Authority,Others,Partnership,Private Limited Company,Proprietorship,Public Limited Company,Public Sector Undertaking,Society/ Club/ Trust/ AOP,Statutory Body,Unlimited Company';
            OptionMembers = " ","Foreign Company","Foreign Limited Liability Partnership","Government Department","Hindu Undivided Family","Limited Liability Partnership","Local Authority",Others,Partnership,"Private Limited Company","Proprietorship","Public Limited Company","Public Sector Undertaking","Society/ Club/ Trust/ AOP","Statutory Body","Unlimited Company";
        }
        field(50025; "PAN Link Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Operative,In-operative';
            OptionMembers = " ","Operative","Inoperative";
        }
        field(50026; "SFPL_POS as Vendor State"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'POS as Vendor State';
        }
        field(50027; "SFPL_Security Balance"; Decimal)
        {
            //DataClassification = ToBeClassified;
            Caption = 'Security Balance';
            FieldClass = FlowField;
            CalcFormula = - sum("Detailed Vendor Ledg. Entry".Amount where("Vendor No." = field("No."), "SFPL_Security Entry" = filter(True)));
        }
        field(50028; "Created From Web"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50029; "API Pan Status"; Text[40])
        {
            DataClassification = ToBeClassified;
        }

        field(50030; "API Full Name"; Text[150])
        {
            DataClassification = ToBeClassified;
        }

        field(50031; "API DOB"; Text[10])
        {
            DataClassification = ToBeClassified;
        }

        field(50032; "API PAN Type"; Text[100])
        {
            DataClassification = ToBeClassified;
        }

        field(50033; "API aadhaar Seeding Status"; Text[10])
        {
            DataClassification = ToBeClassified;
        }

    }

    trigger OnBeforeInsert()
    var
        UserSetup: Record "User Setup";
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Vendor Master", '%1', UserSetup."Access Vendor Master"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You can not create new vendor');
        //PRU_DD 1.10
    end;

    trigger OnAfterInsert()
    var
        UserSetup: Record "User Setup";
    begin
        //PRU-VG
        UserSetup.GET(USERID);
        VALIDATE("Responsibility Center", UserSetup."Responsibility Center");
        //PRU-VG
        "GST Vendor Type" := "GST Vendor Type"::Unregistered;// Suman 14-03-2024
    end;

    procedure UpdateVendor(VendCode: Code[100]; PANNo: Code[10])
    var
        AccessTokenKey: Text;
        Vendor: Record Vendor;
        Expiresin: Integer;
        SalesReceivablesSetup: Record "Sales & Receivables Setup";
        ExpiryDT: DateTime;
        MessResponse: Text;
        CU50045: Codeunit 50060;
    begin
        if Vendor.get(VendCode) then begin
            //if (Vendor."PAN Link Status" <> Vendor."PAN Link Status"::Operative) then begin
            CU50045.GetAccessToken(AccessTokenKey, Expiresin);
            CU50045.SetToken('MasterIndia', AccessTokenKey, DataScope::Module);
            CU50045.SendPANSearchRequest(PANNo, MessResponse);
            if MessResponse = 'YES' then begin
                Rec.Validate("PAN Link Status", Vendor."PAN Link Status"::Operative);
                //Vendor."P.A.N. Status" := Vendor."P.A.N. Status"::" ";
            End else begin
                //Message(MessResponse);
                Rec.Validate("PAN Link Status", Vendor."PAN Link Status"::Inoperative);
            End;
            //Vendor.Modify();
            // end;
        END;

    end;
}