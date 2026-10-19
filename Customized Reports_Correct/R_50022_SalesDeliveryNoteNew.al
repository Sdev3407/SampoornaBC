report 50022 "Sales Delivery Note New"
{
    UsageCategory = Administration;
    Caption = 'Sales Delivery Note New Report';
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'ReportLayout\SalesDeliveryNoteNew.rdl';


    dataset
    {
        dataitem("Sales Shipment Header"; "Sales Shipment Header")
        {
            column(External_Doc; "Sales Shipment Header"."External Document No.")
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
            column(No_SalesShipmentHeader; "Sales Shipment Header"."No.")
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
            dataitem(PageLoop; 2000000026)
            {
                DataItemTableView = SORTING(Number)
                                    WHERE(Number = CONST(1));
                column(AmounttoCustomer_SalesShipmentHeader; "Party Name Caption")
                {
                }
                column(amount1; amount1)
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
                column(Conditions; TermsConditionRec.Conditions)
                {
                }
                column(Company_Name; CompanyInfo.Name)
                {
                }
                column(Company_Email; CompanyInfo."E-Mail")
                {
                }

                column(Company_CIN_No; Company_CIN_No)
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
                column(GSTCustomerType_SalesShipmentHeader; "Sales Shipment Header"."GST Customer Type")
                {
                }
                column(Transport_Method_salesheader; "Sales Shipment Header"."Shipment Method Code")
                {
                }
                column(Place_of_Supply_salesline; FORMAT("Sales Shipment Header"."Ship-to City") + ' ' + FORMAT(StateDescription))
                {
                }
                column(Vehicle_no_salesheader; "Sales Shipment Header"."Vehicle No.")
                {
                }
                column(Ext_Doc_No_salesheader; "Sales Shipment Header"."External Document No.")
                {
                }
                column(Job_No_Salesheader; "Sales Shipment Header"."P.A.N. No.")
                {
                }
                column(Trans_Code_Salesheader; AgentDes)
                {
                }
                column(No_SalesHeader; "Sales Shipment Header"."No.")
                {
                }
                column(Doc_Date_SalesHeader; "Sales Shipment Header"."Order Date")
                {
                }
                column(Bill_to_name_Salesheader; "Sales Shipment Header"."Bill-to Name")
                {
                }
                column(Bill_to_name2_Salesheader; "Sales Shipment Header"."Bill-to Name 2")
                {
                }
                column(Bill_to_Add_salesHeader; "Sales Shipment Header"."Bill-to Address")
                {
                }
                column(Bill_to_AddII_salesHeader; "Sales Shipment Header"."Bill-to Address 2")
                {
                }
                column(Bill_to_city_SalesHeader; "Sales Shipment Header"."Bill-to City")
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
                column(bill_to_Post_code; "Sales Shipment Header"."Bill-to Post Code")
                {
                }
                column(Time_of_Removal; "Sales Shipment Header"."Time of Removal")
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
                column(Tax_Invoice_Caption; "TAX INVOICE")
                {
                }
                column(State_Salesheader; LocStateCode)
                {
                }
                column(t01; t01)
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
                column(Freight; freightAmount)
                {
                }
                column(StateName; StateName)
                {
                }
                dataitem("Sales Shipment Line"; "Sales Shipment Line")
                {
                    DataItemLink = "Document No." = FIELD("No.");
                    DataItemLinkReference = "Sales Shipment Header";
                    DataItemTableView = SORTING("Document No.", "Line No.")
                                        WHERE("No." = FILTER(<> 423730));
                    column(Alt_Qty; "Sales Shipment Line"."Alternate Quantity")
                    {
                    }
                    column(Alt_UOM; "Sales Shipment Line"."Alternate UOM")
                    {
                    }
                    column(DocumentNo_SIl; "Sales Shipment Line"."Document No.")
                    {
                    }
                    // column(GST_RATE_VALUE; "Sales Shipment Line"."GST %") {} //PRU SH
                    column(GST_RATE_VALUE; GST_RATE_VALUE) { }

                    column(LineAmount; LineAmount)
                    {
                    }
                    column(SalesShipmentLineCrossReferenceNo; "Sales Shipment Line"."Line No.")
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
                    column(No_salesline; "Sales Shipment Line"."No.")
                    {
                    }
                    column(Salesline_UOM; "Sales Shipment Line"."Unit of Measure Code")
                    {
                    }
                    column(TotalTCSAmt1; "Address Caption")
                    {
                    }
                    column(TotalTCSAmt; TotalTCSAmt)
                    {
                    }
                    column(TDSTCSAmount_SalesShipmentLine; "Address Caption")
                    {
                    }
                    column(TCSNatureofCollection_SalesShipmentLine; "Address Caption")
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
                    column(Posting_Date; "Sales Shipment Header"."Posting Date")
                    {
                    }
                    column(Package_No; "Description Caption")
                    {
                    }
                    column(LR_RRno; "Sales Shipment Header"."LR/RR No.")
                    {
                    }
                    column(LR_RR_Date; "Sales Shipment Header"."LR/RR Date")
                    {
                    }
                    column(TDS_Percent; "Address Caption")
                    {
                    }
                    column(amount_to_customer; "Address Caption")
                    {
                    }
                    column(Line_Discount_percent; "Address Caption")
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
                    column(Salesline_HSN_Code; "Sales Shipment Line"."HSN/SAC Code")
                    {
                    }
                    //column(Salesline_Unit_Price; "Sales Shipment Line"."MRP Price"){}   //PRU SH
                    column(Salesline_Unit_Price; Salesline_Unit_Price) { }

                    column(Salesline_Total_Amount; "Address Caption")
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
                    column(Salesline_Quantity; "Sales Shipment Line".Quantity)
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
                        SerialNo += 1;
                        //>>PRU_RPG  28-Aug-2017
                        LineCounter += 1;
                        LineAmount := ("Sales Shipment Line"."Unit Price" * "Sales Shipment Line".Quantity);
                        IF ("Sales Shipment Line".Description <> '') THEN
                            IF ("Sales Shipment Line"."Item Reference No." <> '') THEN
                                Salesline_Description := FORMAT("Sales Shipment Line".Description) + ',' + FORMAT("Sales Shipment Line"."Item Reference No.")
                            //Salesline_Description := FORMAT("Sales Shipment line".Description)+', Cross-Ref No '+FORMAT("Sales Shipment line"."Item Reference No.")
                            ELSE
                                Salesline_Description := FORMAT("Sales Shipment Line".Description)
                        ELSE
                            IF ("Sales Shipment Line"."Item Reference No." <> '') THEN
                                //Salesline_Description := 'Cross-Ref No '+FORMAT("Sales Shipment line"."Item Reference No.")
                                Salesline_Description := FORMAT("Sales Shipment Line"."Item Reference No.")
                            ELSE
                                Salesline_Description := '';
                        //<<PRU_RPG  28-Aug-2017

                        IF ("Sales Shipment Line"."No." <> '') AND ("Sales Shipment Line"."HSN/SAC Code" <> '') THEN
                            SrNo := SrNo + 1;
                        SrNo_ForAllLines += 1;
                        //MESSAGE('%1',"Sales Shipment line"."Unit of Measure");
                        //PRU_RPG  GSTAmt:=GSTAmt+"Sales Shipment line"."Total GST Amount";
                        /*
                        IF  "Sales Shipment line"."GST Jurisdiction Type"="Sales Shipment line"."GST Jurisdiction Type"::Interstate THEN BEGIN
                         //PRU_RPG  igst := ROUND(GSTAmt,1,'=');
                          IF IGST11<>0 THEN
                            igst +=  ROUND(IGST11,1,'=');
                          END;
                        IF (igst <> 0) THEN
                            IGSTText := STRSUBSTNO('IGST %1 %',ROUND("Sales Shipment line"."GST %",0.01,'='))
                          ELSE
                            IGSTText := 'IGST %';
                        
                        IF "Sales Shipment line"."GST Jurisdiction Type"="Sales Shipment line"."GST Jurisdiction Type"::Intrastate THEN BEGIN
                         //PRU_RPG cgst:=ROUND(GSTAmt/2,1,'=');
                         //PRU_RPG sgst:=ROUND(GSTAmt/2,1,'=');
                         IF CGST11<>0 THEN
                          cgst+=ROUND(CGST11/2,1,'=');
                         IF SGST11<>0 THEN
                          sgst+=ROUND(SGST11/2,1,'=');
                        END;
                        IF (cgst <> 0) THEN
                            CGSTText := STRSUBSTNO('CGST %1 %',ROUND("Sales Shipment line"."GST %"/2,0.01,'='))
                        ELSE
                          CGSTText := 'CGST %';
                        
                        IF (sgst <> 0) THEN
                            SGSTText := STRSUBSTNO('SGST %1 %',ROUND("Sales Shipment line"."GST %"/2,0.01,'='))
                        ELSE
                          SGSTText := 'SGST %';
                        */

                        /*   //PRU SH 01082022
                        PackingCharges := 0;
                        InsCharges := 0;
                        FreightCharges := 0;
                        PostStrOrdLineDet.RESET;
                        PostStrOrdLineDet.SETCURRENTKEY(Type, "Document Type", "Invoice No.", "Tax/Charge Type", "Tax/Charge Group");
                        PostStrOrdLineDet.SETRANGE(Type, PostStrOrdLineDet.Type::Sale);
                        PostStrOrdLineDet.SETRANGE("Document Type", PostStrOrdLineDet."Document Type"::Invoice);
                        PostStrOrdLineDet.SETRANGE("Invoice No.", "Sales Shipment Line"."Document No.");
                        PostStrOrdLineDet.SETRANGE("Tax/Charge Type", PostStrOrdLineDet."Tax/Charge Type"::Charges);
                        PostStrOrdLineDet.SETRANGE("Item No.", "Sales Shipment Line"."No.");
                        PostStrOrdLineDet.SETRANGE(PostStrOrdLineDet."Line No.", "Sales Shipment Line"."Line No.");
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
*/   //PRU SH 01082022


                        //>>PRU_RPG  30-Aug-2017
                        CLEAR(CGST11);
                        CLEAR(SGST11);
                        CLEAR(IGST11);
                        RecDetaileGSTLedgerEntry.RESET;
                        RecDetaileGSTLedgerEntry.SETRANGE("Document No.", "Document No.");
                        RecDetaileGSTLedgerEntry.SETRANGE("No.", "No.");
                        RecDetaileGSTLedgerEntry.SETRANGE(RecDetaileGSTLedgerEntry."Posting Date", "Sales Shipment Line"."Posting Date");
                        RecDetaileGSTLedgerEntry.SETRANGE("Document Line No.", "Sales Shipment Line"."Line No.");
                        IF RecDetaileGSTLedgerEntry.FINDFIRST THEN
                            REPEAT
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
                        //"Sales Shipment Header".CALCFIELDS("Amount to Customer");
                        //TotAmt:=ROUND("Sales Shipment Header"."Amount to Customer",1,'=');
                        check1.InitTextVariable;
                        check1.FormatNoText(numtext2, TotAmt, '');
                        //TotalTCSAmt:=TotalTCSAmt+"Sales Shipment line"."TDS/TCS Amount"; //PRU-AM 1.0

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
            }

            trigger OnAfterGetRecord()
            begin
                GateEntryLine.RESET;
                GateEntryLine.SETRANGE("Entry Type", GateEntryLine."Entry Type"::Outward);
                GateEntryLine.SETRANGE("Source Type", GateEntryLine."Source Type"::"Sales Shipment");
                GateEntryLine.SETRANGE("Source No.", "Sales Shipment Header"."No.");
                IF GateEntryLine.FINDFIRST THEN
                    SourceNo := GateEntryLine."Gate Entry No.";

                GateEntryHeader.RESET;
                GateEntryHeader.SETRANGE("No.", SourceNo);
                IF GateEntryHeader.FINDFIRST THEN
                    freightAmount := GateEntryHeader."Total Freight Amount";

                LocRec.RESET;
                LocRec.SETRANGE(Code, "Sales Shipment Header"."Location Code");
                IF LocRec.FINDFIRST THEN BEGIN
                    NameLoc := 'E-mail:' + LocRec."E-Mail" + ' Website :' + LocRec."Home Page";
                    AddLoc := LocRec.Address + ' ' + LocRec."Address 2";
                    gstLoc := LocRec."GST Registration No.";
                END;
                CLEAR(amount1);
                SalesShipmentLine1.RESET;
                SalesShipmentLine1.SETRANGE("Document No.", "Sales Shipment Header"."No.");
                IF SalesShipmentLine1.FINDFIRST THEN
                    REPEAT
                    // amount1 += SalesShipmentLine1."MRP Price" * SalesShipmentLine1.Quantity; //PRU SH
                    UNTIL SalesShipmentLine1.NEXT = 0;

                GSTAmt := 0;
                IF TermsConditionRec.GET("Sales Shipment Header"."Terms Code") THEN

                    /*
                    IF "Sales Shipment Header"."GST Customer Type"= "Sales Shipment Header"."GST Customer Type"::Export THEN BEGIN
                      Special := "Special Caption";
                       Print := s01 ;
                       print1 :=  s02 ;
                       print2  := s03 ;
                       tr
                    END;
                    */
                CLEAR(Texxt);
                IF ("Sales Shipment Header"."GST Customer Type" = "Sales Shipment Header"."GST Customer Type"::Unregistered) THEN
                    Texxt := 'YES'
                ELSE
                    Texxt := 'No';
                CLEAR(Print);
                CLEAR(Special);

                Export := FALSE;
                IF "Sales Shipment Header"."GST Customer Type" = "Sales Shipment Header"."GST Customer Type"::Export THEN BEGIN
                    Export := TRUE;
                    T_44.RESET;
                    T_44.SETRANGE(T_44."Document Type", T_44."Document Type"::"Posted Invoice");
                    T_44.SETRANGE(T_44."No.", "Sales Shipment Header"."No.");
                    IF T_44.FINDLAST THEN
                        Print := T_44.Comment;
                    Special := TextConst2;
                END;

                RecShipment.RESET;
                RecShipment.SETRANGE("No.", "Sales Shipment Header"."Transporter Code");
                RecShipment.SETFILTER(Transporter, 'True');
                IF RecShipment.FINDFIRST THEN
                    AgentDes := RecShipment.Name;


                SIL.RESET;
                SIL.SETRANGE("Document No.", "No.");
                SIL.SETRANGE(SIL.Type, SIL.Type::"G/L Account");
                SIL.SETRANGE("No.", '423730');
                IF SIL.FINDFIRST THEN
                    RoundOffAmt := SIL."Line Amount";


                IF Cust1.GET("Sales Shipment Header"."Bill-to Customer No.") THEN BEGIN
                    IF Cust1."Country/Region Code" <> '' THEN
                        countrReg.GET(Cust1."Country/Region Code");
                    mobileno := Cust1."Phone No.";

                    IF Cust1."State Code" <> '' THEN
                        State1.GET(Cust1."State Code");
                    CountryName := countrReg.Name;
                    StateName := State1.Description;

                END;

                ShiptoAddRec.RESET;
                ShiptoAddRec.SETRANGE(Code, "Sales Shipment Header"."Ship-to Code");
                ShiptoAddRec.SETRANGE("Customer No.", "Sales Shipment Header"."Sell-to Customer No.");
                IF ShiptoAddRec.FINDFIRST THEN
                    mobileno2 := ShiptoAddRec."Phone No.";

                IF "Sales Shipment Header"."Ship-to Code" = '' THEN BEGIN
                    ShiptoName := "Sales Shipment Header"."Bill-to Name";
                    ShiptoName2 := "Sales Shipment Header"."Bill-to Name 2";
                    ShipToAdd := "Sales Shipment Header"."Bill-to Address";
                    ShipToAdd2 := "Sales Shipment Header"."Bill-to Address 2";
                    ShipToCity := "Sales Shipment Header"."Bill-to City";
                    ShiptoCode := "Sales Shipment Header"."Bill-to Post Code";
                    ShiptoState := StateName;
                    ShiptoCountry := CountryName;
                    ShiptoPhone := mobileno;
                END ELSE BEGIN
                    ShiptoName := "Sales Shipment Header"."Ship-to Name";
                    ShiptoName2 := "Sales Shipment Header"."Ship-to Name 2";
                    ShipToAdd := "Sales Shipment Header"."Ship-to Address";
                    ShipToAdd2 := "Sales Shipment Header"."Ship-to Address 2";
                    ShipToCity := "Sales Shipment Header"."Ship-to City";
                    ShiptoCode := "Sales Shipment Header"."Ship-to Post Code";

                    ShiptoPhone := mobileno2;
                END;
                IF T222.GET("Sales Shipment Header"."Bill-to Customer No.", "Sales Shipment Header"."Ship-to Code") THEN BEGIN
                    IF T222."Country/Region Code" <> '' THEN
                        countrReg.GET(T222."Country/Region Code");
                    IF T222.State <> '' THEN
                        State1.GET(T222.State);
                    ShiptoCountry := countrReg.Name;
                    ShiptoState := State1.Description;
                END;
                //ShiptoState := StateName;
                //ShiptoCountry := CountryName;
                ///END;
                /*IF "Sales Shipment Header"."Time of Supply" = 0T THEN
                  TimeofSupply := "Sales Shipment Header"."Time of Removal"
                ELSE
                  TimeofSupply := "Sales Shipment Header"."Time of Supply";
                */
                SalesShipmentLine.RESET;
                SalesShipmentLine.SETRANGE("Document No.", "No.");
                IF SalesShipmentLine.FINDFIRST THEN
                    REPEAT
                        gstwords += SalesShipmentLine.Amount;//"Total GST Amount";
                    UNTIL SalesShipmentLine.NEXT = 0;
                check1.InitTextVariable;
                check1.FormatNoText(numtext1, gstwords, '');

            end;

            trigger OnPreDataItem()
            begin
                CompanyInfo.GET;
                CompanyInfo.CALCFIELDS(CompanyInfo.Picture);
                ReverseCharge_TextVar := 'yes';
                mobileno := '';
                mobileno2 := '';
                ShiptoPhone := '';
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

    var
        Company_CIN_No: Code[20];
        SalesShipmentLine1: Record 111;
        amount1: Decimal;
        freightAmount: Decimal;
        GateEntryLine: Record "Gate Entry Line";
        GateEntryHeader: Record "Gate Entry Header";
        SourceNo: Code[20];
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
        // PostStrOrdLineDet: Record 13798;
        FreightCharges: Decimal;
        OtherCharges: Decimal;
        PackingCharges: Decimal;
        InsCharges: Decimal;
        check1: Report 50006;
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
        SalesShipmentLine: Record 113;
        Amt: Decimal;
        GST_RATE_VALUE: Decimal;
        Salesline_Unit_Price: Decimal;
}

