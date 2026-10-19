tableextension 50032 CustomerExt1 extends Customer
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
                if CopyStr(Rec."P.A.N. No.", 4, 1) = 'P' Then begin
                    if (Rec."P.A.N. No." <> 'PANAPPLIED') and (Rec."P.A.N. No." <> '') and (Rec."P.A.N. No." <> 'PANNOTAVBL') and (Rec."P.A.N. No." <> 'PANNOTAVBL') then
                        UpdateCustomer(Rec."No.", Rec."P.A.N. No.");
                end else
                    Rec.Validate("PAN Link Status", "PAN Link Status"::Operative);

            END;

        }
        // modify("Credit Limit (LCY)")
        // {
        //     // trigger OnAfterValidate()
        //     // begin
        //     //     "Remaining Credit Limit" := 0;
        //     //     CALCFIELDS("Balance (LCY)", "Shipped Not Invoiced (LCY)");
        //     //     IF "Credit Limit (LCY)" <> 0 THEN BEGIN
        //     //         IF ("Credit Limit (LCY)" - ("Balance (LCY)" + "Shipped Not Invoiced (LCY)")) < 0 THEN
        //     //             ERROR('Remaining Credit Limit cannot be less than 0')
        //     //         ELSE
        //     //             "Remaining Credit Limit" := "Credit Limit (LCY)" - ("Balance (LCY)" + "Shipped Not Invoiced (LCY)");
        //     //     END ELSE
        //     //         "Remaining Credit Limit" := 0;
        //     // end;
        // }
        modify("Salesperson Code")
        {
            trigger OnAfterValidate()
            var
                TeamSalesperson: Record 5084;
                Team: Record 5083;
            begin
                //gK
                TeamSalesperson.RESET;
                TeamSalesperson.SETRANGE("Salesperson Code", "Salesperson Code");
                IF TeamSalesperson.FINDFIRST THEN BEGIN
                    "Team Code" := TeamSalesperson."Team Code";
                END;
                Team.RESET;
                Team.SETRANGE(Code, "Team Code");
                IF Team.FINDFIRST THEN BEGIN
                    "Team Type" := Team."Team Type"
                END;
            end;
        }
        field(50000; "Aadhar No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-VG1.0';

            trigger OnValidate()
            begin
                IF "Aadhar No." <> 'N/A' THEN//PRU-VG
                    IF (STRLEN("Aadhar No.") <> 12) AND ("Aadhar No." <> '') THEN
                        ERROR(Text50001);//PRU-VG
            end;
        }
        field(50001; "Farmer Location"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Location WHERE("Use As In-Transit" = CONST(false),
                                            Farmer = CONST(true),
                "P.A.N" = FIELD("P.A.N. No."));
        }
        field(50002; "Incoming Document Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50003; "Document Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Type';
            OptionMembers = " ",Type;
        }
        field(50004; "Remaining Credit Limit"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-VG';
        }
        field(50005; Status; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU_NEELESH';
            Editable = false;
            OptionCaption = 'Open,Pending Approval,Approved';
            OptionMembers = Open,"Pending Approval",Approved;
        }
        field(50006; "Customer Type"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-AB';
            OptionCaption = ' ,Farmer,Trader,Direct';
            OptionMembers = " ",Farmer,Trader,Direct;
        }
        field(50007; "Customer Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Regular,Irregular,Suit Filed Cases,,Settled & Continue,Settled,Suit Case Withdraw,Working and Suit case';
            OptionMembers = Regular,Irregular,"Suit Filed Cases",SettledContinue,Settled,"Suit Case Withdraw","Working and Suit case";

            trigger OnValidate()
            begin
                IF "Customer Status" = "Customer Status"::"Suit Filed Cases" THEN
                    Blocked := Blocked::Invoice;
            end;
        }
        field(50008; "Freight Term"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,FOR,EX';
            OptionMembers = " ","FOR",EX;
        }
        field(50010; "Salesperson Code 2"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Salesperson Code 2';
            Description = 'Pru161220#P0272';
            TableRelation = "Salesperson/Purchaser" WHERE(Blocked = CONST(false));

            trigger OnValidate()
            begin
                ValidateSalesPersonCode;
            end;
        }
        field(50011; "Salesperson Code 3"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Salesperson Code 3';
            Description = 'Pru161220#P0272';
            TableRelation = "Salesperson/Purchaser" WHERE(Blocked = CONST(false));

            trigger OnValidate()
            begin
                ValidateSalesPersonCode;
            end;
        }
        field(50012; "CDS Credit Limit"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'MSZ';
        }
        field(50015; Monthly; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50016; Quaterly; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50017; "Half Yearly"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50018; Yearly; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50019; "Updated Credit Limit"; Decimal)
        {
            DataClassification = ToBeClassified;

        }
        field(50020; "TCS Sec 206"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50021; "GST Name"; Text[120])
        {
            DataClassification = ToBeClassified;
        }
        field(50022; "GST Address"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(50023; "GST Address 2"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(50024; "GST Post Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50025; "GST State Code"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50026; "GST Status"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50027; "Last Updated Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50028; "Team Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Team Salesperson" WHERE("Salesperson Code" = FIELD("Salesperson Code"));
        }
        field(50029; "Team Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Cattle,Poultry,CBF,SWINE';
            OptionMembers = " ",Cattle,Poultry,CBF,SWINE;
        }
        field(50030; "Broker Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Vendor."No." WHERE(Broker = FILTER(false));
        }
        field(50031; "Line Narration"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50032; "Outstanding SMS"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'Send Ountsting SMS by Code Unit';
        }
        field(50033; "Customer Cue Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50034; MTDAmt; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50035; YTDAmt; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50036; "TAN No."; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50037; "Old Customer No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50038; "Disable Customer Statement"; Boolean)
        {

            DataClassification = ToBeClassified;
        }
        field(50039; "PAN Link Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Operative,In-operative';
            OptionMembers = " ","Operative","Inoperative";
        }
        field(50040; "Created From Web"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50041; "KFC Customer"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50042; "Type of Customer"; Option)
        {
            OptionCaption = '  ,Institutional Consumer,Industrial Consumer';
            OptionMembers = " ","Institutional Consumer","Industrial Consumer";
        }
        field(50043; "Customer Location"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50044; "Freeze"; Boolean)
        {
            DataClassification = ToBeClassified;

        }
        field(50045; "Over Due Type"; Option)
        {
            OptionCaption = '  ,45 Days,60 Days,90 Days';
            OptionMembers = " ","45 Days","60 Days","90 Days";

        }
        field(50046; "WhatsApp Mobile No."; Text[10])
        {
            DataClassification = ToBeClassified;

        }
        field(50047; "WhatsApp SMS"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50048; "Dispatch SMS"; Boolean)
        {
            DataClassification = ToBeClassified;

        }
        field(50049; "Payment SMS"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Customer Payment SMS';
        }
        field(50050; "Sales Person Payment SMS"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50051; "Welcome Email"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50052; "PaymentQR"; Blob)
        {
            DataClassification = ToBeClassified;
            SubType = Bitmap;
        }
        field(50053; "Password"; Text[20])
        {
            DataClassification = ToBeClassified;
            ExtendedDatatype = Masked;
        }
        field(50054; "Password Reset in Next Login"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50055; "Mobile App Enable"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50056; "Alternate Phone No. 1"; Text[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50057; "Alternate Phone No. 2"; Text[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50058; "Alternate Phone No. 3"; Text[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50059; "Alternate Phone No. 4"; Text[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50060; "Alternate Phone No. 5"; Text[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50061; "API pan_type"; Text[100])
        {
            DataClassification = ToBeClassified;
        }

        field(50062; "API Full Name"; Text[150])
        {
            DataClassification = ToBeClassified;
        }

        field(50063; "API DOB"; Text[10])
        {
            DataClassification = ToBeClassified;
        }

        field(50064; "API aadhaar Seeding Status"; Text[10])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }

        field(50065; "Activate Credit Days Limit"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'This is for Star foods';
        }
    }
    var
        Text50000: Label 'P.A.N. no. should not be less then 10 characters.';
        Text50001: Label 'Aadhar no. should not be less then 12 characters.';

    trigger OnBeforeInsert()
    var
        UserSetup: Record "User Setup";
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Customer Master", '%1', UserSetup."Access Customer Master"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You can not create new customer');
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
        "Outstanding SMS" := TRUE;
        "Dispatch SMS" := True;
        "Payment SMS" := True;
        "WhatsApp SMS" := True;
        "Sales Person Payment SMS" := True;
        "GST Customer Type" := "GST Customer Type"::Unregistered;// Suman 14-03-2024
    end;

    procedure ValidateSalesPersonCode()
    var
        SalespersonPurchaser: Record "Salesperson/Purchaser";
    begin
        IF "Salesperson Code" <> '' THEN
            IF SalespersonPurchaser.GET("Salesperson Code") THEN
                IF SalespersonPurchaser.VerifySalesPersonPurchaserPrivacyBlocked(SalespersonPurchaser) THEN
                    ERROR(SalespersonPurchaser.GetPrivacyBlockedGenericText(SalespersonPurchaser, TRUE));
    end;

    procedure UpdateCustomer(CustCode: Code[100]; PANNO: Code[10])
    var
        AccessTokenKey: Text;
        Customer: Record Customer;
        Expiresin: Integer;
        SalesReceivablesSetup: Record "Sales & Receivables Setup";
        ExpiryDT: DateTime;
        MessResponse: Text;
        CU50045: Codeunit 50060;

    begin
        if Customer.get(CustCode) then begin
            //if (Customer."PAN Link Status" <> Customer."PAN Link Status"::Operative) then begin
            CU50045.GetAccessToken(AccessTokenKey, Expiresin);
            CU50045.SetToken('MasterIndia', AccessTokenKey, DataScope::Module);
            CU50045.SendPANSearchRequest(PANNO, MessResponse);
            if MessResponse = 'YES' then begin
                Rec.Validate("PAN Link Status", Customer."PAN Link Status"::Operative);
                //Vendor."P.A.N. Status" := Vendor."P.A.N. Status"::" ";
            End else begin
                //Message(MessResponse);
                Rec.Validate("PAN Link Status", Customer."PAN Link Status"::Inoperative);


            end;


            //end;
        end;
    end;

}