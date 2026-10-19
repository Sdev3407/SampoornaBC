report 50071 "Liqudation Report"
{
    UsageCategory = Administration;
    Caption = 'Liqudation Report';
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'ReportLayout\LiqudationReport.rdl';
    dataset
    {
        dataitem("GC Statement"; "GC Statement")
        {
            DataItemTableView = SORTING("Shed Type", "No.")
                                ORDER(Ascending)
                                WHERE(Posted = CONST(true));
            RequestFilterFields = "Liquidation Date";
            column(HatchName; ProductionOrder."Hatchery Name")
            {
            }
            column(SupervName; SupervName)
            {
            }
            column(LineName; LineName)
            {
            }
            column(AgeOfLiq; AgeOfLiq)
            {
            }
            column(RportFill; RportFill)
            {
            }
            column(BranchName; DimensionValue.Name)
            {
            }
            column(comp_name; CompanyInformation.Name)
            {
            }
            column(comp_add; CompanyInformation.Address + ' ' + CompanyInformation."Address 2")
            {
            }
            column(Comp_Pic; CompanyInformation.Picture)
            {
            }
            column(Mortality_GCStatement; "GC Statement".Mortality)
            {
            }
            column(MortalityPer_GCStatement; "GC Statement"."Mortality %")
            {
            }
            column(ShortcutDimension2Code_GCStatement; "GC Statement"."Shortcut Dimension 2 Code")
            {
            }
            column(Serielno; Srno)
            {
            }
            column(FarmerNo_GCStatement; "GC Statement"."Farmer No.")
            {
            }
            column(No_GCStatement; "GC Statement"."No.")
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
            column(AccountNo_GCStatement; "GC Statement"."Account No")
            {
            }
            column(FlockNo_GCStatement; "GC Statement"."Flock No.")
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
            column(HatcheryVendor_GCStatement; "GC Statement"."Hatchery/Vendor")
            {
            }
            column(EEF_GCStatement; "GC Statement".EEF)
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
            column(BodyWeight_GCStatement; "GC Statement"."Body Weight %")
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
            column(Salerate_GCStatement; "GC Statement"."Sale rate")
            {
            }
            column(SaleAmount_GCStatement; "GC Statement"."Sale Amount")
            {
            }
            column(FCR_GCStatement; "GC Statement".FCR)
            {
            }
            column(CFCR_GCStatement; "GC Statement".CFCR)
            {
            }
            column(ProductionCost_GCStatement; "GC Statement"."Production Cost")
            {
            }
            column(BirdsRearingGC_GCStatement; "GC Statement"."Birds Rearing GC")
            {
            }
            column(IncentiveforLowCost_GCStatement; "GC Statement"."Incentive for Low Cost")
            {
            }
            column(RateIncentiveforSelling1_GCStatement; "GC Statement"."Rate Incentive for Selling1")
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
            column(DeductionforhighMort_GCStatement; "GC Statement"."Deduction for high Mort")
            {
            }
            column(ExcessFCROver_GCStatement; "GC Statement"."Excess FCR Over")
            {
            }
            column(DeductionforShortage_GCStatement; "GC Statement"."Deduction for Shortage")
            {
            }
            column(TOTALDEDUCTIONLESS_GCStatement; "GC Statement"."TOTAL DEDUCTION(LESS)")
            {
            }
            column(TOTALAMOUNTPAYABLE_GCStatement; "GC Statement"."TOTAL AMOUNT PAYABLE")
            {
            }
            column(LESSTDS1_GCStatement; "GC Statement"."LESS: T.D.S @ 1%")
            {
            }
            column(AMOUNTPAYABLEAFTERTDS_GCStatement; "GC Statement"."AMOUNT PAYABLE AFTER T.D.S")
            {
            }
            column(SELFDCNO_GCStatement; "GC Statement"."SELF  DC NO :")
            {
            }
            column(AMOUNTpayableperbird_GCStatement; "GC Statement"."AMOUNT payable per bird")
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
            column(CostofProdkgBeforeRC2_GCStatement; "GC Statement"."Cost of Prod./kg Before RC2")
            {
            }
            column(BirdSoldINKg2Qty_GCStatement; "GC Statement"."Bird Sold IN Kg.2  Qty.")
            {
            }
            column(BirdSoldINKg2Rate_GCStatement; "GC Statement"."Bird Sold IN Kg.2  Rate")
            {
            }
            column(BirdSoldINKg2Amt_GCStatement; "GC Statement"."Bird Sold IN Kg.2  Amt.")
            {
            }
            column(BirdSoldINNoQty_GCStatement; "GC Statement"."Bird Sold IN No. Qty.")
            {
            }
            column(BirdSoldINNoRate_GCStatement; "GC Statement"."Bird Sold IN No. Rate")
            {
            }
            column(BirdSoldINNoAmt_GCStatement; "GC Statement"."Bird Sold IN No. Amt.")
            {
            }
            column(CostofProdAfterRC2_GCStatement; "GC Statement"."Cost of Prod. After RC2")
            {
            }
            column(CostofProductionPerKg2_GCStatement; "GC Statement"."Cost of Production Per Kg.2")
            {
            }
            column(FCR2_GCStatement; "GC Statement"."F.C.R2")
            {
            }
            column(AverageBodyweight2_GCStatement; "GC Statement"."Average Body weight2")
            {
            }
            column(ProdCostAfterRC2_GCStatement; "GC Statement"."Prod. Cost After RC2")
            {
            }
            column(SALEAMOUNT2_GCStatement; "GC Statement"."SALE AMOUNT2")
            {
            }
            column(NETPROFITLOSS_GCStatement; "GC Statement"."NET PROFIT / (LOSS)")
            {
            }
            column(NETPROFITLOSSBIRD_GCStatement; "GC Statement"."NET PROFIT/ (LOSS)/BIRD")
            {
            }
            column(CostofProductionPerBird_GCStatement; "GC Statement"."Cost of Production Per Bird")
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
            column(ShedType_GCStatement; "GC Statement"."Shed Type")
            {
            }
            column(ShortcutDimension1Code_GCStatement; "GC Statement"."Shortcut Dimension 1 Code")
            {
            }
            column(ShortcutDimension3Code_GCStatement; "GC Statement"."Shortcut Dimension 3 Code")
            {
            }
            column(ResponsibilityCenter_GCStatement; "GC Statement"."Responsibility Center")
            {
            }
            column(NetPayableAfterTDS_GCStatement; "GC Statement"."Net Payable After TDS")
            {
            }
            column(StdGCRate_GCStatement; "GC Statement"."Std. GC Rate")
            {
            }
            column(Posted_GCStatement; "GC Statement".Posted)
            {
            }
            column(TotalofAllRateIncentive_GCStatement; "GC Statement"."Total of All Rate Incentive")
            {
            }
            column(ActualAmount_GCStatement; "GC Statement"."Actual Amount")
            {
            }
            column(RateIncentiveActualAmount_GCStatement; "GC Statement"."Rate Incentive- Actual Amount")
            {
            }
            column(DimensionSetID_GCStatement; "GC Statement"."Dimension Set ID")
            {
            }
            column(EEFIncentivesrangefrom_GCStatement; "GC Statement"."EEF Incentives range from")
            {
            }
            column(MaxRateIncentiveUpto25_GCStatement; "GC Statement"."Max Rate Incentive Upto 2.5")
            {
            }
            column(V1stweekmortality_GCStatement1; "GC Statement"."1st week mortality %")
            {
            }
            column(BroodingIncentive_GCStatement; "GC Statement"."Brooding Incentive")
            {
            }
            column(BirdRearingChargeforCBNew_GCStatement; "GC Statement"."Bird Rearing Charge for CB-New")
            {
            }
            column(StdAdminCost_GCStatement; "GC Statement"."Std. Admin Cost")
            {
            }
            column(LastUSERID_GCStatement; "GC Statement"."Last USERID")
            {
            }
            column(ModifiedDate_GCStatement; "GC Statement"."Modified Date")
            {
            }
            column(FEEDFreightCharges_GCStatement; "GC Statement"."FEED Freight Charges")
            {
            }
            column(DeductionforhighProdCost_GCStatement; "GC Statement"."Deduction for high Prod. Cost")
            {
            }
            column(MinGrowingCharge_GCStatement; "GC Statement"."Min. Growing Charge")
            {
            }
            column(OtherSupplement_GCStatement; "GC Statement"."Other Supplement")
            {
            }
            column(FeedIntake_GCStatement; "GC Statement"."Feed Intake")
            {
            }
            column(CumFeedConsuption_GCStatement; "GC Statement"."Cum. Feed Consuption")
            {
            }
            column(CumFeedStd_GCStatement; "GC Statement"."Cum. Feed Std.")
            {
            }
            column(V1stweekmortality_GCStatement; "GC Statement"."1st week mortality")
            {
            }

            trigger OnAfterGetRecord()
            begin
                SupervName := '';
                LineName := '';
                DimensionValue.RESET;
                DimensionValue.SETRANGE(DimensionValue."Global Dimension No.", 2);
                DimensionValue.SETRANGE(DimensionValue.Code, "GC Statement"."Shortcut Dimension 2 Code");
                IF DimensionValue.FINDFIRST THEN;
                ProductionOrder.RESET;
                ProductionOrder.SETRANGE(ProductionOrder."No.", "GC Statement"."Flock No.");
                IF ProductionOrder.FINDFIRST THEN;
                Location.RESET;
                IF Location.GET("GC Statement"."Farm Code") THEN;
                // DimensionValue1.RESET;
                // DimensionValue1.SETRANGE(DimensionValue1."Global Dimension No.",4);
                // DimensionValue1.SETRANGE(DimensionValue1.Code,ProductionOrder."Supervisor Name");
                // IF DimensionValue1.FINDFIRST THEN
                //    SupervName := DimensionValue1.Name;

                LineNameCBF.RESET;
                LineNameCBF.SETRANGE("Line Code", Location."Line No.");
                IF LineNameCBF.FINDFIRST THEN
                    LineName := LineNameCBF."Line Discription";

                // ProductionOrder.RESET;
                // IF ProductionOrder.GET("GC Statement"."Flock No.") THEN;
                Employee.RESET;
                Employee.SETRANGE("No.", ProductionOrder."Supervisor Name");
                IF Employee.FINDFIRST THEN
                    SupervName := Employee.FullName;
            end;

            trigger OnPreDataItem()
            var

            begin
                RportFill := "GC Statement".GETFILTERS;
                AgeOfLiq := "GC Statement"."Liquidation Date" - "GC Statement"."Receipt Date";
                RecUserSetup.Reset();
                RecUserSetup.SetRange("User ID", UserId);
                RecUserSetup.SetRange("Regional Head", false);
                if RecUserSetup.FindFirst() Then begin
                    IF BranchCode <> '' THEN
                        "GC Statement".SETRANGE("Shortcut Dimension 2 Code", BranchCode)
                end else
                    "GC Statement".SETRANGE(Region, GCREGION);


            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("Branch Code"; BranchCode)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Region; GCREGION)
                {
                    Caption = 'Region Code';
                    Editable = False;
                }
            }
        }

        actions
        {
        }

        trigger OnInit()
        var
            UserSetup: Record 91;
            Editab: Boolean;
            recLoc: record Location;
        begin
            UserSetup.RESET;
            UserSetup.SetRange("User ID", UserId);
            IF UserSetup.FindFirst() THEN
                BranchCode := UserSetup."Global Dimension 2 Code";
            If UserSetup."Regional Head" Then begin
                recLoc.Reset();
                recLoc.SetRange("Global Dimension 2 Code", UserSetup."Global Dimension 2 Code");
                If recLoc.FindFirst() Then
                    GCREGION := recLoc."Region Code";
            end;

        end;



    }

    labels
    {
    }

    trigger OnInitReport()
    var

    begin
        CompanyInformation.GET;
        CompanyInformation.CALCFIELDS(Picture);
        //MESSAGE('1');
    end;

    var
        Srno: Integer;
        CompanyInformation: Record 79;
        DimensionValue: Record 349;
        RportFill: Code[100];
        AgeOfLiq: Integer;
        ProductionOrder: Record 5405;
        BranchCode: Code[20];
        Edita: Boolean;
        LineName: Text;
        DimensionValue1: Record 349;
        SupervName: Text;
        Location: Record 14;
        Employee: Record 5200;
        Test: Boolean;
        UserSetup: Record 91;
        LineNameCBF: Record 50033;
        GCREGION: Text[10];
        RecUserSetup: record "User Setup";
        recLoc: Record Location;
}

