page 50118 "GC Statement Summary"
{

    Caption = 'GC Statement Summary';
    DataCaptionExpression = '';
    DeleteAllowed = false;
    Editable = true;
    InsertAllowed = false;
    LinksAllowed = false;
    ModifyAllowed = true;
    PageType = Worksheet;
    SaveValues = true;
    SourceTable = 349;
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                Editable = false;

                field(Name; Name)
                {
                    ApplicationArea = All;
                    CaptionClass = MATRIX_CaptionSet[2];
                    Editable = false;

                    trigger OnDrillDown()
                    begin
                        Matrix_DrillDown;
                    end;
                }
                field(MatrixRecords4; MatrixRecords[4])
                {
                    ApplicationArea = All;
                    CaptionClass = MATRIX_CaptionSet[4];
                    Editable = false;

                    trigger OnDrillDown()
                    begin
                        Matrix_DrillDown;
                    end;
                }
                field(MatrixRecords5; MatrixRecords[5])
                {
                    ApplicationArea = All;
                    CaptionClass = MATRIX_CaptionSet[5];
                    Editable = false;
                    HideValue = false;

                    trigger OnDrillDown()
                    begin
                        Matrix_DrillDown;
                    end;
                }
                field(MatrixRecords6; MatrixRecords[6])
                {
                    ApplicationArea = All;
                    CaptionClass = MATRIX_CaptionSet[6];
                    Editable = false;

                    trigger OnDrillDown()
                    begin
                        Matrix_DrillDown;
                    end;
                }
                field(MatrixRecords7; MatrixRecords[7])
                {
                    ApplicationArea = All;
                    CaptionClass = MATRIX_CaptionSet[7];
                    Editable = false;

                    trigger OnDrillDown()
                    begin
                        Matrix_DrillDown;
                    end;
                }
                field(MatrixRecords8; MatrixRecords[8])
                {
                    ApplicationArea = All;
                    CaptionClass = MATRIX_CaptionSet[8];
                    Editable = false;

                    trigger OnDrillDown()
                    begin
                        Matrix_DrillDown;
                    end;
                }
                field(MatrixRecords9; MatrixRecords[9])
                {
                    ApplicationArea = All;
                    CaptionClass = MATRIX_CaptionSet[9];
                    Editable = false;

                    trigger OnDrillDown()
                    begin
                        Matrix_DrillDown;
                    end;
                }
                field(MatrixRecords10; MatrixRecords[10])
                {
                    ApplicationArea = All;
                    CaptionClass = MATRIX_CaptionSet[10];
                    Editable = false;

                    trigger OnDrillDown()
                    begin
                        Matrix_DrillDown;
                    end;
                }
                field(MatrixRecords11; MatrixRecords[11])
                {
                    ApplicationArea = All;
                    CaptionClass = MATRIX_CaptionSet[11];
                    Editable = false;

                    trigger OnDrillDown()
                    begin
                        Matrix_DrillDown;
                    end;
                }
                field(MatrixRecords12; MatrixRecords[12])
                {
                    ApplicationArea = All;
                    CaptionClass = MATRIX_CaptionSet[12];
                    Editable = false;

                    trigger OnDrillDown()
                    begin
                        Matrix_DrillDown;
                    end;
                }
                field(MatrixRecords13; MatrixRecords[13])
                {
                    ApplicationArea = All;
                    CaptionClass = MATRIX_CaptionSet[13];
                    Editable = false;

                    trigger OnDrillDown()
                    begin
                        Matrix_DrillDown;
                    end;
                }
                field(MatrixRecords14; MatrixRecords[14])
                {
                    ApplicationArea = All;
                    CaptionClass = MATRIX_CaptionSet[14];
                    Editable = false;

                    trigger OnDrillDown()
                    begin
                        Matrix_DrillDown;
                    end;
                }
                field(MatrixRecords15; MatrixRecords[15])
                {
                    ApplicationArea = All;
                    CaptionClass = MATRIX_CaptionSet[15];
                    Editable = false;

                    trigger OnDrillDown()
                    begin
                        Matrix_DrillDown;
                    end;
                }
                field(MatrixRecords16; MatrixRecords[16])
                {
                    ApplicationArea = All;
                    CaptionClass = MATRIX_CaptionSet[16];
                    Editable = false;

                    trigger OnDrillDown()
                    begin
                        Matrix_DrillDown;
                    end;
                }
                field(MatrixRecords17; MatrixRecords[17])
                {
                    ApplicationArea = All;
                    CaptionClass = MATRIX_CaptionSet[17];
                    Editable = false;

                    trigger OnDrillDown()
                    begin
                        Matrix_DrillDown;
                    end;
                }
                field(MatrixRecords18; MatrixRecords[18])
                {
                    ApplicationArea = All;
                    CaptionClass = MATRIX_CaptionSet[18];
                    Editable = false;

                    trigger OnDrillDown()
                    begin
                        Matrix_DrillDown;
                    end;
                }
                field(MatrixRecords19; MatrixRecords[19])
                {
                    ApplicationArea = All;
                    CaptionClass = MATRIX_CaptionSet[19];
                    Editable = false;

                    trigger OnDrillDown()
                    begin
                        Matrix_DrillDown;
                    end;
                }
                field(MatrixRecords20; MatrixRecords[20])
                {
                    ApplicationArea = All;
                    CaptionClass = MATRIX_CaptionSet[20];
                }

            }

            group(Group5)
            {
                field(MATRIX_CaptionTotal3; MATRIX_CaptionTotal[3])
                {
                    ApplicationArea = All;
                    // CaptionClass = MATRIX_CaptionSet[3];
                    Caption = 'Bank Charge Amount';
                    Editable = false;
                }

                field(MATRIX_CaptionTotal4; MATRIX_CaptionTotal[4])
                {
                    ApplicationArea = All;
                    // CaptionClass = MATRIX_CaptionSet[4];
                    Caption = 'Bal. Account Name';
                    Editable = false;
                }
                field("Cheque No.2"; MATRIX_CaptionTotal[5])
                {
                    ApplicationArea = All;
                    // CaptionClass = MATRIX_CaptionSet[5];
                    Editable = false;
                }
                field("Debit Amount2"; MATRIX_CaptionTotal[6])
                {
                    ApplicationArea = All;
                    CaptionClass = MATRIX_CaptionSet[6];
                    Caption = 'Debit Amount2';
                    Editable = false;
                }
                field(MATRIX_CaptionTotal7; MATRIX_CaptionTotal[7])
                {
                    ApplicationArea = All;
                    // CaptionClass = MATRIX_CaptionSet[7];
                    Editable = false;
                }

                field("Credit Amount2"; MATRIX_CaptionTotal[8])
                {
                    ApplicationArea = All;
                    // CaptionClass = MATRIX_CaptionSet[8];
                    Caption = 'Credit Amount3';
                    Editable = false;
                }
                field(Balance; MATRIX_CaptionTotal[9])
                {
                    ApplicationArea = All;
                    // AutoFormatType = 1;
                    //  CaptionClass = MATRIX_CaptionSet[9];
                    Caption = 'Balance';
                    Editable = false;
                }
                field(TotalBalance; MATRIX_CaptionTotal[10])
                {
                    ApplicationArea = All;
                    // AutoFormatType = 1;
                    // CaptionClass = MATRIX_CaptionSet[10];
                    Caption = 'Total Balance';
                    Editable = false;
                }
                field(MATRIX_CaptionTotal11; MATRIX_CaptionTotal[11])
                {
                    ApplicationArea = All;
                    //  CaptionClass = MATRIX_CaptionSet[11];
                    Editable = false;
                }
                field("Credit Amount21"; MATRIX_CaptionTotal[12])
                {
                    ApplicationArea = All;
                    //  CaptionClass = MATRIX_CaptionSet[12];
                    Caption = 'Credit Amount21';
                    Editable = false;
                }
                field(Balance1; MATRIX_CaptionTotal[13])
                {
                    ApplicationArea = All;
                    // AutoFormatType = 1;
                    // CaptionClass = MATRIX_CaptionSet[13];
                    Caption = 'Balance11';
                    Editable = false;
                }
                field(TotalBalance1; MATRIX_CaptionTotal[14])
                {
                    ApplicationArea = All;
                    // AutoFormatType = 1;
                    //  CaptionClass = MATRIX_CaptionSet[14];
                    Caption = 'Total Balance1';
                    Editable = false;
                }
                field("Credit Amount211"; MATRIX_CaptionTotal[15])
                {
                    ApplicationArea = All;
                    //  CaptionClass = MATRIX_CaptionSet[15];
                    Caption = 'Credit Amount21';
                    Editable = false;
                }
                field(Balance11; MATRIX_CaptionTotal[16])
                {
                    ApplicationArea = All;
                    // AutoFormatType = 1;
                    // CaptionClass = MATRIX_CaptionSet[16];
                    Caption = 'Balance11';
                    Editable = false;
                }
                field(MATRIX_CaptionTotal17; MATRIX_CaptionTotal[17])
                {
                    ApplicationArea = All;
                    //  AutoFormatType = 1;
                    //  CaptionClass = MATRIX_CaptionSet[17];
                    Caption = 'Total Balance1';
                    Editable = false;
                }
                field(MATRIX_CaptionTotal18; MATRIX_CaptionTotal[18])
                {
                    ApplicationArea = All;
                    // AutoFormatType = 1;
                    // CaptionClass = MATRIX_CaptionSet[18];
                    Caption = 'Balance';
                    Editable = false;
                }
                field(MATRIX_CaptionTotal19; MATRIX_CaptionTotal[19])
                {
                    ApplicationArea = All;
                    //  AutoFormatType = 1;
                    // CaptionClass = MATRIX_CaptionSet[19];
                    Caption = 'Total Balance1';
                    Editable = false;
                }
                field(MATRIX_CaptionTotal20; MATRIX_CaptionTotal[20])
                {
                    ApplicationArea = All;
                    CaptionClass = MATRIX_CaptionSet[20];
                    // Caption = 'Feed Retrurn %';
                    Editable = false;
                }


            }


        }
    }

    actions
    {
        area(processing)
        {
            action("Export Excel Sheet")
            {
                Image = Entries;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;
                trigger OnAction()
                begin
                    CLEAR(GcStatementExcelSheetReport);
                    GcStatementExcelSheetReport.GetDateFillter(StartDateLocal, EnddateLocal);
                    GcStatementExcelSheetReport.RUN();
                end;
            }
            action("Update Feed Intake")
            {
                ApplicationArea = All;

                trigger OnAction()
                var
                    UpdateFeedIntakeMaster: Codeunit 50021;
                    ProductionOrder: Record 5405;
                begin
                    UpdateFeedIntakeMaster.RUN;
                end;
            }
        }
    }


    var
        MatrixRecords: array[32] of code[100];
        //  MatrixRecords: array[32] of Code[100];
        MATRIX_CaptionSet: array[32] of Text[1024];
        Text004: Label 'Income Statement';
        Text005: Label 'Balance Sheet';
        Text006: Label 'Expected Cost Setup';
        Text007: Label 'Post Cost to G/L';
        Text008: Label 'Compression';
        Text009: Label 'Posting Group';
        Text010: Label 'Direct Posting';
        Text011: Label 'Posting Date';
        Text012: Label 'Closed Fiscal Year';
        Text013: Label 'Similar Accounts';
        Text014: Label 'Deleted Accounts';
        CostPostingNotSelectedTxt: Label 'Expected Cost Posting to G/L is not selected in the Inventory Setup window. Therefore, inventory interim G/L accounts are empty and this causes a difference between inventory and G/L totals.';
        CostAmountsNotPostedYetTxt: Label 'Some of the cost amounts in the inventory ledger have not yet been posted to the general ledger. You must run the Post Inventory Cost to G/L batch job to reconcile the ledgers.';
        EntriesCompressedTxt: Label 'Some inventory or G/L entries have been date compressed.';
        ReassigningAccountsTxt: Label 'You may have restructured your chart of accounts by reassigning inventory related accounts in the General or Inventory Posting Setup.';
        PostedDirectlyToGLAccountTxt: Label 'Some inventory costs have been posted directly to a G/L account, bypassing the inventory subledger.';
        Text021: Label 'There is a discrepancy between the posting date of the value entry and the associated G/L entry within the reporting period.';
        PostedInClosedFiscalYearTxt: Label 'Some of the cost amounts are posted in a closed fiscal year. Therefore, the inventory-related totals are different from their related G/L accounts in the income statement.';
        Text023: Label 'You have possibly defined one G/L account for different inventory transactions.';
        DeletingAccountsTxt: Label 'You may have restructured your chart of accounts by deleting one or more inventory related G/L accounts.';
        StartDate: Date;
        EndDate: Date;
        Location: Code[20];
        BranchName: Code[30];
        StartDateLocal: Date;
        EnddateLocal: Date;
        BranchCodeLocal: Code[20];
        LocationLocal: Code[20];
        Region: Code[10];
        NoofFarm: Integer;
        MatrixRecordsData: array[100] of Decimal;
        GCStatementReportEntry: Page 50119;
        MATRIX_CaptionTotal: array[100] of Code[20];
        BirdSoldNo: Decimal;
        TotalFeedConsKG: Decimal;
        DimensionValue1: Record 349;
        ExcelBuffer: Record 370 temporary;
        GCStatementExcelSheet: Record 50039;
        EntryNo: Integer;
        EntryCount: Integer;
        GcStatementExcelSheetReport: Report 50073;

    trigger OnAfterGetRecord()
    begin
        InitializeMatrixData;
        SetMatrixCaptionWithFillter(Rec.Code);
        //MESSAGE('Test');
        GCStatementExcelSheet.RESET;
        GCStatementExcelSheet.SETRANGE(GCStatementExcelSheet."2", Rec.Code);
        IF NOT GCStatementExcelSheet.FINDFIRST THEN BEGIN
            EntryNo += 1;
            GCStatementExcelSheet."Entry No" := EntryNo;
            //MESSAGE(FORMAT(EntryNo));
            GCStatementExcelSheet."1" := '';
            GCStatementExcelSheet."2" := Rec.Code;
            IF MatrixRecords[3] <> '' THEN
                EVALUATE(GCStatementExcelSheet."3", MatrixRecords[3]);
            IF MatrixRecords[4] <> '' THEN
                EVALUATE(GCStatementExcelSheet."4", MatrixRecords[4]);
            IF MatrixRecords[5] <> '' THEN
                EVALUATE(GCStatementExcelSheet."5", MatrixRecords[5]);
            IF MatrixRecords[6] <> '' THEN
                EVALUATE(GCStatementExcelSheet."6", MatrixRecords[6]);
            IF MatrixRecords[7] <> '' THEN
                EVALUATE(GCStatementExcelSheet."7", MatrixRecords[7]);
            IF MatrixRecords[8] <> '' THEN
                EVALUATE(GCStatementExcelSheet."8", MatrixRecords[8]);
            IF MatrixRecords[9] <> '' THEN
                EVALUATE(GCStatementExcelSheet."9", MatrixRecords[9]);
            IF MatrixRecords[10] <> '' THEN
                EVALUATE(GCStatementExcelSheet."10", MatrixRecords[10]);
            IF MatrixRecords[11] <> '' THEN
                EVALUATE(GCStatementExcelSheet."11", MatrixRecords[11]);
            IF MatrixRecords[12] <> '' THEN
                EVALUATE(GCStatementExcelSheet."12", MatrixRecords[12]);
            IF MatrixRecords[13] <> '' THEN
                EVALUATE(GCStatementExcelSheet."13", MatrixRecords[13]);
            IF MatrixRecords[14] <> '' THEN
                EVALUATE(GCStatementExcelSheet."14", MatrixRecords[14]);
            IF MatrixRecords[15] <> '' THEN
                EVALUATE(GCStatementExcelSheet."15", MatrixRecords[15]);
            IF MatrixRecords[16] <> '' THEN
                EVALUATE(GCStatementExcelSheet."16", MatrixRecords[16]);
            IF MatrixRecords[17] <> '' THEN
                EVALUATE(GCStatementExcelSheet."17", MatrixRecords[17]);
            IF MatrixRecords[18] <> '' THEN
                EVALUATE(GCStatementExcelSheet."18", MatrixRecords[18]);
            IF MatrixRecords[19] <> '' THEN
                EVALUATE(GCStatementExcelSheet."19", MatrixRecords[19]);
            GCStatementExcelSheet.Farm := Rec.Name;
            //GCStatementExcelSheet.INSERT(TRUE);

        END;
    end;

    trigger OnOpenPage()
    begin
        GCStatementExcelSheet.DELETEALL;
        SetMatrixCaption;
        UpdateExcel;
        SetMatrixCaptionSum;
        EntryNo := 1;
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        // DimensionValue1.RESET;
        // DimensionValue1.SETRANGE(DimensionValue1."Global Dimension No.",2);
        // DimensionValue1.SETRANGE(DimensionValue1.Flag,TRUE);
        // IF DimensionValue1.FINDSET THEN
        //  REPEAT
        //    DimensionValue1.Flag := FALSE;
        //    DimensionValue1.MODIFY;
        //    UNTIL DimensionValue1.NEXT=0
    end;

    local procedure SetMatrixCaption()
    begin
        MATRIX_CaptionSet[1] := 'Area';
        MATRIX_CaptionSet[2] := 'Branch';
        MATRIX_CaptionSet[3] := 'No. Of Farm.';
        MATRIX_CaptionSet[4] := 'Chicks Housed';
        MATRIX_CaptionSet[5] := 'Feed Intake %';
        MATRIX_CaptionSet[6] := 'FCR';
        MATRIX_CaptionSet[7] := 'CFCR';
        MATRIX_CaptionSet[8] := 'Avg. Weight';
        MATRIX_CaptionSet[9] := 'Mean Age';
        MATRIX_CaptionSet[10] := 'Day Gain';
        MATRIX_CaptionSet[11] := 'Mortality %';
        MATRIX_CaptionSet[12] := 'EEF';
        MATRIX_CaptionSet[13] := 'Chick Cost';
        MATRIX_CaptionSet[14] := 'Feed Cost';
        MATRIX_CaptionSet[15] := 'Medicine Cost';
        MATRIX_CaptionSet[16] := 'Admin Cost';
        MATRIX_CaptionSet[17] := 'Prod. Cost';
        MATRIX_CaptionSet[18] := 'GC Per Kg.';
        MATRIX_CaptionSet[19] := 'GC Per Bird';
        MATRIX_CaptionSet[19] := 'GC Per Bird';
        MATRIX_CaptionSet[20] := 'Feed Return %';
        //MATRIX_CaptionSet[20] := '';
    end;


    procedure Load(StartDate: Date; EndDate: Date; BranchFillter: Code[250]; LocationFillter: Code[250])
    begin
        LocationLocal := LocationFillter;
        BranchCodeLocal := BranchFillter;
        StartDateLocal := StartDate;
        EnddateLocal := EndDate;
    end;

    local procedure SetMatrixCaptionWithFillter(BFillter: Code[1000])
    var
        Location: Record 14;
        DimensionValue: Record 349;
        GCStatement: Record 50015;
        LineCount: Integer;
        EFFValue: Decimal;
        MortalityValue: Decimal;
        ChickHousedValue: Decimal;
        "Mortality%Value": Decimal;
        BirdSoldKg: Decimal;
        BirdSoldNo: Decimal;
        "BodyQgt%": Decimal;
        FeedConsKg: Decimal;
        FCRValue: Decimal;
        CFCRValue: Decimal;
        ProdutionCost: Decimal;
        TotalAmountPay: Decimal;
        ChikCostAmt: Decimal;
        FeedCostAmt: Decimal;
        MedicineCost: Decimal;
        AdmnCost2: Decimal;
        ToatlCostProduction: Decimal;
        CostOfPrdAfterRC2: Decimal;
        VaccineCostAmt: Decimal;
        EFFPart1: Decimal;
        EFFPart2: Decimal;
        U7: Decimal;
        X7: Decimal;
        J7: Decimal;
        AB7: Decimal;
        MeanAgeFarm: Decimal;
        "BodyWt%": Decimal;
        MeanAgeTotal: Decimal;
        FCR: Decimal;
        MeanAgeC: Decimal;
        FeedIntake: Decimal;
        CunFeedActual: Decimal;
        CunFeedStd: Decimal;
        TotalFeedShpt: Decimal;
        TotalFeedRecpt: Decimal;
    begin
        //MESSAGE(BFillter);
        FeedIntake := 0;
        EntryCount += 1;
        CunFeedActual := 0;
        CunFeedStd := 0;
        TotalFeedRecpt := 0;
        TotalFeedShpt := 0;
        //MESSAGE('%1',EntryCount);
        InitializeMatrixData;
        Location.RESET;
        IF Location.GET(LocationLocal) THEN;
        //Message(Location.Name);
        DimensionValue.RESET;
        DimensionValue.SETRANGE(DimensionValue."Global Dimension No.", 2);
        DimensionValue.SETRANGE(DimensionValue.Blocked, FALSE);
        DimensionValue.SETRANGE(DimensionValue.Code, BFillter);
        IF DimensionValue.FINDFIRST THEN;
        //MESSAGE(DimensionValue.Name);
        GCStatement.RESET;
        GCStatement.SETRANGE(GCStatement.Posted, TRUE);
        IF (StartDateLocal <> 0D) AND (EnddateLocal <> 0D) THEN
            GCStatement.SETRANGE(GCStatement."Liquidation Date", StartDateLocal, EnddateLocal);
        //IF BranchCodeLocal <> '' THEN// Suman
        GCStatement.SETFILTER(GCStatement."Shortcut Dimension 2 Code", BFillter);
        IF LocationLocal <> '' THEN
            GCStatement.SETRANGE(GCStatement."Shortcut Dimension 3 Code", LocationLocal);
        // if Region <> '' then
        // GCStatement.SETRANGE(GCStatement.Region, Region);// Suman
        IF GCStatement.FINDSET THEN BEGIN
            NoofFarm := GCStatement.COUNT;
            REPEAT
                LineCount += 1;
                CostOfPrdAfterRC2 += GCStatement."Cost of Prod. After RC2";
                ToatlCostProduction += GCStatement."TOTAL COST OF PRODUCTION2";
                AdmnCost2 += GCStatement."AdministrationCost Rs2.2/Bird2";
                MedicineCost += GCStatement."Medicne Cost Amt.";
                FeedCostAmt += GCStatement."Feed Cost Amt.";
                ChikCostAmt += GCStatement."Chik Cost Amt.";
                TotalAmountPay += GCStatement."TOTAL AMOUNT PAYABLE";
                ChickHousedValue += GCStatement."Chick Housed";
                MortalityValue += GCStatement.Mortality;
                BirdSoldKg += GCStatement."Birds Sold (kg)";
                BirdSoldNo += GCStatement."Birds Sold (Nos)";
                FeedConsKg += GCStatement."Feed Consumption(kgs)";
                //EFFValue += GCStatement.EEF;
                VaccineCostAmt += GCStatement."Vaccine Cost Amt.";
                MeanAgeFarm += GCStatement."Mean Age" * GCStatement."Birds Sold (Nos)";
                FeedIntake := GCStatement."Feed Intake";
                CunFeedStd += GCStatement."Cum. Feed Std.";
                CunFeedActual += GCStatement."Cum. Feed Consuption";
                TotalFeedShpt += GCStatement."Total Feed Shiped";
                TotalFeedRecpt += GCStatement."Total Feed Receive";
            UNTIL GCStatement.NEXT = 0;
        END ELSE BEGIN
            DimensionValue.RESET;
            DimensionValue.SETRANGE(DimensionValue."Global Dimension No.", 2);
            DimensionValue.SETRANGE(DimensionValue.Blocked, FALSE);
            DimensionValue.SETRANGE(DimensionValue.Code, BFillter);
            IF DimensionValue.FINDFIRST THEN BEGIN
                //DimensionValue.Flag := TRUE;
                //DimensionValue.MODIFY;
            END;
        END;
        //EFFPart1 :=
        //MESSAGE('%1',NoofFarm);
        MatrixRecords[1] := FORMAT(Location.Name);
        MatrixRecords[3] := FORMAT(LineCount);
        MatrixRecords[4] := FORMAT(ROUND(ChickHousedValue, 0.01, '='));
        IF CunFeedStd <> 0 THEN
            MatrixRecords[5] := FORMAT(ROUND((CunFeedActual / CunFeedStd) * 100, 0.01, '='));
        IF BirdSoldKg <> 0 THEN BEGIN
            MatrixRecords[6] := FORMAT(ROUND(FeedConsKg / BirdSoldKg, 0.01, '='));
            FCR := ROUND(FeedConsKg / BirdSoldKg, 0.01, '=');
            MatrixRecords[13] := FORMAT(ROUND(ChikCostAmt / BirdSoldKg, 0.01, '='));
            MatrixRecords[14] := FORMAT(ROUND(FeedCostAmt / BirdSoldKg, 0.01, '='));
            MatrixRecords[15] := FORMAT(ROUND((MedicineCost + VaccineCostAmt) / BirdSoldKg, 0.01, '='));
            MatrixRecords[16] := FORMAT(ROUND(AdmnCost2 / BirdSoldKg, 0.01, '='));
            MatrixRecords[17] := FORMAT(ROUND(ToatlCostProduction / BirdSoldKg, 0.01, '='));
            MatrixRecords[18] := FORMAT(ROUND(TotalAmountPay / BirdSoldKg, 0.01, '='));
        END ELSE BEGIN
            MatrixRecords[6] := FORMAT(ROUND(FeedConsKg, 0.01, '='));
            MatrixRecords[13] := FORMAT(ROUND(ChikCostAmt, 0.01, '='));
            MatrixRecords[14] := FORMAT(ROUND(FeedCostAmt, 0.01, '='));
            MatrixRecords[15] := FORMAT(ROUND((MedicineCost + VaccineCostAmt), 0.01, '='));
            MatrixRecords[16] := FORMAT(ROUND(AdmnCost2, 0.01, '='));
            MatrixRecords[17] := FORMAT(ROUND(ToatlCostProduction, 0.01, '='));
            MatrixRecords[18] := FORMAT(ROUND(TotalAmountPay, 0.01, '='));
        END;
        IF BirdSoldNo <> 0 THEN BEGIN
            MatrixRecords[8] := FORMAT(ROUND(BirdSoldKg / BirdSoldNo, 0.01, '='));
            CFCRValue := (2 - ROUND(BirdSoldKg / BirdSoldNo, 0.01, '=') / 4) + ROUND(FeedConsKg / BirdSoldKg, 0.01, '=');
            MatrixRecords[9] := FORMAT(ROUND(MeanAgeFarm / BirdSoldNo, 0.01, '='));
            MeanAgeC := ROUND(MeanAgeFarm / BirdSoldNo, 0.01, '=');
            MeanAgeTotal := ROUND(MeanAgeFarm / BirdSoldNo, 0.01, '=');
            "BodyWt%" := BirdSoldKg / BirdSoldNo;
            MatrixRecords[10] := FORMAT(ROUND(("BodyWt%" / MeanAgeTotal) * 1000, 0.01, '='));
            CFCRValue := ROUND((2 - "BodyWt%") / 4 + FCR);
            MatrixRecords[7] := FORMAT(ROUND(CFCRValue, 0.01, '='));
        END ELSE BEGIN
            MatrixRecords[8] := FORMAT(ROUND(BirdSoldKg, 0.01, '='));
            MatrixRecords[9] := FORMAT(ROUND(MeanAgeFarm, 0.01, '='));
        END;
        IF ChickHousedValue <> 0 THEN BEGIN
            MatrixRecords[11] := FORMAT(ROUND(MortalityValue / ChickHousedValue * 100, 0.01, '='));
            U7 := ROUND(MortalityValue / ChickHousedValue * 100, 0.01, '=');
            MatrixRecords[19] := FORMAT(ROUND(TotalAmountPay / ChickHousedValue, 0.01, '='));
        END ELSE BEGIN
            MatrixRecords[11] := FORMAT(ROUND(MortalityValue, 0.01, '='));
            MatrixRecords[19] := FORMAT(ROUND(TotalAmountPay, 0.01, '='));
        END;
        IF (MeanAgeC <> 0) AND (FCR <> 0) THEN
            EFFValue := ROUND(((100 - U7) * "BodyWt%") / (MeanAgeC * FCR) * 100, 0.01, '=');
        MatrixRecords[12] := FORMAT(ROUND(EFFValue, 0.01, '='));
        IF TotalFeedRecpt <> 0 THEN BEGIN
            MatrixRecords[20] := FORMAT(ROUND((TotalFeedShpt / TotalFeedRecpt) * 100, 0.01, '='));
        END;
        ///MESSAGE('%1,%2',TotalFeedRecpt,TotalFeedShpt);
    end;

    local procedure InitializeMatrixData()
    begin
        MatrixRecords[1] := '';
        MatrixRecords[2] := '';
        MatrixRecords[3] := '';
        MatrixRecords[4] := '';
        MatrixRecords[5] := '';
        MatrixRecords[6] := '';
        MatrixRecords[7] := '';
        MatrixRecords[8] := '';
        MatrixRecords[9] := '';
        MatrixRecords[10] := '';
        MatrixRecords[11] := '';
        MatrixRecords[12] := '';
        MatrixRecords[13] := '';
        MatrixRecords[14] := '';
        MatrixRecords[15] := '';
        MatrixRecords[16] := '';
        MatrixRecords[17] := '';
        MatrixRecords[18] := '';
        MatrixRecords[19] := '';
        MatrixRecords[20] := '';
        MatrixRecordsData[1] := 0;
        MatrixRecordsData[2] := 0;
        MatrixRecordsData[3] := 0;
        MatrixRecordsData[4] := 0;
        MatrixRecordsData[5] := 0;
        MatrixRecordsData[6] := 0;
        MatrixRecordsData[7] := 0;
        MatrixRecordsData[9] := 0;
        MatrixRecordsData[10] := 0;
        MatrixRecordsData[11] := 0;
        MatrixRecordsData[12] := 0;
        MatrixRecordsData[13] := 0;
        MatrixRecordsData[14] := 0;
        MatrixRecordsData[15] := 0;
        MatrixRecordsData[16] := 0;
        MatrixRecordsData[17] := 0;
        MatrixRecordsData[19] := 0;
        MatrixRecordsData[20] := 0;
    end;

    procedure Matrix_DrillDown()
    var
        GCStatement: Record 50015;
    begin
        GCStatement.RESET;
        GCStatement.SETRANGE(GCStatement.Posted, TRUE);
        IF (StartDateLocal <> 0D) AND (EnddateLocal <> 0D) THEN
            GCStatement.SETRANGE(GCStatement."Liquidation Date", StartDateLocal, EnddateLocal);
        // IF BranchCodeLocal <> '' THEN// Suman
        GCStatement.SETRANGE(GCStatement."Shortcut Dimension 2 Code", Rec.Code);
        IF LocationLocal <> '' THEN
            GCStatement.SETRANGE(GCStatement."Shortcut Dimension 3 Code", LocationLocal);
        // IF Region <> '' THEN
        //     GCStatement.SETRANGE(GCStatement.Region, Region);
        IF GCStatement.FINDSET THEN BEGIN
            CLEAR(GCStatementReportEntry);
            GCStatementReportEntry.SETTABLEVIEW(GCStatement);
            GCStatementReportEntry.RUNMODAL;
        END;
    end;

    local procedure SetMatrixCaptionSum()
    var
        GCStatement: Record 50015;
        LineCount: Integer;
        EFFValue: Decimal;
        MortalityValue: Decimal;
        ChickHousedValue: Decimal;
        "Mortality%Value": Decimal;
        BirdSoldKg: Decimal;
        BirdSoldNo: Decimal;
        "BodyQgt%": Decimal;
        FeedConsKg: Decimal;
        FCRValue: Decimal;
        CFCRValue: Decimal;
        ProdutionCost: Decimal;
        TotalAmountPay: Decimal;
        ChikCostAmt: Decimal;
        FeedCostAmt: Decimal;
        MedicineCost: Decimal;
        AdmnCost2: Decimal;
        ToatlCostProduction: Decimal;
        CostOfPrdAfterRC2: Decimal;
        VaccineCostAmt: Decimal;
        MeanAgeFarm: Decimal;
        "BodyWt%": Decimal;
        MeanAgeTotal: Decimal;
        FCR: Decimal;
        U7: Decimal;
        MeanAgeC: Decimal;
        FeedIntake: Decimal;
        CunFeedStd: Decimal;
        CunFeedActual: Decimal;
        TotalFeedShpt: Decimal;
        TotalFeedRecpt: Decimal;
    begin
        MATRIX_CaptionTotal[2] := '';
        MATRIX_CaptionTotal[3] := '';
        MATRIX_CaptionTotal[4] := '';
        MATRIX_CaptionTotal[5] := '';
        MATRIX_CaptionTotal[6] := '';
        MATRIX_CaptionTotal[7] := '';
        MATRIX_CaptionTotal[8] := '';
        MATRIX_CaptionTotal[9] := '';
        MATRIX_CaptionTotal[10] := '';
        MATRIX_CaptionTotal[11] := '';
        MATRIX_CaptionTotal[12] := '';
        MATRIX_CaptionTotal[13] := '';
        MATRIX_CaptionTotal[14] := '';
        MATRIX_CaptionTotal[15] := '';
        MATRIX_CaptionTotal[16] := '';
        MATRIX_CaptionTotal[17] := '';
        MATRIX_CaptionTotal[18] := '';
        MATRIX_CaptionTotal[19] := '';
        MATRIX_CaptionTotal[20] := '';
        BirdSoldKg := 0;
        TotalFeedConsKG := 0;
        MeanAgeFarm := 0;
        MeanAgeC := 0;
        U7 := 0;
        FCR := 0;
        FeedIntake := 0;
        GCStatement.RESET;
        IF (StartDateLocal <> 0D) AND (EnddateLocal <> 0D) THEN
            GCStatement.SETRANGE(GCStatement."Liquidation Date", StartDateLocal, EnddateLocal);
        GCStatement.SETRANGE(GCStatement.Posted, TRUE);
        GCStatement.SETFILTER(GCStatement."Shortcut Dimension 2 Code", BranchCodeLocal);
        GCStatement.SETFILTER(GCStatement."Shortcut Dimension 3 Code", LocationLocal);
        //GCStatement.SETFILTER(GCStatement.Region, Region);// Suman
        IF GCStatement.FINDSET THEN BEGIN
            REPEAT
                LineCount += 1;
                CostOfPrdAfterRC2 += GCStatement."Cost of Prod. After RC2";
                ToatlCostProduction += GCStatement."TOTAL COST OF PRODUCTION2";
                AdmnCost2 += GCStatement."AdministrationCost Rs2.2/Bird2";
                MedicineCost += GCStatement."Medicne Cost Amt.";
                FeedCostAmt += GCStatement."Feed Cost Amt.";
                ChikCostAmt += GCStatement."Chik Cost Amt.";
                TotalAmountPay += GCStatement."TOTAL AMOUNT PAYABLE";
                ChickHousedValue += GCStatement."Chick Housed";
                MortalityValue += GCStatement.Mortality;
                BirdSoldKg += GCStatement."Birds Sold (kg)";
                BirdSoldNo += GCStatement."Birds Sold (Nos)";
                FeedConsKg += GCStatement."Feed Consumption(kgs)";
                EFFValue += GCStatement.EEF;
                VaccineCostAmt += GCStatement."Vaccine Cost Amt.";
                MeanAgeFarm += GCStatement."Mean Age" * GCStatement."Birds Sold (Nos)";
                CunFeedActual += GCStatement."Cum. Feed Consuption";
                CunFeedStd += GCStatement."Cum. Feed Std.";
                TotalFeedRecpt += GCStatement."Total Feed Receive";
                TotalFeedShpt += GCStatement."Total Feed Shiped";
            UNTIL GCStatement.NEXT = 0
        END;
        IF BirdSoldNo <> 0 THEN
            "BodyWt%" := BirdSoldKg / BirdSoldNo;
        MATRIX_CaptionTotal[3] := FORMAT(LineCount);
        MATRIX_CaptionTotal[4] := FORMAT(ROUND(ChickHousedValue, 0.01, '='));
        IF CunFeedStd <> 0 THEN
            MATRIX_CaptionTotal[5] := FORMAT(ROUND((CunFeedActual / CunFeedStd) * 100, 0.01, '='));
        ;
        //MATRIX_CaptionTotal[12] := FORMAT(ROUND(EFFValue,0.01,'='));
        IF BirdSoldKg <> 0 THEN BEGIN
            MATRIX_CaptionTotal[6] := FORMAT(ROUND(FeedConsKg / BirdSoldKg, 0.01, '='));
            FCR := ROUND(FeedConsKg / BirdSoldKg);
            MATRIX_CaptionTotal[13] := FORMAT(ROUND(ChikCostAmt / BirdSoldKg, 0.01, '='));
            MATRIX_CaptionTotal[14] := FORMAT(ROUND(FeedCostAmt / BirdSoldKg, 0.01, '='));
            MATRIX_CaptionTotal[15] := FORMAT(ROUND((MedicineCost + VaccineCostAmt) / BirdSoldKg, 0.01, '='));
            MATRIX_CaptionTotal[16] := FORMAT(ROUND(AdmnCost2 / BirdSoldKg, 0.01, '='));
            MATRIX_CaptionTotal[17] := FORMAT(ROUND(ToatlCostProduction / BirdSoldKg, 0.01, '='));
            MATRIX_CaptionTotal[18] := FORMAT(ROUND(TotalAmountPay / BirdSoldKg, 0.01, '='));
        END ELSE BEGIN
            MATRIX_CaptionTotal[6] := FORMAT(ROUND(FeedConsKg, 0.01, '='));
            MATRIX_CaptionTotal[13] := FORMAT(ROUND(ChikCostAmt, 0.01, '='));
            MATRIX_CaptionTotal[14] := FORMAT(ROUND(FeedCostAmt, 0.01, '='));
            MATRIX_CaptionTotal[15] := FORMAT(ROUND((MedicineCost + VaccineCostAmt), 0.01, '='));
            MATRIX_CaptionTotal[16] := FORMAT(ROUND(AdmnCost2, 0.01, '='));
            MATRIX_CaptionTotal[17] := FORMAT(ROUND(ToatlCostProduction, 0.01, '='));
            MATRIX_CaptionTotal[18] := FORMAT(ROUND(TotalAmountPay, 0.01, '='));
        END;
        IF BirdSoldNo <> 0 THEN BEGIN
            MATRIX_CaptionTotal[8] := FORMAT(ROUND(BirdSoldKg / BirdSoldNo, 0.01, '='));
            CFCRValue := ROUND((2 - "BodyWt%") / 4 + FCR);
            //MESSAGE('%1,%2,%3',"BodyWt%",FCR,CFCRValue);
            //MATRIX_CaptionTotal[7] := FORMAT(ROUND(CFCRValue,0.01,'='));
            MeanAgeC := ROUND(MeanAgeFarm / BirdSoldNo, 0.01, '=');
            MATRIX_CaptionTotal[7] := FORMAT(ROUND(CFCRValue, 0.01, '='));
            MATRIX_CaptionTotal[9] := FORMAT(ROUND(MeanAgeFarm / BirdSoldNo, 0.01, '='));
            MeanAgeTotal := ROUND(MeanAgeFarm / BirdSoldNo, 0.01, '=');
            MATRIX_CaptionTotal[10] := FORMAT(ROUND(("BodyWt%" / MeanAgeTotal) * 1000, 0.01, '='));
        END ELSE BEGIN
            MATRIX_CaptionTotal[6] := FORMAT(ROUND(BirdSoldKg, 0.01, '='));
        END;
        IF ChickHousedValue <> 0 THEN BEGIN
            U7 := ROUND(MortalityValue / ChickHousedValue * 100, 0.01, '=');
            MATRIX_CaptionTotal[11] := FORMAT(ROUND(MortalityValue / ChickHousedValue * 100, 0.01, '='));
            MATRIX_CaptionTotal[19] := FORMAT(ROUND(TotalAmountPay / ChickHousedValue, 0.01, '='));
        END ELSE BEGIN
            MATRIX_CaptionTotal[11] := FORMAT(ROUND(MortalityValue, 0.01, '='));
            MATRIX_CaptionTotal[19] := FORMAT(ROUND(TotalAmountPay, 0.01, '='));
        END;
        IF (MeanAgeC <> 0) AND (FCR <> 0) THEN
            EFFValue := ROUND(((100 - U7) * "BodyWt%") / (MeanAgeC * FCR) * 100, 0.01, '=');
        //MESSAGE('%1,%2,%3,%4,%5',U7,"BodyWt%",MeanAgeC,FCR,EFFValue);
        MATRIX_CaptionTotal[12] := FORMAT(ROUND(EFFValue, 0.01, '='));

        IF TotalFeedRecpt <> 0 THEN BEGIN
            MATRIX_CaptionTotal[20] := FORMAT(ROUND((TotalFeedShpt / TotalFeedRecpt) * 100, 0.01, '='));
        END;
        GCStatementExcelSheet.RESET;
        GCStatementExcelSheet.SETRANGE(GCStatementExcelSheet."2", 'Total');
        IF NOT GCStatementExcelSheet.FINDFIRST THEN BEGIN
            GCStatementExcelSheet."1" := '';
            GCStatementExcelSheet."2" := 'Total';
            IF MATRIX_CaptionTotal[3] <> '' THEN
                EVALUATE(GCStatementExcelSheet."3", MATRIX_CaptionTotal[3]);
            IF MATRIX_CaptionTotal[4] <> '' THEN
                EVALUATE(GCStatementExcelSheet."4", MATRIX_CaptionTotal[4]);
            IF MATRIX_CaptionTotal[5] <> '' THEN
                EVALUATE(GCStatementExcelSheet."5", MATRIX_CaptionTotal[5]);
            IF MATRIX_CaptionTotal[6] <> '' THEN
                EVALUATE(GCStatementExcelSheet."6", MATRIX_CaptionTotal[6]);
            IF MATRIX_CaptionTotal[7] <> '' THEN
                EVALUATE(GCStatementExcelSheet."7", MATRIX_CaptionTotal[7]);
            IF MATRIX_CaptionTotal[8] <> '' THEN
                EVALUATE(GCStatementExcelSheet."8", MATRIX_CaptionTotal[8]);
            IF MATRIX_CaptionTotal[9] <> '' THEN
                EVALUATE(GCStatementExcelSheet."9", MATRIX_CaptionTotal[9]);
            IF MATRIX_CaptionTotal[10] <> '' THEN
                EVALUATE(GCStatementExcelSheet."10", MATRIX_CaptionTotal[10]);
            IF MATRIX_CaptionTotal[11] <> '' THEN
                EVALUATE(GCStatementExcelSheet."11", MATRIX_CaptionTotal[11]);
            IF MATRIX_CaptionTotal[12] <> '' THEN
                EVALUATE(GCStatementExcelSheet."12", MATRIX_CaptionTotal[12]);
            IF MATRIX_CaptionTotal[13] <> '' THEN
                EVALUATE(GCStatementExcelSheet."13", MATRIX_CaptionTotal[13]);
            IF MATRIX_CaptionTotal[14] <> '' THEN
                EVALUATE(GCStatementExcelSheet."14", MATRIX_CaptionTotal[14]);
            IF MATRIX_CaptionTotal[15] <> '' THEN
                EVALUATE(GCStatementExcelSheet."15", MATRIX_CaptionTotal[15]);
            IF MATRIX_CaptionTotal[16] <> '' THEN
                EVALUATE(GCStatementExcelSheet."16", MATRIX_CaptionTotal[16]);
            IF MATRIX_CaptionTotal[17] <> '' THEN
                EVALUATE(GCStatementExcelSheet."17", MATRIX_CaptionTotal[17]);
            IF MATRIX_CaptionTotal[18] <> '' THEN
                EVALUATE(GCStatementExcelSheet."18", MATRIX_CaptionTotal[18]);
            IF MATRIX_CaptionTotal[19] <> '' THEN
                EVALUATE(GCStatementExcelSheet."19", MATRIX_CaptionTotal[19]);
            IF MATRIX_CaptionTotal[20] <> '' THEN
                EVALUATE(GCStatementExcelSheet."Feed Return %", MATRIX_CaptionTotal[20]);
            GCStatementExcelSheet.Farm := 'Total';
            GCStatementExcelSheet."Entry No" := 10000;
            GCStatementExcelSheet.INSERT(TRUE);
        END;
    end;

    local procedure UpdateExcel()
    var
        DimensionValue: Record 349;
    begin
        GCStatementExcelSheet.DELETEALL;
        EntryNo := 1;
        DimensionValue.RESET;
        DimensionValue.SETRANGE(DimensionValue."Global Dimension No.", 2);
        DimensionValue.SETFILTER(DimensionValue.Code, BranchCodeLocal);
        IF DimensionValue.FINDSET THEN BEGIN
            REPEAT
                EntryNo += 1;
                InitializeMatrixData;
                SetMatrixCaptionWithFillter(DimensionValue.Code);
                GCStatementExcelSheet.RESET;
                GCStatementExcelSheet.SETRANGE(GCStatementExcelSheet."2", DimensionValue.Code);
                //GCStatementExcelSheet.SETFILTER(GCStatementExcelSheet."2",'<>%1','0');
                IF NOT GCStatementExcelSheet.FINDFIRST THEN BEGIN
                    GCStatementExcelSheet.INIT;
                    GCStatementExcelSheet."2" := DimensionValue.Code;
                    GCStatementExcelSheet.Farm := DimensionValue.Name;
                    GCStatementExcelSheet."Entry No" := EntryNo;
                    //MESSAGE(FORMAT(EntryNo));
                    IF MatrixRecords[3] <> '' THEN
                        EVALUATE(GCStatementExcelSheet."3", MatrixRecords[3]);
                    IF MatrixRecords[4] <> '' THEN
                        EVALUATE(GCStatementExcelSheet."4", MatrixRecords[4]);
                    IF MatrixRecords[5] <> '' THEN
                        EVALUATE(GCStatementExcelSheet."5", MatrixRecords[5]);
                    IF MatrixRecords[6] <> '' THEN
                        EVALUATE(GCStatementExcelSheet."6", MatrixRecords[6]);
                    IF MatrixRecords[7] <> '' THEN
                        EVALUATE(GCStatementExcelSheet."7", MatrixRecords[7]);
                    IF MatrixRecords[8] <> '' THEN
                        EVALUATE(GCStatementExcelSheet."8", MatrixRecords[8]);
                    IF MatrixRecords[9] <> '' THEN
                        EVALUATE(GCStatementExcelSheet."9", MatrixRecords[9]);
                    IF MatrixRecords[10] <> '' THEN
                        EVALUATE(GCStatementExcelSheet."10", MatrixRecords[10]);
                    IF MatrixRecords[11] <> '' THEN
                        EVALUATE(GCStatementExcelSheet."11", MatrixRecords[11]);
                    IF MatrixRecords[12] <> '' THEN
                        EVALUATE(GCStatementExcelSheet."12", MatrixRecords[12]);
                    IF MatrixRecords[13] <> '' THEN
                        EVALUATE(GCStatementExcelSheet."13", MatrixRecords[13]);
                    IF MatrixRecords[14] <> '' THEN
                        EVALUATE(GCStatementExcelSheet."14", MatrixRecords[14]);
                    IF MatrixRecords[15] <> '' THEN
                        EVALUATE(GCStatementExcelSheet."15", MatrixRecords[15]);
                    IF MatrixRecords[16] <> '' THEN
                        EVALUATE(GCStatementExcelSheet."16", MatrixRecords[16]);
                    IF MatrixRecords[17] <> '' THEN
                        EVALUATE(GCStatementExcelSheet."17", MatrixRecords[17]);
                    IF MatrixRecords[18] <> '' THEN
                        EVALUATE(GCStatementExcelSheet."18", MatrixRecords[18]);
                    IF MatrixRecords[19] <> '' THEN
                        EVALUATE(GCStatementExcelSheet."19", MatrixRecords[19]);
                    IF MatrixRecords[20] <> '' THEN
                        EVALUATE(GCStatementExcelSheet."Feed Return %", MatrixRecords[20]);
                    //GCStatementExcelSheet.Farm := Rec.Name;
                    GCStatementExcelSheet.INSERT(TRUE);
                END;
            UNTIL DimensionValue.NEXT = 0;
        END;
    end;

}
