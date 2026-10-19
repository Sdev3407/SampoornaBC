namespace Sampoorna_BC.Sampoorna_BC;

using System.Utilities;
using Microsoft.Finance.ReceivablesPayables;
using Microsoft.Purchases.Document;
using Microsoft.Finance.GeneralLedger.Journal;
using Microsoft.Sales.Document;
using Microsoft.Purchases.Payables;
using Microsoft.Sales.Receivables;
using Microsoft.Inventory.Item;
using Microsoft.Inventory.Ledger;
using Microsoft.Sales.History;

report 50140 "Purch Sales Summary"
{
    ApplicationArea = All;
    Caption = 'Purch Sales Summary';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'ReportLayout\Purch Sales Summary.rdl';

    dataset
    {
        dataitem(Integer; "Integer")
        {
            DataItemTableView = where(Number = filter(1));
            column(Yesterday; Format((WorkDate() - 1)))
            { }
            column(DayAfterYesterday; Format((WorkDate() - 2)))
            { }
            column(LastMonthYesterday; Format(LastMonthtillYesterday))
            { }
            column(LastMonthDayafterYesterday; Format(LastMonthtillYesterday - 1))
            { }

            column(FeedProduction1d; Round(Proddetail[1], 0.01))
            { }
            column(FeedProduction2d; Round(Proddetail[2], 0.01))
            { }
            column(EggProduction1d; Round(Proddetail[3], 0.01))
            { }
            column(EggProduction2d; Round(Proddetail[4], 0.01))
            { }
            column(ChickProduction1d; Round(Proddetail[5], 0.01))
            { }
            column(ChickProduction2d; Round(Proddetail[6], 0.01))
            { }
            column(PurchQtyMaize1d; Round(PurchDetailQty[1], 0.01))
            { }
            column(PurchQtyMaize2d; Round(PurchDetailQty[2], 0.01))
            { }
            column(PurchQtySoya1d; Round(PurchDetailQty[3], 0.01))
            { }
            column(PurchQtySoya2d; Round(PurchDetailQty[4], 0.01))
            { }
            column(PurchQtyBajra1d; Round(PurchDetailQty[5], 0.01))
            { }
            column(PurchQtyBajra2d; Round(PurchDetailQty[6], 0.01))
            { }
            column(allPurchase; Round(PurchDetailAmt[7], 0.01))
            { }
            column(allPurchaseYesterday; Round(PurchDetailAmt[8], 0.01))
            { }
            column(PurchRateMaize1d; Round(PurchDetailRate[1], 0.01))
            { }
            column(PurchRateMaize2d; Round(PurchDetailRate[2], 0.01))
            { }
            column(PurchRateSoya1d; Round(PurchDetailRate[3], 0.01))
            { }
            column(PurchRateSoya2d; Round(PurchDetailRate[4], 0.01))
            { }
            column(PurchRateBajra1d; Round(PurchDetailRate[5], 0.01))
            { }
            column(PurchRateBajra2d; Round(PurchDetailRate[6], 0.01))
            { }
            column(SalesQtyCBF1d; Round(SalesDetailQty[1], 0.01))
            { }
            column(SalesQtyCB2dF; Round(SalesDetailQty[2], 0.01))
            { }
            column(SalesQtyEgg1D; Round(SalesDetailQty[3], 0.01))
            { }
            column(SalesQtyEgg2D; Round(SalesDetailQty[4], 0.01))
            { }
            column(SalesQtyChicks1D; Round(SalesDetailQty[5], 0.01))
            { }
            column(SalesQtyChicks2D; Round(SalesDetailQty[6], 0.01))
            { }
            column(SalesQtyCullBirdMale1D; Round(SalesDetailQty[7], 0.01))
            { }
            column(SalesQtyCullBirdMale2D; Round(SalesDetailQty[8], 0.01))
            { }
            column(SalesQtyCullBirdFemale1D; Round(SalesDetailQty[9], 0.01))
            { }
            column(SalesQtyCullBirdFemale2D; Round(SalesDetailQty[10], 0.01))
            { }
            column(SalesAlternateQtyCBF1D; Round(SalesAlternateQty[1], 0.01))
            { }
            column(SalesAlternateQtyCBF2D; Round(SalesAlternateQty[2], 0.01))
            { }
            column(SalesAlternateQtyCullBirdMale1D; Round(SalesAlternateQty[7], 0.01))
            { }
            column(SalesAlternateQtyCullBirdMale2D; Round(SalesAlternateQty[8], 0.01))
            { }
            column(SalesAlternateQtyCullBirdFemale1D; Round(SalesAlternateQty[9], 0.01))
            { }
            column(SalesAlternateQtyCullBirdFemale2D; Round(SalesAlternateQty[10], 0.01))
            { }
            column(SalesRateCBF1D; Round(SalesDetailRate[1], 0.01))
            { }
            column(SalesRateCBF2D; Round(SalesDetailRate[2], 0.01))
            { }
            column(SalesRateEgg1D; Round(SalesDetailRate[3], 0.01))
            { }
            column(SalesRateEgg2D; Round(SalesDetailRate[4], 0.01))
            { }
            column(SalesRateChicks1D; Round(SalesDetailRate[5], 0.01))
            { }
            column(SalesRateChicks2D; Round(SalesDetailRate[6], 0.01))
            { }
            column(SalesRateCullBirdMale1D; Round(SalesDetailRate[7], 0.01))
            { }
            column(SalesRateCullBirdMale2D; SalesDetailRate[8])
            { }
            column(SalesRateCullBirdFemale1D; SalesDetailRate[9])
            { }
            column(SalesRateCullBirdFemale2D; SalesDetailRate[10])
            { }
            column(SalesAvgWtCBF1d; SalesDetailAvgWt[1])
            { }
            column(SalesAvgWtCB2dF; SalesDetailAvgWt[2])
            { }
            column(SalesAvgWtCullBirdMale1D; SalesDetailAvgWt[7])
            { }
            column(SalesAvgWtCullBirdMale2D; SalesDetailAvgWt[8])
            { }
            column(SalesAvgWtCullBirdFemale1D; SalesDetailAvgWt[9])
            { }
            column(SalesAvgWtCullBirdFemale2D; SalesDetailAvgWt[10])
            { }
            column(ILEQtyBFUpto1D; ILEQty[1])
            { }
            column(ILEQtyLFUpto1D; ILEQty[3])
            { }

            column(ILEQtyLLPFUpto1D; ILEQty[5])
            { }
            column(ILEQtyCFUpto1D; ILEQty[7])
            { }
            column(ILEQtyBRFUpto1D; ILEQty[9])
            { }
            column(ILEQtyOthersUpto1D; ILEQty[11])
            { }
            column(ILEQtyBF1d; ILEQty[2])
            { }
            column(ILEQtyLF1d; ILEQty[4])
            { }
            column(ILEQtyLLPF1d; ILEQty[6])
            { }
            column(ILEQtyCF1d; ILEQty[8])
            { }
            column(ILEQtyBRF1d; ILEQty[10])
            { }
            column(ILEQtyOthers1D; ILEQty[12])
            { }
            column(BFLastMonthTillYesterDay; LMSamePeriodforSale[1])
            { }
            column(LFLastMonthTillYesterDay; LMSamePeriodforSale[3])
            { }
            column(LLPLastMonthTillYesterDay; LMSamePeriodforSale[5])
            { }
            column(CFLastMonthTillYesterDay; LMSamePeriodforSale[7])
            { }

            column(BRFLastMonthTillYesterDay; LMSamePeriodforSale[9])
            { }
            column(BFLastMonthYesterDay; LMSamePeriodforSale[2])
            { }
            column(LFLastMonthYesterDay; LMSamePeriodforSale[4])
            { }
            column(LLPLastMonthYesterDay; LMSamePeriodforSale[6])
            { }
            column(CFLastMonthYesterDay; LMSamePeriodforSale[8])
            { }

            column(BRFLastMonthYesterDay; LMSamePeriodforSale[10])
            { }
            column(DetailCustomAmountFeed1d; Round(DetailCustomAmount[1], 0.01))
            { }
            column(DetailCustomAmountFeed2d; Round(DetailCustomAmount[2], 0.01))
            { }
            column(DetailCustomAmountCBF1d; Round(DetailCustomAmount[3], 0.01))
            { }
            column(DetailCustomAmountCBF2d; Round(DetailCustomAmount[4], 0.01))
            { }
            column(DetailCustomAmountBreeder1d; Round(DetailCustomAmount[5], 0.01))
            { }
            column(DetailCustomAmountBreeder2d; Round(DetailCustomAmount[6], 0.01))
            { }
            column(DetailCustomAmountHatch1d; Round(DetailCustomAmount[7], 0.01))
            { }
            column(DetailCustomAmountHatch2d; Round(DetailCustomAmount[8], 0.01))
            { }
            column(DetailCustomAmountCattle1d; Round(DetailCustomAmount[9], 0.01))
            { }
            column(DetailCustomAmountCattle2d; Round(DetailCustomAmount[10], 0.01))
            { }
            column(LMDetailCustomAmountFeed1d; Round(LMDetailCustomAmount[1], 0.01))
            { }
            column(LMDetailCustomAmountFeed2d; Round(LMDetailCustomAmount[2], 0.01))
            { }
            column(LMDetailCustomAmountCBF1d; Round(LMDetailCustomAmount[3], 0.01))
            { }
            column(LMDetailCustomAmountCBF2d; Round(LMDetailCustomAmount[4], 0.01))
            { }
            column(LMDetailCustomAmountBreeder1d; Round(LMDetailCustomAmount[5], 0.01))
            { }
            column(LMDetailCustomAmountBreeder2d; Round(LMDetailCustomAmount[6], 0.01))
            { }
            column(LMDetailCustomAmountHatch1d; Round(LMDetailCustomAmount[7], 0.01))
            { }
            column(LMDetailCustomAmountHatch2d; Round(LMDetailCustomAmount[8], 0.01))
            { }
            column(LMDetailCustomAmountCattle1d; Round(LMDetailCustomAmount[8], 0.01))
            { }
            column(LMDetailCustomAmountCattle2d; Round(LMDetailCustomAmount[9], 0.01))
            { }
            column(DetailPaymentAmountFeed1d; Round(DetailPaymentAmount[1], 0.01))
            { }
            column(DetailPaymentAmountFeed2d; Round(DetailPaymentAmount[2], 0.01))
            { }
            column(DetailPaymentAmountCBF1d; Round(DetailPaymentAmount[3], 0.01))
            { }
            column(DetailPaymentAmountCBF2d; Round(DetailPaymentAmount[4], 0.01))
            { }
            column(DetailPaymentAmountBreederHatch1d; Round(DetailPaymentAmount[5], 0.01))
            { }
            column(DetailPaymentAmountBreederHatch2d; Round(DetailPaymentAmount[6], 0.01))
            { }
            column(DetailPaymentAmountCattle1d; Round(DetailPaymentAmount[7], 0.01))
            { }
            column(DetailPaymentAmountCattle2d; Round(DetailPaymentAmount[8], 0.01))
            { }
            column(LMDetailPaymentAmountFeed1d; Round(LMDetailPaymentAmount[1], 0.01))
            { }
            column(LMDetailPaymentAmountFeed2d; Round(LMDetailPaymentAmount[2], 0.01))
            { }
            column(LMDetailPaymentAmountCBF1d; Round(LMDetailPaymentAmount[3], 0.01))
            { }
            column(LMDetailPaymentAmountCBF2d; Round(LMDetailPaymentAmount[4], 0.01))
            { }
            column(LMDetailPaymentAmountBreederHatch1d; Round(LMDetailPaymentAmount[5], 0.01))
            { }
            column(LMDetailPaymentAmountBreederHatch2d; Round(LMDetailPaymentAmount[6], 0.01))
            { }
            column(LMDetailPaymentAmountCattle1d; Round(LMDetailPaymentAmount[7], 0.01))
            { }
            column(LMDetailPaymentAmountCattle2d; Round(LMDetailPaymentAmount[8], 0.01))
            { }


            column(DetailVenPaymentAmountFeed1d; Round(DetailVenPaymentAmount[1], 0.01))
            { }
            column(DetailVenPaymentAmountFeed2d; Round(DetailVenPaymentAmount[2], 0.01))
            { }
            column(DetailVenPaymentAmountCBF1d; Round(DetailVenPaymentAmount[3], 0.01))
            { }
            column(DetailVenPaymentAmountCBF2d; Round(DetailVenPaymentAmount[4], 0.01))
            { }
            column(DetailVenPaymentAmountBreederHatch1d; Round(DetailVenPaymentAmount[5], 0.01))
            { }
            column(DetailVenPaymentAmountBreederHatch2d; Round(DetailVenPaymentAmount[6], 0.01))
            { }
            column(DetailVenPaymentAmountCattle1d; Round(DetailVenPaymentAmount[7], 0.01))
            { }
            column(DetailVenPaymentAmountCattle2d; Round(DetailVenPaymentAmount[8], 0.01))
            { }

            column(LMDetailVenPaymentAmountFeed1d; Round(LMDetailVenPaymentAmount[1], 0.01))
            { }
            column(LMDetailVenPaymentAmountFeed2d; Round(LMDetailVenPaymentAmount[2], 0.01))
            { }
            column(LMDetailVenPaymentAmountCBF1d; Round(LMDetailVenPaymentAmount[3], 0.01))
            { }
            column(LMDetailVenPaymentAmountCBF2d; Round(LMDetailVenPaymentAmount[4], 0.01))
            { }
            column(LMDetailVenPaymentAmountBreederHatch1d; Round(LMDetailVenPaymentAmount[5], 0.01))
            { }
            column(LMDetailVenPaymentAmountBreederHatch2d; Round(LMDetailVenPaymentAmount[6], 0.01))
            { }
            column(LMDetailVenPaymentAmountCattle1d; Round(LMDetailVenPaymentAmount[7], 0.01))
            { }
            column(LMDetailVenPaymentAmountCattle2d; Round(LMDetailVenPaymentAmount[8], 0.01))
            { }

            column(OrderReceivedBF1d; OrderReceived[1])
            { }
            column(OrderShippedBF1D; OrderShipped[1])
            { }
            column(OrderReceivedCF1d; OrderReceived[2])
            { }
            column(OrderShippedCF1D; OrderShipped[2])
            { }
            column(OrderReceivedBF2d; OrderReceived[3])
            { }
            column(OrderShippedBF2D; OrderShipped[3])
            { }
            column(OrderReceivedCF2d; OrderReceived[4])
            { }
            column(OrderShippedCF2D; OrderShipped[4])
            { }
            column(CurrentMonthtoLastMonthCollectionFEED; CMFYtolastmonth[1])
            { }
            column(CurrentMonthtoLastMonthCollectionCBF; CMFYtolastmonth[2])
            { }
            column(CurrentMonthtoLastMonthCollectionBREEDER; CMFYtolastmonth[3])
            { }
            column(CurrentMonthtoLastMonthCollectionHATCH; CMFYtolastmonth[4])
            { }
            trigger OnAfterGetRecord()
            var
                PurchLine: Record "Purchase Line";
                SalesInvLine: Record "Sales Invoice Line";
                SalesInvHead: Record "Sales Invoice Header";
                ItemLedgEntry: Record "Item Ledger Entry";
                Item: Record Item;
                DetailCustLedgEntry: Record "Detailed Cust. Ledg. Entry";
                DetailVendLedgEntry: Record "Detailed Vendor Ledg. Entry";
                CustLedgerEntry: Record "Cust. Ledger Entry";
                VendLedgerEntry: Record "Vendor Ledger Entry";
                SalesLine: Record "Sales Line";
                SalesHeader: Record "Sales Header";
                ItemFilter: Text;
                ItemFIlter1: Text;

            begin

                LastMonthtillYesterday := CalcDate('-1M', (WorkDate() - 1));
                //LastMonthDayaftertillYesterday:= CalcDate('-1M', (WorkDate() - 1))
                //Purchase Detail
                Clear(PurchLine);
                Clear(i);
                //Maize
                begin
                    //Purchase Qty & Rate
                    i += 1;

                    PurchLine.Reset();
                    PurchLine.SetFilter("No.", 'RM00024');
                    PurchLine.SetRange("Document Type", PurchLine."Document Type"::Order);
                    PurchLine.SetRange(Type, PurchLine.Type::Item);
                    PurchLine.SetRange("Order Date", WorkDate() - 1);
                    if PurchLine.FindSet() then begin
                        PurchLine.CalcSums("Quantity (Base)");
                        PurchLine.CalcSums(Amount);
                        PurchLine.CalcSums(Quantity);
                        PurchDetailRate[i] := PurchLine.Amount / PurchLine.Quantity;
                        PurchDetailQty[i] := PurchLine."Quantity (Base)" / 1000;
                        PurchDetailAmt[i] := PurchLine.Amount / 10000000;

                    end;

                    // If PurchLine.FindFirst() then begin
                    //     PurchDetailRate[i] := PurchLine."Unit Cost";
                    // end;

                    i += 1;
                    PurchLine.SetRange("Order Date", WorkDate() - 2);
                    if PurchLine.FindSet() then begin
                        PurchLine.CalcSums("Quantity (Base)");
                        PurchLine.CalcSums(Amount);
                        PurchLine.CalcSums(Quantity);
                        PurchDetailRate[i] := PurchLine.Amount / PurchLine.Quantity;
                        PurchDetailQty[i] := PurchLine."Quantity (Base)" / 1000;
                        PurchDetailAmt[i] := PurchLine.Amount / 10000000;
                    end;
                    // If PurchLine.FindFirst() then begin
                    //     PurchDetailRate[i] := PurchLine."Unit Cost";
                    // end;


                end;

                //Soya
                begin
                    //Purchase Qty & Rate
                    i += 1;
                    PurchLine.Reset();
                    PurchLine.SetFilter("No.", 'RM00038');
                    PurchLine.SetRange(Type, PurchLine.Type::Item);
                    PurchLine.SetRange("Document Type", PurchLine."Document Type"::Order);
                    PurchLine.SetRange("Order Date", WorkDate() - 1);
                    if PurchLine.FindSet() then begin
                        PurchLine.CalcSums("Quantity (Base)");
                        PurchLine.CalcSums(Amount);
                        PurchLine.CalcSums(Quantity);
                        PurchDetailRate[i] := PurchLine.Amount / PurchLine.Quantity;
                        PurchDetailQty[i] := PurchLine."Quantity (Base)" / 1000;
                        PurchDetailAmt[i] := PurchLine.Amount;
                    end;

                    // If PurchLine.FindFirst() then begin
                    //     PurchDetailRate[i] := PurchLine."Unit Cost";
                    // end;

                    i += 1;
                    PurchLine.SetRange("Order Date", WorkDate() - 2);
                    if PurchLine.FindSet() then begin
                        PurchLine.CalcSums("Quantity (Base)");
                        PurchLine.CalcSums(Amount);
                        PurchLine.CalcSums(Quantity);
                        PurchDetailRate[i] := PurchLine.Amount / PurchLine.Quantity;
                        PurchDetailQty[i] := PurchLine."Quantity (Base)" / 1000;
                        PurchDetailAmt[i] := PurchLine.Amount;
                    end;

                    // If PurchLine.FindFirst() then begin
                    //     PurchDetailRate[i] := PurchLine."Unit Cost";
                    // end;
                end;

                //Bajra
                begin
                    //Purchase Qty & Rate
                    i += 1;
                    PurchLine.Reset();
                    PurchLine.SetFilter("No.", 'RM00004');
                    PurchLine.SetRange(Type, PurchLine.Type::Item);
                    PurchLine.SetRange("Document Type", PurchLine."Document Type"::Order);
                    PurchLine.SetRange("Order Date", WorkDate() - 1);
                    if PurchLine.FindSet() then begin
                        PurchLine.CalcSums("Quantity (Base)");
                        PurchLine.CalcSums(Amount);
                        PurchLine.CalcSums(Quantity);
                        PurchDetailRate[i] := PurchLine.Amount / PurchLine.Quantity;
                        PurchDetailQty[i] := PurchLine."Quantity (Base)" / 1000;
                        PurchDetailAmt[i] := PurchLine.Amount;
                    end;

                    // If PurchLine.FindFirst() then begin
                    //     PurchDetailRate[i] := PurchLine."Unit Cost";
                    // end;
                    i += 1;
                    PurchLine.SetRange("Order Date", WorkDate() - 2);
                    if PurchLine.FindSet() then begin
                        PurchLine.CalcSums("Quantity (Base)");
                        PurchLine.CalcSums(Amount);
                        PurchLine.CalcSums(Quantity);
                        PurchDetailRate[i] := PurchLine.Amount / PurchLine.Quantity;
                        PurchDetailQty[i] := PurchLine."Quantity (Base)" / 1000;
                        PurchDetailAmt[i] := PurchLine.Amount;
                    end;

                    // If PurchLine.FindFirst() then begin
                    //     PurchDetailRate[i] := PurchLine."Unit Cost";
                    // end;
                end;
                // All Purchase

                begin
                    //Purchase Qty & Rate
                    i += 1;
                    PurchLine.Reset();
                    //PurchLine.SetFilter("No.", 'RM00004');
                    PurchLine.SetRange(Type, PurchLine.Type::Item);
                    PurchLine.SetRange("Document Type", PurchLine."Document Type"::Order);
                    PurchLine.SetFilter("Item Type", '<>%1', PurchLine."Item Type"::Feed);
                    PurchLine.SetRange("Order Date", WorkDate() - 1);
                    if PurchLine.FindSet() then begin
                        PurchLine.CalcSums("Quantity (Base)");
                        PurchLine.CalcSums(Amount);
                        PurchLine.CalcSums(Quantity);
                        PurchDetailRate[i] := PurchLine.Amount / PurchLine.Quantity;
                        PurchDetailQty[i] := PurchLine."Quantity (Base)" / 1000;
                        PurchDetailAmt[i] := PurchLine.Amount / 10000000;
                    end;

                    // If PurchLine.FindFirst() then begin
                    //     PurchDetailRate[i] := PurchLine."Unit Cost";
                    // end;
                    i += 1;
                    PurchLine.SetRange("Order Date", WorkDate() - 2);
                    if PurchLine.FindSet() then begin
                        PurchLine.CalcSums("Quantity (Base)");
                        PurchLine.CalcSums(Amount);
                        PurchLine.CalcSums(Quantity);
                        PurchDetailRate[i] := PurchLine.Amount / PurchLine.Quantity;
                        PurchDetailQty[i] := PurchLine."Quantity (Base)" / 1000;
                        PurchDetailAmt[i] := PurchLine.Amount / 10000000;
                    end;

                    // If PurchLine.FindFirst() then begin
                    //     PurchDetailRate[i] := PurchLine."Unit Cost";
                    // end;
                end;

                //Purchase Detail

                //Sales Detail
                Clear(SalesInvLine);
                Clear(i);
                //Sale CBF
                begin
                    //Sales Qty & Rate
                    i += 1;
                    //SalesInvHead.Get(SalesInvLine."Document No.");
                    SalesInvLine.Reset();
                    SalesInvLine.SetFilter("No.", 'CBFBB01');
                    SalesInvLine.SetRange(Type, SalesInvLine.Type::Item);
                    //SalesInvLine.SetFilter("Posting Group", '%1', 'DOMESTIC');
                    SalesInvLine.SetRange("Posting Date", WorkDate() - 1);
                    if SalesInvLine.FindSet() then begin
                        SalesInvLine.CalcSums("Quantity (Base)");
                        SalesInvLine.CalcSums("Alternate Quantity");
                        SalesInvLine.CalcSums(Amount);
                        SalesInvLine.CalcSums(Quantity);
                        SalesDetailRate[i] := SalesInvLine.Amount / SalesInvLine.Quantity;
                        SalesDetailQty[i] := SalesInvLine."Quantity (Base)" / 1000;
                        SalesAlternateQty[i] := SalesInvLine."Alternate Quantity";
                        SalesDetailAvgWt[i] := SalesInvLine."Quantity (Base)" / SalesInvLine."Alternate Quantity";
                    end;
                    // if SalesInvLine.FindFirst() then begin
                    //     SalesDetailRate[i] := SalesInvLine."Unit Price";
                    // end;
                    i += 1;

                    SalesInvLine.SetRange("Posting Date", WorkDate() - 2);
                    if SalesInvLine.FindSet() then begin
                        SalesInvLine.CalcSums("Quantity (Base)");
                        SalesInvLine.CalcSums("Alternate Quantity");
                        SalesInvLine.CalcSums(Amount);
                        SalesInvLine.CalcSums(Quantity);
                        SalesDetailRate[i] := SalesInvLine.Amount / SalesInvLine.Quantity;
                        SalesDetailQty[i] := SalesInvLine."Quantity (Base)" / 1000;
                        SalesAlternateQty[i] := SalesInvLine."Alternate Quantity";
                        SalesDetailAvgWt[i] := SalesInvLine."Quantity (Base)" / SalesInvLine."Alternate Quantity";
                    end;

                    // if SalesInvLine.FindFirst() then begin
                    //     SalesDetailRate[i] := SalesInvLine."Unit Price";
                    // end;
                end;

                //Egg Sale
                begin
                    //Sales Qty & Rate
                    i += 1;
                    SalesInvLine.Reset();
                    SalesInvLine.SetFilter("No.", 'EGCOMM|EGCRACK|EGHATCH|EGHATCH_O|EGINFERT|EGJUMBO|EGSHAPE|EGWASTE');
                    SalesInvLine.SetRange(Type, SalesInvLine.Type::Item);
                    SalesInvLine.SetRange("Posting Date", WorkDate() - 1);
                    //SalesInvLine.SetFilter("Posting Group", '%1', 'DOMESTIC');
                    if SalesInvLine.FindSet() then begin
                        SalesInvLine.CalcSums("Quantity (Base)");
                        SalesInvLine.CalcSums(Amount);
                        SalesInvLine.CalcSums(Quantity);
                        SalesDetailRate[i] := SalesInvLine.Amount / SalesInvLine.Quantity;
                        SalesDetailQty[i] := SalesInvLine."Quantity (Base)";
                    end;
                    // if SalesInvLine.FindFirst() then begin
                    //     SalesDetailRate[i] := SalesInvLine."Unit Price";
                    // end;

                    i += 1;

                    SalesInvLine.SetRange("Posting Date", WorkDate() - 2);
                    if SalesInvLine.FindSet() then begin
                        SalesInvLine.CalcSums("Quantity (Base)");
                        SalesInvLine.CalcSums(Amount);
                        SalesInvLine.CalcSums(Quantity);
                        SalesDetailRate[i] := SalesInvLine.Amount / SalesInvLine.Quantity;
                        SalesDetailQty[i] := SalesInvLine."Quantity (Base)";
                    end;


                    // if SalesInvLine.FindFirst() then begin
                    //     SalesDetailRate[i] := SalesInvLine."Unit Price";
                    // end;
                end;

                //Chicks Sales
                begin
                    //Sales Qty & Rate
                    i += 1;
                    SalesInvLine.Reset();
                    SalesInvLine.SetFilter("No.", 'BRDOC|BRDOCP|BRDOC_E|BREFC01|BREMC01');
                    SalesInvLine.SetRange(Type, SalesInvLine.Type::Item);
                    SalesInvLine.SetRange("Posting Date", WorkDate() - 1);
                    //SalesInvLine.SetFilter("Posting Group", '%1', 'DOMESTIC');
                    if SalesInvLine.FindSet() then begin
                        SalesInvLine.CalcSums("Quantity (Base)");
                        SalesInvLine.CalcSums(Amount);
                        SalesInvLine.CalcSums(Quantity);
                        SalesDetailRate[i] := SalesInvLine.Amount / SalesInvLine.Quantity;
                        SalesDetailQty[i] := SalesInvLine."Quantity (Base)";
                    end;

                    // if SalesInvLine.FindFirst() then begin
                    //     SalesDetailRate[i] := SalesInvLine."Unit Price";
                    // end;

                    i += 1;

                    SalesInvLine.SetRange("Posting Date", WorkDate() - 2);
                    if SalesInvLine.FindSet() then begin
                        SalesInvLine.CalcSums("Quantity (Base)");
                        SalesInvLine.CalcSums(Amount);
                        SalesInvLine.CalcSums(Quantity);
                        SalesDetailRate[i] := SalesInvLine.Amount / SalesInvLine.Quantity;
                        SalesDetailQty[i] := SalesInvLine."Quantity (Base)";
                    end;


                    // if SalesInvLine.FindFirst() then begin
                    //     SalesDetailRate[i] := SalesInvLine."Unit Price";
                    // end;
                end;

                //Cull Bird Male
                begin
                    //Sales Qty & Rate
                    i += 1;
                    SalesInvLine.Reset();
                    SalesInvLine.SetFilter("No.", 'BRCBM002');
                    SalesInvLine.SetRange(Type, SalesInvLine.Type::Item);
                    SalesInvLine.SetRange("Posting Date", WorkDate() - 1);
                    //SalesInvLine.SetFilter("Posting Group", '%1', 'DOMESTIC');
                    if SalesInvLine.FindSet() then begin
                        SalesInvLine.CalcSums("Quantity (Base)");
                        SalesInvLine.CalcSums("Alternate Quantity");
                        SalesInvLine.CalcSums(Amount);
                        SalesInvLine.CalcSums(Quantity);
                        SalesDetailRate[i] := SalesInvLine.Amount / SalesInvLine.Quantity;
                        SalesDetailQty[i] := SalesInvLine."Quantity (Base)" / 1000;
                        SalesAlternateQty[i] := SalesInvLine."Alternate Quantity";
                        If (SalesInvLine."Alternate Quantity" <> 0) Then
                            SalesDetailAvgWt[i] := SalesInvLine."Quantity (Base)" / SalesInvLine."Alternate Quantity";
                    end;

                    // if SalesInvLine.FindFirst() then begin
                    //     SalesDetailRate[i] := SalesInvLine."Unit Price";
                    // end;
                    i += 1;

                    SalesInvLine.SetRange("Posting Date", WorkDate() - 2);
                    if SalesInvLine.FindSet() then begin
                        SalesInvLine.CalcSums("Quantity (Base)");
                        SalesInvLine.CalcSums("Alternate Quantity");
                        SalesInvLine.CalcSums(Amount);
                        SalesInvLine.CalcSums(Quantity);
                        SalesDetailRate[i] := SalesInvLine.Amount / SalesInvLine.Quantity;
                        SalesDetailQty[i] := SalesInvLine."Quantity (Base)" / 1000;
                        SalesAlternateQty[i] := SalesInvLine."Alternate Quantity";
                        If (SalesInvLine."Alternate Quantity" <> 0) Then
                            SalesDetailAvgWt[i] := SalesInvLine."Quantity (Base)" / SalesInvLine."Alternate Quantity";
                    end;



                    // if SalesInvLine.FindFirst() then begin
                    //     SalesDetailRate[i] := SalesInvLine."Unit Price";
                    // end;
                end;
                //Cull Bird Female
                begin
                    //Sales Qty & Rate
                    i += 1;
                    SalesInvLine.Reset();
                    SalesInvLine.SetFilter("No.", 'BRCBF001');
                    SalesInvLine.SetRange(Type, SalesInvLine.Type::Item);
                    //SalesInvLine.SetFilter("Posting Group", '%1', 'DOMESTIC');
                    SalesInvLine.SetRange("Posting Date", WorkDate() - 1);
                    if SalesInvLine.FindSet() then begin
                        SalesInvLine.CalcSums("Quantity (Base)");
                        SalesInvLine.CalcSums("Alternate Quantity");
                        SalesInvLine.CalcSums(Amount);
                        SalesInvLine.CalcSums(Quantity);
                        SalesDetailRate[i] := SalesInvLine.Amount / SalesInvLine.Quantity;
                        SalesDetailQty[i] := SalesInvLine."Quantity (Base)" / 1000;
                        SalesAlternateQty[i] := SalesInvLine."Alternate Quantity";
                        If (SalesInvLine."Alternate Quantity" <> 0) Then
                            SalesDetailAvgWt[i] := SalesInvLine."Quantity (Base)" / SalesInvLine."Alternate Quantity";
                    end;

                    // if SalesInvLine.FindFirst() then begin
                    //     SalesDetailRate[i] := SalesInvLine."Unit Price";
                    // end;
                    i += 1;

                    SalesInvLine.SetRange("Posting Date", WorkDate() - 2);
                    if SalesInvLine.FindSet() then begin
                        SalesInvLine.CalcSums("Quantity (Base)");
                        SalesInvLine.CalcSums("Alternate Quantity");
                        SalesInvLine.CalcSums(Amount);
                        SalesInvLine.CalcSums(Quantity);
                        SalesDetailRate[i] := SalesInvLine.Amount / SalesInvLine.Quantity;
                        SalesDetailQty[i] := SalesInvLine."Quantity (Base)" / 1000;
                        SalesAlternateQty[i] := SalesInvLine."Alternate Quantity";
                        If (SalesInvLine."Alternate Quantity" <> 0) Then
                            SalesDetailAvgWt[i] := SalesInvLine."Quantity (Base)" / SalesInvLine."Alternate Quantity";
                    end;



                    // if SalesInvLine.FindFirst() then begin
                    //     SalesDetailRate[i] := SalesInvLine."Unit Price";
                    // end;
                end;
                //Sales Detail

                //Prod Detail

                Clear(i);
                //ILE - BF Sales
                begin
                    i += 1;

                    ItemLedgEntry.Reset;
                    // ItemLedgEntry.SetFilter("Item No.", ItemFilter);
                    ItemLedgEntry.SetRange("Entry Type", ItemLedgEntry."Entry Type"::Output);
                    ItemLedgEntry.SetRange("Item Type", ItemLedgEntry."Item Type"::Feed);
                    //ItemLedgEntry.CalcFields("Cust. Posting Group");

                    ItemLedgEntry.SetRange("Posting Date", WorkDate() - 1);
                    // if ItemLedgEntry.FindSet() then begin
                    ItemLedgEntry.CalcSums(Quantity);
                    Proddetail[i] := ItemLedgEntry.Quantity / 1000;
                    // end;

                    i += 1;
                    ItemLedgEntry.SetRange("Posting Date", WorkDate() - 2);
                    // if ItemLedgEntry.FindSet() then begin
                    ItemLedgEntry.CalcSums(Quantity);
                    Proddetail[i] := ItemLedgEntry.Quantity / 1000;
                    // end;
                end;

                begin
                    i += 1;

                    ItemLedgEntry.Reset;
                    ItemLedgEntry.SetFilter("Item No.", 'EGHATCH|EGHATCH_O');
                    ItemLedgEntry.SetRange("Entry Type", ItemLedgEntry."Entry Type"::Output);
                    ItemLedgEntry.SetRange("Item Type", ItemLedgEntry."Item Type"::Egg);
                    //ItemLedgEntry.CalcFields("Cust. Posting Group");

                    ItemLedgEntry.SetRange("Posting Date", WorkDate() - 1);
                    // if ItemLedgEntry.FindSet() then begin
                    ItemLedgEntry.CalcSums(Quantity);
                    Proddetail[i] := ItemLedgEntry.Quantity;
                    // end;

                    i += 1;
                    ItemLedgEntry.SetRange("Posting Date", WorkDate() - 2);
                    // if ItemLedgEntry.FindSet() then begin
                    ItemLedgEntry.CalcSums(Quantity);
                    Proddetail[i] := ItemLedgEntry.Quantity;
                    // end;
                end;
                begin
                    i += 1;

                    ItemLedgEntry.Reset;
                    ItemLedgEntry.SetFilter("Item No.", 'BRDOC|BRDOC P|BRDOC_E');
                    ItemLedgEntry.SetRange("Entry Type", ItemLedgEntry."Entry Type"::Output);
                    ItemLedgEntry.SetRange("Item Type", ItemLedgEntry."Item Type"::Chick);
                    //ItemLedgEntry.CalcFields("Cust. Posting Group");

                    ItemLedgEntry.SetRange("Posting Date", WorkDate() - 1);
                    // if ItemLedgEntry.FindSet() then begin
                    ItemLedgEntry.CalcSums(Quantity);
                    Proddetail[i] := ItemLedgEntry.Quantity;
                    // end;

                    i += 1;
                    ItemLedgEntry.SetRange("Posting Date", WorkDate() - 2);
                    // if ItemLedgEntry.FindSet() then begin
                    ItemLedgEntry.CalcSums(Quantity);
                    Proddetail[i] := ItemLedgEntry.Quantity;
                    // end;
                end;


                Clear(i);
                //ILE - BF Sales
                begin
                    i += 1;
                    Clear(ItemFilter);
                    ItemFilter := CreateItemFilter(Item.SMSItemType::BF);
                    ItemLedgEntry.Reset;
                    ItemLedgEntry.SetFilter("Item No.", ItemFilter);
                    ItemLedgEntry.SetRange("Entry Type", ItemLedgEntry."Entry Type"::Sale);
                    ItemLedgEntry.SetRange("Item Type", ItemLedgEntry."Item Type"::Feed);
                    ItemLedgEntry.CalcFields("Cust. Posting Group");
                    ItemLedgEntry.SetFilter("Cust. Posting Group", '<>%1', 'INTER BRANCH TRANSFE');
                    ItemLedgEntry.SetRange("Posting Date", CalcDate('-CM', (WorkDate() - 1)), WorkDate() - 1);
                    // if ItemLedgEntry.FindSet() then begin
                    ItemLedgEntry.CalcSums(Quantity);
                    ILEQty[i] := ItemLedgEntry.Quantity / 1000 * -1;
                    // end;

                    i += 1;
                    ItemLedgEntry.SetRange("Posting Date", WorkDate() - 1);
                    // if ItemLedgEntry.FindSet() then begin
                    ItemLedgEntry.CalcSums(Quantity);
                    ILEQty[i] := ItemLedgEntry.Quantity / 1000 * -1;
                    // end;
                end;

                Clear(i);
                //ILE - BF Sales Last Month
                begin
                    i += 1;
                    Clear(ItemFilter);
                    ItemFilter := CreateItemFilter(Item.SMSItemType::BF);
                    ItemLedgEntry.Reset;
                    ItemLedgEntry.SetFilter("Item No.", ItemFilter);
                    ItemLedgEntry.SetRange("Entry Type", ItemLedgEntry."Entry Type"::Sale);
                    ItemLedgEntry.SetRange("Item Type", ItemLedgEntry."Item Type"::Feed);
                    ItemLedgEntry.CalcFields("Cust. Posting Group");
                    ItemLedgEntry.SetFilter("Cust. Posting Group", '<>%1', 'INTER BRANCH TRANSFE');
                    ItemLedgEntry.SetRange("Posting Date", CalcDate('-1M-CM', (WorkDate() - 1)), CalcDate('-1M', (WorkDate() - 1)));
                    // if ItemLedgEntry.FindSet() then begin
                    ItemLedgEntry.CalcSums(Quantity);
                    LMSamePeriodforSale[i] := ItemLedgEntry.Quantity / 1000 * -1;
                    // end;

                    i += 1;
                    ItemLedgEntry.SetRange("Posting Date", CalcDate('-1M', (WorkDate() - 1)));
                    // if ItemLedgEntry.FindSet() then begin
                    ItemLedgEntry.CalcSums(Quantity);
                    LMSamePeriodforSale[i] := ItemLedgEntry.Quantity / 1000 * -1;
                    // end;
                end;


                //ILE - BF Sales

                //ILE - LF Sales
                begin
                    Clear(ItemFilter);
                    ItemFilter := CreateItemFilter(Item.SMSItemType::LF);
                    i += 1;
                    ItemLedgEntry.Reset;
                    ItemLedgEntry.SetFilter("Item No.", ItemFilter);
                    ItemLedgEntry.SetRange("Entry Type", ItemLedgEntry."Entry Type"::Sale);
                    ItemLedgEntry.SetRange("Item Type", ItemLedgEntry."Item Type"::Feed);
                    ItemLedgEntry.CalcFields("Cust. Posting Group");
                    ItemLedgEntry.SetFilter("Cust. Posting Group", '<>%1', 'INTER BRANCH TRANSFE');
                    ItemLedgEntry.SetRange("Posting Date", CalcDate('-CM', (WorkDate() - 1)), WorkDate() - 1);
                    // if ItemLedgEntry.FindSet() then begin
                    ItemLedgEntry.CalcSums(Quantity);
                    ILEQty[i] := ItemLedgEntry.Quantity / 1000 * -1;
                    // end;

                    i += 1;
                    ItemLedgEntry.SetRange("Posting Date", WorkDate() - 1);
                    // if ItemLedgEntry.FindSet() then begin
                    ItemLedgEntry.CalcSums(Quantity);
                    ILEQty[i] := ItemLedgEntry.Quantity / 1000 * -1;
                    // end;
                end;

                //ILE - LF Sales For Last Month
                begin
                    i := 2;
                    Clear(ItemFilter);
                    ItemFilter := CreateItemFilter(Item.SMSItemType::LF);
                    i += 1;
                    ItemLedgEntry.Reset;
                    ItemLedgEntry.SetFilter("Item No.", ItemFilter);
                    ItemLedgEntry.SetRange("Entry Type", ItemLedgEntry."Entry Type"::Sale);
                    ItemLedgEntry.SetRange("Item Type", ItemLedgEntry."Item Type"::Feed);
                    ItemLedgEntry.CalcFields("Cust. Posting Group");
                    ItemLedgEntry.SetFilter("Cust. Posting Group", '<>%1', 'INTER BRANCH TRANSFE');
                    ItemLedgEntry.SetRange("Posting Date", CalcDate('-1M-CM', (WorkDate() - 1)), CalcDate('-1M', (WorkDate() - 1)));
                    // if ItemLedgEntry.FindSet() then begin
                    ItemLedgEntry.CalcSums(Quantity);
                    LMSamePeriodforSale[i] := ItemLedgEntry.Quantity / 1000 * -1;
                    // end;

                    i += 1;
                    ItemLedgEntry.SetRange("Posting Date", CalcDate('-1M', (WorkDate() - 1)));
                    // if ItemLedgEntry.FindSet() then begin
                    ItemLedgEntry.CalcSums(Quantity);
                    LMSamePeriodforSale[i] := ItemLedgEntry.Quantity / 1000 * -1;
                    // end;
                end;

                //ILE - LF Sales

                //ILE - LLP Sales
                begin
                    i += 1;
                    Clear(ItemFilter);
                    ItemFilter := CreateItemFilter(Item.SMSItemType::LLP);
                    ItemLedgEntry.Reset;
                    ItemLedgEntry.SetFilter("Item No.", ItemFilter);
                    ItemLedgEntry.SetRange("Entry Type", ItemLedgEntry."Entry Type"::Sale);
                    ItemLedgEntry.SetRange("Item Type", ItemLedgEntry."Item Type"::Feed);
                    ItemLedgEntry.CalcFields("Cust. Posting Group");
                    ItemLedgEntry.SetFilter("Cust. Posting Group", '<>%1', 'INTER BRANCH TRANSFE');
                    ItemLedgEntry.SetRange("Posting Date", CalcDate('-CM', (WorkDate() - 1)), WorkDate() - 1);
                    // if ItemLedgEntry.FindSet() then begin
                    ItemLedgEntry.CalcSums(Quantity);
                    ILEQty[i] := ItemLedgEntry.Quantity / 1000 * -1;
                    // end;

                    i += 1;
                    ItemLedgEntry.SetRange("Posting Date", WorkDate() - 1);
                    if ItemLedgEntry.FindSet() then begin
                        ItemLedgEntry.CalcSums(Quantity);
                        ILEQty[i] := ItemLedgEntry.Quantity / 1000 * -1;
                    end;
                end;

                //ILE - LLP Sales For Last Month
                begin
                    i := 5;
                    Clear(ItemFilter);
                    ItemFilter := CreateItemFilter(Item.SMSItemType::LLP);
                    ItemLedgEntry.Reset;
                    ItemLedgEntry.SetFilter("Item No.", ItemFilter);
                    ItemLedgEntry.SetRange("Entry Type", ItemLedgEntry."Entry Type"::Sale);
                    ItemLedgEntry.SetRange("Item Type", ItemLedgEntry."Item Type"::Feed);
                    ItemLedgEntry.CalcFields("Cust. Posting Group");
                    ItemLedgEntry.SetFilter("Cust. Posting Group", '<>%1', 'INTER BRANCH TRANSFE');
                    ItemLedgEntry.SetRange("Posting Date", CalcDate('-1M-CM', (WorkDate() - 1)), CalcDate('-1M', (WorkDate() - 1)));
                    // if ItemLedgEntry.FindSet() then begin
                    ItemLedgEntry.CalcSums(Quantity);
                    LMSamePeriodforSale[i] := ItemLedgEntry.Quantity / 1000 * -1;
                    // end;

                    i += 1;
                    ItemLedgEntry.SetRange("Posting Date", CalcDate('-1M', (WorkDate() - 1)));
                    if ItemLedgEntry.FindSet() then begin
                        ItemLedgEntry.CalcSums(Quantity);
                        LMSamePeriodforSale[i] := ItemLedgEntry.Quantity / 1000 * -1;
                    end;
                end;


                //ILE - LLP Sales

                //ILE - CF Sales
                begin
                    i += 1;
                    Clear(ItemFilter);
                    ItemFilter := CreateItemFilter(Item.SMSItemType::CF);
                    ItemLedgEntry.Reset;
                    ItemLedgEntry.SetFilter("Item No.", ItemFilter);
                    ItemLedgEntry.SetRange("Entry Type", ItemLedgEntry."Entry Type"::Sale);
                    ItemLedgEntry.SetRange("Item Type", ItemLedgEntry."Item Type"::Feed);
                    ItemLedgEntry.CalcFields("Cust. Posting Group");
                    ItemLedgEntry.SetFilter("Cust. Posting Group", '<>%1', 'INTER BRANCH TRANSFE');
                    ItemLedgEntry.SetRange("Posting Date", CalcDate('-CM', (WorkDate() - 1)), WorkDate() - 1);
                    // if ItemLedgEntry.FindSet() then begin
                    ItemLedgEntry.CalcSums(Quantity);
                    ILEQty[i] := ItemLedgEntry.Quantity / 1000 * -1;
                    // end;
                    //Message('%1', ItemLedgEntry.Quantity / 1000 * -1);


                    i += 1;
                    ItemLedgEntry.SetRange("Posting Date", WorkDate() - 1);
                    // if ItemLedgEntry.FindSet() then begin
                    ItemLedgEntry.CalcSums(Quantity);
                    ILEQty[i] := ItemLedgEntry.Quantity / 1000 * -1;
                    // end;
                end;

                //ILE - CF Sales For Last Month
                begin
                    i := 7;
                    Clear(ItemFilter);
                    ItemFilter := CreateItemFilter(Item.SMSItemType::CF);
                    ItemLedgEntry.Reset;
                    ItemLedgEntry.SetFilter("Item No.", ItemFilter);
                    ItemLedgEntry.SetRange("Entry Type", ItemLedgEntry."Entry Type"::Sale);
                    ItemLedgEntry.SetRange("Item Type", ItemLedgEntry."Item Type"::Feed);
                    ItemLedgEntry.CalcFields("Cust. Posting Group");
                    ItemLedgEntry.SetFilter("Cust. Posting Group", '<>%1', 'INTER BRANCH TRANSFE');
                    ItemLedgEntry.SetRange("Posting Date", CalcDate('-1M-CM', (WorkDate() - 1)), CalcDate('-1M', (WorkDate() - 1)));
                    // if ItemLedgEntry.FindSet() then begin
                    ItemLedgEntry.CalcSums(Quantity);
                    LMSamePeriodforSale[i] := ItemLedgEntry.Quantity / 1000 * -1;
                    // end;


                    i += 1;
                    ItemLedgEntry.SetRange("Posting Date", CalcDate('-1M', (WorkDate() - 1)));
                    // if ItemLedgEntry.FindSet() then begin
                    ItemLedgEntry.CalcSums(Quantity);
                    LMSamePeriodforSale[i] := ItemLedgEntry.Quantity / 1000 * -1;
                    // end;
                end;

                //ILE - CF Sales

                //ILE - BRF Sales
                begin
                    i += 1;
                    Clear(ItemFilter);
                    ItemFilter := CreateItemFilter(Item.SMSItemType::BRF);
                    ItemLedgEntry.Reset;
                    ItemLedgEntry.SetFilter("Item No.", ItemFilter);
                    ItemLedgEntry.SetRange("Entry Type", ItemLedgEntry."Entry Type"::Sale);
                    ItemLedgEntry.SetRange("Item Type", ItemLedgEntry."Item Type"::Feed);
                    ItemLedgEntry.CalcFields("Cust. Posting Group");
                    ItemLedgEntry.SetFilter("Cust. Posting Group", '<>%1', 'INTER BRANCH TRANSFE');
                    ItemLedgEntry.SetRange("Posting Date", CalcDate('-CM', (WorkDate() - 1)), WorkDate() - 1);
                    // if ItemLedgEntry.FindSet() then begin
                    ItemLedgEntry.CalcSums(Quantity);
                    ILEQty[i] := ItemLedgEntry.Quantity / 1000 * -1;
                    // end;

                    i += 1;
                    ItemLedgEntry.SetRange("Posting Date", WorkDate() - 1);
                    // if ItemLedgEntry.FindSet() then begin
                    ItemLedgEntry.CalcSums(Quantity);
                    ILEQty[i] := ItemLedgEntry.Quantity / 1000 * -1;
                    // end;
                end;

                //ILE - BRF Sales For Last Month
                begin
                    i := 9;
                    Clear(ItemFilter);
                    ItemFilter := CreateItemFilter(Item.SMSItemType::BRF);
                    ItemLedgEntry.Reset;
                    ItemLedgEntry.SetFilter("Item No.", ItemFilter);
                    ItemLedgEntry.SetRange("Entry Type", ItemLedgEntry."Entry Type"::Sale);
                    ItemLedgEntry.SetRange("Item Type", ItemLedgEntry."Item Type"::Feed);
                    ItemLedgEntry.CalcFields("Cust. Posting Group");
                    ItemLedgEntry.SetFilter("Cust. Posting Group", '<>%1', 'INTER BRANCH TRANSFE');
                    ItemLedgEntry.SetRange("Posting Date", CalcDate('-1M-CM', (WorkDate() - 1)), CalcDate('-1M', (WorkDate() - 1)));
                    // if ItemLedgEntry.FindSet() then begin
                    ItemLedgEntry.CalcSums(Quantity);
                    LMSamePeriodforSale[i] := ItemLedgEntry.Quantity / 1000 * -1;
                    // end;

                    i += 1;
                    ItemLedgEntry.SetRange("Posting Date", CalcDate('-1M', (WorkDate() - 1)));
                    // if ItemLedgEntry.FindSet() then begin
                    ItemLedgEntry.CalcSums(Quantity);
                    LMSamePeriodforSale[i] := ItemLedgEntry.Quantity / 1000 * -1;
                    // end;
                end;


                //ILE - BRF Sales

                //ILE - Other Sales
                begin
                    // i += 1;
                    // Clear(ItemFilter);
                    // ItemFilter := CreateItemFilter(Item.SMSItemType::CF);
                    // ItemLedgEntry.Reset;
                    // if ItemFilter = '' then
                    //     ItemLedgEntry.SetRange("Item No.", '')
                    // else
                    // ItemLedgEntry.SetFilter("Item No.", ItemFilter);
                    // ItemLedgEntry.SetRange("Entry Type", ItemLedgEntry."Entry Type"::Sale);
                    // ItemLedgEntry.SetRange("Item Type", ItemLedgEntry."Item Type"::Feed);
                    // ItemLedgEntry.CalcFields("Cust. Posting Group");
                    // ItemLedgEntry.SetFilter("Cust. Posting Group", '<>%1', 'INTER BRANCH TRANSFE');
                    // ItemLedgEntry.SetRange("Posting Date", CalcDate('-CM', Today), Today - 1);
                    // if ItemLedgEntry.FindSet() then begin
                    //     ItemLedgEntry.CalcSums(Quantity);
                    //     ILEQty[i] := ItemLedgEntry.Quantity / 1000* -1;
                    // end;

                    // i += 1;
                    // ItemLedgEntry.SetRange("Posting Date", Today - 1);
                    // if ItemLedgEntry.FindSet() then begin
                    //     ItemLedgEntry.CalcSums(Quantity);
                    //     ILEQty[i] := ItemLedgEntry.Quantity / 1000* -1;
                    // end;
                end;

                //ILE - Other Sales


                //ILE
                Clear(i);
                clear(a);
                //DCLE

                //Feed Customers
                i += 1;

                DetailCustLedgEntry.Reset();
                DetailCustLedgEntry.SetRange("Posting Date", 0D, WorkDate() - 1);
                DetailCustLedgEntry.SetRange("Initial Entry Global Dim. 1", 'FEED');
                DetailCustLedgEntry.SetFilter("Posting Group", '%1', 'DOMESTIC');
                if DetailCustLedgEntry.FindSet() then begin
                    DetailCustLedgEntry.CalcSums(Amount);
                    DetailCustomAmount[i] := DetailCustLedgEntry.Amount / 10000000;
                end;

                i += 1;
                DetailCustLedgEntry.SetRange("Posting Date", 0D, WorkDate() - 2);
                if DetailCustLedgEntry.FindSet() then begin
                    DetailCustLedgEntry.CalcSums(Amount);
                    DetailCustomAmount[i] := DetailCustLedgEntry.Amount / 10000000;
                end;



                //Feed Customers

                //CBF Customers
                i += 1;
                DetailCustLedgEntry.Reset();
                DetailCustLedgEntry.SetRange("Posting Date", 0D, WorkDate() - 1);
                DetailCustLedgEntry.SetRange("Initial Entry Global Dim. 1", 'CBF');
                DetailCustLedgEntry.SetFilter("Posting Group", '%1', 'DOMESTIC');
                if DetailCustLedgEntry.FindSet() then begin
                    DetailCustLedgEntry.CalcSums(Amount);
                    DetailCustomAmount[i] := DetailCustLedgEntry.Amount / 10000000;
                end;

                i += 1;
                DetailCustLedgEntry.SetRange("Posting Date", 0D, WorkDate() - 2);
                if DetailCustLedgEntry.FindSet() then begin
                    DetailCustLedgEntry.CalcSums(Amount);
                    DetailCustomAmount[i] := DetailCustLedgEntry.Amount / 10000000;
                end;


                //CBF Customers

                //BREEDER Customers
                i += 1;
                DetailCustLedgEntry.Reset();
                DetailCustLedgEntry.SetRange("Posting Date", 0D, WorkDate() - 1);
                DetailCustLedgEntry.SetRange("Initial Entry Global Dim. 1", 'BREEDER');
                DetailCustLedgEntry.SetFilter("Posting Group", '%1', 'DOMESTIC');
                if DetailCustLedgEntry.FindSet() then begin
                    DetailCustLedgEntry.CalcSums(Amount);
                    DetailCustomAmount[i] := DetailCustLedgEntry.Amount / 10000000;
                end;

                i += 1;
                DetailCustLedgEntry.SetRange("Posting Date", 0D, WorkDate() - 2);
                if DetailCustLedgEntry.FindSet() then begin
                    DetailCustLedgEntry.CalcSums(Amount);
                    DetailCustomAmount[i] := DetailCustLedgEntry.Amount / 10000000;
                end;

                //BREEDER Customers

                //HATCH Customers
                i += 1;
                DetailCustLedgEntry.Reset();
                DetailCustLedgEntry.SetRange("Posting Date", 0D, WorkDate() - 1);
                DetailCustLedgEntry.SetRange("Initial Entry Global Dim. 1", 'HATCH');
                DetailCustLedgEntry.SetFilter("Posting Group", '%1', 'DOMESTIC');
                if DetailCustLedgEntry.FindSet() then begin
                    DetailCustLedgEntry.CalcSums(Amount);
                    DetailCustomAmount[i] := DetailCustLedgEntry.Amount / 10000000;
                end;

                i += 1;
                DetailCustLedgEntry.SetRange("Posting Date", 0D, WorkDate() - 2);
                if DetailCustLedgEntry.FindSet() then begin
                    DetailCustLedgEntry.CalcSums(Amount);
                    DetailCustomAmount[i] := DetailCustLedgEntry.Amount / 10000000;
                end;


                //HATCH Customers


                //Cattle Customers
                i += 1;
                DetailCustLedgEntry.Reset();
                DetailCustLedgEntry.SetRange("Posting Date", 0D, WorkDate() - 1);
                DetailCustLedgEntry.SetRange("Initial Entry Global Dim. 1", 'CATTLE');
                DetailCustLedgEntry.SetFilter("Posting Group", '%1', 'DOMESTIC');
                if DetailCustLedgEntry.FindSet() then begin
                    DetailCustLedgEntry.CalcSums(Amount);
                    DetailCustomAmount[i] := (DetailCustLedgEntry.Amount / 10000000);
                end;

                i += 1;
                DetailCustLedgEntry.SetRange("Posting Date", 0D, WorkDate() - 2);
                if DetailCustLedgEntry.FindSet() then begin
                    DetailCustLedgEntry.CalcSums(Amount);
                    DetailCustomAmount[i] := (DetailCustLedgEntry.Amount / 10000000);
                end;


                //Cattle Customers

                //DCLE

                Clear(i);
                Clear(a);
                //DCLE

                //Feed Customers
                i += 1;
    
                DetailCustLedgEntry.Reset();
                DetailCustLedgEntry.SetRange("Posting Date", WorkDate() - 1);
                DetailCustLedgEntry.SetRange("Initial Entry Global Dim. 1", 'FEED');
                DetailCustLedgEntry.SetFilter("Posting Group", '%1', 'DOMESTIC');
                DetailCustLedgEntry.SetRANGE("Entry Type", DetailCustLedgEntry."Entry Type"::"Initial Entry");
                DetailCustLedgEntry.SetRange("Document Type", DetailCustLedgEntry."Document Type"::Payment);
                if DetailCustLedgEntry.FindSet() then begin
                    DetailCustLedgEntry.CalcSums(Amount);
                    DetailPaymentAmount[i] := (DetailCustLedgEntry.Amount / 10000000) * -1;
                end;

                i += 1;
                DetailCustLedgEntry.SetRange("Posting Date", WorkDate() - 2);
                if DetailCustLedgEntry.FindSet() then begin
                    DetailCustLedgEntry.CalcSums(Amount);
                    DetailPaymentAmount[i] := (DetailCustLedgEntry.Amount / 10000000) * -1;
                end;

                a += 1;
                DetailCustLedgEntry.SetRange("Posting Date", 20250401D, CalcDate('-1M', (WorkDate() - 1)));
                if DetailCustLedgEntry.FindSet() then begin
                    DetailCustLedgEntry.CalcSums(Amount);
                    CMFYtolastmonth[a] := (DetailCustLedgEntry.Amount / 10000000) * -1;
                end;
                //Feed Customers

                //CBF Customers
                i += 1;
                DetailCustLedgEntry.Reset();
                DetailCustLedgEntry.SetRange("Posting Date", WorkDate() - 1);
                DetailCustLedgEntry.SetRange("Initial Entry Global Dim. 1", 'CBF');
                DetailCustLedgEntry.SetFilter("Posting Group", '%1', 'DOMESTIC');
                DetailCustLedgEntry.SetRANGE("Entry Type", DetailCustLedgEntry."Entry Type"::"Initial Entry");
                DetailCustLedgEntry.SetRange("Document Type", DetailCustLedgEntry."Document Type"::Payment);
                if DetailCustLedgEntry.FindSet() then begin
                    DetailCustLedgEntry.CalcSums(Amount);
                    DetailPaymentAmount[i] := (DetailCustLedgEntry.Amount / 10000000) * -1;
                end;

                i += 1;
                DetailCustLedgEntry.SetRange("Posting Date", WorkDate() - 2);
                if DetailCustLedgEntry.FindSet() then begin
                    DetailCustLedgEntry.CalcSums(Amount);
                    DetailPaymentAmount[i] := (DetailCustLedgEntry.Amount / 10000000) * -1;
                end;
                a += 1;
                DetailCustLedgEntry.SetRange("Posting Date", 20250401D, CalcDate('-1M', (WorkDate() - 1)));
                if DetailCustLedgEntry.FindSet() then begin
                    DetailCustLedgEntry.CalcSums(Amount);
                    CMFYtolastmonth[a] := (DetailCustLedgEntry.Amount / 10000000) * -1;
                end;
                //CBF Customers

                //BREEDER & Hatch Customers
                i += 1;
                DetailCustLedgEntry.Reset();
                DetailCustLedgEntry.SetRange("Posting Date", WorkDate() - 1);
                DetailCustLedgEntry.SetRange("Initial Entry Global Dim. 1", 'BREEDER|HATCH');
                DetailCustLedgEntry.SetFilter("Posting Group", '%1', 'DOMESTIC');
                DetailCustLedgEntry.SetRANGE("Entry Type", DetailCustLedgEntry."Entry Type"::"Initial Entry");
                DetailCustLedgEntry.SetRange("Document Type", DetailCustLedgEntry."Document Type"::Payment);
                if DetailCustLedgEntry.FindSet() then begin
                    DetailCustLedgEntry.CalcSums(Amount);
                    DetailPaymentAmount[i] := (DetailCustLedgEntry.Amount / 10000000) * -1;
                end;

                i += 1;
                DetailCustLedgEntry.SetRange("Posting Date", WorkDate() - 2);
                if DetailCustLedgEntry.FindSet() then begin
                    DetailCustLedgEntry.CalcSums(Amount);
                    DetailPaymentAmount[i] := (DetailCustLedgEntry.Amount / 10000000) * -1;
                end;
                a += 1;
                DetailCustLedgEntry.SetRange("Posting Date", 20250401D, CalcDate('-1M', (WorkDate() - 1)));
                if DetailCustLedgEntry.FindSet() then begin
                    DetailCustLedgEntry.CalcSums(Amount);
                    CMFYtolastmonth[a] :=(DetailCustLedgEntry.Amount / 10000000) * -1;
                end;
                //BREEDER & Hatch Customers

                //Cattle Customers
                i += 1;
                DetailCustLedgEntry.Reset();
                DetailCustLedgEntry.SetRange("Posting Date", WorkDate() - 1);
                DetailCustLedgEntry.SetRange("Initial Entry Global Dim. 1", 'CATTLE');
                DetailCustLedgEntry.SetFilter("Posting Group", '%1', 'DOMESTIC');
                DetailCustLedgEntry.SetRANGE("Entry Type", DetailCustLedgEntry."Entry Type"::"Initial Entry");
                DetailCustLedgEntry.SetRange("Document Type", DetailCustLedgEntry."Document Type"::Payment);
                if DetailCustLedgEntry.FindSet() then begin
                    DetailCustLedgEntry.CalcSums(Amount);
                    DetailPaymentAmount[i] := (DetailCustLedgEntry.Amount / 10000000) * -1;
                end;

                i += 1;
                DetailCustLedgEntry.SetRange("Posting Date", WorkDate() - 2);
                if DetailCustLedgEntry.FindSet() then begin
                    DetailCustLedgEntry.CalcSums(Amount);
                    DetailPaymentAmount[i] := (DetailCustLedgEntry.Amount / 10000000) * -1;
                end;
                a += 1;
                DetailCustLedgEntry.SetRange("Posting Date", 20250401D, CalcDate('-1M', (WorkDate() - 1)));
                if DetailCustLedgEntry.FindSet() then begin
                    DetailCustLedgEntry.CalcSums(Amount);
                    CMFYtolastmonth[a] := (DetailCustLedgEntry.Amount / 10000000) * -1;
                end;
                //Cattle Customers

                //DCLE
                // Last Month Customer Payment Start
                Clear(i);
                //DCLE

                //Feed Customers
                i += 1;
                DetailCustLedgEntry.Reset();
                DetailCustLedgEntry.SetRange("Posting Date", CalcDate('-1M', (WorkDate() - 1)));
                DetailCustLedgEntry.SetRange("Initial Entry Global Dim. 1", 'FEED');
                DetailCustLedgEntry.SetFilter("Posting Group", '%1', 'DOMESTIC');
                DetailCustLedgEntry.SetRANGE("Entry Type", DetailCustLedgEntry."Entry Type"::"Initial Entry");
                DetailCustLedgEntry.SetRange("Document Type", DetailCustLedgEntry."Document Type"::Payment);
                if DetailCustLedgEntry.FindSet() then begin
                    DetailCustLedgEntry.CalcSums(Amount);
                    LMDetailPaymentAmount[i] := (DetailCustLedgEntry.Amount / 10000000) * -1;
                end;

                i += 1;
                DetailCustLedgEntry.SetRange("Posting Date", CalcDate('-1M', (WorkDate() - 2)));
                if DetailCustLedgEntry.FindSet() then begin
                    DetailCustLedgEntry.CalcSums(Amount);
                    LMDetailPaymentAmount[i] := (DetailCustLedgEntry.Amount / 10000000) * -1;
                end;
                //Feed Customers

                //CBF Customers
                i += 1;
                DetailCustLedgEntry.Reset();
                DetailCustLedgEntry.SetRange("Posting Date", CalcDate('-1M', (WorkDate() - 1)));
                DetailCustLedgEntry.SetRange("Initial Entry Global Dim. 1", 'CBF');
                DetailCustLedgEntry.SetFilter("Posting Group", '%1', 'DOMESTIC');
                DetailCustLedgEntry.SetRANGE("Entry Type", DetailCustLedgEntry."Entry Type"::"Initial Entry");
                DetailCustLedgEntry.SetRange("Document Type", DetailCustLedgEntry."Document Type"::Payment);
                if DetailCustLedgEntry.FindSet() then begin
                    DetailCustLedgEntry.CalcSums(Amount);
                    LMDetailPaymentAmount[i] := (DetailCustLedgEntry.Amount / 10000000) * -1;
                end;

                i += 1;
                DetailCustLedgEntry.SetRange("Posting Date", CalcDate('-1M', (WorkDate() - 2)));
                if DetailCustLedgEntry.FindSet() then begin
                    DetailCustLedgEntry.CalcSums(Amount);
                    LMDetailPaymentAmount[i] := (DetailCustLedgEntry.Amount / 10000000) * -1;
                end;
                //CBF Customers

                //BREEDER & Hatch Customers
                i += 1;
                DetailCustLedgEntry.Reset();
                DetailCustLedgEntry.SetRange("Posting Date", CalcDate('-1M', (WorkDate() - 1)));
                DetailCustLedgEntry.SetRange("Initial Entry Global Dim. 1", 'BREEDER|HATCH');
                DetailCustLedgEntry.SetFilter("Posting Group", '%1', 'DOMESTIC');
                DetailCustLedgEntry.SetRANGE("Entry Type", DetailCustLedgEntry."Entry Type"::"Initial Entry");
                DetailCustLedgEntry.SetRange("Document Type", DetailCustLedgEntry."Document Type"::Payment);
                if DetailCustLedgEntry.FindSet() then begin
                    DetailCustLedgEntry.CalcSums(Amount);
                    LMDetailPaymentAmount[i] := (DetailCustLedgEntry.Amount / 10000000) * -1;
                end;

                i += 1;
                DetailCustLedgEntry.SetRange("Posting Date", CalcDate('-1M', (WorkDate() - 2)));
                if DetailCustLedgEntry.FindSet() then begin
                    DetailCustLedgEntry.CalcSums(Amount);
                    LMDetailPaymentAmount[i] := (DetailCustLedgEntry.Amount / 10000000) * -1;
                end;
                //BREEDER & Hatch Customers

                //Cattle Customers
                i += 1;
                DetailCustLedgEntry.Reset();
                DetailCustLedgEntry.SetRange("Posting Date", CalcDate('-1M', (WorkDate() - 1)));
                DetailCustLedgEntry.SetRange("Initial Entry Global Dim. 1", 'CATTLE');
                DetailCustLedgEntry.SetFilter("Posting Group", '%1', 'DOMESTIC');
                DetailCustLedgEntry.SetRANGE("Entry Type", DetailCustLedgEntry."Entry Type"::"Initial Entry");
                DetailCustLedgEntry.SetRange("Document Type", DetailCustLedgEntry."Document Type"::Payment);
                if DetailCustLedgEntry.FindSet() then begin
                    DetailCustLedgEntry.CalcSums(Amount);
                    LMDetailPaymentAmount[i] := (DetailCustLedgEntry.Amount / 10000000) * -1;
                end;

                i += 1;
                DetailCustLedgEntry.SetRange("Posting Date", CalcDate('-1M', (WorkDate() - 2)));
                if DetailCustLedgEntry.FindSet() then begin
                    DetailCustLedgEntry.CalcSums(Amount);
                    LMDetailPaymentAmount[i] := (DetailCustLedgEntry.Amount / 10000000) * -1;
                end;
                //Cattle Customers


                // Last Month Customer Payment End

                // Last Month Customer Balance

                Clear(i);
                //DCLE

                //Feed Customers
                i += 1;
                DetailCustLedgEntry.Reset();
                DetailCustLedgEntry.SetRange("Posting Date", 0D, CalcDate('-1M', (WorkDate() - 1)));
                DetailCustLedgEntry.SetRange("Initial Entry Global Dim. 1", 'FEED');
                DetailCustLedgEntry.SetFilter("Posting Group", '%1', 'DOMESTIC');
                //DetailCustLedgEntry.SetRange("Initial Document Type", DetailCustLedgEntry."Initial Document Type"::Payment);
                if DetailCustLedgEntry.FindSet() then begin
                    DetailCustLedgEntry.CalcSums(Amount);
                    LMDetailCustomAmount[i] := DetailCustLedgEntry.Amount / 10000000;
                end;

                i += 1;
                DetailCustLedgEntry.SetRange("Posting Date", 0D, CalcDate('-1M', (WorkDate() - 2)));
                if DetailCustLedgEntry.FindSet() then begin
                    DetailCustLedgEntry.CalcSums(Amount);
                    LMDetailCustomAmount[i] := DetailCustLedgEntry.Amount / 10000000;
                end;
                //Feed Customers

                //CBF Customers
                i += 1;
                DetailCustLedgEntry.Reset();
                DetailCustLedgEntry.SetRange("Posting Date", 0D, CalcDate('-1M', (WorkDate() - 1)));
                DetailCustLedgEntry.SetRange("Initial Entry Global Dim. 1", 'CBF');
                DetailCustLedgEntry.SetFilter("Posting Group", '%1', 'DOMESTIC');
                //DetailCustLedgEntry.SetRange("Initial Document Type", DetailCustLedgEntry."Initial Document Type"::Payment);
                if DetailCustLedgEntry.FindSet() then begin
                    DetailCustLedgEntry.CalcSums(Amount);
                    LMDetailCustomAmount[i] := DetailCustLedgEntry.Amount / 10000000;
                end;

                i += 1;
                DetailCustLedgEntry.SetRange("Posting Date", 0D, CalcDate('-1M', (WorkDate() - 2)));
                if DetailCustLedgEntry.FindSet() then begin
                    DetailCustLedgEntry.CalcSums(Amount);
                    LMDetailCustomAmount[i] := DetailCustLedgEntry.Amount / 10000000;
                end;
                //CBF Customers

                //BREEDER & Hatch Customers
                i += 1;
                DetailCustLedgEntry.Reset();
                DetailCustLedgEntry.SetRange("Posting Date", 0D, CalcDate('-1M', (WorkDate() - 1)));
                DetailCustLedgEntry.SetRange("Initial Entry Global Dim. 1", 'BREEDER');
                DetailCustLedgEntry.SetFilter("Posting Group", '%1', 'DOMESTIC');
                //DetailCustLedgEntry.SetRange("Initial Document Type", DetailCustLedgEntry."Initial Document Type"::Payment);
                if DetailCustLedgEntry.FindSet() then begin
                    DetailCustLedgEntry.CalcSums(Amount);
                    LMDetailCustomAmount[i] := DetailCustLedgEntry.Amount / 10000000;
                end;

                i += 1;
                DetailCustLedgEntry.SetRange("Posting Date", 0D, CalcDate('-1M', (WorkDate() - 2)));
                if DetailCustLedgEntry.FindSet() then begin
                    DetailCustLedgEntry.CalcSums(Amount);
                    LMDetailCustomAmount[i] := DetailCustLedgEntry.Amount / 10000000;
                end;
                i += 1;
                DetailCustLedgEntry.Reset();
                DetailCustLedgEntry.SetRange("Posting Date", 0D, CalcDate('-1M', (WorkDate() - 1)));
                DetailCustLedgEntry.SetRange("Initial Entry Global Dim. 1", 'HATCH');
                DetailCustLedgEntry.SetFilter("Posting Group", '%1', 'DOMESTIC');
                //DetailCustLedgEntry.SetRange("Initial Document Type", DetailCustLedgEntry."Initial Document Type"::Payment);
                if DetailCustLedgEntry.FindSet() then begin
                    DetailCustLedgEntry.CalcSums(Amount);
                    LMDetailCustomAmount[i] := DetailCustLedgEntry.Amount / 10000000;
                end;

                i += 1;
                DetailCustLedgEntry.SetRange("Posting Date", 0D, CalcDate('-1M', (WorkDate() - 2)));
                if DetailCustLedgEntry.FindSet() then begin
                    DetailCustLedgEntry.CalcSums(Amount);
                    LMDetailCustomAmount[i] := DetailCustLedgEntry.Amount / 10000000;
                end;
                //BREEDER & Hatch Customers

                //Cattle Customers
                i += 1;
                DetailCustLedgEntry.Reset();
                DetailCustLedgEntry.SetRange("Posting Date", 0D, CalcDate('-1M', (WorkDate() - 1)));
                DetailCustLedgEntry.SetRange("Initial Entry Global Dim. 1", 'CATTLE');
                DetailCustLedgEntry.SetFilter("Posting Group", '%1', 'DOMESTIC');
                //DetailCustLedgEntry.SetRange("Initial Document Type", DetailCustLedgEntry."Initial Document Type"::Payment);
                if DetailCustLedgEntry.FindSet() then begin
                    DetailCustLedgEntry.CalcSums(Amount);
                    LMDetailCustomAmount[i] := DetailCustLedgEntry.Amount / 10000000;
                end;

                i += 1;
                DetailCustLedgEntry.SetRange("Posting Date", 0D, CalcDate('-1M', (WorkDate() - 2)));
                if DetailCustLedgEntry.FindSet() then begin
                    DetailCustLedgEntry.CalcSums(Amount);
                    LMDetailCustomAmount[i] := DetailCustLedgEntry.Amount / 10000000;
                end;
                // end of Last Month Customer Balance
                Clear(i);
                //DVLE

                //Feed Customers
                i += 1;
                DetailVendLedgEntry.Reset();
                DetailVendLedgEntry.SetRange("Posting Date", WorkDate() - 1);
                DetailVendLedgEntry.SetRange("Initial Entry Global Dim. 1", 'FEED');
                DetailVendLedgEntry.SetRange("Entry Type", DetailVendLedgEntry."Entry Type"::"Initial Entry");
                DetailVendLedgEntry.SetRange("Document Type", DetailVendLedgEntry."Document Type"::Payment);
                if DetailVendLedgEntry.FindSet() then begin
                    DetailVendLedgEntry.CalcSums(Amount);
                    DetailVenPaymentAmount[i] := DetailVendLedgEntry.Amount / 10000000;
                end;

                i += 1;
                DetailVendLedgEntry.SetRange("Posting Date", WorkDate() - 2);
                if DetailVendLedgEntry.FindSet() then begin
                    DetailVendLedgEntry.CalcSums(Amount);
                    DetailVenPaymentAmount[i] := DetailVendLedgEntry.Amount / 10000000;
                end;
                //Feed Customers

                //CBF Customers
                i += 1;
                DetailVendLedgEntry.Reset();
                DetailVendLedgEntry.SetRange("Posting Date", WorkDate() - 1);
                DetailVendLedgEntry.SetRange("Initial Entry Global Dim. 1", 'CBF');
                DetailVendLedgEntry.SetRange("Entry Type", DetailVendLedgEntry."Entry Type"::"Initial Entry");
                DetailVendLedgEntry.SetRange("Document Type", DetailVendLedgEntry."Document Type"::Payment);
                if DetailVendLedgEntry.FindSet() then begin
                    DetailVendLedgEntry.CalcSums(Amount);
                    DetailVenPaymentAmount[i] := DetailVendLedgEntry.Amount / 10000000;
                end;

                i += 1;
                DetailVendLedgEntry.SetRange("Posting Date", WorkDate() - 2);
                if DetailVendLedgEntry.FindSet() then begin
                    DetailVendLedgEntry.CalcSums(Amount);
                    DetailVenPaymentAmount[i] := DetailVendLedgEntry.Amount / 10000000;
                end;
                //CBF Customers

                //BREEDER & Hatch Customers
                i += 1;
                DetailVendLedgEntry.Reset();
                DetailVendLedgEntry.SetRange("Posting Date", WorkDate() - 1);
                DetailVendLedgEntry.SetRange("Initial Entry Global Dim. 1", 'BREEDER|HATCH');
                DetailVendLedgEntry.SetRange("Entry Type", DetailVendLedgEntry."Entry Type"::"Initial Entry");
                DetailVendLedgEntry.SetRange("Document Type", DetailVendLedgEntry."Document Type"::Payment);
                if DetailVendLedgEntry.FindSet() then begin
                    DetailVendLedgEntry.CalcSums(Amount);
                    DetailVenPaymentAmount[i] := DetailVendLedgEntry.Amount / 10000000;
                end;

                i += 1;
                DetailVendLedgEntry.SetRange("Posting Date", WorkDate() - 2);
                if DetailVendLedgEntry.FindSet() then begin
                    DetailVendLedgEntry.CalcSums(Amount);
                    DetailVenPaymentAmount[i] := DetailVendLedgEntry.Amount / 10000000;
                end;
                //BREEDER & Hatch Customers

                //Cattle Customers
                i += 1;
                DetailVendLedgEntry.Reset();
                DetailVendLedgEntry.SetRange("Posting Date", WorkDate() - 1);
                DetailVendLedgEntry.SetRange("Initial Entry Global Dim. 1", 'CATTLE');
                DetailVendLedgEntry.SetRange("Entry Type", DetailVendLedgEntry."Entry Type"::"Initial Entry");
                DetailVendLedgEntry.SetRange("Document Type", DetailVendLedgEntry."Document Type"::Payment);
                if DetailVendLedgEntry.FindSet() then begin
                    DetailVendLedgEntry.CalcSums(Amount);
                    DetailVenPaymentAmount[i] := DetailVendLedgEntry.Amount / 10000000;
                end;

                i += 1;
                DetailVendLedgEntry.SetRange("Posting Date", WorkDate() - 2);
                if DetailVendLedgEntry.FindSet() then begin
                    DetailVendLedgEntry.CalcSums(Amount);
                    DetailVenPaymentAmount[i] := DetailVendLedgEntry.Amount / 10000000;
                end;
                //Cattle Customers

                // Last Month Vendor Payment Start

                Clear(i);
                //DVLE

                //Feed Customers
                i += 1;
                DetailVendLedgEntry.Reset();
                DetailVendLedgEntry.SetRange("Posting Date", CalcDate('-1M', (WorkDate() - 1)));
                DetailVendLedgEntry.SetRange("Initial Entry Global Dim. 1", 'FEED');
                DetailVendLedgEntry.SetRange("Entry Type", DetailVendLedgEntry."Entry Type"::"Initial Entry");
                DetailVendLedgEntry.SetRange("Document Type", DetailVendLedgEntry."Document Type"::Payment);
                if DetailVendLedgEntry.FindSet() then begin
                    DetailVendLedgEntry.CalcSums(Amount);
                    LMDetailVenPaymentAmount[i] := DetailVendLedgEntry.Amount / 10000000;
                end;

                i += 1;
                DetailVendLedgEntry.SetRange("Posting Date", CalcDate('-1M', (WorkDate() - 2)));
                if DetailVendLedgEntry.FindSet() then begin
                    DetailVendLedgEntry.CalcSums(Amount);
                    LMDetailVenPaymentAmount[i] := DetailVendLedgEntry.Amount / 10000000;
                end;
                //Feed Customers

                //CBF Customers
                i += 1;
                DetailVendLedgEntry.Reset();
                DetailVendLedgEntry.SetRange("Posting Date", CalcDate('-1M', (WorkDate() - 1)));
                DetailVendLedgEntry.SetRange("Initial Entry Global Dim. 1", 'CBF');
                DetailVendLedgEntry.SetRange("Entry Type", DetailVendLedgEntry."Entry Type"::"Initial Entry");
                DetailVendLedgEntry.SetRange("Document Type", DetailVendLedgEntry."Document Type"::Payment);
                if DetailVendLedgEntry.FindSet() then begin
                    DetailVendLedgEntry.CalcSums(Amount);
                    LMDetailVenPaymentAmount[i] := DetailVendLedgEntry.Amount / 10000000;
                end;

                i += 1;
                DetailVendLedgEntry.SetRange("Posting Date", CalcDate('-1M', (WorkDate() - 2)));
                if DetailVendLedgEntry.FindSet() then begin
                    DetailVendLedgEntry.CalcSums(Amount);
                    LMDetailVenPaymentAmount[i] := DetailVendLedgEntry.Amount / 10000000;
                end;
                //CBF Customers

                //BREEDER & Hatch Customers
                i += 1;
                DetailVendLedgEntry.Reset();
                DetailVendLedgEntry.SetRange("Posting Date", CalcDate('-1M', (WorkDate() - 1)));
                DetailVendLedgEntry.SetRange("Initial Entry Global Dim. 1", 'BREEDER|HATCH');
                DetailVendLedgEntry.SetRange("Entry Type", DetailVendLedgEntry."Entry Type"::"Initial Entry");
                DetailVendLedgEntry.SetRange("Document Type", DetailVendLedgEntry."Document Type"::Payment);
                if DetailVendLedgEntry.FindSet() then begin
                    DetailVendLedgEntry.CalcSums(Amount);
                    LMDetailVenPaymentAmount[i] := DetailVendLedgEntry.Amount / 10000000;
                end;

                i += 1;
                DetailVendLedgEntry.SetRange("Posting Date", CalcDate('-1M', (WorkDate() - 2)));
                if DetailVendLedgEntry.FindSet() then begin
                    DetailVendLedgEntry.CalcSums(Amount);
                    LMDetailVenPaymentAmount[i] := DetailVendLedgEntry.Amount / 10000000;
                end;
                //BREEDER & Hatch Customers

                //Cattle Customers
                i += 1;
                DetailVendLedgEntry.Reset();
                DetailVendLedgEntry.SetRange("Posting Date", CalcDate('-1M', (WorkDate() - 1)));
                DetailVendLedgEntry.SetRange("Initial Entry Global Dim. 1", 'CATTLE');
                DetailVendLedgEntry.SetRange("Entry Type", DetailVendLedgEntry."Entry Type"::"Initial Entry");
                DetailVendLedgEntry.SetRange("Document Type", DetailVendLedgEntry."Document Type"::Payment);
                if DetailVendLedgEntry.FindSet() then begin
                    DetailVendLedgEntry.CalcSums(Amount);
                    LMDetailVenPaymentAmount[i] := DetailVendLedgEntry.Amount / 10000000;
                end;

                i += 1;
                DetailVendLedgEntry.SetRange("Posting Date", CalcDate('-1M', (WorkDate() - 2)));
                if DetailVendLedgEntry.FindSet() then begin
                    DetailVendLedgEntry.CalcSums(Amount);
                    LMDetailVenPaymentAmount[i] := DetailVendLedgEntry.Amount / 10000000;
                end;
                //Cattle Customers
                // Last Month Vendor Payment End

                //DVLE

                //Sales Order
                SalesHeader.Reset();
                SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::Order);
                SalesHeader.SetRange("Order Date", WorkDate() - 1);
                if SalesHeader.FindSet() then begin
                    Clear(ItemFilter);
                    Clear(ItemFIlter1);
                    ItemFilter := CreateItemFilter(Item.SMSItemType::BF);
                    if ItemFilter <> '' then
                        ItemFilter += '|';
                    ItemFilter += CreateItemFilter(Item.SMSItemType::LLP);
                    if ItemFilter <> '' then
                        ItemFilter += '|';
                    ItemFilter += CreateItemFilter(Item.SMSItemType::LF);

                    ItemFIlter1 := CreateItemFilter(Item.SMSItemType::CF);
                    repeat
                        i := 1;
                        SalesLine.Reset();
                        SalesLine.SetRange("Document No.", SalesHeader."No.");
                        SalesLine.SetRange("Document Type", SalesHeader."Document Type");
                        SalesLine.SetRange(Type, SalesLine.Type::Item);
                        SalesLine.SetFilter("No.", ItemFilter);
                        //if SalesLine.FindSet() then begin
                        SalesLine.CalcSums("Quantity (Base)", "Qty. Shipped (Base)");
                        OrderReceived[i] := SalesLine."Quantity (Base)";
                        OrderShipped[i] := SalesLine."Qty. Shipped (Base)";
                        // end;

                        i += 1;
                        SalesLine.Reset();
                        SalesLine.SetRange("Document No.", SalesHeader."No.");
                        SalesLine.SetRange("Document Type", SalesHeader."Document Type");
                        SalesLine.SetRange(Type, SalesLine.Type::Item);
                        SalesLine.SetFilter("No.", ItemFilter1);
                        //if SalesLine.FindSet() then begin
                        SalesLine.CalcSums("Quantity (Base)", "Qty. Shipped (Base)");
                        OrderReceived[i] := SalesLine."Quantity (Base)";
                        OrderShipped[i] := SalesLine."Qty. Shipped (Base)";
                    //end;
                    until SalesHeader.Next() = 0;
                end;

                SalesHeader.Reset();
                SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::Order);
                SalesHeader.SetRange("Order Date", WorkDate() - 2);
                if SalesHeader.FindSet() then begin
                    Clear(ItemFilter);
                    Clear(ItemFIlter1);
                    ItemFilter := CreateItemFilter(Item.SMSItemType::BF);
                    if ItemFilter <> '' then
                        ItemFilter += '|';
                    ItemFilter += CreateItemFilter(Item.SMSItemType::LLP);
                    if ItemFilter <> '' then
                        ItemFilter += '|';
                    ItemFilter += CreateItemFilter(Item.SMSItemType::LF);

                    ItemFIlter1 := CreateItemFilter(Item.SMSItemType::CF);
                    repeat
                        i := 3;
                        SalesLine.Reset();
                        SalesLine.SetRange("Document No.", SalesHeader."No.");
                        SalesLine.SetRange("Document Type", SalesHeader."Document Type");
                        SalesLine.SetRange(Type, SalesLine.Type::Item);
                        SalesLine.SetFilter("No.", ItemFilter);
                        if SalesLine.FindSet() then begin
                            SalesLine.CalcSums("Quantity (Base)", "Qty. Shipped (Base)");
                            OrderReceived[i] := SalesLine."Quantity (Base)";
                            OrderShipped[i] := SalesLine."Qty. Shipped (Base)";
                        end;

                        i += 1;
                        SalesLine.Reset();
                        SalesLine.SetRange("Document No.", SalesHeader."No.");
                        SalesLine.SetRange("Document Type", SalesHeader."Document Type");
                        SalesLine.SetRange(Type, SalesLine.Type::Item);
                        SalesLine.SetFilter("No.", ItemFilter1);
                        if SalesLine.FindSet() then begin
                            SalesLine.CalcSums("Quantity (Base)", "Qty. Shipped (Base)");
                            OrderReceived[i] := SalesLine."Quantity (Base)";
                            OrderShipped[i] := SalesLine."Qty. Shipped (Base)";
                        end;
                    until SalesHeader.Next() = 0;
                end;

                //Message('%1|%2', LMSamePeriodforSale[7], ILEQty[8])
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }
    procedure CreateItemFilter(SMSType: Option " ",BF,LF,LLP,CF,BRF) ItemFilter: Text;
    var
        ItemRec: Record Item;
    begin
        Clear(ItemFilter);
        ItemRec.Reset();
        ItemRec.SetRange(SMSItemType, SMSType);
        if ItemRec.FindSet() then
            repeat
                if ItemFilter <> '' then
                    ItemFilter += '|';
                ItemFilter += ItemRec."No.";
            until ItemRec.Next() = 0;
        exit(ItemFilter);
    end;

    var
        PurchDetailQty: array[10] of Decimal;
        PurchDetailRate: array[10] of Decimal;
        SalesDetailQty: array[10] of Decimal;
        SalesAlternateQty: array[10] of Decimal;
        SalesDetailAvgWt: array[10] of Decimal;
        SalesDetailRate: array[10] of Decimal;
        DetailCustomAmount: array[10] of Decimal;
        DetailPaymentAmount: array[10] of Decimal;
        DetailVenPaymentAmount: array[10] of Decimal;
        OrderShipped: array[4] of Decimal;
        OrderReceived: array[4] of Decimal;
        ILEQty: array[12] of Decimal;
        LMSamePeriodforSale: array[10] of Decimal;
        LMSamePeriodforDebtor: array[10] of Decimal;
        LMDetailCustomAmount: array[10] of Decimal;
        LMDetailPaymentAmount: array[10] of Decimal;
        LMDetailVenPaymentAmount: array[10] of Decimal;
        Proddetail: array[10] of Decimal;
        PurchDetailAmt: array[10] of Decimal;
        LastMonthtillYesterday: Date;
        CMFYtolastmonth: array[10] of Decimal;


        i: Integer;
        a: Integer;
}
