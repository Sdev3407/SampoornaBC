report 50044 "Purchase Order StarFoods"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'ReportLayout\PurchaseOrderStarFoods.rdl';

    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            RequestFilterFields = "No.";
            column(UserID2; UserID2)
            {
            }
            column(UserID1; UserID1)
            {
            }
            column(RecStatus; RecStatus)
            { }
            column(Approvedby; Approvedby)
            {
            }
            column(ModeofPayment_PurchaseHeader; "Purchase Header"."Payment Method Code")
            {
            }
            column(OtherTermCap; OtherTermCap)
            {
            }
            column(OtherTermCaption; OtherTermCaption)
            {
            }
            column(pleaseCap; pleaseCap)
            {
            }
            column(PaymentTermsCode_PurchaseHeader; "Purchase Header"."Payment Terms Code")
            {
            }
            column(REGcap; REGcap)
            {
            }
            column(paymentDes; paymentDes)
            {
            }
            column(ModeofTransport_PurchaseHeader; "Purchase Header"."Shipment Method Code")
            {
            }
            column(DeliveryPeriodCaop; DeliveryPeriodCaop)
            {
            }
            column(ModetransportCap; ModetransportCap)
            {
            }
            column(DestinationCap; DestinationCap)
            {
            }
            column(PaymentTermCap; PaymentTermCap)
            {
            }
            column(InsuranceType_PurchaseHeader; "Purchase Header"."Insurance Type")
            {
            }
            column(Freight_PurchaseHeader; "Purchase Header".Freight)
            {
            }
            column(InsuranceCap; InsuranceCap)
            {
            }
            column(DeliveryPeriod_PurchaseHeader; "Purchase Header"."Requested Receipt Date")
            {
            }
            column(FreightCap; FreightCap)
            {
            }
            column(Sno_TC; Sno_TC)
            {
            }
            column(Terms_Tc; Terms_Tc)
            {
            }
            column(Cond_Tc; Cond_Tc)
            {
            }
            column(T1; T1)
            {
            }
            column(T2; T2)
            {
            }
            column(OrderDate; FORMAT("Purchase Header"."Order Date", 0, 4))
            {
            }
            column(TermsCode_PurchaseHeader; '')
            {
            }
            column(QuoteNo; "Purchase Header"."Quote No.")
            {
            }
            column(FOR_EX; "Purchase Header"."Rate Basis")
            {
            }
            column(Email; CompInfo."E-Mail")
            {
            }
            column(Watermark; CompInfo.Watermark)
            { }
            column(PaymentMethod1; PaymentMethod1)
            {
            }
            column(BrokerName; BrokerName)
            {
            }
            column(vendorNo; "Purchase Header"."Pay-to Vendor No.")
            {
            }
            column(CreditDays1; CreditDays1)
            {
            }
            column(phone11; phone11)
            {
            }
            column(contact11; contact11)
            {
            }
            column(State2; State2)
            {
            }
            column(EmailVendor; EmailVendor)
            {
            }
            column(ConTactVendor; ConTactVendor)
            {
            }
            column(PhoneVendor; PhoneVendor)
            {
            }
            column(GSTNO; GSTNO)
            {
            }
            column(CreditDays; CreditDays)
            {
            }
            column(ExtendedTexts; ExtendedTexts)
            {
            }
            column(Email11; Email11)
            {
            }
            column(State11; State11)
            {
            }
            column(Add11; Add11)
            {
            }
            column(Name11; Name11)
            {
            }
            column(Supplier_Caption; Supplier_Caption)
            {
            }
            column(ContactPerson_Caption; ContactPerson_Caption)
            {
            }
            column(E_Mail_Caption; E_Mail_Caption)
            {
            }
            column(Headline1; Headline1)
            {
            }
            column(IndentDate_Caption; IndentDate_Caption)
            {
            }
            column(IndentNo_Caption; IndentNo_Caption)
            {
            }
            column(RateBasis_Caption; RateBasis_Caption)
            {
            }
            column(FOR_EX_Caption; FOR_EX_Caption)
            {
            }
            column(ModeOfPay_Caption; ModeOfPay_Caption)
            {
            }
            column(QtnNo_Caption; QtnNo_Caption)
            {
            }
            column(QtnDate_Caption; QtnDate_Caption)
            {
            }
            column(CreditDays_Caption; CreditDays_Caption)
            {
            }
            column(BrokerName_Caption; BrokerName_Caption)
            {
            }
            column(Prepared_Caption; Prepared_Caption)
            {
            }
            column(Approved_Caption; Approved_Caption)
            {
            }
            column(Authorised_Caption; Authorised_Caption)
            {
            }
            column(State1; State1)
            {
            }
            column(CompanyAddr1; CompanyAddr[1])
            {
            }
            column(CompanyAddr2; CompanyAddr[2])
            {
            }
            column(CompanyAddr3; CompanyAddr[3])
            {
            }
            column(CompanyAddr4; CompanyAddr[4])
            {
            }
            column(CompanyAddr5; CompanyAddr[5])
            {
            }
            column(CompanyAddr6; CompanyAddr[6])
            {
            }
            column(CompanyAddr7; CompanyAddr[7])
            {
            }
            column(CompanyAddr8; CompanyAddr[8])
            {
            }
            column(ShiptoName_PurchaseHeader; "Purchase Header"."Ship-to Name")
            {
            }
            column(ShiptoName2_PurchaseHeader; "Purchase Header"."Ship-to Name 2")
            {
            }
            column(ShiptoAddress_PurchaseHeader; "Purchase Header"."Ship-to Address")
            {
            }
            column(ShiptoAddress2_PurchaseHeader; "Purchase Header"."Ship-to Address 2")
            {
            }
            column(ShiptoCity_PurchaseHeader; "Purchase Header"."Ship-to City")
            {
            }
            column(ShiptoContact_PurchaseHeader; "Purchase Header"."Ship-to Contact")
            {
            }
            column(PaytoName_PurchaseHeader; "Purchase Header"."Pay-to Name")
            {
            }
            column(PaytoName2_PurchaseHeader; "Purchase Header"."Pay-to Name 2")
            {
            }
            column(PaytoAddress_PurchaseHeader; "Purchase Header"."Pay-to Address")
            {
            }
            column(PaytoAddress2_PurchaseHeader; "Purchase Header"."Pay-to Address 2")
            {
            }
            column(PaytoCity_PurchaseHeader; "Purchase Header"."Pay-to City")
            {
            }
            column(PaytoContact_PurchaseHeader; "Purchase Header"."Pay-to Contact")
            {
            }
            column(DocumentDate_PurchaseHeader; "Purchase Header"."Document Date")
            {
            }
            column(No_PurchaseHeader; "Purchase Header"."No.")
            {
            }
            column(CST; CST)
            {
            }
            column(GST; GST)
            {
            }
            column(Discout_Cap; Discout_Cap)
            {
            }
            column(PackingFor_Cap; PackingFor_Cap)
            {
            }
            column(INS_CAP; INS_CAP)
            {
            }
            column(SGST_cap; SGST_cap)
            {
            }
            column(CGST_CAP; CGST_CAP)
            {
            }
            column(IGST_CAP; IGST_CAP)
            {
            }
            column(GST_CompInfo; CompInfo."GST Registration No.")
            {
            }
            column(CINNO; CompInfo."SFPL_C.I.N No.")
            {
            }
            column(TINNO_CompInfo; CompInfo."T.C.A.N. No.")
            {
            }
            column(PhoneNo_CompInfo; CompInfo."Phone No.")
            {
            }
            column(Picture_CompInfo; CompInfo.Picture)
            {
            }
            column(Remarks_Caption; "Notes/Remarks_Caption")
            {
            }
            column(Approval_Caption; Approval_Caption)
            {
            }
            column(ShippingDate_Caption; ShippingDate_Caption)
            {
            }
            column(PaymentDetails_Caption; "PaymentDetails_Caption")
            {
            }
            column(Reference_Caption; "Reference_Caption")
            {
            }
            column(OrderNo_Caption; "OrderNo_Caption")
            {
            }
            column(Date_Caption; "Date_Caption")
            {
            }
            column(TOTAL_Caption; "TOTAL_Caption")
            {
            }
            column(Roundoff_Caption; "Roundoff_Caption")
            {
            }
            column(GST_Caption; "GST_Caption")
            {
            }
            column(SubTotal_Caption; "SubTotal_Caption")
            {
            }
            column(PriceRs_perKg_Caption; "BasicPriceRs/perKg_Caption")
            {
            }
            column(Description_Caption; "Description_Caption")
            {
            }
            column(ItemCode_Caption; "ItemCode_Caption")
            {
            }
            column(HSNCode_Caption; "HSNCode_Caption")
            {
            }
            column(Units_Caption; Units_Caption)
            {
            }
            column(Qty_Caption; "Qty_Caption")
            {
            }
            column(Phone_Caption; Phone_Caption)
            {
            }
            column(GSTNO_Caption; "GST NO_Caption")
            {
            }
            column(CST_Caption; "VAT\CST_Caption")
            {
            }
            column(Address_Caption; Address_Caption)
            {
            }
            column(Name_Caption; Name_Caption)
            {
            }
            column(Vendor_Caption; Vendor_Caption)
            {
            }
            column(ShipTo_Caption; ShipTo_Caption)
            {
            }
            column(PurchaseOrder_Caption; PurchaseOrder_Caption)
            {
            }
            column(PurchaseOrderDate_Caption; PurchaseOrderDate_Caption)
            {
            }
            column(PurchaseOrderNo_Caption; PurchaseOrderNo_Caption)
            {
            }
            column(Word; Word[1])
            {
            }
            column(IndentDate1; IndentDate1)
            {
            }
            column(PreparedBy_PurchaseHeader; "Purchase Header".SystemCreatedBy)
            {
            }
            column(ApprovedBy_PurchaseHeader; '')
            {
            }
            dataitem("Purchase Line"; "Purchase Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                column(GSTAmt11; GSTamt1)
                {
                }
                column(GSTBOOL; GSTBOOL)
                {
                }
                column(SgstAmount; SgstAmount)
                {
                }
                column(CgstAmount; CgstAmount + SgstAmount)
                {
                }
                column(IgstAmount; IgstAmount)
                {
                }
                column(SgstPer; SgstPer)
                {
                }
                column(CgstPer; CgstPer)
                {
                }
                column(IgstPer; IgstPer)
                {
                }
                column(DocumentNo; "Purchase Line"."Document No.")
                {
                }
                column(Line_Discount_Amount; "Purchase Line"."Line Discount Amount")
                { }
                column("Line_Discount_Per"; "Purchase Line"."Line Discount %")
                { }
                column(LineNo; "Purchase Line"."Line No.")
                {
                }
                column(AmountInWordsCap; AmountInWordsCap)
                {
                }
                column(IndentNo; "Purchase Line"."Indent No.")
                {
                }
                column(itemNo; "Purchase Line"."No.")
                {
                }
                column(LineItem; "LineItem")
                { }
                column(HSN_SAC; "Purchase Line"."HSN/SAC Code")
                {
                }
                column(UnitPriceLCY_PurchaseLine; "Purchase Line"."Unit Cost (LCY)")
                {
                }
                column(Quantity_PurchaseLine; "Purchase Line".Quantity)
                {
                }
                column(Description_PurchaseLine; "Purchase Line".Description)
                {
                }
                column(UnitofMeasure_PurchaseLine; "Purchase Line"."Unit of Measure")
                {
                }
                column(HSNSACCode_PurchaseLine; "Purchase Line"."HSN/SAC Code")
                {
                }
                column(ItemCategoryCode_PurchaseLine; "Purchase Line"."Item Category Code")
                {
                }
                column(LineAmount_PurchaseLine; "Purchase Line"."Line Amount")
                {
                }
                column(GSTamt; GSTamt)
                {
                }
                column(GSTamt1; GSTamt1)
                {
                }
                column(FreightCharges; FreightCharges)
                {
                }
                column(OtherCharges; OtherCharges)
                {
                }
                column(InsCharges; InsCharges)
                {
                }
                column(PackingCharges; PackingCharges)
                {
                }
                column(UnitCost_PurchaseLine; "Purchase Line"."Direct Unit Cost")
                {
                }
                column(UnitofMeasureCode_PurchaseLine; "Purchase Line"."Unit of Measure Code")
                {
                }

                trigger OnAfterGetRecord()
                var
                    T27: Record Item;
                begin
                    CLEAR(GSTBOOL);
                    CLEAR(IgstAmount);
                    CLEAR(IgstPer);
                    CLEAR(CgstPer);
                    CLEAR(CgstAmount);
                    Clear(LineItem);



                    //GSTamt := 0;
                    /*IF T27.GET("No.") THEN
                      IF T27."Bag Item" THEN
                        CurrReport.SKIP;
                        */
                    // IndentHeader.RESET;
                    // IndentHeader.SETRANGE("Indent No.", "Purchase Line"."Indent No.");
                    // IF IndentHeader.FINDFIRST THEN
                    //     IndentDate1 := IndentHeader."Indent Date";
                    /*
                    //Pru-GK
                    PostStrOrdLineDet.RESET;
                    PostStrOrdLineDet.SETRANGE(Type,PostStrOrdLineDet.Type::Purchase);
                    PostStrOrdLineDet.SETRANGE("Document No." ,"Purchase Line"."Document No.");
                    PostStrOrdLineDet.SETRANGE("Tax/Charge Type",PostStrOrdLineDet."Tax/Charge Type"::Charges);
                    PostStrOrdLineDet.SETFILTER("Tax/Charge Group",'%1|%2|%3|%4|%5','FREIGHT','PACKING','Handling','OTHERS','INSU');
                    IF PostStrOrdLineDet.FINDFIRST THEN BEGIN
                      REPEAT
                        IF PostStrOrdLineDet."Tax/Charge Group" = 'FREIGHT' THEN
                          FreightCharges += PostStrOrdLineDet."Calculation Value";
                        IF PostStrOrdLineDet."Tax/Charge Group" = 'OTHERS' THEN
                          OtherCharges += PostStrOrdLineDet."Calculation Value";
                        IF PostStrOrdLineDet."Tax/Charge Group" = 'PACKING' THEN
                            PackingCharges  += PostStrOrdLineDet."Calculation Value";
                        IF PostStrOrdLineDet."Tax/Charge Group" = 'INSU' THEN
                          InsCharges  += PostStrOrdLineDet."Calculation Value";
                    
                       //   GrandTotalVar += PostStrOrdLineDet."Calculation Value";
                      UNTIL PostStrOrdLineDet.NEXT=0;
                    END;
                    */



                    // IF "Purchase Line"."GST Jurisdiction Type" = "Purchase Line"."GST Jurisdiction Type"::Interstate THEN
                    //     GSTamt += "Purchase Line"."Total GST Amount"
                    // ELSE
                    //     GSTamt1 += "Purchase Line"."Total GST Amount" / 2;
                    //Pru-GK
                    /*
                    ExtendedHeader.RESET;
                    ExtendedHeader.SETRANGE("No.","Purchase Line"."No.");
                    IF ExtendedHeader.FINDFIRST THEN
                      ExtendedLine.RESET;
                      ExtendedLine.SETRANGE("No.", ExtendedHeader."No.");
                      ExtendedLine.SETRANGE("Table Name", ExtendedHeader."Table Name");
                      IF ExtendedLine.FINDFIRST THEN REPEAT
                         ExtendedTexts+= ExtendedLine.Text;
                       UNTIL ExtendedLine.NEXT=0;
                    */
                    If ("Purchase Line".Type <> Enum::"Purchase Line Type"::"G/L Account") and ("Purchase Line".Type <> Enum::"Purchase Line Type"::"Charge (Item)") Then
                        LineItem := '(' + "Purchase Line"."No." + ')';

                    Clear(IgstAmount);
                    Clear(CgstAmount);
                    Clear(SgstAmount);
                    GSTSetup1.Get();//PT
                    TaxTransValue1.SetRange("Tax Type", GSTSetup1."GST Tax Type");
                    TaxTransValue1.SetRange("Tax Record ID", "Purchase Line".RecordId());
                    TaxTransValue1.SetRange("Value Type", TaxTransValue1."Value Type"::COMPONENT);
                    TaxTransValue1.SetFilter(Percent, '<>%1', 0);
                    if TaxTransValue1.FindSet() then
                        repeat
                            TaxComponentName1 := TaxTransValue1.GetAttributeColumName();
                            case TaxComponentName1 of
                                'IGST':
                                    begin
                                        IgstPer := TaxTransValue1.Percent;
                                        evaluate(IGST_Amt2, TaxTransValue1."Column Value");
                                        IgstAmount += IGST_Amt2;
                                    end;
                                'CGST':
                                    begin
                                        evaluate(CGST_Amt2, TaxTransValue1."Column Value");
                                        CgstPer += TaxTransValue1.Percent;
                                        CgstAmount += CGST_Amt2;
                                    end;
                                'SGST':
                                    begin
                                        evaluate(SGST_Amt2, TaxTransValue1."Column Value");
                                        SgstPer += TaxTransValue1.Percent;
                                        SgstAmount += SGST_Amt2;
                                    end;
                            end;
                        until TaxTransValue1.Next() = 0;

                    IF IgstAmount <> 0 THEN BEGIN

                        GSTBOOL := TRUE;
                    END;

                    IF CgstAmount <> 0 THEN BEGIN

                        GSTBOOL := FALSE;
                    END;


                    GSTamt1 := IgstAmount + CgstAmount + SgstAmount;


                end;
            }

            trigger OnAfterGetRecord()
            var
                SgstAmount1: Decimal;
                CgstAmount1: Decimal;
                IgstAmount1: Decimal;
                CGST_Amt3: Decimal;
                SGST_Amt3: Decimal;
                IGST_Amt3: Decimal;
            begin

                If "Purchase Header".Status <> ("Purchase Header".Status::Released) then
                    Error('The Purchase Order will be print only if Status is Released');


                /*
                TermsConditionRec.RESET;
                TermsConditionRec.SETRANGE("No.","Purchase Header"."No.");
                IF TermsConditionRec.FINDSET THEN BEGIN
                  Sno_TC:= TermsConditionRec."Line No.";
                  Terms_Tc:= TermsConditionRec.Terms;
                  Cond_Tc:= TermsConditionRec.Conditions;
                
                  END;
                  */
                // IF "Purchase Header"."Terms Code" <> '' THEN
                //     TermsConditionRec.GET("Purchase Header"."Terms Code");

                CLEAR(Approvedby);
                ApprovalEntry.RESET;
                ApprovalEntry.SETRANGE("Document Type", "Document Type");
                ApprovalEntry.SETRANGE("Document No.", "No.");
                ApprovalEntry.SETRANGE(Status, ApprovalEntry.Status::Approved);
                IF ApprovalEntry.FINDFIRST THEN
                    Approvedby := ApprovalEntry."Approver ID";


                PaymentMethodRec.RESET;
                PaymentMethodRec.SETRANGE(Code, "Purchase Header"."Payment Method Code");
                IF PaymentMethodRec.FINDFIRST THEN
                    PaymentMethod1 := PaymentMethodRec.Description;


                LocationRec.RESET;

                LocationRec.SETRANGE(Code, "Purchase Header"."Location Code");
                IF LocationRec.FINDFIRST THEN
                    //Name11:= LocationRec.Name;
                    Name11 := CompInfo.Name;
                Add11 := LocationRec.Address + ', ' + LocationRec."Address 2" + ', ' + LocationRec.City + '- ' + LocationRec."Post Code";
                State111 := LocationRec."State Code";
                Email11 := LocationRec."E-Mail";
                GSTNO := LocationRec."GST Registration No.";
                phone11 := LocationRec."Phone No.";
                contact11 := LocationRec.Contact;

                StateRec.RESET;
                StateRec.SETRANGE(StateRec.Code, State111);
                IF StateRec.FINDFIRST THEN
                    State11 := StateRec.Description;



                vendor.RESET;
                vendor.SETRANGE("No.", "Purchase Header"."Pay-to Vendor No.");
                IF vendor.FINDFIRST THEN
                    //   CST := vendor."TAN No.";
                    GST := vendor."GST Registration No.";

                ConTactVendor := vendor.Contact;
                PhoneVendor := vendor."Phone No.";
                EmailVendor := vendor."E-Mail";

                CreditDays := "Purchase Header"."Payment Terms Code";
                /*vendor.RESET;
                vendor.SETRANGE("No.","Purchase Header"."Insurance Type");
                IF vendor.FINDFIRST THEN
                  BrokerName:= vendor.Name;
                  */

                PaymentRec.RESET;
                PaymentRec.SETRANGE(Code, CreditDays);
                IF PaymentRec.FINDFIRST THEN
                    CreditDays1 := PaymentRec.Description;

                StateRec.RESET;
                StateRec.SETRANGE(StateRec.Code, "Purchase Header".State);
                IF StateRec.FINDFIRST THEN
                    State1 := StateRec.Description;
                FormatAddr.Company(CompanyAddr, CompInfo);

                LocationRec.RESET;
                LocationRec.SETRANGE(Code, "Purchase Header"."Ship-to Code");
                IF LocationRec.FINDFIRST THEN
                    shipState := LocationRec."State Code";


                StateRec.RESET;
                StateRec.SETRANGE(StateRec.Code, shipState);
                IF StateRec.FINDFIRST THEN
                    State2 := StateRec.Description;
                PurchaseLine.RESET;
                PurchaseLine.SETRANGE("Document No.", "No.");
                IF PurchaseLine.FINDFIRST THEN
                    REPEAT
                        lineAmount += PurchaseLine."Line Amount";
                    //GSTLineAMt += PurchaseLine."Total GST Amount";

                    UNTIL PurchaseLine.NEXT = 0;
                Clear(CgstAmount1);
                Clear(SgstAmount1);
                Clear(IgstAmount1);
                PurchaseLine.RESET;
                PurchaseLine.SETRANGE("Document No.", "No.");
                IF PurchaseLine.FINDFIRST THEN
                    REPEAT
                        Clear(IGST_Amt3);
                        Clear(CGST_Amt3);
                        Clear(SGST_Amt3);
                        lineAmount += PurchaseLine."Line Amount";
                        //  GSTLineAMt += PurchaseLine."Total GST Amount";
                        GSTSetup1.Get();//PT
                        TaxTransValue1.SetRange("Tax Type", GSTSetup1."GST Tax Type");
                        TaxTransValue1.SetRange("Tax Record ID", PurchaseLine.RecordId());
                        TaxTransValue1.SetRange("Value Type", TaxTransValue1."Value Type"::COMPONENT);
                        TaxTransValue1.SetFilter(Percent, '<>%1', 0);
                        if TaxTransValue1.FindSet() then
                            repeat
                                TaxComponentName1 := TaxTransValue1.GetAttributeColumName();
                                case TaxComponentName1 of
                                    'IGST':
                                        begin
                                            //  IgstPer := TaxTransValue1.Percent;
                                            evaluate(IGST_Amt3, TaxTransValue1."Column Value");
                                            IgstAmount1 += IGST_Amt3;
                                        end;
                                    'CGST':
                                        begin
                                            evaluate(CGST_Amt3, TaxTransValue1."Column Value");
                                            //CgstPer += TaxTransValue1.Percent;
                                            CgstAmount1 += CGST_Amt3;
                                        end;
                                    'SGST':
                                        begin
                                            evaluate(SGST_Amt3, TaxTransValue1."Column Value");
                                            SgstPer += TaxTransValue1.Percent;
                                            SgstAmount1 += SGST_Amt3;
                                        end;
                                end;
                            until TaxTransValue1.Next() = 0;
                    UNTIL PurchaseLine.NEXT = 0;
                GSTLineAMt := CgstAmount1 + IgstAmount1 + SgstAmount1;

                PI.Reset();
                PI.SetRange("Document No.", "No.");
                if PI.FindSet() then begin
                    PI.CalcSums(Amount);
                    LineAmt1 := PI.Amount;
                end;
                //LineAmt1 += Round(GSTLineAMt);
                Check.InitTextVariable;
                Check.FormatNoText1(Word, LineAmt1 + Round(GSTLineAMt), "Purchase Header"."Currency Code");

                // DeliveryTerms.RESET;
                // DeliveryTerms.SETRANGE(Code, "Purchase Header"."Delivery Period");
                // IF DeliveryTerms.FINDFIRST THEN
                //     paymentDes := DeliveryTerms.Description;

                If "Purchase Header".Status in ["Purchase Header".Status::Released] Then
                    RecStatus := 1
                else
                    RecStatus := 2;



                UserSetup_Rec.RESET;
                UserSetup_Rec.SETRANGE(UserSetup_Rec."User Security ID", "Purchase Header".SystemCreatedBy);
                IF UserSetup_Rec.FINDFIRST THEN
                    UserID1 := UserSetup_Rec."Full Name";
                UserSetup_Rec.RESET;
                UserSetup_Rec.SETRANGE(UserSetup_Rec."User Name", Approvedby);
                IF UserSetup_Rec.FINDFIRST THEN
                    UserID2 := UserSetup_Rec."Full Name";

            end;
        }
    }

    requestpage
    {

        layout
        {
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
        CompInfo.GET;
        CompInfo.CALCFIELDS(Picture);
        CompInfo.CalcFields(Watermark);
    end;

    var
        RecStatus: Option;
        GSTLineAMt: Decimal;
        LineAmt1: Decimal;
        GSTBOOL: Boolean;
        SgstAmount: Decimal;
        CgstAmount: Decimal;
        IgstAmount: Decimal;
        SgstPer: Decimal;
        CgstPer: Decimal;
        IgstPer: Decimal;
        Sno_TC: Integer;
        State111: Code[10];
        Terms_Tc: Text;
        Cond_Tc: Text;
        //TermsConditionRec: Record "50006";
        IndentDate1: Date;
        IndentHeader: Record "Indent Header";
        PaymentMethodRec: Record "Payment Method";
        PaymentMethod1: Text;
        BrokerName: Text;
        CreditDays1: Text;
        PaymentRec: Record "Payment Terms";
        phone11: Text;
        contact11: Text;
        shipState: Text;
        State2: Text;
        PhoneVendor: Text;
        EmailVendor: Text;
        ConTactVendor: Text;
        GSTNO: Text;
        CreditDays: Text;
        ExtendedHeader: Record "Extended Text Header";
        ExtendedLine: Record "Extended Text Line";
        CompInfo: Record "Company Information";
        T1: Label 'Subject to Jurisdiction of Phagwara Only';
        T2: Label 'GST% as per the Current Billing Terms ';
        E_Mail_Caption: Label 'E-Mail :';
        ContactPerson_Caption: Label 'Contact Person :';
        Supplier_Caption: Label 'Supplier :';
        IndentDate_Caption: Label 'Indent Date :';
        IndentNo_Caption: Label 'Indent No :';
        RateBasis_Caption: Label 'Rate Basis :';
        FOR_EX_Caption: Label 'Rate Basis :';
        ModeOfPay_Caption: Label 'Mode of Payment :';
        QtnNo_Caption: Label 'Qtn. No. :';
        QtnDate_Caption: Label 'Qtn. Date :';
        CreditDays_Caption: Label 'Credit Days :';
        BrokerName_Caption: Label 'Broker Name :';
        Prepared_Caption: Label 'Prepared By';
        Approved_Caption: Label 'Approved By';
        Authorised_Caption: Label 'Authorised Signatory';
        Headline1: Label '"Please supply following materials as per terms & conditions mentioned below. Our purchase order and date must be mentioned in all your document against this supply".';
        Vendor_Caption: Label 'Vendor No. :';
        ShipTo_Caption: Label 'Ship To :';
        Name_Caption: Label 'Name :';
        Address_Caption: Label 'Address :';
        "VAT\CST_Caption": Label 'State :';
        "GST NO_Caption": Label 'GSTIN :';
        Phone_Caption: Label 'Person Ph No. :';
        Qty_Caption: Label 'Qty';
        Units_Caption: Label 'Units';
        HSNCode_Caption: Label 'HSN Code';
        ItemCode_Caption: Label 'Item Code';
        Description_Caption: Label 'Description';
        "BasicPriceRs/perKg_Caption": Label 'Rate (Per Item)';
        //Total_Caption: Label 'Total';
        SubTotal_Caption: Label 'Sub Total';
        GST_Caption: Label 'GST @';
        Roundoff_Caption: Label 'Round off';
        TOTAL_Caption: Label 'TOTAL';
        Date_Caption: Label 'Date';
        OrderNo_Caption: Label 'Order No.';
        Reference_Caption: Label 'Reference';
        PaymentDetails_Caption: Label 'Payment Details';
        ShippingDate_Caption: Label 'Shipping Date';
        Approval_Caption: Label 'Approval';
        "Notes/Remarks_Caption": Label 'Notes / Remarks';
        PurchaseOrder_Caption: Label 'PURCHASE ORDER';
        PurchaseOrderNo_Caption: Label 'Purchase Order No. :';
        PurchaseOrderDate_Caption: Label 'Date  :';
        vendor: Record Vendor;
        CST: Text;
        GST: Text;
        PurchLineRec: Record "Purchase Line";
        GSTamt: Decimal;
        FormatAddr: Codeunit "Format Address";
        CompanyAddr: array[8] of Text;
        Discout_Cap: Label 'Discount';
        PackingFor_Cap: Label 'Packing/Forwarding Charges';
        INS_CAP: Label 'Insurance Charges';
        SGST_cap: Label 'SGST';
        CGST_CAP: Label 'CGST';
        IGST_CAP: Label 'IGST';
        GSTamt1: Decimal;
        //PostStrOrdLineDet: Record "13794";
        FreightCharges: Decimal;
        OtherCharges: Decimal;
        InsCharges: Decimal;
        PackingCharges: Decimal;
        StateRec: Record State;
        State1: Text;
        ItemRec: Record Item;
        ExtendedTexts: Text;
        LocationRec: Record Location;
        Name11: Text;
        Add11: Text;
        State11: Text;
        ContactPerson11: Text;
        PersonPh11: Decimal;
        Email11: Text;
        Check: Report CheckPrint1;
        Word: array[2] of Text;
        AmountInWordsCap: Label 'Amount In Words :';
        PurchaseLine: Record "Purchase Line";
        lineAmount: Decimal;
        InsuranceCap: Label 'Insurance :';
        FreightCap: Label 'Freight :';
        DeliveryPeriodCaop: Label 'Delivery Period :';
        ModetransportCap: Label 'Mode Of Transport :';
        DestinationCap: Label 'Destination :';
        PaymentTermCap: Label 'Payment Term :';
        PaymentTerms: Record "Payment Terms";
        paymentDes: Text;
        OtherTermCap: Label 'Please intimate dispatch particulars i.e.GR/RR no & Date Transporter’s name, Nature of Packing Value of consignment etc Banmajra Unit by Telegraphically/by fax for insurance cover failing which all liabilities for loss / damage shall be to your  account.Please quote our P.O. no on all future correspondence related to this order.The transaction against this order is subjected to Punjab jurisdiction. ';
        OtherTermCaption: Label 'Other Terms :';
        pleaseCap: Label 'Please return a copy of this PO duly signed &stamped as a token of acceptance .In case we do not receive acceptance copy within 7 days the order along with the terms shall be considered as accepted as it is.';
        REGcap: Label 'REG. OFFICE: PLOT NO -F5 RAJIV GANDHI IT PARK CHANDIGARH -160101, Telephone no. 0172-4266666,Fax no 0172-4680003.';
        //DeliveryTerms: Record del;
        Approvedby: Code[20];
        ApprovalEntry: Record "Approval Entry";
        UserSetup_Rec: Record User;
        UserID1: Text;
        UserID2: Text;
        TaxTransValue1: Record "Tax Transaction Value";
        GSTSetup1: Record "GST Setup";
        TaxComponentName1: Text;
        SGST_Amt2: Decimal;
        IGST_Amt2: Decimal;
        SGST_perc1: Decimal;
        CGST_Amt1: Decimal;
        CGST_perc1: Decimal;
        IGST_Amt1: Decimal;
        CGST_Amt2: Decimal;
        IGST_perc1: Decimal;
        LineItem: Text;
        PI: Record "Purchase Line";

}

