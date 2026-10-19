report 50024 "Old GC Statement"
{
    UsageCategory = Administration;
    Caption = 'Old GC Statement Report';
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'ReportLayout\OldGCStatement.rdl';
    dataset
    {
        dataitem("GC Statement"; "GC Statement")
        {
            column(TDS; TDS)
            {
            }
            column(CompanyName; CompanyName)
            { }
            column(LineText11; LineText11)
            {
            }
            column(Batchcode; Batchcode)
            {
            }
            column(LineText10; LineText10)
            {
            }
            column(LineText9; LineText9)
            {
            }
            column(LineText8; LineText8)
            {
            }
            column(LineText7; LineText7)
            {
            }
            column(LineText6; LineText6)
            {
            }
            column(LineText5; LineText5)
            {
            }
            column(LineText4; LineText4)
            {
            }
            column(LineText3; LineText3)
            {
            }
            column(LineText2; LineText2)
            {
            }
            column(LineText1; LineText1)
            {
            }
            column(LineText13; LineText13)
            {
            }
            column(EEFText; EEFText)
            {
            }
            column(Text0000156; Text0000156)
            {
            }
            column(Text00123; Text00123)
            {
            }
            column(Text01234; Text01234)
            {
            }
            column(Text124; Text124)
            {
            }
            column(BroodingIncentive_GCStatement; "GC Statement"."Brooding Incentive")
            {
            }
            column(RateIncentiveActualAmount_GCStatement; "GC Statement"."Rate Incentive- Actual Amount")
            {
            }
            column(MaxRateIncentiveUpto25_GCStatement; "GC Statement"."Max Rate Incentive Upto 2.5")
            {
            }
            column(ActualAmount_GCStatement; "GC Statement"."Actual Amount")
            {
            }
            column(TotalofAllRateIncentive_GCStatement; "GC Statement"."Total of All Rate Incentive")
            {
            }
            column(BirdRate; BirdRate)
            {
            }
            column(GCValue; GCValue)
            {
            }
            column(No_GCStatement; "GC Statement"."No.")
            {
            }
            column(FlockNo_GCStatement; "GC Statement"."Flock No.")
            {
            }
            column(FlockDescription_GCStatement; PO."Description 2")
            {
            }
            column(FarmCode_GCStatement; "GC Statement"."Farm Code")
            {
            }
            column(FarmName_GCStatement; "GC Statement"."Farm Name")
            {
            }
            column(Region_GCStatement; "GC Statement".Region)
            {
            }
            column(State_GCStatement; "GC Statement".State)
            {
            }
            column(Bank_GCStatement; "GC Statement".Bank)
            {
            }
            column(IFSCCode_GCStatement; "GC Statement"."IFSC Code")
            {
            }
            column(FlokNo; "GC Statement"."Flock No.")
            {
            }
            column(AccountNo_GCStatement; "GC Statement"."Account No")
            {
            }
            column(FarmerName_GCStatement; "GC Statement"."Farmer Name")
            {
            }
            column(Branch_GCStatement; "GC Statement".Branch)
            {
            }
            column(Line_GCStatement; "GC Statement".Line)
            {
            }
            column(BankBranch_GCStatement; "GC Statement"."Bank Branch")
            {
            }
            column(PANNo_GCStatement; "GC Statement"."PAN No")
            {
            }
            column(Grade_GCStatement; "GC Statement".Grade)
            {
            }
            column(HatcheryVendor_GCStatement; "GC Statement"."Hatchery/Vendor")
            {
            }
            column(EEF_GCStatement; ROUND("GC Statement".EEF, 0.001, '='))
            {
            }
            column(NetPayableAfterTDS_GCStatement; ROUND("GC Statement"."Net Payable After TDS", 0.01, '='))
            {
            }
            column(ChickHoused_GCStatement; "GC Statement"."Chick Housed")
            {
            }
            column(BirdsSoldkg_GCStatement; "GC Statement"."Birds Sold (kg)")
            {
            }
            column(BirdsSoldNos_GCStatement; "GC Statement"."Birds Sold (Nos)")
            {
            }
            column(FeedConsumptionkgs_GCStatement; "GC Statement"."Feed Consumption(kgs)")
            {
            }
            column(AccidentalMortRecovery_GCStatement; "GC Statement"."Accidental Mort(Recovery)")
            {
            }
            column(LiquidationDate_GCStatement; "GC Statement"."Liquidation Date")
            {
            }
            column(ReceiptDate_GCStatement; "GC Statement"."Receipt Date")
            {
            }
            column(Mortality_GCStatement; "GC Statement".Mortality)
            {
            }
            column(MortalityPerc_GCStatement; ROUND("GC Statement"."Mortality %", 0.001, '='))
            {
            }
            column(BodyWeight_GCStatement; ROUND("GC Statement"."Body Weight %", 0.001, '='))
            {
            }
            column(ShortExcess_GCStatement; "GC Statement"."Short Excess")
            {
            }
            column(MeanAge_GCStatement; "GC Statement"."Mean Age")
            {
            }
            column(AgeInDays_GCStatement; "GC Statement"."Age (In Days)")
            {
            }
            column(Salerate_GCStatement; ROUND("GC Statement"."Sale rate", 0.001, '='))
            {
            }
            column(SaleAmount_GCStatement; "GC Statement"."Sale Amount")
            {
            }
            column(FCR_GCStatement; ROUND("GC Statement".FCR, 0.001, '='))
            {
            }
            column(CFCR_GCStatement; ROUND("GC Statement".CFCR, 0.001, '='))
            {
            }
            column(ProductionCost_GCStatement; ROUND("GC Statement"."Production Cost", 0.001, '='))
            {
            }
            column(BirdsRearingGC_GCStatement; "GC Statement"."Birds Rearing GC")
            {
            }
            column(IncentiveforLowCost_GCStatement; "GC Statement"."Incentive for Low Cost")
            {
            }
            column(RateIncentiveforSelling1_GCStatement; ROUND("GC Statement"."Rate Incentive for Selling1", 0.001, '='))
            {
            }
            column(RateIncentiveforSelling2_GCStatement; "GC Statement"."Rate Incentive for Selling2")
            {
            }
            column(RateIncentiveforSelling3_GCStatement; "GC Statement"."Rate Incentive for Selling3")
            {
            }
            column(SummaryIncentive1_GCStatement; "GC Statement"."Summary Incentive1")
            {
            }
            column(SummaryIncentive2_GCStatement; "GC Statement"."Summary Incentive2")
            {
            }
            column(FeedUnloadingCharges_GCStatement; "GC Statement"."Feed Unloading Charges")
            {
            }
            column(TotalIncentiveAdd_GCStatement; "GC Statement"."Total Incentive (Add)")
            {
            }
            column(DeductionforhighMort_GCStatement; ROUND("GC Statement"."Deduction for high Mort", 0.001, '='))
            {
            }
            column(ExcessFCROver_GCStatement; "GC Statement"."Excess FCR Over")
            {
            }
            column(DeductionforShortage_GCStatement; ROUND("GC Statement"."Deduction for Shortage", 0.001, '='))
            {
            }
            column(TOTALDEDUCTIONLESS_GCStatement; ROUND("GC Statement"."TOTAL DEDUCTION(LESS)", 0.001, '='))
            {
            }
            column(TOTALAMOUNTPAYABLE_GCStatement; ROUND("GC Statement"."TOTAL AMOUNT PAYABLE", 0.001, '='))
            {
            }
            column(LESSTDS1_GCStatement; ROUND("GC Statement"."LESS: T.D.S @ 1%", 0.001, '='))
            {
            }
            column(AMOUNTPAYABLEAFTERTDS_GCStatement; ROUND("GC Statement"."AMOUNT PAYABLE AFTER T.D.S", 0.001, '='))
            {
            }
            column(SELFDCNO_GCStatement; "GC Statement"."SELF  DC NO :")
            {
            }
            column(AMOUNTpayableperbird_GCStatement; ROUND("GC Statement"."AMOUNT payable per bird", 0.001, '='))
            {
            }
            column(GM_GCStatement; "GC Statement"."G.M.")
            {
            }
            column(DGM_GCStatement; "GC Statement"."D.G.M")
            {
            }
            column(AGMAccounts_GCStatement; "GC Statement"."A.G.M. Accounts")
            {
            }
            column(AsstManagerAccounts_GCStatement; "GC Statement"."Asst.  Manager Accounts")
            {
            }
            column(ZoneManager_GCStatement; "GC Statement"."Zone Manager")
            {
            }
            column(BranchManager_GCStatement; "GC Statement"."Branch Manager")
            {
            }
            column(AccountOfficer_GCStatement; "GC Statement"."Account Officer")
            {
            }
            column(CheckedBy_GCStatement; "GC Statement"."Checked By")
            {
            }
            column(IAccepttheabovepayment_GCStatement; "GC Statement"."I Accept the above payment")
            {
            }
            column(FarmerSignature_GCStatement; "GC Statement"."Farmer Signature")
            {
            }
            column(ChickCostQty_GCStatement; "GC Statement"."Chick Cost Qty")
            {
            }
            column(ChickCostRate_GCStatement; "GC Statement"."Chick Cost Rate")
            {
            }
            column(ChikCostAmt_GCStatement; "GC Statement"."Chik Cost Amt.")
            {
            }
            column(FeedCostQty_GCStatement; "GC Statement"."Feed Cost Qty")
            {
            }
            column(FeedCostRate_GCStatement; "GC Statement"."Feed Cost Rate")
            {
            }
            column(FeedCostAmt_GCStatement; "GC Statement"."Feed Cost Amt.")
            {
            }
            column(MaizeCostQty_GCStatement; "GC Statement"."Maize Cost Qty")
            {
            }
            column(MaizeCostRate_GCStatement; "GC Statement"."Maize Cost Rate")
            {
            }
            column(MaizeCostAmt_GCStatement; "GC Statement"."Maize Cost Amt.")
            {
            }
            column(MedicineCostQty_GCStatement; "GC Statement"."Medicine Cost Qty")
            {
            }
            column(MedicineCostRate_GCStatement; "GC Statement"."Medicine Cost Rate")
            {
            }
            column(MedicneCostAmt_GCStatement; "GC Statement"."Medicne Cost Amt.")
            {
            }
            column(VaccineCostQty_GCStatement; "GC Statement"."Vaccine Cost Qty")
            {
            }
            column(VaccineCostRate_GCStatement; "GC Statement"."Vaccine Cost Rate")
            {
            }
            column(VaccineCostAmt_GCStatement; "GC Statement"."Vaccine Cost Amt.")
            {
            }
            column(AdministrationCostRs22Bird2_GCStatement; "GC Statement"."AdministrationCost Rs2.2/Bird2")
            {
            }
            column(TOTALCOSTOFPRODUCTION2_GCStatement; "GC Statement"."TOTAL COST OF PRODUCTION2")
            {
            }
            column(CostofProdkgBeforeRC2_GCStatement; ROUND("GC Statement"."Cost of Prod./kg Before RC2", 0.001, '='))
            {
            }
            column(BirdSoldINKg2Qty_GCStatement; "GC Statement"."Bird Sold IN Kg.2  Qty.")
            {
            }
            column(BirdSoldINKg2Rate_GCStatement; ROUND("GC Statement"."Bird Sold IN Kg.2  Rate", 0.001, '='))
            {
            }
            column(BirdSoldINKg2Amt_GCStatement; ROUND("GC Statement"."Bird Sold IN Kg.2  Amt.", 0.001, '='))
            {
            }
            column(BirdSoldINNoQty_GCStatement; "GC Statement"."Bird Sold IN No. Qty.")
            {
            }
            column(BirdSoldINNoRate_GCStatement; "GC Statement"."Bird Sold IN No. Rate")
            {
            }
            column(BirdSoldINNoAmt_GCStatement; ROUND("GC Statement"."Bird Sold IN No. Amt.", 0.001, '='))
            {
            }
            column(CostofProdAfterRC2_GCStatement; ROUND("GC Statement"."Cost of Prod. After RC2", 0.001, '='))
            {
            }
            column(CostofProductionPerKg2_GCStatement; ROUND("GC Statement"."Cost of Production Per Kg.2", 0.001, '='))
            {
            }
            column(FCR2_GCStatement; ROUND("GC Statement"."F.C.R2", 0.001, '='))
            {
            }
            column(AverageBodyweight2_GCStatement; ROUND("GC Statement"."Average Body weight2", 0.001, '='))
            {
            }
            column(ProdCostAfterRC2_GCStatement; ROUND("GC Statement"."Prod. Cost After RC2", 0.001, '='))
            {
            }
            column(SALEAMOUNT2_GCStatement; "GC Statement"."SALE AMOUNT2")
            {
            }
            column(NETPROFITLOSS_GCStatement; ROUND("GC Statement"."NET PROFIT / (LOSS)", 0.001, '='))
            {
            }
            column(NETPROFITLOSSBIRD_GCStatement; ROUND("GC Statement"."NET PROFIT/ (LOSS)/BIRD", 0.001, '='))
            {
            }
            column(CostofProductionPerBird_GCStatement; ROUND("GC Statement"."Cost of Production Per Bird", 0.001, '='))
            {
            }
            column(StdProdCost_GCStatement; "GC Statement"."Std. Prod Cost")
            {
            }
            column(StdSaleRate_GCStatement; "GC Statement"."Std. Sale Rate")
            {
            }
            column(Receipt_GCStatement; "GC Statement".Receipt)
            {
            }
            column(NoSeries_GCStatement; "GC Statement"."No. Series")
            {
            }
            column(FarmerNo_GCStatement; "GC Statement"."Farmer No.")
            {
            }
            column(ShedType_GCStatement; "GC Statement"."Shed Type")
            {
            }
            column(HatcheryName; PO."Hatchery Name")
            {
            }
            column(BranchName; DV.Name)
            {
            }
            column(EEFIncentivesrangefrom_GCStatement; "GC Statement"."EEF Incentives range from")
            {
            }
            column(ECVisible; ECVisible)
            {
            }
            column(MaxVisible; MaxVisible)
            {
            }
            column(TotalFeedAmount; TotalFeedAmount)
            {
            }
            column(FeedSuppliment; "GC Statement"."Other Supplement")
            {
            }
            column(OtherSupRate; OtherSupRate)
            {
            }
            column(OtherSupplimentQty; OtherSupplimentQty)
            {
            }

            trigger OnAfterGetRecord()
            var
                GLEntry: Record 17;
                GLAccount: Record 15;
            begin
                GCStatement.RESET;
                GCStatement.SETRANGE("Farm Code", "Farm Code");
                GCStatement.SETRANGE(Posted, TRUE);
                Batchcode := GCStatement.COUNT;

                CLEAR(EEFText);
                EEFRange.RESET;
                EEFRange.SETFILTER("Starting Date", '..%1', "GC Statement"."Receipt Date");
                CLEAR(BlankDate);
                EEFRange.SETFILTER("Ending Date", '%1|>=%2', BlankDate, "GC Statement"."Receipt Date");
                EEFRange.SETFILTER("EEF Range To", '>=%1', "GC Statement".EEF);
                EEFRange.SETFILTER("EEF Range From", '<=%1', "GC Statement".EEF);
                IF EEFRange.FINDFIRST THEN
                    EEFText := 'EEF incentive range from ' + FORMAT(EEFRange."EEF Range From") + ' to ' + FORMAT(EEFRange."EEF Range To") + ' ' + '@ ' + FORMAT(EEFRange."RS/KG") + ' Rs. per KG.';


                Text00123 := 'Actual Amount';
                Text01234 := 'Total of all Rate Incentive';
                Text124 := 'ADD :INCENTIVE';
                Text0000156 := 'Feed Unloading Charges @ Rs 20 per Ton';
                IF "Shed Type" <> "Shed Type"::Normal THEN
                    ECVisible := TRUE
                ELSE
                    ECVisible := FALSE;
                CLEAR(MaxVisible);
                IF "GC Statement"."Max Rate Incentive Upto 2.5" > "GC Statement"."Total of All Rate Incentive" THEN
                    MaxVisible := 0
                ELSE
                    MaxVisible := "GC Statement"."Max Rate Incentive Upto 2.5";

                PO.RESET;
                PO.SETFILTER(Status, '%1|%2', PO.Status::Released, PO.Status::Finished);
                PO.SETRANGE("No.", "Flock No.");
                IF PO.FINDFIRST THEN;

                CLEAR(ParaDesc);

                Location.GET("GC Statement"."Farm Code");

                T50022.RESET;
                T50022.SETRANGE(State, Location."State Code");
                T50022.SETRANGE(Type1, "Shed Type");
                T50022.SETRANGE(Type2, T50022.Type2::Incentive);
                T50022.SETFILTER("End Date", '%1|>=%2', 0D, PO."Starting Date");
                T50022.SETRANGE("Start Date", 0D, PO."Starting Date");
                T50022.SETRANGE("Parameter Code", 'GCIPARA001');
                IF T50022.FINDFIRST THEN BEGIN
                    ParaDesc := STRSUBSTNO(FORMAT(T50022."Parameter Description"), T50022.Value1);
                    LineText1 := ParaDesc;
                END;

                CLEAR(ParaDesc);
                T50022.SETRANGE("Parameter Code", 'GCIPARA002');
                IF T50022.FINDFIRST THEN BEGIN
                    ParaDesc := STRSUBSTNO(FORMAT(T50022."Parameter Description"), T50022.Value1, T50022.Value2, T50022.Value3, T50022.Value4, T50022.Value5);
                    LineText2 := ParaDesc;
                END;

                CLEAR(ParaDesc);
                T50022.SETRANGE("Parameter Code", 'GCIPARA003');
                IF T50022.FINDFIRST THEN BEGIN
                    ParaDesc := STRSUBSTNO(FORMAT(T50022."Parameter Description"), T50022.Value1, T50022.Value2, T50022.Value3, T50022.Value4, T50022.Value5);
                    LineText3 := ParaDesc;
                END;

                CLEAR(ParaDesc);
                T50022.SETRANGE("Parameter Code", 'GCIPARA004');
                IF T50022.FINDFIRST THEN BEGIN
                    ParaDesc := STRSUBSTNO(FORMAT(T50022."Parameter Description"), T50022.Value1, T50022.Value2, T50022.Value3, T50022.Value4, T50022.Value5);
                    LineText4 := ParaDesc;
                END;


                CLEAR(ParaDesc);
                T50022.SETRANGE("Parameter Code", 'GCIPARA007');
                IF T50022.FINDFIRST THEN BEGIN
                    ParaDesc := STRSUBSTNO(FORMAT(T50022."Parameter Description"), T50022.Value1, T50022.Value2, T50022.Value3, T50022.Value4, T50022.Value5);
                    LineText5 := ParaDesc;
                END;

                CLEAR(ParaDesc);
                T50022.SETRANGE("Parameter Code", 'GCIPARA008');
                IF T50022.FINDFIRST THEN BEGIN
                    ParaDesc := STRSUBSTNO(FORMAT(T50022."Parameter Description"), T50022.Value1, T50022.Value2, T50022.Value3, T50022.Value4, T50022.Value5);
                    LineText6 := ParaDesc;
                END;

                CLEAR(ParaDesc);
                T50022.SETRANGE("Parameter Code", 'GCIPARA009');
                IF T50022.FINDFIRST THEN BEGIN
                    ParaDesc := STRSUBSTNO(FORMAT(T50022."Parameter Description"), T50022.Value1, T50022.Value2);
                    LineText13 := ParaDesc;
                END;

                CLEAR(ParaDesc);
                T50022.SETRANGE("Parameter Code", 'GCIPARA005');
                IF T50022.FINDFIRST THEN BEGIN
                    ParaDesc := STRSUBSTNO(FORMAT(T50022."Parameter Description"), T50022.Value1, T50022.Value2, T50022.Value3, T50022.Value4, T50022.Value5);
                    LineText10 := ParaDesc;
                END;

                CLEAR(ParaDesc);
                T50022.SETRANGE("Parameter Code", 'GCIPARA006');
                IF T50022.FINDFIRST THEN BEGIN
                    ParaDesc := STRSUBSTNO(FORMAT(T50022."Parameter Description"), T50022.Value1, T50022.Value2, T50022.Value3, T50022.Value4, T50022.Value5);
                    LineText11 := ParaDesc;
                END;



                CLEAR(ParaDesc);
                T50022.SETRANGE("Parameter Code", 'GCDPARA001');
                T50022.SETRANGE(Type2, T50022.Type2::Deduction);
                IF T50022.FINDFIRST THEN BEGIN
                    ParaDesc := STRSUBSTNO(FORMAT(T50022."Parameter Description"), T50022.Value1, T50022.Value2, T50022.Value3, T50022.Value4, T50022.Value5);
                    LineText7 := ParaDesc;
                END;

                CLEAR(ParaDesc);
                T50022.SETRANGE("Parameter Code", 'GCDPARA002');
                T50022.SETRANGE(Type2, T50022.Type2::Deduction);
                IF T50022.FINDFIRST THEN BEGIN
                    ParaDesc := STRSUBSTNO(FORMAT(T50022."Parameter Description"), T50022.Value1, T50022.Value2, T50022.Value3, T50022.Value4, T50022.Value5);
                    LineText8 := ParaDesc;
                END;

                CLEAR(ParaDesc);
                T50022.SETRANGE("Parameter Code", 'GCDPARA003');
                T50022.SETRANGE(Type2, T50022.Type2::Deduction);
                IF T50022.FINDFIRST THEN BEGIN
                    ParaDesc := STRSUBSTNO(FORMAT(T50022."Parameter Description"), T50022.Value1, T50022.Value2, T50022.Value3, T50022.Value4, T50022.Value5);
                    LineText9 := ParaDesc;
                END;


                //<<PRU_HM

                ///Pru_gk
                CLEAR(GCValue);
                CLEAR(BirdRate);
                IF "GC Statement"."Shed Type" = "GC Statement"."Shed Type"::"Super Deluxe" THEN BEGIN
                    T50022.RESET;
                    T50022.SETRANGE("Parameter Code", 'GCNPARA001');
                    T50022.SETRANGE(Type1, T50022.Type1::Deluxe);
                    T50022.SETRANGE(State, State);
                    T50022.SETFILTER("End Date", '%1|>=%2', 0D, PO."Due Date"); // PRU_AS : 01 JULY 2019
                    T50022.SETRANGE("Start Date", 0D, PO."Due Date"); // PRU_AS : 01 JULY 2019
                    IF T50022.FINDFIRST THEN BEGIN
                        GCValue := STRSUBSTNO(FORMAT(T50022."Parameter Description"), T50022.Value1);
                        //MESSAGE('%1',GCValue);
                    END;
                END;
                IF "GC Statement"."Shed Type" = "GC Statement"."Shed Type"::EC THEN BEGIN
                    T50022.RESET;
                    T50022.SETRANGE("Parameter Code", 'GCNPARA001');
                    T50022.SETRANGE(Type1, T50022.Type1::EC);
                    T50022.SETRANGE(State, State);
                    T50022.SETFILTER("End Date", '%1|>=%2', 0D, PO."Due Date"); // PRU_AS : 01 JULY 2019
                    T50022.SETRANGE("Start Date", 0D, PO."Due Date"); // PRU_AS : 01 JULY 2019
                    IF T50022.FINDFIRST THEN BEGIN
                        GCValue := STRSUBSTNO(FORMAT(T50022."Parameter Description"), T50022.Value1);
                    END;
                END;
                IF "GC Statement"."Shed Type" = "GC Statement"."Shed Type"::Normal THEN BEGIN
                    T50022.RESET;
                    T50022.SETRANGE("Parameter Code", 'GCNPARA001');
                    T50022.SETRANGE(Type1, T50022.Type1::Normal);
                    T50022.SETRANGE(State, State);
                    T50022.SETFILTER("End Date", '%1|>=%2', 0D, PO."Due Date"); // PRU_AS : 01 JULY 2019
                    T50022.SETRANGE("Start Date", 0D, PO."Due Date"); // PRU_AS : 01 JULY 2019
                    IF T50022.FINDFIRST THEN BEGIN
                        GCValue := STRSUBSTNO(FORMAT(T50022."Parameter Description"), T50022.Value1);
                    END;
                END;
                //Peu_gk

                GLEntry.RESET;
                GLEntry.SETRANGE("Flock Code", "GC Statement"."Flock No.");
                IF GLEntry.FINDFIRST THEN
                    REPEAT
                        IF GLAccount.GET(GLEntry."G/L Account No.") THEN BEGIN
                            IF GLAccount."FEED Freight Charge" = TRUE THEN
                                TotalFeedAmount += GLEntry.Amount;
                        END;
                    UNTIL GLEntry.NEXT = 0;


                /*
                IF "GC Statement"."Shed Type" = "GC Statement"."Shed Type"::Normal THEN
                    BirdRate := 'Birds Rearing (Growing) Charges for live Grown-up  Comm. Br. Bird @ Rs. 6 per Kg.'
                 ELSE
                    BirdRate := 'Birds Rearing (Growing) Charges for live Grown-up  Comm. Br. Bird @ Rs. 7 per Kg.' ;
                */
                DV.RESET;
                DV.SETRANGE(DV."Dimension Code", 'BRANCH');
                DV.SETRANGE(Code, PO."Shortcut Dimension 2 Code");
                IF DV.FINDFIRST THEN;

                //Pru 091220 P0272>>
                Location.GET("Farm Code");
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
                T32.SETRANGE("Item Type", T32."Item Type"::"Other Supplement");
                T32.SETRANGE("Location Code", "Farm Code");
                T32.SETFILTER("In-transit Mortality", '%1', FALSE);
                T32.CALCSUMS(Quantity);
                OtherSupplimentQty := ABS(T32.Quantity);
                //>>
                //========================================================//
                //GK12
                /*   //PRU SH 01082022
                CLEAR(AssesCode);
                NODNOCHeader.RESET;
                NODNOCHeader.SETRANGE(Type, NODNOCHeader.Type::Vendor);
                NODNOCHeader.SETRANGE("No.", "Farmer No.");
                IF NODNOCHeader.FINDFIRST THEN
                    AssesCode := NODNOCHeader."Assesse Code";
                //======================================================
                CLEAR(TDSP);
                NODNOCLines.RESET;
                NODNOCLines.SETRANGE(Type, NODNOCLines.Type::Vendor);
                NODNOCLines.SETRANGE("No.", "Farmer No.");
                IF NODNOCLines.FINDFIRST THEN
                    TDSP := NODNOCLines."TDS Group";
                //MESSAGE('%1',TDSP);
                //======================================================
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
*/  //PRU SH 01082022
            end;

            trigger OnPreDataItem()
            begin
                CLEAR(LineText1);
                CLEAR(LineText2);
                CLEAR(LineText3);
                CLEAR(LineText4);
                CLEAR(LineText5);
                CLEAR(LineText6);
                CLEAR(LineText7);
                CLEAR(LineText8);
                CLEAR(LineText9);
                CLEAR(TotalFeedAmount);
                CLEAR(Batchcode);
                CompanyInfo.Get;
                CompanyName := CompanyInfo.Name;
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        CompanyName: Text;
        CompanyInfo: Record "Company Information";
        SALE_AMOUNT: Decimal;
        Location: Record 14;
        FarmerName: Text;
        RecState: Code[20];
        Bankname: Text;
        Bankbranch: Code[20];
        BankAccount: Code[20];
        IfscCode: Code[20];
        PanNo_Var: Code[20];
        BirdRate: Text;
        Text0001: Label 'Incentive for low Cost of production  @ Rs 0.50 for every one Rupee per kg (Live birds)';
        Text0002: Label 'Rate Incentive for Selling price above  Rs. 72.01 to Rs. 77.00 @ Rs. 0.05 for every one Rupee per Kg. Live Bird';
        Text0003: Label 'Rate Incentive for Selling price above  Rs. 77.01  Rs.82.00 to above @ Rs. 0.10 for every one Rupee per Kg. Live Bird';
        Text0004: Label 'Rate Incentive for Selling price above  Rs. 82.01  above @ Rs. 0.15 for every one Rupee per Kg. Live Bird';
        T50022: Record 50022;
        PO: Record 5405;
        LineText1: Text;
        LineText2: Text;
        LineText3: Text;
        LineText4: Text;
        ParaDesc: Text;
        LineText5: Text;
        LineText6: Text;
        LineText7: Text;
        LineText8: Text;
        LineText9: Text;
        LineText10: Text;
        LineText11: Text;
        DV: Record 349;
        Batchcode: Decimal;
        ECVisible: Boolean;
        MaxVisible: Decimal;
        GCValue: Text;
        LineText13: Text;
        EEFRange: Record 50027;
        EEFText: Text;
        BlankDate: Date;
        Text00123: Text;
        Text01234: Text;
        Text124: Text;
        Text0000156: Text;
        TotalFeedAmount: Decimal;
        GCStatement: Record 50015;
        OtherSupRate: Decimal;
        OtherSupplimentQty: Decimal;
        T50020: Record 50020;
        T32: Record 32;
        TDSSetup: Record "TDS Setup";//13728;
        TDSP: Option " ",Contractor,Commission,Professional,Interest,Rent,Dividend,"Interest on Securities",Lotteries,"Insurance Commission",NSS,"Mutual fund",Brokerage,"Income from Units","Capital Assets","Horse Races","Sports Association","Payable to Non Residents","Income of Mutual Funds",Units,"Foreign Currency Bonds","FII from Securities",Others,"Rent for Plant & Machinery","Rent for Land & Building","Banking Services";
        // NODNOCLines: Record 13785;
        TDS: Decimal;
        // NODNOCHeader: Record 13786;
        AssesCode: Code[10];
}

