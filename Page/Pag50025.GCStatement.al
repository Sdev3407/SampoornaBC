page 50025 "GC Statement"
{
    // //Visible
    AutoSplitKey = false;
    DeleteAllowed = true;
    PageType = Card;
    SourceTable = "GC Statement";
    SourceTableView = SORTING("Shed Type", "No.")
                      WHERE("Shed Type" = CONST(Normal),
                            Posted = CONST(false));
    //   ApplicationArea = All;
    // UsageCategory = Documents;
    layout
    {
        area(content)
        {
            group(General)
            {
                ShowCaption = false;
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Lookup = False;

                    trigger OnAssistEdit()
                    begin
                        IF Rec.AssistEdit(xRec) THEN
                            CurrPage.UPDATE;
                    end;
                }
                field("Std. Prod Cost"; Rec."Std. Prod Cost")
                {
                    ApplicationArea = All;
                }
                field("Std. Sale Rate"; Rec."Std. Sale Rate")
                {
                    ApplicationArea = All;
                }
                field("Std. GC Rate"; Rec."Std. GC Rate")
                {
                    ApplicationArea = All;
                }
                field("Std. Admin Cost"; Rec."Std. Admin Cost")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Farmer No."; Rec."Farmer No.")
                {
                    ApplicationArea = All;
                }
                field("Farmer Name"; Rec."Farmer Name")
                {
                    ApplicationArea = All;
                }
                field("Farm Code"; Rec."Farm Code")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        CurrPage.UPDATE(TRUE);//UPDATION
                    end;
                }
                field("Farm Name"; Rec."Farm Name")
                {
                    ApplicationArea = All;
                }
                field("Flock No."; Rec."Flock No.")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        CurrPage.UPDATE(TRUE);//UPDATE
                    end;
                }
                field("TDS Section"; Rec."TDS Section")
                {
                    ApplicationArea = All;
                }
                field("Customer Code"; Rec."Customer Code")
                {
                    ApplicationArea = All;
                }
                field(Grade; Rec.Grade)
                {
                    ApplicationArea = All;
                }
                field("Hatchery/Vendor"; Rec."Hatchery/Vendor")
                {
                    ApplicationArea = All;
                }
                field("Supervisor Name"; Rec."Supervisor Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(EEF; Rec.EEF)
                {
                    ApplicationArea = All;
                }
                field("Chick Housed"; Rec."Chick Housed")
                {
                    ApplicationArea = All;
                }
                field("Birds Sold (kg)"; Rec."Birds Sold (kg)")
                {
                    ApplicationArea = All;
                }
                field("Birds Sold (Nos)"; Rec."Birds Sold (Nos)")
                {
                    ApplicationArea = All;
                }
                field("Feed Consumption(kgs)"; Rec."Feed Consumption(kgs)")
                {
                    ApplicationArea = All;
                }
                field("Accidental Mort(Recovery)"; Rec."Accidental Mort(Recovery)")
                {
                    ApplicationArea = All;
                }
                field("Liquidation Date"; Rec."Liquidation Date")
                {
                    ApplicationArea = All;

                    trigger OnValidate()

                    begin
                        if Rec."Liquidation Date" <> Today then
                            Error('Please Seelct the Today Date only Back date is not allowed');
                    end;

                }
                field("Receipt Date"; Rec."Receipt Date")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        CurrPage.UPDATE(TRUE);//UPDATION
                    end;
                }
                field(Mortality; Rec.Mortality)
                {
                    ApplicationArea = All;
                }
                field("Mortality %"; Rec."Mortality %")
                {
                    ApplicationArea = All;
                }
                field("1st week mortality %"; Rec."1st week mortality %")
                {
                    ApplicationArea = All;
                }
                field("Brooding Incentive"; Rec."Brooding Incentive")
                {
                    ApplicationArea = All;
                }
                field("1st week mortality"; Rec."1st week mortality")
                {
                    ApplicationArea = All;
                }
                field("Body Weight %"; Rec."Body Weight %")
                {
                    ApplicationArea = All;
                }
                field("Short Excess"; Rec."Short Excess")
                {
                    ApplicationArea = All;
                }
                field("Mean Age"; Rec."Mean Age")
                {
                    ApplicationArea = All;
                }
                field("Age (In Days)"; Rec."Age (In Days)")
                {
                    ApplicationArea = All;
                }
                field("Sale rate"; Rec."Sale rate")
                {
                    ApplicationArea = All;
                }
                field("Sale Amount"; Rec."Sale Amount")
                {
                    ApplicationArea = All;
                }
                field(FCR; Rec.FCR)
                {
                    ApplicationArea = All;
                }
                field(CFCR; Rec.CFCR)
                {
                    ApplicationArea = All;
                }
                field("Production Cost"; Rec."Production Cost")
                {
                    ApplicationArea = All;
                }
                field("SELF  DC NO :"; Rec."SELF  DC NO :")
                {
                    ApplicationArea = All;
                }
                field("Birds Rearing GC"; Rec."Birds Rearing GC")
                {
                    ApplicationArea = All;
                    Caption = 'Birds Rearing (Growing) Charges for live Grown-up  Comm. Br. Bird';
                }
                field("Bird Rearing Charge for CB-New"; Rec."Bird Rearing Charge for CB-New")
                {
                    ApplicationArea = All;
                    Caption = 'Bird Rearing Charge for CB - New';
                }
                field("Min. Growing Charge"; Rec."Min. Growing Charge")
                {
                    ApplicationArea = All;
                }
                field("Total Incentive (Add)"; Rec."Total Incentive (Add)")
                {
                    ApplicationArea = All;
                }
                field("TOTAL DEDUCTION(LESS)"; Rec."TOTAL DEDUCTION(LESS)")
                {
                    ApplicationArea = All;
                }
                field("TOTAL AMOUNT PAYABLE"; Rec."TOTAL AMOUNT PAYABLE")
                {
                    ApplicationArea = All;
                }
                field("LESS: T.D.S @ 1%"; Rec."LESS: T.D.S @ 1%")
                {
                    ApplicationArea = All;
                }
                field("AMOUNT PAYABLE AFTER T.D.S"; Rec."AMOUNT PAYABLE AFTER T.D.S")
                {
                    ApplicationArea = All;
                }
                field("Net Payable After TDS"; Rec."Net Payable After TDS")
                {
                    ApplicationArea = All;
                    Caption = 'Net Payable';
                }
                field(Receipt; Rec.Receipt)
                {
                    ApplicationArea = All;
                }
                field("Last Modified USERID"; Rec."Last USERID")
                {
                    ApplicationArea = All;
                    Caption = 'Last Modified USERID';
                }
                field("Last Modified Date"; Rec."Modified Date")
                {
                    ApplicationArea = All;
                    Caption = 'Last Modified Date';
                }


            }
            group("CALUATION OF REARING CHARGES")
            {
                Caption = 'CALUATION OF REARING CHARGES';
                Visible = false;
            }
            group("ADD :INCENTIVE")
            {
                Caption = 'ADD :INCENTIVE';
                Visible = true;
                field("Incentive for Low Cost"; Rec."Incentive for Low Cost")
                {
                    ApplicationArea = All;
                }
                field("Rate Incentive for Selling1"; Rec."Rate Incentive for Selling1")
                {
                    ApplicationArea = All;
                    Caption = 'Rate Incentive for Selling price 1';
                }
                field("Rate Incentive for Selling2"; Rec."Rate Incentive for Selling2")
                {
                    ApplicationArea = All;
                    Caption = 'Rate Incentive for Selling price 2';
                }
                field("Rate Incentive for Selling3"; Rec."Rate Incentive for Selling3")
                {
                    ApplicationArea = All;
                    Caption = 'Rate Incentive for Selling price 3';
                }
                field("Rate Incentive for Selling4"; Rec."Rate Incentive for Selling4")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Total of All Rate Incentive"; Rec."Total of All Rate Incentive")
                {
                    ApplicationArea = All;
                }
                field("Rate Incentive- Actual Amount"; Rec."Rate Incentive- Actual Amount")
                {
                    ApplicationArea = All;
                    Caption = 'Rate Incentive- Actual Amount if Prod. Cost is Low';
                }
                field("Max Rate Incentive Upto 2.5"; Rec."Max Rate Incentive Upto 2.5")
                {
                    ApplicationArea = All;
                }
                field("Summary Incentive1"; Rec."Summary Incentive1")
                {
                    ApplicationArea = All;
                    Caption = 'Summary Incentive 1';
                }
                field("Summary Incentive2"; Rec."Summary Incentive2")
                {
                    ApplicationArea = All;
                    Caption = 'Summary Incentive 2';
                }
                field("Feed Unloading Charges"; Rec."Feed Unloading Charges")
                {
                    ApplicationArea = All;
                }
            }
            group("LESS :DEDUCTION")
            {
                Caption = 'LESS :DEDUCTION';
                Visible = true;
                field("Deduction for high Mort"; Rec."Deduction for high Mort")
                {
                    ApplicationArea = All;
                    Caption = 'Deduction for high mortality';
                    MultiLine = true;
                    Width = 500;
                }
                field("Excess FCR Over"; Rec."Excess FCR Over")
                {
                    ApplicationArea = All;
                    Caption = 'Deduction for Excess FCR';
                }
                field("Deduction for Shortage"; Rec."Deduction for Shortage")
                {
                    ApplicationArea = All;
                    Caption = 'Deduction for Shortage Average Body weight';
                }
                field("Deduction for high Prod. Cost"; Rec."Deduction for high Prod. Cost")
                {
                    ApplicationArea = All;
                    Caption = 'Deduction for high Prod. Cost';
                }
                field("AMOUNT payable per bird"; Rec."AMOUNT payable per bird")
                {
                    ApplicationArea = All;
                }
                field("G.M."; Rec."G.M.")
                {
                    ApplicationArea = All;
                }
                field("D.G.M"; Rec."D.G.M")
                {
                    ApplicationArea = All;
                }
                field("A.G.M. Accounts"; Rec."A.G.M. Accounts")
                {
                    ApplicationArea = All;
                }
                field("Asst.  Manager Accounts"; Rec."Asst.  Manager Accounts")
                {
                    ApplicationArea = All;
                }
                field("Zone Manager"; Rec."Zone Manager")
                {
                    ApplicationArea = All;
                }
                field("Branch Manager"; Rec."Branch Manager")
                {
                    ApplicationArea = All;
                }
                field("Account Officer"; Rec."Account Officer")
                {
                    ApplicationArea = All;
                }
                field("Checked By"; Rec."Checked By")
                {
                    ApplicationArea = All;
                }
                field("I Accept the above payment"; Rec."I Accept the above payment")
                {
                    ApplicationArea = All;
                }
                field("Farmer Signature"; Rec."Farmer Signature")
                {
                    ApplicationArea = All;
                }
            }
            group(COSTING)
            {
                Caption = 'COSTING';
                field("Other Supplement"; Rec."Other Supplement")
                {
                    ApplicationArea = All;
                    Caption = 'Other Supplement Cost Amt.';
                }
                field("Chick Cost Qty"; Rec."Chick Cost Qty")
                {
                    ApplicationArea = All;
                }
                field("Chick Cost Rate"; Rec."Chick Cost Rate")
                {
                    ApplicationArea = All;
                }
                field("Chik Cost Amt."; Rec."Chik Cost Amt.")
                {
                    ApplicationArea = All;
                    Caption = 'Chick Cost Amt.';
                }
                field("Feed Cost Qty"; Rec."Feed Cost Qty")
                {
                    ApplicationArea = All;
                }
                field("Feed Cost Rate"; Rec."Feed Cost Rate")
                {
                    ApplicationArea = All;
                }
                field("Feed Cost Amt."; Rec."Feed Cost Amt.")
                {
                    ApplicationArea = All;
                }
                field("Maize Cost Amt."; Rec."Maize Cost Amt.")
                {
                    ApplicationArea = All;
                }
                field("Medicne Cost Amt."; Rec."Medicne Cost Amt.")
                {
                    ApplicationArea = All;
                }
                field("Vaccine Cost Amt."; Rec."Vaccine Cost Amt.")
                {
                    ApplicationArea = All;
                }
                field("AdministrationCost Rs2.2/Bird2"; Rec."AdministrationCost Rs2.2/Bird2")
                {
                    ApplicationArea = All;
                }
                field("TOTAL COST OF PRODUCTION2"; Rec."TOTAL COST OF PRODUCTION2")
                {
                    ApplicationArea = All;
                }
                field("Cost of Prod./kg Before RC2"; Rec."Cost of Prod./kg Before RC2")
                {
                    ApplicationArea = All;
                }
            }
            group("REARING CHARGES")
            {
                Caption = 'REARING CHARGES';
                field("Bird Sold IN Kg.2  Qty."; Rec."Bird Sold IN Kg.2  Qty.")
                {
                    ApplicationArea = All;
                }
                field("Bird Sold IN Kg.2  Rate"; Rec."Bird Sold IN Kg.2  Rate")
                {
                    ApplicationArea = All;
                }
                field("Bird Sold IN Kg.2  Amt."; Rec."Bird Sold IN Kg.2  Amt.")
                {
                    ApplicationArea = All;
                }
                field("Bird Sold IN No. Qty."; Rec."Bird Sold IN No. Qty.")
                {
                    ApplicationArea = All;
                }
                field("Bird Sold IN No. Rate"; Rec."Bird Sold IN No. Rate")
                {
                    ApplicationArea = All;
                }
                field("Bird Sold IN No. Amt."; Rec."Bird Sold IN No. Amt.")
                {
                    ApplicationArea = All;
                }
                field("Cost of Prod. After RC2"; Rec."Cost of Prod. After RC2")
                {
                    ApplicationArea = All;
                }
                field("Cost of Production Per Kg.2"; Rec."Cost of Production Per Kg.2")
                {
                    ApplicationArea = All;
                }
                field("F.C.R2"; Rec."F.C.R2")
                {
                    ApplicationArea = All;
                }
                field("Average Body weight2"; Rec."Average Body weight2")
                {
                    ApplicationArea = All;
                }
                field("Prod. Cost After RC2"; Rec."Prod. Cost After RC2")
                {
                    ApplicationArea = All;
                }
                field("SALE AMOUNT2"; Rec."SALE AMOUNT2")
                {
                    ApplicationArea = All;
                }
                field("NET PROFIT / (LOSS)"; Rec."NET PROFIT / (LOSS)")
                {
                    ApplicationArea = All;
                }
                field("NET PROFIT/ (LOSS)/BIRD"; Rec."NET PROFIT/ (LOSS)/BIRD")
                {
                    ApplicationArea = All;
                }
                field("Cost of Production Per Bird"; Rec."Cost of Production Per Bird")
                {
                    ApplicationArea = All;
                }
                field("Feed Intake"; Rec."Feed Intake")
                {
                    ApplicationArea = All;
                }
                field("Cum. Feed Consuption"; Rec."Cum. Feed Consuption")
                {
                    ApplicationArea = All;
                }
                field("Cum. Feed Std."; Rec."Cum. Feed Std.")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {

            action("Gc Calculation")
            {
                Image = Group;
                Promoted = true;
                PromotedCategory = Process;
                Visible = true;
                ApplicationArea = All;
                trigger OnAction()
                var
                    T5405: Record 5405;
                    Location: Record 14;
                    T50020: Record "GC Rate Calculation";
                    MedicineAmt: Decimal;
                    T32: Record 32;
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
                    T50021: Record "GC Standard Cost";
                    Whicheverishigher: Decimal;
                    BirdSoldShipmentKg: Decimal;
                    BirdSoldShipmentNos: Decimal;
                    BirdSoldCMKg: Decimal;
                    BirdSoldCMNos: Decimal;
                    ILE: Record 32;
                    DebitNoteQty: Decimal;
                    FlockWiseMaster: Record "Flock Wise Master";
                begin
                    UserSetup.RESET;
                    UserSetup.SETRANGE("User ID", USERID);
                    UserSetup.SETFILTER(UserSetup."Access Normal GC Statement", '%1', UserSetup."Access Normal GC Statement"::Create);
                    IF UserSetup.FINDFIRST THEN
                        ERROR('You do not have permission to calculate GC statement');
                    UserSetup.RESET;
                    UserSetup.SETRANGE("User ID", USERID);
                    UserSetup.SETFILTER(UserSetup."Access Normal GC Statement", '%1', UserSetup."Access Normal GC Statement"::View);
                    IF UserSetup.FINDFIRST THEN
                        ERROR('You do not have permission to calculate GC statement');
                    UserSetup.RESET;
                    UserSetup.SETRANGE("User ID", USERID);
                    UserSetup.SETFILTER(UserSetup."Access Normal GC Statement", '%1', UserSetup."Access Normal GC Statement"::Edit);
                    IF UserSetup.FINDFIRST THEN
                        ERROR('You do not have permission to calculate GC statement');

                    Rec.GCCalculation1;
                    "CalculateFeedIntake&UpdateFlockMaster"(Rec."Flock No.");   // SKS



                end;
            }
            action(Post)
            {
                Caption = 'Post';
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                Visible = Visible;
                ApplicationArea = All;
                trigger OnAction()
                var
                    GCStatement: Record "GC Statement";
                    DimensionMaster: Record "Dimension Master";
                    SMSSendTransferOrder: Codeunit 50009;
                    WhatsAppDetail: Codeunit "WhatsApp Function";
                    SmsSentjobQueue: Codeunit "SmsSentjobQueue";
                    GCTemplte: Text;
                    NumberList: List of [Text];
                    Number: Text;
                begin
                    CompanyInfo.Get;
                    IF CONFIRM(GCConfirm, FALSE) THEN BEGIN
                        //>>PRU_RPG DM_0.1
                        if CompanyInfo.SFPLCompany = CompanyInfo.SFPLCompany::Sampoorna then begin
                            DimensionMaster.RESET;
                            DimensionMaster.SETRANGE("Shortcut Dimension 1 Code", Rec."Shortcut Dimension 1 Code");
                            DimensionMaster.SETRANGE("Shortcut Dimension 2 Code", Rec."Shortcut Dimension 2 Code");
                            if CompanyInfo.SFPLCompany = CompanyInfo.SFPLCompany::Sampoorna then
                                DimensionMaster.SETRANGE("Shortcut Dimension 3 Code", Rec."Shortcut Dimension 3 Code");
                            IF NOT DimensionMaster.FINDFIRST THEN
                                ERROR('Dimension Master Does not exist');
                        end;

                        CLEAR(Qty);
                        ILE.RESET;
                        ILE.SETRANGE("Location Code", Rec."Farm Code");
                        ILE.SETRANGE("Flock No.", Rec."Flock No.");
                        IF ILE.FINDSET THEN
                            REPEAT
                                Qty += ILE."Remaining Quantity";
                            UNTIL ILE.NEXT = 0;

                        IF Qty <> 0 THEN
                            ERROR('Please check the Remaining Stock');
                        //<<PRU_RPG DM_0.1

                        Rec.TESTFIELD("TDS Section");
                        Clear(GCTemplte);
                        if CompanyInfo.SFPLCompany in [CompanyInfo.SFPLCompany::Sampoorna] then
                            GCTemplte := '01khb4prz7yzccdh5qrb6zj491'
                        else
                            GCTemplte := '01khd5wvza3tbssnqp5c552a2t';
                        GCStatement.RESET;
                        GCStatement.SETRANGE("Shed Type", Rec."Shed Type");
                        GCStatement.SETRANGE("No.", Rec."No.");
                        IF GCStatement.FINDFIRST THEN BEGIN
                            CLEAR(PostingDateInput);
                            PostingDateInput.RUNMODAL;
                            PostingDateInput.GetFillterValue(PostingD);
                            IF PostingD = 0D THEN
                                ERROR('Posting Date Must Have a value');
                            if PostingD <> Today then
                                Error('Please update the Today date only, Backdate is not allowed');
                            if GCStatement."Liquidation Date" <> PostingD Then begin
                                GCStatement.Validate("Liquidation Date", PostingD);
                                GCStatement.Modify();
                                Rec.GCCalculation1;
                                GCStatement.Modify();
                            end;
                            GCStatement.Posted := TRUE;
                            GCStatement.MODIFY;
                            SMSSendTransferOrder.SMSSendGCStatment(GCStatement."No.");
                            Recregion.Get(GCStatement.Region);
                            CLEAR(WhatsAppDetail);


                            Clear(Week1Mortality);
                            Clear(Week2Mortality);
                            Clear(Week3Mortality);
                            Clear(Week4Mortality);
                            Clear(Week5Mortality);
                            ILE.Reset();
                            ILE.SetRange("Document No.", GCStatement."Flock No.");
                            ILE.SETFILTER("In-transit Mortality", '%1', FALSE);
                            ILE.SetRange("Data Entry Type", ILE."Data Entry Type"::"Mortality - Chicks");
                            ILE.SetRange("Posting Date", GCStatement."Receipt Date", (GCStatement."Receipt Date" + 7));
                            ILE.CalcSums(Quantity);
                            Week1Mortality := Round((ABS(ILE.Quantity) / GCStatement."Chick Housed") * 100, 0.001, '=');

                            ILE.Reset();
                            ILE.SetRange("Document No.", GCStatement."Flock No.");
                            ILE.SETFILTER("In-transit Mortality", '%1', FALSE);
                            ILE.SetRange("Data Entry Type", ILE."Data Entry Type"::"Mortality - Chicks");
                            ILE.SetRange("Posting Date", (GCStatement."Receipt Date" + 8), (GCStatement."Receipt Date" + 14));
                            ILE.CalcSums(Quantity);
                            Week2Mortality := Round((ABS(ILE.Quantity) / GCStatement."Chick Housed") * 100, 0.001, '=');

                            ILE.Reset();
                            ILE.SetRange("Document No.", GCStatement."Flock No.");
                            ILE.SETFILTER("In-transit Mortality", '%1', FALSE);
                            ILE.SetRange("Data Entry Type", ILE."Data Entry Type"::"Mortality - Chicks");
                            ILE.SetRange("Posting Date", (GCStatement."Receipt Date" + 15), (GCStatement."Receipt Date" + 21));
                            ILE.CalcSums(Quantity);
                            Week3Mortality := Round((ABS(ILE.Quantity) / GCStatement."Chick Housed") * 100, 0.001, '=');

                            ILE.Reset();
                            ILE.SetRange("Document No.", GCStatement."Flock No.");
                            ILE.SETFILTER("In-transit Mortality", '%1', FALSE);
                            ILE.SetRange("Data Entry Type", ILE."Data Entry Type"::"Mortality - Chicks");
                            ILE.SetRange("Posting Date", (GCStatement."Receipt Date" + 22), (GCStatement."Receipt Date" + 28));
                            ILE.CalcSums(Quantity);
                            Week4Mortality := Round((ABS(ILE.Quantity) / GCStatement."Chick Housed") * 100, 0.001, '=');

                            ILE.Reset();
                            ILE.SetRange("Document No.", GCStatement."Flock No.");
                            ILE.SETFILTER("In-transit Mortality", '%1', FALSE);
                            ILE.SetRange("Data Entry Type", ILE."Data Entry Type"::"Mortality - Chicks");
                            ILE.SetRange("Posting Date", (GCStatement."Receipt Date" + 29), (GCStatement."Receipt Date" + 36));
                            ILE.CalcSums(Quantity);
                            Week5Mortality := Round((ABS(ILE.Quantity) / GCStatement."Chick Housed") * 100, 0.001, '=');

                            // SMSfunctions.SendWhatsappMessage(SMSfunctions.WhatsupSmsOnGC(GetBranchName(GCStatement."Shortcut Dimension 2 Code"), GCStatement."Farm Name", GCStatement."Receipt Date", GCStatement."Chick Housed", GCStatement.Mortality, GCStatement."Mortality %",
                            //  GCStatement."Mean Age", GCStatement."Average Body weight2", ROUND(GCStatement.FCR, 0.001, '='), ROUND(GCStatement.CFCR, 0.001, '='), GCStatement.EEF, ROUND(GCStatement."Sale rate", 0.01, '=')), '9988212588,7087071000,9876608880');
                            // SMSfunctions.SendWhatsappMessage(SMSfunctions.WhatsupSmsOnGC(GetBranchName(GCStatement."Shortcut Dimension 2 Code"), GCStatement."Farm Name", GCStatement."Receipt Date", GCStatement."Chick Housed", GCStatement.Mortality, GCStatement."Mortality %",
                            // GCStatement."Mean Age", GCStatement."Average Body weight2", ROUND(GCStatement.FCR, 0.001, '='), ROUND(GCStatement.CFCR, 0.001, '='), GCStatement.EEF, ROUND(GCStatement."Sale rate", 0.01, '=')), '9149662146,7023022755,7527020415');
                            // SMSfunctions.SendWhatsappMessage(SMSfunctions.WhatsupSmsOnGC(GetBranchName(GCStatement."Shortcut Dimension 2 Code"), GCStatement."Farm Name", GCStatement."Receipt Date", GCStatement."Chick Housed", GCStatement.Mortality, GCStatement."Mortality %",
                            // GCStatement."Mean Age", GCStatement."Average Body weight2", ROUND(GCStatement.FCR, 0.001, '='), ROUND(GCStatement.CFCR, 0.001, '='), GCStatement.EEF, ROUND(GCStatement."Sale rate", 0.01, '=')), '7588134854');
                            // SMSfunctions.SendWhatsappMessage(SMSfunctions.WhatsupSmsOnGC(GetBranchName(GCStatement."Shortcut Dimension 2 Code"), GCStatement."Farm Name", GCStatement."Receipt Date", GCStatement."Chick Housed", GCStatement.Mortality, GCStatement."Mortality %",
                            // GCStatement."Mean Age", GCStatement."Average Body weight2", ROUND(GCStatement.FCR, 0.001, '='), ROUND(GCStatement.CFCR, 0.001, '='), GCStatement.EEF, ROUND(GCStatement."Sale rate", 0.01, '=')), Recregion."MobileNo.");
                            // SMSfunctions.SendWhatsappMessage(SMSfunctions.WhatsupSmsOnGC(GetBranchName(GCStatement."Shortcut Dimension 2 Code"), GCStatement."Farm Name", GCStatement."Receipt Date", GCStatement."Chick Housed", GCStatement.Mortality, GCStatement."Mortality %",
                            // GCStatement."Mean Age", GCStatement."Average Body weight2", ROUND(GCStatement.FCR, 0.001, '='), ROUND(GCStatement.CFCR, 0.001, '='), GCStatement.EEF, ROUND(GCStatement."Sale rate", 0.01, '=')), '9569949996');
                            //================ New API
                            WhatsAppDetail.AirtelWhatssAppAPI(SMSfunctions.WhatsupSmsOnGCNewAPI(GetBranchName(GCStatement."Shortcut Dimension 2 Code"), GCStatement."Farm Name", GCStatement."Receipt Date", Format(GCStatement."Chick Housed"), Format(GCStatement.Mortality), Format(GCStatement."Mortality %"),
                            Format(GCStatement."Mean Age"), Format(GCStatement."Average Body weight2"), Format(ROUND(GCStatement.FCR, 0.001, '=')), Format(ROUND(GCStatement.CFCR, 0.001, '=')), Format(GCStatement.EEF), Format(ROUND(GCStatement."Sale rate", 0.01, '=')), Format(Week1Mortality), Format(Week2Mortality), Format(Week3Mortality), Format(Week4Mortality), Format(Week5Mortality), '9988212588', GCTemplte));
                            WhatsAppDetail.AirtelWhatssAppAPI(SMSfunctions.WhatsupSmsOnGCNewAPI(GetBranchName(GCStatement."Shortcut Dimension 2 Code"), GCStatement."Farm Name", GCStatement."Receipt Date", Format(GCStatement."Chick Housed"), Format(GCStatement.Mortality), Format(GCStatement."Mortality %"),
                                                        Format(GCStatement."Mean Age"), Format(GCStatement."Average Body weight2"), Format(ROUND(GCStatement.FCR, 0.001, '=')), Format(ROUND(GCStatement.CFCR, 0.001, '=')), Format(GCStatement.EEF), Format(ROUND(GCStatement."Sale rate", 0.01, '=')), Format(Week1Mortality), Format(Week2Mortality), Format(Week3Mortality), Format(Week4Mortality), Format(Week5Mortality), '7087071000', GCTemplte));
                            WhatsAppDetail.AirtelWhatssAppAPI(SMSfunctions.WhatsupSmsOnGCNewAPI(GetBranchName(GCStatement."Shortcut Dimension 2 Code"), GCStatement."Farm Name", GCStatement."Receipt Date", Format(GCStatement."Chick Housed"), Format(GCStatement.Mortality), Format(GCStatement."Mortality %"),
                                                        Format(GCStatement."Mean Age"), Format(GCStatement."Average Body weight2"), Format(ROUND(GCStatement.FCR, 0.001, '=')), Format(ROUND(GCStatement.CFCR, 0.001, '=')), Format(GCStatement.EEF), Format(ROUND(GCStatement."Sale rate", 0.01, '=')), Format(Week1Mortality), Format(Week2Mortality), Format(Week3Mortality), Format(Week4Mortality), Format(Week5Mortality), '9876608880', GCTemplte));
                            WhatsAppDetail.AirtelWhatssAppAPI(SMSfunctions.WhatsupSmsOnGCNewAPI(GetBranchName(GCStatement."Shortcut Dimension 2 Code"), GCStatement."Farm Name", GCStatement."Receipt Date", Format(GCStatement."Chick Housed"), Format(GCStatement.Mortality), Format(GCStatement."Mortality %"),
                                                        Format(GCStatement."Mean Age"), Format(GCStatement."Average Body weight2"), Format(ROUND(GCStatement.FCR, 0.001, '=')), Format(ROUND(GCStatement.CFCR, 0.001, '=')), Format(GCStatement.EEF), Format(ROUND(GCStatement."Sale rate", 0.01, '=')), Format(Week1Mortality), Format(Week2Mortality), Format(Week3Mortality), Format(Week4Mortality), Format(Week5Mortality), '9149662146', GCTemplte));

                            WhatsAppDetail.AirtelWhatssAppAPI(SMSfunctions.WhatsupSmsOnGCNewAPI(GetBranchName(GCStatement."Shortcut Dimension 2 Code"), GCStatement."Farm Name", GCStatement."Receipt Date", Format(GCStatement."Chick Housed"), Format(GCStatement.Mortality), Format(GCStatement."Mortality %"),
                                                        Format(GCStatement."Mean Age"), Format(GCStatement."Average Body weight2"), Format(ROUND(GCStatement.FCR, 0.001, '=')), Format(ROUND(GCStatement.CFCR, 0.001, '=')), Format(GCStatement.EEF), Format(ROUND(GCStatement."Sale rate", 0.01, '=')), Format(Week1Mortality), Format(Week2Mortality), Format(Week3Mortality), Format(Week4Mortality), Format(Week5Mortality), '7023022755', GCTemplte));
                            WhatsAppDetail.AirtelWhatssAppAPI(SMSfunctions.WhatsupSmsOnGCNewAPI(GetBranchName(GCStatement."Shortcut Dimension 2 Code"), GCStatement."Farm Name", GCStatement."Receipt Date", Format(GCStatement."Chick Housed"), Format(GCStatement.Mortality), Format(GCStatement."Mortality %"),
                                                        Format(GCStatement."Mean Age"), Format(GCStatement."Average Body weight2"), Format(ROUND(GCStatement.FCR, 0.001, '=')), Format(ROUND(GCStatement.CFCR, 0.001, '=')), Format(GCStatement.EEF), Format(ROUND(GCStatement."Sale rate", 0.01, '=')), Format(Week1Mortality), Format(Week2Mortality), Format(Week3Mortality), Format(Week4Mortality), Format(Week5Mortality), '7527020415', GCTemplte));

                            WhatsAppDetail.AirtelWhatssAppAPI(SMSfunctions.WhatsupSmsOnGCNewAPI(GetBranchName(GCStatement."Shortcut Dimension 2 Code"), GCStatement."Farm Name", GCStatement."Receipt Date", Format(GCStatement."Chick Housed"), Format(GCStatement.Mortality), Format(GCStatement."Mortality %"),
                                                       Format(GCStatement."Mean Age"), Format(GCStatement."Average Body weight2"), Format(ROUND(GCStatement.FCR, 0.001, '=')), Format(ROUND(GCStatement.CFCR, 0.001, '=')), Format(GCStatement.EEF), Format(ROUND(GCStatement."Sale rate", 0.01, '=')), Format(Week1Mortality), Format(Week2Mortality), Format(Week3Mortality), Format(Week4Mortality), Format(Week5Mortality), '9569949996', GCTemplte));// Parveen Kumar
                            WhatsAppDetail.AirtelWhatssAppAPI(SMSfunctions.WhatsupSmsOnGCNewAPI(GetBranchName(GCStatement."Shortcut Dimension 2 Code"), GCStatement."Farm Name", GCStatement."Receipt Date", Format(GCStatement."Chick Housed"), Format(GCStatement.Mortality), Format(GCStatement."Mortality %"),
                                                        Format(GCStatement."Mean Age"), Format(GCStatement."Average Body weight2"), Format(ROUND(GCStatement.FCR, 0.001, '=')), Format(ROUND(GCStatement.CFCR, 0.001, '=')), Format(GCStatement.EEF), Format(ROUND(GCStatement."Sale rate", 0.01, '=')), Format(Week1Mortality), Format(Week2Mortality), Format(Week3Mortality), Format(Week4Mortality), Format(Week5Mortality), '7300000016', GCTemplte));// Riya Gupta

                            // WhatsAppDetail.AirtelWhatssAppAPI(SMSfunctions.WhatsupSmsOnGCNewAPI(GetBranchName(GCStatement."Shortcut Dimension 2 Code"), GCStatement."Farm Name", GCStatement."Receipt Date", GCStatement."Chick Housed", GCStatement.Mortality, GCStatement."Mortality %",
                            // GCStatement."Mean Age", GCStatement."Average Body weight2", ROUND(GCStatement.FCR, 0.001, '='), ROUND(GCStatement.CFCR, 0.001, '='), GCStatement.EEF, ROUND(GCStatement."Sale rate", 0.01, '='), Week1Mortality, Week2Mortality, Week3Mortality, Week4Mortality, Week5Mortality, '7300000016', GCTemplte));// Riya Gupta


                            NumberList := Recregion."MobileNo.".Split(',');
                            foreach Number in NumberList do begin
                                WhatsAppDetail.AirtelWhatssAppAPI(SMSfunctions.WhatsupSmsOnGCNewAPI(GetBranchName(GCStatement."Shortcut Dimension 2 Code"), GCStatement."Farm Name", GCStatement."Receipt Date", Format(GCStatement."Chick Housed"), Format(GCStatement.Mortality), Format(GCStatement."Mortality %"),
                                 Format(GCStatement."Mean Age"), Format(GCStatement."Average Body weight2"), Format(ROUND(GCStatement.FCR, 0.001, '=')), Format(ROUND(GCStatement.CFCR, 0.001, '=')), Format(GCStatement.EEF), Format(ROUND(GCStatement."Sale rate", 0.01, '=')), Format(Week1Mortality), Format(Week2Mortality), Format(Week3Mortality), Format(Week4Mortality), Format(Week5Mortality), Number, GCTemplte));
                            END;
                            MESSAGE('GC Statement No. %1 Posted Successfully', GCStatement."No.");

                        END;
                    END;
                end;
            }
            action("GC Report")
            {
                Caption = 'GC Report';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                ApplicationArea = All;
                trigger OnAction()
                var
                    GCStatement: Record "GC Statement";
                begin
                    OptionTypeReport;
                end;
            }
            action("Update GC Cal")
            {
                ApplicationArea = All;
                trigger OnAction()
                var
                    GCStatement: Record "GC Statement";
                    FlockWiseMaster: Record "Flock Wise Master";
                    LastConsumed: Decimal;
                    LastCumFeddActual: Decimal;
                begin
                    GCStatement.RESET;
                    GCStatement.SETRANGE(GCStatement."Liquidation Date", 20210101D, TODAY);
                    GCStatement.SETRANGE(GCStatement.Posted, TRUE);
                    IF GCStatement.FINDSET THEN BEGIN
                        REPEAT
                            LastCumFeddActual := 0;
                            LastConsumed := 0;
                            FlockWiseMaster.RESET;
                            FlockWiseMaster.SETRANGE(FlockWiseMaster."Flock No.", GCStatement."Flock No.");
                            FlockWiseMaster.SETFILTER(FlockWiseMaster.Consumed, '<>%1', 0);
                            IF FlockWiseMaster.FINDLAST THEN BEGIN
                                LastConsumed := FlockWiseMaster."CUMFEED Std.";
                            END;
                            FlockWiseMaster.RESET;
                            FlockWiseMaster.SETRANGE(FlockWiseMaster."Flock No.", GCStatement."Flock No.");
                            IF FlockWiseMaster.FINDLAST THEN BEGIN
                                LastCumFeddActual := FlockWiseMaster."CUMFEED Actual";
                            END;
                            IF LastConsumed <> 0 THEN
                                GCStatement."Feed Intake" := LastCumFeddActual / LastConsumed * 100
                            ELSE
                                GCStatement."Feed Intake" := LastCumFeddActual;
                            GCStatement."Cum. Feed Consuption" := LastCumFeddActual;
                            GCStatement."Cum. Feed Std." := LastConsumed;
                            GCStatement.MODIFY(TRUE);
                        //MESSAGE('%1',GCStatement."Flock No.");
                        UNTIL GCStatement.NEXT = 0;
                    END;

                end;
            }
            action("GC Post With GJ Entry")
            {
                Image = PostingEntries;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = true;
                ApplicationArea = All;
                trigger OnAction()
                var
                    GenJournalLine: Record 81;
                    LineNo: Integer;
                    GenJournalBatch: Record 232;
                    NoSeriesManagement: Codeunit 396;
                    SalesReceivablesSetup: Record 311;
                    PostGenJournalBatch: Record 81;
                    PrintVoucher: Record 17;
                    GCStatement: Record "GC Statement";
                    DimensionMaster: Record "Dimension Master";
                    SMSSendTransferOrder: Codeunit 50009;
                begin
                    CompanyInfo.Get;
                    CLEAR(Qty);
                    ILE.RESET;
                    ILE.SETRANGE("Location Code", Rec."Farm Code");
                    ILE.SETRANGE("Flock No.", Rec."Flock No.");
                    IF ILE.FINDSET THEN
                        REPEAT
                            Qty += ILE."Remaining Quantity";
                        UNTIL ILE.NEXT = 0;

                    IF Qty <> 0 THEN
                        ERROR('Please check the Remaining Stock');
                    if CompanyInfo.SFPLCompany = CompanyInfo.SFPLCompany::Sampoorna then begin
                        DimensionMaster.RESET;
                        DimensionMaster.SETRANGE("Shortcut Dimension 1 Code", Rec."Shortcut Dimension 1 Code");
                        DimensionMaster.SETRANGE("Shortcut Dimension 2 Code", Rec."Shortcut Dimension 2 Code");

                        DimensionMaster.SETRANGE("Shortcut Dimension 3 Code", Rec."Shortcut Dimension 3 Code");
                        IF NOT DimensionMaster.FINDFIRST THEN
                            ERROR('Dimension Master Does not exist');
                    end;
                    Rec.TESTFIELD("TDS Section");

                    PostandPrint(Rec);
                end;
            }
            action(TestSMS)
            {
                ApplicationArea = all;
                trigger OnAction()
                var
                    Codeunit1: Codeunit "SmsSentjobQueue";
                    GCStatement: record "GC Statement";
                    SMSDetails: Codeunit "SMS Details";
                    Payload: Text;
                    SMSSendGCStatment: Codeunit "SMS Send Transfer Order";
                begin
                    Clear(Payload);
                    GCStatement.Reset();
                    GCStatement.SetRange("No.", Rec."No.");
                    if GCStatement.FindFirst() then
                        SMSSendGCStatment.SMSSendGCStatment(GCStatement."No.");
                end;
            }
        }
    }

    trigger OnDeleteRecord(): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Normal GC Statement", '%1', UserSetup."Access Normal GC Statement"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have Permission to Delete GC Statement');
        //PRU_DD 1.10
    end;

    trigger OnInit()
    begin
        Visible := TRUE;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        IF xRec."Shed Type" = xRec."Shed Type"::Normal THEN BEGIN
            UserSetup.RESET;
            UserSetup.SETRANGE("User ID", USERID);
            UserSetup.SETFILTER(UserSetup."Access Normal GC Statement", '%1', UserSetup."Access Normal GC Statement"::View);
            IF UserSetup.FINDFIRST THEN
                ERROR('You do not have Permission to Create GC Statement');
        END;
        //PRU_DD 1.10

        IF xRec."Shed Type" = xRec."Shed Type"::Normal THEN BEGIN
            UserSetup.RESET;
            UserSetup.SETRANGE("User ID", USERID);
            UserSetup.SETFILTER(UserSetup."Access Normal GC Statement", '%1', UserSetup."Access Normal GC Statement"::Edit);
            IF UserSetup.FINDFIRST THEN
                ERROR('You do not have Permission to Create GC Statement');
        END;
        //PRU_DD 1.10
    end;

    trigger OnModifyRecord(): Boolean
    begin
        IF xRec."Shed Type" = xRec."Shed Type"::Normal THEN BEGIN
            UserSetup.RESET;
            UserSetup.SETRANGE("User ID", USERID);
            UserSetup.SETFILTER(UserSetup."Access Normal GC Statement", '%1', UserSetup."Access Normal GC Statement"::View);
            IF UserSetup.FINDFIRST THEN
                ERROR('You do not have Permission to Change GC Statement Details');
        END;
        //PRU_DD 1.10
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Modified Date" := DT2DATE(CURRENTDATETIME);// PRU_AS 13 NOV 2019
        Rec."Last USERID" := USERID;// PRU_AS 13 NOV 2019

        IF xRec."Shed Type" = xRec."Shed Type"::Normal THEN BEGIN
            UserSetup.RESET;
            UserSetup.SETRANGE("User ID", USERID);
            UserSetup.SETFILTER(UserSetup."Access Normal GC Statement", '%1', UserSetup."Access Normal GC Statement"::View);
            IF UserSetup.FINDFIRST THEN
                CurrPage.EDITABLE(FALSE);
        END;
        //PRU_DD 1.10
    end;

    trigger OnOpenPage()
    var
        userset: Record 91;
    begin
        //PRU_DD 1.10
        IF xRec."Shed Type" = xRec."Shed Type"::Normal THEN BEGIN
            UserSetup.RESET;
            UserSetup.SETRANGE("User ID", USERID);
            UserSetup.SETFILTER(UserSetup."Access Normal GC Statement", '%1', UserSetup."Access Normal GC Statement"::" ");
            IF UserSetup.FINDFIRST THEN
                ERROR('You do not have permission to open GC Statement');

            UserSetup.RESET;
            UserSetup.SETRANGE("User ID", USERID);
            UserSetup.SETFILTER(UserSetup."Access Normal GC Statement", '%1', UserSetup."Access Normal GC Statement"::View);
            IF UserSetup.FINDFIRST THEN
                CurrPage.EDITABLE(FALSE);
        END;
        //PRU_DD 1.10


        userset.GET(USERID);
        Rec.FILTERGROUP(2);
        Rec.SETFILTER("Shortcut Dimension 1 Code", userset."Global Dimension 1 Code");
        Rec.SETFILTER("Shortcut Dimension 2 Code", userset."Global Dimension 2 Code");
        IF NOT userset."HO Users" THEN
            Rec.SETFILTER("Shortcut Dimension 3 Code", userset."Shortcut Dimension 3 Code");
        Rec.FILTERGROUP(0);

        IF USERID = 'SAM4525' THEN BEGIN
            Visible := TRUE;
        END ELSE
            Visible := FALSE;
    end;

    var

        Week1Mortality: Decimal;
        Week2Mortality: Decimal;
        Week3Mortality: Decimal;
        Week4Mortality: Decimal;
        Week5Mortality: Decimal;
        CompanyInfo: Record "Company Information";
        GCConfirm: Label 'Do you want to post the GC?';
        TotalRateIncentive: Decimal;
        RateIncentive: Decimal;
        UserSetup: Record 91;
        Qty: Decimal;
        ILE: Record 32;
        PrintDocNo: Code[20];
        PrintDocDate: Date;
        // PostedVoucher: Report 16567;
        PostingD: Date;
        PostingDateInput: Page "Posting Date Input";
        GenJnlPost: Codeunit "Gen. Jnl.-Post";
        GENCheck: codeunit 50029;
        GCStatement: Record "GC Statement";
        ActualFeedRec: Decimal;
        ActualFeecTr: Decimal;
        Location: Record 14;
        Visible: Boolean;
        SMSfunctions: Codeunit 50026;
        Recregion: Record Region;

    local procedure OptionTypeReport()
    var
        Selection: Integer;
        Oldgcreport: Boolean;
        Gcreport: Boolean;
        GCStatement: Record "GC Statement";
        Text000: Label '&Print New GC Report,&Print Old GC Report';
    begin
        CLEAR(Gcreport);
        CLEAR(Oldgcreport);
        Selection := STRMENU(Text000, 1);
        IF Selection = 0 THEN
            EXIT;

        Gcreport := Selection IN [1, 3];
        Oldgcreport := Selection IN [2, 3];


        IF Gcreport = TRUE THEN BEGIN
            GCStatement.RESET;
            GCStatement.SETRANGE("Shed Type", Rec."Shed Type");
            GCStatement.SETRANGE("No.", Rec."No.");
            IF GCStatement.FINDFIRST THEN
                REPORT.RUNMODAL(50019, TRUE, FALSE, GCStatement);
        END;

        IF Oldgcreport = TRUE THEN BEGIN
            GCStatement.RESET;
            GCStatement.SETRANGE("Shed Type", Rec."Shed Type");
            GCStatement.SETRANGE("No.", Rec."No.");
            IF GCStatement.FINDFIRST THEN
                REPORT.RUNMODAL(50024, TRUE, FALSE, GCStatement);
        END;
    end;

    local procedure "CalculateFeedIntake&UpdateFlockMaster"(FlockNo: Code[20])
    var
        ProductionOrder: Record 5405;
        UpdateFeedIntakeMaster: Codeunit 50021;
        FlockWiseMaster: Record "Flock Wise Master";
        LastCumFeddActual: Decimal;
        LastConsumed: Decimal;
    begin
        //ERROR('Test');
        ProductionOrder.RESET;
        ProductionOrder.SETRANGE(ProductionOrder.Status, ProductionOrder.Status::Released);
        ProductionOrder.SETRANGE(ProductionOrder."Short Close", FALSE);
        ProductionOrder.SETRANGE(ProductionOrder."Shortcut Dimension 1 Code", 'CBF');
        ProductionOrder.SETRANGE(ProductionOrder."No.", FlockNo);
        IF ProductionOrder.FINDFIRST THEN BEGIN
            CLEAR(UpdateFeedIntakeMaster);
            UpdateFeedIntakeMaster.Code(FlockNo);
            COMMIT;
        END;
        FlockWiseMaster.RESET;
        FlockWiseMaster.SETRANGE(FlockWiseMaster."Flock No.", FlockNo);
        FlockWiseMaster.SETFILTER(FlockWiseMaster.Consumed, '<>%1', 0);
        IF FlockWiseMaster.FINDLAST THEN BEGIN
            LastConsumed := FlockWiseMaster."CUMFEED Std.";
        END;
        FlockWiseMaster.RESET;
        FlockWiseMaster.SETRANGE(FlockWiseMaster."Flock No.", FlockNo);
        IF FlockWiseMaster.FINDLAST THEN BEGIN
            LastCumFeddActual := FlockWiseMaster."CUMFEED Actual";
        END;
        IF LastConsumed <> 0 THEN
            Rec."Feed Intake" := LastCumFeddActual / LastConsumed * 100
        ELSE
            Rec."Feed Intake" := LastCumFeddActual;
        Rec."Cum. Feed Consuption" := LastCumFeddActual;
        Rec."Cum. Feed Std." := LastConsumed;

        FlockWiseMaster.RESET;
        FlockWiseMaster.SETRANGE(FlockWiseMaster."Flock No.", Rec."Flock No.");
        IF FlockWiseMaster.FINDSET THEN BEGIN
            REPEAT
                Rec."Total Feed Receive" += FlockWiseMaster.Recieved;
                Rec."Total Feed Shiped" += FlockWiseMaster.Transfer;
            UNTIL FlockWiseMaster.NEXT = 0;
        END;

        IF Rec."Total Feed Receive" <> 0 THEN
            Rec."Feed Return %" := (Rec."Total Feed Shiped" / Rec."Total Feed Receive") * 100;

        CurrPage.UPDATE;
    end;


    procedure PostandPrint(GCStatementp: Record "GC Statement")
    var
        GenJournalLine: Record 81;
        GenJournalLine1: Record 81;
        LineNo: Integer;
        GenJournalBatch: Record 232;
        NoSeriesManagement: Codeunit 396;
        SalesReceivablesSetup: Record 311;
        PostGenJournalBatch: Record 81;
        PrintVoucher: Record 17;
        GCStatement: Record "GC Statement";
        DimensionMaster: Record "Dimension Master";
        SMSSendTransferOrder: Codeunit 50009;
        CalculateTax: Codeunit "Calculate Tax";
        GenGen: Page "General Journal";
        GLSetup: Record "General Ledger Setup";
        Payload: Text;
        WhatsAppDetail: Codeunit "WhatsApp Function";
        SmsSentjobQueue: Codeunit "SmsSentjobQueue";
        GCTemplte: Text;
        NumberList: List of [Text];
        Number: Text;

    begin
        CompanyInfo.Get;
        IF CONFIRM(GCConfirm, FALSE) THEN BEGIN
            //<<PRU_RPG DM_0.1
            Clear(GCTemplte);
            //ERROR('TESTFIELD');
            Location.RESET;
            IF Location.GET(GCStatementp."Farm Code") THEN BEGIN
                if CompanyInfo.SFPLCompany in [CompanyInfo.SFPLCompany::Sampoorna] Then
                    GCTemplte := '01khb4prz7yzccdh5qrb6zj491'
                else
                    GCTemplte := '01khd5wvza3tbssnqp5c552a2t';
                IF (Location."Farm Type" <> Location."Farm Type"::" ") AND (Location."Farm Type" <> Location."Farm Type"::"Own Farm") THEN BEGIN
                    SalesReceivablesSetup.GET;
                    GenJournalLine.RESET;
                    GenJournalLine.SETRANGE(GenJournalLine."Journal Batch Name", 'DEFAULT');
                    GenJournalLine.SETRANGE(GenJournalLine."Journal Template Name", 'GENERAL');
                    IF GenJournalLine.FINDLAST THEN
                        LineNo := GenJournalLine."Line No."
                    ELSE
                        LineNo := 0;
                    GenJournalLine.RESET;
                    GenJournalLine.INIT;
                    GenJournalLine."Journal Batch Name" := 'DEFAULT';
                    GenJournalLine."Journal Template Name" := 'GENERAL';
                    GenJournalLine.VALIDATE(GenJournalLine."Line No.", LineNo + 10000);
                    CLEAR(PostingDateInput);
                    PostingDateInput.RUNMODAL;
                    PostingDateInput.GetFillterValue(PostingD);
                    IF PostingD = 0D THEN
                        ERROR('Posting Date Must Have a value');
                    if PostingD <> Today then
                        Error('Please update the Today date only, Backdate is not allowed');
                    if GCStatementp."Liquidation Date" <> PostingD Then begin
                        GCStatementp.Validate("Liquidation Date", PostingD);
                        GCStatementp.Modify();
                        GCStatementp.GCCalculation1;
                        GCStatementp.Modify();
                    end;
                    GenJournalLine.VALIDATE(GenJournalLine."Posting Date", PostingD);
                    GenJournalLine.VALIDATE(GenJournalLine."Source Code", 'GENJNL');
                    GenJournalLine."Document Type" := GenJournalLine."Document Type"::Invoice;//Suman
                    GenJournalLine."Party Type" := GenJournalLine."Party Type"::Vendor;//suman
                    GenJournalLine.VALIDATE(GenJournalLine."Party Code", GCStatementp."Farmer No.");//suman
                    GenJournalLine.VALIDATE(GenJournalLine."Document No.", NoSeriesManagement.GetNextNo(SalesReceivablesSetup."Process No Series", WORKDATE, TRUE));
                    IF GCStatementp."Min. Growing Charge" <> 0 THEN BEGIN
                        GenJournalLine.VALIDATE(GenJournalLine."Credit Amount", ROUND(GCStatementp."TOTAL AMOUNT PAYABLE", 1, '='));
                        GenJournalLine."Line Narration1" := 'Min. Growing Charges Amount' + ' ' + FORMAT(GCStatementp."TOTAL AMOUNT PAYABLE") + ' ' + 'Pan No' + ' ' + GCStatementp."PAN No" + ' ' + 'Liq Date' + ' ' + FORMAT(GCStatementp."Liquidation Date") + ' ' + 'Gc No' + ' ' + GCStatementp."No.";
                    END ELSE BEGIN
                        GenJournalLine.VALIDATE(GenJournalLine."Credit Amount", ROUND(GCStatementp."TOTAL AMOUNT PAYABLE", 1, '='));
                        GenJournalLine."Line Narration1" := 'Growing Charges Amount' + ' ' + FORMAT(GCStatementp."TOTAL AMOUNT PAYABLE") + ' ' + 'Pan No' + ' ' + GCStatementp."PAN No" + ' ' + 'Liq Date' + ' ' + FORMAT(GCStatementp."Liquidation Date") + ' ' + 'Gc No' + ' ' + GCStatementp."No.";
                    END;
                    GenJournalLine.VALIDATE(GenJournalLine."Bal. Account Type", GenJournalLine."Bal. Account Type"::"G/L Account");
                    if CompanyInfo.SFPLCompany = CompanyInfo.SFPLCompany::Sampoorna then
                        GenJournalLine.VALIDATE(GenJournalLine."Bal. Account No.", '1280170');
                    if CompanyInfo.SFPLCompany = CompanyInfo.SFPLCompany::"Star Foods" then
                        GenJournalLine.VALIDATE(GenJournalLine."Bal. Account No.", '313609');
                    GenJournalLine."Shortcut Dimension 1 Code" := GCStatementp."Shortcut Dimension 1 Code";
                    GenJournalLine."Shortcut Dimension 2 Code" := GCStatementp."Shortcut Dimension 2 Code";
                    if CompanyInfo.SFPLCompany = CompanyInfo.SFPLCompany::Sampoorna then
                        GenJournalLine.VALIDATE("Shortcut Dimension 3 Code", GCStatementp."Shortcut Dimension 3 Code");
                    GenJournalLine."Dimension Set ID" := GCStatementp."Dimension Set ID";
                    GenJournalLine."Due Date" := (GCStatementp."Liquidation Date" + 15);// Suman

                    //   if 
                    GenJournalLine.VALIDATE("TDS Section Code", GCStatementp."TDS Section");
                    PrintDocNo := GenJournalLine."Document No.";
                    GenJournalLine."External Document No." := GCStatementp."Flock No.";
                    PrintDocDate := GenJournalLine."Posting Date";
                    GenJournalLine."GST Credit" := GenJournalLine."GST Credit"::" ";
                    GenJournalLine.INSERT;
                    CalculateTax.CallTaxEngineOnGenJnlLine(GenJournalLine, GenJournalLine);
                    MESSAGE(GenJournalLine."Document No.");

                    GENCheck.SetPostingTrue(TRUE);
                    GenJnlPost.RUN(GenJournalLine);
                    PrintVoucher.RESET;
                    PrintVoucher.SETRANGE(PrintVoucher."Document No.", PrintDocNo);
                    PrintVoucher.SETRANGE(PrintVoucher."Posting Date", PrintDocDate);
                    MESSAGE(PrintDocNo);
                    //PrintVoucher.SETFILTER("Source Code",'<>%1','INVTPCOST');
                    IF PrintVoucher.FINDFIRST THEN BEGIN
                        REPORT.RUNMODAL(REPORT::"Posted Voucher1", false, TRUE, PrintVoucher);
                    END;

                END;
            END;

            //CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post",GenJournalLine);
            GCStatement.RESET;
            GCStatement.SETRANGE("Shed Type", GCStatementp."Shed Type");
            GCStatement.SETRANGE("No.", GCStatementp."No.");
            IF GCStatement.FINDFIRST THEN BEGIN
                GCStatement.Posted := TRUE;
                GCStatement.MODIFY;
                GLSetup.Get();
                //if GLSetup."Run SMS" = true then
                SMSSendTransferOrder.SMSSendGCStatment(GCStatement."No.");
                Recregion.Get(GCStatement.Region);

                CLEAR(WhatsAppDetail);

                Clear(Week1Mortality);
                Clear(Week2Mortality);
                Clear(Week3Mortality);
                Clear(Week4Mortality);
                Clear(Week5Mortality);
                ILE.Reset();
                ILE.SetRange("Document No.", GCStatement."Flock No.");
                ILE.SETFILTER("In-transit Mortality", '%1', FALSE);
                ILE.SetRange("Data Entry Type", ILE."Data Entry Type"::"Mortality - Chicks");
                ILE.SetRange("Posting Date", GCStatement."Receipt Date", (GCStatement."Receipt Date" + 7));
                ILE.CalcSums(Quantity);
                Week1Mortality := Round((ABS(ILE.Quantity) / GCStatement."Chick Housed") * 100, 0.001, '=');

                ILE.Reset();
                ILE.SetRange("Document No.", GCStatement."Flock No.");
                ILE.SETFILTER("In-transit Mortality", '%1', FALSE);
                ILE.SetRange("Data Entry Type", ILE."Data Entry Type"::"Mortality - Chicks");
                ILE.SetRange("Posting Date", (GCStatement."Receipt Date" + 8), (GCStatement."Receipt Date" + 14));
                ILE.CalcSums(Quantity);
                Week2Mortality := Round((ABS(ILE.Quantity) / GCStatement."Chick Housed") * 100, 0.001, '=');

                ILE.Reset();
                ILE.SetRange("Document No.", GCStatement."Flock No.");
                ILE.SETFILTER("In-transit Mortality", '%1', FALSE);
                ILE.SetRange("Data Entry Type", ILE."Data Entry Type"::"Mortality - Chicks");
                ILE.SetRange("Posting Date", (GCStatement."Receipt Date" + 15), (GCStatement."Receipt Date" + 21));
                ILE.CalcSums(Quantity);
                Week3Mortality := Round((ABS(ILE.Quantity) / GCStatement."Chick Housed") * 100, 0.001, '=');

                ILE.Reset();
                ILE.SetRange("Document No.", GCStatement."Flock No.");
                ILE.SETFILTER("In-transit Mortality", '%1', FALSE);
                ILE.SetRange("Data Entry Type", ILE."Data Entry Type"::"Mortality - Chicks");
                ILE.SetRange("Posting Date", (GCStatement."Receipt Date" + 22), (GCStatement."Receipt Date" + 28));
                ILE.CalcSums(Quantity);
                Week4Mortality := Round((ABS(ILE.Quantity) / GCStatement."Chick Housed") * 100, 0.001, '=');

                ILE.Reset();
                ILE.SetRange("Document No.", GCStatement."Flock No.");
                ILE.SETFILTER("In-transit Mortality", '%1', FALSE);
                ILE.SetRange("Data Entry Type", ILE."Data Entry Type"::"Mortality - Chicks");
                ILE.SetRange("Posting Date", (GCStatement."Receipt Date" + 29), (GCStatement."Receipt Date" + 36));
                ILE.CalcSums(Quantity);
                Week5Mortality := Round((ABS(ILE.Quantity) / GCStatement."Chick Housed") * 100, 0.001, '=');

                // SMSfunctions.SendWhatsappMessage(SMSfunctions.WhatsupSmsOnGC(GetBranchName(GCStatement."Shortcut Dimension 2 Code"), GCStatement."Farm Name", GCStatement."Receipt Date", GCStatement."Chick Housed", GCStatement.Mortality, GCStatement."Mortality %",
                // GCStatement."Mean Age", GCStatement."Average Body weight2", ROUND(GCStatement.FCR, 0.001, '='), ROUND(GCStatement.CFCR, 0.001, '='), GCStatement.EEF, ROUND(GCStatement."Sale rate", 0.01, '=')), '9988212588,7087071000,9876608880');
                // SMSfunctions.SendWhatsappMessage(SMSfunctions.WhatsupSmsOnGC(GetBranchName(GCStatement."Shortcut Dimension 2 Code"), GCStatement."Farm Name", GCStatement."Receipt Date", GCStatement."Chick Housed", GCStatement.Mortality, GCStatement."Mortality %",
                // GCStatement."Mean Age", GCStatement."Average Body weight2", ROUND(GCStatement.FCR, 0.001, '='), ROUND(GCStatement.CFCR, 0.001, '='), GCStatement.EEF, ROUND(GCStatement."Sale rate", 0.01, '=')), '9149662146,7023022755,7527020415');
                // SMSfunctions.SendWhatsappMessage(SMSfunctions.WhatsupSmsOnGC(GetBranchName(GCStatement."Shortcut Dimension 2 Code"), GCStatement."Farm Name", GCStatement."Receipt Date", GCStatement."Chick Housed", GCStatement.Mortality, GCStatement."Mortality %",
                // GCStatement."Mean Age", GCStatement."Average Body weight2", ROUND(GCStatement.FCR, 0.001, '='), ROUND(GCStatement.CFCR, 0.001, '='), GCStatement.EEF, ROUND(GCStatement."Sale rate", 0.01, '=')), '7588134854');
                // SMSfunctions.SendWhatsappMessage(SMSfunctions.WhatsupSmsOnGC(GetBranchName(GCStatement."Shortcut Dimension 2 Code"), GCStatement."Farm Name", GCStatement."Receipt Date", GCStatement."Chick Housed", GCStatement.Mortality, GCStatement."Mortality %",
                // GCStatement."Mean Age", GCStatement."Average Body weight2", ROUND(GCStatement.FCR, 0.001, '='), ROUND(GCStatement.CFCR, 0.001, '='), GCStatement.EEF, ROUND(GCStatement."Sale rate", 0.01, '=')), Recregion."MobileNo.");

                //=============== New API Business Whatsapp======================================================//
                WhatsAppDetail.AirtelWhatssAppAPI(SMSfunctions.WhatsupSmsOnGCNewAPI(GetBranchName(GCStatement."Shortcut Dimension 2 Code"), GCStatement."Farm Name", GCStatement."Receipt Date", Format(GCStatement."Chick Housed"), Format(GCStatement.Mortality), Format(GCStatement."Mortality %"),
                            Format(GCStatement."Mean Age"), Format(GCStatement."Average Body weight2"), Format(ROUND(GCStatement.FCR, 0.001, '=')), Format(ROUND(GCStatement.CFCR, 0.001, '=')), Format(GCStatement.EEF), Format(ROUND(GCStatement."Sale rate", 0.01, '=')), Format(Week1Mortality), Format(Week2Mortality), Format(Week3Mortality), Format(Week4Mortality), Format(Week5Mortality), '9988212588', GCTemplte));
                WhatsAppDetail.AirtelWhatssAppAPI(SMSfunctions.WhatsupSmsOnGCNewAPI(GetBranchName(GCStatement."Shortcut Dimension 2 Code"), GCStatement."Farm Name", GCStatement."Receipt Date", Format(GCStatement."Chick Housed"), Format(GCStatement.Mortality), Format(GCStatement."Mortality %"),
                                            Format(GCStatement."Mean Age"), Format(GCStatement."Average Body weight2"), Format(ROUND(GCStatement.FCR, 0.001, '=')), Format(ROUND(GCStatement.CFCR, 0.001, '=')), Format(GCStatement.EEF), Format(ROUND(GCStatement."Sale rate", 0.01, '=')), Format(Week1Mortality), Format(Week2Mortality), Format(Week3Mortality), Format(Week4Mortality), Format(Week5Mortality), '7087071000', GCTemplte));
                WhatsAppDetail.AirtelWhatssAppAPI(SMSfunctions.WhatsupSmsOnGCNewAPI(GetBranchName(GCStatement."Shortcut Dimension 2 Code"), GCStatement."Farm Name", GCStatement."Receipt Date", Format(GCStatement."Chick Housed"), Format(GCStatement.Mortality), Format(GCStatement."Mortality %"),
                                            Format(GCStatement."Mean Age"), Format(GCStatement."Average Body weight2"), Format(ROUND(GCStatement.FCR, 0.001, '=')), Format(ROUND(GCStatement.CFCR, 0.001, '=')), Format(GCStatement.EEF), Format(ROUND(GCStatement."Sale rate", 0.01, '=')), Format(Week1Mortality), Format(Week2Mortality), Format(Week3Mortality), Format(Week4Mortality), Format(Week5Mortality), '9876608880', GCTemplte));
                WhatsAppDetail.AirtelWhatssAppAPI(SMSfunctions.WhatsupSmsOnGCNewAPI(GetBranchName(GCStatement."Shortcut Dimension 2 Code"), GCStatement."Farm Name", GCStatement."Receipt Date", Format(GCStatement."Chick Housed"), Format(GCStatement.Mortality), Format(GCStatement."Mortality %"),
                                            Format(GCStatement."Mean Age"), Format(GCStatement."Average Body weight2"), Format(ROUND(GCStatement.FCR, 0.001, '=')), Format(ROUND(GCStatement.CFCR, 0.001, '=')), Format(GCStatement.EEF), Format(ROUND(GCStatement."Sale rate", 0.01, '=')), Format(Week1Mortality), Format(Week2Mortality), Format(Week3Mortality), Format(Week4Mortality), Format(Week5Mortality), '9149662146', GCTemplte));

                WhatsAppDetail.AirtelWhatssAppAPI(SMSfunctions.WhatsupSmsOnGCNewAPI(GetBranchName(GCStatement."Shortcut Dimension 2 Code"), GCStatement."Farm Name", GCStatement."Receipt Date", Format(GCStatement."Chick Housed"), Format(GCStatement.Mortality), Format(GCStatement."Mortality %"),
                                            Format(GCStatement."Mean Age"), Format(GCStatement."Average Body weight2"), Format(ROUND(GCStatement.FCR, 0.001, '=')), Format(ROUND(GCStatement.CFCR, 0.001, '=')), Format(GCStatement.EEF), Format(ROUND(GCStatement."Sale rate", 0.01, '=')), Format(Week1Mortality), Format(Week2Mortality), Format(Week3Mortality), Format(Week4Mortality), Format(Week5Mortality), '7023022755', GCTemplte));
                WhatsAppDetail.AirtelWhatssAppAPI(SMSfunctions.WhatsupSmsOnGCNewAPI(GetBranchName(GCStatement."Shortcut Dimension 2 Code"), GCStatement."Farm Name", GCStatement."Receipt Date", Format(GCStatement."Chick Housed"), Format(GCStatement.Mortality), Format(GCStatement."Mortality %"),
                                            Format(GCStatement."Mean Age"), Format(GCStatement."Average Body weight2"), Format(ROUND(GCStatement.FCR, 0.001, '=')), Format(ROUND(GCStatement.CFCR, 0.001, '=')), Format(GCStatement.EEF), Format(ROUND(GCStatement."Sale rate", 0.01, '=')), Format(Week1Mortality), Format(Week2Mortality), Format(Week3Mortality), Format(Week4Mortality), Format(Week5Mortality), '7527020415', GCTemplte));


                WhatsAppDetail.AirtelWhatssAppAPI(SMSfunctions.WhatsupSmsOnGCNewAPI(GetBranchName(GCStatement."Shortcut Dimension 2 Code"), GCStatement."Farm Name", GCStatement."Receipt Date", Format(GCStatement."Chick Housed"), Format(GCStatement.Mortality), Format(GCStatement."Mortality %"),
                                           Format(GCStatement."Mean Age"), Format(GCStatement."Average Body weight2"), Format(ROUND(GCStatement.FCR, 0.001, '=')), Format(ROUND(GCStatement.CFCR, 0.001, '=')), Format(GCStatement.EEF), Format(ROUND(GCStatement."Sale rate", 0.01, '=')), Format(Week1Mortality), Format(Week2Mortality), Format(Week3Mortality), Format(Week4Mortality), Format(Week5Mortality), '9569949996', GCTemplte));// Parveen Kumar
                WhatsAppDetail.AirtelWhatssAppAPI(SMSfunctions.WhatsupSmsOnGCNewAPI(GetBranchName(GCStatement."Shortcut Dimension 2 Code"), GCStatement."Farm Name", GCStatement."Receipt Date", Format(GCStatement."Chick Housed"), Format(GCStatement.Mortality), Format(GCStatement."Mortality %"),
                                            Format(GCStatement."Mean Age"), Format(GCStatement."Average Body weight2"), Format(ROUND(GCStatement.FCR, 0.001, '=')), Format(ROUND(GCStatement.CFCR, 0.001, '=')), Format(GCStatement.EEF), Format(ROUND(GCStatement."Sale rate", 0.01, '=')), Format(Week1Mortality), Format(Week2Mortality), Format(Week3Mortality), Format(Week4Mortality), Format(Week5Mortality), '7300000016', GCTemplte));// Riya Gupta
                                                                                                                                                                                                                                                                                                                                                                                                                                               //===============Business Whatsapp======================================================//
                NumberList := Recregion."MobileNo.".Split(',');
                foreach Number in NumberList do begin
                    WhatsAppDetail.AirtelWhatssAppAPI(SMSfunctions.WhatsupSmsOnGCNewAPI(GetBranchName(GCStatement."Shortcut Dimension 2 Code"), GCStatement."Farm Name", GCStatement."Receipt Date", Format(GCStatement."Chick Housed"), Format(GCStatement.Mortality), Format(GCStatement."Mortality %"),
                                     Format(GCStatement."Mean Age"), Format(GCStatement."Average Body weight2"), Format(ROUND(GCStatement.FCR, 0.001, '=')), Format(ROUND(GCStatement.CFCR, 0.001, '=')), Format(GCStatement.EEF), Format(ROUND(GCStatement."Sale rate", 0.01, '=')), Format(Week1Mortality), Format(Week2Mortality), Format(Week3Mortality), Format(Week4Mortality), Format(Week5Mortality), Number, GCTemplte));
                END;
            end;
            MESSAGE('GC Statement No. %1 Posted Successfully', GCStatement."No.");
        END;
        GenJournalLine1.Reset();
        GenJournalLine1.SetRange("Journal Template Name", 'GENERAL');
        GenJournalLine1.SetRange("Journal Batch Name", 'DEFAULT');
        if GenJournalLine1.FindFirst() then
            GenJournalLine1.DeleteAll();

    END;


    local procedure GetBranchName(DimCode: Code[20]): Text
    var
        DimensionValue: Record 349;
    begin
        DimensionValue.RESET;
        DimensionValue.SETRANGE(DimensionValue."Global Dimension No.", 2);
        DimensionValue.SETRANGE(DimensionValue."Dimension Code", 'BRANCH');
        DimensionValue.SETRANGE(DimensionValue.Code, DimCode);
        IF DimensionValue.FINDFIRST THEN
            EXIT(DimensionValue.Name);
    end;
}

