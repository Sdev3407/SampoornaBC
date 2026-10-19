tableextension 50039 ProductionOrderExt extends "Production Order"
{
    fields
    {

        modify("Source No.")
        {
            trigger OnAfterValidate()
            var
                recItem: Record Item;
                VersionMgt: Codeunit VersionManagement;
                UserRec: Record "User Setup";
            begin

                //Pru_P0272 >>
                IF "Source Type" = "Source Type"::Item THEN BEGIN
                    recItem.RESET;
                    recItem.SETRANGE("No.", "Source No.");
                    recItem.SETFILTER("Production BOM No.", '<>%1', '');
                    IF recItem.FINDFIRST THEN BEGIN
                        "Prod. Bom No." := recItem."Production BOM No.";
                        "BOM Version No" := VersionMgt.GetBOMVersion(recItem."Production BOM No.", WORKDATE, TRUE);
                        MODIFY;
                        //ProdBomEdit := FALSE
                    END ELSE BEGIN
                        "Prod. Bom No." := '';
                        "BOM Version No" := '';
                        MODIFY;
                        //ProdBomEdit := TRUE;
                    END;
                END;
                UserRec.Get(USERID);
                IF NOT UserRec."User Permission" THEN BEGIN
                    Rec.VALIDATE("Shortcut Dimension 1 Code", UserRec."Global Dimension 1 Code");
                    Rec.VALIDATE("Shortcut Dimension 2 Code", UserRec."Global Dimension 2 Code");
                    IF NOT UserRec."HO Users" THEN BEGIN
                        Rec.VALIDATE("Shortcut Dimension 3 Code", UserRec."Shortcut Dimension 3 Code");
                    END;
                END;
                // <<
            end;
        }
        modify("Location Code")
        {
            trigger OnAfterValidate()
            var
                UserSetup: Record "User Setup";
                Location: Record Location;
                UserRec: Record "User Setup";
                companyInfo: Record "Company Information";
            begin
                companyInfo.Get;

                UserRec.Get(USERID);
                Rec.VALIDATE("Shortcut Dimension 1 Code", UserRec."Global Dimension 1 Code");
                IF NOT UserRec."User Permission" THEN BEGIN
                    Rec.VALIDATE("Shortcut Dimension 1 Code", UserRec."Global Dimension 1 Code");
                    Rec.VALIDATE("Shortcut Dimension 2 Code", UserRec."Global Dimension 2 Code");
                    IF NOT UserRec."HO Users" THEN BEGIN
                        Rec.VALIDATE("Shortcut Dimension 3 Code", UserRec."Shortcut Dimension 3 Code");
                    END;
                END;
                // CLEAR("Shortcut Dimension 2 Code");
                If companyInfo.SFPLCompany = companyInfo.SFPLCompany::Sampoorna Then Begin
                    UserSetup.GET(USERID);
                    IF UserSetup."User Permission" THEN begin
                        Location.RESET;
                        Location.SETRANGE(Code, "Location Code");
                        IF Location.FINDFIRST THEN BEGIN
                            Rec.VALIDATE("Shortcut Dimension 2 Code", Location."Global Dimension 2 Code");
                            //     Rec.MODIFY;
                        END;
                    End;
                END;
                If companyInfo.SFPLCompany = companyInfo.SFPLCompany::Sampoorna Then
                    Rec.VALIDATE("Shortcut Dimension 3 Code", "Location Code");
                // Rec.VALIDATE("Shortcut Dimension 2 Code");

            end;
        }
        field(50000; "Hatching Date"; Date)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-DD-New Field Added';
        }
        field(50001; "Transfer Order No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-DD-New Field Added';
        }
        field(50002; "Breed Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-DD-New Field Added';
            TableRelation = "Breed Master";
        }
        field(50003; "Transfer Line No."; Integer)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-DD-New Field Added';
        }
        field(50004; "Hatchery Entry"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-DD-New Field Added';
        }
        field(50005; "Responsibility Center"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-DD-New Field Added';
            TableRelation = "Responsibility Center";
        }
        field(50006; "Shortcut Dimension 3 Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,3';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(3, "Shortcut Dimension 3 Code");
            end;
        }
        field(50007; Stage; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Brooding-1,Brooding-2,Layer-1,Layer-2,Layer-3,Layer-4';
            OptionMembers = " ","Brooding-1","Brooding-2","Layer-1","Layer-2","Layer-3","Layer-4";
        }
        field(50008; "Opening Male Bird"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50009; "Opening Female Bird"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50010; "Short Close"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-VG';
        }
        field(50011; "Hatchery Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-VG';
        }
        field(50012; "Hatchery No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-VG';
            TableRelation = "Hatchery Name"."Hatchery No.";

            trigger OnValidate()
            var
                HatcheryName: Record 50025;
            begin
                HatcheryName.RESET;
                HatcheryName.SETRANGE("Hatchery No.", "Hatchery No.");
                IF HatcheryName.FINDFIRST THEN
                    "Hatchery Name" := HatcheryName."Hatchery Name";
            end;
        }
        field(50013; "STD %"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'Pru_gk';
        }
        field(50014; "Laying EGG Week"; Integer)
        {
            DataClassification = ToBeClassified;
            Description = 'Pru_gk';
            Editable = true;
            TableRelation = "Age Wk & STD %";

            trigger OnValidate()
            var
                T_50026: Record 50026;
            begin
                IF T_50026.GET("Laying EGG Week") THEN
                    "STD %" := T_50026."CHICKS PRODUCTION %"
                ELSE
                    "STD %" := 0;
            end;
        }
        field(50021; "Flock No.(Breeder)"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-RV';

            trigger OnLookup()
            var
                ProductionOrder_Loc1: Record 5405;
                ProductionOrderList_page: Page 99000815;
            begin
                //>>PRU_RPG
                ProductionOrder_Loc1.RESET;
                ProductionOrder_Loc1.SETFILTER(Status, '%1|%2', ProductionOrder_Loc1.Status::Released, ProductionOrder_Loc1.Status::Finished);
                IF ProductionOrder_Loc1.FINDSET THEN BEGIN
                    IF PAGE.RUNMODAL(99000815, ProductionOrder_Loc1) = ACTION::LookupOK THEN BEGIN
                        VALIDATE("Flock No.(Breeder)", ProductionOrder_Loc1."Description 2");

                    END;
                END;
                //<PRU_RPG
            end;
        }
        field(50022; "DOC Placing Date"; Date)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU_RPG MNF_0.1';
        }
        field(50023; "Flock Value"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU_RPG MNF_0.1';
        }
        field(50024; "Supervisor Name"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee."No.";
        }
        field(50025; "Bardana RPO"; Boolean)
        {
            DataClassification = CustomerContent;
        }

        field(50031; "Prod. Bom No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'Pru_P0272';
            TableRelation = IF ("Location Code" = FILTER(<> '')) "Production BOM Header"."No." WHERE("Location Code 1" = FIELD("Location Code"),
                                                                                               "Item No." = FIELD("Source No."));

            trigger OnValidate()
            var
                ProductionBOMHeader: Record "Production BOM Header";
                VersionMgt: Codeunit VersionManagement;
            begin
                TESTFIELD("Location Code");
                /*
                IF "Prod. Bom No." <> '' THEN BEGIN
                  IF CONFIRM('Do you want to insert Production BOM Lines?') THEN
                    InsertBomComp("Prod. Bom No.", "Location Code");
                END;
                 */
                CLEAR("BOM Version No");
                ProductionBOMHeader.RESET;
                ProductionBOMHeader.SETRANGE("No.", "Prod. Bom No.");
                IF ProductionBOMHeader.FINDFIRST THEN
                    "BOM Version No" := VersionMgt.GetBOMVersion("Prod. Bom No.", WORKDATE, TRUE);


            end;
        }
        field(50032; "Prod. Bom Description"; Text[50])
        {
            DataClassification = ToBeClassified;
            Description = 'Pru_P0272';
        }
        field(50033; "Batch Barcode"; BLOB)
        {
            DataClassification = ToBeClassified;
            SubType = Bitmap;
        }
        field(50034; "BOM Version No"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Production BOM Version"."Version Code" where("Production BOM No." = field("Prod. Bom No."), Status = Filter('Certified'));
            
            // end;
        }
        field(50035; "Batch Size"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,0.8,1.0,1.5,2.0';
            OptionMembers = " ","0.8","1.0","1.5","2.0";
        }
        field(50036; "Reopened"; Boolean)
        {
            Caption = 'Reopened';
            Editable = false;
        }
        field(50037; "RPO Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Processing,Portion,Re-Process,Third Party';
            OptionMembers = " ","Processing","Portion","Re-Process","Third Party";
        }
        field(50038; "Lot No."; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50039; "SFPL User ID"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(60000; "Check"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }
    trigger OnAfterInsert()
    var
        UserSetup: Record "User Setup";

        MfgRecSetup: Record "Manufacturing Setup";
        MfgSetup: Record "Responsibility Center";
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access R Prod. Order", '%1', UserSetup."Access R Prod. Order"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You can not create Released Production Order');
        //PRU_DD 1.10

        //PRU_DD 1.10
        //MfgSetup.GET;
        UserSetup.GET(USERID);
        UserSetup.TESTFIELD("Responsibility Center");
        MfgSetup.GET(UserSetup."Responsibility Center");
    end;

    trigger OnAfterModify()
    begin
        //TESTFIELD("Shortcut Dimension 1 Code");
        //TESTFIELD("Shortcut Dimension 2 Code");
        //TESTFIELD("Shortcut Dimension 3 Code");
    end;
}