report 50002 "Purchase Order1"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'ReportLayout\PurchaseOrder1.rdl';

    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            RequestFilterFields = "Document Type", "No.";
            CalcFields = Amount;
            column(Sno_TC; Sno_TC)
            {
            }
            column(Terms_Tc; Terms_Tc)
            {
            }
            column(RecStatus; RecStatus)
            { }
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
            column(TermsCode_PurchaseHeader; TermsConditionRec.Conditions + ' ' + TermsConditionRec.Conditions2)
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
            column(Approvedby; Approvedby)
            {
            }
            column(CreatedBy; CreatedBy)
            { }
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
            column(BillAdd11; BillAdd11)
            { }
            column(Billcontact11; Billcontact11)
            { }
            column(BillEmail11; BillEmail11)
            { }
            column(BillGSTNO; BillGSTNO)
            { }
            column(Billphone11; Billphone11)
            { }
            column(BillState11; BillState11)
            { }
            column(BillState111; BillState111)
            { }
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
            column(PaytoAddress_PurchaseHeader; "Purchase Header"."Buy-from Address")
            {
            }
            column(PaytoAddress2_PurchaseHeader; "Purchase Header"."Buy-from Address 2")
            {
            }
            column(PaytoCity_PurchaseHeader; "Purchase Header"."Buy-from City")
            {
            }
            column(PaytoContact_PurchaseHeader; "Purchase Header"."Buy-from Contact")
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
            column(TINNO_CompInfo; TINNO_CompInfo)
            {
            }
            column(PhoneNo_CompInfo; CompInfo."Phone No.")
            {
            }
            column(Picture_CompInfo; CompInfo.Picture)
            {
            }
            column(Watermark_CompInfo; CompInfo.Watermark)
            { }
            column(Remarks_Caption; "Notes/Remarks_Caption")
            {
            }
            column(Approval_Caption; Approval_Caption)
            {
            }
            column(ShippingDate_Caption; ShippingDate_Caption)
            {
            }
            column(PaymentDetails_Caption; PaymentDetails_Caption)
            {
            }
            column(Reference_Caption; Reference_Caption)
            {
            }
            column(OrderNo_Caption; OrderNo_Caption
                                   )
            {
            }
            column(Date_Caption; Date_Caption

                                )
            {
            }
            column(TOTAL_Caption; TOTAL_Caption
                                 )
            {
            }
            column(Roundoff_Caption; Roundoff_Caption

                                    )
            {
            }
            column(GST_Caption; GST_Caption

                               )
            {
            }
            column(SubTotal_Caption; SubTotal_Caption

                                    )
            {
            }
            column(PriceRs_perKg_Caption; "BasicPriceRs/perKg_Caption"

                                         )
            {
            }
            column(Description_Caption; Description_Caption

                                       )
            {
            }
            column(ItemCode_Caption; ItemCode_Caption
                                    )
            {
            }
            column(HSNCode_Caption; HSNCode_Caption

                                   )
            {
            }
            column(Units_Caption; Units_Caption)
            {
            }
            column(Qty_Caption; Qty_Caption
                               )
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
            column(Commnt1; Commnt1)
            {
            }
            column(Commnt2; Commnt2)
            {
            }
            column(Commnt3; Commnt3)
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
                column(HSN_SAC; "Purchase Line"."HSN/SAC Code")
                {
                }
                column(UnitPriceLCY_PurchaseLine; "Purchase Line"."Unit Price (LCY)")
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

                    //      Message("Purchase Line"."Document No.");

                    //GSTamt := 0;
                    /*
                    IF T27.GET("No.") THEN
                      IF T27."Bag Item" THEN
                        CurrReport.SKIP;
                      */
                    IndentHeader.RESET;
                    IndentHeader.SETRANGE("Indent No.", "Purchase Line"."Indent No.");
                    IF IndentHeader.FINDFIRST THEN
                        IndentDate1 := IndentHeader."Indent Date";



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


                    IF "Purchase Line".Type = "Purchase Line".Type::" " THEN
                        ExtendedTexts := "Purchase Line".Description;
                    /*
                IF "Purchase Line"."GST Jurisdiction Type" = "Purchase Line"."GST Jurisdiction Type"::Interstate THEN BEGIN
                    IgstAmount := "Purchase Line"."Total GST Amount";
                    IgstPer := "Purchase Line"."GST %";
                    GSTBOOL := TRUE;
                END;

                IF "Purchase Line"."GST Jurisdiction Type" = "Purchase Line"."GST Jurisdiction Type"::Intrastate THEN BEGIN
                    CgstAmount := "Purchase Line"."Total GST Amount";
                    CgstPer := "Purchase Line"."GST %" / 2;
                    //SgstAmount:= "Purchase Line"."Total GST Amount";
                    SgstPer := "Purchase Line"."GST %" / 2;
                    GSTBOOL := FALSE;
                END;
*/

                    //////////////////

                    //if (PLRec1."P & F Value" = true) OR (PLRec1."Freight Value" = true) OR (PLRec1."Cutting & Loading" = true) then begin
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
                User: Record User;
            begin

                If "Purchase Header".Status <> ("Purchase Header".Status::Released) then
                    Error('The Purchase Order will be print only if Status is Released');

                CLEAR(Approvedby);
                ApprovalEntry.RESET;
                ApprovalEntry.SETRANGE("Document Type", "Document Type");
                ApprovalEntry.SETRANGE("Document No.", "No.");
                ApprovalEntry.SETRANGE(Status, ApprovalEntry.Status::Approved);
                IF ApprovalEntry.FINDFIRST THEN begin
                    User.Reset();
                    User.SetRange("User Name", ApprovalEntry."Approver ID");
                    if User.FindFirst() then
                        Approvedby := User."Full Name";
                end;

                User.Reset();
                User.SetRange("User Security ID", "Purchase Header".SystemCreatedBy);
                if User.FindFirst() then
                    CreatedBy := User."Full Name";

                IF TermsConditionRec.GET("Purchase Header"."Terms Code") THEN;


                PaymentMethodRec.RESET;
                PaymentMethodRec.SETRANGE(Code, "Purchase Header"."Payment Method Code");
                IF PaymentMethodRec.FINDFIRST THEN
                    PaymentMethod1 := PaymentMethodRec.Description;

                CLEAR(Commnt1);
                PurchCommentLine.RESET;
                PurchCommentLine.SETRANGE("No.", "Purchase Header"."No.");
                PurchCommentLine.SETFILTER("Line No.", '%1', 10000);
                IF PurchCommentLine.FINDSET THEN
                    Commnt1 := '*' + PurchCommentLine.Comment;

                CLEAR(Commnt2);
                PurchCommentLine.RESET;
                PurchCommentLine.SETRANGE("No.", "Purchase Header"."No.");
                PurchCommentLine.SETFILTER("Line No.", '%1', 20000);
                IF PurchCommentLine.FINDSET THEN
                    Commnt2 := '*' + PurchCommentLine.Comment;

                CLEAR(Commnt3);
                PurchCommentLine.RESET;
                PurchCommentLine.SETRANGE("No.", "Purchase Header"."No.");
                PurchCommentLine.SETFILTER("Line No.", '%1', 30000);
                IF PurchCommentLine.FINDSET THEN
                    Commnt3 := '*' + PurchCommentLine.Comment;


                LocationRec.RESET;
                LocationRec.SETRANGE(Code, "Purchase Header"."Location Code");
                IF LocationRec.FINDFIRST THEN begin
                    //Name11:= LocationRec.Name;
                    Name11 := CompInfo.Name;
                    // if ((LocationRec.Code = 'SFPL0093') or (LocationRec.Code = 'SFPL0093-P')) then begin
                    //     recLOC.Reset();
                    //     recLOC.SetRange(Code, 'SFPL0137');
                    //     if recLOC.FindFirst() then begin
                    //         Add11 := recLOC.Name + ', ' + recLOC.Address + ', ' + recLOC."Address 2" + '-' + recLOC."Post Code";
                    //         State111 := recLOC."State Code";
                    //         Email11 := recLOC."E-Mail";
                    //         GSTNO := recLOC."GST Registration No.";
                    //         phone11 := recLOC."Phone No.";
                    //         contact11 := recLOC.Contact;
                    //     end;

                    // end else begin

                    Add11 := LocationRec.Name + ', ' + LocationRec.Address + ', ' + LocationRec."Address 2" + '-' + LocationRec."Post Code";
                    State111 := LocationRec."State Code";
                    Email11 := LocationRec."E-Mail";
                    GSTNO := LocationRec."GST Registration No.";
                    phone11 := LocationRec."Phone No.";
                    contact11 := LocationRec.Contact;

                    StateRec.RESET;
                    StateRec.SETRANGE(Code, State111);
                    IF StateRec.FINDFIRST THEN
                        State11 := StateRec.Description;
                    //end;
                    BillAdd11 := LocationRec.Name + ', ' + LocationRec.Address + ', ' + LocationRec."Address 2" + '-' + LocationRec."Post Code";
                    BillState111 := LocationRec."State Code";
                    BillEmail11 := LocationRec."E-Mail";
                    BillGSTNO := LocationRec."GST Registration No.";
                    Billphone11 := LocationRec."Phone No.";
                    Billcontact11 := LocationRec.Contact;

                    StateRec.RESET;
                    StateRec.SETRANGE(Code, BillState111);
                    IF StateRec.FINDFIRST THEN
                        BillState11 := StateRec.Description;
                end;



                // vendor.RESET;
                // vendor.SETRANGE("No.", "Purchase Header"."Pay-to Vendor No.");
                // IF vendor.FINDFIRST THEN;
                // //    CST := vendor.T
                // Suman 21062025
                if "Purchase Header"."Order Address Code" = '' Then begin

                    GST := "Purchase Header"."Vendor GST Reg. No.";

                end else begin
                    GST := "Purchase Header"."Order Address GST Reg. No.";

                end;
                // Suman 21062025
                vendor.Get("Purchase Header"."Pay-to Vendor No.");
                ConTactVendor := vendor.Contact;
                PhoneVendor := vendor."Phone No.";
                EmailVendor := vendor."E-Mail";
                if vendor."GST Vendor Type" = Enum::"GST Vendor Type"::Unregistered then begin
                    GST := vendor."P.A.N. No.";
                    "GST NO_Caption" := 'PAN No. :'
                end else
                    "GST NO_Caption" := 'GSTIN :';

                CreditDays := "Purchase Header"."Payment Terms Code";
                vendor.RESET;
                vendor.SETRANGE("No.", "Purchase Header"."Brokerage Code");
                IF vendor.FINDFIRST THEN
                    BrokerName := vendor.Name;


                PaymentRec.RESET;
                PaymentRec.SETRANGE(Code, CreditDays);
                IF PaymentRec.FINDFIRST THEN
                    CreditDays1 := PaymentRec.Description;

                StateRec.RESET;
                if "Order Address Code" = '' Then
                    StateRec.SETRANGE(Code, "Purchase Header".State)
                else
                    StateRec.SETRANGE(Code, "Purchase Header"."GST Order Address State");
                IF StateRec.FINDFIRST THEN
                    State1 := StateRec.Description;
                FormatAddr.Company(CompanyAddr, CompInfo);

                LocationRec.RESET;
                LocationRec.SETRANGE(Code, "Purchase Header"."Ship-to Code");
                IF LocationRec.FINDFIRST THEN
                    shipState := LocationRec."State Code";


                StateRec.RESET;
                StateRec.SETRANGE(Code, shipState);
                IF StateRec.FINDFIRST THEN
                    State2 := StateRec.Description;
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

                LineAmt1 := "Purchase Header".Amount + Round(GSTLineAMt);
                Check.InitTextVariable;
                Check.FormatNoText1(Word, "Purchase Header".Amount + Round(GSTLineAMt), "Purchase Header"."Currency Code");
                If "Purchase Header".Status in ["Purchase Header".Status::Released] Then
                    RecStatus := 1
                else
                    RecStatus := 2;


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

        // if Not CurrReport.Preview then
        //     Error('You can not print this report.');

        CompInfo.GET;
        CompInfo.CALCFIELDS(Picture);
        CompInfo.CalcFields(Watermark);


    end;

    var

        CreatedBy: Text;
        Approvedby: Code[20];
        ApprovalEntry: Record "Approval Entry";
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
        StateRec: Record State;
        Cond_Tc: Text;
        TermsConditionRec: Record 50010;
        IndentDate1: Date;
        IndentHeader: Record 50011;
        PaymentMethodRec: Record 289;
        PaymentMethod1: Text;
        BrokerName: Text;
        CreditDays1: Text;
        PaymentRec: Record 3;
        phone11: Text;
        contact11: Text;
        shipState: Text;
        State2: Text;
        PhoneVendor: Text;
        EmailVendor: Text;
        ConTactVendor: Text;
        GSTNO: Text;
        CreditDays: Text;
        ExtendedHeader: Record 279;
        ExtendedLine: Record 280;
        CompInfo: Record 79;
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
        "GST NO_Caption": Text;
        //"GST NO_Caption": Label 'GSTIN/PAN No. :';
        Phone_Caption: Label 'Person Ph No. :';
        Qty_Caption: Label 'Qty';
        Units_Caption: Label 'Units';
        HSNCode_Caption: Label 'HSN Code';
        ItemCode_Caption: Label 'Item Code';
        Description_Caption: Label 'Description';
        "BasicPriceRs/perKg_Caption": Label 'Rate (Per Item)';

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
        vendor: Record 23;
        CST: Text;
        GST: Text;
        PurchLineRec: Record 39;
        GSTamt: Decimal;
        FormatAddr: Codeunit 365;
        CompanyAddr: array[8] of Text;
        Discout_Cap: Label 'Discount';
        PackingFor_Cap: Label 'Packing/Forwarding Charges';
        INS_CAP: Label 'Insurance Charges';
        SGST_cap: Label 'SGST';
        CGST_CAP: Label 'CGST';
        IGST_CAP: Label 'IGST';
        GSTamt1: Decimal;
        //  PostStrOrdLineDet: Record 13794;
        FreightCharges: Decimal;
        OtherCharges: Decimal;
        InsCharges: Decimal;
        PackingCharges: Decimal;
        //StateRec: Record 13762;
        State1: Text;
        ItemRec: Record 27;
        ExtendedTexts: Text;
        LocationRec: Record 14;
        Name11: Text;
        Add11: Text;
        State11: Text;
        ContactPerson11: Text;
        PersonPh11: Decimal;
        Email11: Text;
        Check: Report 50101;
        Word: array[2] of Text;
        AmountInWordsCap: Label 'Amount In Words :';
        PurchaseLine: Record 39;
        lineAmount: Decimal;
        Commnt1: Text[100];
        Commnt2: Text[100];
        Commnt3: Text[100];
        PurchCommentLine: Record 43;
        PLRec1: Record "Purchase Line";
        TaxTransValue1: Record "Tax Transaction Value";
        TotalTax1: Decimal;
        SGST_Amt1: Decimal;
        TDSRat: Page "TDS Rates";
        SGST_perc1: Decimal;
        SGST_Amt2: Decimal;
        IGST_Amt2: Decimal;
        TaxComponentName1: Text;
        CGST_Amt1: Decimal;
        CGST_perc1: Decimal;
        IGST_Amt1: Decimal;
        CGST_Amt2: Decimal;
        IGST_perc1: Decimal;
        GSTSetup1: Record "GST Setup";
        CINNO: Code[10];
        TINNO_CompInfo: Code[10];
        PaytoAddress_PurchaseHeader: Text;
        PaytoAddress2_PurchaseHeader: Text;
        OrderAddress: Record "Order Address";
        recLOC: Record Location;
        BillAdd11: Text;
        BillState111: Text;
        BillEmail11: text;
        BillGSTNO: text;
        Billphone11: text;
        Billcontact11: text;
        BillState11: text;

}

