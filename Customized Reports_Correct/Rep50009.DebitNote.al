report 50009 "Debit Note"
{

    UsageCategory = Administration;
    Caption = 'Debit Note';
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'ReportLayout\DebitNote.rdl';
    dataset
    {
        dataitem("Purch. Cr. Memo Hdr."; "Purch. Cr. Memo Hdr.")
        {
            CalcFields = Amount;//"Amount to Vendor";

            column(QRCode; "Purch. Cr. Memo Hdr."."E-Invoice QR Code")
            {
            }
            column(EInvoiceNo; "Purch. Cr. Memo Hdr."."E-Invoice No.")
            {
            }

            column(AuthoSig; AuthoSig)
            { }
            column(TermCondition; TermCondition)
            { }
            column(gstLoc; gstLoc)
            {
            }
            column(AddLoc; AddLoc)
            {
            }
            column(NameLoc; NameLoc)
            {
            }
            column(ExternalDocNo; "Purch. Cr. Memo Hdr."."Vendor Cr. Memo No.")
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
            column(Comment1; Comment1)
            {
            }
            column(Comment2; Comment2)
            {
            }
            column(Comment3; Comment3)
            {
            }
            column(ShiptoPhone; ShiptoPhone)
            {
            }
            dataitem(CopyLoop; 2000000026)
            {
                DataItemTableView = SORTING(Number);
                dataitem(PageLoop; 2000000026)
                {
                    DataItemTableView = SORTING(Number)
                                        WHERE(Number = CONST(1));
                    column(AmounttoVendor_SalesInvoiceHeader; TotAmt1)//"Purch. Cr. Memo Hdr."."Amount to Vendor")
                    {
                    }
                    column(OutputNo; OutputNo)
                    {
                    }
                    column(CopyText; CopyText)
                    {
                    }

                    column(Company_Name; CompanyInfo."Name")
                    {
                    }
                    column(Company_Email; CompanyInfo."E-Mail")
                    {
                    }
                    column(Company_Ship_To_Address; CompanyInfo."Address")
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
                    column(Company_Ship_To_City; CompanyInfo."City")
                    {
                    }
                    column(Company_Ship_To_PostCode; CompanyInfo."Ship-to Post Code")
                    {
                    }
                    column(company_Picture; CompanyInfo."Picture")
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
                    column(No_PurchCrMemo; "Purch. Cr. Memo Hdr."."No.")
                    {
                    }
                    column(DocDate_PurchCrMemo; FORMAT("Purch. Cr. Memo Hdr."."Document Date"))
                    {
                    }
                    column(BuyFromVendorName_PurchCrMemo; "Purch. Cr. Memo Hdr."."Buy-from Vendor Name")
                    {
                    }
                    column(BuyFromAdd_PurchCrMemo; "Purch. Cr. Memo Hdr."."Buy-from Address")
                    {
                    }
                    column(BuyFromAdd2_PurchCrMemo; "Purch. Cr. Memo Hdr."."Buy-from Address 2")
                    {
                    }
                    column(BuyFromCity_PurchCrMemo; "Purch. Cr. Memo Hdr."."Buy-from City")
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
                    column(BuyFromPostCode_PurchCrMemo; "Purch. Cr. Memo Hdr."."Buy-from Post Code")
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
                    column(TCSAmt1; TCSAmt1)
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
                    column(LineNarration1_PurchCrMemoHdr; "Purch. Cr. Memo Hdr."."Line Narration1")
                    {
                    }
                    dataitem("Purch. Cr. Memo Line"; "Purch. Cr. Memo Line")
                    {
                        DataItemLink = "Document No." = FIELD("No.");
                        DataItemLinkReference = "Purch. Cr. Memo Hdr.";
                        DataItemTableView = SORTING("Document No.", "Line No.")
                                            WHERE(
                                                  Type = FILTER(<> ' '),
                                                  Quantity = FILTER(<> 0));
                        column(CrQty; "Purch. Cr. Memo Line".Quantity)
                        {
                        }
                        column(Posting_Date; "Purch. Cr. Memo Hdr."."Posting Date")
                        {
                        }
                        column(Against_Inv_No_PurchCrMemo; AgainstInvoiceNo)
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
                        column(No_PurchCRMemoLine; "Purch. Cr. Memo Line"."No.")
                        {
                        }
                        column(Desc_PurchCRMemoLine; "Purch. Cr. Memo Line".Description)
                        {
                        }
                        column(GST_RATE_VALUE_PurchCRMemoLine; GSTRateVale)//"GST %")
                        {
                        }
                        column(HSNCode_PurchCRMemoLine; "Purch. Cr. Memo Line"."HSN/SAC Code")
                        {
                        }
                        column(Qty_PurchCRMemoLine; "Purch. Cr. Memo Line".Quantity)
                        {
                        }
                        column(SumQty; SumQty)
                        {
                        }
                        column(SumTotal; SumTotal)
                        {
                        }
                        column(UOM_PurchCRMemoLine; "Purch. Cr. Memo Line"."Unit of Measure Code")
                        {
                        }
                        column(AltQty_PurchCRMemoLine; "Purch. Cr. Memo Line"."Alternate Quantity")
                        {
                        }
                        column(UnitPrice_PurchCRMemoLine; "Purch. Cr. Memo Line"."Direct Unit Cost")
                        {
                        }
                        column(LineAmount_PurchCRMemoLine; "Purch. Cr. Memo Line"."Line Amount")
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
                        column(LineNo_PurchCRMemoLine; "Purch. Cr. Memo Line"."Line No.")
                        {
                        }
                        column(DocNo_PurchCRMemoLine; "Purch. Cr. Memo Line"."Document No.")
                        {
                        }
                        dataitem("Purch. Comment Line"; "Purch. Comment Line")
                        {
                            DataItemLink = "No." = FIELD("Document No."),
                                           "Document Line No." = FIELD("Line No.");
                            DataItemTableView = SORTING("Document Type", "No.", "Document Line No.", "Line No.")
                                                WHERE("Document Type" = CONST("Posted Credit Memo"));
                            column(DocType_PuchCommentLine; "Purch. Comment Line"."Document Type")
                            {
                            }
                            column(No_PuchCommentLine; "Purch. Comment Line"."No.")
                            {
                            }
                            column(DocLineNo_PuchCommentLine; "Purch. Comment Line"."Document Line No.")
                            {
                            }
                            column(LineNo_PuchCommentLine; "Purch. Comment Line"."Line No.")
                            {
                            }
                            column(Comment_PuchCommentLine; "Purch. Comment Line"."Comment")
                            {
                            }
                        }

                        trigger OnAfterGetRecord()
                        Var
                            CompanyInfo1: Record "Company Information";
                        begin
                            SerialNo += 1;
                            LineCounter += 1;
                            if CompanyInfo1.SFPLCompany in [CompanyInfo1.SFPLCompany::Sampoorna] then
                                IF ("Purch. Cr. Memo Line".Type = "Purch. Cr. Memo Line".Type::"G/L Account") AND ("Purch. Cr. Memo Line"."No." = '1301390') THEN
                                    CurrReport.SKIP;
                            if CompanyInfo1.SFPLCompany in [CompanyInfo1.SFPLCompany::"Star Foods"] then
                                IF ("Purch. Cr. Memo Line".Type = "Purch. Cr. Memo Line".Type::"G/L Account") AND ("Purch. Cr. Memo Line"."No." = '301850') THEN
                                    CurrReport.SKIP;

                            Clear(GSTRateVale);
                            RecDetaileGSTLedgerEntry.RESET;
                            RecDetaileGSTLedgerEntry.SETRANGE("Document No.", "Document No.");
                            //    RecDetaileGSTLedgerEntry.SETRANGE("No.", "No.");
                            //  RecDetaileGSTLedgerEntry.SETRANGE(RecDetaileGSTLedgerEntry."Posting Date", "Sales Invoice Line"."Posting Date");
                            RecDetaileGSTLedgerEntry.SETRANGE("Document Line No.", "Purch. Cr. Memo Line"."Line No.");
                            IF RecDetaileGSTLedgerEntry.FINDFIRST THEN
                                REPEAT
                                    GSTRateVale += RecDetaileGSTLedgerEntry."GST %";
                                until RecDetaileGSTLedgerEntry.Next() = 0;

                            RecDetaileGSTLedgerEntry.RESET;
                            RecDetaileGSTLedgerEntry.SETRANGE("Document No.", "Document No.");
                            RecDetaileGSTLedgerEntry.SETRANGE(RecDetaileGSTLedgerEntry."Posting Date", "Purch. Cr. Memo Line"."Posting Date");
                            //RecDetaileGSTLedgerEntry.SETRANGE("Document Line No.","Purch. Cr. Memo Line"."Line No.");
                            RecDetaileGSTLedgerEntry.SETRANGE("GST Component Code", 'CGST');
                            IF RecDetaileGSTLedgerEntry.FINDSET THEN  //suman
                                REPEAT
                                    //IF RecDetaileGSTLedgerEntry."GST Component Code" = 'CGST' THEN BEGIN
                                    CGST11 := ABS(RecDetaileGSTLedgerEntry."GST Amount");
                                    cgst += CGST11;
                                    CGSTText := STRSUBSTNO('CGST %1 %', ROUND(RecDetaileGSTLedgerEntry."GST %", 0.01, '='))
                                //END;
                                UNTIL RecDetaileGSTLedgerEntry.NEXT = 0;

                            RecDetaileGSTLedgerEntry.RESET;
                            RecDetaileGSTLedgerEntry.SETRANGE("Document No.", "Document No.");
                            RecDetaileGSTLedgerEntry.SETRANGE(RecDetaileGSTLedgerEntry."Posting Date", "Purch. Cr. Memo Line"."Posting Date");
                            //RecDetaileGSTLedgerEntry.SETRANGE("Document Line No.","Purch. Cr. Memo Line"."Line No.");
                            RecDetaileGSTLedgerEntry.SETRANGE("GST Component Code", 'SGST');
                            IF RecDetaileGSTLedgerEntry.FINDSET THEN       // Suman
                                REPEAT
                                    //IF RecDetaileGSTLedgerEntry."GST Component Code" = 'SGST' THEN BEGIN
                                    SGST11 := ABS(RecDetaileGSTLedgerEntry."GST Amount");
                                    sgst += SGST11;
                                    SGSTText := STRSUBSTNO('SGST %1 %', ROUND(RecDetaileGSTLedgerEntry."GST %", 0.01, '='))
                                UNTIL RecDetaileGSTLedgerEntry.NEXT = 0;
                            RecDetaileGSTLedgerEntry.RESET;
                            RecDetaileGSTLedgerEntry.SETRANGE("Document No.", "Document No.");
                            RecDetaileGSTLedgerEntry.SETRANGE(RecDetaileGSTLedgerEntry."Posting Date", "Purch. Cr. Memo Line"."Posting Date");
                            //RecDetaileGSTLedgerEntry.SETRANGE("Document Line No.","Purch. Cr. Memo Line"."Line No.");
                            RecDetaileGSTLedgerEntry.SETRANGE("GST Component Code", 'IGST');
                            IF RecDetaileGSTLedgerEntry.FINDSET THEN
                                ///SUMAN
                                REPEAT
                                    IGST11 := ABS(RecDetaileGSTLedgerEntry."GST Amount");
                                    igst += IGST11;
                                    IGSTText := STRSUBSTNO('IGST %1 %', ROUND(RecDetaileGSTLedgerEntry."GST %", 0.01, '='))
                                //MESSAGE('%1',cgst);
                                UNTIL RecDetaileGSTLedgerEntry.NEXT = 0;
                            //MESSAGE('%1',cgst);
                            //<<PRU_RPG 20-Aug-2017
                            TCSAmt1 := 0;
                            if FLAg = true then begin
                                TCSENtry.Reset();
                                TCSENtry.SetRange("Document No.", "Purch. Cr. Memo Line"."Document No.");
                                if TCSENtry.FindFirst() then
                                    TCSAmt1 := Abs(TCSENtry."TDS Amount");
                                FLAg := false;
                            end;

                            if "Purch. Cr. Memo Line"."GST Reverse Charge" = true then begin

                                "Purch. Cr. Memo Hdr.".CALCFIELDS(Amount);//("Amount to Vendor");
                                TotAmt := ROUND("Purch. Cr. Memo Hdr.".Amount, 1, '=');
                                TotAmt1 := "Purch. Cr. Memo Hdr.".Amount + TCSAmt1;
                                check1.InitTextVariable;
                                check1.FormatNoText1(numtext2, TotAmt, "Purch. Cr. Memo Hdr."."Currency Code");
                            end else begin
                                "Purch. Cr. Memo Hdr.".CALCFIELDS(Amount);//("Amount to Vendor");
                                TotAmt := ROUND("Purch. Cr. Memo Hdr.".Amount + sgst + igst + cgst, 1, '=');
                                TotAmt1 := "Purch. Cr. Memo Hdr.".Amount + sgst + igst + cgst + TCSAmt1;
                                check1.InitTextVariable;
                                check1.FormatNoText1(numtext2, TotAmt, "Purch. Cr. Memo Hdr."."Currency Code");
                                //TotalTCSAmt:=TotalTCSAmt+"Purch. Cr. Memo Hdr."."TDS/TCS Amount"; //PRU-AM 1.0
                            END;
                            SumTotal := 0;
                            PurchCrMemoLine.RESET;
                            PurchCrMemoLine.SETRANGE("Document No.", "Purch. Cr. Memo Line"."Document No.");
                            PurchCrMemoLine.SETFILTER(PurchCrMemoLine."Gen. Prod. Posting Group", '<>%1', 'R-F');
                            IF PurchCrMemoLine.FINDFIRST THEN
                                REPEAT
                                    SumTotal += PurchCrMemoLine."Line Amount";
                                UNTIL PurchCrMemoLine.NEXT = 0;

                            SumQty += "Purch. Cr. Memo Line".Quantity;
                        end;

                        trigger OnPreDataItem()
                        begin
                            SerialNo := 0;
                            CLEAR(CGST11);
                            CLEAR(SGST11);
                            CLEAR(IGST11);
                            CLEAR(igst);
                            CLEAR(cgst);
                            CLEAR(sgst);
                            CLEAR(CGSTText);
                            CLEAR(SGSTText);
                            CLEAR(IGSTText);
                            CGSTText := 'CGST %';
                            SGSTText := 'SGST %';
                            IGSTText := 'IGST %';
                            TotalLine := 10;
                            LineCounter := 0;

                            CLEAR(SumQty);
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
                            //Integer.SETRANGE(Number, 1, (10 - "Purch. Cr. Memo Line".COUNT)); //Pru Gulshan
                            Integer.SETRANGE(Number, 0, TotalLine - LineCounter); //Pru Gulshan
                        end;
                    }
                }

                trigger OnAfterGetRecord()
                begin
                    CompanyInfo.get;
                    IF Number > 1 THEN BEGIN
                        CopyText := Text003;
                        OutputNo += 1;
                    END;


                    VenRec.RESET;
                    VenRec.SETRANGE("No.", "Purch. Cr. Memo Hdr."."Buy-from Vendor No.");
                    IF VenRec.FINDFIRST THEN BEGIN
                        CusGST := VenRec."GST Registration No.";
                        CusPAN := VenRec."P.A.N. No.";
                        IF (VenRec."GST Vendor Type" = VenRec."GST Vendor Type"::Unregistered) THEN
                            ReverseCharge_TextVar := 'Yes'
                        ELSE
                            ReverseCharge_TextVar := 'No';
                    END;

                    StateRec.RESET;
                    StateRec.SETRANGE(Code, VenRec."State Code");
                    //MESSAGE('%1',VenRec."State Code");
                    IF StateRec.FINDFIRST THEN BEGIN
                        CusStateCode := StateRec."State Code (GST Reg. No.)";
                        ShipPAN := VenRec."P.A.N. No.";
                    END;

                    IF "Purch. Cr. Memo Hdr."."Ship-to Code" <> '' THEN BEGIN
                        ShipRec.RESET;
                        ShipRec.SETRANGE("Customer No.", "Purch. Cr. Memo Hdr."."Sell-to Customer No.");
                        ShipRec.SETRANGE(Code, "Purch. Cr. Memo Hdr."."Ship-to Code");
                        IF ShipRec.FINDFIRST THEN BEGIN
                            ShipToGST := ShipRec."GST Registration No.";
                            StateRec.RESET;
                            StateRec.SETRANGE(Code, ShipRec.State);
                            IF StateRec.FINDFIRST THEN
                                shipGSTCode := StateRec."State Code (GST Reg. No.)";
                        END;
                    END;
                    //MESSAGE(shipGSTCode);
                    IF "Purch. Cr. Memo Hdr."."Ship-to Code" = '' THEN BEGIN
                        ShipToGST := CusGST;
                        ShipPAN := CusPAN;
                        shipGSTCode := CusStateCode;
                    END;
                    // If CompanyInfo.SFPLCompany in [CompanyInfo.SFPLCompany::Sampoorna] Then begin
                    //     BankRec.RESET;
                    //     BankRec.SETRANGE("No.", '');
                    //     IF BankRec.FINDFIRST THEN BEGIN
                    //         BankAcc := BankRec."Bank Account No.";
                    //         BankName := BankRec.Name;
                    //         IFSCCode := BankRec."IFSC Code";
                    //         BankAdd := BankRec.Address + ',' + BankRec."Address 2";
                    //         //BankCity := BankRec.City;
                    //     END;
                    // end;


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
                CGST111: Decimal;
                SGST111: Decimal;
                IGST111: Decimal;
            begin
                LocRec.RESET;
                LocRec.SETRANGE(Code, "Purch. Cr. Memo Hdr."."Location Code");
                IF LocRec.FINDFIRST THEN BEGIN
                    NameLoc := 'E-mail:' + LocRec."E-Mail" + ' Website :' + LocRec."Home Page";
                    AddLoc := LocRec.Address + ' ' + LocRec."Address 2";
                    gstLoc := LocRec."GST Registration No.";
                END;

                VendorLedgerEntry.RESET;
                VendorLedgerEntry.SETRANGE("Document No.", "Applies-to Doc. No.");
                IF VendorLedgerEntry.FINDFIRST THEN BEGIN
                    AgainstInvoiceDate := VendorLedgerEntry."Document Date";
                    AgainstInvoiceNo := VendorLedgerEntry."External Document No.";
                END;

                IF Vendor.GET("Purch. Cr. Memo Hdr."."Buy-from Vendor No.") THEN BEGIN
                    IF Vendor."Country/Region Code" <> '' THEN
                        countrReg.GET(Vendor."Country/Region Code");
                    mobileno := Vendor."Phone No.";
                    IF Vendor."State Code" <> '' THEN
                        State1.GET(Vendor."State Code");
                    CountryName := countrReg.Name;
                    StateName := State1.Description;
                END;
                ShiptoAddRec.RESET;
                ShiptoAddRec.SETRANGE(Code, "Purch. Cr. Memo Hdr."."Ship-to Code");
                IF ShiptoAddRec.FINDFIRST THEN
                    mobileno2 := ShiptoAddRec."Phone No.";

                IF "Purch. Cr. Memo Hdr."."Ship-to Code" = '' THEN BEGIN
                    ShiptoName := "Purch. Cr. Memo Hdr."."Buy-from Vendor Name";
                    ShiptoName2 := "Purch. Cr. Memo Hdr."."Buy-from Vendor Name 2";
                    ShipToAdd := "Purch. Cr. Memo Hdr."."Buy-from Address";
                    ShipToAdd2 := "Purch. Cr. Memo Hdr."."Buy-from Address 2";
                    ShipToCity := "Purch. Cr. Memo Hdr."."Buy-from City";
                    ShiptoCode := "Purch. Cr. Memo Hdr."."Buy-from Post Code";
                    ShiptoState := StateName;
                    ShiptoCountry := CountryName;
                    ShiptoPhone := mobileno;
                END ELSE BEGIN
                    ShiptoName := "Purch. Cr. Memo Hdr."."Ship-to Name";
                    ShiptoName2 := "Purch. Cr. Memo Hdr."."Ship-to Name 2";
                    ShipToAdd := "Purch. Cr. Memo Hdr."."Ship-to Address";
                    ShipToAdd2 := "Purch. Cr. Memo Hdr."."Ship-to Address 2";
                    ShipToCity := "Purch. Cr. Memo Hdr."."Ship-to City";
                    ShiptoCode := "Purch. Cr. Memo Hdr."."Ship-to Post Code";
                    ShiptoPhone := mobileno2;

                    IF T222.GET("Purch. Cr. Memo Hdr."."Buy-from Vendor No.", "Purch. Cr. Memo Hdr."."Ship-to Code") THEN BEGIN
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
                if CompanyInfo.SFPLCompany in [CompanyInfo.SFPLCompany::Sampoorna] then
                    PCML.SETRANGE("No.", '1301390');
                if CompanyInfo.SFPLCompany in [CompanyInfo.SFPLCompany::"Star Foods"] then
                    PCML.SETRANGE("No.", '301850');
                if CompanyInfo.SFPLCompany in [CompanyInfo.SFPLCompany::Vetadd] then
                    PCML.SETRANGE("No.", '312320');
                IF PCML.FINDFIRST THEN
                    RoundOffAmt := PCML."Line Amount";

                CLEAR(LineDiscount);
                Clear(gstwords);
                Clear(CGST111);
                Clear(SGST111);
                Clear(IGST111);
                PurchCrMemoLine.RESET;
                PurchCrMemoLine.SETRANGE("Document No.", "No.");
                IF PurchCrMemoLine.FINDFIRST THEN
                    REPEAT
                        RecDetaileGSTLedgerEntry.RESET;
                        RecDetaileGSTLedgerEntry.SETRANGE("Document No.", PurchCrMemoLine."Document No.");
                        //  RecDetaileGSTLedgerEntry.SETRANGE("No.", PurchCrMemoLine."No.");
                        //    RecDetaileGSTLedgerEntry.SETRANGE(RecDetaileGSTLedgerEntry."Posting Date", PurchCrMemoLine."Posting Date");
                        RecDetaileGSTLedgerEntry.SETRANGE("Document Line No.", PurchCrMemoLine."Line No.");
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

                        //gstwords += PurchCrMemoLine."Amount";
                        LineDiscount += PurchCrMemoLine."Line Discount Amount";
                    UNTIL PurchCrMemoLine.NEXT = 0;
                gstwords := CGST111 + SGST111 + IGST111;
                check1.InitTextVariable;
                check1.FormatNoText1(numtext1, CGST111 + SGST111 + IGST111, '');

                IF TermsConditionRec.GET("Purch. Cr. Memo Hdr."."Terms Code") THEN

                    //-->3 Comments
                    PurchCommentLine.RESET;
                PurchCommentLine.SETRANGE("Document Type", PurchCommentLine."Document Type"::"Posted Credit Memo");
                PurchCommentLine.SETRANGE("No.", "Purch. Cr. Memo Hdr."."No.");
                IF PurchCommentLine.FINDFIRST THEN
                    REPEAT
                        IF PurchCommentLine.Comment <> '' THEN BEGIN
                            IF PurchCommentLine."Line No." = 10000 THEN
                                Comment1 := PurchCommentLine.Comment;
                            IF PurchCommentLine."Line No." = 20000 THEN
                                Comment2 := PurchCommentLine.Comment;
                            IF PurchCommentLine."Line No." = 30000 THEN
                                Comment3 := PurchCommentLine.Comment;
                        END;
                    UNTIL PurchCommentLine.NEXT = 0;

                CompanyInfo.Get;
                AuthoSig := CompanyInfo.Name;
                If CompanyInfo.SFPLCompany in [CompanyInfo.SFPLCompany::"Star Foods"] then
                    TermCondition := 'All disputes are subject to Punjab jurisdiction.'
                else
                    TermCondition := 'All disputes are subject to Phagwara jurisdiction.'

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
                group(grp)
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
        FLAg := true;
    end;

    var
        CompanyInfo: Record "Company Information";
        ReportCaption: Label 'Debit Note';
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
        "Invoice No Caption": Label 'Debit Note No.';
        "Invoice Date Caption": Label 'Debit Note Date';
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
        VendorLedgerEntry: Record 25;
        AgainstInvoiceDate: Date;
        Vendor: Record 23;
        countrReg: Record 9;
        mobileno: Text;
        State1: Record State;
        CountryName: Text;
        StateName: Text;
        "PIN caption": Label 'PIN:';
        CusStateCode: Text;
        StateRec: Record State;
        VenRec: Record 23;
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
        PCML: Record 125;
        LineDiscount: Decimal;
        PurchCrMemoLine: Record 125;
        gstwords: Decimal;
        check1: Report 50101;//"1401";
        numtext1: array[2] of Text;
        "Total Invoice Value (Rs.) Caption": Label 'Total Invoice Value (Rs.)';
        "Total Invoice Value Caption": Label 'Total Invoice Value (In Words):-';
        numtext2: array[2] of Text;
        TotAmt: Decimal;

        TotAmt1: Decimal;
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
        PurchCommentLine: Record 43;
        Comment1: Text;
        Comment2: Text;
        Comment3: Text;
        AgainstInvoiceNo: Code[35];
        DetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry";//16419;
        SumQty: Decimal;
        SumTotal: Decimal;
        GSTRateVale: Decimal;
        TCSAmt1: Decimal;
        FLAg: Boolean;
        TCSENtry: Record "TDS Entry";
        AuthoSig: Text;
        TermCondition: Text;
        VetaddCompany: text;


}

