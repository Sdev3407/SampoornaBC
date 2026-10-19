table 50015 "GC Statement"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;

            trigger OnValidate()
            begin
                IF "No." <> xRec."No." THEN BEGIN
                    UserSetup.GET(USERID);
                    UserSetup.TESTFIELD("Responsibility Center");
                    RC.GET(UserSetup."Responsibility Center");
                    NoSeriesMgt.TestManual(RC."GC Statement Nos.");
                    "No. Series" := '';
                END;
            end;
        }
        field(2; "Farm Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = true;
            TableRelation = Location.Code where("Shortcut Dimension 1 Code" = filter('CBF'));

            trigger OnValidate()
            var
                T50021: Record 50021;
                Location: Record 14;
                Companyinfo: Record "Company Information";
            begin
                Companyinfo.get;
                IF Reclocation.GET("Farm Code") THEN
                    "Farm Name" := Reclocation.Name
                ELSE
                    "Farm Name" := '';
                ///Pru_gk
                IF Location.GET("Farm Code") THEN BEGIN
                    Validate("Farmer No.", Location."Farmer Code");
                    State := Location."State Code";
                    Bank := Location."Bank Name";
                    "Bank Branch" := Location."Bank Branch";
                    "Account No" := Location."Account No.";
                    "IFSC Code" := Location."IFSC Code";
                    "PAN No" := Location."P.A.N";
                    Region := Location."Region Code";

                END;
                ////Pru_gk
                IF Vendor.GET("Farmer No.") THEN begin
                    "Farmer Name" := Vendor.Name;
                end;
                If Companyinfo.SFPLCompany in [Companyinfo.SFPLCompany::Sampoorna] Then
                    Rec.VALIDATE("Shortcut Dimension 3 Code", "Farm Code");

                IF UserSetup."User Permission" THEN BEGIN
                    Location.RESET;
                    Location.SETRANGE(Code, "Farm Code");
                    IF Location.FINDFIRST THEN
                        Rec.VALIDATE("Shortcut Dimension 2 Code", Location."Global Dimension 2 Code");

                END;

            end;
        }
        field(3; "Farm Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(4; Region; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Region;
        }
        field(5; State; Code[10])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(6; Bank; Text[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(7; "IFSC Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(8; "Account No"; Text[30])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(9; "Flock No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Production Order"."No." WHERE(Status = FILTER(Released),
                                                          "Location Code" = FIELD("Farm Code"));

            trigger OnValidate()
            var
                T32: Record 32;
                T5405: Record 5405;
                T14: Record 14;
                T5407: Record 5407;
                DEL: Record 50005;
                MortalityValue: Decimal;
                SalesAmt: Decimal;
                SSL: Record 111;
                BirdSales: Decimal;
                TotalSales: Decimal;
                DiffDateSales: Integer;
                FeedConsumption: Decimal;
                FeedPositiveAdj: Decimal;
                MortalityOpening: Decimal;
                GC: Record 50015;
                GCStatement: Record 50015;
                ProductionOrder_T: Record 5405;
                Location_T: Record 14;
            begin
                //TESTFIELD("Std. Prod Cost");
                //TESTFIELD("Std. Sale Rate");
                TESTFIELD("Farm Code");
                /////Pru_gk
                ProductionOrder_T.RESET;
                ProductionOrder_T.SETRANGE("No.", "Flock No.");
                IF ProductionOrder_T.FINDFIRST THEN BEGIN
                    ProductionOrder_T.TESTFIELD("Location Code");
                    Location_T.GET(ProductionOrder_T."Location Code");
                    IF "Shed Type" <> Location_T."Shed Type" THEN
                        ERROR('The Shed type of selected Flock No. is different from the selected GC Statement');
                END;
                //Pru_gk

                GCStatement.RESET;
                GCStatement.SETRANGE("Shed Type", "Shed Type");
                GCStatement.SETFILTER("No.", '<>%1', "No.");
                GCStatement.SETRANGE("Flock No.", "Flock No.");
                GCStatement.SETRANGE(Posted, TRUE);
                IF GCStatement.FINDFIRST THEN BEGIN
                    ERROR('GC Statement already created with this Flock No.');
                END;

                ProductionOrder.RESET;
                ProductionOrder.SETRANGE("No.", "Flock No.");
                IF ProductionOrder.FINDFIRST THEN BEGIN
                    Employee.GET(ProductionOrder."Supervisor Name");
                    "Supervisor Name" := Employee.FullName;
                END ELSE
                    "Supervisor Name" := '';

            end;
        }
        field(10; "Farmer Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(11; Branch; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = true;
        }
        field(12; Line; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(13; "Bank Branch"; Text[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(14; "PAN No"; Code[10])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(15; Grade; Code[10])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(16; "Hatchery/Vendor"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(17; EEF; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 2;
            Editable = false;
        }
        field(18; "Chick Housed"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 2;
            Editable = false;
        }
        field(19; "Birds Sold (kg)"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 2;
            Editable = false;
        }
        field(20; "Birds Sold (Nos)"; Integer)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(21; "Feed Consumption(kgs)"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 2;
            Editable = false;
        }
        field(22; "Accidental Mort(Recovery)"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 2;
            Editable = false;
        }
        field(23; "Liquidation Date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = true;
            trigger OnValidate()
            var
                Location: Record 14;
            begin
                if Location.Get("Farm Code") then begin
                    Location."Liquidation Date" := "Liquidation Date";
                    Location.Modify(true);
                end;
            end;
        }
        field(24; "Receipt Date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(25; Mortality; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 2;
            Editable = false;
        }
        field(26; "Mortality %"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 2;
            Editable = false;
        }
        field(27; "Body Weight %"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 3;
            Editable = false;
        }
        field(28; "Short Excess"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 2;
            Editable = false;
        }
        field(29; "Mean Age"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 2;
            Editable = false;
        }
        field(30; "Age (In Days)"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 2;
            Editable = false;
        }
        field(31; "Sale rate"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 2;
            Editable = false;
        }
        field(32; "Sale Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 2;
            Editable = false;
        }
        field(33; FCR; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 3;
            Editable = false;
        }
        field(34; CFCR; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 3;
            Editable = false;
        }
        field(35; "Production Cost"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 2;
            Editable = false;
        }
        field(36; "Birds Rearing GC"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 2;
            Editable = false;
        }
        field(37; "Incentive for Low Cost"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Incentive for low Cost of production';
            DecimalPlaces = 2 : 2;
            Editable = false;
        }
        field(38; "Rate Incentive for Selling1"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 2;
            Editable = false;
        }
        field(39; "Rate Incentive for Selling2"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 2;
            Editable = false;
        }
        field(40; "Rate Incentive for Selling3"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 2;
            Editable = false;
        }
        field(41; "Summary Incentive1"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Summary Incentive @1 if Mortality is between 0 and 3';
            DecimalPlaces = 2 : 2;
            Editable = false;
        }
        field(42; "Summary Incentive2"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Summary Incentive @0.5 if Mortality is between 3.01 and 5';
            DecimalPlaces = 2 : 2;
            Editable = false;
        }
        field(43; "Feed Unloading Charges"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 2;
            Editable = false;
        }
        field(44; "Total Incentive (Add)"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 2;
            Editable = false;
        }
        field(45; "Deduction for high Mort"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 2;
            Editable = false;
        }
        field(46; "Excess FCR Over"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Excess FCR over 1.65, excess feed intake amt. deducted';
            DecimalPlaces = 2 : 2;
            Editable = false;
        }
        field(47; "Deduction for Shortage"; Decimal)
        {
            DATACLASSIFICATION = TOBECLASSIFIED;
            DecimalPlaces = 2 : 2;
            Editable = false;
        }
        field(48; "TOTAL DEDUCTION(LESS)"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 2;
            Editable = false;
        }
        field(49; "TOTAL AMOUNT PAYABLE"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 2;
            Editable = false;
        }
        field(50; "LESS: T.D.S @ 1%"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 2;
            Editable = false;
        }
        field(51; "AMOUNT PAYABLE AFTER T.D.S"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 2;
            Editable = false;
        }
        field(52; "SELF  DC NO :"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 2;
            Editable = false;
        }
        field(53; "AMOUNT payable per bird"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 2;
            Editable = false;
        }
        field(54; "G.M."; Text[30])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(55; "D.G.M"; Text[30])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(56; "A.G.M. Accounts"; Text[30])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(57; "Asst.  Manager Accounts"; Text[30])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(58; "Zone Manager"; Text[30])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(59; "Branch Manager"; Text[30])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(60; "Account Officer"; Text[30])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(61; "Checked By"; Text[30])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(62; "I Accept the above payment"; Text[30])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(63; "Farmer Signature"; Text[30])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(64; "Chick Cost Qty"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 2;
            Editable = false;
        }
        field(65; "Chick Cost Rate"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 2;
            Editable = false;
        }
        field(66; "Chik Cost Amt."; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 2;
            Editable = false;
        }
        field(67; "Feed Cost Qty"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 2;
            Editable = false;
        }
        field(68; "Feed Cost Rate"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 2;
            Editable = false;
        }
        field(69; "Feed Cost Amt."; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 2;
            Editable = false;
        }
        field(70; "Maize Cost Qty"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 2;
            Editable = false;
        }
        field(71; "Maize Cost Rate"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 2;
            Editable = false;
        }
        field(72; "Maize Cost Amt."; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 2;
            Editable = false;
        }
        field(73; "Medicine Cost Qty"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 2;
            Editable = false;
        }
        field(74; "Medicine Cost Rate"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 2;
            Editable = false;
        }
        field(75; "Medicne Cost Amt."; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 2;
            Editable = false;
        }
        field(76; "Vaccine Cost Qty"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 2;
            Editable = false;
        }
        field(77; "Vaccine Cost Rate"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 2;
            Editable = false;
        }
        field(78; "Vaccine Cost Amt."; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 2;
            Editable = false;
        }
        field(79; "AdministrationCost Rs2.2/Bird2"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'ADMINISTRATION COST (Rs 2.20 Per Birds)';
            DecimalPlaces = 2 : 2;
            Editable = false;
        }
        field(80; "TOTAL COST OF PRODUCTION2"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'TOTAL COST OF PRODUCTION';
            DecimalPlaces = 2 : 2;
            Editable = false;
        }
        field(81; "Cost of Prod./kg Before RC2"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 2;
            Editable = false;
        }
        field(82; "Bird Sold IN Kg.2  Qty."; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 2;
            Editable = false;
        }
        field(83; "Bird Sold IN Kg.2  Rate"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 2;
            Editable = false;
        }
        field(84; "Bird Sold IN Kg.2  Amt."; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 2;
            Editable = false;
        }
        field(85; "Bird Sold IN No. Qty."; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 2;
            Editable = false;
        }
        field(86; "Bird Sold IN No. Rate"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 2;
            Editable = false;
        }
        field(87; "Bird Sold IN No. Amt."; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 2;
            Editable = false;
        }
        field(88; "Cost of Prod. After RC2"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 2;
            Editable = false;
        }
        field(89; "Cost of Production Per Kg.2"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Cost of Production Per Kg.';
            DecimalPlaces = 2 : 2;
            Editable = false;
        }
        field(91; "F.C.R2"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'F.C.R';
            DecimalPlaces = 2 : 2;
            Editable = false;
        }
        field(92; "Average Body weight2"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 2;
            Editable = false;
        }
        field(93; "Prod. Cost After RC2"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 2;
            Editable = false;
        }
        field(94; "SALE AMOUNT2"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 2;
            Editable = false;
        }
        field(95; "NET PROFIT / (LOSS)"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 2;
            Editable = false;
        }
        field(96; "NET PROFIT/ (LOSS)/BIRD"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 2;
            Editable = false;
        }
        field(97; "Cost of Production Per Bird"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 2;
            Editable = false;
        }
        field(98; "Std. Prod Cost"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 2;
            Editable = false;
        }
        field(99; "Std. Sale Rate"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 2;
            Editable = false;
        }
        field(100; Receipt; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 2;
            Editable = false;
        }
        field(101; "No. Series"; Code[10])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(102; "Farmer No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = Vendor."No." WHERE(Farmer = CONST(true));

            trigger OnValidate()
            begin
                IF Vendor.GET("Farmer No.") THEN begin

                    "Farmer Name" := Vendor.Name
                END ELSE
                    "Farmer Name" := '';
            end;
        }
        field(103; "Shed Type"; Option)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            OptionCaption = ' ,Normal,EC,Super Deluxe';
            OptionMembers = " ",Normal,EC,"Super Deluxe";
        }
        field(104; "Shortcut Dimension 1 Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,1';
            Editable = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1),
                                                          Blocked = CONST(false));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
            end;
        }
        field(105; "Shortcut Dimension 2 Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,2';
            Editable = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2),
                                                          Blocked = CONST(false));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
            end;
        }
        field(106; "Shortcut Dimension 3 Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,3';
            Editable = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3),
                                                          Blocked = CONST(false));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(3, "Shortcut Dimension 3 Code");
            end;
        }
        field(107; "Responsibility Center"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(108; "Net Payable After TDS"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(109; "Std. GC Rate"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(110; Posted; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = true;
        }
        field(111; "Total of All Rate Incentive"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(112; "Actual Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(113; "Rate Incentive- Actual Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(480; "Dimension Set ID"; Integer)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(481; "EEF Incentives range from"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(482; "Max Rate Incentive Upto 2.5"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(483; "1st week mortality %"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(484; "Brooding Incentive"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(485; "1st week mortality"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(486; "Bird Rearing Charge for CB-New"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(487; "Std. Admin Cost"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50000; "Last USERID"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "Modified Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50002; "FEED Freight Charges"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50003; "Deduction for high Prod. Cost"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Deduction for high Prod. Cost';
        }
        field(50004; "Min. Growing Charge"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50010; "Other Supplement"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'Pru 081220 #P0272';
            Editable = false;
        }
        field(50012; "Feed Intake"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50013; "Cum. Feed Consuption"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50014; "Cum. Feed Std."; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50015; "Feed Return %"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50016; "Total Feed Receive"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50017; "Total Feed Shiped"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50018; "TDS Nature of Deduction"; Code[10])
        {
            DataClassification = ToBeClassified;

            trigger OnLookup()
            begin
                /*
                  SetFilterOnNODLines('','');
                  IF NODLines.FIND('-') THEN
                    REPEAT
                      TDSNOD.RESET;
                      TDSNOD.SETRANGE(Code,NODLines."NOD/NOC");
                   IF TDSNOD.FINDFIRST THEN
                     TDSNOD.MODIFYALL(Mark,TRUE);
                   COMMIT;
                   UNTIL NODLines.NEXT=0;

                  TDSNOD.RESET;
                  TDSNOD.SETRANGE(Mark,TRUE);
                  IF PAGE.RUNMODAL(PAGE::"TDS Nature of Deductions",TDSNOD)= ACTION::LookupOK THEN
                    "TDS Nature of Deduction" := TDSNOD.Code;
  *///S.M
                VALIDATE("TDS Nature of Deduction");
            end;

            trigger OnValidate()
            begin
                //       TDSNOD.MODIFYALL(Mark, FALSE);
                //     SetFilterOnNODLines("TDS Nature of Deduction", '');
            end;
        }
        field(50019; "Rate Incentive for Selling4"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50020; "Customer Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer."No." WHERE(Blocked = FILTER(' '),
                                               "P.A.N. No." = FIELD("PAN No"));
        }
        field(50021; "Supervisor Name"; Text[40])
        {
            DataClassification = ToBeClassified;
        }
        field(50022; "TDS Section"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Allowed Sections"."TDS Section" where("Vendor No" = field("Farmer No."));
        }

        field(50023; "Posting Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50024; "Premix Qty"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50025; "Premix Value"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Shed Type", "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        IF xRec."Shed Type" = xRec."Shed Type"::Normal THEN BEGIN
            UserSetup.RESET;
            UserSetup.SETRANGE("User ID", USERID);
            UserSetup.SETFILTER(UserSetup."Access Normal GC Statement", '%1', UserSetup."Access Normal GC Statement"::View);
            IF UserSetup.FINDFIRST THEN
                ERROR('You can not create Normal GC Statement');
        END;
        //PRU_DD 1.10

        IF xRec."Shed Type" = xRec."Shed Type"::EC THEN BEGIN
            UserSetup.RESET;
            UserSetup.SETRANGE("User ID", USERID);
            UserSetup.SETFILTER(UserSetup."Access EC GC Statement", '%1', UserSetup."Access EC GC Statement"::View);
            IF UserSetup.FINDFIRST THEN
                ERROR('You can not create EC GC Statement');
        END;
        //PRU_DD 1.10

        IF "No." = '' THEN BEGIN
            UserSetup.GET(USERID);
            UserSetup.TESTFIELD("Responsibility Center");
            RC.GET(UserSetup."Responsibility Center");
            RC.TESTFIELD("GC Statement Nos.");
            NoSeriesMgt.InitSeries(RC."GC Statement Nos.", xRec."No. Series", 0D, "No.", "No. Series");
        END;
        Rec.VALIDATE("Responsibility Center", UserSetup."Responsibility Center");
        Rec.VALIDATE("Shortcut Dimension 1 Code", UserSetup."Global Dimension 1 Code");
        Rec.VALIDATE("Shortcut Dimension 2 Code", UserSetup."Global Dimension 2 Code");
        Rec.VALIDATE("Shortcut Dimension 3 Code", UserSetup."Shortcut Dimension 3 Code");
        Rec.VALIDATE("Farm Code", UserSetup."Shortcut Dimension 3 Code");
    end;

    trigger OnModify()
    begin
        Rec."Modified Date" := DT2DATE(CURRENTDATETIME);// PRU_AS 13 NOV 2019
        Rec."Last USERID" := USERID;// PRU_AS 13 NOV 2019
    end;

    var
        Companyinfo: Record "Company Information";
        NoSeriesMgt: Codeunit 396;
        Reclocation: Record 14;
        UserSetup: Record 91;
        RC: Record 5714;
        Vendor: Record 23;
        HatchDate: Date;
        OtherSupplimentQty: Decimal;
        OtherSupRate: Decimal;
        TDSSetup: Record "TDS Setup";
        TDSP: Code[10];
        // NODNOCLines: Record 13785;
        // NODNOCHeader: Record 13786;
        AssesCode: Code[20];
        TDS: Decimal;
        // NODLines: Record "13785";
        //TDSNOD: Record "13726";
        ProductionOrder: Record 5405;
        Employee: Record 5200;


    procedure AssistEdit(OldGCStatement: Record 50015): Boolean
    begin
        UserSetup.GET(USERID);
        UserSetup.TESTFIELD("Responsibility Center");
        RC.GET(UserSetup."Responsibility Center");
        IF NoSeriesMgt.SelectSeries(RC."GC Statement Nos.", OldGCStatement."No. Series", "No. Series") THEN
            EXIT(TRUE);
    end;

    local procedure CalculatePart2()
    var
        Location: Record 14;
        T50020: Record 50020;
        T32: Record 32;
        MedicineAmt: Decimal;
    begin
        //Part2
        /*
        IF "Shed Type" = "Shed Type"::Normal THEN
        "Birds Rearing GC":=ABS("Birds Sold (kg)"*6)
        ELSE
        IF "Shed Type" = "Shed Type"::EC THEN
         "Birds Rearing GC" := ABS("Birds Sold (kg)"*7);
        IF ("Sale rate">72)THEN BEGIN
          IF "Sale rate"<=77 THEN
            "Rate Incentive for Selling1":=ABS(("Sale rate"-72.01)*0.05*"Birds Sold (kg)")
          ELSE
            "Rate Incentive for Selling1":=ABS(5*0.05*"Birds Sold (kg)");
        END ELSE
          "Rate Incentive for Selling1":=0;
        
        
        IF ABS("Sale rate")>77.1 THEN BEGIN
          IF ABS("Sale rate")<=82 THEN
            "Rate Incentive for Selling2" := ABS(("Sale rate"-77.01)*0.1*"Birds Sold (kg)")
          ELSE
            "Rate Incentive for Selling2":=ABS(5*0.1*"Birds Sold (kg)");
        END ELSE
          "Rate Incentive for Selling2" := 0;
        
        IF ABS("Sale rate")>82 THEN BEGIN
          IF ABS("Sale rate")<=110 THEN
            "Rate Incentive for Selling3":=ABS(("Sale rate"-82.015)*0.1*"Birds Sold (kg)")
          ELSE
            "Rate Incentive for Selling3":=ABS(5*0.15*"Birds Sold (kg)");
        END ELSE
          "Rate Incentive for Selling3" := 0;
        */

        IF (ABS("Mortality %") > 0) AND (ABS("Mortality %") <= 3) THEN
            "Summary Incentive1" := ABS("Birds Sold (Nos)" * 0.1);

        IF ("Mortality %" > 3) AND ("Mortality %" <= 5) THEN
            "Summary Incentive2" := ABS("Birds Sold (Nos)" * 0.5);

        "Feed Unloading Charges" := ABS("Feed Consumption(kgs)" / 1000 * 20);

        "Total Incentive (Add)" := ABS("Birds Rearing GC" + "Rate Incentive for Selling1" + "Rate Incentive for Selling2" +
        "Rate Incentive for Selling3" + "Rate Incentive for Selling4" + "Summary Incentive1" + "Summary Incentive2" + "Feed Unloading Charges");

        //part3
        IF ABS("Mortality %") > 6 THEN
            "Deduction for high Mort" := ABS((Mortality - (6 * Mortality / (Mortality / "Chick Housed" * 100))) * "Body Weight %" * 24);

        IF (CFCR < FCR) AND (CFCR > 1.7) THEN BEGIN
            "Excess FCR Over" := ABS(((CFCR - 1.7) * "Birds Sold (kg)" * 31))
        END ELSE BEGIN
            IF (FCR < CFCR) AND (FCR > 1.7) THEN
                "Excess FCR Over" := ABS(((FCR - 1.7) * "Birds Sold (kg)" * 31));
        END;

        IF ("Short Excess" > 0) AND ("Sale rate" <= 65) THEN BEGIN
            "Deduction for Shortage" := ABS("Short Excess" * "Body Weight %" * 65);
        END ELSE BEGIN
            IF ("Short Excess" > 0) AND ("Sale rate" > 65) THEN
                "Deduction for Shortage" := ABS("Short Excess" * "Body Weight %" * "Sale rate");
        END;

        "TOTAL DEDUCTION(LESS)" := ABS("Deduction for high Mort" + "Excess FCR Over" + "Deduction for Shortage");

        "TOTAL AMOUNT PAYABLE" := "Total Incentive (Add)" - "TOTAL DEDUCTION(LESS)";
        "LESS: T.D.S @ 1%" := "TOTAL AMOUNT PAYABLE" * 1 / 100;
        "AMOUNT PAYABLE AFTER T.D.S" := "TOTAL AMOUNT PAYABLE" - "LESS: T.D.S @ 1%";
        Receipt := ABS("AMOUNT PAYABLE AFTER T.D.S" - "SELF  DC NO :");

        "AMOUNT payable per bird" := "TOTAL AMOUNT PAYABLE" / "Chick Housed";

        //part4
        "Chick Cost Qty" := "Chick Housed";
        Location.GET("Farm Code");
        T50020.RESET;
        T50020.SETRANGE("Item Type", T50020."Item Type"::Chick);
        T50020.SETRANGE("State Code", Location."State Code");
        T50020.SETRANGE("Shed Type", "Shed Type");
        IF T50020.FINDFIRST THEN
            "Chick Cost Rate" := T50020.Rate;
        "Chik Cost Amt." := ABS("Chick Cost Qty" * "Chick Cost Rate");

        "Feed Cost Qty" := ABS("Feed Consumption(kgs)" - "Maize Cost Qty");
        T50020.RESET;
        T50020.SETRANGE("Item Type", T50020."Item Type"::Feed);
        T50020.SETRANGE("State Code", Location."State Code");
        T50020.SETRANGE("Shed Type", "Shed Type");
        IF T50020.FINDFIRST THEN
            "Feed Cost Rate" := T50020.Rate;
        "Feed Cost Amt." := ABS("Feed Cost Qty" * "Feed Cost Rate");


        "Maize Cost Amt." := ABS("Maize Cost Qty" * "Maize Cost Rate");

        T32.RESET;
        T32.SETCURRENTKEY("Entry Type", "Flock No.", "Item Type", "Location Code");
        T32.SETRANGE("Entry Type", T32."Entry Type"::Consumption);
        T32.SETRANGE("Document No.", "Flock No.");
        T32.SETFILTER("Item Type", '%1|%2', T32."Item Type"::Medicine, T32."Item Type"::Vaccination);
        T32.SETRANGE("Location Code", "Farm Code");
        T32.SETRANGE("In-transit Mortality", FALSE); ////Pru_gk 23092019
        T32.SETAUTOCALCFIELDS("Cost Amount (Actual)", "Cost Amount (Expected)");
        IF T32.FINDSET THEN
            REPEAT
                MedicineAmt += T32."Cost Amount (Actual)" + T32."Cost Amount (Expected)";
            UNTIL T32.NEXT = 0;
        "Medicne Cost Amt." := ABS(MedicineAmt);

        "AdministrationCost Rs2.2/Bird2" := ABS("Chick Cost Qty" * 2.2);

        "TOTAL COST OF PRODUCTION2" := ABS("Chik Cost Amt." + "Feed Cost Amt." + "Maize Cost Amt." + "Medicne Cost Amt." + "AdministrationCost Rs2.2/Bird2" +
                   "Vaccine Cost Amt." + "Other Supplement" + "Premix Value"); //Pru 111220 #P0272 v0.01


        "Bird Sold IN Kg.2  Qty." := ("Birds Sold (kg)");
        "Bird Sold IN Kg.2  Amt." := ("TOTAL AMOUNT PAYABLE");
        "Bird Sold IN Kg.2  Rate" := ("TOTAL AMOUNT PAYABLE" / "Birds Sold (kg)");
        "Cost of Prod./kg Before RC2" := ("TOTAL COST OF PRODUCTION2" / "Bird Sold IN Kg.2  Qty.");

        "Bird Sold IN No. Qty." := ("Birds Sold (Nos)");

        "Cost of Prod. After RC2" := ("TOTAL COST OF PRODUCTION2" + "Bird Sold IN Kg.2  Amt.");
        "Cost of Production Per Kg.2" := ("Cost of Prod. After RC2" / "Bird Sold IN Kg.2  Qty.");

        "Cost of Production Per Bird" := ABS("Cost of Prod. After RC2" / "Birds Sold (Nos)");
        "F.C.R2" := ABS(("Feed Cost Qty" + "Maize Cost Qty") / "Bird Sold IN Kg.2  Qty.");

        "Average Body weight2" := ABS("Bird Sold IN Kg.2  Qty." / "Bird Sold IN No. Qty.");

        "Prod. Cost After RC2" := ABS("Cost of Prod. After RC2");
        "SALE AMOUNT2" := ABS("Sale Amount");

        "NET PROFIT / (LOSS)" := ABS("Sale Amount" - "Cost of Prod. After RC2");
        "NET PROFIT/ (LOSS)/BIRD" := ABS("NET PROFIT / (LOSS)" / "Chick Cost Qty");
        "Production Cost" := "Cost of Prod./kg Before RC2";
        IF "Production Cost" > "Std. Prod Cost" THEN
            "Incentive for Low Cost" := 0
        ELSE
            "Incentive for Low Cost" := ABS(("Std. Prod Cost" - "Production Cost") * "Birds Sold (kg)" * 0.5);

    end;


    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    var
        DimMgt: Codeunit 408;
    begin
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
    end;


    procedure GCCalculation()
    var
        T5405: Record 5405;
        Location: Record 14;
        T50020: Record 50020;
        MedicineAmt: Decimal;
        T32: Record 32;
        T14: Record 14;
        T5407: Record 5407;
        DEL: Record 50005;
        MortalityValue: Decimal;
        SalesAmt: Decimal;
        TRS: Record "Transfer Shipment Line";
        TRR: Record "Transfer Receipt Line";
        SSL: Record 111;
        BirdSales: Decimal;
        BirdSaleInvoice: Decimal;
        BirdSalesTRS: Decimal;
        TotalSales: Decimal;
        TotalSalesInvoice: Decimal;
        TotalSalesTRS: Decimal;
        DiffDateSales: Integer;
        FeedConsumption: Decimal;
        FeedPositiveAdj: Decimal;
        MortalityOpening: Decimal;
        T50021: Record 50021;
        Whicheverishigher: Decimal;
        BirdSoldShipmentKg: Decimal;
        BirdSoldShipmentNos: Decimal;
        BirdSoldCMKg: Decimal;
        BirdSoldCMNos: Decimal;
        ILE: Record 32;
        DebitNoteQty: Decimal;
        TotalRateIncentive: Decimal;
        RateIncentive: Decimal;
    begin
        TESTFIELD("Flock No.");
        Location.GET("Farm Code");
        "Receipt Date" := T5405."Starting Date";
        T50021.RESET;
        T50021.SETRANGE("Shed Type", "Shed Type");
        T50021.SETRANGE("State Code", Location."State Code");
        T50021.SETFILTER("Ending Date", '%1|>=%2', 0D, "Receipt Date"); /////Pru_gk
        T50021.SETRANGE("Starting Date", 0D, "Receipt Date");////Pru_gk
        IF T50021.FINDFIRST THEN BEGIN
            "Std. Prod Cost" := T50021."Std. Production Cost";
            "Std. Sale Rate" := T50021."Std. Sales Rate";
            "Std. GC Rate" := T50021."Std. GC Rate";
        END;

        T32.RESET;
        T32.SETCURRENTKEY("Entry Type", "Flock No.", "Item Type", "Location Code");
        T32.SETRANGE("Item Type", T32."Item Type"::Feed);
        T32.SETRANGE("Location Code", "Farm Code");
        T32.SETFILTER("In-transit Mortality", '%1', FALSE);
        T32.CALCSUMS(Quantity);
        IF T32.Quantity > 0 THEN
            ERROR('GC Cannot be calculated due to feed stock available in %1 Location', "Farm Code");

        CLEAR(DebitNoteQty);
        ILE.RESET;
        ILE.SETCURRENTKEY("Entry Type", "Flock No.", "Item Type", "Location Code");
        ILE.SETRANGE("Location Code", "Farm Code");
        ILE.SETRANGE("Flock No.", "Flock No.");
        ILE.SETRANGE("Item Type", ILE."Item Type"::Chick);
        ILE.SETRANGE("Document Type", ILE."Document Type"::"Transfer Shipment");
        ILE.SETRANGE("Debit Note Type", ILE."Debit Note Type"::"Debit Note");
        ILE.SETFILTER("In-transit Mortality", '%1', FALSE);
        IF ILE.FINDFIRST THEN
            REPEAT
                DebitNoteQty := -(ILE.Quantity);
            UNTIL ILE.NEXT = 0;

        T5405.RESET;
        T5405.SETRANGE("No.", "Flock No.");
        IF T5405.FINDFIRST THEN;
        "Chick Housed" := ABS(ROUND(T5405.Quantity - DebitNoteQty, 0.01, '='));
        T14.GET("Farm Code");
        T14.TESTFIELD("Liquidation Date");
        CLEAR(MedicineAmt);
        CLEAR(SalesAmt);
        CLEAR(BirdSales);
        Clear(BirdSaleInvoice);
        Clear(BirdSalesTRS);
        CLEAR(TotalSales);
        CLEAR(DiffDateSales);
        CLEAR(FeedConsumption);
        CLEAR(FeedPositiveAdj);
        CLEAR(MortalityOpening);
        CLEAR(BirdSoldCMKg);
        CLEAR(BirdSoldCMNos);
        CLEAR(BirdSoldShipmentKg);
        CLEAR(BirdSoldShipmentNos);
        CLEAR(HatchDate);
        "Liquidation Date" := T14."Liquidation Date";
        "Receipt Date" := T5405."Starting Date";
        HatchDate := T5405."Hatching Date";
        CLEAR(MortalityValue);
        DEL.RESET;
        DEL.SETRANGE("Flock No.", "Flock No.");
        DEL.SETRANGE(Posted, TRUE);
        DEL.SETFILTER("Mortality Type", '<>%1', DEL."Mortality Type"::" ");
        DEL.SETRANGE("Exclude Quantity of Mortality", FALSE);
        IF DEL.FINDSET THEN
            REPEAT
                MortalityValue += (DEL."Actual Value" - DEL."Reverse Qty.");
            UNTIL DEL.NEXT = 0;
        T32.RESET;
        T32.SETCURRENTKEY("Entry Type", "Flock No.", "Item Type", "Location Code");
        T32.SETRANGE("Entry Type", T32."Entry Type"::Consumption);
        T32.SETRANGE("Document No.", "Flock No.");
        T32.SETRANGE("Item Type", T32."Item Type"::Chick);
        T32.SETRANGE("Location Code", "Farm Code");
        T32.SETFILTER("Posting Date", '<%1', 20180401D);

        T32.SETFILTER("In-transit Mortality", '%1', FALSE); ////Pru_gk 23092019
        T32.CALCSUMS(Quantity);
        MortalityOpening := ABS(T32.Quantity);
        Mortality := ROUND(ABS(MortalityValue) + ABS(MortalityOpening), 0.01, '=');
        CLEAR(FeedConsumption);
        CLEAR(FeedPositiveAdj);
        T32.RESET;
        T32.SETCURRENTKEY("Entry Type", "Flock No.", "Item Type", "Location Code");
        T32.SETRANGE("Entry Type", T32."Entry Type"::Consumption);
        T32.SETRANGE("Document No.", "Flock No.");
        T32.SETRANGE("Item Type", T32."Item Type"::Feed);
        T32.SETRANGE("Location Code", "Farm Code");
        T32.SETFILTER("In-transit Mortality", '%1', FALSE);
        T32.CALCSUMS(Quantity);
        FeedConsumption := ABS(T32.Quantity);
        T32.RESET;
        T32.SETCURRENTKEY("Entry Type", "Flock No.", "Item Type", "Location Code");
        T32.SETRANGE("Entry Type", T32."Entry Type"::"Positive Adjmt.");
        T32.SETRANGE("Document No.", "Flock No.");
        T32.SETRANGE("Item Type", T32."Item Type"::Feed);
        T32.SETRANGE("Location Code", "Farm Code");
        T32.SETFILTER("In-transit Mortality", '%1', FALSE);
        T32.CALCSUMS(Quantity);
        FeedPositiveAdj := ABS(T32.Quantity);
        "Feed Consumption(kgs)" := ROUND(FeedConsumption - FeedPositiveAdj, 0.01, '=');
        T32.RESET;
        T32.SETCURRENTKEY("Entry Type", "Flock No.", "Item Type", "Location Code");
        T32.SETRANGE("Entry Type", T32."Entry Type"::Sale);
        T32.SETRANGE("Document Type", T32."Document Type"::"Sales Shipment");
        T32.SETRANGE("Flock No.", "Flock No.");
        T32.SETRANGE("Item Type", T32."Item Type"::Bird);
        T32.SETRANGE("Location Code", "Farm Code");
        T32.SETFILTER("In-transit Mortality", '%1', FALSE);
        T32.CALCSUMS(Quantity, "Alternate Quantity");
        BirdSoldShipmentKg := ROUND(ABS(T32.Quantity), 0.01, '=');
        BirdSoldShipmentNos := ROUND(ABS(T32."Alternate Quantity"), 0.01, '=');
        T32.RESET;
        T32.SETCURRENTKEY("Entry Type", "Flock No.", "Item Type", "Location Code");
        T32.SETRANGE("Entry Type", T32."Entry Type"::Sale);
        T32.SETRANGE("Document Type", T32."Document Type"::"Sales Return Receipt");
        T32.SETRANGE("Flock No.", "Flock No.");
        T32.SETRANGE("Item Type", T32."Item Type"::Bird);
        T32.SETRANGE("Location Code", "Farm Code");
        T32.SETFILTER("In-transit Mortality", '%1', FALSE);
        T32.CALCSUMS(Quantity, "Alternate Quantity");
        BirdSoldCMKg := ROUND(ABS(T32.Quantity), 0.01, '=');
        BirdSoldCMNos := ROUND(ABS(T32."Alternate Quantity"), 0.01, '=');
        "Birds Sold (kg)" := BirdSoldShipmentKg - BirdSoldCMKg;
        "Birds Sold (Nos)" := BirdSoldShipmentNos - BirdSoldCMNos;
        SSL.RESET;
        SSL.SETRANGE("Flock No.", "Flock No.");
        SSL.SETRANGE("Item Type", SSL."Item Type"::Bird);
        IF SSL.FINDFIRST THEN
            REPEAT
                //DiffDateSales := SSL."Posting Date"-"Receipt Date";
                DiffDateSales := SSL."Posting Date" - HatchDate;
                BirdSaleInvoice += SSL."Alternate Quantity";
                TotalSalesInvoice += SSL."Alternate Quantity" * DiffDateSales;
            UNTIL SSL.NEXT = 0;
        "Mean Age" := ROUND(TotalSales / BirdSales, 0.01, '=');

        "Mortality %" := ROUND(ABS(Mortality / "Chick Housed") * 100, 0.01, '=');
        "Body Weight %" := ROUND(ABS("Birds Sold (kg)" / "Birds Sold (Nos)"), 0.001, '=');
        "Age (In Days)" := ABS("Liquidation Date" - "Receipt Date");

        FCR := ROUND(ABS("Feed Consumption(kgs)" / "Birds Sold (kg)"), 0.001, '=');
        CFCR := ROUND(ABS((2 - "Body Weight %") / 4 + FCR), 0.001, '=');
        EEF := ROUND(((100 - "Mortality %") * "Body Weight %" / (FCR * "Mean Age") * 100), 1, '='); //Rk-PRU
        "Age (In Days)" := "Liquidation Date" - "Receipt Date" + 1; //RK-PRU
        T32.RESET;
        T32.SETCURRENTKEY("Entry Type", "Flock No.", "Item Type", "Location Code");
        T32.SETRANGE("Entry Type", T32."Entry Type"::Sale);
        T32.SETRANGE("Flock No.", "Flock No.");
        T32.SETRANGE("Item Type", T32."Item Type"::Bird);
        T32.SETRANGE("Location Code", "Farm Code");
        T32.SETFILTER("In-transit Mortality", '%1', FALSE);
        T32.SETAUTOCALCFIELDS("Sales Amount (Actual)", "Sales Amount (Expected)");
        IF T32.FINDSET THEN
            REPEAT
                SalesAmt += T32."Sales Amount (Actual)" + T32."Sales Amount (Expected)";
            UNTIL T32.NEXT = 0;
        TRS.RESET;
        TRS.SETCURRENTKEY("Flock No.", "Item Type", "Transfer-from Code");
        TRS.SETRANGE("Flock No.", "Flock No.");
        TRS.SETRANGE("Item Type", T32."Item Type"::Bird);
        TRS.SETRANGE("Transfer-from Code", "Farm Code");
        IF TRS.FINDSET THEN
            REPEAT
                SalesAmt += TRS.Amount;
            UNTIL TRS.NEXT = 0;

        TRR.RESET;
        TRR.SETCURRENTKEY("Flock No.", "Item Type", "Transfer-to Code");
        TRR.SETRANGE("Flock No.", "Flock No.");
        TRR.SETRANGE("Item Type", T32."Item Type"::Bird);
        TRR.SETRANGE("Transfer-to Code", "Farm Code");
        IF TRR.FINDSET THEN
            REPEAT
                SalesAmt += -(TRR.Amount);
            UNTIL TRR.NEXT = 0;



        ////
        "Sale Amount" := ROUND(ABS(SalesAmt), 0.01, '=');
        "Sale rate" := ROUND(ABS(SalesAmt / "Birds Sold (kg)"), 0.01, '=');
        "Short Excess" := ROUND("Chick Housed" - "Birds Sold (Nos)" - Mortality, 0.01, '=');


        //Part2
        ////IF "Shed Type" = "Shed Type"::Normal THEN
        "Birds Rearing GC" := ROUND(ABS("Birds Sold (kg)" * "Std. GC Rate"), 0.01, '=');
        ////ELSE
        /////IF "Shed Type" = "Shed Type"::EC THEN
        ///"Birds Rearing GC" := ROUND(ABS("Birds Sold (kg)"*"Std. GC Rate"),0.01,'=');
        ////ELSE

        IF Location."State Code" = 'JK' THEN
            "Rate Incentive for Selling1" := 0
        ELSE BEGIN
            IF ("Sale rate" > 72) THEN BEGIN
                IF "Sale rate" <= 77 THEN
                    "Rate Incentive for Selling1" := ROUND(ABS(("Sale rate" - 72.01) * 0.05 * "Birds Sold (kg)"), 0.01, '=')
                ELSE
                    "Rate Incentive for Selling1" := ROUND(ABS(5 * 0.05 * "Birds Sold (kg)"), 0.01, '=');
            END ELSE
                "Rate Incentive for Selling1" := 0;
        END;

        IF ABS("Sale rate") > 77.1 THEN BEGIN
            IF ABS("Sale rate") <= 82 THEN
                "Rate Incentive for Selling2" := ROUND(ABS(("Sale rate" - 77.01) * 0.1 * "Birds Sold (kg)"), 0.01, '=')
            ELSE
                IF Location."State Code" = 'JK' THEN
                    "Rate Incentive for Selling2" := ROUND(ABS(4.99 * 0.1 * "Birds Sold (kg)"), 0.01, '=')
                ELSE
                    "Rate Incentive for Selling2" := ROUND(ABS(5 * 0.1 * "Birds Sold (kg)"), 0.01, '=');
        END ELSE
            "Rate Incentive for Selling2" := 0;

        IF Location."State Code" = 'JK' THEN BEGIN
            IF ABS("Sale rate") > 82 THEN BEGIN
                IF ABS("Sale rate") <= 150 THEN
                    "Rate Incentive for Selling3" := ROUND(ABS(("Sale rate" - 82.015) * 0.15 * "Birds Sold (kg)"), 0.01, '=')
                ELSE
                    "Rate Incentive for Selling3" := ROUND(ABS(67.99 * 0.15 * "Birds Sold (kg)"), 0.01, '=');
            END ELSE
                "Rate Incentive for Selling3" := 0;
        END ELSE BEGIN
            IF "Shed Type" = "Shed Type"::Normal THEN BEGIN
                IF ABS("Sale rate") > 82 THEN BEGIN
                    IF ABS("Sale rate") <= 110 THEN
                        "Rate Incentive for Selling3" := ROUND(ABS(("Sale rate" - 82.01) * 0.15 * "Birds Sold (kg)"), 0.01, '=')
                    ELSE
                        "Rate Incentive for Selling3" := ROUND(ABS(27.99 * 0.15 * "Birds Sold (kg)"), 0.01, '=');
                END ELSE
                    "Rate Incentive for Selling3" := 0;
            END;
        END;

        IF "Shed Type" = "Shed Type"::Normal THEN BEGIN
            CLEAR(TotalRateIncentive);
            CLEAR(RateIncentive);

            TotalRateIncentive := "Rate Incentive for Selling2" + "Rate Incentive for Selling3";
            RateIncentive := TotalRateIncentive / "Birds Sold (kg)";
            IF RateIncentive > 2.5 THEN
                "Max Rate Incentive Upto 2.5" := "Birds Sold (kg)" * 2.5;
        END;
        IF (ABS("Mortality %") > 0) AND (ABS("Mortality %") <= 3) THEN
            IF Location."State Code" = 'JK' THEN
                "Summary Incentive1" := ROUND(ABS("Birds Sold (Nos)" * 0.8), 0.01, '=')
            ELSE
                "Summary Incentive1" := ROUND(ABS("Birds Sold (Nos)" * 1), 0.01, '=')
        ELSE
            "Summary Incentive1" := 0;

        IF Location."State Code" = 'JK' THEN BEGIN
            IF ("Mortality %" > 3) AND ("Mortality %" <= 4) THEN
                "Summary Incentive2" := ROUND(ABS("Birds Sold (Nos)" * 0.4), 0.01, '=')
            ELSE
                "Summary Incentive2" := 0;
        END ELSE BEGIN
            IF ("Mortality %" > 3) AND ("Mortality %" <= 5) THEN
                "Summary Incentive2" := ROUND(ABS("Birds Sold (Nos)" * 0.5), 0.01, '=')
            ELSE
                "Summary Incentive2" := 0;
        END;
        IF Location."State Code" = 'JK' THEN
            "Feed Unloading Charges" := 0
        ELSE
            "Feed Unloading Charges" := ROUND(ABS("Feed Consumption(kgs)" / 1000 * 20), 0.01, '=');



        //part3
        IF Location."State Code" = 'JK' THEN BEGIN
            IF ABS("Mortality %") > 7 THEN
                "Deduction for high Mort" := ROUND(ABS((Mortality - (7 * Mortality / (Mortality / "Chick Housed" * 100))) * "Body Weight %" * 25), 0.01, '=')
            ELSE
                "Deduction for high Mort" := 0;
        END ELSE BEGIN
            IF ABS("Mortality %") > 6 THEN
                "Deduction for high Mort" := ROUND(ABS((Mortality - (6 * Mortality / (Mortality / "Chick Housed" * 100))) * "Body Weight %" * 24), 0.01, '=')
            ELSE
                "Deduction for high Mort" := 0;
        END;
        ////vidit
        IF (CFCR <= FCR) THEN BEGIN
            IF (CFCR > 1.7) THEN
                "Excess FCR Over" := ((CFCR - 1.7) * "Birds Sold (kg)" * 31)
            ELSE
                "Excess FCR Over" := 0;
        END ELSE
            IF (FCR < CFCR) THEN BEGIN
                IF (FCR > 1.7) THEN
                    "Excess FCR Over" := ((FCR - 1.7) * "Birds Sold (kg)" * 31)
                ELSE
                    "Excess FCR Over" := 0;
            END ELSE
                "Excess FCR Over" := 0;
        CLEAR(Whicheverishigher);
        IF "Sale rate" <= 65 THEN
            Whicheverishigher := 65
        ELSE
            Whicheverishigher := "Sale rate";
        IF ("Short Excess" > 0) THEN
            "Deduction for Shortage" := ROUND(ABS("Short Excess" * "Body Weight %" * Whicheverishigher), 0.01, '=')
        ELSE
            "Deduction for Shortage" := 0;

        "TOTAL DEDUCTION(LESS)" := ROUND(ABS("Deduction for high Mort" + "Excess FCR Over" + "Deduction for Shortage"), 0.01, '=');


        //part4
        "Chick Cost Qty" := ROUND("Chick Housed", 0.01, '=');
        Location.GET("Farm Code");
        T50020.RESET;
        T50020.SETRANGE("Item Type", T50020."Item Type"::Chick);
        T50020.SETRANGE("State Code", Location."State Code");
        T50020.SETRANGE("Shed Type", "Shed Type");
        IF T50020.FINDFIRST THEN
            "Chick Cost Rate" := ROUND(T50020.Rate, 0.01, '=');
        "Chik Cost Amt." := ROUND(ABS("Chick Cost Qty" * "Chick Cost Rate"), 0.01, '=');

        "Feed Cost Qty" := ROUND(ABS("Feed Consumption(kgs)" - "Maize Cost Qty"), 0.01, '=');
        T50020.RESET;
        T50020.SETRANGE("Item Type", T50020."Item Type"::Feed);
        T50020.SETRANGE("State Code", Location."State Code");
        T50020.SETRANGE("Shed Type", "Shed Type");
        IF T50020.FINDFIRST THEN
            "Feed Cost Rate" := ROUND(T50020.Rate, 0.01, '=');
        "Feed Cost Amt." := ROUND(ABS("Feed Cost Qty" * "Feed Cost Rate"), 0.01, '=');

        "Maize Cost Amt." := ROUND(ABS("Maize Cost Qty" * "Maize Cost Rate"), 0.01, '=');

        T32.RESET;
        T32.SETCURRENTKEY("Entry Type", "Flock No.", "Item Type", "Location Code");
        T32.SETRANGE("Entry Type", T32."Entry Type"::Consumption);
        T32.SETRANGE("Document No.", "Flock No.");
        T32.SETFILTER("Item Type", '%1|%2', T32."Item Type"::Medicine, T32."Item Type"::Vaccination);
        T32.SETRANGE("Location Code", "Farm Code");
        T32.SETFILTER("In-transit Mortality", '%1', FALSE);
        T32.SETAUTOCALCFIELDS("Cost Amount (Actual)", "Cost Amount (Expected)");
        IF T32.FINDSET THEN
            REPEAT
                MedicineAmt += T32."Cost Amount (Actual)" + T32."Cost Amount (Expected)";
            UNTIL T32.NEXT = 0;
        "Medicne Cost Amt." := ROUND(ABS(MedicineAmt), 0.01, '=');


        IF Location."State Code" = 'JK' THEN
            "AdministrationCost Rs2.2/Bird2" := ROUND(ABS("Chick Cost Qty" * 3.3), 0.01, '=')
        ELSE
            "AdministrationCost Rs2.2/Bird2" := ROUND(ABS("Chick Cost Qty" * 2.2), 0.01, '=');

        "TOTAL COST OF PRODUCTION2" := ROUND(ABS("Chik Cost Amt." + "Feed Cost Amt." + "Maize Cost Amt." + "Medicne Cost Amt." + "AdministrationCost Rs2.2/Bird2" +
                   "Vaccine Cost Amt." + "Other Supplement" + "Premix Value"), 0.01, '='); //Pru 111220 #P0272  v0.01


        "Bird Sold IN Kg.2  Qty." := ROUND(("Birds Sold (kg)"), 0.01, '=');
        "Bird Sold IN Kg.2  Amt." := ROUND(("TOTAL AMOUNT PAYABLE"), 0.01, '=');
        "Bird Sold IN Kg.2  Rate" := ROUND(("TOTAL AMOUNT PAYABLE" / "Birds Sold (kg)"), 0.01, '=');
        "Cost of Prod./kg Before RC2" := ROUND(("TOTAL COST OF PRODUCTION2" / "Bird Sold IN Kg.2  Qty."), 0.01, '=');

        "Bird Sold IN No. Qty." := ROUND(("Birds Sold (Nos)"), 0.01, '=');

        "Cost of Prod. After RC2" := ROUND(("TOTAL COST OF PRODUCTION2" + "Bird Sold IN Kg.2  Amt."), 0.01, '=');
        "Cost of Production Per Kg.2" := ROUND(("Cost of Prod. After RC2" / "Bird Sold IN Kg.2  Qty."), 0.01, '=');

        "Cost of Production Per Bird" := ROUND(ABS("Cost of Prod. After RC2" / "Birds Sold (Nos)"), 0.01, '=');
        "F.C.R2" := ROUND(ABS(("Feed Cost Qty" + "Maize Cost Qty") / "Bird Sold IN Kg.2  Qty."), 0.001, '=');

        "Average Body weight2" := ROUND(ABS("Bird Sold IN Kg.2  Qty." / "Bird Sold IN No. Qty."), 0.001, '=');

        "Prod. Cost After RC2" := ROUND(ABS("Cost of Prod. After RC2"), 0.01, '=');
        "SALE AMOUNT2" := ROUND(ABS("Sale Amount"), 0.01, '=');

        "NET PROFIT / (LOSS)" := ROUND(ABS("Sale Amount" - "Cost of Prod. After RC2"), 0.01, '=');
        "NET PROFIT/ (LOSS)/BIRD" := ROUND(ABS("NET PROFIT / (LOSS)" / "Chick Cost Qty"), 0.01, '=');
        "Production Cost" := ROUND("Cost of Prod./kg Before RC2", 0.01, '=');
        IF "Production Cost" > "Std. Prod Cost" THEN
            "Incentive for Low Cost" := 0
        ELSE
            IF Location."State Code" = 'JK' THEN BEGIN
                "Incentive for Low Cost" := ROUND(ABS(("Std. Prod Cost" - "Production Cost") * "Birds Sold (kg)" * 0.4), 0.01, '=');
            END ELSE
                "Incentive for Low Cost" := ROUND(ABS(("Std. Prod Cost" - "Production Cost") * "Birds Sold (kg)" * 0.5), 0.01, '=');
        IF "Shed Type" = "Shed Type"::Normal THEN BEGIN
            IF RateIncentive < 2.5 THEN BEGIN
                "Total Incentive (Add)" := ROUND(ABS("Birds Rearing GC" + "Incentive for Low Cost" + "Rate Incentive for Selling1" + "Rate Incentive for Selling2" +
                "Rate Incentive for Selling3" + "Rate Incentive for Selling4" + "Summary Incentive1" + "Summary Incentive2" + "Feed Unloading Charges" + "Min. Growing Charge"), 0.01, '=')
            END ELSE BEGIN
                "Total Incentive (Add)" := ROUND(ABS("Birds Rearing GC" + "Incentive for Low Cost" + "Rate Incentive for Selling1" + "Max Rate Incentive Upto 2.5" + "Summary Incentive1" + "Summary Incentive2" + "Feed Unloading Charges" + "Min. Growing Charge"), 0.01, '=')
            END;
        END ELSE
            IF "Shed Type" = "Shed Type"::EC THEN BEGIN
                IF EEF >= 411 THEN
                    "EEF Incentives range from" := 2.6 * "Birds Sold (kg)"
                ELSE
                    IF EEF >= 406 THEN
                        "EEF Incentives range from" := 2.5 * "Birds Sold (kg)"
                    ELSE
                        IF EEF >= 401 THEN
                            "EEF Incentives range from" := 2.4 * "Birds Sold (kg)"
                        ELSE
                            IF EEF >= 396 THEN
                                "EEF Incentives range from" := 2.3 * "Birds Sold (kg)"
                            ELSE
                                IF EEF >= 391 THEN
                                    "EEF Incentives range from" := 2.2 * "Birds Sold (kg)"
                                ELSE
                                    IF EEF >= 386 THEN
                                        "EEF Incentives range from" := 2.1 * "Birds Sold (kg)"
                                    ELSE
                                        IF EEF >= 381 THEN
                                            "EEF Incentives range from" := 2 * "Birds Sold (kg)"
                                        ELSE
                                            IF EEF >= 376 THEN
                                                "EEF Incentives range from" := 1.9 * "Birds Sold (kg)"
                                            ELSE
                                                IF EEF >= 371 THEN
                                                    "EEF Incentives range from" := 1.8 * "Birds Sold (kg)"
                                                ELSE
                                                    IF EEF >= 366 THEN
                                                        "EEF Incentives range from" := 1.7 * "Birds Sold (kg)"
                                                    ELSE
                                                        IF EEF >= 361 THEN
                                                            "EEF Incentives range from" := 1.6 * "Birds Sold (kg)"
                                                        ELSE
                                                            IF EEF >= 356 THEN
                                                                "EEF Incentives range from" := 1.5 * "Birds Sold (kg)"
                                                            ELSE
                                                                IF EEF >= 351 THEN
                                                                    "EEF Incentives range from" := 1.4 * "Birds Sold (kg)"
                                                                ELSE
                                                                    IF EEF >= 346 THEN
                                                                        "EEF Incentives range from" := 1.3 * "Birds Sold (kg)"
                                                                    ELSE
                                                                        IF EEF >= 341 THEN
                                                                            "EEF Incentives range from" := 1.2 * "Birds Sold (kg)"
                                                                        ELSE
                                                                            IF EEF >= 336 THEN
                                                                                "EEF Incentives range from" := 1.1 * "Birds Sold (kg)"
                                                                            ELSE
                                                                                IF EEF >= 331 THEN
                                                                                    "EEF Incentives range from" := 1 * "Birds Sold (kg)"
                                                                                ELSE
                                                                                    IF EEF >= 326 THEN
                                                                                        "EEF Incentives range from" := 0.9 * "Birds Sold (kg)"
                                                                                    ELSE
                                                                                        IF EEF >= 321 THEN
                                                                                            "EEF Incentives range from" := 0.8 * "Birds Sold (kg)"
                                                                                        ELSE
                                                                                            IF EEF >= 316 THEN
                                                                                                "EEF Incentives range from" := 0.7 * "Birds Sold (kg)"
                                                                                            ELSE
                                                                                                IF EEF >= 311 THEN
                                                                                                    "EEF Incentives range from" := 0.6 * "Birds Sold (kg)"
                                                                                                ELSE
                                                                                                    IF EEF >= 306 THEN
                                                                                                        "EEF Incentives range from" := 0.5 * "Birds Sold (kg)"
                                                                                                    ELSE
                                                                                                        IF EEF >= 300 THEN
                                                                                                            "EEF Incentives range from" := 0.25 * "Birds Sold (kg)";

                "Total Incentive (Add)" := ROUND(ABS("Birds Rearing GC" + "Incentive for Low Cost" + "Rate Incentive for Selling1" + "Rate Incentive for Selling2" +
                "Rate Incentive for Selling3" + "Rate Incentive for Selling4" + "Summary Incentive1" + "Summary Incentive2" + "Feed Unloading Charges" + "EEF Incentives range from" + "Min. Growing Charge"), 0.01, '=');
            END;

        "TOTAL AMOUNT PAYABLE" := ROUND("Total Incentive (Add)" - "TOTAL DEDUCTION(LESS)", 0.01, '=');
        IF "TOTAL AMOUNT PAYABLE" > 0 THEN
            "LESS: T.D.S @ 1%" := ROUND("TOTAL AMOUNT PAYABLE" * 1 / 100, 0.01, '=');
        "AMOUNT PAYABLE AFTER T.D.S" := ROUND("TOTAL AMOUNT PAYABLE" - "LESS: T.D.S @ 1%", 0.01, '=');
        //Receipt:=ROUND(ABS("AMOUNT PAYABLE AFTER T.D.S"-"SELF  DC NO :"),0.01,'=');

        "Net Payable After TDS" := ROUND(("AMOUNT PAYABLE AFTER T.D.S" - "SELF  DC NO :" + Receipt), 0.01, '=');
        "AMOUNT payable per bird" := ROUND("TOTAL AMOUNT PAYABLE" / "Chick Housed", 0.01, '=');
        IF "AMOUNT payable per bird" < 0 THEN
            "AMOUNT payable per bird" := 0;
    end;

    procedure GCCalculation1()
    var
        T5405: Record 5405;
        ProdOrder: Record 5405;
        Location: Record 14;
        T50020: Record 50020;
        MedicineAmt: Decimal;
        T32: Record 32;
        T14: Record 14;
        T5407: Record 5407;
        DEL: Record 50005;
        MortalityValue: Decimal;
        SalesAmt: Decimal;
        SSL: Record 111;
        TRS: Record "Transfer Shipment Line";
        BirdSales: Decimal;
        BirdSalesInvoice: Decimal;
        BirdSalesTRS: Decimal;
        TotalSales: Decimal;
        TotalSalesInvoice: Decimal;
        TotalSalesTRS: Decimal;
        DiffDateSales: Integer;
        FeedConsumption: Decimal;
        FeedPositiveAdj: Decimal;
        MortalityOpening: Decimal;
        T50021: Record 50021;
        Whicheverishigher: Decimal;
        BirdSoldShipmentKg: Decimal;
        BirdSoldShipmentNos: Decimal;
        BirdSoldCMKg: Decimal;
        BirdSoldCMNos: Decimal;
        ILE: Record 32;
        DebitNoteQty: Decimal;
        TotalRateIncentive: Decimal;
        RateIncentive: Decimal;
        T50022: Record 50022;
        GCStatement: Record 50015;
        PO: Record 5405;
        MedicineQty: Decimal;
        VaccineQty: Decimal;
        VaccineAmt: Decimal;
        SCML: Record 115;
        TRR: Record "Transfer Receipt Line";
        BirdSalesCM: Decimal;
        BirdSalesCMCreditMemo: Decimal;
        BirdSalesCMTRR: Decimal;
        TotalSalesCM: Decimal;
        TotalSalesCMCreditMemo: Decimal;
        TotalSalesCMTRR: Decimal;
        DiffDateSalesCM: Integer;
        CLE: Record 21;
        DCLE: Record 379;
        TempSIH: Record 112 temporary;
        SIL: Record 113;
        T18_Loc: Record 18;
        SelfDCInvoice: Decimal;
        SelfDCCM: Decimal;
        ParameterMaster_T: Record 50001;
        EEFRange: Record 50027;
        BlankDate: Date;
        DataEntrySheet: Record 50005;
        Actualvalue_v: Decimal;
        T_32: Record 32;
        TotalMortality: Decimal;
        EEFRange1: Record 50027;
        GCParameterMaster: Record 50023;
        Para4Total: Decimal;
        Item: Record 27;
        Medicine_ABS: Decimal;
        Vacce_ABS: Decimal;
        TaxConfiValueRec: Record "Tax Rate Value";
        AssesCode1: Text[2000];
        FarMerRec: Record Vendor;
        MaizQty: Decimal;
        MaizAmt: Decimal;
    begin
        TESTFIELD("Flock No.");
        Location.GET("Farm Code");
        ProdOrder.SETRANGE("No.", "Flock No.");
        IF ProdOrder.FINDFIRST THEN
            "Receipt Date" := ProdOrder."Starting Date";

        T50021.RESET;
        T50021.SETRANGE("Shed Type", "Shed Type");
        T50021.SETRANGE("State Code", Location."State Code");
        T50021.SETFILTER("Ending Date", '%1|>=%2', 0D, "Receipt Date"); /////Pru_gk
        T50021.SETRANGE("Starting Date", 0D, "Receipt Date");////Pru_gk
        IF T50021.FINDFIRST THEN BEGIN
            "Std. Prod Cost" := T50021."Std. Production Cost";
            "Std. Sale Rate" := T50021."Std. Sales Rate";
            "Std. GC Rate" := T50021."Std. GC Rate";
            "Std. Admin Cost" := T50021."Std. Admin Cost";

        END;

        T32.RESET;
        T32.SETCURRENTKEY("Entry Type", "Flock No.", "Item Type", "Location Code");
        T32.SETRANGE("Item Type", T32."Item Type"::Feed);
        T32.SETRANGE("Location Code", "Farm Code");
        T32.SETRANGE("In-transit Mortality", FALSE); ////Pru_gk 23092019
        T32.CALCSUMS(Quantity);
        IF T32.Quantity > 0 THEN
            ERROR('GC Cannot be calculated due to feed stock available in %1 Location', "Farm Code");
        CLEAR(DebitNoteQty);
        ILE.RESET;
        ILE.SETCURRENTKEY("Entry Type", "Flock No.", "Item Type", "Location Code");
        ILE.SETRANGE("Location Code", "Farm Code");
        ILE.SETRANGE("Flock No.", "Flock No.");
        ILE.SETRANGE("Item Type", ILE."Item Type"::Chick);
        ILE.SETRANGE("Document Type", ILE."Document Type"::"Transfer Shipment");
        ILE.SETRANGE("Debit Note Type", ILE."Debit Note Type"::"Debit Note");
        ILE.SETRANGE("In-transit Mortality", FALSE);////Pru_gk 23092019
        IF ILE.FINDFIRST THEN
            REPEAT
                DebitNoteQty += -(ILE.Quantity);   /////Pru_gk   chenge +=
            UNTIL ILE.NEXT = 0;

        T5405.RESET;
        T5405.SETRANGE("No.", "Flock No.");
        IF T5405.FINDFIRST THEN;
        "Chick Housed" := ABS(ROUND(T5405.Quantity - DebitNoteQty, 0.01, '='));
        T14.GET("Farm Code");
        T14.TESTFIELD("Liquidation Date");
        CLEAR(MedicineAmt);
        CLEAR(SalesAmt);
        CLEAR(BirdSales);
        Clear(BirdSalesInvoice);
        Clear(BirdSalesTRS);
        CLEAR(TotalSales);
        Clear(TotalSalesInvoice);
        Clear(TotalSalesTRS);
        CLEAR(DiffDateSales);
        CLEAR(FeedConsumption);
        CLEAR(FeedPositiveAdj);
        CLEAR(MortalityOpening);
        CLEAR(BirdSoldCMKg);
        CLEAR(BirdSoldCMNos);
        CLEAR(BirdSoldShipmentKg);
        CLEAR(BirdSoldShipmentNos);
        CLEAR(HatchDate);
        "Liquidation Date" := T14."Liquidation Date";
        "Receipt Date" := T5405."Starting Date";
        HatchDate := T5405."Hatching Date";
        CLEAR(MortalityValue);
        /* 
         DEL.RESET;
         DEL.SETRANGE("Flock No.", "Flock No.");
         DEL.SETRANGE(Posted, TRUE);
         DEL.SETFILTER("Mortality Type", '<>%1', DEL."Mortality Type"::" ");
         DEL.SETRANGE("Exclude Quantity of Mortality", FALSE);
         IF DEL.FINDSET THEN
             REPEAT
                 ParameterMaster_T.RESET;
                 ParameterMaster_T.SETRANGE("No.", DEL."Parameter No.");
                 ParameterMaster_T.SETRANGE("In-transit Mortality", FALSE); ///Pru_gk
                 IF ParameterMaster_T.FINDFIRST THEN
                     MortalityValue += (DEL."Actual Value" - DEL."Reverse Qty.");
             UNTIL DEL.NEXT = 0;
             */
        //Suman
        ILE.Reset;
        ILE.SetRange("Document No.", "Flock No.");
        ILE.SetFilter("Data Entry Type", '%1', ILE."Data Entry Type"::"Mortality - Chicks");
        ILE.SetRange("In-transit Mortality", false);
        if ILE.FindSet then
            repeat
                MortalityValue += ILE.Quantity

            Until ILE.Next = 0;
        //Suman

        T32.RESET;
        T32.SETCURRENTKEY("Entry Type", "Flock No.", "Item Type", "Location Code");
        T32.SETRANGE("Entry Type", T32."Entry Type"::Consumption);
        T32.SETRANGE("Document No.", "Flock No.");
        T32.SETRANGE("Item Type", T32."Item Type"::Chick);
        T32.SETRANGE("Location Code", "Farm Code");
        T32.SETFILTER("Posting Date", '<%1', 20180401D);
        T32.SETFILTER("In-transit Mortality", '%1', FALSE); ////Pru_gk 23092019
        T32.CALCSUMS(Quantity);
        MortalityOpening := ABS(T32.Quantity);
        Mortality := ROUND(ABS(MortalityValue) + ABS(MortalityOpening), 0.01, '=');
        CLEAR(FeedConsumption);
        CLEAR(FeedPositiveAdj);
        T32.RESET;
        T32.SETCURRENTKEY("Entry Type", "Flock No.", "Item Type", "Location Code");
        T32.SETRANGE("Entry Type", T32."Entry Type"::Consumption);
        T32.SETRANGE("Document No.", "Flock No.");
        T32.SETRANGE("Item Type", T32."Item Type"::Feed);
        T32.SETRANGE("Location Code", "Farm Code");
        T32.SETFILTER("In-transit Mortality", '%1', FALSE); ////Pru_gk 23092019
        T32.CALCSUMS(Quantity);
        FeedConsumption := ABS(T32.Quantity);
        T32.RESET;
        T32.SETCURRENTKEY("Entry Type", "Flock No.", "Item Type", "Location Code");
        T32.SETRANGE("Entry Type", T32."Entry Type"::"Positive Adjmt.");
        T32.SETRANGE("Document No.", "Flock No.");
        T32.SETRANGE("Item Type", T32."Item Type"::Feed);
        T32.SETRANGE("Location Code", "Farm Code");
        T32.SETFILTER("In-transit Mortality", '%1', FALSE); ////Pru_gk 23092019
        T32.CALCSUMS(Quantity);
        FeedPositiveAdj := ABS(T32.Quantity);
        "Feed Consumption(kgs)" := ROUND(FeedConsumption - FeedPositiveAdj, 0.01, '=');
        T32.RESET;
        T32.SETCURRENTKEY("Entry Type", "Flock No.", "Item Type", "Location Code");
        T32.SETFILTER("Entry Type", '%1|%2', T32."Entry Type"::Sale, T32."Entry Type"::Transfer);//Suman 261124
        T32.SETFILTER("Document Type", '%1|%2', T32."Document Type"::"Sales Shipment", T32."Document Type"::"Transfer Shipment");//Suman 261124
        T32.SETRANGE("Flock No.", "Flock No.");
        T32.SETRANGE("Item Type", T32."Item Type"::Bird);
        T32.SETRANGE("Location Code", "Farm Code");
        T32.SETFILTER("In-transit Mortality", '%1', FALSE); ////Pru_gk 23092019
        T32.CALCSUMS(Quantity, "Alternate Quantity");
        BirdSoldShipmentKg := ROUND(ABS(T32.Quantity), 0.01, '=');
        BirdSoldShipmentNos := ROUND(ABS(T32."Alternate Quantity"), 0.01, '=');
        T32.RESET;
        T32.SETCURRENTKEY("Entry Type", "Flock No.", "Item Type", "Location Code");
        T32.SETFILTER("Entry Type", '%1|%2', T32."Entry Type"::Sale, T32."Entry Type"::Transfer);//Suman 261124
        T32.SETFILTER("Document Type", '%1|%2', T32."Document Type"::"Sales Return Receipt", T32."Document Type"::"Transfer Receipt");//Suman 261124
        T32.SETRANGE("Flock No.", "Flock No.");
        T32.SETRANGE("Item Type", T32."Item Type"::Bird);
        T32.SETRANGE("Location Code", "Farm Code");
        T32.SETFILTER("In-transit Mortality", '%1', FALSE); ////Pru_gk 23092019
        T32.CALCSUMS(Quantity, "Alternate Quantity");
        BirdSoldCMKg := ROUND(ABS(T32.Quantity), 0.01, '=');
        BirdSoldCMNos := ROUND(ABS(T32."Alternate Quantity"), 0.01, '=');
        "Birds Sold (kg)" := BirdSoldShipmentKg - BirdSoldCMKg;
        "Birds Sold (Nos)" := BirdSoldShipmentNos - BirdSoldCMNos;
        SSL.RESET;
        SSL.SETRANGE("Flock No.", "Flock No.");
        SSL.SETRANGE("Item Type", SSL."Item Type"::Bird);
        IF SSL.FINDFIRST THEN
            REPEAT
                //DiffDateSales := SSL."Posting Date"-"Receipt Date";
                DiffDateSales := SSL."Posting Date" - HatchDate;
                BirdSalesInvoice += SSL."Alternate Quantity";
                TotalSalesInvoice += SSL."Alternate Quantity" * DiffDateSales;
            UNTIL SSL.NEXT = 0;
        TRS.Reset();
        TRS.SetRange("Flock No.", "Flock No.");
        TRS.SetRange("Item Type", TRS."Item Type"::Bird);
        if TRS.FindFirst() then
            repeat
                TRS.CalcFields("Posting Date");
                DiffDateSales := TRS."Posting Date" - HatchDate;
                BirdSalesTRS += TRS."Alternate Quantity";
                TotalSalesTRS += TRS."Alternate Quantity" * DiffDateSales;
            Until TRS.Next() = 0;

        BirdSales := BirdSalesInvoice + BirdSalesTRS;
        TotalSales := TotalSalesInvoice + TotalSalesTRS;

        SCML.RESET;
        SCML.SETRANGE("Flock No.", "Flock No.");
        SCML.SETRANGE("Item Type", SCML."Item Type"::Bird);
        IF SCML.FINDFIRST THEN
            REPEAT
                //DiffDateSales := SSL."Posting Date"-"Receipt Date";
                DiffDateSalesCM := SCML."Posting Date" - HatchDate;
                BirdSalesCMCreditMemo += SCML."Alternate Quantity";
                TotalSalesCMCreditMemo += SCML."Alternate Quantity" * DiffDateSalesCM;
            UNTIL SCML.NEXT = 0;

        TRR.RESET;
        TRR.SETRANGE("Flock No.", "Flock No.");
        TRR.SETRANGE("Item Type", SCML."Item Type"::Bird);
        IF TRR.FINDFIRST THEN
            REPEAT
                TRR.CalcFields("Posting Date");
                //DiffDateSales := SSL."Posting Date"-"Receipt Date";
                DiffDateSalesCM := TRR."Posting Date" - HatchDate;
                BirdSalesCMTRR += -TRR."Alternate Quantity";
                TotalSalesCMTRR += -(TRR."Alternate Quantity" * DiffDateSalesCM);
            UNTIL TRR.NEXT = 0;
        BirdSalesCM := BirdSalesCMCreditMemo + BirdSalesCMTRR;
        TotalSalesCM := TotalSalesCMCreditMemo + TotalSalesCMTRR;
        ///PRU-VG 190319
        "SELF  DC NO :" := 0;
        SelfDCCM := 0;
        SelfDCInvoice := 0;
        Receipt := 0;
        TempSIH.DELETEALL;
        SIL.RESET;
        SIL.SETRANGE("Flock No.", "Flock No.");
        SIL.SETRANGE("Sell-to Customer No.", "Customer Code");
        IF SIL.FINDSET THEN
            REPEAT
                //T18_Loc.GET(SIL."Sell-to Customer No.");
                //IF T18_Loc."Farmer Location" = SIL."Location Code" THEN BEGIN
                SelfDCInvoice += SIL.Amount;
                // MESSAGE('%1',SIL."Amount To Customer");
                //TempSIH."No." := SIL."Document No.";
                //UNTIL SIL.NEXT =0;

                //      IF NOT TempSIH.GET(SIL."Document No.") THEN BEGIN
                //        TempSIH.INIT;
                //        TempSIH."No." := SIL."Document No.";
                //        TempSIH.INSERT;
                //END;
                CLE.RESET;
                CLE.SETRANGE(CLE."Document No.", SIL."Document No.");
                CLE.SETAUTOCALCFIELDS("Original Amt. (LCY)", "Remaining Amt. (LCY)");
                IF CLE.FINDSET THEN
                    REPEAT
                        Receipt += (CLE."Original Amt. (LCY)" - CLE."Remaining Amt. (LCY)");
                    //MESSAGE('%1,%2',Receipt,CLE.COUNT);
                    UNTIL CLE.NEXT = 0;
            UNTIL SIL.NEXT = 0;
        SCML.RESET;
        SCML.SETRANGE("Flock No.", "Flock No.");
        SCML.SETRANGE("Sell-to Customer No.", "Customer Code");
        IF SCML.FINDFIRST THEN BEGIN
            REPEAT
                SelfDCCM += SCML.Amount;

            UNTIL SCML.NEXT = 0;
        END;
        /*
          REPEAT
            T18_Loc.GET(SCML."Sell-to Customer No.");
            IF T18_Loc."Farmer Location" = SCML."Location Code" THEN BEGIN
        
        
        
            END;
          UNTIL SCML.NEXT=0;
          */
        "SELF  DC NO :" := SelfDCInvoice - SelfDCCM;
        //IF TempSIH.FINDSET THEN  //suman
        // CLE.RESET;
        // CLE.SETRANGE(CLE."Document No.",TempSIH."No.");
        // CLE.SETAUTOCALCFIELDS("Original Amt. (LCY)","Remaining Amt. (LCY)");
        // IF CLE.FINDSET THEN
        // REPEAT
        //  Receipt += (CLE."Original Amt. (LCY)"-CLE."Remaining Amt. (LCY)");
        //  MESSAGE('%1,%2',Receipt,CLE.COUNT);

        /*DCLE.RESET;
        DCLE.SETRANGE("Cust. Ledger Entry No.",CLE."Entry No.");
        DCLE.SETRANGE("Customer No.",CLE."Customer No.");
        DCLE.SETRANGE("Entry Type",DCLE."Entry Type"::Application);
        DCLE.SETRANGE("Document Type",DCLE."Document Type"::Payment);/////26-03-2019
        IF DCLE.FINDSET THEN REPEAT
          Receipt += ABS(DCLE.Amount)
        UNTIL DCLE.NEXT=0;*/
        //UNTIL CLE.NEXT=0;
        //END;
        //UNTIL TempSIH.NEXT=0; //suman
        ///PRU-VG 190319
        "Mean Age" := ROUND((TotalSales + TotalSalesCM) / (BirdSales + BirdSalesCM), 0.01, '=');
        //MESSAGE('%1',"Mean Age");
        "Mortality %" := ROUND(ABS(Mortality / "Chick Housed") * 100, 0.01, '=');
        "Body Weight %" := ROUND(ABS("Birds Sold (kg)" / "Birds Sold (Nos)"), 0.001, '=');
        "Age (In Days)" := ABS("Liquidation Date" - "Receipt Date");

        FCR := ROUND(ABS("Feed Consumption(kgs)" / "Birds Sold (kg)"), 0.00001, '=');
        CFCR := ROUND(ABS((2 - "Body Weight %") / 4 + FCR), 0.00001, '=');
        EEF := ROUND(((100 - "Mortality %") * "Body Weight %" / (FCR * "Mean Age") * 100), 1, '='); //Rk-PRU
        "Age (In Days)" := ABS("Liquidation Date" - "Receipt Date") + 1; //RK-PRU
        T32.RESET;
        T32.SETCURRENTKEY("Entry Type", "Flock No.", "Item Type", "Location Code");
        T32.SETRANGE("Entry Type", T32."Entry Type"::Sale);
        T32.SETRANGE("Flock No.", "Flock No.");
        T32.SETRANGE("Item Type", T32."Item Type"::Bird);
        T32.SETRANGE("Location Code", "Farm Code");
        T32.SETFILTER("In-transit Mortality", '%1', FALSE); ////Pru_gk 23092019
        T32.SETAUTOCALCFIELDS("Sales Amount (Actual)", "Sales Amount (Expected)");
        IF T32.FINDSET THEN
            REPEAT
                SalesAmt += T32."Sales Amount (Actual)" + T32."Sales Amount (Expected)";
            UNTIL T32.NEXT = 0;

        TRS.RESET;
        TRS.SETCURRENTKEY("Flock No.", "Item Type", "Transfer-from Code");
        TRS.SETRANGE("Flock No.", "Flock No.");
        TRS.SETRANGE("Item Type", T32."Item Type"::Bird);
        TRS.SETRANGE("Transfer-from Code", "Farm Code");
        IF TRS.FINDSET THEN
            REPEAT
                SalesAmt += TRS.Amount;
            UNTIL TRS.NEXT = 0;

        TRR.RESET;
        TRR.SETCURRENTKEY("Flock No.", "Item Type", "Transfer-to Code");
        TRR.SETRANGE("Flock No.", "Flock No.");
        TRR.SETRANGE("Item Type", T32."Item Type"::Bird);
        TRR.SETRANGE("Transfer-to Code", "Farm Code");
        IF TRR.FINDSET THEN
            REPEAT
                SalesAmt += -(TRR.Amount);
            UNTIL TRR.NEXT = 0;


        ////
        "Sale Amount" := ROUND(ABS(SalesAmt), 0.01, '=');
        "Sale rate" := ROUND(ABS(SalesAmt / "Birds Sold (kg)"), 0.01, '=');
        "Short Excess" := ROUND("Chick Housed" - "Birds Sold (Nos)" - Mortality, 0.01, '=');

        PO.RESET;
        PO.SETFILTER(Status, '%1|%2', PO.Status::Released, PO.Status::Finished);
        PO.SETRANGE("No.", "Flock No.");
        IF PO.FINDFIRST THEN;

        ////Pru_gk 04122019
        T_32.RESET;
        T_32.SETRANGE("Flock No.", "Flock No.");
        T_32.SETRANGE("Entry Type", T_32."Entry Type"::Consumption);
        T_32.SETRANGE("In-transit Mortality", FALSE);
        T_32.SETRANGE("Posting Date", PO."Due Date", CALCDATE('6D', PO."Due Date"));
        T_32.SETRANGE("Item Type", T_32."Item Type"::Chick);
        IF T_32.FINDFIRST THEN
            REPEAT
                TotalMortality += T_32.Quantity;
            UNTIL T_32.NEXT = 0;
        "1st week mortality" := ABS(TotalMortality);
        IF "1st week mortality" <> 0 THEN
            "1st week mortality %" := (("1st week mortality" / "Chick Housed") * 100)
        ELSE
            "1st week mortality %" := 0;
        ////Pru_gk today
        ///Pru_gk MGC_0.1

        // Premix Calculation
        "Premix Qty" := 0;
        "Premix Value" := 0;
        T32.RESET;
        T32.SETCURRENTKEY("Entry Type", "Flock No.", "Item Type", "Location Code");
        T32.SETRANGE("Entry Type", T32."Entry Type"::Consumption);
        T32.SETRANGE("Document No.", "Flock No.");
        T32.SETFILTER("Item Type", '%1', T32."Item Type"::Premix);
        T32.SETRANGE("Location Code", "Farm Code");
        T32.SETFILTER("In-transit Mortality", '%1', FALSE);
        T32.SETAUTOCALCFIELDS("Cost Amount (Actual)", "Cost Amount (Expected)");
        IF T32.FINDSET THEN
            REPEAT
                "Premix Qty" += (T32.Quantity) * -1;
                "Premix Value" += (T32."Cost Amount (Actual)" + T32."Cost Amount (Expected)") * -1;
            UNTIL T32.NEXT = 0;



        GCParameterMaster.RESET;
        GCParameterMaster.SETRANGE(Code, 'GCIPARA002');
        GCParameterMaster.SETRANGE(Block, FALSE);
        IF GCParameterMaster.FINDFIRST THEN BEGIN
            T50022.RESET;
            T50022.SETRANGE(State, Location."State Code");
            T50022.SETRANGE(Type1, "Shed Type");
            T50022.SETRANGE(Type2, T50022.Type2::Incentive);
            T50022.SETRANGE("Parameter Code", 'GCIPARA002');
            T50022.SETFILTER("End Date", '%1|>=%2', 0D, PO."Starting Date");
            T50022.SETRANGE("Start Date", 0D, PO."Starting Date");
            IF T50022.FINDFIRST THEN BEGIN
                IF ("Sale rate" > T50022.Value1) THEN BEGIN
                    IF "Sale rate" <= T50022.Value2 THEN
                        "Rate Incentive for Selling1" := ROUND(ABS(("Sale rate" - T50022.Value3) * T50022.Value4 * "Birds Sold (kg)"), 0.01, '=')
                    ELSE
                        "Rate Incentive for Selling1" := ROUND(ABS((T50022.Value2 - T50022.Value3) * T50022.Value4 * "Birds Sold (kg)"), 0.01, '=');
                END ELSE
                    "Rate Incentive for Selling1" := 0;
            END ELSE
                "Rate Incentive for Selling1" := 0;
        END; ///Pru_gk MGC_0.1

        ///Pru_gk MGC_0.1
        GCParameterMaster.RESET;
        GCParameterMaster.SETRANGE(Code, 'GCIPARA003');
        GCParameterMaster.SETRANGE(Block, FALSE);
        IF GCParameterMaster.FINDFIRST THEN BEGIN
            T50022.SETRANGE("Parameter Code", 'GCIPARA003');
            IF T50022.FINDFIRST THEN BEGIN
                IF ABS("Sale rate") > T50022.Value1 THEN BEGIN
                    IF ABS("Sale rate") <= T50022.Value2 THEN
                        "Rate Incentive for Selling2" := ROUND(ABS(("Sale rate" - T50022.Value3) * T50022.Value4 * "Birds Sold (kg)"), 0.01, '=')
                    ELSE
                        "Rate Incentive for Selling2" := ROUND(ABS((T50022.Value2 - T50022.Value3) * T50022.Value4 * "Birds Sold (kg)"), 0.01, '=');
                END ELSE
                    "Rate Incentive for Selling2" := 0;
            END ELSE
                "Rate Incentive for Selling2" := 0;
        END; ///Pru_gk MGC_0.1
             ///Pru_gk MGC_0.1
        GCParameterMaster.RESET;
        GCParameterMaster.SETRANGE(Code, 'GCIPARA004');
        GCParameterMaster.SETRANGE(Block, FALSE);
        IF GCParameterMaster.FINDFIRST THEN BEGIN
            T50022.SETRANGE("Parameter Code", 'GCIPARA004');
            IF T50022.FINDFIRST THEN BEGIN
                IF ABS("Sale rate") > T50022.Value1 THEN BEGIN
                    IF ABS("Sale rate") <= T50022.Value2 THEN
                        "Rate Incentive for Selling3" := ROUND(ABS(("Sale rate" - T50022.Value3) * T50022.Value4 * "Birds Sold (kg)"), 0.01, '=')
                    ELSE
                        "Rate Incentive for Selling3" := ROUND(ABS((T50022.Value2 - T50022.Value3) * T50022.Value4 * "Birds Sold (kg)"), 0.01, '=');
                END ELSE
                    "Rate Incentive for Selling3" := 0;
            END ELSE
                "Rate Incentive for Selling3" := 0;
        END; ///Pru_gk MGC_0.1

        GCParameterMaster.RESET;
        GCParameterMaster.SETRANGE(Code, 'GCIPARA011');
        GCParameterMaster.SETRANGE(Block, FALSE);
        IF GCParameterMaster.FINDFIRST THEN BEGIN
            T50022.RESET;
            T50022.SETRANGE(State, Location."State Code");
            T50022.SETRANGE(Type1, "Shed Type");
            T50022.SETRANGE(Type2, T50022.Type2::Incentive);
            T50022.SETRANGE("Parameter Code", 'GCIPARA011');
            T50022.SETFILTER("End Date", '%1|>=%2', 0D, PO."Starting Date");
            T50022.SETRANGE("Start Date", 0D, PO."Starting Date");
            IF T50022.FINDFIRST THEN BEGIN
                IF ("Sale rate" > T50022.Value1) THEN BEGIN
                    IF "Sale rate" <= T50022.Value2 THEN
                        "Rate Incentive for Selling4" := ROUND(ABS(("Sale rate" - T50022.Value3) * T50022.Value4 * "Birds Sold (kg)"), 0.01, '=')
                    ELSE
                        "Rate Incentive for Selling4" := ROUND(ABS((T50022.Value2 - T50022.Value3) * T50022.Value4 * "Birds Sold (kg)"), 0.01, '=');
                END ELSE
                    "Rate Incentive for Selling4" := 0;
            END ELSE
                "Rate Incentive for Selling4" := 0;
        END; ///Pru_gk MGC_0.1


        "Total of All Rate Incentive" := "Rate Incentive for Selling1" + "Rate Incentive for Selling2" + "Rate Incentive for Selling3" + "Rate Incentive for Selling4";
        ///Pru_gk MGC_0.1
        GCParameterMaster.RESET;
        GCParameterMaster.SETRANGE(Code, 'GCIPARA005');
        GCParameterMaster.SETRANGE(Block, FALSE);
        IF GCParameterMaster.FINDFIRST THEN BEGIN
            T50022.SETRANGE("Parameter Code", 'GCIPARA005');
            IF T50022.FINDFIRST THEN BEGIN
                /////IF "Total of All Rate Incentive"/"Birds Sold (kg)" > T50022.Value1 THEN
                "Max Rate Incentive Upto 2.5" := "Birds Sold (kg)" * T50022.Value1;
                /////ELSE
                ///////"Max Rate Incentive Upto 2.5" := 0;
            END ELSE
                "Max Rate Incentive Upto 2.5" := 0;
        END;
        ///Pru_gk MGC_0.1
        IF "Max Rate Incentive Upto 2.5" <= "Total of All Rate Incentive" THEN
            "Actual Amount" := "Max Rate Incentive Upto 2.5"
        ELSE
            "Actual Amount" := "Total of All Rate Incentive";
        ///Pru_gk MGC_0.1
        GCParameterMaster.RESET;
        GCParameterMaster.SETRANGE(Code, 'GCIPARA007');
        GCParameterMaster.SETRANGE(Block, FALSE);
        IF GCParameterMaster.FINDFIRST THEN BEGIN
            T50022.SETRANGE("Parameter Code", 'GCIPARA007');
            IF T50022.FINDFIRST THEN BEGIN
                IF (ABS("Mortality %") > 0) AND (ABS("Mortality %") <= T50022.Value1) THEN
                    "Summary Incentive1" := ROUND(ABS("Birds Sold (Nos)" * T50022.Value2), 0.01, '=')
                ELSE
                    "Summary Incentive1" := 0
            END ELSE
                "Summary Incentive1" := 0;
        END;
        ///Pru_gk MGC_0.1
        ///Pru_gk MGC_0.1
        GCParameterMaster.RESET;
        GCParameterMaster.SETRANGE(Code, 'GCIPARA008');
        GCParameterMaster.SETRANGE(Block, FALSE);
        IF GCParameterMaster.FINDFIRST THEN BEGIN
            T50022.SETRANGE("Parameter Code", 'GCIPARA008');
            IF T50022.FINDFIRST THEN BEGIN
                IF ("Mortality %" >= T50022.Value1) AND ("Mortality %" <= T50022.Value2) THEN
                    "Summary Incentive2" := ROUND(ABS("Birds Sold (Nos)" * T50022.Value3), 0.01, '=')
                ELSE
                    "Summary Incentive2" := 0;
            END ELSE
                "Summary Incentive2" := 0;
        END;
        ///Pru_gk MGC_0.1

        ////Pru_gk
        ///Pru_gk MGC_0.1
        GCParameterMaster.RESET;
        GCParameterMaster.SETRANGE(Code, 'GCIPARA009');
        GCParameterMaster.SETRANGE(Block, FALSE);
        IF GCParameterMaster.FINDFIRST THEN BEGIN
            T50022.SETRANGE("Parameter Code", 'GCIPARA009');
            IF T50022.FINDFIRST THEN BEGIN
                IF ("1st week mortality %" <= T50022.Value1) THEN
                    "Brooding Incentive" := ROUND(ABS("Birds Sold (Nos)" * T50022.Value2), 0.01, '=')
                ELSE
                    "Brooding Incentive" := 0;
            END ELSE
                "Brooding Incentive" := 0;
        END;

        ////Pru_gk

        ////Pru_gk
        ///Pru_gk MGC_0.1
        GCParameterMaster.RESET;
        GCParameterMaster.SETRANGE(Code, 'GCIPARA010');
        GCParameterMaster.SETRANGE(Block, FALSE);
        IF GCParameterMaster.FINDFIRST THEN BEGIN
            T50022.SETRANGE("Parameter Code", 'GCIPARA010');
            IF T50022.FINDFIRST THEN BEGIN
                IF Location."State Code" = 'JK' THEN
                    "Feed Unloading Charges" := 0
                ELSE
                    "Feed Unloading Charges" := ROUND(ABS("Feed Consumption(kgs)" / 1000 * T50022.Value1), 0.01, '=');
            END;
        END;


        ///Pru_gk MGC_0.1
        //part3
        ///Pru_gk MGC_0.1
        GCParameterMaster.RESET;
        GCParameterMaster.SETRANGE(Code, 'GCDPARA001');
        GCParameterMaster.SETRANGE(Block, FALSE);
        IF GCParameterMaster.FINDFIRST THEN BEGIN
            T50022.SETRANGE(Type2, T50022.Type2::Deduction);
            T50022.SETRANGE("Parameter Code", 'GCDPARA001');
            IF T50022.FINDFIRST THEN BEGIN
                IF ABS("Mortality %") >= T50022.Value1 THEN
                    "Deduction for high Mort" := ROUND(ABS((Mortality - (T50022.Value1 * Mortality / (Mortality / "Chick Housed" * 100))) * "Body Weight %" * T50022.Value2), 0.01, '=')
                ELSE
                    "Deduction for high Mort" := 0;
            END ELSE
                "Deduction for high Mort" := 0;
        END;
        ///Pru_gk MGC_0.1
        ////vidit
        ///Pru_gk MGC_0.1
        GCParameterMaster.RESET;
        GCParameterMaster.SETRANGE(Code, 'GCDPARA002');
        GCParameterMaster.SETRANGE(Block, FALSE);
        IF GCParameterMaster.FINDFIRST THEN BEGIN
            T50022.SETRANGE("Parameter Code", 'GCDPARA002');
            IF T50022.FINDFIRST THEN BEGIN
                IF (CFCR <= FCR) THEN BEGIN
                    IF (CFCR >= T50022.Value1) THEN
                        "Excess FCR Over" := ((CFCR - T50022.Value1) * "Birds Sold (kg)" * T50022.Value2)
                    ELSE
                        "Excess FCR Over" := 0;
                END ELSE
                    IF (FCR < CFCR) THEN BEGIN
                        IF (FCR >= T50022.Value1) THEN
                            "Excess FCR Over" := ((FCR - T50022.Value1) * "Birds Sold (kg)" * T50022.Value2)
                        ELSE
                            "Excess FCR Over" := 0;
                    END ELSE
                        "Excess FCR Over" := 0;
            END ELSE
                "Excess FCR Over" := 0;
        END;
        ///Pru_gk MGC_0.1
        ///Pru_gk MGC_0.1
        GCParameterMaster.RESET;
        GCParameterMaster.SETRANGE(Code, 'GCDPARA003');
        GCParameterMaster.SETRANGE(Block, FALSE);
        IF GCParameterMaster.FINDFIRST THEN BEGIN
            T50022.SETRANGE("Parameter Code", 'GCDPARA003');
            IF T50022.FINDFIRST THEN BEGIN
                CLEAR(Whicheverishigher);
                IF "Sale rate" <= T50022.Value1 THEN
                    Whicheverishigher := T50022.Value1
                ELSE
                    Whicheverishigher := "Sale rate";
                IF ("Short Excess" > 0) THEN
                    "Deduction for Shortage" := ROUND(ABS("Short Excess" * "Body Weight %" * Whicheverishigher), 0.01, '=')
                ELSE
                    "Deduction for Shortage" := 0;
            END ELSE
                "Deduction for Shortage" := 0;
        END;

        //part4
        "Chick Cost Qty" := ROUND("Chick Housed", 0.01, '=');
        Location.GET("Farm Code");
        T50020.RESET;
        T50020.SETRANGE("Item Type", T50020."Item Type"::Chick);
        T50020.SETRANGE("State Code", Location."State Code");
        T50020.SETRANGE("Shed Type", "Shed Type");
        T50020.SETFILTER("Ending Date", '%1|>=%2', 0D, PO."Due Date");
        T50020.SETRANGE("Starting Date", 0D, PO."Due Date");
        IF T50020.FINDFIRST THEN
            "Chick Cost Rate" := ROUND(T50020.Rate, 0.01, '=');
        "Chik Cost Amt." := ROUND(ABS("Chick Cost Qty" * "Chick Cost Rate"), 0.01, '=');

        //"Feed Cost Qty" := ROUND(ABS("Feed Consumption(kgs)" - "Maize Cost Qty"), 0.01, '=');
        "Feed Cost Qty" := ROUND(ABS("Feed Consumption(kgs)"), 0.01, '=');
        T50020.RESET;
        T50020.SETRANGE("Item Type", T50020."Item Type"::Feed);
        T50020.SETRANGE("State Code", Location."State Code");
        T50020.SETRANGE("Shed Type", "Shed Type");
        T50020.SETFILTER("Ending Date", '%1|>=%2', 0D, PO."Due Date");
        T50020.SETRANGE("Starting Date", 0D, PO."Due Date");
        IF T50020.FINDFIRST THEN
            "Feed Cost Rate" := ROUND(T50020.Rate, 0.01, '=');
        "Feed Cost Amt." := ROUND(ABS("Feed Cost Qty" * "Feed Cost Rate"), 0.01, '=');


        //SUman 26062025
        T32.RESET;
        T32.SETCURRENTKEY("Entry Type", "Flock No.", "Item Type", "Location Code");
        T32.SETRANGE("Entry Type", T32."Entry Type"::Consumption);
        T32.SETRANGE("Document No.", "Flock No.");
        T32.SETFILTER(T32."Item No.", '%1|%2', 'RM00043', 'RM00024');
        T32.SETRANGE("Location Code", "Farm Code");
        T32.SETRANGE("In-transit Mortality", FALSE); ////Pru_gk 23092019
        T32.SETAUTOCALCFIELDS("Cost Amount (Actual)", "Cost Amount (Expected)");
        IF T32.FINDSET THEN
            REPEAT
                MaizQty += T32.Quantity;
                MaizAmt += T32."Cost Amount (Actual)" + T32."Cost Amount (Expected)";
            UNTIL T32.NEXT = 0;
        "Maize Cost Qty" := ABS(MaizQty);
        if (MaizQty <> 0) and (MaizAmt <> 0) then
            "Maize Cost Rate" := ABS(MaizAmt) / ABS(MaizQty);

        "Maize Cost Amt." := ROUND(ABS("Maize Cost Qty" * "Maize Cost Rate"), 0.01, '=');

        //Pru 091220 P0272>>
        OtherSupRate := 0;
        OtherSupplimentQty := 0;
        T50020.RESET;
        T50020.SETRANGE("Shed Type", "Shed Type");
        T50020.SETRANGE("Item Type", T50020."Item Type"::"Other Suppliment");
        T50020.SETRANGE("State Code", Location."State Code");
        T50020.SETFILTER("Ending Date", '%1|>=%2', 0D, "Receipt Date");
        T50020.SETRANGE("Starting Date", 0D, "Receipt Date");
        IF T50020.FINDFIRST THEN
            OtherSupRate := T50020.Rate;

        T32.RESET;
        T32.SETCURRENTKEY("Entry Type", "Flock No.", "Item Type", "Location Code");
        T32.SETRANGE("Entry Type", T32."Entry Type"::Consumption);
        T32.SETRANGE("Document No.", "Flock No.");
        T32.SETfilter("Item Type", '%1', T32."Item Type"::"Other Supplement");// Suman 19-04-2025
        T32.SETRANGE("Location Code", "Farm Code");
        T32.SETFILTER("In-transit Mortality", '%1', FALSE);
        T32.CALCSUMS(Quantity);
        OtherSupplimentQty := T32.Quantity;

        "Other Supplement" := ROUND(ABS(OtherSupplimentQty * OtherSupRate), 0.01, '=');
        //MESSAGE('Rate %1 = End Date %2 = State Code %3 = Rec Date 4%', OtherSupRate, T50020."Ending Date", T50020."State Code", );
        //>>

        "Medicne Cost Amt." := 0;
        "Vaccine Cost Amt." := 0;
        CLEAR(MedicineQty);///PRU-VG 020119
        CLEAR(MedicineAmt);///PRU-VG 020119
        CLEAR(VaccineQty);///PRU-VG 020119
        CLEAR(VaccineAmt);///PRU-VG 020119
        T32.RESET;
        T32.SETCURRENTKEY("Entry Type", "Flock No.", "Item Type", "Location Code");
        T32.SETRANGE("Entry Type", T32."Entry Type"::Consumption);
        T32.SETRANGE("Document No.", "Flock No.");
        T32.SETFILTER("Item Type", '%1|%2', T32."Item Type"::Medicine, T32."Item Type"::Medicine);///PRU-VG 020119
        ////T32.SETFILTER("Item Type",'%1|%2',T32."Item Type"::Medicine,T32."Item Type"::Vaccination);///PRU-VG 020119
        T32.SETRANGE("Location Code", "Farm Code");
        T32.SETFILTER("In-transit Mortality", '%1', FALSE); ////Pru_gk 23092019
        T32.SETAUTOCALCFIELDS("Cost Amount (Actual)", "Cost Amount (Expected)");///PRU-VG 020119
        IF T32.FINDSET THEN
            REPEAT
                CLEAR(MedicineQty);///PRU-VG 020119
                CLEAR(MedicineAmt);///PRU-VG 020119
                /*
                T50020.RESET;
                T50020.SETRANGE("Item Type",T50020."Item Type"::Medicine);
                T50020.SETRANGE("State Code",Location."State Code");
                T50020.SETRANGE("Item No.",T32."Item No.");
                T50020.SETRANGE("Shed Type","Shed Type");
                T50020.SETFILTER("Ending Date",'%1|>=%2',0D,PO."Due Date");
                T50020.SETRANGE("Starting Date",0D,PO."Due Date");
                IF T50020.FINDFIRST THEN
                */
                Item.RESET;
                Item.SETRANGE(Item."No.", T32."Item No.");
                IF Item.FINDFIRST THEN
                    MedicineAmt += (T32."Cost Amount (Actual)");
                MedicineQty := T32.Quantity;///PRU-VG 020119
                Medicine_ABS += ROUND((((MedicineAmt / MedicineQty) + (((MedicineAmt / MedicineQty) * Item."GC Rate %") / 100)) * MedicineQty), 0.01, '=');
            //MedicineAmt := ROUND(T50020.Rate,0.01,'=');

            //"Medicne Cost Amt." += ROUND((MedicineQty*MedicineAmt),0.01,'=');
            /////MedicineAmt += T32."Cost Amount (Actual)"+T32."Cost Amount (Expected)";///PRU-VG 020119
            UNTIL T32.NEXT = 0;///PRU-VG 020119-Start
        "Medicne Cost Amt." := ABS(Medicine_ABS);

        T32.RESET;
        T32.SETCURRENTKEY("Entry Type", "Flock No.", "Item Type", "Location Code");
        T32.SETRANGE("Entry Type", T32."Entry Type"::Consumption);
        T32.SETRANGE("Document No.", "Flock No.");
        T32.SETFILTER("Item Type", '%1', T32."Item Type"::Vaccination);///PRU-VG 020119
        T32.SETRANGE("Location Code", "Farm Code");
        T32.SETFILTER("In-transit Mortality", '%1', FALSE);
        T32.SETAUTOCALCFIELDS("Cost Amount (Actual)", "Cost Amount (Expected)"); ////Pru_gk 23092019
        IF T32.FINDSET THEN
            REPEAT
                CLEAR(VaccineQty);///PRU-VG 020119
                CLEAR(VaccineAmt);///PRU-VG 020119
                /*
                T50020.RESET;
                T50020.SETRANGE("Item Type",T50020."Item Type"::Vaccination);
                T50020.SETRANGE("State Code",Location."State Code");
                T50020.SETRANGE("Item No.",T32."Item No.");
                T50020.SETRANGE("Shed Type","Shed Type");
                T50020.SETFILTER("Ending Date",'%1|>=%2',0D,PO."Due Date");
                T50020.SETRANGE("Starting Date",0D,PO."Due Date");
                IF T50020.FINDFIRST THEN
                */
                Item.RESET;
                Item.SETRANGE(Item."No.", T32."Item No.");
                IF Item.FINDFIRST THEN
                    VaccineAmt := (T32."Cost Amount (Actual)");
                VaccineQty := T32.Quantity;///PRU-VG 020119
                Vacce_ABS += ROUND((((VaccineAmt / VaccineQty) + (((VaccineAmt / VaccineQty) * Item."GC Rate %") / 100)) * VaccineQty), 0.01, '=');
            UNTIL T32.NEXT = 0;

        "Vaccine Cost Amt." := ABS(Vacce_ABS);

        T50021.RESET;
        T50021.SETRANGE("Shed Type", "Shed Type");
        T50021.SETRANGE("State Code", Location."State Code");
        T50021.SETFILTER("Ending Date", '%1|>=%2', 0D, "Receipt Date"); /////Pru_gk
        T50021.SETRANGE("Starting Date", 0D, "Receipt Date");////Pru_gk
        IF T50021.FINDFIRST THEN;

        ///IF Location."State Code"='JK' THEN
        "AdministrationCost Rs2.2/Bird2" := ROUND(ABS("Chick Cost Qty" * T50021."Std. Admin Cost"), 0.01, '=');
        //ELSE
        ///"AdministrationCost Rs2.2/Bird2":=ROUND(ABS("Chick Cost Qty"*T50021."Std. Admin Cost"),0.01,'=');

        "TOTAL COST OF PRODUCTION2" := ROUND(ABS("Chik Cost Amt." + "Feed Cost Amt." + "Maize Cost Amt." + "Medicne Cost Amt." + "AdministrationCost Rs2.2/Bird2" +
                   "Vaccine Cost Amt." + "Other Supplement" + "Premix Value"), 0.01, '='); //Pru 111220 #P0272 v0.01



        //"Production Cost" := ROUND("Cost of Prod./kg Before RC2",0.01,'=');
        "Production Cost" := ROUND(("TOTAL COST OF PRODUCTION2" / "Birds Sold (kg)"), 0.01, '=');
        ////PRU-VG
        ///Pru_gk MGC_0.1
        ///Pru_gk MGC_0.1

        CLEAR(Para4Total);
        GCParameterMaster.RESET;
        GCParameterMaster.SETRANGE(Code, 'GCDPARA004');
        GCParameterMaster.SETRANGE(Block, FALSE);
        IF GCParameterMaster.FINDFIRST THEN BEGIN
            T50022.SETRANGE("Parameter Code", 'GCDPARA004');
            IF T50022.FINDFIRST THEN BEGIN
                IF "Std. Prod Cost" < "Production Cost" THEN BEGIN
                    Para4Total := "Production Cost" - "Std. Prod Cost";
                    "Deduction for high Prod. Cost" := ((T50022.Value1 * "Birds Sold (kg)") * Para4Total);
                END ELSE
                    "Deduction for high Prod. Cost" := 0;
            END;
        END;
        ///Pru_gk MGC_0.1
        "TOTAL DEDUCTION(LESS)" := ROUND("Deduction for high Mort" + "Deduction for Shortage");
        GCParameterMaster.RESET;
        GCParameterMaster.SETRANGE(Code, 'GCIPARA006');
        GCParameterMaster.SETRANGE(Block, FALSE);
        IF GCParameterMaster.FINDFIRST THEN BEGIN
            T50022.RESET;
            T50022.SETRANGE(State, Location."State Code");
            T50022.SETRANGE(Type1, "Shed Type");
            T50022.SETRANGE(Type2, T50022.Type2::Incentive);
            T50022.SETFILTER("End Date", '%1|>=%2', 0D, PO."Starting Date");
            T50022.SETRANGE("Start Date", 0D, PO."Starting Date");
            T50022.SETRANGE("Parameter Code", 'GCIPARA006');
            IF T50022.FINDFIRST THEN BEGIN
                IF "Production Cost" <= T50022.Value1 THEN
                    "Rate Incentive- Actual Amount" := "Actual Amount"
                ELSE
                    "Rate Incentive- Actual Amount" := 0;
            END ELSE
                "Rate Incentive- Actual Amount" := 0;
        END;
        ///Pru_gk MGC_0.1
        ///PRU-VG
        ///Pru_gk MGC_0.1

        GCParameterMaster.RESET;
        GCParameterMaster.SETRANGE(Code, 'GCIPARA001');
        GCParameterMaster.SETRANGE(Block, FALSE);
        IF GCParameterMaster.FINDFIRST THEN BEGIN
            T50022.RESET;
            T50022.SETRANGE("Parameter Code", 'GCIPARA001');
            T50022.SETRANGE(State, Location."State Code");
            T50022.SETRANGE(Type1, "Shed Type");
            T50022.SETRANGE(Type2, T50022.Type2::Incentive);
            T50022.SETFILTER("End Date", '%1|>=%2', 0D, PO."Starting Date");
            T50022.SETRANGE("Start Date", 0D, PO."Starting Date");
            IF T50022.FINDFIRST THEN BEGIN
                IF "Production Cost" > "Std. Prod Cost" THEN
                    "Incentive for Low Cost" := 0
                ELSE
                    "Incentive for Low Cost" := ROUND(("Std. Prod Cost" - "Production Cost") * "Birds Sold (kg)" * T50022.Value1, 0.01, '=');
            END ELSE
                "Incentive for Low Cost" := 0;
        END;

        GCParameterMaster.RESET;
        GCParameterMaster.SETRANGE(Code, 'GCNPARA001');
        GCParameterMaster.SETRANGE(Block, FALSE);
        IF GCParameterMaster.FINDFIRST THEN BEGIN
            T50022.RESET;
            T50022.SETRANGE("Parameter Code", 'GCNPARA001');
            T50022.SETRANGE(State, Location."State Code");
            T50022.SETRANGE(Type1, "Shed Type");
            T50022.SETRANGE(Type2, T50022.Type2::Incentive);
            T50022.SETFILTER("End Date", '%1|>=%2', 0D, PO."Starting Date");
            T50022.SETRANGE("Start Date", 0D, PO."Starting Date");
            IF T50022.FINDFIRST THEN BEGIN
                "Std. GC Rate" := T50022.Value1;
                "Birds Rearing GC" := ROUND(ABS("Birds Sold (kg)" * "Std. GC Rate"), 0.01, '=');
            END;
        END;
        "Bird Rearing Charge for CB-New" := ("Birds Rearing GC" + "Incentive for Low Cost") - ("Deduction for high Prod. Cost" + "Excess FCR Over");
        ///Pru_gk MGC_0.1
        IF "Shed Type" = "Shed Type"::Normal THEN BEGIN
            IF RateIncentive < 2.5 THEN BEGIN
                "Total Incentive (Add)" := ROUND(("Bird Rearing Charge for CB-New" + "Feed Unloading Charges"/////"Rate Incentive for Selling1"+"Rate Incentive for Selling2"+
                                                                                                             //////"Rate Incentive for Selling3"//////
                + "Rate Incentive- Actual Amount" + "Summary Incentive1" + "Summary Incentive2" + "Brooding Incentive"), 0.01, '=')
            END ELSE BEGIN
                "Total Incentive (Add)" := ROUND(("Bird Rearing Charge for CB-New" + "Rate Incentive for Selling1" + "Max Rate Incentive Upto 2.5" + "Summary Incentive1"
                + "Summary Incentive2" + "Brooding Incentive" + "Feed Unloading Charges"), 0.01, '=')
            END;
        END ELSE BEGIN

            //IF "Shed Type" = "Shed Type"::EC THEN BEGIN
            EEFRange.RESET;
            EEFRange.SETRANGE("Shed Type", "Shed Type");
            EEFRange.SETRANGE("GC Type", EEFRange."GC Type"::"EEF Incentive"); //////Pru_gk
            EEFRange.SETFILTER("Starting Date", '..%1', "Receipt Date");
            CLEAR(BlankDate);
            EEFRange.SETFILTER("Ending Date", '%1|>=%2', BlankDate, "Receipt Date");
            EEFRange.SETFILTER("EEF Range To", '>=%1', EEF);
            EEFRange.SETFILTER("EEF Range From", '<=%1', EEF);
            EEFRange.SetRange(EEFRange.State, State);
            IF EEFRange.FINDFIRST THEN
                "EEF Incentives range from" := EEFRange."RS/KG" * "Birds Sold (kg)"
            ELSE BEGIN
                MESSAGE('Please update your EEF Incentive Master as Receipt Date and EEF are %1 & %2', "Receipt Date", EEF);
                "EEF Incentives range from" := 0;
            END;
            //END;
            "Total Incentive (Add)" := ROUND(("Bird Rearing Charge for CB-New" + "Rate Incentive- Actual Amount" + "Summary Incentive1" + "Summary Incentive2"
            + "Feed Unloading Charges" + "Brooding Incentive" + "EEF Incentives range from"), 0.01, '=');
            /////Pru_gk MGC_0.1
        END;

        ////Pru_gk 02062020
        EEFRange1.RESET;
        EEFRange1.SETRANGE("Shed Type", "Shed Type");
        EEFRange1.SETRANGE("GC Type", EEFRange1."GC Type"::"Min Growing Charge");
        EEFRange1.SETFILTER("Starting Date", '..%1', "Receipt Date");
        CLEAR(BlankDate);
        EEFRange1.SETFILTER("Ending Date", '%1|>=%2', BlankDate, "Receipt Date");
        EEFRange1.SETFILTER("EEF Range To", '>=%1', "Production Cost");
        EEFRange1.SETFILTER("EEF Range From", '<=%1', "Production Cost");
        EEFRange1.SetRange(EEFRange1.State, State);// Suman 13-03-2025
        IF EEFRange1.FINDFIRST THEN
            "Min. Growing Charge" := EEFRange1."RS/KG" * "Birds Sold (kg)"
        ELSE
            "Min. Growing Charge" := 0;

        IF "Min. Growing Charge" > 0 THEN BEGIN
            "Total Incentive (Add)" := ROUND(("Min. Growing Charge"), 0.01, '=');
            "TOTAL DEDUCTION(LESS)" := ROUND(("Deduction for Shortage"), 0.01, '=');
        END;
        ////Pru_gk 02062020
        //GK15052021-
        //
        /*
        CLEAR(AssesCode);
        NODNOCHeader.RESET;
        NODNOCHeader.SETRANGE(Type, NODNOCHeader.Type::Vendor);
        NODNOCHeader.SETRANGE("No.", "Farmer No.");
        IF NODNOCHeader.FINDFIRST THEN
            AssesCode := NODNOCHeader."Assesse Code";
*///S.M

        //MESSAGE('%1',AssesCode);
        /*
        CLEAR(TDSP);
        NODNOCLines.RESET;
        NODNOCLines.SETRANGE(Type,NODNOCLines.Type::Vendor);
        NODNOCLines.SETRANGE("No.","Farmer No.");
        IF NODNOCLines.FINDFIRST THEN
          TDSP := NODNOCLines."NOD/NOC";
          */
        //MESSAGE('%1',TDSP);
        /* S.M
                CLEAR(TDS);
                TDSSetup.RESET;
                TDSSetup.SETRANGE("TDS Nature of Deduction", "TDS Nature of Deduction");
                TDSSetup.SETRANGE("Assessee Code", AssesCode);
                TDSSetup.SETRANGE("Effective Date", 0D, "Liquidation Date");
                IF TDSSetup.FINDLAST THEN BEGIN
                    IF NODNOCHeader."P.A.N No." <> '' THEN
                        TDS := TDSSetup."TDS %"
                    ELSE
                        TDS := TDSSetup."Non PAN TDS %";
                END;

        */
        Clear(AssesCode1);
        if FarMerRec.get("Farmer No.") then;
        AssesCode1 := "TDS Section" + '|' + FarMerRec."Assessee Code" + '|||||';
        TaxConfiValueRec.Reset();
        TaxConfiValueRec.SetRange(TaxConfiValueRec."Tax Type", 'TDS');
        TaxConfiValueRec.SetRange(TaxConfiValueRec."Column Type", TaxConfiValueRec."Column Type"::Component);
        TaxConfiValueRec.SetRange("Column ID", 33);
        TaxConfiValueRec.SetRange("Tax Rate ID", AssesCode1);
        TaxConfiValueRec.SetFilter(Value, '<>%1', '0');
        if TaxConfiValueRec.FindFirst() then begin
            Evaluate(TDS, TaxConfiValueRec.Value);
        END;
        IF Location."Farm Type" <> Location."Farm Type"::"Own Farm" THEN BEGIN
            IF TDS = 0 THEN
                ERROR('TDS Section %1 & TDS Assess Code does not exist in tds rate', "TDS Section", FarMerRec."Assessee Code");
        END;
        //GK1215052021+

        IF Location."Farm Type" = Location."Farm Type"::"Own Farm" THEN
            "TOTAL AMOUNT PAYABLE" := 0

        ELSE
            "TOTAL AMOUNT PAYABLE" := ROUND("Total Incentive (Add)" - "TOTAL DEDUCTION(LESS)", 0.01, '=');
        //  Message('%1..%2TDS', "TOTAL AMOUNT PAYABLE", TDS);
        IF "TOTAL AMOUNT PAYABLE" > 0 THEN
            "LESS: T.D.S @ 1%" := ROUND("TOTAL AMOUNT PAYABLE" * TDS / 100, 0.01, '=')
        ELSE
            "LESS: T.D.S @ 1%" := 0;
        "AMOUNT PAYABLE AFTER T.D.S" := ROUND("TOTAL AMOUNT PAYABLE" - "LESS: T.D.S @ 1%", 0.01, '=');
        //Receipt:=ROUND(ABS("AMOUNT PAYABLE AFTER T.D.S"-"SELF  DC NO :"),0.01,'=');

        "Net Payable After TDS" := ROUND(("AMOUNT PAYABLE AFTER T.D.S" - "SELF  DC NO :" + Receipt), 0.01, '=');
        "AMOUNT payable per bird" := ROUND("TOTAL AMOUNT PAYABLE" / "Chick Housed", 0.01, '=');
        IF "AMOUNT payable per bird" < 0 THEN
            "AMOUNT payable per bird" := 0;

        ////
        "Bird Sold IN Kg.2  Qty." := ROUND(("Birds Sold (kg)"), 0.01, '=');

        IF "TOTAL AMOUNT PAYABLE" <= 0 THEN
            "Bird Sold IN Kg.2  Amt." := 0
        ELSE
            "Bird Sold IN Kg.2  Amt." := ROUND(("TOTAL AMOUNT PAYABLE"), 0.01, '=');

        IF "TOTAL AMOUNT PAYABLE" <= 0 THEN
            "Bird Sold IN Kg.2  Rate" := 0
        ELSE
            "Bird Sold IN Kg.2  Rate" := ROUND(("TOTAL AMOUNT PAYABLE" / "Birds Sold (kg)"), 0.01, '=');

        "Cost of Prod./kg Before RC2" := ROUND(("TOTAL COST OF PRODUCTION2" / "Bird Sold IN Kg.2  Qty."), 0.01, '=');

        "Bird Sold IN No. Qty." := ROUND(("Birds Sold (Nos)"), 0.01, '=');

        "Cost of Prod. After RC2" := ROUND(("TOTAL COST OF PRODUCTION2" + "Bird Sold IN Kg.2  Amt."), 0.01, '=');
        "Cost of Production Per Kg.2" := ROUND(("Cost of Prod. After RC2" / "Bird Sold IN Kg.2  Qty."), 0.01, '=');

        "Cost of Production Per Bird" := ROUND(ABS("Cost of Prod. After RC2" / "Birds Sold (Nos)"), 0.01, '=');
        "F.C.R2" := ROUND(ABS(("Feed Cost Qty" + "Maize Cost Qty") / "Bird Sold IN Kg.2  Qty."), 0.001, '=');

        "Average Body weight2" := ROUND(ABS("Bird Sold IN Kg.2  Qty." / "Bird Sold IN No. Qty."), 0.001, '=');

        "Prod. Cost After RC2" := ROUND(ABS("Cost of Prod. After RC2"), 0.01, '=');
        "SALE AMOUNT2" := ROUND(ABS("Sale Amount"), 0.01, '=');

        "NET PROFIT / (LOSS)" := ROUND(("Sale Amount" - "Cost of Prod. After RC2"), 0.01, '=');
        "NET PROFIT/ (LOSS)/BIRD" := ROUND(("NET PROFIT / (LOSS)" / "Chick Cost Qty"), 0.01, '=');

    end;

    local procedure SetFilterOnNODLines(TDSNatureOfDeduction: Code[10]; NatureOfRemittance: Code[10])
    var
        TDSRat: Page "TDS Rates";
    begin
        /*
                NODLines.RESET;
                NODLines.SETRANGE(Type, NODLines.Type::Vendor);
                NODLines.SETRANGE("No.", "Farmer No.");
                NODLines.SETFILTER("NOD/NOC", TDSNatureOfDeduction);
                NODLines.SETFILTER("Nature of Remittance", NatureOfRemittance);
                NODLines.SETFILTER("TDS Group", '<>%1', NODLines."TDS Group"::Others);
        */
    end;
}
