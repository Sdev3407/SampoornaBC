report 50016 "Credit Note"
{
    UsageCategory = Administration;
    Caption = 'Credit Note Report';
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'ReportLayout\CreditNote.rdl';
    dataset
    {
        dataitem("Sales Cr.Memo Header"; "Sales Cr.Memo Header")
        {
            CalcFields = "Amount";
            column(E_Invoice_QR_Code; "E-Invoice QR Code")
            { }
            column(gstLoc; gstLoc)
            {
            }
            column(AuthoSig; AuthoSig)
            { }
            column(TermCondition; TermCondition)
            { }
            column(AddLoc; AddLoc)
            {
            }
            column(NameLoc; NameLoc)
            {
            }
            column(ExternalDocNo; "Sales Cr.Memo Header"."External Document No.")
            {
            }
            column(SerialNo; SerialNo)
            {
            }
            column(mobileno; mobileno)
            {
            }
            column(Line_Discount; LineDiscount)
            {
            }
            column(ShiptoPhone; ShiptoPhone)
            {
            }
            column(Comment1; Comment1)
            {
            }
            column(Comment2; Comment2)
            {
            }
            column(Comment3; Comment3)
            {
            }
            column(TCSAmount; TCSAmt1)
            {
            }
            column(AmounttoVendor_SalesInvoiceHeader; "Sales Cr.Memo Header".Amount + gstwords + TCSAmt1) { }
            dataitem(CopyLoop; 2000000026)
            {
                DataItemTableView = SORTING(Number);
                dataitem(PageLoop; 2000000026)
                {
                    DataItemTableView = SORTING(Number)
                                        WHERE(Number = CONST(1));
                    //PRU SH
                    //   column(AmounttoVendor_SalesInvoiceHeader; AmounttoVendor_SalesInvoiceHeader) { }

                    column(OutputNo; OutputNo)
                    {
                    }
                    column(CopyText; CopyText)
                    {
                    }
                    column(Company_Name; CompanyInfo.Name)
                    {
                    }
                    column(Company_Email; CompanyInfo."E-Mail")
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
                    column(Company_Ship_To_City; CompanyInfo.City)
                    {
                    }
                    column(Company_Ship_To_PostCode; CompanyInfo."Ship-to Post Code")
                    {
                    }

                    column(Company_CIN; CompanyInfo."SFPL_C.I.N No.")
                    {
                    }

                    column(company_Picture; CompanyInfo.Picture)
                    {
                    }
                    column(Report_Caption; ReportCaption)
                    {
                    }
                    column(text_under_Tax_Invoice; TT01)
                    {
                    }
                    column(T0002; T0002)
                    {
                    }
                    column(T0003; T0003)
                    {
                    }
                    column(No_PurchCrMemo; "Sales Cr.Memo Header"."No.")
                    {
                    }
                    column(DocDate_PurchCrMemo; FORMAT("Sales Cr.Memo Header"."Document Date"))
                    {
                    }
                    column(BuyFromVendorName_PurchCrMemo; "Sales Cr.Memo Header"."Bill-to Name")
                    {
                    }
                    column(BuyFromAdd_PurchCrMemo; "Sales Cr.Memo Header"."Bill-to Address")
                    {
                    }
                    column(BuyFromAdd2_PurchCrMemo; "Sales Cr.Memo Header"."Bill-to Address 2")
                    {
                    }
                    column(BuyFromCity_PurchCrMemo; "Sales Cr.Memo Header"."Bill-to City")
                    {
                    }
                    column(CountryName; CountryName)
                    {
                    }
                    column(StateName; StateName)
                    {
                    }
                    column(PIN_caption; "PIN caption")
                    {
                    }
                    column(BuyFromPostCode_PurchCrMemo; "Sales Cr.Memo Header"."Bill-to Post Code")
                    {
                    }
                    column(CusStateCode; CusStateCode)
                    {
                    }
                    column(CusGST; CusGST)
                    {
                    }
                    column(CusPAN; CusPAN)
                    {
                    }
                    column(Ship_To_name_PurchCrMemo; ShiptoName)
                    {
                    }
                    column(ShiptoName2_PurchCrMemo; ShiptoName2)
                    {
                    }
                    column(Ship_To_Add_PurchCrMemo; ShipToAdd)
                    {
                    }
                    column(Ship_To_AddII_PurchCrMemo; ShipToAdd2)
                    {
                    }
                    column(Ship_To_City_PurchCrMemo; ShipToCity)
                    {
                    }
                    column(Ship_to_post_code_PurchCrMemo; ShiptoCode)
                    {
                    }
                    column(ShiptoState; ShiptoState)
                    {
                    }
                    column(ShiptoCountry; ShiptoCountry)
                    {
                    }
                    column(shipGSTCode; shipGSTCode)
                    {
                    }
                    column(ShipToGST; ShipToGST)
                    {
                    }
                    column(Invoice_No_Caption; "Invoice No Caption")
                    {
                    }
                    column(Invoice_Date_Caption; "Invoice Date Caption")
                    {
                    }
                    column(Against_Invoice_No_Caption; "Against Invoice No Caption")
                    {
                    }
                    column(Ext_Doc_Caption; "Ext Doc Caption")
                    {
                    }
                    column(Details_of_reciever; T0002)
                    {
                    }
                    column(Details_of_consignee; T0003)
                    {
                    }
                    column(Against_Inv_No_Caption; "Against Inv No")
                    {
                    }
                    column(Against_Inv_Date_Caption; "Against Inv Date")
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
                    column(PAN_Caption; "PAN Caption")
                    {
                    }
                    column(Mobile_No_Caption; "Mobile No Caption")
                    {
                    }
                    column(RoundOffAmt; RoundOffAmt)
                    {
                    }
                    column(total_GST_Caption; "total GST Caption")
                    {
                    }
                    column(Conditions; TermsConditionRec.Conditions)
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
                    dataitem("Sales Cr.Memo Line"; "Sales Cr.Memo Line")
                    {
                        DataItemLink = "Document No." = FIELD("No.");
                        DataItemLinkReference = "Sales Cr.Memo Header";
                        DataItemTableView = SORTING("Document No.", "Line No.")
                                            WHERE("No." = FILTER(<> ''), "No." = filter(<> '1301390|301850'), Quantity = filter(<> 0));
                        column(Posting_Date; FORMAT("Sales Cr.Memo Header"."Posting Date"))
                        {
                        }
                        column(Against_Inv_No_PurchCrMemo; "Sales Cr.Memo Header"."Applies-to Doc. No.")
                        {
                        }
                        column(AgainstInvoiceDate_PurchCrMemo; FORMAT(AgainstInvoiceDate))
                        {
                        }
                        column(S_No_Caption; "S.No Captiion")
                        {
                        }
                        column(Item_Code_Caption; "Item Code Caption")
                        {
                        }
                        column(Description_Caption; "Description Caption")
                        {
                        }
                        column(GST_Caption; "GST Caption")
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
                        column(Alt_Qty_Caption; "Alt Qty Caption")
                        {
                        }
                        column(Unit_Price_Caption; "Unit Price Caption")
                        {
                        }
                        column(Total_Amount_Caption; "Total Amount Caption")
                        {
                        }
                        column(No_PurchCRMemoLine; "Sales Cr.Memo Line"."No.")
                        {
                        }
                        column(Desc_PurchCRMemoLine; "Sales Cr.Memo Line".Description)
                        {
                        }
                        // column(GST_RATE_VALUE_PurchCRMemoLine; "Sales Cr.Memo Line"."GST %") {}    //PRU SH
                        column(GST_RATE_VALUE_PurchCRMemoLine; GST_RATE_VALUE_PurchCRMemoLine) { }

                        column(HSNCode_PurchCRMemoLine; "Sales Cr.Memo Line"."HSN/SAC Code")
                        {
                        }
                        column(Qty_PurchCRMemoLine; "Sales Cr.Memo Line".Quantity)
                        {
                        }
                        column(UOM_PurchCRMemoLine; "Sales Cr.Memo Line"."Unit of Measure Code")
                        {
                        }
                        column(AltQty_PurchCRMemoLine; "Sales Cr.Memo Line"."Alternate Quantity")
                        {
                        }
                        column(UnitPrice_PurchCRMemoLine; "Sales Cr.Memo Line"."Unit Price")
                        {
                        }
                        column(LineAmount_PurchCRMemoLine; "Sales Cr.Memo Line"."Line Amount")
                        {
                        }
                        column(sgst; sgst)
                        {
                        }
                        column(cgst; cgst)
                        {
                        }
                        column(igst; igst)
                        {
                        }

                        column(Total_Invoice_Value; "Total Invoice Value (Rs.) Caption")
                        {
                        }
                        column(invoice_words_caption; "Total Invoice Value Caption")
                        {
                        }
                        column(invoice_words2; numtext2[1])
                        {
                        }
                        column(gstwords; numtext1[1])
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            SerialNo += 1;
                            LineCounter += 1;

                            CLEAR(CGST11);
                            CLEAR(SGST11);
                            CLEAR(IGST11);
                            CLEAR(igst);
                            CLEAR(cgst);
                            CLEAR(sgst);

                            IF ("Sales Cr.Memo Line".Type = "Sales Cr.Memo Line".Type::"G/L Account") AND ("Sales Cr.Memo Line"."No." = '135100') THEN
                                CurrReport.SKIP;


                            Clear(GST_RATE_VALUE_PurchCRMemoLine);
                            RecDetaileGSTLedgerEntry.RESET;
                            RecDetaileGSTLedgerEntry.SETRANGE("Document No.", "Document No.");
                            //    RecDetaileGSTLedgerEntry.SETRANGE("No.", "No.");
                            //  RecDetaileGSTLedgerEntry.SETRANGE(RecDetaileGSTLedgerEntry."Posting Date", "Sales Invoice Line"."Posting Date");
                            RecDetaileGSTLedgerEntry.SETRANGE("Document Line No.", "Sales Cr.Memo Line"."Line No.");
                            IF RecDetaileGSTLedgerEntry.FINDFIRST THEN
                                REPEAT
                                    GST_RATE_VALUE_PurchCRMemoLine += RecDetaileGSTLedgerEntry."GST %";
                                until RecDetaileGSTLedgerEntry.Next() = 0;

                            RecDetaileGSTLedgerEntry.RESET;
                            RecDetaileGSTLedgerEntry.SETRANGE("Document No.", "Document No.");
                            //RecDetaileGSTLedgerEntry.SETRANGE("No.","No.");
                            RecDetaileGSTLedgerEntry.SETRANGE(RecDetaileGSTLedgerEntry."Posting Date", "Sales Cr.Memo Line"."Posting Date");
                            RecDetaileGSTLedgerEntry.SETRANGE("Document Line No.", "Sales Cr.Memo Line"."Line No.");
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


                            //TotalTCSAmt:=TotalTCSAmt+"Sales Cr.Memo Header"."TDS/TCS Amount"; //PRU-AM 1.0

                            //GK03062021-
                            CLEAR(TCSAmount);
                            TCSEntry.RESET;
                            TCSEntry.SETRANGE("Document No.", "Document No.");
                            IF TCSEntry.FINDFIRST THEN
                                TCSAmount := ABS(TCSEntry."TCS Amount Including Surcharge");

                            CompanyInfo.Get;
                            AuthoSig := CompanyInfo.Name;
                            If CompanyInfo.SFPLCompany in [CompanyInfo.SFPLCompany::"Star Foods"] then
                                TermCondition := 'All disputes are subject to Punjab jurisdiction.'
                            else
                                TermCondition := 'All disputes are subject to Phagwara jurisdiction.'

                        end;

                        trigger OnPreDataItem()
                        begin

                            SerialNo := 0;
                            CLEAR(igst);
                            CLEAR(cgst);
                            CLEAR(sgst);
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
                            Integer.SETRANGE(Number, 1, (10 - "Sales Cr.Memo Line".COUNT)); //Pru Gulshan
                        end;
                    }
                }

                trigger OnAfterGetRecord()
                begin

                    IF Number > 1 THEN BEGIN
                        CopyText := Text003;
                        OutputNo += 1;
                    END;
                    //MESSAGE('%1',CopyText);

                    VenRec.RESET;
                    VenRec.SETRANGE("No.", "Sales Cr.Memo Header"."Bill-to Customer No.");
                    IF VenRec.FINDFIRST THEN BEGIN
                        CusGST := VenRec."GST Registration No.";
                        CusPAN := VenRec."P.A.N. No.";
                        IF (VenRec."GST Customer Type" = VenRec."GST Customer Type"::Unregistered) THEN
                            ReverseCharge_TextVar := 'Yes'
                        ELSE
                            ReverseCharge_TextVar := 'No';
                    END;

                    StateRec.RESET;
                    StateRec.SETRANGE(Code, VenRec."State Code");
                    IF StateRec.FINDFIRST THEN BEGIN
                        CusStateCode := StateRec."State Code (GST Reg. No.)";
                        ShipPAN := VenRec."P.A.N. No.";
                    END;

                    IF "Sales Cr.Memo Header"."Ship-to Code" <> '' THEN BEGIN
                        ShipRec.RESET;
                        ShipRec.SETRANGE("Customer No.", "Sales Cr.Memo Header"."Sell-to Customer No.");
                        ShipRec.SETRANGE(Code, "Sales Cr.Memo Header"."Ship-to Code");
                        IF ShipRec.FINDFIRST THEN BEGIN
                            ShipToGST := ShipRec."GST Registration No.";
                            StateRec.RESET;
                            StateRec.SETRANGE(Code, ShipRec.State);
                            IF StateRec.FINDFIRST THEN
                                shipGSTCode := StateRec."State Code (GST Reg. No.)";
                        END;
                    END;
                    //MESSAGE(shipGSTCode);
                    IF "Sales Cr.Memo Header"."Ship-to Code" = '' THEN BEGIN
                        ShipToGST := CusGST;
                        ShipPAN := CusPAN;
                        shipGSTCode := CusStateCode;
                    END;
                    /*
                   BankRec.RESET;
                   BankRec.SETRANGE( "No.","Sales Cr.Memo Header"."Bank Account No.");
                   IF BankRec.FINDFIRST THEN BEGIN
                     BankAcc:= BankRec."Bank Account No.";
                     BankName:= BankRec.Name;
                     IFSCCode:= BankRec."IFSC Code";
                     BankAdd:= BankRec.Address+','+BankRec."Address 2";
                     BankCity:= BankRec.City;
                     END;
                   */

                end;

                trigger OnPreDataItem()
                begin

                    NoOfLoops := ABS(NoOfCopies) + 1;
                    IF NoOfLoops <= 0 THEN
                        NoOfLoops := 1;
                    CopyText := 'Original';
                    SETRANGE(Number, 1, NoOfLoops);
                    OutputNo := 1;
                end;
            }

            trigger OnAfterGetRecord()
            var
                IGST111: Decimal;
                CGST111: Decimal;
                SGST111: Decimal;
            begin

                LocRec.RESET;
                LocRec.SETRANGE(Code, "Sales Cr.Memo Header"."Location Code");
                IF LocRec.FINDFIRST THEN BEGIN
                    NameLoc := 'E-mail:' + LocRec."E-Mail" + ' Website :' + LocRec."Home Page";
                    AddLoc := LocRec.Address + ' ' + LocRec."Address 2";
                    gstLoc := LocRec."GST Registration No.";
                END;

                CustLedgerEntry.RESET;
                CustLedgerEntry.SETRANGE("Document No.", "Applies-to Doc. No.");
                IF CustLedgerEntry.FINDFIRST THEN
                    AgainstInvoiceDate := CustLedgerEntry."Posting Date";

                IF Customer.GET("Sales Cr.Memo Header"."Bill-to Customer No.") THEN BEGIN
                    IF Customer."Country/Region Code" <> '' THEN
                        countrReg.GET(Customer."Country/Region Code");
                    mobileno := Customer."Phone No.";
                    IF Customer."State Code" <> '' THEN
                        State1.GET(Customer."State Code");
                    CountryName := countrReg.Name;
                    StateName := State1.Description;
                END;
                ShiptoAddRec.RESET;
                ShiptoAddRec.SETRANGE(Code, "Sales Cr.Memo Header"."Ship-to Code");
                IF ShiptoAddRec.FINDFIRST THEN
                    mobileno2 := ShiptoAddRec."Phone No.";

                IF "Sales Cr.Memo Header"."Ship-to Code" = '' THEN BEGIN
                    ShiptoName := "Sales Cr.Memo Header"."Bill-to Name";
                    ShiptoName2 := "Sales Cr.Memo Header"."Bill-to Name 2";
                    ShipToAdd := "Sales Cr.Memo Header"."Bill-to Address";
                    ShipToAdd2 := "Sales Cr.Memo Header"."Bill-to Address 2";
                    ShipToCity := "Sales Cr.Memo Header"."Bill-to City";
                    ShiptoCode := "Sales Cr.Memo Header"."Bill-to Post Code";
                    ShiptoState := StateName;
                    ShiptoCountry := CountryName;
                    ShiptoPhone := mobileno;
                END ELSE BEGIN
                    ShiptoAddRec.RESET;
                    ShiptoAddRec.SETRANGE("Customer No.", "Sales Cr.Memo Header"."Sell-to Customer No.");
                    ShiptoAddRec.SETRANGE(Code, "Sales Cr.Memo Header"."Ship-to Code");
                    IF ShiptoAddRec.FINDFIRST THEN
                        ShiptoName := ShiptoAddRec.Name;
                    ShiptoName2 := ShiptoAddRec."Name 2";
                    ShipToAdd := ShiptoAddRec.Address;
                    ShipToAdd2 := ShiptoAddRec."Address 2";
                    ShipToCity := ShiptoAddRec.City;
                    ShiptoCode := ShiptoAddRec."Post Code";
                    ShiptoPhone := mobileno2;
                    //ShiptoState:= ShiptoAddRec.State

                    IF T222.GET("Sales Cr.Memo Header"."Bill-to Customer No.", "Sales Cr.Memo Header"."Ship-to Code") THEN BEGIN
                        IF T222."Country/Region Code" <> '' THEN
                            countrReg.GET(T222."Country/Region Code");
                        IF T222.State <> '' THEN
                            State1.GET(T222.State);
                        ShiptoCountry := countrReg.Name;
                        ShiptoState := State1.Description;
                    END;
                END;


                PCML.RESET;
                PCML.SETRANGE("Document No.", "No.");
                PCML.SETRANGE(PCML.Type, PCML.Type::"G/L Account");
                PCML.SETRANGE("No.", '1301390');
                IF PCML.FINDFIRST THEN
                    RoundOffAmt := PCML."Line Amount";

                CLEAR(LineDiscount);
                clear(gstwords);

                PurchCrMemoLine.RESET;
                PurchCrMemoLine.SETRANGE("Document No.", "No.");
                IF PurchCrMemoLine.FINDFIRST THEN
                    REPEAT
                        clear(CGST111);
                        clear(IGST111);
                        clear(SGST111);
                        RecDetaileGSTLedgerEntry.RESET;
                        RecDetaileGSTLedgerEntry.SETRANGE("Document No.", "No.");
                        //RecDetaileGSTLedgerEntry.SETRANGE("No.","No.");
                        //  RecDetaileGSTLedgerEntry.SETRANGE(RecDetaileGSTLedgerEntry."Posting Date", PurchCrMemoLine."Posting Date");
                        RecDetaileGSTLedgerEntry.SETRANGE("Document Line No.", PurchCrMemoLine."Line No.");
                        IF RecDetaileGSTLedgerEntry.FINDFIRST THEN
                            REPEAT
                                IF RecDetaileGSTLedgerEntry."GST Component Code" = 'CGST' THEN BEGIN
                                    CGST111 += ABS(RecDetaileGSTLedgerEntry."GST Amount");
                                    //cgst := CGST11;
                                    //CGSTText := STRSUBSTNO('CGST %1 %', ROUND(RecDetaileGSTLedgerEntry."GST %", 0.01, '='))
                                END;
                                IF RecDetaileGSTLedgerEntry."GST Component Code" = 'SGST' THEN BEGIN
                                    SGST111 += ABS(RecDetaileGSTLedgerEntry."GST Amount");
                                    // sgst := SGST11;
                                    //SGSTText := STRSUBSTNO('SGST %1 %', ROUND(RecDetaileGSTLedgerEntry."GST %", 0.01, '='))
                                END;
                                IF RecDetaileGSTLedgerEntry."GST Component Code" = 'IGST' THEN BEGIN
                                    IGST111 += ABS(RecDetaileGSTLedgerEntry."GST Amount");
                                    //igst := IGST11;
                                    // IGSTText := STRSUBSTNO('IGST %1 %', ROUND(RecDetaileGSTLedgerEntry."GST %", 0.01, '='))
                                END;

                            UNTIL RecDetaileGSTLedgerEntry.NEXT = 0;
                        //<<PRU_RPG 20-Aug-2017
                        gstwords += IGST111 + SGST111 + CGST111;
                        //      Message('%1', gstwords);
                        LineDiscount += PurchCrMemoLine."Line Discount Amount";
                    UNTIL PurchCrMemoLine.NEXT = 0;
                TCSAmt1 := 0;

                TCSENtry.Reset();
                TCSENtry.SetRange("Document No.", "Sales Cr.Memo Header"."No.");
                if TCSENtry.FindFirst() then
                    repeat
                        TCSAmt1 += ABS(TCSENtry."TCS Amount");
                    until TCSENtry.Next() = 0;
                "Sales Cr.Memo Header".CALCFIELDS("Amount");
                TotAmt := "Sales Cr.Memo Header"."Amount";

                check1.InitTextVariable;
                check1.FormatNoText1(numtext2, TotAmt + gstwords + TCSAmt1, '');

                check1.InitTextVariable;
                check1.FormatNoText1(numtext1, gstwords, '');

                IF TermsConditionRec.GET("Sales Cr.Memo Header"."Terms Code") THEN;

                //-->3 Comments
                SalesCommentLine.RESET;
                SalesCommentLine.SETRANGE("Document Type", SalesCommentLine."Document Type"::"Posted Credit Memo");
                SalesCommentLine.SETRANGE("No.", "Sales Cr.Memo Header"."No.");
                IF SalesCommentLine.FINDFIRST THEN
                    REPEAT
                        IF SalesCommentLine.Comment <> '' THEN BEGIN
                            IF SalesCommentLine."Line No." = 10000 THEN
                                Comment1 := SalesCommentLine.Comment;
                            IF SalesCommentLine."Line No." = 20000 THEN
                                Comment2 := SalesCommentLine.Comment;
                            IF SalesCommentLine."Line No." = 30000 THEN
                                Comment3 := SalesCommentLine.Comment;
                        END;
                    UNTIL SalesCommentLine.NEXT = 0;
                //<--3 Comments
            end;

            trigger OnPreDataItem()
            begin
                CompanyInfo.GET;
                CompanyInfo.CALCFIELDS(CompanyInfo.Picture);
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
                        ApplicationArea = all;
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
        FLAg := true;
        "Sales Cr.Memo Header".CalcFields("E-Invoice QR Code");
    end;

    var
        Company_CIN_No: Code[20];
        CompanyInfo: Record 79;
        ReportCaption: Label 'Credit Note';
        TT01: Label 'Under Rule (46) of GST Invoice Rule';
        NameLoc: Text;
        gstLoc: Text;
        AddLoc: Text;
        LocRec: Record 14;
        NoOfCopies: Integer;
        NoOfLoops: Integer;
        CopyText: Text[30];
        OutputNo: Integer;
        Text003: Label 'COPY';
        "Invoice No Caption": Label 'Credit Note No.';
        "Invoice Date Caption": Label 'Credit Note Date';
        T0002: Label 'Details of Reciever(Billed to)';
        "Ext Doc Caption": Label 'External Doc. No.';
        "Against Invoice No Caption": Label 'Against Invoice No Caption';
        "Party Name Caption": Label 'Party Name';
        "Address Caption": Label 'Address';
        "State Code Caption": Label 'State Code :';
        "GSTIN Rec Caption": Label 'GSTIN/Unique ID';
        "PAN Caption": Label 'PAN NO';
        "Mobile No Caption": Label 'Mobile No.';
        T0003: Label 'Details of Consignee(Shipped to)';
        "Against Inv No": Label 'Against Invoice No';
        "Against Inv Date": Label 'Against Invoice Date';
        CustLedgerEntry: Record 21;
        AgainstInvoiceDate: Date;
        Customer: Record 18;
        countrReg: Record 9;
        mobileno: Text;
        State1: Record State;
        CountryName: Text;
        StateName: Text;
        "PIN caption": Label 'PIN:';
        CusStateCode: Text;
        StateRec: Record state;
        VenRec: Record 18;
        ShipPAN: Text;
        CusGST: Text;
        CusPAN: Text;
        ReverseCharge_TextVar: Text[5];
        ShiptoName: Text;
        ShiptoName2: Text;
        ShipToAdd: Text;
        ShipToAdd2: Text;
        ShipToCity: Text;
        ShiptoCode: Code[20];
        ShiptoAddRec: Record 222;
        mobileno2: Text;
        ShiptoState: Text;
        ShiptoCountry: Text;
        ShiptoPhone: Text;
        T222: Record 222;
        ShipRec: Record 222;
        ShipToGST: Text;
        shipGSTCode: Text;
        "S.No Captiion": Label 'S. No';
        "Item Code Caption": Label 'Item Code';
        "Description Caption": Label 'Description';
        "GST Caption": Label 'GST %';
        "HSN Code Caption": Label 'HSN Code';
        "Quantity Caption": Label 'Qty.';
        "UOM Caption": Label 'UOM';
        "Alt Qty Caption": Label 'Alt Qty.';
        "Unit Price Caption": Label 'Unit Price (Rs.)';
        "Total Amount Caption": Label 'Total Amount';
        SerialNo: Integer;
        igst: Decimal;
        cgst: Decimal;
        sgst: Decimal;
        CGST11: Decimal;
        IGST11: Decimal;
        SGST11: Decimal;
        RecDetaileGSTLedgerEntry: Record "Detailed GST Ledger Entry";//16419;
        CGSTText: Text;
        SGSTText: Text;
        IGSTText: Text;
        RoundOffAmt: Decimal;
        PCML: Record 115;
        LineDiscount: Decimal;
        PurchCrMemoLine: Record 115;
        gstwords: Decimal;
        check1: Report 50101;
        numtext1: array[2] of Text;
        "Total Invoice Value (Rs.) Caption": Label 'Total Invoice Value (Rs.)';
        "Total Invoice Value Caption": Label 'Total Invoice Value (In Words):-';
        numtext2: array[2] of Text;
        TotAmt: Decimal;
        TotalTCSAmt: Integer;
        "total GST Caption": Label 'Total GST Value (In Words):-';
        TermsConditionRec: Record 50010;
        TotalLine: Integer;
        LineCounter: Integer;
        "our bank caption": Label 'Our Bank';
        "Bank Account No Caption": Label 'Bank Account No';
        "ifsc code caption": Label 'IFSC Code';
        "Branch Address caption": Label 'Branch Address';
        BankRec: Record 270;
        IFSCCode: Text;
        BankAcc: Text;
        BankName: Text;
        BankAdd: Text;
        SalesCommentLine: Record 44;
        Comment1: Text;
        Comment2: Text;
        Comment3: Text;
        TCSEntry: Record "TCS Entry";//16514;
        TCSAmount: Decimal;
        TCSAmt1: Decimal;
        AmounttoVendor_SalesInvoiceHeader: Decimal;
        GST_RATE_VALUE_PurchCRMemoLine: Decimal;
        FLAg: Boolean;
        AuthoSig: text;
        TermCondition: Text;
}

