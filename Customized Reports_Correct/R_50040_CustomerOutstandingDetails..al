report 50040 "Customer Outstanding Details"
{
    UsageCategory = Administration;
    Caption = 'Customer Outstanding Details Report';
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'ReportLayout\CustomerOutstandingDetails.rdl';
    dataset
    {
        dataitem(Customer; Customer)
        {
            DataItemTableView = ORDER(Ascending);
            RequestFilterFields = "Team Code";
            column(CustNo; Customer."No.")
            {
            }
            column(CustName; Customer.Name)
            {
            }
            column(CustTeamCode; Customer."Team Code")
            {
            }
            column(SalespersonCode; Customer."Salesperson Code")
            {
            }
            column(TeamType; Customer."Team Type")
            {
            }
            column(CreditLimitLCY; Customer."Credit Limit (LCY)")
            {
            }
            column(BeforeAmount_gDec; BeforeAmount_gDec)
            {
            }
            column(Amount0_30_gDec; Amount0_30_gDec)
            {
            }
            column(Amount31_60_gDec; Amount31_60_gDec)
            {
            }
            column(Amount61_90_gDec; Amount61_90_gDec)
            {
            }
            column(Amount91_180_gDec; Amount91_180_gDec)
            {
            }
            column(Amount181_270_gDec; Amount181_270_gDec)
            {
            }
            column(Amount270_gDec; Amount270_gDec)
            {
            }
            column(TotalAmt; TotalAmt_gDec)
            {
            }
            column(Heading1; HeadingText[1])
            {
            }
            column(Heading2; HeadingText[2])
            {
            }
            column(Heading3; HeadingText[3])
            {
            }
            column(Heading4; HeadingText[4])
            {
            }
            column(Heading5; HeadingText[5])
            {
            }
            column(Heading6; HeadingText[6])
            {
            }
            column(SalesName; SalesName)
            {
            }
            column(Rqty; Rqty)
            {
            }
            column(TotalAmt_gDec; TotalAmt_gDec)
            {
            }
            column(AsOnDate_gDte; AsOnDate_gDte)
            {
            }
            column(colourtext; colourtext)
            {
            }
            column(Grandtotl; Grandtotl)
            {
            }
            column(SalesValue; SalesValue)
            {
            }
            column(Outstanding30Dabove; Outstanding30DAbove)
            {
            }
            column(Outstanding30D; Outstanding30D)
            {
            }
            column(NetChange; NetChange)
            {
            }

            trigger OnAfterGetRecord()
            var
                CustLedgerEntry: Record 21;
                DateCalc_lInt: Integer;
            begin
                CLEAR(SalesName);
                SalespersonPurchaser.RESET;
                SalespersonPurchaser.SETRANGE(Code, Customer."Salesperson Code");
                IF SalespersonPurchaser.FINDFIRST THEN
                    SalesName := SalespersonPurchaser.Name;
                //
                CLEAR(SalesValue);
                CLEAR(Rqty);
                RSalesInvoiceLine.RESET;
                RSalesInvoiceLine.SETRANGE("Sell-to Customer No.", Customer."No.");
                RSalesInvoiceLine.SETRANGE("Posting Date", AsOnDate_gDte - 29, AsOnDate_gDte);
                IF RSalesInvoiceLine.FINDFIRST THEN
                    REPEAT
                        Rqty += RSalesInvoiceLine."Quantity (Base)";
                        SalesValue += RSalesInvoiceLine."Amount";
                    UNTIL RSalesInvoiceLine.NEXT = 0;

                //
                CustLedgerEntry.RESET;
                CustLedgerEntry.SETRANGE("Customer No.", Customer."No.");
                CustLedgerEntry.SETFILTER("Document Type", 'Invoice');
                CustLedgerEntry.SETRANGE("Posting Date", AsOnDate_gDte - 29, AsOnDate_gDte);
                IF NOT CustLedgerEntry.FINDFIRST THEN
                    colourtext := 'Red'
                ELSE
                    colourtext := 'Black';
                //
                CLEAR(BeforeAmount_gDec);
                CustLedgerEntry.RESET;
                CustLedgerEntry.SETRANGE("Customer No.", "No.");
                //CustLedgerEntry.SETRANGE("Salesperson Code",Customer."Salesperson Code");
                CustLedgerEntry.SETFILTER("Posting Date", '>%1', AsOnDate_gDte);
                CustLedgerEntry.SETFILTER(CustLedgerEntry."Remaining Amount", '<>%1', 0);
                //CustLedgerEntry.SETFILTER("Global Dimension 1 Code",Customer.GETFILTER("Global Dimension 1 Filter"));
                CustLedgerEntry.SETRANGE("Document Type", CustLedgerEntry."Document Type"::Invoice);
                IF CustLedgerEntry.FINDFIRST THEN BEGIN
                    REPEAT
                        CustLedgerEntry.CALCFIELDS("Remaining Amount");
                    //BeforeAmount_gDec += CustLedgerEntry."Remaining Amount";
                    UNTIL CustLedgerEntry.NEXT = 0;
                END;
                //MESSAGE('G-%1',BeforeAmount_gDec);

                CLEAR(DateCalc_lInt);
                CLEAR(Amount0_30_gDec);
                CLEAR(Amount31_60_gDec);
                CLEAR(Amount61_90_gDec);
                CLEAR(Amount91_180_gDec);
                CLEAR(Amount181_270_gDec);
                CLEAR(Amount270_gDec);
                CLEAR(Outstanding30D);
                CLEAR(Outstanding30DAbove);
                CustLedgerEntry.RESET;
                CustLedgerEntry.SETRANGE("Customer No.", "No.");
                CustLedgerEntry.SETFILTER("Posting Date", '<=%1', AsOnDate_gDte);
                CustLedgerEntry.SETFILTER(CustLedgerEntry."Remaining Amount", '<>%1', 0);
                CustLedgerEntry.SETFILTER("Global Dimension 1 Code", Customer.GETFILTER("Global Dimension 1 Filter"));
                CustLedgerEntry.SETRANGE("Document Type", CustLedgerEntry."Document Type"::Invoice);
                IF CustLedgerEntry.FINDFIRST THEN BEGIN
                    REPEAT
                        CustLedgerEntry.CALCFIELDS("Remaining Amount");
                        CLEAR(DateCalc_lInt);
                        DateCalc_lInt := AsOnDate_gDte - CustLedgerEntry."Posting Date";
                        CASE DateCalc_lInt OF
                            //      0..6: Amount0_30_gDec += CustLedgerEntry."Remaining Amount";
                            //      7..13: Amount31_60_gDec += CustLedgerEntry."Remaining Amount";
                            //      14..20: Amount61_90_gDec += CustLedgerEntry."Remaining Amount";
                            //      21..28: Amount91_180_gDec += CustLedgerEntry."Remaining Amount";
                            //29..1000: Amount270_gDec += CustLedgerEntry."Remaining Amount";
                            0 .. 30:
                                Outstanding30D += CustLedgerEntry."Remaining Amount";
                            ELSE
                                Outstanding30DAbove += CustLedgerEntry."Remaining Amount";
                        END;
                    UNTIL CustLedgerEntry.NEXT = 0;
                END;

                DetailedCustLedgEntry.RESET;
                DetailedCustLedgEntry.SETRANGE(DetailedCustLedgEntry."Customer No.", Customer."No.");
                DetailedCustLedgEntry.SETRANGE(DetailedCustLedgEntry."Posting Date", 0D, AsOnDate_gDte);
                IF DetailedCustLedgEntry.FINDSET THEN
                    REPEAT
                        NetChange += DetailedCustLedgEntry.Amount;
                    UNTIL DetailedCustLedgEntry.NEXT = 0;

                CLEAR(TotalAmt_gDec);
                CLEAR(Grandtotl);
                TotalAmt_gDec := Amount0_30_gDec + Amount31_60_gDec + Amount61_90_gDec + Amount91_180_gDec + Amount270_gDec;
                Grandtotl += TotalAmt_gDec;
                //IF (Grandtotl < 0.1) AND (Rqty < 0.1) THEN
                //CurrReport.SKIP;

                IF Grandtotl < 0.1 THEN
                    CurrReport.SKIP;

                SrNo_gInt += 1;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Option)
                {
                    Caption = 'Option';
                    field("As on Date"; AsOnDate_gDte)
                    {
                        ApplicationArea = All;
                    }
                    field(HeadingType; HeadingType)
                    {
                        Caption = 'Heading Type';
                        OptionCaption = 'Date Interval,Number of Days';
                        ApplicationArea = All;
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        //AsOnDate_gDte :=WORKDATE;
        AsOnDate_gDte := CALCDATE('-2D', WORKDATE);
        //AsOnDate_gDte := AsOnDate_gDte;
        CreateHeadings;
    end;

    var
        Starting_gDte: Date;
        Ending_gDte: Date;
        Amount0_30_gDec: Decimal;
        Amount31_60_gDec: Decimal;
        Amount61_90_gDec: Decimal;
        Amount91_180_gDec: Decimal;
        Amount181_270_gDec: Decimal;
        Amount270_gDec: Decimal;
        BeforeAmount_gDec: Decimal;
        CompanyInformation_gRec: Record 79;
        CompanyAddress_gTxt: Text;
        SrNo_gInt: Integer;
        TotalAmt_gDec: Decimal;
        AsOnDate_gDte: Date;
        "Filter": Code[20];
        HeadingType: Option "Date Interval","Number of Days";
        HeadingText: array[10] of Text;
        SalespersonPurchaser: Record 13;
        SalesName: Text;
        RSalesInvoiceLine: Record 113;
        Rqty: Decimal;
        EndingDate: Date;
        StartDate: Date;
        EndDate: Date;
        ColourBool: Boolean;
        colourtext: Text;
        Grandtotl: Decimal;
        SalesValue: Decimal;
        Outstanding30D: Decimal;
        Outstanding30DAbove: Decimal;
        DetailedCustLedgEntry: Record 379;
        NetChange: Decimal;

    local procedure CreateHeadings()
    var
        i: Integer;
    begin
        IF HeadingType = HeadingType::"Date Interval" THEN BEGIN
            HeadingText[1] := FORMAT(AsOnDate_gDte) + ' - ' + FORMAT(CALCDATE('-6D', AsOnDate_gDte));
            HeadingText[2] := FORMAT(CALCDATE('-07D', AsOnDate_gDte)) + ' - ' + FORMAT(CALCDATE('-13D', AsOnDate_gDte));
            HeadingText[3] := FORMAT(CALCDATE('-14D', AsOnDate_gDte)) + ' - ' + FORMAT(CALCDATE('-20D', AsOnDate_gDte));
            HeadingText[4] := FORMAT(CALCDATE('-21D', AsOnDate_gDte)) + ' - ' + FORMAT(CALCDATE('-28D', AsOnDate_gDte));
            HeadingText[5] := '> ' + FORMAT(CALCDATE('-28D', AsOnDate_gDte));
        END ELSE BEGIN
            HeadingText[1] := '0 - 06';
            HeadingText[2] := '07 - 13';
            HeadingText[3] := '14 - 20';
            HeadingText[4] := '21 - 28';
            HeadingText[5] := '> 28';
        END;
    end;
}

