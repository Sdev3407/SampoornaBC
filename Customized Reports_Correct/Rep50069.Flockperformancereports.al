report 50069 "Flock performance reports"
{
    UsageCategory = Administration;
    Caption = 'Flock Performance Report';
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'ReportLayout\Flockperformancereports.rdl';
    dataset
    {
        dataitem("Production Order"; "Production Order")
        {
            DataItemTableView = SORTING(Status, "No.", "Location Code")
                                ORDER(Ascending)
                                WHERE(Status = FILTER(Released | Finished),
                                      "DOC Placing Date" = FILTER(<> ''),
                                      "Location Code" = FILTER(<> ''));
            RequestFilterFields = Status, "Shortcut Dimension 2 Code", "Date Filter";
            column(Batchno; Batchno)
            {
            }
            column(compname; companyinfo.Name)
            {
            }
            column(compcity; BranchName)
            {
            }
            column(SRno; SRno)
            {
            }
            column(DateMin; DateMin)
            {
            }
            column(DateMax; DateMax)
            {
            }
            column(No_ProductionOrder; "Production Order"."No.")
            {
            }
            column(LocationCode_ProductionOrder; "Production Order"."Location Code")
            {
            }
            column(locationname; locationname)
            {
            }
            column(Supervisor; Supervisor)
            {
            }
            column(HatcheryName_ProductionOrder; "Production Order"."Hatchery Name")
            {
            }
            column(DueDate_ProductionOrder; "Production Order"."Due Date")
            {
            }
            column(Farm_sqft; Farm_sqft)
            {
            }
            column(Quantity_ProductionOrder; "Production Order".Quantity)
            {
            }
            column(TransitMortality; TransitMortality)
            {
            }
            column(DayMortality; DayMortality)
            {
            }
            column(PreMortality; PreMortality)
            {
            }
            column(DayBeforeMortality; DayBeforeMortality)
            {
            }
            column(Flock_Age; Flock_Age)
            {
            }
            column(cum_Mor; cum_Mor)
            {
            }
            column(mortality; mortality)
            {
            }
            column(Bird_sold; Bird_sold)
            {
            }
            column(Body_Wt_Act; Body_Wt_Act)
            {
            }
            column(Body_Wt_Std; Body_Wt_Std)
            {
            }
            column(Cum_Feeds_Act; Cum_Feeds_Act)
            {
            }
            column(Cum_Feeds_Std; Cum_Feeds_Std)
            {
            }
            column(Cum_Fcr_Act; Cum_Fcr_Act)
            {
            }
            column(Cum_Fcr_Std; Cum_Fcr_Std)
            {
            }
            column(Running_Cop; Running_Cop)
            {
            }
            column(Day_Cons; Day_Cons)
            {
            }
            column(Day_Feed_Std; Day_Feed_Std)
            {
            }
            column(Prev_Day_Cons; Prev_Day_Cons)
            {
            }
            column(Day_Before_Cons; Day_Before_Cons)
            {
            }
            column(Per_Birds_Feed_Cons_Act; Per_Birds_Feed_Cons_Act)
            {
            }
            column(Per_Birds_Feed_Cons_Std; Per_Birds_Feed_Cons_Std)
            {
            }
            column(Feed_Stock; Feed_Stock)
            {
            }
            column(In_Transit_Feed_Stock; In_Transit_Feed_Stock)
            {
            }
            column(No_of_Birds_Supplied; No_of_Birds_Supplied)
            {
            }
            column(Short_Birds; Short_Birds)
            {
            }
            column(TotalRunning; TotalRunning)
            {
            }
            column(Week_Birds; Week_Birds)
            {
            }
            column(Name_of_sup; Name_of_sup)
            {
            }
            column(Line_Name; Line_Name)
            {
            }
            column(Cause_Of_Mortality; Cause_Of_Mortality)
            {
            }
            column(Feed_cons_per_Bird; Feed_cons_per_Bird)
            {
            }
            column(PerDayCun; PerDayCun)
            {
            }
            column(NoofBirds; NoofBirds)
            {
            }
            column(PerConFed; PerConFed)
            {
            }
            column(ConfeedStd; ConfeedStd)
            {
            }
            column(Day_Feed_Stdform; Day_Feed_Stdform)
            {
            }
            column(TrasMot; TrasMot)
            {
            }
            column(WeekB; WeekB)
            {
            }
            column(ShortB; ShortB)
            {
            }
            column(RunningQty_N; RunningQty_N)
            {
            }
            column(FeedConPer; FeedConPer)
            {
            }
            column(LineName; LineName)
            {
            }

            trigger OnAfterGetRecord()
            var
                Datafilter: Text;

            begin
                /*
                GCstatement.RESET;
                GCstatement.SETRANGE("Flock No.","Production Order"."No.");
                GCstatement.SETRANGE(Posted,TRUE);
                IF GCstatement.FINDFIRST THEN
                
                  CurrReport.SKIP;
                  */
                CompanyInfo.Get;
                Datafilter := "Production Order".GETFILTER("Date Filter");
                EVALUATE(datefN, Datafilter);
                IF "Production Order".Status = "Production Order".Status::Finished THEN BEGIN
                    GCstatement.RESET;
                    GCstatement.SETRANGE("Flock No.", "Production Order"."No.");
                    //GCstatement.SETRANGE(Posted,TRUE);
                    IF GCstatement.FINDFIRST THEN
                        IF GCstatement."Liquidation Date" < datefN THEN
                            CurrReport.SKIP;
                END;

                IF "Production Order".Status = "Production Order".Status::Released THEN BEGIN
                    GCstatement.RESET;
                    GCstatement.SETRANGE("Flock No.", "Production Order"."No.");
                    GCstatement.SETRANGE(Posted, TRUE);
                    IF GCstatement.FINDFIRST THEN
                        IF GCstatement."Liquidation Date" < datefN THEN
                            CurrReport.SKIP;
                    IF "Production Order"."Due Date" > datefN THEN
                        CurrReport.SKIP;
                END;
                BranchFiter := "Production Order".GETFILTER("Production Order"."Shortcut Dimension 2 Code");
                //IF BranchFiter = '' THEN
                //ERROR('Please Select branch Code');
                IF "Production Order"."Location Code" <> locCode THEN
                    Batchno := 0;

                SRno := SRno + 1;
                Batchno += 1;

                EVALUATE(DateMax, Datafilter);
                IF DateMax = 0D THEN
                    DateMax := WORKDATE;

                Flock_Age := (DateMax - "Production Order"."DOC Placing Date");

                LineName := '';
                locationname := '';
                Farm_sqft := 0;
                location.RESET;
                location.SETRANGE(Code, "Production Order"."Location Code");
                IF location.FINDFIRST THEN BEGIN
                    locationname := location.Name;
                    Farm_sqft := location."Total Sq.Ft Area";
                    LineNameCBF.RESET;
                    LineNameCBF.SETRANGE("Line Code", location."Line No.");
                    IF LineNameCBF.FINDFIRST THEN
                        LineName := LineNameCBF."Line Discription";

                END;

                Supervisor := '';
                Employee.RESET;
                Employee.SETRANGE("No.", "Production Order"."Supervisor Name");
                IF Employee.FINDFIRST THEN
                    Supervisor := Employee.FullName;


                TransitMortality := 0;
                ILE1.RESET;
                ILE1.SETCURRENTKEY("Entry Type", "Posting Date");
                ILE1.SETRANGE("Flock No.", "Production Order"."No.");
                ILE1.SETRANGE("Entry Type", ILE1."Entry Type"::Consumption);
                ILE1.SETRANGE("In-transit Mortality", TRUE);
                //ILE1.SETRANGE("Global Dimension 2 Code",BranchFiter);
                ILE1.SETRANGE("Posting Date", DateMax);

                ILE1.CALCSUMS(Quantity);
                TransitMortality += ILE1.Quantity;


                DayMortality := 0;
                ILE2.RESET;
                ILE2.SETCURRENTKEY("Entry Type", "Posting Date");
                ILE2.SETRANGE("Flock No.", "Production Order"."No.");
                ILE2.SETRANGE("Entry Type", ILE2."Entry Type"::Consumption);
                ILE2.SETRANGE("Data Entry Type", ILE2."Data Entry Type"::"Mortality - Chicks");
                //ILE2.SETRANGE("Global Dimension 2 Code",BranchFiter);
                ILE2.SETRANGE("Posting Date", DateMax);
                ILE2.CALCSUMS(Quantity);
                DayMortality := ILE2.Quantity;
                //MESSAGE('%1',ILE2.Quantity);

                PreMortality := 0;
                ILE2.RESET;
                ILE2.SETCURRENTKEY("Entry Type", "Posting Date");
                ILE2.SETRANGE("Flock No.", "Production Order"."No.");
                ILE2.SETRANGE("Entry Type", ILE2."Entry Type"::Consumption);
                ILE2.SETRANGE("Data Entry Type", ILE2."Data Entry Type"::"Mortality - Chicks");
                ILE2.SETRANGE("Posting Date", DateMax - 1);
                //ILE2.SETRANGE("Global Dimension 2 Code",BranchFiter);
                ILE2.CALCSUMS(Quantity);
                PreMortality := ILE2.Quantity;

                DayBeforeMortality := 0;
                ILE2.RESET;
                ILE2.SETCURRENTKEY("Entry Type", "Posting Date");
                ILE2.SETRANGE("Flock No.", "Production Order"."No.");
                ILE2.SETRANGE("Entry Type", ILE2."Entry Type"::Consumption);
                ILE2.SETRANGE("Data Entry Type", ILE2."Data Entry Type"::"Mortality - Chicks");
                ///ILE2.SETRANGE("Global Dimension 2 Code",BranchFiter);
                ILE2.SETRANGE("Posting Date", DateMax - 2);
                ILE2.CALCSUMS(Quantity);
                DayBeforeMortality := ILE2.Quantity;


                //----------------------------------CUMMU_Mortality--------------------------------------------------

                cum_Mor := 0;
                ILE2.RESET;
                ILE2.SETCURRENTKEY("Entry Type", "Posting Date");
                ILE2.SETRANGE("Flock No.", "Production Order"."No.");
                ILE2.SETRANGE("Entry Type", ILE2."Entry Type"::Consumption);
                ILE2.SETRANGE("Data Entry Type", ILE2."Data Entry Type"::"Mortality - Chicks");
                ILE2.SETRANGE("Posting Date", 0D, DateMax);
                ///ILE2.SETRANGE("Global Dimension 2 Code",BranchFiter);
                ILE2.CALCSUMS(Quantity);
                cum_Mor := ILE2.Quantity;


                //----------------------------------Cause_Of_Mortality--------------------------------------------------

                DataEntryLines_T.RESET;
                DataEntryLines_T.SETRANGE("Flock No.", "Production Order"."No.");
                DataEntryLines_T.SETRANGE(Posted, TRUE);
                DataEntryLines_T.SETRANGE("Posting Date", DateMax);
                DataEntryLines_T.SETFILTER(Diseases, '<>%1', '');
                IF DataEntryLines_T.FINDFIRST THEN BEGIN
                    ReasonCode_T.GET(DataEntryLines_T.Diseases);
                    Cause_Of_Mortality := ReasonCode_T.Description;
                END;



                TrasMot := 0;
                DataEntryLines_rec.RESET;
                DataEntryLines_rec.SETRANGE("Flock No.", "Production Order"."No.");
                DataEntryLines_rec.SETRANGE(Posted, TRUE);
                DataEntryLines_rec.SETRANGE("Posting Date", 0D, DateMax);
                if Companyinfo.SFPLCompany in [Companyinfo.SFPLCompany::Sampoorna] then// Suman 26/10
                    DataEntryLines_rec.SETRANGE("Parameter No.", 'PARA-215');
                if Companyinfo.SFPLCompany in [Companyinfo.SFPLCompany::"Star Foods"] then // Suman 26/10
                    DataEntryLines_rec.SETRANGE("Parameter No.", 'PARA-021');
                IF DataEntryLines_rec.FINDFIRST THEN
                    REPEAT
                        TrasMot += DataEntryLines_rec."Actual Value";
                        ItemN := DataEntryLines_rec."Item No.";
                    UNTIL DataEntryLines_rec.NEXT = 0;

                WeekB := 0;
                DataEntryLines_rec.RESET;
                DataEntryLines_rec.SETRANGE("Flock No.", "Production Order"."No.");
                DataEntryLines_rec.SETRANGE(Posted, TRUE);
                DataEntryLines_rec.SETRANGE("Posting Date", 0D, DateMax);
                if Companyinfo.SFPLCompany in [Companyinfo.SFPLCompany::Sampoorna] then// Suman 26/10
                    DataEntryLines_rec.SETRANGE("Parameter No.", 'PARA-216');
                if Companyinfo.SFPLCompany in [Companyinfo.SFPLCompany::"Star Foods"] then// Suman 26/10
                    DataEntryLines_rec.SETRANGE("Parameter No.", 'PARA-022');
                IF DataEntryLines_rec.FINDFIRST THEN
                    REPEAT
                        WeekB += DataEntryLines_rec."Actual Value";
                        ItemN := DataEntryLines_rec."Item No.";
                    UNTIL DataEntryLines_rec.NEXT = 0;

                ShortB := 0;
                DataEntryLines_rec.RESET;
                DataEntryLines_rec.SETRANGE("Flock No.", "Production Order"."No.");
                DataEntryLines_rec.SETRANGE(Posted, TRUE);
                DataEntryLines_rec.SETRANGE("Posting Date", 0D, DateMax);
                if Companyinfo.SFPLCompany in [Companyinfo.SFPLCompany::Sampoorna] then// Suman 26/10
                    DataEntryLines_rec.SETRANGE("Parameter No.", 'PARA-217');
                if Companyinfo.SFPLCompany in [Companyinfo.SFPLCompany::"Star Foods"] then// Suman 26/10
                    DataEntryLines_rec.SETRANGE("Parameter No.", 'PARA-023');
                IF DataEntryLines_rec.FINDFIRST THEN
                    REPEAT
                        ShortB += DataEntryLines_rec."Actual Value";
                        ItemN := DataEntryLines_rec."Item No.";
                    UNTIL DataEntryLines_rec.NEXT = 0;

                TotalN := TrasMot + WeekB + ShortB;
                //---------------------------------- Running COP --------------------------------------------------



                RunningValue := 0;
                LocationState.GET("Production Order"."Location Code");
                GCStatement_R.RESET;
                GCStatement_R.SETRANGE("Flock No.", "Production Order"."No.");
                IF GCStatement_R.FINDFIRST THEN;
                ILE2.RESET;
                ILE2.SETCURRENTKEY("Entry Type", "Posting Date");
                ILE2.SETRANGE("Flock No.", "Production Order"."No.");
                ///ILE2.SETRANGE("Global Dimension 2 Code",BranchFiter);
                ILE2.SETRANGE("Entry Type", ILE2."Entry Type"::Consumption);
                ILE2.SETRANGE("Posting Date", 0D, DateMax);
                IF ILE2.FINDFIRST THEN
                    REPEAT

                        GCRateCalculation.RESET;
                        GCRateCalculation.SETRANGE("State Code", LocationState."State Code");
                        GCRateCalculation.SETRANGE("Item No.", ILE2."Item No.");
                        GCRateCalculation.SETRANGE("Shed Type", LocationState."Shed Type");
                        GCRateCalculation.SETFILTER("Ending Date", '%1|>=%2', 0D, "Production Order"."Due Date"); /////Pru_gk
                        GCRateCalculation.SETRANGE("Starting Date", 0D, "Production Order"."Due Date");////Pru_gk
                        IF GCRateCalculation.FINDFIRST THEN BEGIN
                            RunningValue += ILE2.Quantity * GCRateCalculation.Rate;
                        END ELSE BEGIN
                            GCRateCalculation.RESET;
                            GCRateCalculation.SETRANGE("State Code", LocationState."State Code");
                            GCRateCalculation.SETRANGE("Item Type", ILE2."Item Type");
                            GCRateCalculation.SETRANGE("Shed Type", LocationState."Shed Type");
                            GCRateCalculation.SETFILTER("Ending Date", '%1|>=%2', 0D, "Production Order"."Due Date"); /////Pru_gk
                            GCRateCalculation.SETRANGE("Starting Date", 0D, "Production Order"."Due Date");////Pru_gk
                            IF GCRateCalculation.FINDFIRST THEN BEGIN
                                RunningValue += ILE2.Quantity * GCRateCalculation.Rate;

                            END;
                        END;

                    UNTIL ILE2.NEXT = 0;
                RuningNew := 0;
                //-----------------------transit Mot------------------
                GCStandardCost.RESET;
                GCStandardCost.SETRANGE("Shed Type", LocationState."Shed Type");
                GCStandardCost.SETRANGE("State Code", LocationState."State Code");
                GCStandardCost.SETFILTER("Ending Date", '%1|>=%2', 0D, "Production Order"."Due Date"); /////Pru_gk
                GCStandardCost.SETRANGE("Starting Date", 0D, "Production Order"."Due Date");////Pru_gk
                IF GCStandardCost.FINDFIRST THEN
                    StdCost := "Production Order".Quantity * GCStandardCost."Std. Admin Cost";

                GCRateCalculation.RESET;
                GCRateCalculation.SETRANGE("State Code", LocationState."State Code");
                GCRateCalculation.SETRANGE("Item No.", ItemN);
                GCRateCalculation.SETRANGE("Shed Type", LocationState."Shed Type");
                GCRateCalculation.SETFILTER("Ending Date", '%1|>=%2', 0D, "Production Order"."Due Date"); /////Pru_gk
                GCRateCalculation.SETRANGE("Starting Date", 0D, "Production Order"."Due Date");////Pru_gk
                IF GCRateCalculation.FINDFIRST THEN BEGIN
                    RuningNew += TotalN * GCRateCalculation.Rate;
                END ELSE BEGIN
                    IF Item_R.GET(ItemN) THEN;
                    GCRateCalculation.RESET;
                    GCRateCalculation.SETRANGE("State Code", LocationState."State Code");
                    GCRateCalculation.SETRANGE("Item Type", Item_R."Item Type");
                    GCRateCalculation.SETRANGE("Shed Type", LocationState."Shed Type");
                    GCRateCalculation.SETFILTER("Ending Date", '%1|>=%2', 0D, "Production Order"."Due Date"); /////Pru_gk
                    GCRateCalculation.SETRANGE("Starting Date", 0D, "Production Order"."Due Date");////Pru_gk
                    IF GCRateCalculation.FINDFIRST THEN BEGIN
                        RuningNew += TotalN * GCRateCalculation.Rate;

                    END;
                END;
                RunningValue := ABS(RunningValue) + ABS(StdCost) - ABS(RuningNew);

                SalesQty_N := 0;
                ILE2.RESET;
                ILE2.SETCURRENTKEY("Entry Type", "Posting Date");
                ILE2.SETRANGE("Flock No.", "Production Order"."No.");
                ILE2.SETRANGE("Entry Type", ILE2."Entry Type"::Sale);
                ILE2.SETRANGE("Posting Date", 0D, DateMax);
                //ILE2.SETRANGE("Global Dimension 2 Code",BranchFiter);
                ILE2.CALCSUMS(Quantity);
                SalesQty_N := ILE2.Quantity;
                IF SalesQty_N <> 0 THEN
                    RunningQty_N := ABS(RunningValue / SalesQty_N)
                ELSE
                    RunningQty_N := 0;

                //------------------------------------Birds sold---------------------------------------------

                Bird_sold := 0;
                ILE2.RESET;
                ILE2.SETCURRENTKEY("Entry Type", "Posting Date");
                ILE2.SETRANGE("Flock No.", "Production Order"."No.");
                ILE2.SetFilter("Entry Type", '%1|%2', ILE2."Entry Type"::Sale, ILE2."Entry Type"::Transfer);
                ILE2.SETRANGE("Item Type", ILE2."Item Type"::Bird);//GK
                ILE2.SETRANGE("Posting Date", 0D, DateMax);
                //ILE2.SETRANGE("Global Dimension 2 Code",BranchFiter);
                ILE2.CALCSUMS("Alternate Quantity");
                Bird_sold := ILE2."Alternate Quantity";
                IF (RunningValue <> 0) AND (Bird_sold <> 0) THEN
                    TotalRunning := RunningValue / Bird_sold;

                //------------------------------Cum Feeds Cons---------------------------------------

                Cum_Feeds_Act := 0;
                ILE2.RESET;
                ILE2.SETCURRENTKEY("Entry Type", "Posting Date");
                ILE2.SETRANGE("Flock No.", "Production Order"."No.");
                ILE2.SETRANGE("Entry Type", ILE2."Entry Type"::Consumption);
                ILE2.SETRANGE("Item Type", ILE2."Item Type"::Feed);
                //ILE2.SETRANGE("Global Dimension 2 Code",BranchFiter);
                ILE2.SETRANGE("Posting Date", 0D, DateMax);
                ILE2.CALCSUMS(Quantity);
                Cum_Feeds_Act := ABS(ILE2.Quantity);


                //----------------------------Day feed Consumption--------------------------

                Day_Cons := 0;
                ILE2.RESET;
                ILE2.SETCURRENTKEY("Entry Type", "Posting Date");
                ILE2.SETRANGE("Flock No.", "Production Order"."No.");
                ILE2.SETRANGE("Entry Type", ILE2."Entry Type"::Consumption);
                ILE2.SETRANGE("Item Type", ILE2."Item Type"::Feed);
                //ILE2.SETRANGE("Global Dimension 2 Code",BranchFiter);
                ILE2.SETRANGE("Posting Date", DateMax);
                ILE2.CALCSUMS(Quantity);
                Day_Cons := ILE2.Quantity;



                //---------------------------- Previous Day feed Consumption--------------------------
                Prev_Day_Cons := 0;
                ILE2.RESET;
                ILE2.SETCURRENTKEY("Entry Type", "Posting Date");
                ILE2.SETRANGE("Flock No.", "Production Order"."No.");
                ILE2.SETRANGE("Entry Type", ILE2."Entry Type"::Consumption);
                ILE2.SETRANGE("Item Type", ILE2."Item Type"::Feed);
                //ILE2.SETRANGE("Global Dimension 2 Code",BranchFiter);
                ILE2.SETRANGE("Posting Date", DateMax - 1);
                ILE2.CALCSUMS(Quantity);
                Prev_Day_Cons := ILE2.Quantity;

                //---------------------------- Day Before Previous Day feed Consumption--------------------------
                Day_Before_Cons := 0;
                ILE2.RESET;
                ILE2.SETCURRENTKEY("Entry Type", "Posting Date");
                ILE2.SETRANGE("Flock No.", "Production Order"."No.");
                ILE2.SETRANGE("Entry Type", ILE2."Entry Type"::Consumption);
                ILE2.SETRANGE("Item Type", ILE2."Item Type"::Feed);
                //ILE2.SETRANGE("Global Dimension 2 Code",BranchFiter);
                ILE2.SETRANGE("Posting Date", DateMax - 2);
                ILE2.CALCSUMS(Quantity);
                Day_Before_Cons := ILE2.Quantity;

                //-------------------Feed Stock------------------------------------

                Feed_Stock := 0;


                ILE2.RESET;
                ILE2.SETCURRENTKEY("Entry Type", "Location Code", "External Document No.", "Item No.", "Order Type", "Order No.", "Order Line No.");
                ILE2.SETRANGE("Flock No.", "Production Order"."No.");
                ILE2.SETRANGE("Item Type", ILE2."Item Type"::Feed);
                ILE2.SETRANGE("Location Code", "Production Order"."Location Code");
                //ILE2.SETRANGE("Global Dimension 2 Code",BranchFiter);
                ILE2.SETRANGE("Posting Date", 0D, DateMax);
                ILE2.CALCSUMS(Quantity);
                Feed_Stock := ILE2.Quantity;

                //-------------------Intransit Feed Stock--------------------------
                In_Transit_Feed_Stock := 0;
                /*
                ILE2.RESET;
                ILE2.SETCURRENTKEY("Entry Type","Location Code","External Document No.","Item No.","Order Type","Order No.","Order Line No.");
                ILE2.SETRANGE("Flock No.","Production Order"."No.");
                ILE2.SETRANGE("Item Type",ILE2."Item Type"::Feed);
                ILE2.SETRANGE("Location Code",'IN-TRANSIT');
                ILE2.SETRANGE("Posting Date",0D,DateMax);
                //ILE2.SETRANGE("Global Dimension 2 Code",BranchFiter);
                ILE2.CALCSUMS("Remaining Quantity");
                  In_Transit_Feed_Stock:=ILE2."Remaining Quantity";
                  */

                TransferHeader_t.RESET;
                TransferHeader_t.SETRANGE("Transfer-to Code", "Production Order"."Location Code");
                TransferHeader_t.SETRANGE("Posting Date", 0D, DateMax);
                IF TransferHeader_t.FINDFIRST THEN
                    REPEAT
                        TransferLine_t.RESET;
                        TransferLine_t.SETRANGE("Document No.", TransferHeader_t."No.");
                        TransferLine_t.SETRANGE("Transfer-to Code", "Production Order"."Location Code");
                        TransferLine_t.SETRANGE("Item Type", TransferLine_t."Item Type"::Feed);
                        IF TransferLine_t.FINDFIRST THEN
                            REPEAT
                                In_Transit_Feed_Stock += TransferLine_t."Quantity Shipped" - TransferLine_t."Quantity Received";
                            UNTIL TransferLine_t.NEXT = 0;
                    UNTIL TransferHeader_t.NEXT = 0;

                //--------------------------------------Standard value-----------------------------------
                Cumm_Mortality.RESET;
                Cumm_Mortality.SETRANGE(Age, Flock_Age);
                IF Cumm_Mortality.FINDFIRST THEN BEGIN
                    mortality := Cumm_Mortality."Cumm. Mortality";
                    Body_Wt_Std := Cumm_Mortality."Weight (Gms)";
                    Cum_Feeds_Std := Cumm_Mortality."Cum.Intake (Gms)";
                    Per_Birds_Feed_Cons_Std := Cumm_Mortality."Daily Intake (Gms)";
                    Cum_Fcr_Std := Cumm_Mortality.FCR;
                    Day_Feed_Std := Cumm_Mortality."Daily Intake (Gms)";

                END;
                //---------------------------Name of supplier-------------------------

                dimension.RESET;
                dimension.SETRANGE(Code, "Production Order"."Location Code");
                IF dimension.FINDFIRST THEN
                    Line_Name := dimension.Name;

                //-------------------line Name----------------------------

                //-------------------------Weak Birds------------------------------
                Week_Birds := 0;
                TransferRcptline.RESET;
                TransferRcptline.SETCURRENTKEY("Transfer Order No.", "Item No.");
                TransferRcptline.SETRANGE("Flock No.", "Production Order"."No.");
                TransferRcptline.CALCSUMS("Weak Bird Quantity");
                Week_Birds := TransferRcptline."Weak Bird Quantity";

                //----------------------------no of Birds--------------------------

                NoofBirds := 0;
                ILE2.RESET;
                ILE2.SETCURRENTKEY("Entry Type", "Posting Date");
                ILE2.SETRANGE("Location Code", "Production Order"."Location Code");
                ILE2.SetFilter("Document Type", '%1|%2', ILE2."Document Type"::"Transfer Receipt", ILE2."Document Type"::"Purchase Receipt");// Suman 26/10
                ILE2.SETRANGE("Item Type", ILE2."Item Type"::Chick);
                ILE2.SETRANGE("Flock No.", "Production Order"."No.");
                //ILE2.SETRANGE("Global Dimension 2 Code",BranchFiter);
                ILE2.SETRANGE("Posting Date", 0D, DateMax);
                ILE2.CALCSUMS(Quantity);
                NoofBirds := ILE2.Quantity;


                FeedQty := 0;
                ILE2.RESET;
                ILE2.SETCURRENTKEY("Entry Type", "Posting Date");
                ILE2.SETRANGE("Flock No.", "Production Order"."No.");
                ILE2.SETRANGE("Entry Type", ILE2."Entry Type"::Sale);
                ILE2.SETRANGE("Posting Date", 0D, DateMax);
                //ILE2.SETRANGE("Global Dimension 2 Code",BranchFiter);
                //ILE2.CALCSUMS("Quantity");
                FeedQty := ILE2.Quantity;
                //-------------------Body Weight------------------
                Body_Wt_Act := 0;
                DataEntrySheet.RESET;
                DataEntrySheet.SETRANGE("Flock No.", "Production Order"."No.");
                DataEntrySheet.SETRANGE(Posted, TRUE);
                IF DataEntrySheet.FINDFIRST THEN BEGIN
                    DataEntryLines_R.RESET;
                    DataEntryLines_R.SETRANGE("Flock No.", "Production Order"."No.");
                    DataEntryLines_R.SETRANGE("Posting Date", DateMax);
                    DataEntryLines_R.SETRANGE("Parameter No.", 'PARA-055');
                    IF DataEntryLines_R.FINDFIRST THEN
                        // REPEAT
                        Body_Wt_Act := DataEntryLines_R."Actual Value";
                    /// UNTIL DataEntryLines_R.NEXT = 0;
                END;
                CLEAR(PerDayCun);

                IF (Day_Cons <> 0) AND ("Production Order".Quantity <> 0) AND (((("Production Order".Quantity - TransitMortality) + cum_Mor) - ABS(Bird_sold)) <> 0) THEN
                    PerDayCun := ABS(ROUND(Day_Cons / ((("Production Order".Quantity - TransitMortality) + cum_Mor) - ABS(Bird_sold)), 0.001, '='));

                CLEAR(PerConFed);
                IF (Body_Wt_Act <> 0) AND ("Production Order".Quantity <> 0) THEN
                    PerConFed := ABS(ROUND(Cum_Feeds_Act / ((("Production Order".Quantity - TransitMortality) - ABS(cum_Mor)) * ABS(Body_Wt_Act)), 0.01, '='));
                CLEAR(ConfeedStd);

                ConfeedStd := ROUND(Cum_Feeds_Std * (("Production Order".Quantity - TransitMortality) + Bird_sold + ABS(("Production Order".Quantity - TransitMortality
                - ABS(cum_Mor) - ABS(Bird_sold)))) / 2, 1, '=');
                CLEAR(Day_Feed_Stdform);

                Day_Feed_Stdform := ROUND(Day_Feed_Std * (("Production Order".Quantity - TransitMortality) + Bird_sold + ABS(("Production Order".Quantity - TransitMortality
                - ABS(cum_Mor) - ABS(Bird_sold)))) / 2, 1, '=');

                locCode := "Production Order"."Location Code";

                CLAmt := (("Production Order".Quantity - TransitMortality) - ABS(cum_Mor) - Bird_sold);
                IF CLAmt > 0 THEN
                    RunningQty_N := 0;

                //Round(Abs(Fields!Day_Cons.Value/(Fields!Quantity_ProductionOrder.Value-Fields!TransitMortality.Value-
                //Abs(Fields!cum_Mor.Value)-Abs(Fields!Bird_sold.Value))),3)

                IF (Day_Cons <> 0) AND ("Production Order".Quantity <> 0) AND ((("Production Order".Quantity - TransitMortality) - ABS(cum_Mor) - ABS(Bird_sold)) <> 0) THEN
                    FeedConPer := ABS(ROUND(Day_Cons / (("Production Order".Quantity - TransitMortality) - ABS(cum_Mor) - ABS(Bird_sold)), 0.001, '='))
                ELSE
                    FeedConPer := 0;

                DimenValue.Reset();
                DimenValue.SetRange(Code, BranchCode);
                dimension.SetRange("Dimension Code", 'BRANCH');
                if dimension.FindFirst() then
                    BranchName := dimension.Name;


            end;

            trigger OnPreDataItem()
            begin
                companyinfo.GET;
                Batchno := 0;
                If BranchCode <> '' then
                    "Production Order".SetRange("Shortcut Dimension 2 Code", BranchCode);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(Content)
            {
                field("Branch Code"; BranchCode)
                {
                    ApplicationArea = All;
                    Caption = 'Branch Code';
                    Editable = False;
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        var
            myInt: Integer;
            UserSetup: Record "User Setup";
        begin

            UserSetup.Reset();
            UserSetup.SetRange("User ID", UserId);
            if UserSetup.FindFirst() then
                BranchCode := UserSetup."Global Dimension 2 Code";

        End;

    }

    labels
    {
    }

    var
        BranchCode: text;
        SRno: Integer;
        companyinfo: Record 79;
        location: Record 14;
        Employee: Record 5200;
        ILE1: Record 32;
        ILE2: Record 32;
        ILE3: Record 32;
        ILE4: Record 32;
        locationname: Text;
        Supervisor: Text;
        Farm_sqft: Decimal;
        TransitMortality: Integer;
        DayMortality: Decimal;
        PreMortality: Decimal;
        DayBeforeMortality: Decimal;
        DateMin: Date;
        DateMax: Date;
        Cumm_Mortality: Record 50035;
        Flock_Age: Integer;
        cum_Mor: Decimal;
        mortality: Decimal;
        Bird_sold: Decimal;
        Body_Wt_Act: Decimal;
        Body_Wt_Std: Decimal;
        Cum_Feeds_Act: Decimal;
        Cum_Feeds_Std: Decimal;
        Cum_Fcr_Act: Decimal;
        Cum_Fcr_Std: Decimal;
        Running_Cop: Decimal;
        Day_Cons: Decimal;
        Day_Feed_Std: Decimal;
        Prev_Day_Cons: Decimal;
        Day_Before_Cons: Decimal;
        Per_Birds_Feed_Cons_Act: Decimal;
        Per_Birds_Feed_Cons_Std: Decimal;
        Feed_Stock: Decimal;
        In_Transit_Feed_Stock: Decimal;
        No_of_Birds_Supplied: Decimal;
        Short_Birds: Decimal;
        Week_Birds: Decimal;
        Name_of_sup: Decimal;
        Line_Name: Text;
        Cause_Of_Mortality: Text;
        Feed_cons_per_Bird: Decimal;
        dimension: Record 349;
        TransferRcptline: Record 5747;
        GCstatement: Record 50015;
        DataEntrySheet: Record 50003;
        RunningValue: Decimal;
        LocationState: Record 14;
        GCRateCalculation: Record 50020;
        GCStatement_R: Record 50015;
        TotalRunning: Decimal;
        PerDayCun: Decimal;
        ClosingBird: Decimal;
        NoofBirds: Decimal;
        DataEntryLines_R: Record 50005;
        PerConFed: Decimal;
        BranchFiter: Text;
        ConfeedStd: Decimal;
        Day_Feed_Stdform: Decimal;
        FeedQty: Decimal;
        DataEntryLines_rec: Record 50005;
        TrasMot: Decimal;
        WeekB: Decimal;
        ShortB: Decimal;
        DataEntryLines_T: Record 50005;
        ReasonCode_T: Record 231;
        TransferHeader_t: Record 5740;
        TransferLine_t: Record 5741;
        StdCost: Decimal;
        GCStandardCost: Record 50021;
        ItemLedgerEntry_T: Record 32;
        SalesQty_N: Decimal;
        RunningQty_N: Decimal;
        TotalN: Decimal;
        ItemN: Code[30];
        Item_R: Record 27;
        RuningNew: Decimal;
        datefN: Date;
        Batchno: Integer;
        locCode: Code[20];
        CLAmt: Decimal;
        FeedConPer: Decimal;
        LineNameCBF: Record 50033;
        LineName: Text;
        DimenValue: Record "Dimension Value";
        BranchName: Text;


    procedure SetReportFilter(Branch: Text)
    begin
        BranchCode := Branch;
    end;

}

