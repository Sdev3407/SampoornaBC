report 50001 "Sales Invoice New-GST"
{
    UsageCategory = Administration;
    Caption = 'Sales Invoice New GST Report';
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'ReportLayout\SalesInvoiceNewGST.rdl';

    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            CalcFields = "Amount";
            RequestFilterFields = "Sell-to Customer No.", "Posting Date";
            column(PaymentQRCode_SalesInvoiceHeader; "Sales Invoice Header"."Payment QR Code")
            {
            }
            column(QRCode; "Sales Invoice Header"."E-Invoice QR Code")
            {
            }
            column(EInvoiceNo_SalesInvoiceHeader; "Sales Invoice Header"."E-Invoice No.")
            {
            }
            column(VUserID; VUserID)
            { }
            column(VPrintdateTime; VPrintdateTime)
            { }
            column(TcsInf; TcsInf)
            {
            }
            column(Term1; Term1)
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
            column(AmounttoCustomer_SalesInvoiceHeader; TCS + "Sales Invoice Header"."Amount" + CGST111 + SGST111 + IGST111)
            {
            }
            dataitem(CopyLoop; 2000000026)
            {
                DataItemTableView = SORTING(Number);
                dataitem(PageLoop; 2000000026)
                {
                    DataItemTableView = SORTING(Number)
                                        WHERE(Number = CONST(1));

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
                    column(Conditions; TermsConditionRec.Conditions)
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
                    column(Trans_Code_Salesheader; "Sales Invoice Header"."Transporter Name")
                    {
                    }
                    column(No_SalesHeader; "Sales Invoice Header"."No.")
                    {
                    }
                    column(Doc_Date_SalesHeader; "Sales Invoice Header"."Order Date")
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
                    column(Exemp; Exemp)
                    {

                    }
                    column(State_Salesheader; LocStateCode)
                    {
                    }
                    column(t01; t01)
                    {
                    }
                    /* Rep
                    column(company_CIN; CompanyInfo."C.I.N No.")
                    {
                    }
                    */  // PRU SH
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
                    column(Freight; "Sales Invoice Header".Freight)
                    {
                    }
                    column(StateName; StateName)
                    {
                    }
                    column(ShipStateName; ShipStateName)
                    {
                    }
                    column(CustStateName; CustStateName)
                    {
                    }
                    dataitem("Sales Invoice Line"; "Sales Invoice Line")
                    {
                        DataItemLink = "Document No." = FIELD("No.");
                        DataItemLinkReference = "Sales Invoice Header";
                        DataItemTableView = SORTING("Document No.", "Line No.")
                                            WHERE("No." = FILTER(<> 1301390),
                                                  Type = FILTER(<> ' '),
                                                  Quantity = FILTER(<> 0));
                        column(Alt_Qty; "Sales Invoice Line"."Alternate Quantity")
                        {
                        }
                        column(Alt_UOM; "Sales Invoice Line"."Alternate UOM")
                        {
                        }
                        column(DocumentNo_SIl; "Sales Invoice Line"."Document No.")
                        {
                        }
                        /*  //PRU SH
                                                column(GST_RATE_VALUE; "Sales Invoice Line"."GST %")
                                                {
                                                }
                                                */  //PRU SH
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
                        /*   //PRU SH
                        column(TotalTCSAmt1; "Sales Invoice Line"."TDS/TCS Amount")
                        {
                        }
                        
                        column(TDSTCSAmount_SalesInvoiceLine; "Sales Invoice Line"."TDS/TCS Amount")
                        {
                        }
                        */   //PRU SH
                        column(TotalTCSAmt1; TotalTCSAmt1)
                        {
                        }

                        column(TDSTCSAmount_SalesInvoiceLine; TDSTCSAmount_SalesInvoiceLine)
                        {
                        }

                        column(TotalTCSAmt; TotalTCSAmt)
                        {
                        }
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
                        /*   //PRU SH
                        column(TDS_Percent; "Sales Invoice Line"."TDS/TCS %")
                        {
                        }
                        */   //PRU SH
                        column(TDS_Percent; TDS_Percent)
                        {
                        }
                        column(amount_to_customer; ROUND("Sales Invoice Line"."Amount", 1, '='))
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
                        column(TCS; TCS)
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
                        var
                            TCSENtry: Record "TCS Entry";

                        begin
                            IF COPYSTR("Sales Invoice Line".Description, 1, 11) = 'Shipment No' THEN BEGIN
                                CurrReport.SKIP;
                            END;
                            SerialNo += 1;
                            //>>PRU_RPG  28-Aug-2017
                            LineCounter += 1;
                            LineAmount := ("Sales Invoice Line"."Unit Price" * "Sales Invoice Line".Quantity);
                            IF ("Sales Invoice Line".Description <> '') THEN
                                IF ("Sales Invoice Line"."Item Reference No." <> '') THEN
                                    Salesline_Description := FORMAT("Sales Invoice Line".Description) + ',' + FORMAT("Sales Invoice Line"."Item Reference No.")
                                //Salesline_Description := FORMAT("Sales Invoice Line".Description)+', Cross-Ref No '+FORMAT("Sales Invoice Line"."Item Reference No.")
                                ELSE
                                    Salesline_Description := FORMAT("Sales Invoice Line".Description)
                            ELSE
                                IF ("Sales Invoice Line"."Item Reference No." <> '') THEN
                                    //Salesline_Description := 'Cross-Ref No '+FORMAT("Sales Invoice Line"."Item Reference No.")
                                    Salesline_Description := FORMAT("Sales Invoice Line"."Item Reference No.")
                                ELSE
                                    Salesline_Description := '';
                            //<<PRU_RPG  28-Aug-2017


                            IF ("Sales Invoice Line"."No." <> '') AND ("Sales Invoice Line"."HSN/SAC Code" <> '') AND ("Sales Invoice Line".Quantity <> 0) THEN
                                SrNo := SrNo + 1;
                            SrNo_ForAllLines += 1;
                            //MESSAGE('%1',"Sales Invoice Line"."Unit of Measure");
                            //PRU_RPG  GSTAmt:=GSTAmt+"Sales Invoice Line"."Total GST Amount";
                            /*
                            IF  "Sales Invoice Line"."GST Jurisdiction Type"="Sales Invoice Line"."GST Jurisdiction Type"::Interstate THEN BEGIN
                             //PRU_RPG  igst := ROUND(GSTAmt,1,'=');
                              IF IGST11<>0 THEN
                                igst +=  ROUND(IGST11,1,'=');
                              END;
                            IF (igst <> 0) THEN
                                IGSTText := STRSUBSTNO('IGST %1 %',ROUND("Sales Invoice Line"."GST %",0.01,'='))
                              ELSE
                                IGSTText := 'IGST %';
                            
                            IF "Sales Invoice Line"."GST Jurisdiction Type"="Sales Invoice Line"."GST Jurisdiction Type"::Intrastate THEN BEGIN
                             //PRU_RPG cgst:=ROUND(GSTAmt/2,1,'=');
                             //PRU_RPG sgst:=ROUND(GSTAmt/2,1,'=');
                             IF CGST11<>0 THEN
                              cgst+=ROUND(CGST11/2,1,'=');
                             IF SGST11<>0 THEN
                              sgst+=ROUND(SGST11/2,1,'=');
                            END;
                            IF (cgst <> 0) THEN
                                CGSTText := STRSUBSTNO('CGST %1 %',ROUND("Sales Invoice Line"."GST %"/2,0.01,'='))
                            ELSE
                              CGSTText := 'CGST %';
                            
                            IF (sgst <> 0) THEN
                                SGSTText := STRSUBSTNO('SGST %1 %',ROUND("Sales Invoice Line"."GST %"/2,0.01,'='))
                            ELSE
                              SGSTText := 'SGST %';
                            */


                            /*  //PRU SH 01082022
                            PackingCharges := 0;
                            InsCharges := 0;
                            FreightCharges := 0;
                            PostStrOrdLineDet.RESET;
                            PostStrOrdLineDet.SETCURRENTKEY(Type, "Document Type", "Invoice No.", "Tax/Charge Type", "Tax/Charge Group");
                            PostStrOrdLineDet.SETRANGE(Type, PostStrOrdLineDet.Type::Sale);
                            PostStrOrdLineDet.SETRANGE("Document Type", PostStrOrdLineDet."Document Type"::Invoice);
                            PostStrOrdLineDet.SETRANGE("Invoice No.", "Sales Invoice Line"."Document No.");
                            PostStrOrdLineDet.SETRANGE("Tax/Charge Type", PostStrOrdLineDet."Tax/Charge Type"::Charges);
                            PostStrOrdLineDet.SETRANGE("Item No.", "Sales Invoice Line"."No.");
                            PostStrOrdLineDet.SETRANGE(PostStrOrdLineDet."Line No.", "Sales Invoice Line"."Line No.");
                            PostStrOrdLineDet.SETFILTER("Tax/Charge Group", '%1|%2|%3|%4|%5', 'FREIGHT', 'PACKING', 'Handling', 'OTHERS', 'INSURANCE');
                            IF PostStrOrdLineDet.FINDFIRST THEN BEGIN
                                REPEAT

                                    IF PostStrOrdLineDet."Tax/Charge Group" = 'FREIGHT' THEN
                                        FreightCharges := PostStrOrdLineDet.Amount;

                                    IF PostStrOrdLineDet."Tax/Charge Group" = 'OTHERS' THEN
                                        OtherCharges := PostStrOrdLineDet.Amount;

                                    IF PostStrOrdLineDet."Tax/Charge Group" = 'PACKING' THEN
                                        //message('%1|%2' ,PostStrOrdLineDet."Invoice No.",PostStrOrdLineDet.Amount);
                                        PackingCharges := PostStrOrdLineDet.Amount;

                                    IF PostStrOrdLineDet."Tax/Charge Group" = 'INSURANCE' THEN
                                        InsCharges := PostStrOrdLineDet.Amount;

                                UNTIL PostStrOrdLineDet.NEXT = 0;
                            END;

                            */  //PRU SH 01082022


                            //>>PRU_RPG  30-Aug-2017
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
                            RecDetaileGSTLedgerEntry.SETRANGE("Document Line No.", "Sales Invoice Line"."Line No.");
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



                            //<<PRU_RPG 20-Aug-2017

                            //Close By gulshan

                            /*
                             IF (igst <> 0) THEN
                              gstwords += igst//,1,'=')
                            ELSE
                              gstwords += cgst+sgst;
                              */
                            TCSAmt1 := 0;
                            if FLAg = true then begin
                                TCSENtry.Reset();
                                TCSENtry.SetRange("Document No.", "Sales Invoice Line"."Document No.");
                                if TCSENtry.FindFirst() then
                                    TCSAmt1 := TCSENtry."TCS Amount";
                                FLAg := false;
                            end;
                            "Sales Invoice Header".CALCFIELDS(Amount);//"Amount to Customer");
                            TotAmt := ROUND(TCSAmt1 + "Sales Invoice Header"."Amount" + CGST11 + SGST11 + IGST11, 1, '=');

                            //    TotalTCSAmt := TotalTCSAmt + "Sales Invoice Line".TCs; //PRU-AM 1.0   //PRU SH 01082022

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
                            TotalLine := 8;
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
                        if "Sales Invoice Header"."Bank Account No." = 'BANK-006' Then Begin
                            if "Sales Invoice Header"."Shortcut Dimension 1 Code" = 'FEED' then
                                BankAcc := 'SFFD01' + '' + "Sales Invoice Header"."Bill-to Customer No.";
                            if "Sales Invoice Header"."Shortcut Dimension 1 Code" = 'CATTLE' then
                                BankAcc := 'SFCT01' + '' + "Sales Invoice Header"."Bill-to Customer No.";
                            if "Sales Invoice Header"."Shortcut Dimension 1 Code" = 'BREEDER' then
                                BankAcc := 'SFBR01' + '' + "Sales Invoice Header"."Bill-to Customer No.";
                            if "Sales Invoice Header"."Shortcut Dimension 1 Code" = 'HATCH' then
                                BankAcc := 'SFHT01' + '' + "Sales Invoice Header"."Bill-to Customer No.";
                            if "Sales Invoice Header"."Shortcut Dimension 1 Code" = 'CBF' then
                                BankAcc := 'SFCB01' + '' + "Sales Invoice Header"."Bill-to Customer No.";
                            if "Sales Invoice Header"."Shortcut Dimension 1 Code" = 'SWINE' then
                                BankAcc := 'SFSW01' + '' + "Sales Invoice Header"."Bill-to Customer No.";
                        End Else
                            BankAcc := BankRec."Bank Account No.";
                        //BankAcc := BankRec."Bank Account No.";
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
                        StateRec.SETRANGE(Code, LocRec."State Code");
                        IF StateRec.FINDFIRST THEN BEGIN
                            LocStateCode := StateRec."State Code (GST Reg. No.)";
                        END;
                    END;
                    CusRec.RESET;
                    CusRec.SETRANGE("No.", "Sales Invoice Header"."Bill-to Customer No.");
                    IF CusRec.FINDFIRST THEN BEGIN
                        CusGST := CusRec."GST Registration No.";
                        CusPAN := CusRec."P.A.N. No.";
                        IF (CusRec."GST Customer Type" = CusRec."GST Customer Type"::Unregistered) THEN
                            ReverseCharge_TextVar := 'Yes'
                        ELSE
                            ReverseCharge_TextVar := 'No';

                        //PRU_RPG CusStateCode := CusRec."State Code" ;

                        StateRec.RESET;
                        StateRec.SETRANGE(Code, CusRec."State Code");
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
                            StateRec.SETRANGE(Code, ShipRec.State);
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
                        StateRec.SETRANGE(Code, "Sales Invoice Header"."GST Ship-to State Code");
                        IF StateRec.FINDFIRST THEN
                            StateDescription := '- ' + StateRec.Description;
                    END ELSE BEGIN
                        CLEAR(StateDescription);
                        StateRec.RESET;
                        StateRec.SETRANGE(Code, "Sales Invoice Header"."GST Bill-to State Code");
                        IF StateRec.FINDFIRST THEN
                            StateDescription := '- ' + StateRec.Description;
                    END;

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
            var

            begin



                IF ("Sales Invoice Header"."Posting Date" > 20200930D) AND ("Sales Invoice Header"."Posting Date" <= 20210331D) THEN
                    TcsInf := 'With effect from 01-Oct-2020, Finance Act 2020 introduced Sec 206C (1H), which requires seller to collect tax at source (TCS) on sale of goods when consideration exceeds Rs. 50 lacs during the Financial year  2020-21 at 0.075%'
                ELSE
                    TcsInf := '';

                IF ("Sales Invoice Header"."Posting Date" > 20210630D) AND ("Sales Invoice Header"."Posting Date" <= 20260401D) THEN
                    Term1 := '* Statutory provision U/S 194Q and 206AB|206CCA applicable.';
                IF ("Sales Invoice Header"."Posting Date" >= 20260401D) then
                    Term1 := '* Statutory provisions of Section 393(1) & Other TDS sections will be applicable.';
                //Pru_gk
                GateEntryLine.RESET;
                GateEntryLine.SETRANGE("Entry Type", GateEntryLine."Entry Type"::Outward);
                GateEntryLine.SETRANGE("Source Type", GateEntryLine."Source Type"::"Sales Shipment");
                GateEntryLine.SETRANGE("Source No.", "Sales Invoice Header"."No.");
                IF GateEntryLine.FINDFIRST THEN
                    SourceNo := GateEntryLine."Gate Entry No.";

                GateEntryHeader.RESET;
                GateEntryHeader.SETRANGE("No.", SourceNo);
                IF GateEntryHeader.FINDFIRST THEN
                    freightAmount := GateEntryHeader."Total Freight Amount";

                Exemp := False;

                IF "Sales Invoice Header"."Invoice Type" = "Sales Invoice Header"."Invoice Type"::"Bill of Supply" THEN begin
                    ReportCaption := 'BILL OF SUPPLY';
                    Exemp := True;
                end ELSE
                    IF "Sales Invoice Header"."Invoice Type" = "Sales Invoice Header"."Invoice Type"::"Debit Note" THEN
                        ReportCaption := 'DEBIT NOTE'
                    ELSE
                        IF "Sales Invoice Header"."Invoice Type" = "Sales Invoice Header"."Invoice Type"::Supplementary THEN
                            ReportCaption := 'SUPPLEMENTARY INVOICE'

                        ELSE
                            ReportCaption := 'TAX INVOICE';

                LocRec.RESET;
                LocRec.SETRANGE(Code, "Sales Invoice Header"."Location Code");
                IF LocRec.FINDSET THEN BEGIN
                    if CompanyInfo.SFPLCompany in [CompanyInfo.SFPLCompany::Sampoorna] Then
                        NameLoc := 'E-mail: ' + 'customercare@sampoornafeeds.com' + ' Website:' + 'sampoornafeeds.com';
                    if CompanyInfo.SFPLCompany in [CompanyInfo.SFPLCompany::Vetadd] Then
                        NameLoc := 'E-mail: ' + CompanyInfo."E-Mail";
                    AddLoc := LocRec.Address + ' ' + LocRec."Address 2";
                    gstLoc := LocRec."GST Registration No.";
                END;


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
                SIL.SETRANGE("No.", '1301390');
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

                IF "Sales Invoice Header"."Ship-to Name" = '' THEN BEGIN
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
                RecTCS.SETRANGE("Document No.", "No.");
                IF RecTCS.FINDFIRST THEN
                    repeat
                        TCS += ABS(RecTCS."TCS Amount");
                    until RecTCS.Next() = 0;
                CLEAR(LineDiscount);
                Clear(CGST111);
                Clear(SGST111);
                Clear(IGST111);
                SalesInvoiceLine.RESET;
                SalesInvoiceLine.SETRANGE("Document No.", "No.");
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

                check1.InitTextVariable;
                check1.FormatNoText1(numtext2, TCS + "Sales Invoice Header".Amount + IGST111 + CGST111 + SGST111, '');
                check1.InitTextVariable;
                check1.FormatNoText1(numtext1, CGST111 + SGST111 + IGST111, '');

            end;

            trigger OnPreDataItem()
            begin

                CompanyInfo.GET;
                CompanyInfo.CALCFIELDS(CompanyInfo.Picture);
                ReverseCharge_TextVar := 'yes';
                "Sales Invoice Header".CALCFIELDS("Payment QR Code");
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
        PrintQr := 0;
        FLAg := true;

        if VUserID = '' then
            VUserID := UserId;
        if VPrintdateTime = 0DT then
            VPrintdateTime := CurrentDateTime;
    end;

    var

        CGST111: Decimal;
        SGST111: Decimal;
        IGST111: Decimal;
        FLAg: Boolean;
        Company_CIN_No: Code[20];
        LineDiscount: Decimal;
        freightAmount: Decimal;
        SourceNo: Code[20];
        GateEntryHeader: Record "Gate Entry Header";
        GateEntryLine: Record "Gate Entry Line";
        SerialNo: Integer;
        mobileno2: Text;
        ShiptoPhone: Text;
        ShiptoAddRec: Record 222;
        mobileno: Text;
        gstLoc: Text;
        AddLoc: Text;
        NameLoc: Text;
        TermsConditionRec: Record 50010;
        CompanyInfo: Record 79;

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
        Cust: Record 18;
        CopyText: Text[30];
        OutputNo: Integer;
        Text003: Label 'COPY';
        "PIN caption": Label 'PIN:';
        LocRec: Record 14;
        StateRec: Record State;
        LocStateCode: Text[2];
        LocGSTCode: Text[15];
        CusRec: Record 18;
        CusStateCode: Text;
        CusGST: Text;
        CusPAN: Text;
        ShipRec: Record 222;
        XX: Record 36;
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
        BankRec: Record 270;
        IFSCCode: Text;
        BankAcc: Text;
        BankName: Text;
        BankAdd: Text;
        GstRec: Record "Detailed GST Ledger Entry";//16419;
        "our bank caption": Label 'Our Bank';
        "Bank Account No Caption": Label 'Bank Account No';
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
        // PostStrOrdLineDet: Record 13798;  //PRU SH 01082022
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
        T_44: Record 44;
        TotalTCSAmt: Decimal;
        Texxt: Text[5];
        CGSTText: Text;
        SGSTText: Text;
        IGSTText: Text;
        StateDescription: Text[52];
        ReverseCharge_TextVar: Text[5];
        Salesline_Description: Text;
        RecShipment: Record 23;
        AgentDes: Text;
        RecDetaileGSTLedgerEntry: Record "Detailed GST Ledger Entry";//16419;
        CGST11: Decimal;
        IGST11: Decimal;
        SGST11: Decimal;
        SIL: Record 113;
        RoundOffAmt: Decimal;
        ShiptoName: Text;
        ShiptoName2: Text;
        ShipToAdd: Text;
        ShipToAdd2: Text;
        ShipToCity: Text;
        ShiptoCode: Code[20];
        CountryName: Text;
        StateName: Text;
        Cust1: Record 18;
        State1: Record State;
        countrReg: Record 9;
        ShiptoCountry: Text;
        ShiptoState: Text;
        T222: Record 222;
        TimeofSupply: Time;
        TotalLine: Integer;
        LineCounter: Integer;
        LineAmount: Decimal;
        SalesInvoiceLine: Record 113;
        Amt: Decimal;
        ReportCaption: Text;
        TCS: Decimal;
        RecTCS: Record "TCS Entry";//16514;
        TcsInf: Text[250];
        DetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry";//16419;
        Term1: Text;
        SMSfunctions: Codeunit 50018;
        PrintQr: Integer;
        ShipStateName: Text;
        CustStateName: Text;
        GST_RATE_VALUE: Decimal;
        TotalTCSAmt1: Decimal;
        TDSTCSAmount_SalesInvoiceLine: Decimal;
        TDS_Percent: Decimal;
        TCSAmt1: Decimal;
        Exemp: Boolean;
        VUserID: Text;
        VPrintdateTime: DateTime;

    procedure SetPrintIDandPrintTime(UserID: Text; PrintDateTime: DateTime)
    begin
        VUserID := UserID;
        VPrintdateTime := PrintDateTime;
    end;
}

