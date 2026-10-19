report 50004 "Aged Accounts Payab Creditor"
{
    Caption = 'Aged Accounts Payable';
    UsageCategory = Administration;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'ReportLayout\AgedAccountsPayabCreditor.rdl';

    dataset
    {
        dataitem(Vendor; 23)
        {
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.";
            column(CompanyName; COMPANYNAME)
            {
            }
            column(NewPagePerVendor; NewPagePerVendor)
            {
            }
            column(AgesAsOfEndingDate; STRSUBSTNO(Text006, FORMAT(EndingDate, 0, 4)))
            {
            }
            column(SelectAgeByDuePostngDocDt; STRSUBSTNO(Text007, SELECTSTR(AgingBy + 1, Text009)))
            {
            }
            column(PrintAmountInLCY; PrintAmountInLCY)
            {
            }
            column(CaptionVendorFilter; TABLECAPTION + ': ' + VendorFilter)
            {
            }
            column(VendorFilter; VendorFilter)
            {
            }
            column(AgingBy; AgingBy)
            {
            }
            column(SelctAgeByDuePostngDocDt1; STRSUBSTNO(Text004, SELECTSTR(AgingBy + 1, Text009)))
            {
            }
            column(HeaderText5; HeaderText[5])
            {
            }
            column(HeaderText4; HeaderText[4])
            {
            }
            column(HeaderText3; HeaderText[3])
            {
            }
            column(HeaderText2; HeaderText[2])
            {
            }
            column(HeaderText1; HeaderText[1])
            {
            }
            column(PrintDetails; PrintDetails)
            {
            }
            column(GrandTotalVLE5RemAmtLCY; GrandTotalVLERemaingAmtLCY[5])
            {
                AutoFormatType = 1;
            }
            column(GrandTotalVLE4RemAmtLCY; GrandTotalVLERemaingAmtLCY[4])
            {
                AutoFormatType = 1;
            }
            column(GrandTotalVLE3RemAmtLCY; GrandTotalVLERemaingAmtLCY[3])
            {
                AutoFormatType = 1;
            }
            column(GrandTotalVLE2RemAmtLCY; GrandTotalVLERemaingAmtLCY[2])
            {
                AutoFormatType = 1;
            }
            column(GrandTotalVLE1RemAmtLCY; GrandTotalVLERemaingAmtLCY[1])
            {
                AutoFormatType = 1;
            }
            column(GrandTotalVLE1AmtLCY; GrandTotalVLEAmtLCY)
            {
                AutoFormatType = 1;
            }
            column(PageGroupNo; PageGroupNo)
            {
            }
            column(No_Vendor; "No.")
            {
            }
            column(AgedAcctPayableCaption; AgedAcctPayableCaptionLbl)
            {
            }
            column(CurrReportPageNoCaption; CurrReportPageNoCaptionLbl)
            {
            }
            column(AllAmtsinLCYCaption; AllAmtsinLCYCaptionLbl)
            {
            }
            column(AgedOverdueAmsCaption; AgedOverdueAmsCaptionLbl)
            {
            }
            column(GrandTotalVLE5RemAmtLCYCaption; GrandTotalVLE5RemAmtLCYCaptionLbl)
            {
            }
            column(AmountLCYCaption; AmountLCYCaptionLbl)
            {
            }
            column(DueDateCaption; DueDateCaptionLbl)
            {
            }
            column(DocumentNoCaption; DocumentNoCaptionLbl)
            {
            }
            column(PostingDateCaption; PostingDateCaptionLbl)
            {
            }
            column(DocumentTypeCaption; DocumentTypeCaptionLbl)
            {
            }
            column(VendorNoCaption; FIELDCAPTION("No."))
            {
            }
            column(VendorNameCaption; FIELDCAPTION("Name"))
            {
            }
            column(CurrencyCaption; CurrencyCaptionLbl)
            {
            }
            column(TotalLCYCaption; TotalLCYCaptionLbl)
            {
            }
            column(CompanyInfo_Picture; CompanyInfo.Picture)
            {
            }
            column(ViewCreditorType; ViewCreditorType)
            {
            }
            dataitem(DataItem4114; 25)
            {
                DataItemLink = "Vendor No." = FIELD("No."),
                              "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                               "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter");
                DataItemTableView = SORTING("Vendor No.", "Posting Date", "Currency Code");
                PrintOnlyIfDetail = true;

                trigger OnAfterGetRecord()
                var
                    VendorLedgEntry: Record 25;
                begin
                    VendorLedgEntry.SETCURRENTKEY("Closed by Entry No.");
                    VendorLedgEntry.SETRANGE("Closed by Entry No.", "Entry No.");
                    VendorLedgEntry.SETRANGE("Posting Date", 0D, EndingDate);
                    IF VendorLedgEntry.FINDSET(FALSE, FALSE) THEN
                        REPEAT
                            InsertTemp(VendorLedgEntry);
                        UNTIL VendorLedgEntry.NEXT = 0;

                    IF "Closed by Entry No." <> 0 THEN BEGIN
                        VendorLedgEntry.SETRANGE("Closed by Entry No.", "Closed by Entry No.");
                        IF VendorLedgEntry.FINDSET(FALSE, FALSE) THEN
                            REPEAT
                                InsertTemp(VendorLedgEntry);
                            UNTIL VendorLedgEntry.NEXT = 0;
                    END;

                    VendorLedgEntry.RESET;
                    VendorLedgEntry.SETRANGE("Entry No.", "Closed by Entry No.");
                    VendorLedgEntry.SETRANGE("Posting Date", 0D, EndingDate);
                    IF VendorLedgEntry.FINDSET(FALSE, FALSE) THEN
                        REPEAT
                            InsertTemp(VendorLedgEntry);
                        UNTIL VendorLedgEntry.NEXT = 0;
                    CurrReport.SKIP;
                end;

                trigger OnPreDataItem()
                begin
                    SETRANGE("Posting Date", EndingDate + 1, 99991231D);
                end;
            }
            dataitem(OpenVendorLedgEntry; 25)
            {
                DataItemLink = "Vendor No." = FIELD("No."),
                               "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                               "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter");
                DataItemTableView = SORTING("Vendor No.", Open, Positive, "Due Date", "Currency Code");
                PrintOnlyIfDetail = true;

                trigger OnAfterGetRecord()
                begin
                    IF AgingBy = AgingBy::"Posting Date" THEN BEGIN
                        CALCFIELDS("Remaining Amt. (LCY)");
                        IF "Remaining Amt. (LCY)" = 0 THEN
                            CurrReport.SKIP;
                    END;
                    InsertTemp(OpenVendorLedgEntry);
                    CurrReport.SKIP;
                end;

                trigger OnPreDataItem()
                begin
                    IF AgingBy = AgingBy::"Posting Date" THEN BEGIN
                        SETRANGE("Posting Date", 0D, EndingDate);
                        SETRANGE("Date Filter", 0D, EndingDate);
                    END
                end;
            }
            dataitem(CurrencyLoop; 2000000026)
            {
                DataItemTableView = SORTING("Number")
                                    WHERE(Number = FILTER(1 ..));
                PrintOnlyIfDetail = true;
                dataitem(TempVendortLedgEntryLoop; 2000000026)
                {
                    DataItemTableView = SORTING("Number")
                                        WHERE(Number = FILTER(1 ..));
                    column(VendorName; Vendor."Name")
                    {
                    }
                    column(VendorNo; Vendor."No.")
                    {
                    }
                    column(CreditorType; VendorLedgEntryEndingDate."Creditors Type")
                    {
                    }
                    column(VLEEndingDateRemAmtLCY; VendorLedgEntryEndingDate."Remaining Amt. (LCY)")
                    {
                        AutoFormatType = 1;
                    }
                    column(AgedVLE1RemAmtLCY; AgedVendorLedgEntry[1]."Remaining Amt. (LCY)")
                    {
                        AutoFormatType = 1;
                    }
                    column(AgedVendLedgEnt2RemAmtLCY; AgedVendorLedgEntry[2]."Remaining Amt. (LCY)")
                    {
                        AutoFormatType = 1;
                    }
                    column(AgedVendLedgEnt3RemAmtLCY; AgedVendorLedgEntry[3]."Remaining Amt. (LCY)")
                    {
                        AutoFormatType = 1;
                    }
                    column(AgedVendLedgEnt4RemAmtLCY; AgedVendorLedgEntry[4]."Remaining Amt. (LCY)")
                    {
                        AutoFormatType = 1;
                    }
                    column(AgedVendLedgEnt5RemAmtLCY; AgedVendorLedgEntry[5]."Remaining Amt. (LCY)")
                    {
                        AutoFormatType = 1;
                    }
                    column(VendLedgEntryEndDtAmtLCY; VendorLedgEntryEndingDate."Amount (LCY)")
                    {
                        AutoFormatType = 1;
                    }
                    column(VendLedgEntryEndDtDueDate; FORMAT(VendorLedgEntryEndingDate."Due Date"))
                    {
                    }
                    column(VendLedgEntryEndDtDocNo; VendorLedgEntryEndingDate."Document No.")
                    {
                    }
                    column(VendLedgEntyEndgDtDocType; FORMAT(VendorLedgEntryEndingDate."Document Type"))
                    {
                    }
                    column(VendLedgEntryEndDtPostgDt; FORMAT(VendorLedgEntryEndingDate."Posting Date"))
                    {
                    }
                    column(AgedVendLedgEnt5RemAmt; AgedVendorLedgEntry[5]."Remaining Amount")
                    {
                        AutoFormatExpression = "CurrencyCode";
                        AutoFormatType = 1;
                    }
                    column(AgedVendLedgEnt4RemAmt; AgedVendorLedgEntry[4]."Remaining Amount")
                    {
                        AutoFormatExpression = "CurrencyCode";
                        AutoFormatType = 1;
                    }
                    column(AgedVendLedgEnt3RemAmt; AgedVendorLedgEntry[3]."Remaining Amount")
                    {
                        AutoFormatExpression = "CurrencyCode";
                        AutoFormatType = 1;
                    }
                    column(AgedVendLedgEnt2RemAmt; AgedVendorLedgEntry[2]."Remaining Amount")
                    {
                        AutoFormatExpression = "CurrencyCode";
                        AutoFormatType = 1;
                    }
                    column(AgedVendLedgEnt1RemAmt; AgedVendorLedgEntry[1]."Remaining Amount")
                    {
                        AutoFormatExpression = "CurrencyCode";
                        AutoFormatType = 1;
                    }
                    column(VLEEndingDateRemAmt; VendorLedgEntryEndingDate."Remaining Amount")
                    {
                        AutoFormatExpression = "CurrencyCode";
                        AutoFormatType = 1;
                    }
                    column(VendLedgEntryEndingDtAmt; VendorLedgEntryEndingDate.Amount)
                    {
                        AutoFormatExpression = "CurrencyCode";
                        AutoFormatType = 1;
                    }
                    column(TotalVendorName; STRSUBSTNO(Text005, Vendor."Name"))
                    {
                    }
                    column(CurrCode_TempVenLedgEntryLoop; "CurrencyCode")
                    {
                        AutoFormatExpression = "CurrencyCode";
                        AutoFormatType = 1;
                    }
                    column(CaPexAmt; CaPexAmt)
                    {
                    }
                    column(VLEERemainingAmt1; VLEE[1]."Remaining Amount")
                    {
                    }
                    column(ImpAmt; ImpAmt)
                    {
                    }
                    column(MediAmt; MediAmt)
                    {
                    }
                    column(MisAmt; MisAmt)
                    {
                    }
                    column(OtherGrainAmt; OtherGrainAmt)
                    {
                    }
                    column(ServiAmt; ServiAmt)
                    {
                    }
                    column(SoyaAmt; SoyaAmt)
                    {
                    }
                    column(NullAmt; NullAmt)
                    {
                    }
                    column(CapxAmt1Month; CapxAmt1Month)
                    {
                    }
                    column(CapxAmt2Month; CapxAmt2Month)
                    {
                    }
                    column(CapxAmt3Month; CapxAmt3Month)
                    {
                    }
                    column(CapxAmt4Month; CapxAmt4Month)
                    {
                    }
                    column(CapxAmt5Month; CapxAmt5Month)
                    {
                    }
                    column(SoyaAmt1Month; SoyaAmt1Month)
                    {
                    }
                    column(SoyaAmt2Month; SoyaAmt2Month)
                    {
                    }
                    column(SoyaAmt3Month; SoyaAmt3Month)
                    {
                    }
                    column(SoyaAmt4Month; SoyaAmt4Month)
                    {
                    }
                    column(SoyaAmt5Month; SoyaAmt5Month)
                    {
                    }
                    column(OtherGrainAmt1Month; OtherGrainAmt1Month)
                    {
                    }
                    column(OtherGrainAmt2Month; OtherGrainAmt2Month)
                    {
                    }
                    column(OtherGrainAmt3Month; OtherGrainAmt3Month)
                    {
                    }
                    column(OtherGrainAmt4Month; OtherGrainAmt4Month)
                    {
                    }
                    column(OtherGrainAmt5Month; OtherGrainAmt5Month)
                    {
                    }
                    column(MediAmt1Month; MediAmt1Month)
                    {
                    }
                    column(MediAmt2Month; MediAmt2Month)
                    {
                    }
                    column(MediAmt3Month; MediAmt3Month)
                    {
                    }
                    column(MediAmt4Month; MediAmt4Month)
                    {
                    }
                    column(MediAmt5Month; MediAmt5Month)
                    {
                    }
                    column(ServiceAmt1Month; ServiceAmt1Month)
                    {
                    }
                    column(ServiceAmt2Month; ServiceAmt2Month)
                    {
                    }
                    column(ServiceAmt3Month; ServiceAmt3Month)
                    {
                    }
                    column(ServiceAmt4Month; ServiceAmt4Month)
                    {
                    }
                    column(ServiceAmt5Month; ServiceAmt5Month)
                    {
                    }
                    column(ImportAmt1Month; ImportAmt1Month)
                    {
                    }
                    column(ImportAmt2Month; ImportAmt2Month)
                    {
                    }
                    column(ImportAmt3Month; ImportAmt3Month)
                    {
                    }
                    column(ImportAmt4Month; ImportAmt4Month)
                    {
                    }
                    column(ImportAmt5Month; ImportAmt5Month)
                    {
                    }
                    column(MiscAmt1Month; MiscAmt1Month)
                    {
                    }
                    column(MiscAmt2Month; MiscAmt2Month)
                    {
                    }
                    column(MiscAmt3Month; MiscAmt3Month)
                    {
                    }
                    column(MiscAmt4Month; MiscAmt4Month)
                    {
                    }
                    column(MiscAmt5Month; MiscAmt5Month)
                    {
                    }
                    column(NullAmt1Month; NullAmt1Month)
                    {
                    }
                    column(NullAmt2Month; NullAmt2Month)
                    {
                    }
                    column(NullAmt3Month; NullAmt3Month)
                    {
                    }
                    column(NullAmt4Month; NullAmt4Month)
                    {
                    }
                    column(NullAmt5Month; NullAmt5Month)
                    {
                    }
                    column(MaizeAmt; MaizeAmt)
                    {
                    }
                    column(MaizeAmt1Month; MaizeAmt1Month)
                    {
                    }
                    column(MaizeAmt2Month; MaizeAmt2Month)
                    {
                    }
                    column(MaizeAmt3Month; MaizeAmt3Month)
                    {
                    }
                    column(MaizeAmt4Month; MaizeAmt4Month)
                    {
                    }
                    column(MaizeAmt5Month; MaizeAmt5Month)
                    {
                    }
                    column(BajraAmt; BajraAmt)
                    {
                    }
                    column(BajraAmt1Month; BajraAmt1Month)
                    {
                    }
                    column(BajraAmt2Month; BajraAmt2Month)
                    {
                    }
                    column(BajraAmt3Month; BajraAmt3Month)
                    {
                    }
                    column(BajraAmt4Month; BajraAmt4Month)
                    {
                    }
                    column(BajraAmt5Month; BajraAmt5Month)
                    {
                    }
                    column(WheatAmt; WheatAmt)
                    {
                    }
                    column(WheatAmt1Month; WheatAmt1Month)
                    {
                    }
                    column(WheatAmt2Month; WheatAmt2Month)
                    {
                    }
                    column(WheatAmt3Month; WheatAmt3Month)
                    {
                    }
                    column(WheatAmt4Month; WheatAmt4Month)
                    {
                    }
                    column(WheatAmt5Month; WheatAmt5Month)
                    {
                    }
                    column(MustardAmt; MustardAmt)
                    {
                    }
                    column(MustardAmt1Month; MustardAmt1Month)
                    {
                    }
                    column(MustardAmt2Month; MustardAmt2Month)
                    {
                    }
                    column(MustardAmt3Month; MustardAmt3Month)
                    {
                    }
                    column(MustardAmt4Month; MustardAmt4Month)
                    {
                    }
                    column(MustardAmt5Month; MustardAmt5Month)
                    {
                    }
                    column(DDGSAmt; DDGSAmt)
                    {
                    }
                    column(DDGSAmt1Month; DDGSAmt1Month)
                    {
                    }
                    column(DDGSAmt2Month; DDGSAmt2Month)
                    {
                    }
                    column(DDGSAmt3Month; DDGSAmt3Month)
                    {
                    }
                    column(DDGSAmt4Month; DDGSAmt4Month)
                    {
                    }
                    column(DDGSAmt5Month; DDGSAmt5Month)
                    {
                    }
                    column(DeoiledRiceAmt; DeoiledRiceAmt)
                    {
                    }
                    column(DeoiledRiceAmt1Month; DeoiledRiceAmt1Month)
                    {
                    }
                    column(DeoiledRiceAmt2Month; DeoiledRiceAmt2Month)
                    {
                    }
                    column(DeoiledRiceAmt3Month; DeoiledRiceAmt3Month)
                    {
                    }
                    column(DeoiledRiceAmt4Month; DeoiledRiceAmt4Month)
                    {
                    }
                    column(DeoiledRiceAmt5Month; DeoiledRiceAmt5Month)
                    {
                    }
                    column(BirdsAmt; BirdsAmt)
                    {
                    }
                    column(BirdsAmt1Month; BirdsAmt1Month)
                    {
                    }
                    column(BirdsAmt2Month; BirdsAmt2Month)
                    {
                    }
                    column(BirdsAmt3Month; BirdsAmt3Month)
                    {
                    }
                    column(BirdsAmt4Month; BirdsAmt4Month)
                    {
                    }
                    column(BirdsAmt5Month; BirdsAmt5Month)
                    {
                    }
                    column(ChicksAmt; ChicksAmt)
                    {
                    }
                    column(ChicksAmt1Month; ChicksAmt1Month)
                    {
                    }
                    column(ChicksAmt2Month; ChicksAmt2Month)
                    {
                    }
                    column(ChicksAmt3Month; ChicksAmt3Month)
                    {
                    }
                    column(ChicksAmt4Month; ChicksAmt4Month)
                    {
                    }
                    column(ChicksAmt5Month; ChicksAmt5Month)
                    {
                    }
                    column(GenItemAmt; GenItemAmt)
                    {
                    }
                    column(GenItem1Month; GenItem1Month)
                    {
                    }
                    column(GenItem2Month; GenItem2Month)
                    {
                    }
                    column(GenItem3Month; GenItem3Month)
                    {
                    }
                    column(GenItem4Month; GenItem4Month)
                    {
                    }
                    column(GenItem5Month; GenItem5Month)
                    {
                    }
                    column(HatchingEggOutsideAmt; HatchingEggOutsideAmt)
                    {
                    }
                    column(HatchingEggOutside1Month; HatchingEggOutside1Month)
                    {
                    }
                    column(HatchingEggOutside2Month; HatchingEggOutside2Month)
                    {
                    }
                    column(HatchingEggOutside3Month; HatchingEggOutside3Month)
                    {
                    }
                    column(HatchingEggOutside4Month; HatchingEggOutside4Month)
                    {
                    }
                    column(HatchingEggOutside5Month; HatchingEggOutside5Month)
                    {
                    }
                    column(PremixAmt; PremixAmt)
                    {
                    }
                    column(Premix1Month; Premix1Month)
                    {
                    }
                    column(Premix2Month; Premix2Month)
                    {
                    }
                    column(Premix3Month; Premix3Month)
                    {
                    }
                    column(Premix4Month; Premix4Month)
                    {
                    }
                    column(Premix5Month; Premix5Month)
                    {
                    }
                    column(RiceBranOilAmt; RiceBranOilAmt)
                    {
                    }
                    column(RiceBranOil1Month; RiceBranOil1Month)
                    {
                    }
                    column(RiceBranOil2Month; RiceBranOil2Month)
                    {
                    }
                    column(RiceBranOil3Month; RiceBranOil3Month)
                    {
                    }
                    column(RiceBranOil4Month; RiceBranOil4Month)
                    {
                    }
                    column(RiceBranOil5Month; RiceBranOil5Month)
                    {
                    }
                    column(RiceBranPolishAmt; RiceBranPolishAmt)
                    {
                    }
                    column(RiceBranPolish1Month; RiceBranPolish1Month)
                    {
                    }
                    column(RiceBranPolish2Month; RiceBranPolish2Month)
                    {
                    }
                    column(RiceBranPolish3Month; RiceBranPolish3Month)
                    {
                    }
                    column(RiceBranPolish4Month; RiceBranPolish4Month)
                    {
                    }
                    column(RiceBranPolish5Month; RiceBranPolish5Month)
                    {
                    }
                    column(RiceKanniAmt; RiceKanniAmt)
                    {
                    }
                    column(RiceKanni1Month; RiceKanni1Month)
                    {
                    }
                    column(RiceKanni2Month; RiceKanni2Month)
                    {
                    }
                    column(RiceKanni3Month; RiceKanni3Month)
                    {
                    }
                    column(RiceKanni4Month; RiceKanni4Month)
                    {
                    }
                    column(RiceKanni5Month; RiceKanni5Month)
                    {
                    }
                    column(LimeStonePowerAmt; LimeStonePowerAmt)
                    {
                    }
                    column(LimeStonePower1Month; LimeStonePower1Month)
                    {
                    }
                    column(LimeStonePower2Month; LimeStonePower2Month)
                    {
                    }
                    column(LimeStonePower3Month; LimeStonePower3Month)
                    {
                    }
                    column(LimeStonePower4Month; LimeStonePower4Month)
                    {
                    }
                    column(LimeStonePower5Month; LimeStonePower5Month)
                    {
                    }
                    column(GaurMealAmt; GaurMealAmt)
                    {
                    }
                    column(GaurMeal1Month; GaurMeal1Month)
                    {
                    }
                    column(GaurMeal2Month; GaurMeal2Month)
                    {
                    }
                    column(GaurMeal3Month; GaurMeal3Month)
                    {
                    }
                    column(GaurMeal4Month; GaurMeal4Month)
                    {
                    }
                    column(GaurMeal5Month; GaurMeal5Month)
                    {
                    }
                    column(ChickenWasteMealAmt; ChickenWasteMealAmt)
                    {
                    }
                    column(ChickenWasteMeal1Month; ChickenWasteMeal1Month)
                    {
                    }
                    column(ChickenWasteMeal2Month; ChickenWasteMeal2Month)
                    {
                    }
                    column(ChickenWasteMeal3Month; ChickenWasteMeal3Month)
                    {
                    }
                    column(ChickenWasteMeal4Month; ChickenWasteMeal4Month)
                    {
                    }
                    column(ChickenWasteMeal5Month; ChickenWasteMeal5Month)
                    {
                    }
                    column(PPBagsAmt; PPBagsAmt)
                    {
                    }
                    column(PPBags1Month; PPBags1Month)
                    {
                    }
                    column(PPBags2Month; PPBags2Month)
                    {
                    }
                    column(PPBags3Month; PPBags3Month)
                    {
                    }
                    column(PPBags4Month; PPBags4Month)
                    {
                    }
                    column(PPBags5Month; PPBags5Month)
                    {
                    }
                    column(OtherAmt; OtherAmt)
                    {
                    }
                    column(Other1Month; Other1Month)
                    {
                    }
                    column(Other2Month; Other2Month)
                    {
                    }
                    column(Other3Month; Other3Month)
                    {
                    }
                    column(Other4Month; Other4Month)
                    {
                    }
                    column(Other5Month; Other5Month)
                    {
                    }

                    trigger OnAfterGetRecord()
                    var
                        PeriodIndex: Integer;
                    begin
                        IF Number = 1 THEN BEGIN
                            IF NOT TempVendorLedgEntry.FINDSET(FALSE, FALSE) THEN
                                CurrReport.BREAK;
                        END ELSE
                            IF TempVendorLedgEntry.NEXT = 0 THEN
                                CurrReport.BREAK;

                        VendorLedgEntryEndingDate := TempVendorLedgEntry;

                        DetailedVendorLedgerEntry.SETRANGE("Vendor Ledger Entry No.", VendorLedgEntryEndingDate."Entry No.");
                        IF DetailedVendorLedgerEntry.FINDSET(FALSE, FALSE) THEN
                            REPEAT
                                IF (DetailedVendorLedgerEntry."Entry Type" =
                                    DetailedVendorLedgerEntry."Entry Type"::"Initial Entry") AND
                                   (VendorLedgEntryEndingDate."Posting Date" > EndingDate) AND
                                   (AgingBy <> AgingBy::"Posting Date")
                                THEN BEGIN
                                    IF VendorLedgEntryEndingDate."Document Date" <= EndingDate THEN
                                        ////DetailedVendorLedgerEntry."Posting Date" :=  ////PRU-VG Commented standard code for Document No. F-PPI/1920/1703
                                        ///VendorLedgEntryEndingDate."Document Date"////PRU-VG Commented standard code for Document No. F-PPI/1920/1703
                                        DetailedVendorLedgerEntry."Posting Date" := ////PRU-VG Commented standard code for Document No. F-PPI/1920/1703
                                  VendorLedgEntryEndingDate."Posting Date"  ////PRU-VG Commented standard code for Document No. F-PPI/1920/1703
                                    ELSE
                                        IF (VendorLedgEntryEndingDate."Due Date" <= EndingDate) AND
                                           (AgingBy = AgingBy::"Due Date")
                                        THEN
                                            DetailedVendorLedgerEntry."Posting Date" :=
                                              VendorLedgEntryEndingDate."Due Date"
                                END;

                                IF (DetailedVendorLedgerEntry."Posting Date" <= EndingDate) OR
                                   (TempVendorLedgEntry.Open AND
                                    (AgingBy = AgingBy::"Due Date") AND
                                    (VendorLedgEntryEndingDate."Due Date" > EndingDate) AND
                                    (VendorLedgEntryEndingDate."Posting Date" <= EndingDate))
                                THEN BEGIN
                                    IF DetailedVendorLedgerEntry."Entry Type" IN
                                       [DetailedVendorLedgerEntry."Entry Type"::"Initial Entry",
                                        DetailedVendorLedgerEntry."Entry Type"::"Unrealized Loss",
                                        DetailedVendorLedgerEntry."Entry Type"::"Unrealized Gain",
                                        DetailedVendorLedgerEntry."Entry Type"::"Realized Loss",
                                        DetailedVendorLedgerEntry."Entry Type"::"Realized Gain",
                                        DetailedVendorLedgerEntry."Entry Type"::"Payment Discount",
                                        DetailedVendorLedgerEntry."Entry Type"::"Payment Discount (VAT Excl.)",
                                        DetailedVendorLedgerEntry."Entry Type"::"Payment Discount (VAT Adjustment)",
                                        DetailedVendorLedgerEntry."Entry Type"::"Payment Tolerance",
                                        DetailedVendorLedgerEntry."Entry Type"::"Payment Discount Tolerance",
                                        DetailedVendorLedgerEntry."Entry Type"::"Payment Tolerance (VAT Excl.)",
                                        DetailedVendorLedgerEntry."Entry Type"::"Payment Tolerance (VAT Adjustment)",
                                        DetailedVendorLedgerEntry."Entry Type"::"Payment Discount Tolerance (VAT Excl.)",
                                        DetailedVendorLedgerEntry."Entry Type"::"Payment Discount Tolerance (VAT Adjustment)"]
                                    THEN BEGIN
                                        VendorLedgEntryEndingDate."Amount" := VendorLedgEntryEndingDate."Amount" + DetailedVendorLedgerEntry."Amount";
                                        VendorLedgEntryEndingDate."Amount (LCY)" :=
                                          VendorLedgEntryEndingDate."Amount (LCY)" + DetailedVendorLedgerEntry."Amount (LCY)";
                                    END;
                                    IF DetailedVendorLedgerEntry."Posting Date" <= EndingDate THEN BEGIN
                                        VendorLedgEntryEndingDate."Remaining Amount" :=
                                          VendorLedgEntryEndingDate."Remaining Amount" + DetailedVendorLedgerEntry."Amount";
                                        VendorLedgEntryEndingDate."Remaining Amt. (LCY)" :=
                                          VendorLedgEntryEndingDate."Remaining Amt. (LCY)" + DetailedVendorLedgerEntry."Amount (LCY)";
                                    END;
                                END;
                            UNTIL DetailedVendorLedgerEntry.NEXT = 0;

                        IF VendorLedgEntryEndingDate."Remaining Amount" = 0 THEN
                            CurrReport.SKIP;

                        CASE AgingBy OF
                            AgingBy::"Due Date":
                                PeriodIndex := GetPeriodIndex(VendorLedgEntryEndingDate."Due Date");
                            AgingBy::"Posting Date":
                                PeriodIndex := GetPeriodIndex(VendorLedgEntryEndingDate."Posting Date");
                            AgingBy::"Document Date":
                                BEGIN
                                    IF VendorLedgEntryEndingDate."Document Date" > EndingDate THEN BEGIN
                                        VendorLedgEntryEndingDate."Remaining Amount" := 0;
                                        VendorLedgEntryEndingDate."Remaining Amt. (LCY)" := 0;
                                        VendorLedgEntryEndingDate."Document Date" := VendorLedgEntryEndingDate."Posting Date";
                                    END;
                                    PeriodIndex := GetPeriodIndex(VendorLedgEntryEndingDate."Document Date");
                                END;
                        END;
                        CLEAR(AgedVendorLedgEntry);
                        AgedVendorLedgEntry[PeriodIndex]."Remaining Amount" := VendorLedgEntryEndingDate."Remaining Amount";
                        AgedVendorLedgEntry[PeriodIndex]."Remaining Amt. (LCY)" := VendorLedgEntryEndingDate."Remaining Amt. (LCY)";
                        TotalVendorLedgEntry[PeriodIndex]."Remaining Amount" += VendorLedgEntryEndingDate."Remaining Amount";
                        TotalVendorLedgEntry[PeriodIndex]."Remaining Amt. (LCY)" += VendorLedgEntryEndingDate."Remaining Amt. (LCY)";
                        GrandTotalVLERemaingAmtLCY[PeriodIndex] += VendorLedgEntryEndingDate."Remaining Amt. (LCY)";
                        TotalVendorLedgEntry[1]."Amount" += VendorLedgEntryEndingDate."Remaining Amount";
                        TotalVendorLedgEntry[1]."Amount (LCY)" += VendorLedgEntryEndingDate."Remaining Amt. (LCY)";
                        GrandTotalVLEAmtLCY += VendorLedgEntryEndingDate."Remaining Amt. (LCY)";

                        /*VendorLedgEntryEndingDate.SETRANGE("Creditors Type",VendorLedgEntryEndingDate."Creditors Type"::"CAPEX CREDITORS");
                        IF VendorLedgEntryEndingDate.FINDSET THEN
                        VLEE[1]."Remaining Amount" += VendorLedgEntryEndingDate."Remaining Amount";*/

                    end;

                    trigger OnPostDataItem()
                    begin
                        IF NOT PrintAmountInLCY THEN
                            UpdateCurrencyTotals;
                    end;

                    trigger OnPreDataItem()
                    begin
                        IF NOT PrintAmountInLCY THEN
                            TempVendorLedgEntry.SETRANGE("Currency Code", TempCurrency."Code");
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    CLEAR(TotalVendorLedgEntry);

                    IF Number = 1 THEN BEGIN
                        IF NOT TempCurrency.FINDSET(FALSE, FALSE) THEN
                            CurrReport.BREAK;
                    END ELSE
                        IF TempCurrency.NEXT = 0 THEN
                            CurrReport.BREAK;

                    IF TempCurrency."Code" <> '' THEN
                        "CurrencyCode" := TempCurrency."Code"
                    ELSE
                        "CurrencyCode" := GLSetup."LCY Code";

                    NumberOfCurrencies := NumberOfCurrencies + 1;
                end;

                trigger OnPostDataItem()
                begin
                    IF NewPagePerVendor AND (NumberOfCurrencies > 0) THEN
                        CurrReport.NEWPAGE;
                end;

                trigger OnPreDataItem()
                begin
                    NumberOfCurrencies := 0;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                IF NewPagePerVendor THEN
                    PageGroupNo := PageGroupNo + 1;

                TempCurrency.RESET;
                TempCurrency.DELETEALL;
                TempVendorLedgEntry.RESET;
                TempVendorLedgEntry.DELETEALL;
                CLEAR(GrandTotalVLERemaingAmtLCY);
                GrandTotalVLEAmtLCY := 0;

                CompanyInfo.CALCFIELDS(Picture);
                //MESSAGE('%1..%2..%3..%4..%5..%6..%7..%8..%9..%10',PeriodStartDate[1],PeriodEndDate[1],PeriodStartDate[2],PeriodEndDate[2],PeriodStartDate[3],PeriodEndDate[3],
                //PeriodStartDate[4],PeriodEndDate[4],PeriodStartDate[5],PeriodEndDate[5]);
                //PruRaj
                VLE.RESET;
                VLE.SETRANGE("Vendor No.", Vendor."No.");
                VLE.SETRANGE("Creditors Type", VLE."Creditors Type"::"CAPEX CREDITORS");
                VLE.SETFILTER("Posting Date", '<=%1', EndingDate);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS("Remaining Amount");
                        CaPexAmt += VLE."Remaining Amount";
                    UNTIL VLE.NEXT = 0;

                VLE.RESET;
                VLE.SETRANGE("Vendor No.", Vendor."No.");
                VLE.SETRANGE("Creditors Type", VLE."Creditors Type"::"IMPORT CREDITORS");
                VLE.SETFILTER("Posting Date", '<=%1', EndingDate);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS("Remaining Amount");
                        ImpAmt += VLE."Remaining Amount";
                    UNTIL VLE.NEXT = 0;

                VLE.RESET;
                VLE.SETRANGE("Vendor No.", Vendor."No.");
                VLE.SETRANGE("Creditors Type", VLE."Creditors Type"::"MEDICINE CREDITORS");
                VLE.SETFILTER("Posting Date", '<=%1', EndingDate);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS("Remaining Amount");
                        MediAmt += VLE."Remaining Amount";
                    UNTIL VLE.NEXT = 0;

                VLE.RESET;
                VLE.SETRANGE("Vendor No.", Vendor."No.");
                VLE.SETRANGE("Creditors Type", VLE."Creditors Type"::"MISCELLANEOUS CREDITORS");
                VLE.SETFILTER("Posting Date", '<=%1', EndingDate);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS("Remaining Amount");
                        MisAmt += VLE."Remaining Amount";
                    UNTIL VLE.NEXT = 0;

                VLE.RESET;
                VLE.SETRANGE("Vendor No.", Vendor."No.");
                VLE.SETRANGE("Creditors Type", VLE."Creditors Type"::"OTHER GRAIN CREDITORS");
                VLE.SETFILTER("Posting Date", '<=%1', EndingDate);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS("Remaining Amount");
                        OtherGrainAmt += VLE."Remaining Amount";
                    UNTIL VLE.NEXT = 0;

                VLE.RESET;
                VLE.SETRANGE("Vendor No.", Vendor."No.");
                VLE.SETRANGE("Creditors Type", VLE."Creditors Type"::"SERVICE CREDITORS");
                VLE.SETFILTER("Posting Date", '<=%1', EndingDate);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS("Remaining Amount");
                        ServiAmt += VLE."Remaining Amount";
                    UNTIL VLE.NEXT = 0;

                VLE.RESET;
                VLE.SETRANGE("Vendor No.", Vendor."No.");
                VLE.SETRANGE("Creditors Type", VLE."Creditors Type"::"SOYA CREDITORS");
                VLE.SETFILTER("Posting Date", '<=%1', EndingDate);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS("Remaining Amount");
                        SoyaAmt += VLE."Remaining Amount";
                    UNTIL VLE.NEXT = 0;

                VLE.RESET;
                VLE.SETRANGE("Vendor No.", Vendor."No.");
                VLE.SETRANGE("Creditors Type", VLE."Creditors Type"::" ");
                VLE.SETFILTER("Posting Date", '<=%1', EndingDate);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS("Remaining Amount");
                        NullAmt += VLE."Remaining Amount";
                    UNTIL VLE.NEXT = 0;

                //as on 051219 PruRaj
                VLE.RESET;
                VLE.SETRANGE("Vendor No.", Vendor."No.");
                VLE.SETRANGE("Creditors Type", VLE."Creditors Type"::"Maize Creditors");
                VLE.SETFILTER("Posting Date", '<=%1', EndingDate);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS("Remaining Amount");
                        MaizeAmt += VLE."Remaining Amount";
                    UNTIL VLE.NEXT = 0;

                VLE.RESET;
                VLE.SETRANGE("Vendor No.", Vendor."No.");
                VLE.SETRANGE("Creditors Type", VLE."Creditors Type"::"BAJRA Creditors");
                VLE.SETFILTER("Posting Date", '<=%1', EndingDate);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS("Remaining Amount");
                        BajraAmt += VLE."Remaining Amount";
                    UNTIL VLE.NEXT = 0;

                VLE.RESET;
                VLE.SETRANGE("Vendor No.", Vendor."No.");
                VLE.SETRANGE("Creditors Type", VLE."Creditors Type"::"Wheat Creditors");
                VLE.SETFILTER("Posting Date", '<=%1', EndingDate);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS("Remaining Amount");
                        WheatAmt += VLE."Remaining Amount";
                    UNTIL VLE.NEXT = 0;

                VLE.RESET;
                VLE.SETRANGE("Vendor No.", Vendor."No.");
                VLE.SETRANGE("Creditors Type", VLE."Creditors Type"::"Mustard DOC Creditors");
                VLE.SETFILTER("Posting Date", '<=%1', EndingDate);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS("Remaining Amount");
                        MustardAmt += VLE."Remaining Amount";
                    UNTIL VLE.NEXT = 0;

                VLE.RESET;
                VLE.SETRANGE("Vendor No.", Vendor."No.");
                VLE.SETRANGE("Creditors Type", VLE."Creditors Type"::"D.D.G.S Creditors");
                VLE.SETFILTER("Posting Date", '<=%1', EndingDate);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS("Remaining Amount");
                        DDGSAmt += VLE."Remaining Amount";
                    UNTIL VLE.NEXT = 0;

                VLE.RESET;
                VLE.SETRANGE("Vendor No.", Vendor."No.");
                VLE.SETRANGE("Creditors Type", VLE."Creditors Type"::"DEOILED RICE BRAN Creditors");
                VLE.SETFILTER("Posting Date", '<=%1', EndingDate);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS("Remaining Amount");
                        DeoiledRiceAmt += VLE."Remaining Amount";
                    UNTIL VLE.NEXT = 0;

                //PRU_NEELESH 07012020

                VLE.RESET;
                VLE.SETRANGE("Vendor No.", Vendor."No.");
                VLE.SETRANGE("Creditors Type", VLE."Creditors Type"::"Birds Creditor");
                VLE.SETFILTER("Posting Date", '<=%1', EndingDate);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS("Remaining Amount");
                        BirdsAmt += VLE."Remaining Amount";
                    UNTIL VLE.NEXT = 0;

                VLE.RESET;
                VLE.SETRANGE("Vendor No.", Vendor."No.");
                VLE.SETRANGE("Creditors Type", VLE."Creditors Type"::"Chicks Creditor");
                VLE.SETFILTER("Posting Date", '<=%1', EndingDate);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS("Remaining Amount");
                        ChicksAmt += VLE."Remaining Amount";
                    UNTIL VLE.NEXT = 0;

                VLE.RESET;
                VLE.SETRANGE("Vendor No.", Vendor."No.");
                VLE.SETRANGE("Creditors Type", VLE."Creditors Type"::"Gen Item");
                VLE.SETFILTER("Posting Date", '<=%1', EndingDate);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS("Remaining Amount");
                        GenItemAmt += VLE."Remaining Amount";
                    UNTIL VLE.NEXT = 0;

                VLE.RESET;
                VLE.SETRANGE("Vendor No.", Vendor."No.");
                VLE.SETRANGE("Creditors Type", VLE."Creditors Type"::"Hatching Egg Outside");
                VLE.SETFILTER("Posting Date", '<=%1', EndingDate);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS("Remaining Amount");
                        HatchingEggOutsideAmt += VLE."Remaining Amount";
                    UNTIL VLE.NEXT = 0;

                VLE.RESET;
                VLE.SETRANGE("Vendor No.", Vendor."No.");
                VLE.SETRANGE("Creditors Type", VLE."Creditors Type"::Premix);
                VLE.SETFILTER("Posting Date", '<=%1', EndingDate);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS("Remaining Amount");
                        PremixAmt += VLE."Remaining Amount";
                    UNTIL VLE.NEXT = 0;

                VLE.RESET;
                VLE.SETRANGE("Vendor No.", Vendor."No.");
                VLE.SETRANGE("Creditors Type", VLE."Creditors Type"::"Rice Bran Oil");
                VLE.SETFILTER("Posting Date", '<=%1', EndingDate);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS("Remaining Amount");
                        RiceBranOilAmt += VLE."Remaining Amount";
                    UNTIL VLE.NEXT = 0;

                VLE.RESET;
                VLE.SETRANGE("Vendor No.", Vendor."No.");
                VLE.SETRANGE("Creditors Type", VLE."Creditors Type"::"Rice Bran Polish");
                VLE.SETFILTER("Posting Date", '<=%1', EndingDate);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS("Remaining Amount");
                        RiceBranPolishAmt += VLE."Remaining Amount";
                    UNTIL VLE.NEXT = 0;

                VLE.RESET;
                VLE.SETRANGE("Vendor No.", Vendor."No.");
                VLE.SETRANGE("Creditors Type", VLE."Creditors Type"::"Rice Kanni");
                VLE.SETFILTER("Posting Date", '<=%1', EndingDate);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS("Remaining Amount");
                        RiceKanniAmt += VLE."Remaining Amount";
                    UNTIL VLE.NEXT = 0;

                VLE.RESET;
                VLE.SETRANGE("Vendor No.", Vendor."No.");
                VLE.SETRANGE("Creditors Type", VLE."Creditors Type"::"Lime Stone Power");
                VLE.SETFILTER("Posting Date", '<=%1', EndingDate);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS("Remaining Amount");
                        LimeStonePowerAmt += VLE."Remaining Amount";
                    UNTIL VLE.NEXT = 0;

                VLE.RESET;
                VLE.SETRANGE("Vendor No.", Vendor."No.");
                VLE.SETRANGE("Creditors Type", VLE."Creditors Type"::"Gaur Meal");
                VLE.SETFILTER("Posting Date", '<=%1', EndingDate);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS("Remaining Amount");
                        GaurMealAmt += VLE."Remaining Amount";
                    UNTIL VLE.NEXT = 0;

                VLE.RESET;
                VLE.SETRANGE("Vendor No.", Vendor."No.");
                VLE.SETRANGE("Creditors Type", VLE."Creditors Type"::"Chicken Waste Meal");
                VLE.SETFILTER("Posting Date", '<=%1', EndingDate);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS("Remaining Amount");
                        ChickenWasteMealAmt += VLE."Remaining Amount";
                    UNTIL VLE.NEXT = 0;

                VLE.RESET;
                VLE.SETRANGE("Vendor No.", Vendor."No.");
                VLE.SETRANGE("Creditors Type", VLE."Creditors Type"::"P.P Bags");
                VLE.SETFILTER("Posting Date", '<=%1', EndingDate);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS("Remaining Amount");
                        PPBagsAmt += VLE."Remaining Amount";
                    UNTIL VLE.NEXT = 0;

                VLE.RESET;
                VLE.SETRANGE("Vendor No.", Vendor."No.");
                VLE.SETRANGE("Creditors Type", VLE."Creditors Type"::"Other");
                VLE.SETFILTER("Posting Date", '<=%1', EndingDate);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS("Remaining Amount");
                        OtherAmt += VLE."Remaining Amount";
                    UNTIL VLE.NEXT = 0;

                //PRU_NEELESH 07012020
                //as on 051219 PruRaj

                //Capx Creditor
                VLE.RESET;
                VLE.SETRANGE("Vendor No.", Vendor."No.");
                VLE.SETRANGE("Creditors Type", VLE."Creditors Type"::"CAPEX CREDITORS");
                VLE.SETRANGE("Due Date", PeriodStartDate[1], PeriodEndDate[1]);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS("Remaining Amount");
                        DueCapxAmt += VLE."Remaining Amount";
                    UNTIL VLE.NEXT = 0;

                VLE.RESET;
                VLE.SETRANGE("Vendor No.", Vendor."No.");
                VLE.SETRANGE("Creditors Type", VLE."Creditors Type"::"CAPEX CREDITORS");
                VLE.SETRANGE("Due Date", PeriodStartDate[2], PeriodEndDate[2]);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS("Remaining Amount");
                        CapxAmt2Month += VLE."Remaining Amount";
                    UNTIL VLE.NEXT = 0;

                VLE.RESET;
                VLE.SETRANGE("Vendor No.", Vendor."No.");
                VLE.SETRANGE("Creditors Type", VLE."Creditors Type"::"CAPEX CREDITORS");
                VLE.SETRANGE("Due Date", PeriodStartDate[3], PeriodEndDate[3]);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS("Remaining Amount");
                        CapxAmt3Month += VLE."Remaining Amount";
                    UNTIL VLE.NEXT = 0;

                VLE.RESET;
                VLE.SETRANGE("Vendor No.", Vendor."No.");
                VLE.SETRANGE("Creditors Type", VLE."Creditors Type"::"CAPEX CREDITORS");
                VLE.SETRANGE("Due Date", PeriodStartDate[4], PeriodEndDate[4]);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS("Remaining Amount");
                        CapxAmt4Month += VLE."Remaining Amount";
                    UNTIL VLE.NEXT = 0;

                VLE.RESET;
                VLE.SETRANGE("Vendor No.", Vendor."No.");
                VLE.SETRANGE("Creditors Type", VLE."Creditors Type"::"CAPEX CREDITORS");
                VLE.SETRANGE("Due Date", PeriodStartDate[5], PeriodEndDate[5]);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS("Remaining Amount");
                        CapxAmt5Month += VLE."Remaining Amount";
                    UNTIL VLE.NEXT = 0;

                //SOYA Creditors
                VLE.RESET;
                VLE.SETRANGE("Vendor No.", Vendor."No.");
                VLE.SETRANGE("Creditors Type", VLE."Creditors Type"::"SOYA CREDITORS");
                VLE.SETRANGE("Due Date", PeriodStartDate[1], PeriodEndDate[1]);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS("Remaining Amount");
                        SoyaAmt1Month += VLE."Remaining Amount";
                    UNTIL VLE.NEXT = 0;

                VLE.RESET;
                VLE.SETRANGE("Vendor No.", Vendor."No.");
                VLE.SETRANGE("Creditors Type", VLE."Creditors Type"::"SOYA CREDITORS");
                VLE.SETRANGE("Due Date", PeriodStartDate[2], PeriodEndDate[2]);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS("Remaining Amount");
                        SoyaAmt2Month += VLE."Remaining Amount";
                    UNTIL VLE.NEXT = 0;

                VLE.RESET;
                VLE.SETRANGE("Vendor No.", Vendor."No.");
                VLE.SETRANGE("Creditors Type", VLE."Creditors Type"::"SOYA CREDITORS");
                VLE.SETRANGE("Due Date", PeriodStartDate[3], PeriodEndDate[3]);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS("Remaining Amount");
                        SoyaAmt3Month += VLE."Remaining Amount";
                    UNTIL VLE.NEXT = 0;

                VLE.RESET;
                VLE.SETRANGE("Vendor No.", Vendor."No.");
                VLE.SETRANGE("Creditors Type", VLE."Creditors Type"::"SOYA CREDITORS");
                VLE.SETRANGE("Due Date", PeriodStartDate[4], PeriodEndDate[4]);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS("Remaining Amount");
                        SoyaAmt4Month += VLE."Remaining Amount";
                    UNTIL VLE.NEXT = 0;

                VLE.RESET;
                VLE.SETRANGE("Vendor No.", Vendor."No.");
                VLE.SETRANGE("Creditors Type", VLE."Creditors Type"::"SOYA CREDITORS");
                VLE.SETRANGE("Due Date", PeriodStartDate[5], PeriodEndDate[5]);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS("Remaining Amount");
                        SoyaAmt5Month += VLE."Remaining Amount";
                    UNTIL VLE.NEXT = 0;

                //Other Grain Creditor
                VLE.RESET;
                VLE.SETRANGE("Vendor No.", Vendor."No.");
                VLE.SETRANGE("Creditors Type", VLE."Creditors Type"::"OTHER GRAIN CREDITORS");
                VLE.SETRANGE("Due Date", PeriodStartDate[1], PeriodEndDate[1]);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS("Remaining Amount");
                        OtherGrainAmt1Month += VLE."Remaining Amount";
                    UNTIL VLE.NEXT = 0;

                VLE.RESET;
                VLE.SETRANGE("Vendor No.", Vendor."No.");
                VLE.SETRANGE("Creditors Type", VLE."Creditors Type"::"OTHER GRAIN CREDITORS");
                VLE.SETRANGE("Due Date", PeriodStartDate[2], PeriodEndDate[2]);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS("Remaining Amount");
                        OtherGrainAmt2Month += VLE."Remaining Amount";
                    UNTIL VLE.NEXT = 0;

                VLE.RESET;
                VLE.SETRANGE("Vendor No.", Vendor."No.");
                VLE.SETRANGE("Creditors Type", VLE."Creditors Type"::"OTHER GRAIN CREDITORS");
                VLE.SETRANGE("Due Date", PeriodStartDate[3], PeriodEndDate[3]);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS("Remaining Amount");
                        OtherGrainAmt3Month += VLE."Remaining Amount";
                    UNTIL VLE.NEXT = 0;

                VLE.RESET;
                VLE.SETRANGE("Vendor No.", Vendor."No.");
                VLE.SETRANGE("Creditors Type", VLE."Creditors Type"::"OTHER GRAIN CREDITORS");
                VLE.SETRANGE("Due Date", PeriodStartDate[4], PeriodEndDate[4]);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS("Remaining Amount");
                        OtherGrainAmt4Month += VLE."Remaining Amount";
                    UNTIL VLE.NEXT = 0;

                VLE.RESET;
                VLE.SETRANGE("Vendor No.", Vendor."No.");
                VLE.SETRANGE("Creditors Type", VLE."Creditors Type"::"OTHER GRAIN CREDITORS");
                VLE.SETRANGE("Due Date", PeriodStartDate[5], PeriodEndDate[5]);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS("Remaining Amount");
                        OtherGrainAmt5Month += VLE."Remaining Amount";
                    UNTIL VLE.NEXT = 0;

                //Medicine Creditors
                VLE.RESET;
                VLE.SETRANGE("Vendor No.", Vendor."No.");
                VLE.SETRANGE("Creditors Type", VLE."Creditors Type"::"MEDICINE CREDITORS");
                VLE.SETRANGE("Due Date", PeriodStartDate[1], PeriodEndDate[1]);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS("Remaining Amount");
                        MediAmt1Month += VLE."Remaining Amount";
                    UNTIL VLE.NEXT = 0;

                VLE.RESET;
                VLE.SETRANGE("Vendor No.", Vendor."No.");
                VLE.SETRANGE("Creditors Type", VLE."Creditors Type"::"MEDICINE CREDITORS");
                VLE.SETRANGE("Due Date", PeriodStartDate[2], PeriodEndDate[2]);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS("Remaining Amount");
                        MediAmt2Month += VLE."Remaining Amount";
                    UNTIL VLE.NEXT = 0;

                VLE.RESET;
                VLE.SETRANGE("Vendor No.", Vendor."No.");
                VLE.SETRANGE("Creditors Type", VLE."Creditors Type"::"MEDICINE CREDITORS");
                VLE.SETRANGE("Due Date", PeriodStartDate[3], PeriodEndDate[3]);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS("Remaining Amount");
                        MediAmt3Month += VLE."Remaining Amount";
                    UNTIL VLE.NEXT = 0;

                VLE.RESET;
                VLE.SETRANGE("Vendor No.", Vendor."No.");
                VLE.SETRANGE("Creditors Type", VLE."Creditors Type"::"MEDICINE CREDITORS");
                VLE.SETRANGE("Due Date", PeriodStartDate[4], PeriodEndDate[4]);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS("Remaining Amount");
                        MediAmt4Month += VLE."Remaining Amount";
                    UNTIL VLE.NEXT = 0;

                VLE.RESET;
                VLE.SETRANGE("Vendor No.", Vendor."No.");
                VLE.SETRANGE("Creditors Type", VLE."Creditors Type"::"MEDICINE CREDITORS");
                VLE.SETRANGE("Due Date", PeriodStartDate[5], PeriodEndDate[5]);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS("Remaining Amount");
                        MediAmt5Month += VLE."Remaining Amount";
                    UNTIL VLE.NEXT = 0;

                //Service Creditors
                VLE.RESET;
                VLE.SETRANGE("Vendor No.", Vendor."No.");
                VLE.SETRANGE("Creditors Type", VLE."Creditors Type"::"SERVICE CREDITORS");
                VLE.SETRANGE("Due Date", PeriodStartDate[1], PeriodEndDate[1]);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS("Remaining Amount");
                        ServiceAmt1Month += VLE."Remaining Amount";
                    UNTIL VLE.NEXT = 0;

                VLE.RESET;
                VLE.SETRANGE("Vendor No.", Vendor."No.");
                VLE.SETRANGE("Creditors Type", VLE."Creditors Type"::"SERVICE CREDITORS");
                VLE.SETRANGE("Due Date", PeriodStartDate[2], PeriodEndDate[2]);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS("Remaining Amount");
                        ServiceAmt2Month += VLE."Remaining Amount";
                    UNTIL VLE.NEXT = 0;

                VLE.RESET;
                VLE.SETRANGE("Vendor No.", Vendor."No.");
                VLE.SETRANGE("Creditors Type", VLE."Creditors Type"::"SERVICE CREDITORS");
                VLE.SETRANGE("Due Date", PeriodStartDate[3], PeriodEndDate[3]);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS("Remaining Amount");
                        ServiceAmt3Month += VLE."Remaining Amount";
                    UNTIL VLE.NEXT = 0;

                VLE.RESET;
                VLE.SETRANGE("Vendor No.", Vendor."No.");
                VLE.SETRANGE("Creditors Type", VLE."Creditors Type"::"SERVICE CREDITORS");
                VLE.SETRANGE("Due Date", PeriodStartDate[4], PeriodEndDate[4]);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS("Remaining Amount");
                        ServiceAmt4Month += VLE."Remaining Amount";
                    UNTIL VLE.NEXT = 0;

                VLE.RESET;
                VLE.SETRANGE("Vendor No.", Vendor."No.");
                VLE.SETRANGE("Creditors Type", VLE."Creditors Type"::"SERVICE CREDITORS");
                VLE.SETRANGE("Due Date", PeriodStartDate[5], PeriodEndDate[5]);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS("Remaining Amount");
                        ServiceAmt5Month += VLE."Remaining Amount";
                    UNTIL VLE.NEXT = 0;

                //Import Creditors
                VLE.RESET;
                VLE.SETRANGE("Vendor No.", Vendor."No.");
                VLE.SETRANGE("Creditors Type", VLE."Creditors Type"::"IMPORT CREDITORS");
                VLE.SETRANGE("Due Date", PeriodStartDate[1], PeriodEndDate[1]);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS("Remaining Amount");
                        ImportAmt1Month += VLE."Remaining Amount";
                    UNTIL VLE.NEXT = 0;

                VLE.RESET;
                VLE.SETRANGE("Vendor No.", Vendor."No.");
                VLE.SETRANGE("Creditors Type", VLE."Creditors Type"::"IMPORT CREDITORS");
                VLE.SETRANGE("Due Date", PeriodStartDate[2], PeriodEndDate[2]);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS("Remaining Amount");
                        ImportAmt2Month += VLE."Remaining Amount";
                    UNTIL VLE.NEXT = 0;

                VLE.RESET;
                VLE.SETRANGE("Vendor No.", Vendor."No.");
                VLE.SETRANGE("Creditors Type", VLE."Creditors Type"::"IMPORT CREDITORS");
                VLE.SETRANGE("Due Date", PeriodStartDate[3], PeriodEndDate[3]);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS("Remaining Amount");
                        ImportAmt3Month += VLE."Remaining Amount";
                    UNTIL VLE.NEXT = 0;


                VLE.RESET;
                VLE.SETRANGE("Vendor No.", Vendor."No.");
                VLE.SETRANGE("Creditors Type", VLE."Creditors Type"::"IMPORT CREDITORS");
                VLE.SETRANGE("Due Date", PeriodStartDate[4], PeriodEndDate[4]);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS("Remaining Amount");
                        ImportAmt4Month += VLE."Remaining Amount";
                    UNTIL VLE.NEXT = 0;

                VLE.RESET;
                VLE.SETRANGE("Vendor No.", Vendor."No.");
                VLE.SETRANGE("Creditors Type", VLE."Creditors Type"::"IMPORT CREDITORS");
                VLE.SETRANGE("Due Date", PeriodStartDate[5], PeriodEndDate[5]);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS("Remaining Amount");
                        ImportAmt5Month += VLE."Remaining Amount";
                    UNTIL VLE.NEXT = 0;

                //MISCELLANEOUS Creditor
                VLE.RESET;
                VLE.SETRANGE("Vendor No.", Vendor."No.");
                VLE.SETRANGE("Creditors Type", VLE."Creditors Type"::"MISCELLANEOUS CREDITORS");
                VLE.SETRANGE("Due Date", PeriodStartDate[1], PeriodEndDate[1]);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS("Remaining Amount");
                        MiscAmt1Month += VLE."Remaining Amount";
                    UNTIL VLE.NEXT = 0;


                VLE.RESET;
                VLE.SETRANGE("Vendor No.", Vendor."No.");
                VLE.SETRANGE("Creditors Type", VLE."Creditors Type"::"MISCELLANEOUS CREDITORS");
                VLE.SETRANGE("Due Date", PeriodStartDate[2], PeriodEndDate[2]);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS("Remaining Amount");
                        MiscAmt2Month += VLE."Remaining Amount";
                    UNTIL VLE.NEXT = 0;

                VLE.RESET;
                VLE.SETRANGE("Vendor No.", Vendor."No.");
                VLE.SETRANGE("Creditors Type", VLE."Creditors Type"::"MISCELLANEOUS CREDITORS");
                VLE.SETRANGE("Due Date", PeriodStartDate[3], PeriodEndDate[3]);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS("Remaining Amount");
                        MiscAmt3Month += VLE."Remaining Amount";
                    UNTIL VLE.NEXT = 0;

                VLE.RESET;
                VLE.SETRANGE("Vendor No.", Vendor."No.");
                VLE.SETRANGE("Creditors Type", VLE."Creditors Type"::"MISCELLANEOUS CREDITORS");
                VLE.SETRANGE("Due Date", PeriodStartDate[4], PeriodEndDate[4]);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS("Remaining Amount");
                        MiscAmt4Month += VLE."Remaining Amount";
                    UNTIL VLE.NEXT = 0;

                VLE.RESET;
                VLE.SETRANGE("Vendor No.", Vendor."No.");
                VLE.SETRANGE("Creditors Type", VLE."Creditors Type"::"MISCELLANEOUS CREDITORS");
                VLE.SETRANGE("Due Date", PeriodStartDate[5], PeriodEndDate[5]);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS("Remaining Amount");
                        MiscAmt5Month += VLE."Remaining Amount";
                    UNTIL VLE.NEXT = 0;

                //Null Creditors
                VLE.RESET;
                VLE.SETRANGE("Vendor No.", Vendor."No.");
                VLE.SETRANGE("Creditors Type", VLE."Creditors Type"::" ");
                VLE.SETRANGE("Due Date", PeriodStartDate[1], PeriodEndDate[1]);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS("Remaining Amount");
                        NullAmt1Month += VLE."Remaining Amount";
                    UNTIL VLE.NEXT = 0;

                VLE.RESET;
                VLE.SETRANGE("Vendor No.", Vendor."No.");
                VLE.SETRANGE("Creditors Type", VLE."Creditors Type"::" ");
                VLE.SETRANGE("Due Date", PeriodStartDate[2], PeriodEndDate[2]);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS("Remaining Amount");
                        NullAmt2Month += VLE."Remaining Amount";
                    UNTIL VLE.NEXT = 0;

                VLE.RESET;
                VLE.SETRANGE("Vendor No.", Vendor."No.");
                VLE.SETRANGE("Creditors Type", VLE."Creditors Type"::" ");
                VLE.SETRANGE("Due Date", PeriodStartDate[3], PeriodEndDate[3]);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS("Remaining Amount");
                        NullAmt3Month += VLE."Remaining Amount";
                    UNTIL VLE.NEXT = 0;

                VLE.RESET;
                VLE.SETRANGE("Vendor No.", Vendor."No.");
                VLE.SETRANGE("Creditors Type", VLE."Creditors Type"::" ");
                VLE.SETRANGE("Due Date", PeriodStartDate[4], PeriodEndDate[4]);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS("Remaining Amount");
                        NullAmt4Month += VLE."Remaining Amount";
                    UNTIL VLE.NEXT = 0;

                VLE.RESET;
                VLE.SETRANGE("Vendor No.", Vendor."No.");
                VLE.SETRANGE("Creditors Type", VLE."Creditors Type"::" ");
                VLE.SETRANGE("Due Date", PeriodStartDate[5], PeriodEndDate[5]);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS("Remaining Amount");
                        NullAmt5Month += VLE."Remaining Amount";
                    UNTIL VLE.NEXT = 0;
                //PruRaj
                //>>as on 051219 PruRaj

                //Maize Creditors
                VLE.RESET;
                VLE.SETRANGE("Vendor No.", Vendor."No.");
                VLE.SETRANGE("Creditors Type", VLE."Creditors Type"::"Maize Creditors");
                VLE.SETRANGE("Due Date", PeriodStartDate[1], PeriodEndDate[1]);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS("Remaining Amount");
                        MaizeAmt1Month += VLE."Remaining Amount";
                    UNTIL VLE.NEXT = 0;

                VLE.RESET;
                VLE.SETRANGE("Vendor No.", Vendor."No.");
                VLE.SETRANGE("Creditors Type", VLE."Creditors Type"::"Maize Creditors");
                VLE.SETRANGE("Due Date", PeriodStartDate[2], PeriodEndDate[2]);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS("Remaining Amount");
                        MaizeAmt2Month += VLE."Remaining Amount";
                    UNTIL VLE.NEXT = 0;

                VLE.RESET;
                VLE.SETRANGE("Vendor No.", Vendor."No.");
                VLE.SETRANGE("Creditors Type", VLE."Creditors Type"::"Maize Creditors");
                VLE.SETRANGE("Due Date", PeriodStartDate[3], PeriodEndDate[3]);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS("Remaining Amount");
                        MaizeAmt3Month += VLE."Remaining Amount";
                    UNTIL VLE.NEXT = 0;

                VLE.RESET;
                VLE.SETRANGE("Vendor No.", Vendor."No.");
                VLE.SETRANGE("Creditors Type", VLE."Creditors Type"::"Maize Creditors");
                VLE.SETRANGE("Due Date", PeriodStartDate[4], PeriodEndDate[4]);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS("Remaining Amount");
                        MaizeAmt4Month += VLE."Remaining Amount";
                    UNTIL VLE.NEXT = 0;

                VLE.RESET;
                VLE.SETRANGE("Vendor No.", Vendor."No.");
                VLE.SETRANGE("Creditors Type", VLE."Creditors Type"::"Maize Creditors");
                VLE.SETRANGE("Due Date", PeriodStartDate[5], PeriodEndDate[5]);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS("Remaining Amount");
                        MaizeAmt5Month += VLE."Remaining Amount";
                    UNTIL VLE.NEXT = 0;

                //Maize Creditors


                //Bajra Creditors
                VLE.RESET;
                VLE.SETRANGE("Vendor No.", Vendor."No.");
                VLE.SETRANGE("Creditors Type", VLE."Creditors Type"::"BAJRA Creditors");
                VLE.SETRANGE("Due Date", PeriodStartDate[1], PeriodEndDate[1]);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS("Remaining Amount");
                        BajraAmt1Month += VLE."Remaining Amount";
                    UNTIL VLE.NEXT = 0;

                VLE.RESET;
                VLE.SETRANGE("Vendor No.", Vendor."No.");
                VLE.SETRANGE("Creditors Type", VLE."Creditors Type"::"BAJRA Creditors");
                VLE.SETRANGE("Due Date", PeriodStartDate[2], PeriodEndDate[2]);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS("Remaining Amount");
                        BajraAmt2Month += VLE."Remaining Amount";
                    UNTIL VLE.NEXT = 0;

                VLE.RESET;
                VLE.SETRANGE("Vendor No.", Vendor."No.");
                VLE.SETRANGE("Creditors Type", VLE."Creditors Type"::"BAJRA Creditors");
                VLE.SETRANGE("Due Date", PeriodStartDate[3], PeriodEndDate[3]);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS("Remaining Amount");
                        BajraAmt3Month += VLE."Remaining Amount";
                    UNTIL VLE.NEXT = 0;

                VLE.RESET;
                VLE.SETRANGE("Vendor No.", Vendor."No.");
                VLE.SETRANGE("Creditors Type", VLE."Creditors Type"::"BAJRA Creditors");
                VLE.SETRANGE("Due Date", PeriodStartDate[4], PeriodEndDate[4]);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS("Remaining Amount");
                        BajraAmt4Month += VLE."Remaining Amount";
                    UNTIL VLE.NEXT = 0;

                VLE.RESET;
                VLE.SETRANGE("Vendor No.", Vendor."No.");
                VLE.SETRANGE("Creditors Type", VLE."Creditors Type"::"BAJRA Creditors");
                VLE.SETRANGE("Due Date", PeriodStartDate[5], PeriodEndDate[5]);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS("Remaining Amount");
                        BajraAmt5Month += VLE."Remaining Amount";
                    UNTIL VLE.NEXT = 0;

                //Bajra Creditors

                //Wheat Creditors
                VLE.RESET;
                VLE.SETRANGE("Vendor No.", Vendor."No.");
                VLE.SETRANGE("Creditors Type", VLE."Creditors Type"::"Wheat Creditors");
                VLE.SETRANGE("Due Date", PeriodStartDate[1], PeriodEndDate[1]);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS("Remaining Amount");
                        WheatAmt1Month += VLE."Remaining Amount";
                    UNTIL VLE.NEXT = 0;

                VLE.RESET;
                VLE.SETRANGE("Vendor No.", Vendor."No.");
                VLE.SETRANGE("Creditors Type", VLE."Creditors Type"::"Wheat Creditors");
                VLE.SETRANGE("Due Date", PeriodStartDate[2], PeriodEndDate[2]);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS("Remaining Amount");
                        WheatAmt2Month += VLE."Remaining Amount";
                    UNTIL VLE.NEXT = 0;

                VLE.RESET;
                VLE.SETRANGE("Vendor No.", Vendor."No.");
                VLE.SETRANGE("Creditors Type", VLE."Creditors Type"::"Wheat Creditors");
                VLE.SETRANGE("Due Date", PeriodStartDate[3], PeriodEndDate[3]);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS("Remaining Amount");
                        WheatAmt3Month += VLE."Remaining Amount";
                    UNTIL VLE.NEXT = 0;

                VLE.RESET;
                VLE.SETRANGE("Vendor No.", Vendor."No.");
                VLE.SETRANGE("Creditors Type", VLE."Creditors Type"::"Wheat Creditors");
                VLE.SETRANGE("Due Date", PeriodStartDate[4], PeriodEndDate[4]);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS("Remaining Amount");
                        WheatAmt4Month += VLE."Remaining Amount";
                    UNTIL VLE.NEXT = 0;

                VLE.RESET;
                VLE.SETRANGE("Vendor No.", Vendor."No.");
                VLE.SETRANGE("Creditors Type", VLE."Creditors Type"::"Wheat Creditors");
                VLE.SETRANGE("Due Date", PeriodStartDate[5], PeriodEndDate[5]);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS("Remaining Amount");
                        WheatAmt5Month += VLE."Remaining Amount";
                    UNTIL VLE.NEXT = 0;

                //Wheat Creditors

                //Mustard Doc Creditors
                VLE.RESET;
                VLE.SETRANGE("Vendor No.", Vendor."No.");
                VLE.SETRANGE("Creditors Type", VLE."Creditors Type"::"Mustard DOC Creditors");
                VLE.SETRANGE("Due Date", PeriodStartDate[1], PeriodEndDate[1]);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS("Remaining Amount");
                        MustardAmt1Month += VLE."Remaining Amount";
                    UNTIL VLE.NEXT = 0;

                VLE.RESET;
                VLE.SETRANGE("Vendor No.", Vendor."No.");
                VLE.SETRANGE("Creditors Type", VLE."Creditors Type"::"Mustard DOC Creditors");
                VLE.SETRANGE("Due Date", PeriodStartDate[2], PeriodEndDate[2]);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS("Remaining Amount");
                        MustardAmt2Month += VLE."Remaining Amount";
                    UNTIL VLE.NEXT = 0;

                VLE.RESET;
                VLE.SETRANGE("Vendor No.", Vendor."No.");
                VLE.SETRANGE("Creditors Type", VLE."Creditors Type"::"Mustard DOC Creditors");
                VLE.SETRANGE("Due Date", PeriodStartDate[3], PeriodEndDate[3]);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS("Remaining Amount");
                        MustardAmt3Month += VLE."Remaining Amount";
                    UNTIL VLE.NEXT = 0;

                VLE.RESET;
                VLE.SETRANGE("Vendor No.", Vendor."No.");
                VLE.SETRANGE("Creditors Type", VLE."Creditors Type"::"Mustard DOC Creditors");
                VLE.SETRANGE("Due Date", PeriodStartDate[4], PeriodEndDate[4]);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS("Remaining Amount");
                        MustardAmt4Month += VLE."Remaining Amount";
                    UNTIL VLE.NEXT = 0;

                VLE.RESET;
                VLE.SETRANGE("Vendor No.", Vendor."No.");
                VLE.SETRANGE("Creditors Type", VLE."Creditors Type"::"Mustard DOC Creditors");
                VLE.SETRANGE("Due Date", PeriodStartDate[5], PeriodEndDate[5]);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS("Remaining Amount");
                        MustardAmt5Month += VLE."Remaining Amount";
                    UNTIL VLE.NEXT = 0;

                //Mustard Doc Creditors


                //DDGS Creditors
                VLE.RESET;
                VLE.SETRANGE("Vendor No.", Vendor."No.");
                VLE.SETRANGE("Creditors Type", VLE."Creditors Type"::"D.D.G.S Creditors");
                VLE.SETRANGE("Due Date", PeriodStartDate[1], PeriodEndDate[1]);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS("Remaining Amount");
                        DDGSAmt1Month += VLE."Remaining Amount";
                    UNTIL VLE.NEXT = 0;

                VLE.RESET;
                VLE.SETRANGE("Vendor No.", Vendor."No.");
                VLE.SETRANGE("Creditors Type", VLE."Creditors Type"::"D.D.G.S Creditors");
                VLE.SETRANGE("Due Date", PeriodStartDate[2], PeriodEndDate[2]);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS("Remaining Amount");
                        DDGSAmt2Month += VLE."Remaining Amount";
                    UNTIL VLE.NEXT = 0;

                VLE.RESET;
                VLE.SETRANGE("Vendor No.", Vendor."No.");
                VLE.SETRANGE("Creditors Type", VLE."Creditors Type"::"D.D.G.S Creditors");
                VLE.SETRANGE("Due Date", PeriodStartDate[3], PeriodEndDate[3]);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS("Remaining Amount");
                        DDGSAmt3Month += VLE."Remaining Amount";
                    UNTIL VLE.NEXT = 0;

                VLE.RESET;
                VLE.SETRANGE("Vendor No.", Vendor."No.");
                VLE.SETRANGE("Creditors Type", VLE."Creditors Type"::"D.D.G.S Creditors");
                VLE.SETRANGE("Due Date", PeriodStartDate[4], PeriodEndDate[4]);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS("Remaining Amount");
                        DDGSAmt4Month += VLE."Remaining Amount";
                    UNTIL VLE.NEXT = 0;

                VLE.RESET;
                VLE.SETRANGE("Vendor No.", Vendor."No.");
                VLE.SETRANGE("Creditors Type", VLE."Creditors Type"::"D.D.G.S Creditors");
                VLE.SETRANGE("Due Date", PeriodStartDate[5], PeriodEndDate[5]);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS("Remaining Amount");
                        DDGSAmt5Month += VLE."Remaining Amount";
                    UNTIL VLE.NEXT = 0;

                //DDGS Creditors

                //Deoiled Rice Bran Creditors
                VLE.RESET;
                VLE.SETRANGE("Vendor No.", Vendor."No.");
                VLE.SETRANGE("Creditors Type", VLE."Creditors Type"::"DEOILED RICE BRAN Creditors");
                VLE.SETRANGE("Due Date", PeriodStartDate[1], PeriodEndDate[1]);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS("Remaining Amount");
                        DeoiledRiceAmt1Month += VLE."Remaining Amount";
                    UNTIL VLE.NEXT = 0;

                VLE.RESET;
                VLE.SETRANGE("Vendor No.", Vendor."No.");
                VLE.SETRANGE("Creditors Type", VLE."Creditors Type"::"DEOILED RICE BRAN Creditors");
                VLE.SETRANGE("Due Date", PeriodStartDate[2], PeriodEndDate[2]);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS("Remaining Amount");
                        DeoiledRiceAmt2Month += VLE."Remaining Amount";
                    UNTIL VLE.NEXT = 0;

                VLE.RESET;
                VLE.SETRANGE("Vendor No.", Vendor."No.");
                VLE.SETRANGE("Creditors Type", VLE."Creditors Type"::"DEOILED RICE BRAN Creditors");
                VLE.SETRANGE("Due Date", PeriodStartDate[3], PeriodEndDate[3]);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS("Remaining Amount");
                        DeoiledRiceAmt3Month += VLE."Remaining Amount";
                    UNTIL VLE.NEXT = 0;

                VLE.RESET;
                VLE.SETRANGE("Vendor No.", Vendor."No.");
                VLE.SETRANGE("Creditors Type", VLE."Creditors Type"::"DEOILED RICE BRAN Creditors");
                VLE.SETRANGE("Due Date", PeriodStartDate[4], PeriodEndDate[4]);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS("Remaining Amount");
                        DeoiledRiceAmt4Month += VLE."Remaining Amount";
                    UNTIL VLE.NEXT = 0;

                VLE.RESET;
                VLE.SETRANGE("Vendor No.", Vendor."No.");
                VLE.SETRANGE("Creditors Type", VLE."Creditors Type"::"DEOILED RICE BRAN Creditors");
                VLE.SETRANGE("Due Date", PeriodStartDate[5], PeriodEndDate[5]);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS("Remaining Amount");
                        DeoiledRiceAmt5Month += VLE."Remaining Amount";
                    UNTIL VLE.NEXT = 0;

                //Deoiled Rice Brand Creditors
                //PRU_NEELESH 07012020
                //BIRDS Creditors
                VLE.RESET;
                VLE.SETRANGE("Vendor No.", Vendor."No.");
                VLE.SETRANGE("Creditors Type", VLE."Creditors Type"::"Birds Creditor");
                VLE.SETRANGE("Due Date", PeriodStartDate[1], PeriodEndDate[1]);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS("Remaining Amount");
                        BirdsAmt1Month += VLE."Remaining Amount";
                    UNTIL VLE.NEXT = 0;

                VLE.RESET;
                VLE.SETRANGE("Vendor No.", Vendor."No.");
                VLE.SETRANGE("Creditors Type", VLE."Creditors Type"::"Birds Creditor");
                VLE.SETRANGE("Due Date", PeriodStartDate[2], PeriodEndDate[2]);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS("Remaining Amount");
                        BirdsAmt2Month += VLE."Remaining Amount";
                    UNTIL VLE.NEXT = 0;

                VLE.RESET;
                VLE.SETRANGE("Vendor No.", Vendor."No.");
                VLE.SETRANGE("Creditors Type", VLE."Creditors Type"::"Birds Creditor");
                VLE.SETRANGE("Due Date", PeriodStartDate[3], PeriodEndDate[3]);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS("Remaining Amount");
                        BirdsAmt3Month += VLE."Remaining Amount";
                    UNTIL VLE.NEXT = 0;

                VLE.RESET;
                VLE.SETRANGE("Vendor No.", Vendor."No.");
                VLE.SETRANGE("Creditors Type", VLE."Creditors Type"::"Birds Creditor");
                VLE.SETRANGE("Due Date", PeriodStartDate[4], PeriodEndDate[4]);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS("Remaining Amount");
                        BirdsAmt4Month += VLE."Remaining Amount";
                    UNTIL VLE.NEXT = 0;

                VLE.RESET;
                VLE.SETRANGE("Vendor No.", Vendor."No.");
                VLE.SETRANGE("Creditors Type", VLE."Creditors Type"::"Birds Creditor");
                VLE.SETRANGE("Due Date", PeriodStartDate[5], PeriodEndDate[5]);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS("Remaining Amount");
                        BirdsAmt5Month += VLE."Remaining Amount";
                    UNTIL VLE.NEXT = 0;
                //BIRDS Creditors

                //CHICKS Creditors
                VLE.RESET;
                VLE.SETRANGE("Vendor No.", Vendor."No.");
                VLE.SETRANGE("Creditors Type", VLE."Creditors Type"::"Chicks Creditor");
                VLE.SETRANGE("Due Date", PeriodStartDate[1], PeriodEndDate[1]);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS("Remaining Amount");
                        ChicksAmt1Month += VLE."Remaining Amount";
                    UNTIL VLE.NEXT = 0;

                VLE.RESET;
                VLE.SETRANGE("Vendor No.", Vendor."No.");
                VLE.SETRANGE("Creditors Type", VLE."Creditors Type"::"Chicks Creditor");
                VLE.SETRANGE("Due Date", PeriodStartDate[2], PeriodEndDate[2]);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS("Remaining Amount");
                        ChicksAmt2Month += VLE."Remaining Amount";
                    UNTIL VLE.NEXT = 0;

                VLE.RESET;
                VLE.SETRANGE("Vendor No.", Vendor."No.");
                VLE.SETRANGE("Creditors Type", VLE."Creditors Type"::"Chicks Creditor");
                VLE.SETRANGE("Due Date", PeriodStartDate[3], PeriodEndDate[3]);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS("Remaining Amount");
                        ChicksAmt3Month += VLE."Remaining Amount";
                    UNTIL VLE.NEXT = 0;

                VLE.RESET;
                VLE.SETRANGE("Vendor No.", Vendor."No.");
                VLE.SETRANGE("Creditors Type", VLE."Creditors Type"::"Chicks Creditor");
                VLE.SETRANGE("Due Date", PeriodStartDate[4], PeriodEndDate[4]);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS("Remaining Amount");
                        ChicksAmt4Month += VLE."Remaining Amount";
                    UNTIL VLE.NEXT = 0;

                VLE.RESET;
                VLE.SETRANGE("Vendor No.", Vendor."No.");
                VLE.SETRANGE("Creditors Type", VLE."Creditors Type"::"Chicks Creditor");
                VLE.SETRANGE("Due Date", PeriodStartDate[5], PeriodEndDate[5]);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS("Remaining Amount");
                        ChicksAmt5Month += VLE."Remaining Amount";
                    UNTIL VLE.NEXT = 0;
                //CHICKS Creditors

                //Gen Item
                VLE.RESET;
                VLE.SETRANGE("Vendor No.", Vendor."No.");
                VLE.SETRANGE("Creditors Type", VLE."Creditors Type"::"Gen Item");
                VLE.SETRANGE("Due Date", PeriodStartDate[1], PeriodEndDate[1]);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS("Remaining Amount");
                        GenItem1Month += VLE."Remaining Amount";
                    UNTIL VLE.NEXT = 0;

                VLE.RESET;
                VLE.SETRANGE("Vendor No.", Vendor."No.");
                VLE.SETRANGE("Creditors Type", VLE."Creditors Type"::"Gen Item");
                VLE.SETRANGE("Due Date", PeriodStartDate[2], PeriodEndDate[2]);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS("Remaining Amount");
                        GenItem2Month += VLE."Remaining Amount";
                    UNTIL VLE.NEXT = 0;

                VLE.RESET;
                VLE.SETRANGE("Vendor No.", Vendor."No.");
                VLE.SETRANGE("Creditors Type", VLE."Creditors Type"::"Gen Item");
                VLE.SETRANGE("Due Date", PeriodStartDate[3], PeriodEndDate[3]);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS("Remaining Amount");
                        GenItem3Month += VLE."Remaining Amount";
                    UNTIL VLE.NEXT = 0;

                VLE.RESET;
                VLE.SETRANGE("Vendor No.", Vendor."No.");
                VLE.SETRANGE("Creditors Type", VLE."Creditors Type"::"Gen Item");
                VLE.SETRANGE("Due Date", PeriodStartDate[4], PeriodEndDate[4]);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS("Remaining Amount");
                        GenItem4Month += VLE."Remaining Amount";
                    UNTIL VLE.NEXT = 0;

                VLE.RESET;
                VLE.SETRANGE("Vendor No.", Vendor."No.");
                VLE.SETRANGE("Creditors Type", VLE."Creditors Type"::"Gen Item");
                VLE.SETRANGE("Due Date", PeriodStartDate[5], PeriodEndDate[5]);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS("Remaining Amount");
                        GenItem5Month += VLE."Remaining Amount";
                    UNTIL VLE.NEXT = 0;
                //Gen Item

                //Hatching Egg Outside
                VLE.RESET;
                VLE.SETRANGE("Vendor No.", Vendor."No.");
                VLE.SETRANGE("Creditors Type", VLE."Creditors Type"::"Hatching Egg Outside");
                VLE.SETRANGE("Due Date", PeriodStartDate[1], PeriodEndDate[1]);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS("Remaining Amount");
                        HatchingEggOutside1Month += VLE."Remaining Amount";
                    UNTIL VLE.NEXT = 0;

                VLE.RESET;
                VLE.SETRANGE("Vendor No.", Vendor."No.");
                VLE.SETRANGE("Creditors Type", VLE."Creditors Type"::"Hatching Egg Outside");
                VLE.SETRANGE("Due Date", PeriodStartDate[2], PeriodEndDate[2]);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS("Remaining Amount");
                        HatchingEggOutside2Month += VLE."Remaining Amount";
                    UNTIL VLE.NEXT = 0;

                VLE.RESET;
                VLE.SETRANGE("Vendor No.", Vendor."No.");
                VLE.SETRANGE("Creditors Type", VLE."Creditors Type"::"Hatching Egg Outside");
                VLE.SETRANGE("Due Date", PeriodStartDate[3], PeriodEndDate[3]);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS("Remaining Amount");
                        HatchingEggOutside3Month += VLE."Remaining Amount";
                    UNTIL VLE.NEXT = 0;

                VLE.RESET;
                VLE.SETRANGE("Vendor No.", Vendor."No.");
                VLE.SETRANGE("Creditors Type", VLE."Creditors Type"::"Hatching Egg Outside");
                VLE.SETRANGE("Due Date", PeriodStartDate[4], PeriodEndDate[4]);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS("Remaining Amount");
                        HatchingEggOutside4Month += VLE."Remaining Amount";
                    UNTIL VLE.NEXT = 0;

                VLE.RESET;
                VLE.SETRANGE("Vendor No.", Vendor."No.");
                VLE.SETRANGE("Creditors Type", VLE."Creditors Type"::"Hatching Egg Outside");
                VLE.SETRANGE("Due Date", PeriodStartDate[5], PeriodEndDate[5]);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS("Remaining Amount");
                        HatchingEggOutside5Month += VLE."Remaining Amount";
                    UNTIL VLE.NEXT = 0;
                //Hatching Egg Outside

                //Premix
                VLE.RESET;
                VLE.SETRANGE("Vendor No.", Vendor."No.");
                VLE.SETRANGE("Creditors Type", VLE."Creditors Type"::Premix);
                VLE.SETRANGE("Due Date", PeriodStartDate[1], PeriodEndDate[1]);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS("Remaining Amount");
                        Premix1Month += VLE."Remaining Amount";
                    UNTIL VLE.NEXT = 0;

                VLE.RESET;
                VLE.SETRANGE("Vendor No.", Vendor."No.");
                VLE.SETRANGE("Creditors Type", VLE."Creditors Type"::Premix);
                VLE.SETRANGE("Due Date", PeriodStartDate[2], PeriodEndDate[2]);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS("Remaining Amount");
                        Premix2Month += VLE."Remaining Amount";
                    UNTIL VLE.NEXT = 0;

                VLE.RESET;
                VLE.SETRANGE("Vendor No.", Vendor."No.");
                VLE.SETRANGE("Creditors Type", VLE."Creditors Type"::Premix);
                VLE.SETRANGE("Due Date", PeriodStartDate[3], PeriodEndDate[3]);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS("Remaining Amount");
                        Premix3Month += VLE."Remaining Amount";
                    UNTIL VLE.NEXT = 0;

                VLE.RESET;
                VLE.SETRANGE("Vendor No.", Vendor."No.");
                VLE.SETRANGE("Creditors Type", VLE."Creditors Type"::Premix);
                VLE.SETRANGE("Due Date", PeriodStartDate[4], PeriodEndDate[4]);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS("Remaining Amount");
                        Premix4Month += VLE."Remaining Amount";
                    UNTIL VLE.NEXT = 0;

                VLE.RESET;
                VLE.SETRANGE("Vendor No.", Vendor."No.");
                VLE.SETRANGE("Creditors Type", VLE."Creditors Type"::Premix);
                VLE.SETRANGE("Due Date", PeriodStartDate[5], PeriodEndDate[5]);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS("Remaining Amount");
                        Premix5Month += VLE."Remaining Amount";
                    UNTIL VLE.NEXT = 0;
                //Premix


                //Rice Bran Oil
                VLE.RESET;
                VLE.SETRANGE("Vendor No.", Vendor."No.");
                VLE.SETRANGE("Creditors Type", VLE."Creditors Type"::"Rice Bran Oil");
                VLE.SETRANGE("Due Date", PeriodStartDate[1], PeriodEndDate[1]);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS("Remaining Amount");
                        RiceBranOil1Month += VLE."Remaining Amount";
                    UNTIL VLE.NEXT = 0;

                VLE.RESET;
                VLE.SETRANGE("Vendor No.", Vendor."No.");
                VLE.SETRANGE("Creditors Type", VLE."Creditors Type"::"Rice Bran Oil");
                VLE.SETRANGE("Due Date", PeriodStartDate[2], PeriodEndDate[2]);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS("Remaining Amount");
                        RiceBranOil2Month += VLE."Remaining Amount";
                    UNTIL VLE.NEXT = 0;

                VLE.RESET;
                VLE.SETRANGE("Vendor No.", Vendor."No.");
                VLE.SETRANGE("Creditors Type", VLE."Creditors Type"::"Rice Bran Oil");
                VLE.SETRANGE("Due Date", PeriodStartDate[3], PeriodEndDate[3]);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS("Remaining Amount");
                        RiceBranOil3Month += VLE."Remaining Amount";
                    UNTIL VLE.NEXT = 0;

                VLE.RESET;
                VLE.SETRANGE("Vendor No.", Vendor."No.");
                VLE.SETRANGE("Creditors Type", VLE."Creditors Type"::"Rice Bran Oil");
                VLE.SETRANGE("Due Date", PeriodStartDate[4], PeriodEndDate[4]);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS("Remaining Amount");
                        RiceBranOil4Month += VLE."Remaining Amount";
                    UNTIL VLE.NEXT = 0;

                VLE.RESET;
                VLE.SETRANGE("Vendor No.", Vendor."No.");
                VLE.SETRANGE("Creditors Type", VLE."Creditors Type"::"Rice Bran Oil");
                VLE.SETRANGE("Due Date", PeriodStartDate[5], PeriodEndDate[5]);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS("Remaining Amount");
                        RiceBranOil5Month += VLE."Remaining Amount";
                    UNTIL VLE.NEXT = 0;
                //Rice Bran Oil

                //Rice Bran Polish
                VLE.RESET;
                VLE.SETRANGE("Vendor No.", Vendor."No.");
                VLE.SETRANGE("Creditors Type", VLE."Creditors Type"::"Rice Bran Polish");
                VLE.SETRANGE("Due Date", PeriodStartDate[1], PeriodEndDate[1]);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS("Remaining Amount");
                        RiceBranPolish1Month += VLE."Remaining Amount";
                    UNTIL VLE.NEXT = 0;

                VLE.RESET;
                VLE.SETRANGE("Vendor No.", Vendor."No.");
                VLE.SETRANGE("Creditors Type", VLE."Creditors Type"::"Rice Bran Polish");
                VLE.SETRANGE("Due Date", PeriodStartDate[2], PeriodEndDate[2]);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS("Remaining Amount");
                        RiceBranPolish2Month += VLE."Remaining Amount";
                    UNTIL VLE.NEXT = 0;

                VLE.RESET;
                VLE.SETRANGE("Vendor No.", Vendor."No.");
                VLE.SETRANGE("Creditors Type", VLE."Creditors Type"::"Rice Bran Polish");
                VLE.SETRANGE("Due Date", PeriodStartDate[3], PeriodEndDate[3]);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS("Remaining Amount");
                        RiceBranPolish3Month += VLE."Remaining Amount";
                    UNTIL VLE.NEXT = 0;

                VLE.RESET;
                VLE.SETRANGE("Vendor No.", Vendor."No.");
                VLE.SETRANGE("Creditors Type", VLE."Creditors Type"::"Rice Bran Polish");
                VLE.SETRANGE("Due Date", PeriodStartDate[4], PeriodEndDate[4]);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS("Remaining Amount");
                        RiceBranPolish4Month += VLE."Remaining Amount";
                    UNTIL VLE.NEXT = 0;

                VLE.RESET;
                VLE.SETRANGE("Vendor No.", Vendor."No.");
                VLE.SETRANGE("Creditors Type", VLE."Creditors Type"::"Rice Bran Polish");
                VLE.SETRANGE("Due Date", PeriodStartDate[5], PeriodEndDate[5]);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS("Remaining Amount");
                        RiceBranPolish5Month += VLE."Remaining Amount";
                    UNTIL VLE.NEXT = 0;
                //Rice Bran Polish

                //Rice Kanni
                VLE.RESET;
                VLE.SETRANGE("Vendor No.", Vendor."No.");
                VLE.SETRANGE("Creditors Type", VLE."Creditors Type"::"Rice Kanni");
                VLE.SETRANGE("Due Date", PeriodStartDate[1], PeriodEndDate[1]);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS("Remaining Amount");
                        RiceKanni1Month += VLE."Remaining Amount";
                    UNTIL VLE.NEXT = 0;

                VLE.RESET;
                VLE.SETRANGE("Vendor No.", Vendor."No.");
                VLE.SETRANGE("Creditors Type", VLE."Creditors Type"::"Rice Kanni");
                VLE.SETRANGE("Due Date", PeriodStartDate[2], PeriodEndDate[2]);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS("Remaining Amount");
                        RiceKanni2Month += VLE."Remaining Amount";
                    UNTIL VLE.NEXT = 0;

                VLE.RESET;
                VLE.SETRANGE("Vendor No.", Vendor."No.");
                VLE.SETRANGE("Creditors Type", VLE."Creditors Type"::"Rice Kanni");
                VLE.SETRANGE("Due Date", PeriodStartDate[3], PeriodEndDate[3]);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS("Remaining Amount");
                        RiceKanni3Month += VLE."Remaining Amount";
                    UNTIL VLE.NEXT = 0;

                VLE.RESET;
                VLE.SETRANGE("Vendor No.", Vendor."No.");
                VLE.SETRANGE("Creditors Type", VLE."Creditors Type"::"Rice Kanni");
                VLE.SETRANGE("Due Date", PeriodStartDate[4], PeriodEndDate[4]);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS("Remaining Amount");
                        RiceKanni4Month += VLE."Remaining Amount";
                    UNTIL VLE.NEXT = 0;

                VLE.RESET;
                VLE.SETRANGE("Vendor No.", Vendor."No.");
                VLE.SETRANGE("Creditors Type", VLE."Creditors Type"::"Rice Kanni");
                VLE.SETRANGE("Due Date", PeriodStartDate[5], PeriodEndDate[5]);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS("Remaining Amount");
                        RiceKanni5Month += VLE."Remaining Amount";
                    UNTIL VLE.NEXT = 0;
                //Rice Kanni

                //Lime Stone Power
                VLE.RESET;
                VLE.SETRANGE("Vendor No.", Vendor."No.");
                VLE.SETRANGE("Creditors Type", VLE."Creditors Type"::"Lime Stone Power");
                VLE.SETRANGE("Due Date", PeriodStartDate[1], PeriodEndDate[1]);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS("Remaining Amount");
                        LimeStonePower1Month += VLE."Remaining Amount";
                    UNTIL VLE.NEXT = 0;

                VLE.RESET;
                VLE.SETRANGE("Vendor No.", Vendor."No.");
                VLE.SETRANGE("Creditors Type", VLE."Creditors Type"::"Lime Stone Power");
                VLE.SETRANGE("Due Date", PeriodStartDate[2], PeriodEndDate[2]);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS("Remaining Amount");
                        LimeStonePower2Month += VLE."Remaining Amount";
                    UNTIL VLE.NEXT = 0;

                VLE.RESET;
                VLE.SETRANGE("Vendor No.", Vendor."No.");
                VLE.SETRANGE("Creditors Type", VLE."Creditors Type"::"Lime Stone Power");
                VLE.SETRANGE("Due Date", PeriodStartDate[3], PeriodEndDate[3]);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS("Remaining Amount");
                        LimeStonePower3Month += VLE."Remaining Amount";
                    UNTIL VLE.NEXT = 0;

                VLE.RESET;
                VLE.SETRANGE("Vendor No.", Vendor."No.");
                VLE.SETRANGE("Creditors Type", VLE."Creditors Type"::"Lime Stone Power");
                VLE.SETRANGE("Due Date", PeriodStartDate[4], PeriodEndDate[4]);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS("Remaining Amount");
                        LimeStonePower4Month += VLE."Remaining Amount";
                    UNTIL VLE.NEXT = 0;

                VLE.RESET;
                VLE.SETRANGE("Vendor No.", Vendor."No.");
                VLE.SETRANGE("Creditors Type", VLE."Creditors Type"::"Lime Stone Power");
                VLE.SETRANGE("Due Date", PeriodStartDate[5], PeriodEndDate[5]);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS("Remaining Amount");
                        LimeStonePower5Month += VLE."Remaining Amount";
                    UNTIL VLE.NEXT = 0;
                //Lime Stone Power

                //Gaur Meal
                VLE.RESET;
                VLE.SETRANGE("Vendor No.", Vendor."No.");
                VLE.SETRANGE("Creditors Type", VLE."Creditors Type"::"Gaur Meal");
                VLE.SETRANGE("Due Date", PeriodStartDate[1], PeriodEndDate[1]);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS("Remaining Amount");
                        GaurMeal1Month += VLE."Remaining Amount";
                    UNTIL VLE.NEXT = 0;

                VLE.RESET;
                VLE.SETRANGE("Vendor No.", Vendor."No.");
                VLE.SETRANGE("Creditors Type", VLE."Creditors Type"::"Gaur Meal");
                VLE.SETRANGE("Due Date", PeriodStartDate[2], PeriodEndDate[2]);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS("Remaining Amount");
                        GaurMeal2Month += VLE."Remaining Amount";
                    UNTIL VLE.NEXT = 0;

                VLE.RESET;
                VLE.SETRANGE("Vendor No.", Vendor."No.");
                VLE.SETRANGE("Creditors Type", VLE."Creditors Type"::"Gaur Meal");
                VLE.SETRANGE("Due Date", PeriodStartDate[3], PeriodEndDate[3]);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS("Remaining Amount");
                        GaurMeal3Month += VLE."Remaining Amount";
                    UNTIL VLE.NEXT = 0;

                VLE.RESET;
                VLE.SETRANGE("Vendor No.", Vendor."No.");
                VLE.SETRANGE("Creditors Type", VLE."Creditors Type"::"Gaur Meal");
                VLE.SETRANGE("Due Date", PeriodStartDate[4], PeriodEndDate[4]);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS("Remaining Amount");
                        GaurMeal4Month += VLE."Remaining Amount";
                    UNTIL VLE.NEXT = 0;

                VLE.RESET;
                VLE.SETRANGE("Vendor No.", Vendor."No.");
                VLE.SETRANGE("Creditors Type", VLE."Creditors Type"::"Gaur Meal");
                VLE.SETRANGE("Due Date", PeriodStartDate[5], PeriodEndDate[5]);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS("Remaining Amount");
                        GaurMeal5Month += VLE."Remaining Amount";
                    UNTIL VLE.NEXT = 0;
                //Gaur Meal

                //Chicken Waste Meal
                VLE.RESET;
                VLE.SETRANGE("Vendor No.", Vendor."No.");
                VLE.SETRANGE("Creditors Type", VLE."Creditors Type"::"Chicken Waste Meal");
                VLE.SETRANGE("Due Date", PeriodStartDate[1], PeriodEndDate[1]);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS("Remaining Amount");
                        ChickenWasteMeal1Month += VLE."Remaining Amount";
                    UNTIL VLE.NEXT = 0;

                VLE.RESET;
                VLE.SETRANGE("Vendor No.", Vendor."No.");
                VLE.SETRANGE("Creditors Type", VLE."Creditors Type"::"Chicken Waste Meal");
                VLE.SETRANGE("Due Date", PeriodStartDate[2], PeriodEndDate[2]);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS("Remaining Amount");
                        ChickenWasteMeal2Month += VLE."Remaining Amount";
                    UNTIL VLE.NEXT = 0;

                VLE.RESET;
                VLE.SETRANGE("Vendor No.", Vendor."No.");
                VLE.SETRANGE("Creditors Type", VLE."Creditors Type"::"Chicken Waste Meal");
                VLE.SETRANGE("Due Date", PeriodStartDate[3], PeriodEndDate[3]);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS("Remaining Amount");
                        ChickenWasteMeal3Month += VLE."Remaining Amount";
                    UNTIL VLE.NEXT = 0;

                VLE.RESET;
                VLE.SETRANGE("Vendor No.", Vendor."No.");
                VLE.SETRANGE("Creditors Type", VLE."Creditors Type"::"Chicken Waste Meal");
                VLE.SETRANGE("Due Date", PeriodStartDate[4], PeriodEndDate[4]);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS("Remaining Amount");
                        ChickenWasteMeal4Month += VLE."Remaining Amount";
                    UNTIL VLE.NEXT = 0;

                VLE.RESET;
                VLE.SETRANGE("Vendor No.", Vendor."No.");
                VLE.SETRANGE("Creditors Type", VLE."Creditors Type"::"Chicken Waste Meal");
                VLE.SETRANGE("Due Date", PeriodStartDate[5], PeriodEndDate[5]);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS("Remaining Amount");
                        ChickenWasteMeal5Month += VLE."Remaining Amount";
                    UNTIL VLE.NEXT = 0;
                //Chicken Waste Meal

                //P.P Bags
                VLE.RESET;
                VLE.SETRANGE("Vendor No.", Vendor."No.");
                VLE.SETRANGE("Creditors Type", VLE."Creditors Type"::"P.P Bags");
                VLE.SETRANGE("Due Date", PeriodStartDate[1], PeriodEndDate[1]);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS("Remaining Amount");
                        PPBags1Month += VLE."Remaining Amount";
                    UNTIL VLE.NEXT = 0;

                VLE.RESET;
                VLE.SETRANGE("Vendor No.", Vendor."No.");
                VLE.SETRANGE("Creditors Type", VLE."Creditors Type"::"P.P Bags");
                VLE.SETRANGE("Due Date", PeriodStartDate[2], PeriodEndDate[2]);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS("Remaining Amount");
                        PPBags2Month += VLE."Remaining Amount";
                    UNTIL VLE.NEXT = 0;

                VLE.RESET;
                VLE.SETRANGE("Vendor No.", Vendor."No.");
                VLE.SETRANGE("Creditors Type", VLE."Creditors Type"::"P.P Bags");
                VLE.SETRANGE("Due Date", PeriodStartDate[3], PeriodEndDate[3]);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS("Remaining Amount");
                        PPBags3Month += VLE."Remaining Amount";
                    UNTIL VLE.NEXT = 0;

                VLE.RESET;
                VLE.SETRANGE("Vendor No.", Vendor."No.");
                VLE.SETRANGE("Creditors Type", VLE."Creditors Type"::"P.P Bags");
                VLE.SETRANGE("Due Date", PeriodStartDate[4], PeriodEndDate[4]);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS("Remaining Amount");
                        PPBags4Month += VLE."Remaining Amount";
                    UNTIL VLE.NEXT = 0;

                VLE.RESET;
                VLE.SETRANGE("Vendor No.", Vendor."No.");
                VLE.SETRANGE("Creditors Type", VLE."Creditors Type"::"P.P Bags");
                VLE.SETRANGE("Due Date", PeriodStartDate[5], PeriodEndDate[5]);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS("Remaining Amount");
                        PPBags5Month += VLE."Remaining Amount";
                    UNTIL VLE.NEXT = 0;
                //P.P Bags

                //Other
                VLE.RESET;
                VLE.SETRANGE("Vendor No.", Vendor."No.");
                VLE.SETRANGE("Creditors Type", VLE."Creditors Type"::Other);
                VLE.SETRANGE("Due Date", PeriodStartDate[1], PeriodEndDate[1]);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS("Remaining Amount");
                        Other1Month += VLE."Remaining Amount";
                    UNTIL VLE.NEXT = 0;

                VLE.RESET;
                VLE.SETRANGE("Vendor No.", Vendor."No.");
                VLE.SETRANGE("Creditors Type", VLE."Creditors Type"::Other);
                VLE.SETRANGE("Due Date", PeriodStartDate[2], PeriodEndDate[2]);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS("Remaining Amount");
                        Other2Month += VLE."Remaining Amount";
                    UNTIL VLE.NEXT = 0;

                VLE.RESET;
                VLE.SETRANGE("Vendor No.", Vendor."No.");
                VLE.SETRANGE("Creditors Type", VLE."Creditors Type"::Other);
                VLE.SETRANGE("Due Date", PeriodStartDate[3], PeriodEndDate[3]);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS("Remaining Amount");
                        Other3Month += VLE."Remaining Amount";
                    UNTIL VLE.NEXT = 0;

                VLE.RESET;
                VLE.SETRANGE("Vendor No.", Vendor."No.");
                VLE.SETRANGE("Creditors Type", VLE."Creditors Type"::Other);
                VLE.SETRANGE("Due Date", PeriodStartDate[4], PeriodEndDate[4]);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS("Remaining Amount");
                        Other4Month += VLE."Remaining Amount";
                    UNTIL VLE.NEXT = 0;

                VLE.RESET;
                VLE.SETRANGE("Vendor No.", Vendor."No.");
                VLE.SETRANGE("Creditors Type", VLE."Creditors Type"::Other);
                VLE.SETRANGE("Due Date", PeriodStartDate[5], PeriodEndDate[5]);
                IF VLE.FINDSET THEN
                    REPEAT
                        VLE.CALCFIELDS("Remaining Amount");
                        Other5Month += VLE."Remaining Amount";
                    UNTIL VLE.NEXT = 0;
                //Others

                //PRU_NEELESH 07012020
                //<<as on 051219 PruRaj
            end;

            trigger OnPreDataItem()
            begin
                PageGroupNo := 1;
            end;
        }
        dataitem(CurrencyTotals; 2000000026)
        {
            DataItemTableView = SORTING("Number")
                                WHERE(Number = FILTER(1 ..));
            column(Number_CurrencyTotals; Number)
            {
            }
            column(NewPagePerVend_CurrTotal; NewPagePerVendor)
            {
            }
            column(TempCurrency2Code; TempCurrency2."Code")
            {
                AutoFormatExpression = "CurrencyCode";
                AutoFormatType = 1;
            }
            column(AgedVendLedgEnt6RemAmtLCY5; AgedVendorLedgEntry[6]."Remaining Amount")
            {
                AutoFormatExpression = "CurrencyCode";
                AutoFormatType = 1;
            }
            column(AgedVendLedgEnt1RemAmtLCY1; AgedVendorLedgEntry[1]."Remaining Amount")
            {
                AutoFormatExpression = "CurrencyCode";
                AutoFormatType = 1;
            }
            column(AgedVendLedgEnt2RemAmtLCY2; AgedVendorLedgEntry[2]."Remaining Amount")
            {
                AutoFormatExpression = "CurrencyCode";
                AutoFormatType = 1;
            }
            column(AgedVendLedgEnt3RemAmtLCY3; AgedVendorLedgEntry[3]."Remaining Amount")
            {
                AutoFormatExpression = "CurrencyCode";
                AutoFormatType = 1;
            }
            column(AgedVendLedgEnt4RemAmtLCY4; AgedVendorLedgEntry[4]."Remaining Amount")
            {
                AutoFormatExpression = "CurrencyCode";
                AutoFormatType = 1;
            }
            column(AgedVendLedgEnt5RemAmtLCY5; AgedVendorLedgEntry[5]."Remaining Amount")
            {
                AutoFormatExpression = "CurrencyCode";
                AutoFormatType = 1;
            }
            column(CurrencySpecificationCaption; CurrencySpecificationCaptionLbl)
            {
            }

            trigger OnAfterGetRecord()
            begin
                IF Number = 1 THEN BEGIN
                    IF NOT TempCurrency2.FINDSET(FALSE, FALSE) THEN
                        CurrReport.BREAK;
                END ELSE
                    IF TempCurrency2.NEXT = 0 THEN
                        CurrReport.BREAK;

                CLEAR(AgedVendorLedgEntry);
                TempCurrencyAmount.SETRANGE("Currency Code", TempCurrency2."Code");
                IF TempCurrencyAmount.FINDSET(FALSE, FALSE) THEN
                    REPEAT
                        IF TempCurrencyAmount.Date <> 99991231D THEN
                            AgedVendorLedgEntry[GetPeriodIndex(TempCurrencyAmount."Date")]."Remaining Amount" :=
                              TempCurrencyAmount."Amount"
                        ELSE
                            AgedVendorLedgEntry[6]."Remaining Amount" := TempCurrencyAmount."Amount";
                    UNTIL TempCurrencyAmount.NEXT = 0;
            end;

            trigger OnPreDataItem()
            begin
                PageGroupNo := 0;
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(AgedAsOf; EndingDate)
                    {
                        Caption = 'Aged As Of';
                        ApplicationArea = All;
                    }
                    field(AgingBy; AgingBy)
                    {
                        Caption = 'Aging by';
                        OptionCaption = 'Due Date,Posting Date,Document Date';
                        ApplicationArea = All;
                    }
                    field(PeriodLength; PeriodLength)
                    {
                        Caption = 'Period Length';
                        ApplicationArea = All;
                    }
                    field(PrintAmountInLCY; PrintAmountInLCY)
                    {
                        Caption = 'Print Amounts in LCY';
                        ApplicationArea = All;
                    }
                    field(PrintDetails; PrintDetails)
                    {
                        Caption = 'Print Details';
                        ApplicationArea = All;
                    }
                    field(HeadingType; HeadingType)
                    {
                        Caption = 'Heading Type';
                        OptionCaption = 'Date Interval,Number of Days';
                        ApplicationArea = All;
                    }
                    field(NewPagePerVendor; NewPagePerVendor)
                    {
                        Caption = 'New Page per Vendor';
                        ApplicationArea = All;
                    }
                    field("View Creditor Type"; ViewCreditorType)
                    {
                        Caption = 'View Creditor Type';
                        ApplicationArea = All;
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            IF EndingDate = 0D THEN
                EndingDate := WORKDATE;
        end;
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        CompanyInfo.GET;
    end;

    trigger OnPreReport()
    begin
        VendorFilter := Vendor.GETFILTERS;

        GLSetup.GET;

        CalcDates;
        CreateHeadings;
    end;

    var
        GLSetup: Record 98;
        TempVendorLedgEntry: Record 25 temporary;
        VendorLedgEntryEndingDate: Record 25;
        TotalVendorLedgEntry: array[5] of Record 25;
        AgedVendorLedgEntry: array[6] of Record 25;
        TempCurrency: Record 4 temporary;
        TempCurrency2: Record 4 temporary;
        TempCurrencyAmount: Record 264 temporary;
        DetailedVendorLedgerEntry: Record 380;
        GrandTotalVLERemaingAmtLCY: array[5] of Decimal;
        GrandTotalVLEAmtLCY: Decimal;
        VendorFilter: Text;
        PrintAmountInLCY: Boolean;
        EndingDate: Date;
        AgingBy: Option "Due Date","Posting Date","Document Date";
        PeriodLength: DateFormula;
        PrintDetails: Boolean;
        HeadingType: Option "Date Interval","Number of Days";
        NewPagePerVendor: Boolean;
        PeriodStartDate: array[5] of Date;
        PeriodEndDate: array[5] of Date;
        HeaderText: array[5] of Text[30];
        Text000: Label 'Not Due';
        Text001: Label 'Before';
        CurrencyCode: Code[10];
        Text002: Label 'days';
        Text003: Label 'More than';
        Text004: Label 'Aged by %1';
        Text005: Label 'Total for %1';
        Text006: Label 'Aged as of %1';
        Text007: Label 'Aged by %1';
        NumberOfCurrencies: Integer;
        Text009: Label 'Due Date,Posting Date,Document Date';
        Text010: Label 'The Date Formula %1 cannot be used. Try to restate it, for example, by using 1M+CM instead of CM+1M.';
        PageGroupNo: Integer;
        EnterDateFormulaErr: Label 'Enter a date formula in the Period Length field.';
        Text027: Label '-%1', Comment = 'Negating the period length: %1 is the period length';
        AgedAcctPayableCaptionLbl: Label 'Aged Accounts Payable';
        CurrReportPageNoCaptionLbl: Label 'Page';
        AllAmtsinLCYCaptionLbl: Label 'All Amounts in LCY';
        AgedOverdueAmsCaptionLbl: Label 'Aged Overdue Amounts';
        GrandTotalVLE5RemAmtLCYCaptionLbl: Label 'Balance';
        AmountLCYCaptionLbl: Label 'Original Amount';
        DueDateCaptionLbl: Label 'Due Date';
        DocumentNoCaptionLbl: Label 'Document No.';
        PostingDateCaptionLbl: Label 'Posting Date';
        DocumentTypeCaptionLbl: Label 'Document Type';
        CurrencyCaptionLbl: Label 'Currency Code';
        TotalLCYCaptionLbl: Label 'Total (LCY)';
        CurrencySpecificationCaptionLbl: Label 'Currency Specification';
        CompanyInfo: Record 79;
        CaPexAmt: Decimal;
        VLE: Record 25;
        VLEE: array[6] of Record 25;
        ImpAmt: Decimal;
        MediAmt: Decimal;
        MisAmt: Decimal;
        OtherGrainAmt: Decimal;
        ServiAmt: Decimal;
        SoyaAmt: Decimal;
        NullAmt: Decimal;
        Vare: Text;
        DueCapxAmt: Decimal;
        NewDate: Date;
        CapxAmt1Month: Decimal;
        NewDate1: Date;
        NewDate2: Date;
        CapxAmt2Month: Decimal;
        CapxAmt3Month: Decimal;
        CapxAmt4Month: Decimal;
        CapxAmt5Month: Decimal;
        SoyaAmt1Month: Decimal;
        SoyaAmt2Month: Decimal;
        SoyaAmt3Month: Decimal;
        SoyaAmt4Month: Decimal;
        SoyaAmt5Month: Decimal;
        OtherGrainAmt1Month: Decimal;
        OtherGrainAmt2Month: Decimal;
        OtherGrainAmt3Month: Decimal;
        OtherGrainAmt4Month: Decimal;
        OtherGrainAmt5Month: Decimal;
        MediAmt1Month: Decimal;
        MediAmt2Month: Decimal;
        MediAmt3Month: Decimal;
        MediAmt4Month: Decimal;
        MediAmt5Month: Decimal;
        ServiceAmt1Month: Decimal;
        ServiceAmt2Month: Decimal;
        ServiceAmt3Month: Decimal;
        ServiceAmt4Month: Decimal;
        ServiceAmt5Month: Decimal;
        ImportAmt1Month: Decimal;
        ImportAmt2Month: Decimal;
        ImportAmt3Month: Decimal;
        ImportAmt4Month: Decimal;
        ImportAmt5Month: Decimal;
        MiscAmt1Month: Decimal;
        MiscAmt2Month: Decimal;
        MiscAmt3Month: Decimal;
        MiscAmt4Month: Decimal;
        MiscAmt5Month: Decimal;
        NullAmt1Month: Decimal;
        NullAmt2Month: Decimal;
        NullAmt3Month: Decimal;
        NullAmt4Month: Decimal;
        NullAmt5Month: Decimal;
        MaizeAmt: Decimal;
        BajraAmt: Decimal;
        WheatAmt: Decimal;
        MustardAmt: Decimal;
        DDGSAmt: Decimal;
        DeoiledRiceAmt: Decimal;
        MaizeAmt1Month: Decimal;
        MaizeAmt2Month: Decimal;
        MaizeAmt3Month: Decimal;
        MaizeAmt4Month: Decimal;
        MaizeAmt5Month: Decimal;
        BajraAmt1Month: Decimal;
        BajraAmt2Month: Decimal;
        BajraAmt3Month: Decimal;
        BajraAmt4Month: Decimal;
        BajraAmt5Month: Decimal;
        WheatAmt1Month: Decimal;
        WheatAmt2Month: Decimal;
        WheatAmt3Month: Decimal;
        WheatAmt4Month: Decimal;
        WheatAmt5Month: Decimal;
        MustardAmt1Month: Decimal;
        MustardAmt2Month: Decimal;
        MustardAmt3Month: Decimal;
        MustardAmt4Month: Decimal;
        MustardAmt5Month: Decimal;
        DDGSAmt1Month: Decimal;
        DDGSAmt2Month: Decimal;
        DDGSAmt3Month: Decimal;
        DDGSAmt4Month: Decimal;
        DDGSAmt5Month: Decimal;
        DeoiledRiceAmt1Month: Decimal;
        DeoiledRiceAmt2Month: Decimal;
        DeoiledRiceAmt3Month: Decimal;
        DeoiledRiceAmt4Month: Decimal;
        DeoiledRiceAmt5Month: Decimal;
        ViewCreditorType: Boolean;
        BirdsAmt: Decimal;
        BirdsAmt1Month: Decimal;
        BirdsAmt2Month: Decimal;
        BirdsAmt3Month: Decimal;
        BirdsAmt4Month: Decimal;
        BirdsAmt5Month: Decimal;
        ChicksAmt: Decimal;
        ChicksAmt1Month: Decimal;
        ChicksAmt2Month: Decimal;
        ChicksAmt3Month: Decimal;
        ChicksAmt4Month: Decimal;
        ChicksAmt5Month: Decimal;
        GenItemAmt: Decimal;
        GenItem1Month: Decimal;
        GenItem2Month: Decimal;
        GenItem3Month: Decimal;
        GenItem4Month: Decimal;
        GenItem5Month: Decimal;
        HatchingEggOutsideAmt: Decimal;
        HatchingEggOutside1Month: Decimal;
        HatchingEggOutside2Month: Decimal;
        HatchingEggOutside3Month: Decimal;
        HatchingEggOutside4Month: Decimal;
        HatchingEggOutside5Month: Decimal;
        PremixAmt: Decimal;
        Premix1Month: Decimal;
        Premix2Month: Decimal;
        Premix3Month: Decimal;
        Premix4Month: Decimal;
        Premix5Month: Decimal;
        RiceBranOilAmt: Decimal;
        RiceBranOil1Month: Decimal;
        RiceBranOil2Month: Decimal;
        RiceBranOil3Month: Decimal;
        RiceBranOil4Month: Decimal;
        RiceBranOil5Month: Decimal;
        RiceBranPolishAmt: Decimal;
        RiceBranPolish1Month: Decimal;
        RiceBranPolish2Month: Decimal;
        RiceBranPolish3Month: Decimal;
        RiceBranPolish4Month: Decimal;
        RiceBranPolish5Month: Decimal;
        RiceKanniAmt: Decimal;
        RiceKanni1Month: Decimal;
        RiceKanni2Month: Decimal;
        RiceKanni3Month: Decimal;
        RiceKanni4Month: Decimal;
        RiceKanni5Month: Decimal;
        LimeStonePowerAmt: Decimal;
        LimeStonePower1Month: Decimal;
        LimeStonePower2Month: Decimal;
        LimeStonePower3Month: Decimal;
        LimeStonePower4Month: Decimal;
        LimeStonePower5Month: Decimal;
        GaurMealAmt: Decimal;
        GaurMeal1Month: Decimal;
        GaurMeal2Month: Decimal;
        GaurMeal3Month: Decimal;
        GaurMeal4Month: Decimal;
        GaurMeal5Month: Decimal;
        ChickenWasteMealAmt: Decimal;
        ChickenWasteMeal1Month: Decimal;
        ChickenWasteMeal2Month: Decimal;
        ChickenWasteMeal3Month: Decimal;
        ChickenWasteMeal4Month: Decimal;
        ChickenWasteMeal5Month: Decimal;
        PPBagsAmt: Decimal;
        PPBags1Month: Decimal;
        PPBags2Month: Decimal;
        PPBags3Month: Decimal;
        PPBags4Month: Decimal;
        PPBags5Month: Decimal;
        OtherAmt: Decimal;
        Other1Month: Decimal;
        Other2Month: Decimal;
        Other3Month: Decimal;
        Other4Month: Decimal;
        Other5Month: Decimal;

    local procedure CalcDates()
    var
        i: Integer;
        PeriodLength2: DateFormula;
    begin
        IF NOT EVALUATE(PeriodLength2, STRSUBSTNO(Text027, PeriodLength)) THEN
            ERROR(EnterDateFormulaErr);
        IF AgingBy = AgingBy::"Due Date" THEN BEGIN
            PeriodEndDate[1] := 99991231D;
            PeriodStartDate[1] := EndingDate + 1;
        END ELSE BEGIN
            PeriodEndDate[1] := EndingDate;
            PeriodStartDate[1] := CALCDATE(PeriodLength2, EndingDate + 1);
        END;
        FOR i := 2 TO ARRAYLEN(PeriodEndDate) DO BEGIN
            PeriodEndDate[i] := PeriodStartDate[i - 1] - 1;
            PeriodStartDate[i] := CALCDATE(PeriodLength2, PeriodEndDate[i] + 1);
        END;

        i := ARRAYLEN(PeriodEndDate);

        PeriodStartDate[i] := 0D;

        FOR i := 1 TO ARRAYLEN(PeriodEndDate) DO
            IF PeriodEndDate[i] < PeriodStartDate[i] THEN
                ERROR(Text010, PeriodLength);
    end;

    local procedure CreateHeadings()
    var
        i: Integer;
    begin
        IF AgingBy = AgingBy::"Due Date" THEN BEGIN
            HeaderText[1] := Text000;
            i := 2;
        END ELSE
            i := 1;
        WHILE i < ARRAYLEN(PeriodEndDate) DO BEGIN
            IF HeadingType = HeadingType::"Date Interval" THEN
                HeaderText[i] := STRSUBSTNO('%1\..%2', PeriodStartDate[i], PeriodEndDate[i])
            ELSE
                HeaderText[i] :=
                  STRSUBSTNO('%1 - %2 %3', EndingDate - PeriodEndDate[i] + 1, EndingDate - PeriodStartDate[i] + 1, Text002);
            i := i + 1;
        END;
        IF HeadingType = HeadingType::"Date Interval" THEN
            HeaderText[i] := STRSUBSTNO('%1\%2', Text001, PeriodStartDate[i - 1])
        ELSE
            HeaderText[i] := STRSUBSTNO('%1\%2 %3', Text003, EndingDate - PeriodStartDate[i - 1] + 1, Text002);
    end;

    local procedure InsertTemp(var VendorLedgEntry: Record 25)
    var
        Currency: Record 4;
    begin
        WITH TempVendorLedgEntry DO BEGIN
            IF GET(VendorLedgEntry."Entry No.") THEN
                EXIT;
            TempVendorLedgEntry := VendorLedgEntry;
            INSERT;
            IF PrintAmountInLCY THEN BEGIN
                CLEAR(TempCurrency);
                TempCurrency."Amount Rounding Precision" := GLSetup."Amount Rounding Precision";
                IF TempCurrency.INSERT THEN;
                EXIT;
            END;
            IF TempCurrency.GET("Currency Code") THEN
                EXIT;
            IF "Currency Code" <> '' THEN
                Currency.GET("Currency Code")
            ELSE BEGIN
                CLEAR(Currency);
                Currency."Amount Rounding Precision" := GLSetup."Amount Rounding Precision";
            END;
            TempCurrency := Currency;
            TempCurrency.INSERT;
        END;
    end;

    local procedure GetPeriodIndex(Date: Date): Integer
    var
        i: Integer;
    begin
        FOR i := 1 TO ARRAYLEN(PeriodEndDate) DO
            IF "Date" IN [PeriodStartDate[i] .. PeriodEndDate[i]] THEN
                EXIT(i);
    end;

    local procedure UpdateCurrencyTotals()
    var
        i: Integer;
    begin
        TempCurrency2."Code" := "CurrencyCode";
        IF TempCurrency2.INSERT THEN;
        WITH TempCurrencyAmount DO BEGIN
            FOR i := 1 TO ARRAYLEN(TotalVendorLedgEntry) DO BEGIN
                "Currency Code" := "CurrencyCode";
                "Date" := PeriodStartDate[i];
                IF FIND THEN BEGIN
                    "Amount" := "Amount" + TotalVendorLedgEntry[i]."Remaining Amount";
                    MODIFY;
                END ELSE BEGIN
                    "Currency Code" := "CurrencyCode";
                    "Date" := PeriodStartDate[i];
                    "Amount" := TotalVendorLedgEntry[i]."Remaining Amount";
                    INSERT;
                END;
            END;
            "Currency Code" := "CurrencyCode";
            "Date" := 99991231D;
            IF FIND THEN BEGIN
                "Amount" := "Amount" + TotalVendorLedgEntry[1]."Amount";
                MODIFY;
            END ELSE BEGIN
                "Currency Code" := "CurrencyCode";
                "Date" := 99991231D;
                "Amount" := TotalVendorLedgEntry[1]."Amount";
                INSERT;
            END;
        END;
    end;


    procedure InitializeRequest(NewEndingDate: Date; NewAgingBy: Option; NewPeriodLength: DateFormula; NewPrintAmountInLCY: Boolean; NewPrintDetails: Boolean; NewHeadingType: Option; NewNewPagePerVendor: Boolean)
    begin
        EndingDate := NewEndingDate;
        AgingBy := NewAgingBy;
        PeriodLength := NewPeriodLength;
        PrintAmountInLCY := NewPrintAmountInLCY;
        PrintDetails := NewPrintDetails;
        HeadingType := NewHeadingType;
        NewPagePerVendor := NewNewPagePerVendor;
    end;
}

