tableextension 50060 TransferHeaderExt extends "Transfer Header"
{
    fields

    {
        modify("Transfer-from Code")
        {

            trigger OnAfterValidate()
            var
                UserSetup: Record "User Setup";
                Location: Record Location;
                T_14: Record Location;
            begin
                CompanyInfo.Get;
                //PRU_NEELESH 18022020
                IF T_14.GET("Transfer-from Code") THEN BEGIN
                    IF T_14."Responsibility Center" = 'CBF' THEN BEGIN  //PRU_KH_Exp1.1_28022020
                        IF T_14."Agreement End Date" <> 0D THEN
                            IF ((T_14."Agreement End Date" - TODAY) < 61) THEN
                                MESSAGE('Agreement End Date will be expired on %1 of Farm %2', T_14."Agreement End Date", T_14.Code);
                    END;  //PRU_KH_Exp1.1_28022020
                END;
                //PRU_NEELESH 18022020
                If CompanyInfo.SFPLCompany = CompanyInfo.SFPLCompany::Sampoorna then
                    Rec.VALIDATE("Shortcut Dimension 3 Code", "Transfer-from Code");

                Location.RESET;
                Location.SETRANGE(Code, "Transfer-from Code");
                IF Location.FINDFIRST THEN BEGIN
                    Rec.VALIDATE("Shortcut Dimension 1 Code", Location."Global Dimension 1 Code");
                    Rec.VALIDATE("Shortcut Dimension 2 Code", Location."Global Dimension 2 Code");
                    Rec.Validate("From State Code", Location."State Code");
                    If CompanyInfo.SFPLCompany = CompanyInfo.SFPLCompany::Sampoorna then
                        Rec.VALIDATE("Shortcut Dimension 3 Code", Location.Code);
                end;
                UserSetup.GET(USERID);
                IF UserSetup."User Permission" THEN BEGIN
                    Location.RESET;
                    Location.SETRANGE(Code, "Transfer-from Code");
                    IF Location.FINDFIRST THEN begin
                        Rec.Validate("Shortcut Dimension 1 Code", Location."Global Dimension 1 Code");
                        Rec.VALIDATE("Shortcut Dimension 2 Code", Location."Global Dimension 2 Code");
                    end;
                END;


                //PRU_RPG NDF_0.1
            end;
        }
        modify("Transfer-to Code")
        {
            trigger OnBeforeValidate()
            var
                Location: Record 14;
                Confirmed: Boolean;
                Location_Rec: Record 14;
                T_14: Record 14;
                RecLocation: Record Location;
            begin
                //+RK-PRU
                RecLocation.GET("Transfer-to Code");
                IF RecLocation.Block THEN
                    ERROR('Location must not block');

                ///Pru_gk1.1
                Location_Rec.RESET;
                Location_Rec.SETRANGE(Code, "Transfer-to Code");
                IF Location_Rec.FINDFIRST THEN BEGIN
                    VALIDATE("New Shortcut Dimension 1 Code", Location_Rec."Global Dimension 1 Code");
                    VALIDATE("New Shortcut Dimension 2 Code", Location_Rec."Global Dimension 2 Code");
                    VALIDATE("New LOB", Location_Rec."Global Dimension 1 Code");  //PRU_RPG NDF_0.1
                    VALIDATE("New Branch", Location_Rec."Global Dimension 2 Code"); //PRU_RPG NDF_0.1
                END;
            end;

            trigger OnAfterValidate()
            var
                Location: Record 14;
                Confirmed: Boolean;
                Location_Rec: Record 14;
                T_14: Record 14;
                RecLocation: Record Location;

            begin
                CompanyInfo.Get;
                Location.RESET;
                Location.SETRANGE(Code, "Transfer-from Code");
                IF Location.FINDFIRST THEN begin
                    Rec.Validate("Shortcut Dimension 1 Code", Location."Global Dimension 1 Code");
                    Rec.VALIDATE("Shortcut Dimension 2 Code", Location."Global Dimension 2 Code");
                    If CompanyInfo.SFPLCompany = CompanyInfo.SFPLCompany::Sampoorna then
                        Rec.VALIDATE("Shortcut Dimension 3 Code", Location.Code);
                end;
                RecLocation.Get("Transfer-to Code");
                Rec.Validate("To State Code", RecLocation."State Code");
            end;


        }
        field(50001; "Responsibility Center"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-DD-New Field Added';
            TableRelation = "Responsibility Center";
        }
        field(50002; "Shortcut Dimension 3 Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,3';
            Description = 'PRU_RPG NDF 0.1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(3, "Shortcut Dimension 3 Code");
                ValidateCustomShortcutDimCode(3, "Shortcut Dimension 3 Code");  //PRU_RPG NDF_0.1
            end;
        }
        field(50003; "New Shortcut Dimension 1 Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,1';
            Caption = 'New Shortcut Dimension 1 Code';
            Description = 'PRU-VG';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate()
            begin
                //ValidateShortcutDimCode(1,"Shortcut Dimension 1 Code");
            end;
        }
        field(50004; "New Shortcut Dimension 2 Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,2';
            Caption = 'New Shortcut Dimension 2 Code';
            Description = 'PRU-VG';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate()
            begin
                //ValidateShortcutDimCode(2,"Shortcut Dimension 2 Code");
            end;
        }
        field(50005; "Debit Note Type"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'Pru_gk';
            OptionCaption = ' ,Debit Note';
            OptionMembers = " ","Debit Note";
        }
        field(50007; Shipped; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU_AS0.003';
        }
        field(50008; "New LOB"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'New LOB';
            Description = 'PRU_RPG NDF 0.1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate()
            begin
                ValidateCustomShortcutDimCode(1, "New LOB");  //PRU_RPG NDF_0.1
                ValidateCustomShortcutDimCode(3, "Shortcut Dimension 3 Code");  //PRU_RPG NDF_0.1
            end;
        }
        field(50009; "New Branch"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'New Branch';
            Description = 'PRU_RPG NDF 0.1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate()
            begin
                ValidateCustomShortcutDimCode(2, "New Branch"); //PRU_RPG NDF_0.1
                ValidateCustomShortcutDimCode(3, "Shortcut Dimension 3 Code");  //PRU_RPG NDF_0.1
            end;
        }
        field(50010; "New Dimension Set ID"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'New Dimension Set ID';
            Description = 'PRU_RPG NDF 0.1';
            Editable = false;
            TableRelation = "Dimension Set Entry";
        }
        field(50011; "Approval Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Open,"Pending For Approval",Approved;
        }

        field(50012; "From State Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50013; "To State Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50014; "SFPL User ID"; text[20])
        {
            DataClassification = ToBeClassified;
            //Editable = false;
        }
        //SIM-----------Code Added-------------
        //SIM-----------Code Added-------------
        field(50050; "Transporter Code"; Code[20])
        {
            DataClassification = ToBeClassified;

            TableRelation = Vendor."No." where(Transporter = const(true));
            trigger OnValidate()
            var
                Transporter: Record Vendor;
            begin
                if Transporter.get("Transporter Code") then
                    "Transporter Name" := Transporter.Name;
            end;
        }
        field(50051; "Transporter Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                TestField("Transporter Code", '');
            end;
        }
        field(50052; "Freight Value"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        //SIM-----------Code Added-------------
    }
    trigger OnBeforeInsert()
    var
        UserSetup: Record "User Setup";
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Transfer Order", '%1', UserSetup."Access Transfer Order"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have Permission to Create Transfer Order');
        //PRU_DD 1.10
    end;

    LOCAL procedure TransferLinesExist(): Boolean
    var
        TransLine: Record "Transfer Line";
    begin
        TransLine.RESET;
        TransLine.SETRANGE("Document No.", "No.");
        EXIT(TransLine.FINDFIRST);
    END;

    procedure ValidateCustomShortcutDimCode(FieldNumber: Integer; VAR ShortcutDimCode: Code[20])
    var
        OldDimSetID: Integer;
        TransLine: Record "Transfer Line";
        DimMgt: Codeunit DimensionManagement;
    begin
        OldDimSetID := "New Dimension Set ID";
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "New Dimension Set ID");

        IF OldDimSetID <> "New Dimension Set ID" THEN BEGIN
            MODIFY;
            IF TransferLinesExist THEN BEGIN
                TransLine.RESET;
                TransLine.SETRANGE("Document No.", "No.");
                IF TransLine.FINDSET THEN BEGIN
                    REPEAT
                        TransLine."New LOB" := "New LOB";
                        TransLine."New Branch" := "New Branch";
                        TransLine."New Dimension Set ID" := "New Dimension Set ID";
                        TransLine.MODIFY;
                    UNTIL TransLine.NEXT = 0;
                END;
                // UpdateAllLineDimNewLOB("New Dimension Set ID",OldDimSetID);
            END;
        END;
    END;

    var
        CompanyInfo: Record "Company Information";

}