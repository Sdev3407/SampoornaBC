report 50028 "Sales Invoice Star Foods"
{
    UsageCategory = Administration;
    Caption = 'Sales Invoice Star Foods';
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'ReportLayout\StarFoodInvoice.rdl';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            //CalcFields = "Amount to Customer";
            column(TCSINF; TCSINF)
            {
            }
            column(IRNHash_SalesInvoiceHeader; "Sales Invoice Header"."E-Invoice No.")
            {
            }
            column(QRCode_SalesInvoiceHeader; "Sales Invoice Header"."E-Invoice QR Code")
            {
            }
            column(Payment_QR_Code; "Sales Invoice Header"."Payment QR Code")
            { }
            column(PrintGSTTerm; PrintGSTTerm)
            {
            }
            column(Type_of_Sale; Type_of_Sale)
            {
            }
            column(Sale; Sale)
            {
            }
            column(LocationName; LocationName)
            {
            }
            column(StateName; StateName)
            {
            }
            column(TC1; TC1)
            {
            }
            column(TC2; TC2)
            {
            }
            column(TC3; TC3)
            {
            }
            column(TC4; TC4)
            {
            }
            column(TC5; TC5)
            {
            }
            column(TC6; TC6)
            {
            }
            column(TC7; TC7)
            { }
            column(TC8; TC8)
            { }
            column(InvoiceDec; InvoiceDec)
            { }
            column(PlaceofSupply_SalesInvoiceHeader; FORMAT("Sales Invoice Header"."Ship-to City") + ' ' + FORMAT(StateDescription))
            {
            }
            column(PONo_SalesInvoiceHeader; "Sales Invoice Header"."External Document No.")
            {
            }
            column(PODate_SalesInvoiceHeader; "Sales Invoice Header"."Order Date")
            {
            }
            column(PaymentTerms; PaymentTerms)
            {
            }
            column(PrepaymentOrderNo_SalesInvoiceHeader; "Sales Invoice Header"."Prepayment Order No.")
            {
            }
            column(ExternalDocNo; "Sales Invoice Header"."External Document No.")
            {
            }
            column(SerialNo; SerialNo)
            {
            }
            column(mobileno; mobileno)
            {
            }
            column(ShiptoPhone; ShiptoPhone)
            {
            }
            column(gstLoc; gstLoc)
            {
            }
            column(AddLoc; AddLoc)
            {
            }
            column(NameLoc; NameLoc)
            {
            }
            column(Fssi; Fssi)
            {
            }
            column(Alt_Qty_Caption; Alt_Qty_Caption)
            {
            }
            column(Alt_UOM_Caption; Alt_UOM_Caption)
            {
            }
            column(GST_Rate_Caption; GST_Rate_Caption)
            {
            }
            column(No_SalesInvoiceHeader; "Sales Invoice Header"."No.")
            {
            }
            column(GSTInfo1; GSTInfo1)
            {
            }
            column(GSTInfo2; GSTInfo2)
            {
            }
            column(GSTInfo3; GSTInfo3)
            {
            }
            column(GSTInfo4; GSTInfo4)
            {
            }
            column(WEBSITE_VALUE; "website value")
            {
            }
            column(Print; Print)
            {
            }
            column(print1; print1)
            {
            }
            column(print2; print2)
            {
            }
            column(Special; Special)
            {
            }
            column(Line_Discount; LineDiscount)
            {
            }
            dataitem(CopyLoop; 2000000026)
            {
                DataItemTableView = SORTING(Number);
                dataitem(PageLoop; 2000000026)
                {
                    DataItemTableView = SORTING(Number)
                                        WHERE(Number = CONST(1));
                    column(AmounttoCustomer_SalesInvoiceHeader; TCS + "Sales Invoice Header"."Amount" + CGST111 + SGST111 + IGST111)
                    {
                    }
                    column(TimeofSupply; TimeofSupply)
                    {
                    }
                    column(OutputNo; OutputNo)
                    {
                    }
                    column(CopyText; CopyText)
                    {
                    }
                    column(shipGSTCode; shipGSTCode)
                    {
                    }
                    column(ShipToGST; ShipToGST)
                    {
                    }
                    column(CusPAN; CusPAN)
                    {
                    }
                    column(CusGST; CusGST)
                    {
                    }
                    column(CusStateCode; CusStateCode)
                    {
                    }
                    column(Conditions; TermsConditionRec.Description)
                    {
                    }
                    column(Company_Name; CompanyInfo.Name)
                    {
                    }
                    column(Company_Email; CompanyInfo."E-Mail")
                    {
                    }
                    column(Company_CIN_No; CompanyInfo."SFPL_C.I.N No.")
                    {
                    }
                    column(Company_Ship_To_Address; CompanyInfo.Address)
                    {
                    }
                    column(Company_Ship_To_Address2; CompanyInfo."Address 2")
                    {
                    }
                    column(PostCode_CompInfo; CompanyInfo."Post Code")
                    {
                    }
                    column(Email_ComInfo; CompanyInfo."E-Mail")
                    {
                    }
                    column(PhoneNo_CompInfo; CompanyInfo."Phone No.")
                    {
                    }
                    column(Fax_CompInfo; CompanyInfo."Fax No.")
                    {
                    }
                    column(RoundOffAmt; RoundOffAmt)
                    {
                    }
                    column(Company_Ship_To_City; CompanyInfo.City)
                    {
                    }
                    column(Company_Ship_To_PostCode; CompanyInfo."Ship-to Post Code")
                    {
                    }
                    column(GST_No_Company; LocGSTCode)
                    {
                    }
                    column(GSTCustomerType_SalesInvoiceHeader; "Sales Invoice Header"."GST Customer Type")
                    {
                    }
                    column(Transport_Method_salesheader; "Sales Invoice Header"."Shipment Method Code")
                    {
                    }
                    column(Place_of_Supply_salesline; FORMAT("Sales Invoice Header"."Ship-to City") + ' ' + FORMAT(StateDescription))
                    {
                    }
                    column(Vehicle_no_salesheader; "Sales Invoice Header"."Vehicle No.")
                    {
                    }
                    column(Ext_Doc_No_salesheader; "Sales Invoice Header"."External Document No.")
                    {
                    }
                    column(Job_No_Salesheader; "Sales Invoice Header"."P.A.N. No.")
                    {
                    }
                    column(Trans_Code_Salesheader; AgentDes)
                    {
                    }
                    column(No_SalesHeader; "Sales Invoice Header"."No.")
                    {
                    }
                    column(Doc_Date_SalesHeader; "Sales Invoice Header"."Document Date")
                    {
                    }
                    column(Bill_to_name_Salesheader; "Sales Invoice Header"."Bill-to Name")
                    {
                    }
                    column(Bill_to_name2_Salesheader; "Sales Invoice Header"."Bill-to Name 2")
                    {
                    }
                    column(Bill_to_Add_salesHeader; "Sales Invoice Header"."Bill-to Address")
                    {
                    }
                    column(Bill_to_AddII_salesHeader; "Sales Invoice Header"."Bill-to Address 2")
                    {
                    }
                    column(Bill_to_city_SalesHeader; "Sales Invoice Header"."Bill-to City")
                    {
                    }
                    column(Ship_To_name_salesHeader; ShiptoName)
                    {
                    }
                    column(ShiptoName2; ShiptoName2)
                    {
                    }
                    column(Ship_To_Add_salesHeader; ShipToAdd)
                    {
                    }
                    column(Ship_To_AddII_salesHeader; ShipToAdd2)
                    {
                    }
                    column(Ship_To_City_salesHeader; ShipToCity)
                    {
                    }
                    column(Ship_to_post_code; ShiptoCode)
                    {
                    }
                    column(ShiptoState; ShiptoState)
                    {
                    }
                    column(ShiptoCountry; ShiptoCountry)
                    {
                    }
                    column(bill_to_Post_code; "Sales Invoice Header"."Bill-to Post Code")
                    {
                    }
                    column(Time_of_Removal; "Sales Invoice Header"."Time of Removal")
                    {
                    }
                    column(IGST_Caption; "IGST Caption")
                    {
                    }
                    column(CUSTOMER_tYPE; Export)
                    {
                    }
                    column(GSTIN_no_Caption; "GSTIN NO caption")
                    {
                    }
                    column(CGST_Caption; "CGST Caption")
                    {
                    }
                    column(SGST_Caption; "SGST Caption")
                    {
                    }
                    column(TCS_Caption; "TCS Caption")
                    {
                    }
                    column(CIN_Caption; "CIN Caption")
                    {
                    }
                    column(Invoice_No_Caption; "Invoice No Caption")
                    {
                    }
                    column(Invoice_Date_Caption; "Invoice Date Caption")
                    {
                    }
                    column(DnT_Supply_Caption; "D&T Supply Caption")
                    {
                    }
                    column(DnT_Removal_Caption; "D&T Removal Caption")
                    {
                    }
                    column(TAX_is_PAYABLE; T0001)
                    {
                    }
                    column(Details_of_reciever; T0002)
                    {
                    }
                    column(TCS; TCS)
                    {
                    }
                    column(Party_Name_Caption; "Party Name Caption")
                    {
                    }
                    column(Address_Caption; "Address Caption")
                    {
                    }
                    column(State_Code_Caption; "State Code Caption")
                    {
                    }
                    column(GSTIN_Rec_Caption; "GSTIN Rec Caption")
                    {
                    }
                    column(PIN_caption; "PIN caption")
                    {
                    }
                    column(PAN_Caption; "PAN Caption")
                    {
                    }
                    column(Trans_Mode_Caption; "Trans Mode Caption")
                    {
                    }
                    column(Trans_Name_Caption; "Trans Name Caption")
                    {
                    }
                    column(Vehicle_Caption; "Vehicle Caption")
                    {
                    }
                    column(Place_of_supply_Caption; "Place of supply Caption")
                    {
                    }
                    column(PO_No_Caption; "PO No Caption")
                    {
                    }
                    column(Job_No_Caption; "Job No Caption")
                    {
                    }
                    column(Details_of_Consignee; T0003)
                    {
                    }
                    column(Tax_Invoice_Caption; ReportCaption)
                    {
                    }
                    column(State_Salesheader; LocStateCode)
                    {
                    }
                    column(t01; t01)
                    {
                    }
                    column(company_CIN; CompanyInfo."SFPL_C.I.N No.")
                    {
                    }
                    column(company_Picture; CompanyInfo.Picture)
                    {
                    }
                    column(eMAIL_cAPTION; Email)
                    {
                    }
                    column(wEBSITE_cAPTION; WEBSITE)
                    {
                    }
                    column(BankAcc; BankAcc)
                    {
                    }
                    column(BankName; BankName)
                    {
                    }
                    column(BankAdd; BankAdd)
                    {
                    }
                    column(IFSCCode; IFSCCode)
                    {
                    }
                    column(our_bank_caption; "our bank caption")
                    {
                    }
                    column(Bank_Account_No_Caption; "Bank Account No Caption")
                    {
                    }
                    column(ifsc_code_caption; "ifsc code caption")
                    {
                    }
                    column(Branch_Address_captio; "Branch Address caption")
                    {
                    }
                    column(Total_INVOICE_CAPTION; "Total Invoice Value (Rs.) Caption")
                    {
                    }
                    column(SalesHeader_InvoiceRemarks; "Description Caption")
                    {
                    }
                    column(invoice_remarks_caption; "Invoice Remarks Caption")
                    {
                    }
                    column(electronic_caption; "Electronic Referance No: Capption")
                    {
                    }
                    column(e04; e04)
                    {
                    }
                    column(e03; e03)
                    {
                    }
                    column(e02; e02)
                    {
                    }
                    column(e01; e01)
                    {
                    }
                    column(invoice_remarks; "Description Caption")
                    {
                    }
                    column(O_E_Caption; "E. & O.E. Caption")
                    {
                    }
                    column(TextVar; TextVar)
                    {
                    }
                    column(TextVar1; TextVar1)
                    {
                    }
                    column(s04; s04)
                    {
                    }
                    column(s03; s03)
                    {
                    }
                    column(s02; s02)
                    {
                    }
                    column(s01; s01)
                    {
                    }
                    column(Special_Caption; "Special Caption")
                    {
                    }
                    column(t02; t02)
                    {
                    }
                    column(total_GST_Caption; "total GST Caption")
                    {
                    }
                    column(text_under_Tax_Invoice; TT01)
                    {
                    }
                    column(ReverseCharge_TextVar; ReverseCharge_TextVar)
                    {
                    }
                    column(CountryName; CountryName)
                    {
                    }
                    column(Freight; "Sales Invoice Header"."Freight Value")
                    {
                    }
                    column(ShipStateName; ShipStateName)
                    {
                    }
                    dataitem("Sales Invoice Line"; "Sales Invoice Line")
                    {
                        DataItemLink = "Document No." = FIELD("No.");
                        DataItemLinkReference = "Sales Invoice Header";
                        DataItemTableView = SORTING("Document No.", "Line No.")
                                            WHERE("No." = FILTER(<> 423730));
                        column(Alt_Qty; '')
                        {
                        }
                        column(Alt_UOM; '')
                        {
                        }
                        column(DocumentNo_SIl; "Sales Invoice Line"."Document No.")
                        {
                        }
                        column(GST_RATE_VALUE; GST_RATE_VALUE)
                        {
                        }
                        column(LineAmount; LineAmount)
                        {
                        }
                        column(SalesInvoiceLineCrossReferenceNo; "Sales Invoice Line"."Line No.")
                        {
                        }
                        column(CGSTText; CGSTText)
                        {
                        }
                        column(SGSTText; SGSTText)
                        {
                        }
                        column(IGSTText; IGSTText)
                        {
                        }
                        column(No_salesline; "Sales Invoice Line"."No.")
                        {
                        }
                        column(Salesline_UOM; "Sales Invoice Line"."Unit of Measure Code")
                        {
                        }
                        // column(TotalTCSAmt1;"Sales Invoice Line"."TDS/TCS Amount")
                        // {
                        // }
                        column(TotalTCSAmt; TotalTCSAmt)
                        {
                        }
                        // column(TDSTCSAmount_SalesInvoiceLine;TDSTCSAmount_SalesInvoiceLine)
                        // {
                        // }
                        column(TCSNatureofCollection_SalesInvoiceLine; "Sales Invoice Line"."TCS Nature of Collection")
                        {
                        }
                        column(invoice_words2; numtext2[1])
                        {
                        }
                        column(gstwords; numtext1[1])
                        {
                        }
                        column(GST_Amt; GSTAmt)
                        {
                        }
                        column(L05; L05)
                        {
                        }
                        column(L04; L04)
                        {
                        }
                        column(L03; L03)
                        {
                        }
                        column(L02; L02)
                        {
                        }
                        column(L01; L01)
                        {
                        }
                        column(Posting_Date; "Sales Invoice Header"."Posting Date")
                        {
                        }
                        column(Package_No; "Description Caption")
                        {
                        }
                        column(LR_RRno; "Sales Invoice Header"."LR/RR No.")
                        {
                        }
                        column(LR_RR_Date; "Sales Invoice Header"."LR/RR Date")
                        {
                        }
                        // column(TDS_Percent;"Sales Invoice Line"."TDS/TCS %")
                        // {
                        // }
                        column(amount_to_customer; ROUND("Sales Invoice Line".Amount, 1, '='))
                        {
                        }
                        column(Line_Discount_percent; "Sales Invoice Line"."Line Discount Amount")
                        {
                        }
                        column(invoice_words_caption; "Total Invoice Value Caption")
                        {
                        }
                        column(Total_Invoice_Value; "Total Invoice Value (Rs.) Caption")
                        {
                        }
                        column(Taxable_Amount_Caption; "Taxable Amount Caption")
                        {
                        }
                        column(Insurance_Charges_Caption; "Insurance Charges Caption")
                        {
                        }
                        column(ShipPAN; ShipPAN)
                        {
                        }
                        column(Freight_Charge_Caption; "Freight Charge Caption")
                        {
                        }
                        column(Packing_Forwarding_Caption; "Packing & Forwarding Caption")
                        {
                        }
                        column(Net_Amount_Caption; "Net Amount Caption")
                        {
                        }
                        column(Less_Discount_Caption; "Less Discount Caption")
                        {
                        }
                        column(Salesline_Description; Salesline_Description)
                        {
                        }
                        column(Salesline_HSN_Code; "Sales Invoice Line"."HSN/SAC Code")
                        {
                        }
                        column(Salesline_Unit_Price; "Sales Invoice Line"."Unit Price")
                        {
                        }
                        column(Salesline_Total_Amount; ROUND("Sales Invoice Line".Amount, 0.01, '='))
                        {
                        }
                        column(S_No_Caption; "S.No Captiion")
                        {
                        }
                        column(Item_Code_Caption; "Item Code Caption")
                        {
                        }
                        column(BankCity; BankCity)
                        {
                        }
                        column(Description_Caption; "Description Caption")
                        {
                        }
                        column(HSN_Code_Caption; "HSN Code Caption")
                        {
                        }
                        column(Quantity_Caption; "Quantity Caption")
                        {
                        }
                        column(UOM_Caption; "UOM Caption")
                        {
                        }
                        column(Unit_Price_Caption; "Unit Price Caption")
                        {
                        }
                        column(Total_Amount_Caption; "Total Amount Caption")
                        {
                        }
                        column(Salesline_Quantity; "Sales Invoice Line".Quantity)
                        {
                        }
                        column(srno; SrNo)
                        {
                        }
                        column(SrNo_ForAllLines; SrNo_ForAllLines)
                        {
                        }
                        column(Last_Caption; "Last Caption")
                        {
                        }
                        column(CGST11; CGST11)
                        {
                        }
                        column(IGST11; IGST11)
                        {
                        }
                        column(SGST11; SGST11)
                        {
                        }
                        column(sgst; sgst)
                        {
                        }
                        column(cgst; cgst)
                        {
                        }
                        column(InsCharges; InsCharges)
                        {
                        }
                        column(PackingCharges; PackingCharges)
                        {
                        }
                        column(FreightCharges; FreightCharges)
                        {
                        }
                        column(igst; igst)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            IF COPYSTR("Sales Invoice Line".Description, 1, 11) = 'Shipment No' THEN BEGIN
                                CurrReport.SKIP;
                            END;

                            IF "Sales Invoice Line"."No." = '301850' THEN
                                CurrReport.SKIP;

                            SerialNo += 1;
                            //>>PRU_RPG  28-Aug-2017
                            LineCounter += 1;
                            LineAmount := ("Sales Invoice Line"."Unit Price" * "Sales Invoice Line".Quantity);
                            IF ("Sales Invoice Line".Description <> '') THEN
                                //IF ("Sales Invoice Line"."Cross-Reference No." <> '') THEN
                                //Salesline_Description := FORMAT("Sales Invoice Line".Description)+','+FORMAT("Sales Invoice Line"."Cross-Reference No.")
                                //Salesline_Description := FORMAT("Sales Invoice Line".Description)+', Cross-Ref No '+FORMAT("Sales Invoice Line"."Cross-Reference No.")
                                //ELSE
                                Salesline_Description := FORMAT("Sales Invoice Line".Description)
                            //ELSE
                            // IF ("Sales Invoice Line"."Cross-Reference No." <> '') THEN
                            //Salesline_Description := 'Cross-Ref No '+FORMAT("Sales Invoice Line"."Cross-Reference No.")
                            //Salesline_Description :=FORMAT("Sales Invoice Line"."Cross-Reference No.")
                            ELSE
                                Salesline_Description := '';

                            CLEAR(CGST11);
                            CLEAR(SGST11);
                            CLEAR(IGST11);
                            CLEAR(igst);
                            CLEAR(cgst);
                            CLEAR(sgst);
                            Clear(GST_RATE_VALUE);
                            RecDetaileGSTLedgerEntry.RESET;
                            RecDetaileGSTLedgerEntry.SETRANGE("Document No.", "Document No.");
                            RecDetaileGSTLedgerEntry.SETRANGE("No.", "No.");
                            RecDetaileGSTLedgerEntry.SETRANGE(RecDetaileGSTLedgerEntry."Posting Date", "Sales Invoice Line"."Posting Date");
                            //RecDetaileGSTLedgerEntry.SETRANGE(RecDetaileGSTLedgerEntry."Document Line No.", "Sales Invoice Line"."Line No.");
                            IF RecDetaileGSTLedgerEntry.FINDFIRST THEN
                                REPEAT
                                    GST_RATE_VALUE += RecDetaileGSTLedgerEntry."GST %";
                                    IF RecDetaileGSTLedgerEntry."GST Component Code" = 'CGST' THEN BEGIN
                                        CGST11 := ABS(RecDetaileGSTLedgerEntry."GST Amount");
                                        cgst := CGST11;
                                        CGSTText := STRSUBSTNO('CGST %1 %', ROUND(RecDetaileGSTLedgerEntry."GST %", 0.01, '='))
                                    END;
                                    IF RecDetaileGSTLedgerEntry."GST Component Code" = 'SGST' THEN BEGIN
                                        SGST11 := ABS(RecDetaileGSTLedgerEntry."GST Amount");
                                        sgst := SGST11;
                                        SGSTText := STRSUBSTNO('SGST %1 %', ROUND(RecDetaileGSTLedgerEntry."GST %", 0.01, '='))
                                    END;
                                    IF RecDetaileGSTLedgerEntry."GST Component Code" = 'IGST' THEN BEGIN
                                        IGST11 := ABS(RecDetaileGSTLedgerEntry."GST Amount");
                                        igst := IGST11;
                                        IGSTText := STRSUBSTNO('IGST %1 %', ROUND(RecDetaileGSTLedgerEntry."GST %", 0.01, '='))
                                    END;

                                UNTIL RecDetaileGSTLedgerEntry.NEXT = 0;

                            TCSAmt1 := 0;
                            if FLAg = true then begin
                                TCSENtry.Reset();
                                TCSENtry.SetRange("Document No.", "Sales Invoice Line"."Document No.");
                                if TCSENtry.FindFirst() then
                                    TCSAmt1 := TCSENtry."TCS Amount";
                                FLAg := false;
                            end;
                            // "Sales Invoice Header".CALCFIELDS(Amount);
                            // TotAmt:="Sales Invoice Header"."Amount to Customer";
                            // check1.InitTextVariable;
                            // check1.FormatNoText(numtext2,TotAmt,'');
                            //MESSAGE('%1',TotAmt);
                            "Sales Invoice Header".CALCFIELDS(Amount);//"Amount to Customer");
                            TotAmt := ROUND(TCSAmt1 + "Sales Invoice Header"."Amount" + CGST11 + SGST11 + IGST11, 1, '=');
                            // check1.InitTextVariable;
                            // check1.FormatNoText1(numtext2, TCS + "Sales Invoice Header".Amount + IGST11 + CGST11 + SGST11, '');
                            // check1.InitTextVariable;
                            // check1.FormatNoText1(numtext1, CGST11 + SGST11 + IGST11, '');

                        end;

                        trigger OnPreDataItem()
                        begin
                            SerialNo := 0;
                            CLEAR(Salesline_Description);
                            CLEAR(TotalTCSAmt);
                            CLEAR(GSTAmt);
                            CLEAR(igst);
                            CLEAR(cgst);
                            CLEAR(sgst);
                            CLEAR(CGSTText);
                            CLEAR(SGSTText);
                            CLEAR(IGSTText);
                            CLEAR(TotAmt);
                            CGSTText := 'CGST %';
                            SGSTText := 'SGST %';
                            IGSTText := 'IGST %';
                            TotalLine := 10;
                            LineCounter := 0;
                        end;
                    }
                    dataitem(Integer; Integer)
                    {
                        DataItemTableView = SORTING(Number);
                        column(Number_Integer; Integer.Number)
                        {
                        }

                        trigger OnPreDataItem()
                        begin
                            Integer.SETRANGE(Number, 0, TotalLine - LineCounter); //Pru Gulshan
                        end;
                    }
                }

                trigger OnAfterGetRecord()
                begin


                    CLEAR(TextVar);
                    CLEAR(TextVar1);
                    /*IF Number > 1 THEN BEGIN
                      CopyText := Text003;
                      OutputNo += 1;
                    END;
                    MESSAGE(FORMAT(OutputNo));*/
                    IF Number = 1 THEN BEGIN
                        CopyText := 'Original for Recipient';
                        OutputNo += 1;
                    END;
                    IF Number = 2 THEN BEGIN
                        CopyText := 'Duplicate for Transporter';
                        OutputNo += 1;
                    END;
                    IF Number = 3 THEN BEGIN
                        CopyText := 'Triplicate for Supplier';
                        OutputNo += 1;
                    END;
                    IF Number = 4 THEN BEGIN
                        CopyText := 'Extra Copy';
                        OutputNo += 1;
                    END;
                    IF Number > 4 THEN BEGIN
                        CopyText := 'Copy-1';
                        OutputNo += 1;
                    END;

                    GstRec.RESET;

                    BankRec.RESET;
                    BankRec.SETRANGE("No.", "Sales Invoice Header"."Bank Account No.");
                    IF BankRec.FINDFIRST THEN BEGIN
                        BankAcc := BankRec."Bank Account No.";
                        BankName := BankRec.Name;
                        IFSCCode := BankRec."IFSC Code";
                        BankAdd := BankRec.Address + ',' + BankRec."Address 2";
                        BankCity := BankRec.City;
                    END;


                    LocRec.RESET;
                    LocRec.SETRANGE(Code, "Sales Invoice Header"."Location Code");
                    IF LocRec.FINDFIRST THEN BEGIN
                        LocGSTCode := LocRec."GST Registration No.";
                        StateRec.RESET;
                        StateRec.SETRANGE(StateRec.Code, LocRec."State Code");
                        IF StateRec.FINDFIRST THEN BEGIN
                            LocStateCode := StateRec."State Code (GST Reg. No.)";
                        END;
                    END;
                    CusRec.RESET;
                    CusRec.SETRANGE("No.", "Sales Invoice Header"."Sell-to Customer No.");
                    IF CusRec.FINDFIRST THEN BEGIN
                        CusGST := CusRec."GST Registration No.";
                        CusPAN := CusRec."P.A.N. No.";
                        IF (CusRec."GST Customer Type" = CusRec."GST Customer Type"::Unregistered) THEN
                            ReverseCharge_TextVar := 'Yes'
                        ELSE
                            ReverseCharge_TextVar := 'No';

                        //PRU_RPG CusStateCode := CusRec."State Code" ;

                        StateRec.RESET;
                        StateRec.SETRANGE(StateRec.Code, CusRec."State Code");
                        IF StateRec.FINDFIRST THEN BEGIN
                            CusStateCode := StateRec."State Code (GST Reg. No.)";
                            ShipPAN := CusRec."P.A.N. No.";
                            CustStateName := StateRec.Description;
                        END;
                    END;
                    IF "Sales Invoice Header"."Ship-to Code" <> '' THEN BEGIN
                        ShipRec.RESET;
                        ShipRec.SETRANGE("Customer No.", "Sales Invoice Header"."Sell-to Customer No.");
                        ShipRec.SETRANGE(Code, "Sales Invoice Header"."Ship-to Code");
                        IF ShipRec.FINDFIRST THEN BEGIN
                            ShipToGST := ShipRec."GST Registration No.";
                            StateRec.RESET;
                            StateRec.SETRANGE(StateRec.Code, ShipRec.State);
                            IF StateRec.FINDFIRST THEN BEGIN
                                shipGSTCode := StateRec."State Code (GST Reg. No.)";
                                ShipStateName := StateRec.Description;
                            END;
                        END;
                    END;
                    //MESSAGE(shipGSTCode);
                    IF "Sales Invoice Header"."Ship-to Code" = '' THEN BEGIN
                        ShipToGST := CusGST;
                        ShipPAN := CusPAN;
                        shipGSTCode := CusStateCode;
                        ShipStateName := CustStateName;
                    END;

                    SrNo := 0;
                    TotAmt := 0;
                    CLEAR(SrNo_ForAllLines);


                    TextVar := s04;
                    TextVar1 := TextConst1;
                    IF "Sales Invoice Header"."GST Ship-to State Code" <> '' THEN BEGIN
                        CLEAR(StateDescription);
                        StateRec.RESET;
                        StateRec.SETRANGE(StateRec.Code, "Sales Invoice Header"."GST Ship-to State Code");
                        IF StateRec.FINDFIRST THEN
                            StateDescription := '- ' + StateRec.Description;
                    END ELSE BEGIN
                        CLEAR(StateDescription);
                        StateRec.RESET;
                        StateRec.SETRANGE(StateRec.Code, "Sales Invoice Header"."GST Bill-to State Code");
                        IF StateRec.FINDFIRST THEN
                            StateDescription := '- ' + StateRec.Description;
                    END;

                    CLEAR(TCS);
                    RecTCS.RESET;
                    RecTCS.SETRANGE("Document No.", "Sales Invoice Header"."No.");
                    IF RecTCS.FINDFIRST THEN
                        repeat
                            TCS += ABS(RecTCS."TCS Amount");
                        until RecTCS.Next() = 0;
                    CLEAR(LineDiscount);
                    Clear(CGST111);
                    Clear(SGST111);
                    Clear(IGST111);
                    SalesInvoiceLine.RESET;
                    SalesInvoiceLine.SETRANGE("Document No.", "Sales Invoice Header"."No.");
                    IF SalesInvoiceLine.FINDFIRST THEN
                        REPEAT
                            RecDetaileGSTLedgerEntry.RESET;
                            RecDetaileGSTLedgerEntry.SETRANGE("Document No.", SalesInvoiceLine."Document No.");
                            RecDetaileGSTLedgerEntry.SETRANGE("No.", SalesInvoiceLine."No.");
                            RecDetaileGSTLedgerEntry.SETRANGE(RecDetaileGSTLedgerEntry."Posting Date", SalesInvoiceLine."Posting Date");
                            RecDetaileGSTLedgerEntry.SETRANGE("Document Line No.", SalesInvoiceLine."Line No.");
                            IF RecDetaileGSTLedgerEntry.FINDFIRST THEN
                                REPEAT
                                    IF RecDetaileGSTLedgerEntry."GST Component Code" = 'CGST' THEN BEGIN
                                        CGST111 += ABS(RecDetaileGSTLedgerEntry."GST Amount");
                                    END;
                                    IF RecDetaileGSTLedgerEntry."GST Component Code" = 'SGST' THEN BEGIN
                                        SGST111 += ABS(RecDetaileGSTLedgerEntry."GST Amount");

                                    END;
                                    IF RecDetaileGSTLedgerEntry."GST Component Code" = 'IGST' THEN BEGIN
                                        IGST111 += ABS(RecDetaileGSTLedgerEntry."GST Amount");

                                    END;

                                UNTIL RecDetaileGSTLedgerEntry.NEXT = 0;

                            //  gstwords += SalesInvoiceLine.Amount;//"Total GST Amount";
                            LineDiscount += SalesInvoiceLine."Line Discount Amount";
                        UNTIL SalesInvoiceLine.NEXT = 0;
                    gstwords := CGST111 + SGST111 + IGST111;
                    "Sales Invoice Header".CalcFields(Amount);
                    check1.InitTextVariable;
                    check1.FormatNoText1(numtext2, TCS + "Sales Invoice Header".Amount + IGST111 + CGST111 + SGST111, '');
                    check1.InitTextVariable;
                    check1.FormatNoText1(numtext1, CGST111 + SGST111 + IGST111, '');

                end;

                trigger OnPreDataItem()
                begin
                    NoOfLoops := ABS(NoOfCopies) + Cust."Invoice Copies";
                    IF NoOfLoops <= 0 THEN
                        NoOfLoops := 1;
                    CopyText := 'Original for Recipient';
                    SETRANGE(Number, 1, NoOfLoops);
                    OutputNo := 1;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                IF ("Sales Invoice Header"."Posting Date" > 20200930D) AND ("Sales Invoice Header"."Posting Date" <= 20210331D) THEN
                    TCSINF := 'With effect from 01-Oct-2020, Finance Act 2020 introduced Sec 206C (1H), which requires seller to collect tax at source (TCS) on sale of goods when consideration exceeds Rs. 50 lacs during the Financial year  2020-21 at 0.075%'
                ELSE
                    TCSINF := '';
                ///Pru_gk

                //Generalledger.GET;
                //IF Generalledger."Company Setup"= Generalledger."Company Setup"::StarFoods THEN
                Fssi := 'FSSAI License No.:-' + ' ' + CompanyInfo."SFPL_FSSAI No.";
                //MESSAGE('%1',Fssi);
                Generalledger.GET;

                //IF Generalledger."Company Setup"= Generalledger."Company Setup"::StarFoods THEN BEGIN
                IF "Sales Invoice Header"."Invoice Type" = "Sales Invoice Header"."Invoice Type"::"Bill of Supply" THEN BEGIN
                    GSTInfo1 := '"Goods Sold under this invoice bear unregistered Brand Name and I/We hereby voluntarily';
                    GSTInfo2 := ' forego any actionable claim or enforceable right in respect of these brand names-Exempt';
                    GSTInfo3 := ' Supply under Gst chargeable to 0% Tax."';
                    GSTInfo4 := '';
                    //  END ELSE BEGIN
                    //    GSTInfo1 := '';
                    //    GSTInfo2 := ' ';
                    //    GSTInfo3 := ' ';
                    //    GSTInfo4 := ' ';
                    //END;
                END;
                ///Pru_gk
                //Sale := FALSE;
                // IF "Sales Invoice Header"."Posting Date" > 20220718D THEN BEGIN
                Cust.RESET;
                Cust.SETRANGE("No.", "Sales Invoice Header"."Sell-to Customer No.");
                Cust.SETRANGE("Type of Customer", Cust."Type of Customer"::"Institutional Consumer");
                IF Cust.FINDFIRST THEN BEGIN
                    Sale := TRUE;
                    Type_of_Sale := 'GST Exempted for Institutional/Industrial Buyers Vide notification No 7/2022 Dt 13/07/2022.';
                END;
                //   END;
                GateEntryLine.RESET;
                GateEntryLine.SETRANGE(GateEntryLine."Entry Type", GateEntryLine."Entry Type"::Outward);
                GateEntryLine.SETRANGE(GateEntryLine."Source Type", GateEntryLine."Source Type"::"Sales Shipment");
                GateEntryLine.SETRANGE(GateEntryLine."Source No.", "Sales Invoice Header"."No.");
                IF GateEntryLine.FINDFIRST THEN
                    SourceNo := GateEntryLine."Gate Entry No.";

                GateEntryHeader.RESET;
                GateEntryHeader.SETRANGE("No.", SourceNo);
                IF GateEntryHeader.FINDFIRST THEN
                    freightAmount := GateEntryHeader."Total Freight Amount";
                PTRec.RESET;
                PTRec.SETRANGE(Code, "Sales Invoice Header"."Payment Terms Code");
                IF PTRec.FINDFIRST THEN
                    PaymentTerms := PTRec.Description;


                IF "Sales Invoice Header"."Invoice Type" = "Sales Invoice Header"."Invoice Type"::"Bill of Supply" THEN
                    ReportCaption := 'BILL OF SUPPLY'
                ELSE
                    IF "Sales Invoice Header"."Invoice Type" = "Sales Invoice Header"."Invoice Type"::"Debit Note" THEN
                        ReportCaption := 'DEBIT NOTE'
                    ELSE
                        ReportCaption := 'TAX INVOICE';

                CLEAR(StateName);
                LocRec.RESET;
                LocRec.SETRANGE(Code, "Sales Invoice Header"."Location Code");
                IF LocRec.FINDFIRST THEN BEGIN
                    State_rec.RESET;
                    State_rec.SETRANGE(State_rec.Code, LocRec."State Code");
                    IF State_rec.FINDFIRST THEN
                        StateName := State_rec.Description;

                    NameLoc := 'E-mail:' + CompanyInfo."E-Mail";
                    AddLoc := LocRec.Address + ' ' + LocRec."Address 2" + LocRec.City + ' ' + StateName + '- ' + LocRec."Post Code";
                    gstLoc := LocRec."GST Registration No.";
                END;
                //MESSAGE(StateName);

                GSTAmt := 0;
                IF TermsConditionRec.GET("Sales Invoice Header"."Terms Code") THEN

                    /*
                    IF "Sales Invoice Header"."GST Customer Type"= "Sales Invoice Header"."GST Customer Type"::Export THEN BEGIN
                      Special := "Special Caption";
                       Print := s01 ;
                       print1 :=  s02 ;
                       print2  := s03 ;
                       tr
                    END;
                    */
                CLEAR(Texxt);
                IF ("Sales Invoice Header"."GST Customer Type" = "Sales Invoice Header"."GST Customer Type"::Unregistered) THEN
                    Texxt := 'YES'
                ELSE
                    Texxt := 'No';
                CLEAR(Print);
                CLEAR(Special);

                Export := FALSE;
                IF "Sales Invoice Header"."GST Customer Type" = "Sales Invoice Header"."GST Customer Type"::Export THEN BEGIN
                    Export := TRUE;
                    T_44.RESET;
                    T_44.SETRANGE(T_44."Document Type", T_44."Document Type"::"Posted Invoice");
                    T_44.SETRANGE(T_44."No.", "Sales Invoice Header"."No.");
                    IF T_44.FINDLAST THEN
                        Print := T_44.Comment;
                    Special := TextConst2;
                END;

                RecShipment.RESET;
                RecShipment.SETRANGE("No.", "Sales Invoice Header"."Transporter Code");
                RecShipment.SETFILTER(Transporter, 'True');
                IF RecShipment.FINDFIRST THEN
                    AgentDes := RecShipment.Name;


                SIL.RESET;
                SIL.SETRANGE("Document No.", "No.");
                SIL.SETRANGE(SIL.Type, SIL.Type::"G/L Account");
                SIL.SETRANGE("No.", '301850');
                IF SIL.FINDFIRST THEN
                    RoundOffAmt := SIL."Line Amount";


                IF Cust1.GET("Sales Invoice Header"."Bill-to Customer No.") THEN BEGIN
                    IF Cust1."Country/Region Code" <> '' THEN
                        countrReg.GET(Cust1."Country/Region Code");
                    mobileno := Cust1."Phone No.";
                    IF Cust1."State Code" <> '' THEN
                        State1.GET(Cust1."State Code");
                    CountryName := countrReg.Name;
                    StateName := State1.Description;

                END;
                ShiptoAddRec.RESET;
                ShiptoAddRec.SETRANGE(Code, "Sales Invoice Header"."Ship-to Code");
                IF ShiptoAddRec.FINDFIRST THEN
                    mobileno2 := ShiptoAddRec."Phone No.";

                IF "Sales Invoice Header"."Ship-to Code" = '' THEN BEGIN
                    ShiptoName := "Sales Invoice Header"."Bill-to Name";
                    ShiptoName2 := "Sales Invoice Header"."Bill-to Name 2";
                    ShipToAdd := "Sales Invoice Header"."Bill-to Address";
                    ShipToAdd2 := "Sales Invoice Header"."Bill-to Address 2";
                    ShipToCity := "Sales Invoice Header"."Bill-to City";
                    ShiptoCode := "Sales Invoice Header"."Bill-to Post Code";
                    ShiptoState := StateName;
                    ShiptoCountry := CountryName;
                    ShiptoPhone := mobileno;
                END ELSE BEGIN
                    ShiptoName := "Sales Invoice Header"."Ship-to Name";
                    ShiptoName2 := "Sales Invoice Header"."Ship-to Name 2";
                    ShipToAdd := "Sales Invoice Header"."Ship-to Address";
                    ShipToAdd2 := "Sales Invoice Header"."Ship-to Address 2";
                    ShipToCity := "Sales Invoice Header"."Ship-to City";
                    ShiptoCode := "Sales Invoice Header"."Ship-to Post Code";
                    ShiptoPhone := mobileno2;

                    IF T222.GET("Sales Invoice Header"."Bill-to Customer No.", "Sales Invoice Header"."Ship-to Code") THEN BEGIN
                        IF T222."Country/Region Code" <> '' THEN
                            countrReg.GET(T222."Country/Region Code");
                        IF T222.State <> '' THEN
                            State1.GET(T222.State);
                        ShiptoCountry := countrReg.Name;
                        ShiptoState := State1.Description;
                    END;
                    //ShiptoState := StateName;
                    //ShiptoCountry := CountryName;
                END;
                /*IF "Sales Invoice Header"."Time of Supply" = 0T THEN
                  TimeofSupply := "Sales Invoice Header"."Time of Removal"
                ELSE
                  TimeofSupply := "Sales Invoice Header"."Time of Supply";
                */

                CLEAR(TCS);
                RecTCS.RESET;
                RecTCS.SETRANGE(RecTCS."Document No.", "No.");
                IF RecTCS.FINDFIRST THEN
                    TCS := ABS(RecTCS."TCS Amount");

                CLEAR(LineDiscount);
                RecDetaileGSTLedgerEntry.RESET;
                RecDetaileGSTLedgerEntry.SETRANGE(RecDetaileGSTLedgerEntry."Document No.", "No.");
                IF RecDetaileGSTLedgerEntry.FINDFIRST THEN
                    REPEAT
                        gstwords += RecDetaileGSTLedgerEntry."GST Amount";

                    UNTIL SalesInvoiceLine.NEXT = 0;

                SalesInvoiceLine.Reset();
                SalesInvoiceLine.SetRange("Document No.", "No.");
                if SalesInvoiceLine.FindFirst() then
                    repeat
                        LineDiscount += SalesInvoiceLine."Line Discount Amount";
                    until SalesInvoiceLine.Next() = 0;

                check1.InitTextVariable;
                check1.FormatNoText(numtext1, gstwords, '');

                IF T_14.GET("Sales Invoice Header"."Location Code") THEN
                    LocationName1 := T_14.Name;
                T_9.RESET;
                T_9.SETRANGE(Code, T_14."State Code");
                IF T_9.FINDFIRST THEN
                    LocationName := T_9.Description;

                if "Sales Invoice Header"."Posting Date" <= 20260626D then begin
                    TC1 := '1. Goods once sold will not be taken back';
                    TC2 := '2. Our risk and responsibility ceases after the goods leave our premises.';
                    TC3 := '3. Interest 18% p.a shall be charged for late payments.';
                    TC4 := '4. All payments should be made by way of DD/Cheque/RTGS.';
                    TC5 := '5. Discrepancy if any in the bill should be brought to our notice within 24 hours.';
                    TC6 := '6. All disputes subject to PUNJAB jurisdiction';
                end Else begin
                    TC1 := '1. Goods once sold will not be taken back';
                    TC2 := '2. Our risk and responsibility ceases after the goods leave our premises.';
                    TC3 := '3. Interest 18% P.A shall be charged if payment is not made within due date from Invoice date.';
                    TC4 := '4. All payments should be made by way of DD/Cheque/RTGS.';
                    TC5 := '5. Discrepancy if any in the bill should be brought to our notice within 24 hours.';
                    TC6 := '6. All disputes subject to Ludhiana Jurisdiction';
                    TC7 := '7. Statutory provisions of Section 393(1) & Other TDS sections will be applicable.';
                    if "Sales Invoice Header"."Shortcut Dimension 1 Code" = 'PROCESSING' Then
                        TC8 := '8. We hereby certify that the material mentioned on this invoice is/are warranted to be of the nature and quality which it/these purports/purported to be.'
                    Else
                        TC8 := '';
                end;

                if "Sales Invoice Header"."Posting Date" >= 20260626D then
                    InvoiceDec := 'This is a computer generated invoice, does not require a signature.';


            end;

            trigger OnPreDataItem()
            begin
                CompanyInfo.GET;
                CompanyInfo.CALCFIELDS(CompanyInfo.Picture);
                ReverseCharge_TextVar := 'yes';


                // PRU_AS 28 aug 2019 - start


                /*
                IF CompanyInfo.Name = 'STAR FOODS'THEN BEGIN
                
                   IF PrintGSTTerm = TRUE THEN BEGIN
                
                    GSTInfo1 := '"Goods Sold under this invoice bear unregistered Brand Name and I/We hereby voluntarily';
                    GSTInfo2 := ' forego any actionable claim or enforceable right in respect of these brand names-Exempt';
                    GSTInfo3 := ' Supply under Gst chargeable to 0% Tax."';
                    GSTInfo4 := '';
                  END
                    END
                  ELSE BEGIN
                    GSTInfo1 := ' ';
                    GSTInfo2 := ' ';
                    GSTInfo3 := ' ';
                    GSTInfo4 := ' ';
                  END;
                 */

                // PRU_AS 28 aug 2019 - end

            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group("No Of Copies")
                {
                    field(NoOfCopies; NoOfCopies)
                    {
                        Caption = 'No. of Copies';
                    }
                    field(PrintGSTTerm; PrintGSTTerm)
                    {
                        Caption = 'Print GST Terms and conditions';
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            PrintGSTTerm := TRUE;// PRU_AS 28 AUG 2019
        end;
    }

    labels
    {
    }

    var
        InvoiceDec: Text;
        PaymentTerm: Text[100];
        PaymentTerms: Text;
        PTRec: Record "Payment Terms";
        LineDiscount: Decimal;
        freightAmount: Decimal;
        SourceNo: Code[20];
        GateEntryHeader: Record "Posted Gate Entry Header";
        GateEntryLine: Record "Posted Gate Entry Line";
        SerialNo: Integer;
        mobileno2: Text;
        ShiptoPhone: Text;
        ShiptoAddRec: Record "Ship-to Address";
        mobileno: Text;
        gstLoc: Text;
        AddLoc: Text;
        NameLoc: Text;
        TermsConditionRec: Record "Terms And Conditions";
        CompanyInfo: Record "Company Information";
        TC1: Text;
        TC2: Text;
        TC3: Text;
        TC4: Text;
        TC5: Text;
        TC6: Text;
        TC7: Text;
        TC8: Text;
        TCo1: Label '1. Goods one sold will not be taken back';
        TCo2: Label '2. Our risk and responsibility ceases after the goods leave our premises.';
        TCo3: Label '3. Interest 18% p.a shall be charged for late payments.';
        TCo4: Label '4. All payments should be made by way of DD/Cheque/RTGS.';
        TCo5: Label '5. Discrepancy if any in the bill should be brought to our notice within 24 hours.';
        TCo6: Label '6. All disputes subject to ';
        Alt_Qty_Caption: Label 'Alt. Qty.';
        Alt_UOM_Caption: Label 'Alt. UOM';
        GST_Rate_Caption: Label 'GST %';
        "IGST Caption": Label 'IGST%';
        "CGST Caption": Label 'CGST%';
        "SGST Caption": Label 'SGST%';
        "TCS Caption": Label 'TCS%';
        "CIN Caption": Label 'CIN No.';
        "Invoice No Caption": Label 'Invoice No';
        "Invoice Date Caption": Label 'Invoice Date';
        "D&T Supply Caption": Label 'Date of Supply';
        "D&T Removal Caption": Label 'Date & Time of Removal';
        T0001: Label 'Tax is Payable On Reverse Charge  :';
        T0002: Label 'Details of Reciever(Billed to)';
        "Party Name Caption": Label 'Party Name';
        "Address Caption": Label 'Address';
        "State Code Caption": Label 'State Code :';
        "GSTIN Rec Caption": Label 'GSTIN/Unique ID';
        "PAN Caption": Label 'PAN NO';
        "Trans Mode Caption": Label 'Transportation Mode';
        "Trans Name Caption": Label 'Transporter Name';
        "Vehicle Caption": Label 'Vehicle No';
        "Place of supply Caption": Label 'Place of Supply';
        "PO No Caption": Label 'Purchase Order No';
        "Job No Caption": Label 'Job No';
        T0003: Label 'Details of Consignee(Shipped to)';
        "S.No Captiion": Label 'S. No';
        "Item Code Caption": Label 'Item Code';
        "Description Caption": Label 'Description';
        "HSN Code Caption": Label 'HSN Code';
        "Quantity Caption": Label 'Qty.';
        "UOM Caption": Label 'UOM';
        "Unit Price Caption": Label 'Unit Price (Rs.)';
        "Total Amount Caption": Label 'Total Amount';
        "TAX INVOICE": Label 'TAX INVOICE';
        TT01: Label 'Under Rule (46) of GST Invoice Rule';
        "GSTIN NO caption": Label 'GSTIN No';
        t01: Label 'AN ISO 9001-2008 COMPANY';
        Email: Label 'EMAIL';
        WEBSITE: Label 'WEBSITE';
        NoOfCopies: Integer;
        NoOfLoops: Integer;
        Cust: Record Customer;
        CopyText: Text[30];
        OutputNo: Integer;
        Text003: Label 'COPY';
        "PIN caption": Label 'PIN:';
        LocRec: Record Location;
        StateRec: Record State;
        LocStateCode: Text[2];
        LocGSTCode: Text[15];
        CusRec: Record Customer;
        CusStateCode: Text;
        CusGST: Text;
        CusPAN: Text;
        ShipRec: Record "222";
        ShipToGST: Text;
        shipGSTCode: Text;
        ShipPAN: Text;
        SrNo: Integer;
        "Less Discount Caption": Label 'Less: Discount Amount ';
        "Net Amount Caption": Label 'Net Amount';
        "Packing & Forwarding Caption": Label 'Packing & Forwarding';
        "Freight Charge Caption": Label 'Freight Charge';
        "Insurance Charges Caption": Label 'Insurance Charges';
        "Taxable Amount Caption": Label 'Taxable Amount';
        "Total Invoice Value (Rs.) Caption": Label 'Total Invoice Value (Rs.)';
        "Electronic Referance No: Capption": Label 'Electronic Referance No: ';
        "Invoice Remarks Caption": Label 'Invoice Remarks:';
        "Total Invoice Value Caption": Label 'Total Invoice Value (In Words):-';
        SrNo_ForAllLines: Integer;
        BankRec: Record "270";
        IFSCCode: Text;
        BankAcc: Text;
        BankName: Text;
        BankAdd: Text;
        GstRec: Record "GST Ledger Entry";
        "our bank caption": Label 'Our Bank';
        "Bank Account No Caption": Label 'Bank Acc No';
        "ifsc code caption": Label 'IFSC Code';
        "Branch Address caption": Label 'Branch Address';
        "total GST Caption": Label 'Total GST Value (In Words):-';
        t02: Label 'Amount of Subject to Reverse Charge';
        "Special Caption": Label 'Special Instruction:';
        s01: Label 'Incase  of Export:-  (Direct Export & SEZ Sale)';
        s02: Label 'Supplyment:-  For Export Under Bond or Letter of Undertaking Without Payment of Duty';
        s03: Label 'Supplyment For Export on Payment of Integrated Tax(IGST)';
        s04: Label 'Certified that the particulars given above are true & correct and the amount indicated represents the price actually charged and that there is no flow of any additional consideration directly or indirectly from buyer. Duty has been shown in all assessment.';
        "E. & O.E. Caption": Label 'E. & O.E.';
        e01: Label 'All disputes subject to Delhi jurisdiction';
        e02: Label 'Please make payment within 7 days of presentation of bill otherwise interest @18% p.a. will be charged for delayed period.';
        e03: Label 'For TPS Infrastructure Limited';
        e04: Label 'Authorised Signature';
        L01: Label 'LR/GR NO';
        L02: Label 'LR/GR DT';
        L03: Label 'Package Nos';
        L04: Label 'Freight Value';
        L05: Label 'S.O Date';
        "website value": Label 'WWW.TPSMFG.COM';
        "Last Caption": Label 'Regd. Office: 84, M-Block, Commercial Complex, Greater Kailash-II New Delhi- 110048 India Tel. 011-29214007, 29212101  Fax- 011-29216856';
        TextConst1: Label 'Special instruction:-';
        igst: Decimal;
        cgst: Decimal;
        sgst: Decimal;
        GSTAmt: Decimal;
        //PostStrOrdLineDet: Record "13798";
        FreightCharges: Decimal;
        OtherCharges: Decimal;
        PackingCharges: Decimal;
        InsCharges: Decimal;
        check1: Report 50101;
        numtext1: array[2] of Text;
        gstwords: Decimal;
        numtext2: array[2] of Text;
        BankCity: Text;
        Export: Boolean;
        TotAmt: Decimal;
        Print: Text;
        print1: Text;
        print2: Text;
        Special: Text;
        TextConst2: Label 'Incase of Export-';
        TextVar: Text;
        TextVar1: Text;
        T_44: Record "Sales Comment Line";
        TotalTCSAmt: Decimal;
        Texxt: Text[5];
        CGSTText: Text;
        SGSTText: Text;
        IGSTText: Text;
        StateDescription: Text[52];
        ReverseCharge_TextVar: Text[5];
        Salesline_Description: Text;
        RecShipment: Record Vendor;
        AgentDes: Text;
        RecDetaileGSTLedgerEntry: Record "Detailed GST Ledger Entry";
        CGST11: Decimal;
        IGST11: Decimal;
        SGST11: Decimal;
        SIL: Record "Sales Invoice Line";
        RoundOffAmt: Decimal;
        ShiptoName: Text;
        ShiptoName2: Text;
        ShipToAdd: Text;
        ShipToAdd2: Text;
        ShipToCity: Text;
        ShiptoCode: Code[20];
        CountryName: Text;
        StateName: Text;
        Cust1: Record Customer;
        State1: Record State;
        countrReg: Record "Country/Region";
        ShiptoCountry: Text;
        ShiptoState: Text;
        T222: Record "Ship-to Address";
        TimeofSupply: Time;
        TotalLine: Integer;
        LineCounter: Integer;
        LineAmount: Decimal;
        SalesInvoiceLine: Record "Sales Invoice Line";
        Amt: Decimal;
        ReportCaption: Text;
        State_rec: Record State;
        T_14: Record Location;
        LocationName: Code[50];
        T_9: Record State;
        LocationName1: Code[50];
        PrintGSTTerm: Boolean;
        GSTInfo1: Text[100];
        GSTInfo2: Text[100];
        GSTInfo3: Text[100];
        GSTInfo4: Text[100];
        PrintComments: Text;
        Generalledger: Record "98";
        TCS: Decimal;
        RecTCS: Record "TCS Entry";
        TCSINF: Text[250];
        Fssi: Text;
        ShipStateName: Text;
        CustStateName: Text;
        Type_of_Sale: Text;
        Sale: Boolean;
        GST_RATE_VALUE: Decimal;
        TCSENtry: Record "TCS Entry";
        TCSAmt1: Decimal;
        FLAg: Boolean;
        PlaceofSupply_SalesInvoiceHeader: Text;
        CGST111: Decimal;
        SGST111: Decimal;
        IGST111: Decimal;

}

