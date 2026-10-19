tableextension 50010 ItemJournalLineExt extends "Item Journal Line"
{
    fields
    {
        modify("Operation No.")
        {
            trigger OnAfterValidate()
            var
                ItemRec: Record Item;
            begin
                if ItemRec.Get("Item No.") then
                    "Gen. Prod. Posting Group" := ItemRec."Gen. Prod. Posting Group";
            end;
        }


        modify("Item No.")
        {
            trigger OnAfterValidate()
            var
                ItemRec: Record Item;
                UserSetupRec: Record "User Setup";
                ProdOrder: Record "Production Order";
            begin
                if ItemRec.Get("Item No.") then;
                "Chicks Item" := ItemRec."Chicks Item"; //RK-PRU
                "Item Type" := ItemRec."Item Type";//PRU-VG

                If Rec."Order Type" = Rec."Order Type"::Production then begin
                    if rec."Journal Template Name" <> 'REVALUATIO' then begin
                        if Rec."Document No." <> '' then
                            ProdOrder.Get(ProdOrder.Status::Released, Rec."Document No.");
                        Rec."Bardana Generation Entry" := ProdOrder."Bardana RPO";
                    end;
                end;

                UserSetupRec.GET(UserId);
                if UserId <> 'JOBQUEUE' then begin
                    UserSetupRec.TESTFIELD("Global Dimension 1 Code");
                    Rec.VALIDATE("Responsibility Center", UserSetupRec."Responsibility Center");
                    Rec.VALIDATE("Shortcut Dimension 1 Code", UserSetupRec."Global Dimension 1 Code");
                    IF NOT UserSetupRec."User Permission" THEN BEGIN
                        UserSetupRec.TESTFIELD("Global Dimension 2 Code");
                        IF NOT UserSetupRec."HO Users" THEN
                            UserSetupRec.TESTFIELD("Shortcut Dimension 3 Code");
                        Rec.VALIDATE("Responsibility Center", UserSetupRec."Responsibility Center");
                        Rec.VALIDATE("Shortcut Dimension 1 Code", UserSetupRec."Global Dimension 1 Code");
                        Rec.VALIDATE("Shortcut Dimension 2 Code", UserSetupRec."Global Dimension 2 Code");

                        IF NOT UserSetupRec."HO Users" THEN
                            if not Rec."Bardana Generation Entry" then
                                Rec.VALIDATE("Shortcut Dimension 3 Code", UserSetupRec."Shortcut Dimension 3 Code");
                        IF NOT UserSetupRec."HO Users" THEN begin
                            if rec."Item No." <> '' then
                                if not Rec."Bardana Generation Entry" then
                                    Rec."Location Code" := UserSetupRec."Shortcut Dimension 3 Code";
                        END;
                    end;
                end;
            END;
        }
        modify(Quantity)
        {
            trigger OnAfterValidate()
            var
                UserSetupRec: Record "User Setup";
                CompanyInfo: Record "Company Information";
            begin
                CompanyInfo.Get;
                UserSetupRec.GET(USERID);
                if UserId <> 'JOBQUEUE' then begin
                    UserSetupRec.TESTFIELD("Global Dimension 1 Code");
                    Rec.VALIDATE("Responsibility Center", UserSetupRec."Responsibility Center");
                    Rec.VALIDATE("Shortcut Dimension 1 Code", UserSetupRec."Global Dimension 1 Code");
                    IF NOT UserSetupRec."User Permission" THEN BEGIN
                        UserSetupRec.TESTFIELD("Global Dimension 2 Code");
                        IF NOT UserSetupRec."HO Users" THEN
                            UserSetupRec.TESTFIELD("Shortcut Dimension 3 Code");
                        Rec.VALIDATE("Responsibility Center", UserSetupRec."Responsibility Center");
                        Rec.VALIDATE("Shortcut Dimension 1 Code", UserSetupRec."Global Dimension 1 Code");
                        Rec.VALIDATE("Shortcut Dimension 2 Code", UserSetupRec."Global Dimension 2 Code");
                        if CompanyInfo.SFPLCompany = CompanyInfo.SFPLCompany::Sampoorna Then begin
                            IF NOT UserSetupRec."HO Users" THEN
                                if not Rec."Bardana Generation Entry" then
                                    Rec.VALIDATE("Shortcut Dimension 3 Code", UserSetupRec."Shortcut Dimension 3 Code");
                            IF NOT UserSetupRec."HO Users" THEN
                                if rec."Item No." <> '' then
                                    if not Rec."Bardana Generation Entry" then
                                        Rec."Location Code" := UserSetupRec."Shortcut Dimension 3 Code";

                        end;
                    End;
                end;
            end;
        }
        modify("Location Code")
        {
            trigger OnAfterValidate()
            var
                UserSetupRec: Record "User Setup";
                Location: Record Location;
                CompanyInfo: Record "Company Information";
            begin
                CompanyInfo.Get;
                if UserId <> 'JOBQUEUE' then
                    If CompanyInfo.SFPLCompany = CompanyInfo.SFPLCompany::Sampoorna Then Begin
                        VALIDATE("Shortcut Dimension 3 Code", Rec."Location Code");
                        UserSetupRec.GET(USERID);
                        IF UserSetupRec."User Permission" THEN begin
                            Location.RESET;
                            Location.SETRANGE(Code, "Shortcut Dimension 3 Code");
                            IF Location.FINDFIRST THEN
                                VALIDATE("Shortcut Dimension 2 Code", Location."Global Dimension 2 Code");
                            Rec.Validate("Shortcut Dimension 3 Code", rec."Location Code");
                        END;
                    End;
            end;
        }
        field(50000; "Data Entry Sheet No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-DD-New Field Added';

        }
        field(50001; "Additional Unit Quantity"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-DD-New Field Added';
        }
        field(50002; "Additional Unit of Measure"; Code[10])
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-DD-New Field Added';
        }
        field(50003; Rejected; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-VG 4.0';
        }
        field(50004; Fertility; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-VG 4.0';
        }
        field(50005; Age; Integer)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-VG 4.0';
        }
        field(50006; "Breed Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-VG 4.0';
            TableRelation = "Breed Master";
        }
        field(50007; "Lay Day Comment"; Text[250])
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-VG 4.0';
        }
        field(50008; "Chicks Item"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'RK-PRU 1.0';
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
            begin
                ValidateShortcutDimCode(3, "Shortcut Dimension 3 Code");
            end;
        }
        field(50012; "Alternate UOM"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-VG';
            TableRelation = "Unit of Measure";
        }
        field(50013; "Alternate Quantity"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-VG';
        }
        field(50014; "Flock No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-VG';
            TableRelation = "Production Order"."No." WHERE(Status = FILTER('Released' | 'Finished'));
        }
        field(50015; "Item Type"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-VG';
            OptionCaption = ' ,Feed,Vaccination,Medicine,Bird,Chick,Egg,GEN,Other Suppliment,Premix,Feed Suppliment,Bardana,RM,Scrap';
            OptionMembers = " ",Feed,Vaccination,Medicine,Bird,Chick,Egg,GEN,"Other Suppliment",Premix,"Feed Suppliment",Bardana,RM,Scrap;
        }
        field(50016; "New Shortcut Dimension 3 Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            //  CaptionClass = '1,2,3,' + Text007;
            Caption = 'New Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));

            trigger OnValidate()
            begin
                TESTFIELD("Entry Type", "Entry Type"::Transfer);
                ValidateNewShortcutDimCode(3, "New Shortcut Dimension 3 Code");
            end;
        }
        field(50017; "Weak Mortality"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-VG';
        }
        field(50018; "Transit Mortality"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-VG';
        }
        field(50019; "Exclude Quantity of Mortality"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-VG';
        }
        field(50020; "Debit Note Type"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'Pru_gk';
            OptionCaption = ' ,Debit Note';
            OptionMembers = " ","Debit Note";
        }
        field(50021; "In-transit Mortality"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-VG';
        }
        field(50022; "Data Entry Type"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU_RPG MNF_0.1';
            OptionCaption = ' ,Mortality - Bird,Mortality - Chicks,Culls - Bird,Culls - Chicks,Sexing Error';
            OptionMembers = " ","Mortality - Bird","Mortality - Chicks","Culls - Bird","Culls - Chicks","Sexing Error";
        }
        field(50023; "Laying Entry Type"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU_RPG MNF_0.1';
            OptionCaption = ' ,Hatching Egg,Pullet Egg,Jumbo Egg,Crack Egg,Waste Egg,Misshapes Egg';
            OptionMembers = " ","Hatching Egg","Pullet Egg","Jumbo Egg","Crack Egg","Waste Egg","Misshapes Egg";
        }
        field(50024; "Hatching Entry Type"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU_RPG MNF_0.1';
            OptionCaption = ' ,Culls,Mortality,Dead in Shell,Egg Blast,Settable Egg, Salable Eggs,Hatchable Egg,Reject/Unhatched Egg,Infertile/Commercial Egg';
            OptionMembers = " ",Culls,Mortality,"Dead in Shell","Egg Blast","Settable Egg"," Salable Eggs","Hatchable Egg","Reject/Unhatched Egg","Infertile/Commercial Egg";
        }
        field(50025; "Descriptive Entry Type"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU_RPG MNF_0.1';
            OptionCaption = ' ,Weight Neuter,Weight Male,Weight Female,Temperature,CV,Water,Humidity,Lighting';
            OptionMembers = " ","Weight Neuter","Weight Male","Weight Female",Temperature,CV,Water,Humidity,Lighting;
        }
        field(50026; Consumption; Boolean)
        {
            Caption = 'Consumption';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50027; Region; Code[10])
        {
            Caption = 'Region';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50028; "Remaining Qty"; Decimal)
        {
            Caption = 'Remaining Qty';

            //DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
            FieldClass = FlowField;
            CalcFormula = Sum("Item Ledger Entry"."Remaining Quantity" WHERE("Item No." = FIELD("Item No."),
                                                                  "Location Code" = FIELD("Location Code"), "Remaining Quantity" = filter(<> 0)));
        }

        field(50029; "Apply Entry"; Integer)
        {
            Caption = 'Apply Entry';

            trigger OnLookup()
            var
                ItemLedgEntry: Record "Item Ledger Entry";
                ItemJnlLine2: Record "Item Journal Line";
                PositiveFilterValue: Boolean;
            begin
                ItemLedgEntry.Reset();
                ItemLedgEntry.SetRange("Item No.", Rec."Item No.");
                ItemLedgEntry.SetRange("Location Code", Rec."Location Code");
                ItemLedgEntry.SetRange(Positive, true);
                if PAGE.RunModal(PAGE::"Item Ledger Entries", ItemLedgEntry) = ACTION::LookupOK then begin
                    ItemJnlLine2 := Rec;
                    if "Apply Entry" = FieldNo("Apply Entry") then
                        ItemJnlLine2.Validate("Apply Entry", ItemLedgEntry."Entry No.")
                    else
                        ItemJnlLine2.Validate("Apply Entry", ItemLedgEntry."Entry No.");
                    Rec := ItemJnlLine2;
                end;

            end;

            trigger OnValidate()
            var
                ItemLedgEntry: Record "Item Ledger Entry";
                ItemTrackingLines: Page "Item Tracking Lines";
                ShowTrackingExistsError: Boolean;
                IsHandled: Boolean;
                ShouldCheckItemLedgEntryFieldsForOutput: Boolean;
            begin

                ItemLedgEntry.Reset();
                ItemLedgEntry.SetRange("Entry No.", "Apply Entry");
                If ItemLedgEntry.FindFirst() then
                    if Rec.Quantity < ItemLedgEntry.Quantity then begin
                        ItemLedgEntry.CalcFields("Purchase Amount (Actual)");
                        ItemLedgEntry.CalcFields("Purchase Amount (Expected)");
                        ItemLedgEntry.CalcFields("Cost Amount (Actual)");
                        if (ItemLedgEntry."Purchase Amount (Actual)" <> 0) or (ItemLedgEntry."Purchase Amount (Expected)" <> 0) then
                            Rec.Validate("Unit Amount", ((ItemLedgEntry."Purchase Amount (Actual)" + ItemLedgEntry."Purchase Amount (Expected)") / ItemLedgEntry.Quantity))
                        else
                            //     Rec.Validate("Unit Amount", (ItemLedgEntry."Purchase Amount (Expected)" / ItemLedgEntry.Quantity));

                            Rec.Validate("Unit Amount", (ItemLedgEntry."Cost Amount (Actual)" / ItemLedgEntry.Quantity));

                    end else begin
                        Error('You Can not apply the Morethan the Qty');
                    end;

            end;

        }
        field(50030; "Consumption Posting"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Consumable Setup"."Posting Group" Where("Item No." = field("Item No."));
        }
        field(50031; "Bardana Generation Entry"; Boolean)
        {
            DataClassification = ToBeClassified;

        }
        field(50032; "Manufacturing Date"; Date)
        {
            Caption = 'Manufacturing Date';
            DataClassification = CustomerContent;
        }
        field(50033; "New Manufacturing Date"; Date)
        {
            Caption = 'New Manufacturing Date';
            DataClassification = CustomerContent;
        }
        field(50034; "Finished OutPut Qty"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Prod. Order Line"."Finished Quantity" where("Prod. Order No." = field("Document No."), "Line No." = field("Order Line No."), "Item No." = field("Source No.")));

        }
        field(50035; "SFPLUserID"; Text[20])
        {
            DataClassification = CustomerContent;
        }
    }
    //SIM---Code Added----->>>>>>--------
    procedure CreateItemTrackingLines1(UpdateTracking: Boolean)
    var
        ItemJournalLine1: Record "Item Journal Line";
        ItemJnlLineReserve1: Codeunit "Item Jnl. Line-Reserve";
    begin
        ItemJournalLine1.Copy(Rec);
        ItemJnlLineReserve1.CreateItemTracking(ItemJournalLine1);
        if UpdateTracking then
            UpdateItemTracking1(ItemJournalLine1);
    end;

    procedure UpdateItemTracking1(var ItemJournalLine1: Record "Item Journal Line")
    var
        TempItemJournalLine: Record "Item Journal Line" temporary;
        TempTrackingSpecification: Record "Tracking Specification" temporary;
        SingleItemTrackingExists: Boolean;
    begin
        ItemJournalLine1.Find();
        TempItemJournalLine := ItemJournalLine1;

        if ItemJournalLine1.GetItemTracking1(TempTrackingSpecification) then
            if TempTrackingSpecification.Count() = 1 then begin
                SingleItemTrackingExists := true;
                ItemJournalLine1.CopyTrackingFromSpec(TempTrackingSpecification);
                ItemJournalLine1."Expiration Date" := TempTrackingSpecification."Expiration Date";
                ItemJournalLine1."Warranty Date" := TempTrackingSpecification."Warranty Date";
            end;

        if not SingleItemTrackingExists then begin
            ItemJournalLine1.ClearTracking();
            ItemJournalLine1.ClearDates();
        end;

        if not ItemJournalLine1.HasSameTracking(TempItemJournalLine) then
            ItemJournalLine1.Modify();
    end;

    procedure GetItemTracking1(var TempTrackingSpecification1: Record "Tracking Specification" temporary): Boolean
    var
        ReservationEntry1: Record "Reservation Entry";
        ItemTrackingManagement: Codeunit "Item Tracking Management";
    begin
        SetReservationFilters(ReservationEntry1);
        ReservationEntry1.ClearTrackingFilter();
        exit(ItemTrackingManagement.SumUpItemTracking(ReservationEntry1, TempTrackingSpecification1, false, true));
    end;
    //SIM---Code Added-----<<<<<<<--------
}