report 50062 "Purchase Self Invoice"
{
    UsageCategory = Administration;
    Caption = 'Purchase Self Invoice';
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'ReportLayout\PurchaseSelfInvoice.rdl';
    dataset
    {
        dataitem("Purch. Inv. Header"; "Purch. Inv. Header")
        {
            DataItemTableView = SORTING("No.")
                                WHERE("GST Vendor Type" = FILTER(Unregistered));
            RequestFilterFields = "No.", "Buy-from Vendor No.", "No. Printed";
            RequestFilterHeading = 'Posted Purchase Invoice';
            column(CGST; CGST)
            {
            }
            column(SGST; SGST)
            {
            }
            column(IGST; IGST)
            {
            }
            column(AmountInWord; AmtInword[1])
            {
            }
            column(VendorInvNo; "Purch. Inv. Header"."Vendor Invoice No.")
            {
            }
            column(address1; address1)
            {
            }
            column(City1; City1)
            {
            }
            column(country1; country1)
            {
            }
            column(Pincode1; Pincode1)
            {
            }
            column(Phone1; Phone1)
            {
            }
            column(GST1; GST1)
            {
            }
            column(No_PurchInvHeader; "No.")
            {
            }
            column(InvDiscountAmountCaption; InvDiscountAmountCaptionLbl)
            {
            }
            column(Narration; Narration)
            {
            }
            column(Picture; CompanyInfo.Picture)
            {
            }
            column(PayToName; "Purch. Inv. Header"."Pay-to Name")
            {
            }
            column(VendorAdrName; VendorAdr.Name)
            {
            }
            column(VendorAdrres; VendorAdr.Address + VendorAdr."Address 2")
            {
            }
            column(VendorAdrCity; VendorAdr.City)
            {
            }
            column(VendorAdrPS; VendorAdr."Post Code")
            {
            }
            column(VendorAdrST; VendorAdr."State Code")
            {
            }
            column(VendorAdrPhone; VendorAdr."Phone No.")
            {
            }
            //  column(AmounttoVendor_PurchInvHeader; "Purch. Inv. Header"."Amount to Vendor")  //PRU SH
            column(AmounttoVendor_PurchInvHeader; AmounttoVendor_PurchInvHeader) { }
            dataitem(CopyLoop; 2000000026)
            {
                DataItemTableView = SORTING(Number);
                dataitem(PageLoop; 2000000026)
                {
                    DataItemTableView = SORTING(Number)
                                        WHERE(Number = CONST(1));
                    column(Name; CompanyInfo.Name)
                    {
                    }
                    column(PaymentTermsDesc; PaymentTerms.Description)
                    {
                    }
                    column(ShipmentMethodDesc; ShipmentMethod.Description)
                    {
                    }
                    column(DocCaptionCopyText; STRSUBSTNO(DocumentCaption, CopyText))
                    {
                    }
                    column(VendAddr1; VendAddr[1])
                    {
                    }
                    column(CompanyAddr1; CompanyAddr[1])
                    {
                    }
                    column(VendAddr2; VendAddr[2])
                    {
                    }
                    column(CompanyAddr2; CompanyAddr[2])
                    {
                    }
                    column(VendAddr3; VendAddr[3])
                    {
                    }
                    column(CompanyAddr3; CompanyAddr[3])
                    {
                    }
                    column(VendAddr4; VendAddr[4])
                    {
                    }
                    column(CompanyAddr4; CompanyAddr[4])
                    {
                    }
                    column(VendAddr5; VendAddr[5])
                    {
                    }
                    column(CompanyInfoPhoneNo; CompanyInfo."Phone No.")
                    {
                    }
                    column(VendAddr6; VendAddr[6])
                    {
                    }
                    column(CompanyRegistrationLbl; CompanyRegistrationLbl)
                    {
                    }
                    column(CompanyInfo_GST_RegistrationNo; CompanyInfo."GST Registration No.")
                    {
                    }
                    column(VendorRegistrationLbl; VendorRegistrationLbl)
                    {
                    }
                    column(Vendor_GST_RegistrationNo; Vendor."GST Registration No.")
                    {
                    }
                    column(PhoneNo; CompanyInfo."Phone No.")
                    {
                    }
                    column(Address; CompanyInfo.Address + ' ' + CompanyInfo."Address 2")
                    {
                    }

                    column(CINNo; CINNo)
                    {
                    }

                    column(GSTRegNo; CompanyInfo."GST Registration No.")
                    {
                    }
                    column(CompanyInfoEMail; CompanyInfo."E-Mail")
                    {
                    }
                    column(CompanyInfoHomePage; CompanyInfo."Home Page")
                    {
                    }
                    column(CompanyInfoVATRegNo; CompanyInfo."VAT Registration No.")
                    {
                    }
                    column(CompanyInfoGiroNo; CompanyInfo."Giro No.")
                    {
                    }
                    column(CompanyInfoBankName; CompanyInfo."Bank Name")
                    {
                    }
                    column(CompanyInfoBankAccNo; CompanyInfo."Bank Account No.")
                    {
                    }
                    column(PayVendNo_PurchInvHeader; "Purch. Inv. Header"."Pay-to Vendor No.")
                    {
                    }
                    column(BuyfrVendNo_PurchInvHeaderCaption; "Purch. Inv. Header".FIELDCAPTION("Buy-from Vendor No."))
                    {
                    }
                    column(BuyfrVendNo_PurchInvHeader; "Purch. Inv. Header"."Buy-from Vendor No.")
                    {
                    }
                    column(DocDate_PurchInvHeader; FORMAT("Purch. Inv. Header"."Document Date", 0, 4))
                    {
                    }
                    column(VATNoText; VATNoText)
                    {
                    }
                    column(VATRegNo_PurchInvHeader; "Purch. Inv. Header"."VAT Registration No.")
                    {
                    }
                    column(DueDate_PurchInvHeader; FORMAT("Purch. Inv. Header"."Due Date"))
                    {
                    }
                    column(PurchaserText; PurchaserText)
                    {
                    }
                    column(SalesPurchPersonName; SalesPurchPerson.Name)
                    {
                    }
                    column(ReferenceText; ReferenceText)
                    {
                    }
                    column(YourRef_PurchInvHeader; "Purch. Inv. Header"."Your Reference")
                    {
                    }
                    column(OrderNoText; OrderNoText)
                    {
                    }
                    column(OrderNo_PurchInvHeader; "Purch. Inv. Header"."Order No.")
                    {
                    }
                    column(VendAddr7; VendAddr[7])
                    {
                    }
                    column(VendAddr8; VendAddr[8])
                    {
                    }
                    column(CompanyAddr5; CompanyAddr[5])
                    {
                    }
                    column(CompanyAddr6; CompanyAddr[6])
                    {
                    }
                    column(PostDate_PurchInvHeader; FORMAT("Purch. Inv. Header"."Posting Date"))
                    {
                    }
                    column(PricIncVAT_PurchInvHeader; "Purch. Inv. Header"."Prices Including VAT")
                    {
                    }
                    column(OutputNo; OutputNo)
                    {
                    }
                    column(ShowInternalInfo; ShowInternalInfo)
                    {
                    }
                    column(VATBasDisc_PurchInvHeader; "Purch. Inv. Header"."VAT Base Discount %")
                    {
                    }
                    column(PricesInclVATtxt; PricesInclVATtxt)
                    {
                    }
                    column(CompanyInfoPhoneNoCaption; CompanyInfoPhoneNoCaptionLbl)
                    {
                    }
                    column(CompanyInfoEMailCaption; CompanyInfoEMailCaptionLbl)
                    {
                    }
                    column(CompanyInfoHomePageCaption; CompanyInfoHomePageCaptionLbl)
                    {
                    }
                    column(CompanyInfoVATRegistrationNoCaption; CompanyInfoVATRegistrationNoCaptionLbl)
                    {
                    }
                    column(CompanyInfoGiroNoCaption; CompanyInfoGiroNoCaptionLbl)
                    {
                    }
                    column(CompanyInfoBankNameCaption; CompanyInfoBankNameCaptionLbl)
                    {
                    }
                    column(CompanyInfoBankAccountNoCaption; CompanyInfoBankAccountNoCaptionLbl)
                    {
                    }
                    column(PurchInvHeaderDueDateCaption; PurchInvHeaderDueDateCaptionLbl)
                    {
                    }
                    column(InvoiceNoCaption; InvoiceNoCaptionLbl)
                    {
                    }
                    column(PurchInvHeaderPostingDateCaption; PurchInvHeaderPostingDateCaptionLbl)
                    {
                    }
                    column(PageCaption; PageCaptionLbl)
                    {
                    }
                    column(PaymentTermsDescriptionCaption; PaymentTermsDescriptionCaptionLbl)
                    {
                    }
                    column(ShipmentMethodDescriptionCaption; ShipmentMethodDescriptionCaptionLbl)
                    {
                    }
                    column(VATAmountLineVATCaption; VATAmountLineVATCaptionLbl)
                    {
                    }
                    column(VATAmountLineVATBaseVTCCaption; VATAmountLineVATBaseVTCCaptionLbl)
                    {
                    }
                    column(VATAmtLineVATAmtVTCCaption; VATAmtLineVATAmtVTCCaptionLbl)
                    {
                    }
                    column(VATAmountSpecificationCaption; VATAmountSpecificationCaptionLbl)
                    {
                    }
                    column(VATAmtLineInvDiscBaseAmtVTCCaption; VATAmtLineInvDiscBaseAmtVTCCaptionLbl)
                    {
                    }
                    column(VATAmtLineLineAmtVTCCaption; VATAmtLineLineAmtVTCCaptionLbl)
                    {
                    }
                    column(VATAmountLineVATIdentifierCaption; VATAmountLineVATIdentifierCaptionLbl)
                    {
                    }
                    column(VATAmountLineVATBaseVTC1Caption; VATAmountLineVATBaseVTC1CaptionLbl)
                    {
                    }
                    column(DocumentDateCaption; DocumentDateCaptionLbl)
                    {
                    }
                    column(PayVendNo_PurchInvHeaderCaption; "Purch. Inv. Header".FIELDCAPTION("Pay-to Vendor No."))
                    {
                    }
                    column(PricIncVAT_PurchInvHeaderCaption; "Purch. Inv. Header".FIELDCAPTION("Prices Including VAT"))
                    {
                    }
                    dataitem("Purch. Comment Line"; "Purch. Comment Line")
                    {
                        DataItemLink = "No." = FIELD("No.");
                        DataItemLinkReference = "Purch. Inv. Header";
                        DataItemTableView = WHERE("Document Line No." = FILTER(0));
                        column(Comment_PurchCommentLine; "Purch. Comment Line".Comment)
                        {
                        }
                    }
                    dataitem(DimensionLoop1; 2000000026)
                    {
                        DataItemLinkReference = "Purch. Inv. Header";
                        DataItemTableView = SORTING(Number)
                                            WHERE(Number = FILTER(1 ..));
                        column(DimText; DimText)
                        {
                        }
                        column(HeaderDimensionsCaption; HeaderDimensionsCaptionLbl)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            IF Number = 1 THEN BEGIN
                                IF NOT DimSetEntry1.FINDFIRST THEN
                                    CurrReport.BREAK;
                            END ELSE
                                IF NOT Continue THEN
                                    CurrReport.BREAK;

                            CLEAR(DimText);
                            Continue := FALSE;
                            REPEAT
                                OldDimText := DimText;
                                IF DimText = '' THEN
                                    DimText := STRSUBSTNO(
                                      '%1 %2', DimSetEntry1."Dimension Code", DimSetEntry1."Dimension Value Code")
                                ELSE
                                    DimText :=
                                      STRSUBSTNO(
                                        '%1, %2 %3', DimText,
                                        DimSetEntry1."Dimension Code", DimSetEntry1."Dimension Value Code");
                                IF STRLEN(DimText) > MAXSTRLEN(OldDimText) THEN BEGIN
                                    DimText := OldDimText;
                                    Continue := TRUE;
                                    EXIT;
                                END;
                            UNTIL (DimSetEntry1.NEXT = 0);
                        end;

                        trigger OnPreDataItem()
                        begin
                            IF NOT ShowInternalInfo THEN
                                CurrReport.BREAK;
                        end;
                    }
                    dataitem("Purch. Inv. Line"; "Purch. Inv. Line")
                    {
                        DataItemLink = "Document No." = FIELD("No.");
                        DataItemLinkReference = "Purch. Inv. Header";
                        DataItemTableView = SORTING("Document No.", "Line No.");
                        column(Qty; "Purch. Inv. Line".Quantity)
                        {
                        }
                        column(HSN; "Purch. Inv. Line"."HSN/SAC Code")
                        {
                        }
                        column(UnitCost; "Purch. Inv. Line"."Unit Cost")
                        {
                        }
                        column(LineAmount; "Purch. Inv. Line"."Line Amount")
                        {
                        }
                        //  column(GSTPercent; "Purch. Inv. Line"."GST %")   //PRU SH
                        column(GSTPercent; GSTPercent) { }

                        column(SrNo; SrNo)
                        {
                        }
                        // column(SUMTDSAmt; "Purch. Inv. Line"."TDS Amount")  //PRU SH

                        column(GSTComponentCode1; GSTComponentCode[1] + ' Amount')
                        {
                        }
                        column(GSTComponentCode2; GSTComponentCode[2] + ' Amount')
                        {
                        }
                        column(GSTComponentCode3; GSTComponentCode[3] + ' Amount')
                        {
                        }
                        column(GSTComponentCode4; GSTComponentCode[4] + 'Amount')
                        {
                        }
                        column(GSTCompAmount1; ABS(GSTCompAmount[1]))
                        {
                        }
                        column(GSTCompAmount2; ABS(GSTCompAmount[2]))
                        {
                        }
                        column(GSTCompAmount3; ABS(GSTCompAmount[3]))
                        {
                        }
                        column(GSTCompAmount4; ABS(GSTCompAmount[4]))
                        {
                        }
                        column(IsGSTApplicable; IsGSTApplicable)
                        {
                        }
                        column(ServiceTaxAmt; ServiceTaxAmt)
                        {
                        }
                        column(ServiceTaxECessAmt; ServiceTaxECessAmt)
                        {
                        }
                        column(ServiceTaxSHECessAmt; ServiceTaxSHECessAmt)
                        {
                        }
                        column(ServiceTaxSBCAmount; ServiceTaxSBCAmount)
                        {
                        }
                        column(ApplServiceTaxSBCAmount; AppliedServiceTaxSBCAmount)
                        {
                        }
                        column(KKCessAmount; KKCessAmount)
                        {
                        }
                        column(AppliedKKCessAmount; AppliedKKCessAmount)
                        {
                        }
                        column(AppliedServTaxAmt; AppliedServiceTaxAmt)
                        {
                        }
                        column(ApplServTaxECessAmt; AppliedServiceTaxECessAmt)
                        {
                        }
                        column(ApplServTaxSHECessAmt; AppliedServiceTaxSHECessAmt)
                        {
                        }
                        column(LineAmt_PurchInvLine; "Line Amount")
                        {
                            AutoFormatExpression = "Purch. Inv. Line".GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(Desc_PurchInvLine; Description)
                        {
                        }
                        column(No_PurchInvLine; "No.")
                        {
                        }
                        column(No_PurchInvLineCaption; FIELDCAPTION("No."))
                        {
                        }
                        column(Quantity_PurchInvLine; Quantity)
                        {
                        }
                        column(UOM_PurchInvLine; "Unit of Measure")
                        {
                        }
                        column(DirectUnitCost_PurchInvLine; "Direct Unit Cost")
                        {
                            AutoFormatExpression = "Purch. Inv. Line".GetCurrencyCode;
                            AutoFormatType = 2;
                        }
                        column(LineDisc_PurchInvLine; "Line Discount %")
                        {
                        }
                        column(AllowInvDisc_PurchInvLine; "Allow Invoice Disc.")
                        {
                            IncludeCaption = false;
                        }
                        column(LineDiscAmt_PurchInvLine; "Line Discount Amount")
                        {
                        }
                        column(LineNo_PurchInvLine; "Purch. Inv. Line"."Line No.")
                        {
                        }
                        column(AllowVATDisctxt; AllowVATDisctxt)
                        {
                        }
                        column(PurchInLineTypeNo; PurchInLineTypeNo)
                        {
                        }
                        column(VATAmtText; VATAmountText)
                        {
                        }
                        column(SourceDocNo_PurchInvLine; "Source Document No.")
                        {
                        }
                        column(InvDiscAmt_PurchInvLine; -"Inv. Discount Amount")
                        {
                            AutoFormatExpression = "Purch. Inv. Line".GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(TotalText; TotalText)
                        {
                        }
                        column(Amt_PurchInvLine; Amount)
                        {
                            AutoFormatExpression = "Purch. Inv. Line".GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(TotalInclVATText; TotalInclVATText)
                        {
                        }
                        /*   //PRU SH
                        column(AmtToVend_PurchInvLine; "Amount To Vendor")
                        {
                            // AutoFormatExpression = "Purch. Inv. Line".GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(ExciseAmt_PurchInvLine; "Excise Amount")
                        {
                            //AutoFormatExpression = "Purch. Inv. Line".GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(TaxAmt_PurchInvLine; "Tax Amount")
                        {
                            //AutoFormatExpression = "Purch. Inv. Line".GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(TtlTDSIncSHECESS_PurchInvLine; -"Total TDS Including SHE CESS")
                        {
                            //AutoFormatExpression = "Purch. Inv. Line".GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                     
                        column(WorkTaxAmt_PurchInvLine; -"Work Tax Amount")
                        {
                            // AutoFormatExpression = "Purch. Inv. Line".GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                           */   //PRU SH
                        column(AmtToVend_PurchInvLine; AmtToVend_PurchInvLine)
                        {
                            // AutoFormatExpression = "Purch. Inv. Line".GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(ExciseAmt_PurchInvLine; ExciseAmt_PurchInvLine)
                        {
                            //AutoFormatExpression = "Purch. Inv. Line".GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(TaxAmt_PurchInvLine; TaxAmt_PurchInvLine)
                        {
                            //AutoFormatExpression = "Purch. Inv. Line".GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(TtlTDSIncSHECESS_PurchInvLine; TtlTDSIncSHECESS_PurchInvLine)
                        {
                            //AutoFormatExpression = "Purch. Inv. Line".GetCurrencyCode;
                            AutoFormatType = 1;
                        }

                        column(WorkTaxAmt_PurchInvLine; WorkTaxAmt_PurchInvLine)
                        {
                            // AutoFormatExpression = "Purch. Inv. Line".GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(OtherTaxesAmt; OtherTaxesAmount)
                        {
                            AutoFormatExpression = "Purch. Inv. Line".GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(ChargesAmt; ChargesAmount)
                        {
                            AutoFormatExpression = "Purch. Inv. Line".GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(AmtIncVATAmt_PurchInvLine; "Amount Including VAT" - Amount)
                        {
                            AutoFormatExpression = "Purch. Inv. Line".GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineVATAmtText; VATAmountLine.VATAmountText)
                        {
                        }
                        column(TotalExclVATText; TotalExclVATText)
                        {
                        }
                        column(TotalSubTotal; TotalSubTotal)
                        {
                            AutoFormatExpression = "Purch. Inv. Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalInvDiscAmt; TotalInvoiceDiscountAmount)
                        {
                            AutoFormatExpression = "Purch. Inv. Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalAmt; TotalAmount)
                        {
                            AutoFormatExpression = "Purch. Inv. Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalAmtInclVAT; TotalAmountInclVAT)
                        {
                            AutoFormatExpression = "Purch. Inv. Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalPaymentDiscOnVAT; TotalPaymentDiscountOnVAT)
                        {
                            AutoFormatType = 1;
                        }
                        column(DirectUnitCostCaption; DirectUnitCostCaptionLbl)
                        {
                        }
                        column(PurchInvLineLineDiscountCaption; PurchInvLineLineDiscountCaptionLbl)
                        {
                        }
                        column(AmountCaption; AmountCaptionLbl)
                        {
                        }
                        column(SubtotalCaption; SubtotalCaptionLbl)
                        {
                        }
                        column(PurchInvLineExciseAmountCaption; PurchInvLineExciseAmountCaptionLbl)
                        {
                        }
                        column(PurchInvLineTaxAmountCaption; PurchInvLineTaxAmountCaptionLbl)
                        {
                        }
                        column(ServiceTaxAmountCaption; ServiceTaxAmountCaptionLbl)
                        {
                        }
                        column(TotalTDSIncludingSHECESSCaption; TotalTDSIncludingSHECESSCaptionLbl)
                        {
                        }
                        column(WorkTaxAmountCaption; WorkTaxAmountCaptionLbl)
                        {
                        }
                        column(OtherTaxesAmountCaption; OtherTaxesAmountCaptionLbl)
                        {
                        }
                        column(ChargesAmountCaption; ChargesAmountCaptionLbl)
                        {
                        }
                        column(ServiceTaxeCessAmountCaption; ServiceTaxeCessAmountCaptionLbl)
                        {
                        }
                        column(SvcTaxAmtAppliedCaption; SvcTaxAmtAppliedCaptionLbl)
                        {
                        }
                        column(SvcTaxeCessAmtAppliedCaption; SvcTaxeCessAmtAppliedCaptionLbl)
                        {
                        }
                        column(ServiceTaxSHECessAmountCaption; ServiceTaxSHECessAmountCaptionLbl)
                        {
                        }
                        column(LineAmtInvDiscountAmtAmtInclVATCaption; LineAmtInvDiscountAmtAmtInclVATCaptionLbl)
                        {
                        }
                        column(AllowInvDiscountCaption; AllowInvDiscountCaptionLbl)
                        {
                        }
                        column(Desc_PurchInvLineCaption; FIELDCAPTION(Description))
                        {
                        }
                        column(Quantity_PurchInvLineCaption; FIELDCAPTION(Quantity))
                        {
                        }
                        column(UOM_PurchInvLineCaption; FIELDCAPTION("Unit of Measure"))
                        {
                        }
                        column(LineDiscAmt_PurchInvLineCaption; FIELDCAPTION("Line Discount Amount"))
                        {
                        }
                        column(ServTaxSBCAmtCaption; ServTaxSBCAmtCaptionLbl)
                        {
                        }
                        column(SvcTaxSBCAmtAppliedCaption; SvcTaxSBCAmtAppliedCaptionLbl)
                        {
                        }
                        column(KKCessAmtCaption; KKCessAmtCaptionLbl)
                        {
                        }
                        column(KKCessAmtAppliedCaption; KKCessAmtAppliedCaptionLbl)
                        {
                        }
                        dataitem(DimensionLoop2; 2000000026)
                        {
                            DataItemTableView = SORTING(Number)
                                                WHERE(Number = FILTER(1 ..));
                            column(DimText1; DimText)
                            {
                            }
                            column(LineDimensionsCaption; LineDimensionsCaptionLbl)
                            {
                            }

                            trigger OnAfterGetRecord()
                            begin
                                IF Number = 1 THEN BEGIN
                                    IF NOT DimSetEntry2.FINDFIRST THEN
                                        CurrReport.BREAK;
                                END ELSE
                                    IF NOT Continue THEN
                                        CurrReport.BREAK;

                                CLEAR(DimText);
                                Continue := FALSE;
                                REPEAT
                                    OldDimText := DimText;
                                    IF DimText = '' THEN
                                        DimText := STRSUBSTNO(
                                          '%1 %2', DimSetEntry2."Dimension Code", DimSetEntry2."Dimension Value Code")
                                    ELSE
                                        DimText :=
                                          STRSUBSTNO(
                                            '%1, %2 %3', DimText,
                                            DimSetEntry2."Dimension Code", DimSetEntry2."Dimension Value Code");
                                    IF STRLEN(DimText) > MAXSTRLEN(OldDimText) THEN BEGIN
                                        DimText := OldDimText;
                                        Continue := TRUE;
                                        EXIT;
                                    END;
                                UNTIL (DimSetEntry2.NEXT = 0);
                            end;

                            trigger OnPreDataItem()
                            begin
                                IF NOT ShowInternalInfo THEN
                                    CurrReport.BREAK;

                                DimSetEntry2.SETRANGE("Dimension Set ID", "Purch. Inv. Line"."Dimension Set ID");
                            end;
                        }

                        trigger OnAfterGetRecord()
                        var
                        // StructureLineDetails: Record 13798;   //PRU SH
                        begin
                            IF "Purch. Inv. Line"."No." = '' THEN
                                CurrReport.SKIP;
                            SrNo += 1;
                            IF (Type = Type::"G/L Account") AND (NOT ShowInternalInfo) THEN
                                "No." := '';

                            VATAmountLine.INIT;
                            VATAmountLine."VAT Identifier" := "Purch. Inv. Line"."VAT Identifier";
                            VATAmountLine."VAT Calculation Type" := "VAT Calculation Type";
                            VATAmountLine."Tax Group Code" := "Tax Group Code";
                            VATAmountLine."Use Tax" := "Use Tax";
                            VATAmountLine."VAT %" := "VAT %";
                            VATAmountLine."VAT Base" := Amount;
                            VATAmountLine."Amount Including VAT" := "Amount Including VAT";
                            VATAmountLine."Line Amount" := "Line Amount";
                            IF "Allow Invoice Disc." THEN
                                VATAmountLine."Inv. Disc. Base Amount" := "Line Amount";
                            VATAmountLine."Invoice Discount Amount" := "Inv. Discount Amount";
                            VATAmountLine.InsertLine;

                            ////////// calculate gst amt

                            IGST_perc := 0;
                            IGST_Amt := 0;
                            CGST_perc := 0;
                            CGST_Amt := 0;
                            SGST_perc := 0;
                            SGST_Amt := 0;
                            DetailedGSTLedgerEntry.RESET;
                            DetailedGSTLedgerEntry.SETRANGE("Document Line No.", "Purch. Inv. Line"."Line No.");
                            DetailedGSTLedgerEntry.SETRANGE("Document No.", "Purch. Inv. Line"."Document No.");
                            DetailedGSTLedgerEntry.SETRANGE("No.", "Purch. Inv. Line"."No.");
                            IF DetailedGSTLedgerEntry.FINDSET THEN
                                REPEAT
                                    IF DetailedGSTLedgerEntry."GST Component Code" = 'IGST' THEN BEGIN
                                        IGST_perc := DetailedGSTLedgerEntry."GST %";
                                        IGST_Amt += ABS(DetailedGSTLedgerEntry."GST Amount");

                                    END;
                                    IF DetailedGSTLedgerEntry."GST Component Code" = 'SGST' THEN BEGIN
                                        SGST_perc := DetailedGSTLedgerEntry."GST %";
                                        SGST_Amt += ABS(DetailedGSTLedgerEntry."GST Amount");
                                    END;
                                    IF DetailedGSTLedgerEntry."GST Component Code" = 'CGST' THEN BEGIN
                                        CGST_perc := DetailedGSTLedgerEntry."GST %";
                                        CGST_Amt += ABS(DetailedGSTLedgerEntry."GST Amount");
                                    END;
                                UNTIL DetailedGSTLedgerEntry.NEXT = 0;



                            /// ///// calculate gst amt


                            /*  //PRU SH
                                                        IF IsGSTApplicable AND (Type <> Type::" ") THEN BEGIN
                                                            j := 1;
                                                            GSTComponent.RESET;
                                                            GSTComponent.SETRANGE("GST Jurisdiction Type", "GST Jurisdiction Type");
                                                            IF GSTComponent.FINDSET THEN
                                                                REPEAT
                                                                    GSTComponentCode[j] := GSTComponent.Code;
                                                                    DetailedGSTLedgerEntry.RESET;
                                                                    DetailedGSTLedgerEntry.SETCURRENTKEY("Transaction Type", "Document Type", "Document No.", "Document Line No.");
                                                                    DetailedGSTLedgerEntry.SETRANGE("Transaction Type", DetailedGSTLedgerEntry."Transaction Type"::Purchase);
                                                                    DetailedGSTLedgerEntry.SETRANGE("Entry Type", DetailedGSTLedgerEntry."Entry Type"::"Initial Entry"); // PRU_AS : 21 MAY 2019
                                                                    DetailedGSTLedgerEntry.SETRANGE("Document No.", "Document No.");
                                                                    DetailedGSTLedgerEntry.SETRANGE("Document Line No.", "Line No.");
                                                                    DetailedGSTLedgerEntry.SETRANGE("GST Component Code", GSTComponentCode[j]);
                                                                    IF DetailedGSTLedgerEntry.FINDSET THEN BEGIN
                                                                        REPEAT
                                                                            GSTCompAmount[j] +=
                                                                              CurrExchRate.ExchangeAmtLCYToFCY(
                                                                                DetailedGSTLedgerEntry."Posting Date", DetailedGSTLedgerEntry."Currency Code",
                                                                                DetailedGSTLedgerEntry."GST Amount", DetailedGSTLedgerEntry."Currency Factor");
                                                                        UNTIL DetailedGSTLedgerEntry.NEXT = 0;
                                                                        j += 1;
                                                                    END;
                                                                UNTIL GSTComponent.NEXT = 0;

                                                        END;
                                                        */  //PRU SH
                                                            /*   //PRU SH
                                                                                        StructureLineDetails.RESET;
                                                                                        StructureLineDetails.SETRANGE(Type, StructureLineDetails.Type::Purchase);
                                                                                        StructureLineDetails.SETRANGE("Document Type", StructureLineDetails."Document Type"::Invoice);
                                                                                        StructureLineDetails.SETRANGE("Invoice No.", "Document No.");
                                                                                        StructureLineDetails.SETRANGE("Item No.", "No.");
                                                                                        StructureLineDetails.SETRANGE("Line No.", "Line No.");
                                                                                        IF StructureLineDetails.FIND('-') THEN
                                                                                            REPEAT
                                                                                                IF NOT StructureLineDetails."Payable to Third Party" THEN BEGIN
                                                                                                    IF StructureLineDetails."Tax/Charge Type" = StructureLineDetails."Tax/Charge Type"::Charges THEN
                                                                                                        ChargesAmount := ChargesAmount + ROUND(StructureLineDetails.Amount);
                                                                                                    IF StructureLineDetails."Tax/Charge Type" = StructureLineDetails."Tax/Charge Type"::"Other Taxes" THEN
                                                                                                        OtherTaxesAmount := OtherTaxesAmount + ROUND(StructureLineDetails.Amount);
                                                                                                END;
                                                                                            UNTIL StructureLineDetails.NEXT = 0;
                                                                                        // SUMTDSAmt := SUMTDSAmt + "Purch. Inv. Line"."TDS Amount"; //PRU_DD COMMENTED BY PRU_AS

                                                                                        SumServiceTaxAmt := SumServiceTaxAmt + "Service Tax Amount";
                                                                                        SumServiceTaxECessAmt := SumServiceTaxECessAmt + "Service Tax eCess Amount";
                                                                                        SumServiceTaxSHECessAmt := SumServiceTaxSHECessAmt + "Service Tax SHE Cess Amount";
                                                                                        SumServiceTaxSBCAmount := SumServiceTaxSBCAmount + "Service Tax SBC Amount";
                                                                                        SumKKCessAmount := SumKKCessAmount + "KK Cess Amount";
                                                                                        AllowVATDisctxt := FORMAT("Purch. Inv. Line"."Allow Invoice Disc.");

                                                                                        SUMTDSAmt += SUMTDSAmt + "Purch. Inv. Line"."TDS Amount"; // PRU_AS 21 MAY 2019
                                                                                        PurchInLineTypeNo := "Purch. Inv. Line".Type;
                                                                                        IF "Purch. Inv. Header"."Transaction No. Serv. Tax" <> 0 THEN BEGIN
                                                                                            ServiceTaxEntry.RESET;
                                                                                            ServiceTaxEntry.SETRANGE(Type, ServiceTaxEntry.Type::Purchase);
                                                                                            ServiceTaxEntry.SETRANGE("Document Type", ServiceTaxEntry."Document Type"::Invoice);
                                                                                            ServiceTaxEntry.SETRANGE("Document No.", "Purch. Inv. Header"."No.");
                                                                                            IF ServiceTaxEntry.FINDFIRST THEN BEGIN
                                                                                                ServiceTaxAmt := ABS(ServiceTaxEntry."Service Tax Amount");
                                                                                                ServiceTaxECessAmt := ABS(ServiceTaxEntry."eCess Amount");
                                                                                                ServiceTaxSHECessAmt := ABS(ServiceTaxEntry."SHE Cess Amount");
                                                                                                ServiceTaxSBCAmount := ABS(ServiceTaxEntry."Service Tax SBC Amount");
                                                                                                KKCessAmount := ABS(ServiceTaxEntry."KK Cess Amount");
                                                                                                AppliedServiceTaxAmt := SumServiceTaxAmt - ABS(ServiceTaxEntry."Service Tax Amount");
                                                                                                AppliedServiceTaxECessAmt := SumServiceTaxECessAmt - ABS(ServiceTaxEntry."eCess Amount");
                                                                                                AppliedServiceTaxSHECessAmt := SumServiceTaxSHECessAmt - ABS(ServiceTaxEntry."SHE Cess Amount");
                                                                                                AppliedServiceTaxSBCAmount := SumServiceTaxSBCAmount - ABS(ServiceTaxEntry."Service Tax SBC Amount");
                                                                                                AppliedKKCessAmount := SumKKCessAmount - ABS(ServiceTaxEntry."KK Cess Amount");
                                                                                            END ELSE BEGIN
                                                                                                AppliedServiceTaxAmt := "Service Tax Amount";
                                                                                                AppliedServiceTaxECessAmt := "Service Tax eCess Amount";
                                                                                                AppliedServiceTaxSHECessAmt := "Service Tax SHE Cess Amount";
                                                                                                AppliedServiceTaxSBCAmount := "Service Tax SBC Amount";
                                                                                                AppliedKKCessAmount := "KK Cess Amount";
                                                                                            END;
                                                                                        END ELSE BEGIN
                                                                                            ServiceTaxAmt := "Service Tax Amount";
                                                                                            ServiceTaxECessAmt := "Service Tax eCess Amount";
                                                                                            ServiceTaxSHECessAmt := "Service Tax SHE Cess Amount";
                                                                                            ServiceTaxSBCAmount := "Service Tax SBC Amount";
                                                                                            KKCessAmount := "KK Cess Amount";
                                                                                        END;
                                                            */    //PRU SH
                            TotalSubTotal += "Line Amount";
                            TotalInvoiceDiscountAmount -= "Inv. Discount Amount";
                            TotalAmount += Amount;
                            TotalAmountVAT += "Amount Including VAT" - Amount;
                            TotalAmountInclVAT += "Amount";
                            TotalPaymentDiscountOnVAT += -("Line Amount" - "Inv. Discount Amount" - "Amount Including VAT");
                        end;

                        trigger OnPreDataItem()
                        var
                            PurchInvLine: Record 123;
                            VATIdentifier: Code[10];
                        begin

                            VATAmountLine.DELETEALL;
                            MoreLines := FIND('+');
                            WHILE MoreLines AND (Description = '') AND ("No." = '') AND (Quantity = 0) AND (Amount = 0) DO
                                MoreLines := NEXT(-1) <> 0;
                            IF NOT MoreLines THEN
                                CurrReport.BREAK;
                            SETRANGE("Line No.", 0, "Line No.");
                            // CurrReport.CREATETOTALS("Line Amount", "Inv. Discount Amount", Amount, "Amount Including VAT", "Excise Amount", "Tax Amount",  //PRU SH
                            //"Service Tax Amount", "Service Tax eCess Amount");   //PRU SH
                            //CurrReport.CREATETOTALS("Total TDS Including SHE CESS", "Work Tax Amount", "Amount To Vendor", "Service Tax SHE Cess Amount");  //PRU SH

                            PurchInvLine.SETRANGE("Document No.", "Purch. Inv. Header"."No.");
                            PurchInvLine.SETFILTER(Type, '<>%1', 0);
                            VATAmountText := '';
                            IF PurchInvLine.FIND('-') THEN BEGIN
                                VATAmountText := STRSUBSTNO(Text011, PurchInvLine."VAT %");
                                VATIdentifier := PurchInvLine."VAT Identifier";
                                REPEAT
                                    IF (PurchInvLine."VAT Identifier" <> VATIdentifier) AND (PurchInvLine.Quantity <> 0) THEN
                                        VATAmountText := Text012;
                                UNTIL PurchInvLine.NEXT = 0;
                            END;
                            i := COUNT;
                            SumServiceTaxAmt := 0;
                            SumServiceTaxECessAmt := 0;
                            SumServiceTaxSHECessAmt := 0;
                            SumServiceTaxSBCAmount := 0;
                            SumKKCessAmount := 0;
                            CLEAR(GSTCompAmount); // PRU_AS 20 MAY 2019
                            //SUMTDSAmt:=0; // commented by PRU_AS 21 MAY 2019
                            CLEAR(SUMTDSAmt); // PRU_AS 21 MAY 2019
                            SrNo := 0;
                        end;
                    }
                    dataitem(VATCounter; 2000000026)
                    {
                        DataItemTableView = SORTING(Number);
                        column(VATAmtLineVATBase; VATAmountLine."VAT Base")
                        {
                            AutoFormatExpression = "Purch. Inv. Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineVATAmt; VATAmountLine."VAT Amount")
                        {
                            AutoFormatExpression = "Purch. Inv. Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineLineAmt; VATAmountLine."Line Amount")
                        {
                            AutoFormatExpression = "Purch. Inv. Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineInvDiscBaseAmt; VATAmountLine."Inv. Disc. Base Amount")
                        {
                            AutoFormatExpression = "Purch. Inv. Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineInvDiscAmt; VATAmountLine."Invoice Discount Amount")
                        {
                            AutoFormatExpression = "Purch. Inv. Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineVAT; VATAmountLine."VAT %")
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(VATAmtLineVATIdentifier; VATAmountLine."VAT Identifier")
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            VATAmountLine.GetLine(Number);
                        end;

                        trigger OnPreDataItem()
                        begin
                            SETRANGE(Number, 1, VATAmountLine.COUNT);
                            CurrReport.CREATETOTALS(
                              VATAmountLine."Line Amount", VATAmountLine."Inv. Disc. Base Amount",
                              VATAmountLine."Invoice Discount Amount", VATAmountLine."VAT Base", VATAmountLine."VAT Amount");
                        end;
                    }
                    dataitem(VATCounterLCY; 2000000026)
                    {
                        DataItemTableView = SORTING(Number);
                        column(VALExchRate; VALExchRate)
                        {
                        }
                        column(VALSpecLCYHeader; VALSpecLCYHeader)
                        {
                        }
                        column(VALVATAmtLCY; VALVATAmountLCY)
                        {
                            AutoFormatType = 1;
                        }
                        column(VALVATBaseLCY; VALVATBaseLCY)
                        {
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineVAT1; VATAmountLine."VAT %")
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(VATAmtLineVATIdentifier1; VATAmountLine."VAT Identifier")
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            VATAmountLine.GetLine(Number);
                            VALVATBaseLCY :=
                              VATAmountLine.GetBaseLCY(
                                "Purch. Inv. Header"."Posting Date", "Purch. Inv. Header"."Currency Code",
                                "Purch. Inv. Header"."Currency Factor");
                            VALVATAmountLCY :=
                              VATAmountLine.GetAmountLCY(
                                "Purch. Inv. Header"."Posting Date", "Purch. Inv. Header"."Currency Code",
                                "Purch. Inv. Header"."Currency Factor");
                        end;

                        trigger OnPreDataItem()
                        begin
                            IF (NOT GLSetup."Print VAT specification in LCY") OR
                               ("Purch. Inv. Header"."Currency Code" = '')
                            THEN
                                CurrReport.BREAK;

                            SETRANGE(Number, 1, VATAmountLine.COUNT);
                            CurrReport.CREATETOTALS(VALVATBaseLCY, VALVATAmountLCY);

                            IF GLSetup."LCY Code" = '' THEN
                                VALSpecLCYHeader := Text007 + Text008
                            ELSE
                                VALSpecLCYHeader := Text007 + FORMAT(GLSetup."LCY Code");

                            CurrExchRate.FindCurrency("Purch. Inv. Header"."Posting Date", "Purch. Inv. Header"."Currency Code", 1);
                            CalculatedExchRate := ROUND(1 / "Purch. Inv. Header"."Currency Factor" * CurrExchRate."Exchange Rate Amount", 0.000001);
                            VALExchRate := STRSUBSTNO(Text009, CalculatedExchRate, CurrExchRate."Exchange Rate Amount");
                        end;
                    }
                    dataitem(Total; 2000000026)
                    {
                        DataItemTableView = SORTING(Number)
                                            WHERE(Number = CONST(1));
                    }
                    dataitem(Total2; 2000000026)
                    {
                        DataItemTableView = SORTING(Number)
                                            WHERE(Number = CONST(1));

                        trigger OnPreDataItem()
                        begin
                            IF "Purch. Inv. Header"."Buy-from Vendor No." = "Purch. Inv. Header"."Pay-to Vendor No." THEN
                                CurrReport.BREAK;
                        end;
                    }
                    dataitem(Total3; 2000000026)
                    {
                        DataItemTableView = SORTING(Number)
                                            WHERE(Number = CONST(1));
                        column(ShipToAddr1; ShipToAddr[1])
                        {
                        }
                        column(ShipToAddr2; ShipToAddr[2])
                        {
                        }
                        column(ShipToAddr3; ShipToAddr[3])
                        {
                        }
                        column(ShipToAddr4; ShipToAddr[4])
                        {
                        }
                        column(ShipToAddr5; ShipToAddr[5])
                        {
                        }
                        column(ShipToAddr6; ShipToAddr[6])
                        {
                        }
                        column(ShipToAddr7; ShipToAddr[7])
                        {
                        }
                        column(ShipToAddr8; ShipToAddr[8])
                        {
                        }
                        column(ShiptoAddressCaption; ShiptoAddressCaptionLbl)
                        {
                        }

                        trigger OnPreDataItem()
                        begin
                            IF ShipToAddr[1] = '' THEN
                                CurrReport.BREAK;
                        end;
                    }

                    trigger OnAfterGetRecord()
                    begin
                        CompanyInfo.GET;
                        CompanyInfo.CALCFIELDS(Picture);
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    IF Number > 1 THEN BEGIN
                        OutputNo := OutputNo + 1;
                        CopyText := Text003;
                    END;
                    CurrReport.PAGENO := 1;

                    TotalSubTotal := 0;
                    TotalInvoiceDiscountAmount := 0;
                    TotalAmount := 0;
                    TotalAmountVAT := 0;
                    TotalAmountInclVAT := 0;
                    TotalPaymentDiscountOnVAT := 0;

                    ServiceTaxSHECessAmt := 0;
                    ServiceTaxECessAmt := 0;
                    ServiceTaxAmt := 0;
                    ServiceTaxSBCAmount := 0;
                    KKCessAmount := 0;
                    AppliedServiceTaxSHECessAmt := 0;
                    AppliedServiceTaxECessAmt := 0;
                    AppliedServiceTaxAmt := 0;
                    AppliedServiceTaxSBCAmount := 0;
                    AppliedKKCessAmount := 0;
                    ChargesAmount := 0;
                    OtherTaxesAmount := 0;
                end;

                trigger OnPostDataItem()
                begin
                    IF NOT CurrReport.PREVIEW THEN
                        PurchInvCountPrinted.RUN("Purch. Inv. Header");
                end;

                trigger OnPreDataItem()
                begin
                    OutputNo := 1;
                    NoOfLoops := ABS(NoOfCopies) + 1;
                    CopyText := '';
                    SETRANGE(Number, 1, NoOfLoops);
                end;
            }

            trigger OnAfterGetRecord()
            var
                PurchInvLine: Record 123;
            begin
                Vendor.RESET;
                IF VendorAdr.GET("Purch. Inv. Header"."Buy-from Vendor No.") THEN;
                "Purch. Inv. Header".CALCFIELDS("Amount");
                //MESSAGE('%1',"Purch. Inv. Header"."Amount to Vendor");

                PurchCommnt.RESET;
                PurchCommnt.SETRANGE("No.", "Purch. Inv. Header"."No.");
                IF PurchCommnt.FINDFIRST THEN
                    REPEAT
                        Narration := PurchCommnt.Comment;
                    UNTIL PurchCommnt.NEXT = 0;


                //    CurrReport.LANGUAGE := Language.GetLanguageID("Language Code");  //PRU SH


                // IsGSTApplicable := GSTManagement.IsGSTApplicable(Structure);  //PRU SH
                Vendor.GET("Buy-from Vendor No.");

                IF RespCenter.GET("Responsibility Center") THEN BEGIN
                    FormatAddr.RespCenter(CompanyAddr, RespCenter);
                    CompanyInfo."Phone No." := RespCenter."Phone No.";
                    CompanyInfo."Fax No." := RespCenter."Fax No.";
                END ELSE
                    FormatAddr.Company(CompanyAddr, CompanyInfo);

                DimSetEntry1.SETRANGE("Dimension Set ID", "Purch. Inv. Header"."Dimension Set ID");

                IF "Order No." = '' THEN
                    OrderNoText := ''
                ELSE
                    OrderNoText := FIELDCAPTION("Order No.");
                IF "Purchaser Code" = '' THEN BEGIN
                    CLEAR(SalesPurchPerson);
                    PurchaserText := '';
                END ELSE BEGIN
                    SalesPurchPerson.GET("Purchaser Code");
                    PurchaserText := Text000
                END;
                IF "Your Reference" = '' THEN
                    ReferenceText := ''
                ELSE
                    ReferenceText := FIELDCAPTION("Your Reference");
                IF "VAT Registration No." = '' THEN
                    VATNoText := ''
                ELSE
                    VATNoText := FIELDCAPTION("VAT Registration No.");
                IF "Currency Code" = '' THEN BEGIN
                    GLSetup.TESTFIELD("LCY Code");
                    TotalText := STRSUBSTNO(Text001, GLSetup."LCY Code");
                    TotalInclVATText := STRSUBSTNO(Text13700, GLSetup."LCY Code");
                    TotalExclVATText := STRSUBSTNO(Text13701, GLSetup."LCY Code");
                END ELSE BEGIN
                    TotalText := STRSUBSTNO(Text001, "Currency Code");
                    TotalInclVATText := STRSUBSTNO(Text13700, "Currency Code");
                    TotalExclVATText := STRSUBSTNO(Text13701, "Currency Code");
                END;
                FormatAddr.PurchInvPayTo(VendAddr, "Purch. Inv. Header");
                IF "Payment Terms Code" = '' THEN
                    PaymentTerms.INIT
                ELSE BEGIN
                    PaymentTerms.GET("Payment Terms Code");
                    PaymentTerms.TranslateDescription(PaymentTerms, "Language Code");
                END;
                IF "Shipment Method Code" = '' THEN
                    ShipmentMethod.INIT
                ELSE BEGIN
                    ShipmentMethod.GET("Shipment Method Code");
                    ShipmentMethod.TranslateDescription(ShipmentMethod, "Language Code");
                END;

                FormatAddr.PurchInvShipTo(ShipToAddr, "Purch. Inv. Header");

                IF LogInteraction THEN
                    IF NOT CurrReport.PREVIEW THEN
                        SegManagement.LogDocument(
                          14, "No.", 0, 0, DATABASE::Vendor, "Buy-from Vendor No.", "Purchaser Code", '', "Posting Description", '');
                SupplementaryText := '';
                PurchInvLine.SETRANGE("Document No.", "No.");
                PurchInvLine.SETRANGE(Supplementary, TRUE);
                IF PurchInvLine.FINDFIRST THEN
                    SupplementaryText := Text16500;

                PricesInclVATtxt := FORMAT("Purch. Inv. Header"."Prices Including VAT");


                LocationRec.RESET;
                LocationRec.SETRANGE(Code, "Purch. Inv. Header"."Location Code");
                IF LocationRec.FINDFIRST THEN
                    address1 := LocationRec.Address + ' ' + LocationRec."Address 2";
                City1 := LocationRec.City;
                Pincode1 := LocationRec."Post Code";
                country1 := LocationRec.County;
                Phone1 := LocationRec."Phone No.";
                GST1 := LocationRec."GST Registration No.";
                CGST := 0;
                SGST := 0;
                IGST := 0;
                DetailedGSTLedgerEntry.RESET;
                //DetailedGSTLedgerEntry.SETCURRENTKEY("Transaction Type","Document Type","Document No.","Document Line No.");
                DetailedGSTLedgerEntry.SETRANGE("Transaction Type", DetailedGSTLedgerEntry."Transaction Type"::Purchase);
                DetailedGSTLedgerEntry.SETRANGE("Entry Type", DetailedGSTLedgerEntry."Entry Type"::"Initial Entry"); // PRU_AS : 21 MAY 2019
                DetailedGSTLedgerEntry.SETRANGE(DetailedGSTLedgerEntry."Document No.", "Purch. Inv. Header"."No.");
                IF DetailedGSTLedgerEntry.FINDSET THEN
                    REPEAT
                        IF DetailedGSTLedgerEntry."GST Component Code" = 'CGST' THEN
                            CGST += DetailedGSTLedgerEntry."GST Amount";
                        IF DetailedGSTLedgerEntry."GST Component Code" = 'SGST' THEN
                            SGST += DetailedGSTLedgerEntry."GST Amount";
                        IF DetailedGSTLedgerEntry."GST Component Code" = 'IGST' THEN
                            IGST += DetailedGSTLedgerEntry."GST Amount";
                    UNTIL DetailedGSTLedgerEntry.NEXT = 0;
                Check.InitTextVariable;
                Check.FormatNoText(AmtInword, "Purch. Inv. Header"."Amount", '');
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
                    field(NoOfCopies; NoOfCopies)
                    {
                        Caption = 'No. of Copies';
                        ApplicationArea = All;
                    }
                    field(ShowInternalInfo; ShowInternalInfo)
                    {
                        Caption = 'Show Internal Information';
                        ApplicationArea = All;
                    }
                    field(LogInteraction; LogInteraction)
                    {
                        Caption = 'Log Interaction';
                        Enabled = LogInteractionEnable;
                        ApplicationArea = All;
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnInit()
        begin
            LogInteractionEnable := TRUE;
        end;

        trigger OnOpenPage()
        begin
            LogInteraction := SegManagement.FindInteractTmplCode(14) <> '';
            LogInteractionEnable := LogInteraction;
        end;
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        GLSetup.GET;
    end;

    trigger OnPreReport()
    begin
        CompanyInfo.GET;
        CompanyInfo.CALCFIELDS(Picture);
    end;

    var
        IGST_perc: Decimal;
        IGST_Amt: Decimal;
        CGST_perc: Decimal;
        CGST_Amt: Decimal;
        SGST_perc: Decimal;
        SGST_Amt: Decimal;
        Text000: Label 'Purchaser';
        Text001: Label 'Total %1';
        Text003: Label 'COPY';
        Text004: Label 'Purchase - Invoice %1';
        SUMTDSAmt: Decimal;
        CINNo: Code[20];
        GST1: Text;
        Phone1: Text;
        PurchCommnt: Record 43;
        Narration: Text;
        address1: Text;
        City1: Text;
        country1: Text;
        Pincode1: Text;
        LocationRec: Record 14;
        GLSetup: Record 98;
        CompanyInfo: Record 79;
        ShipmentMethod: Record 10;
        PaymentTerms: Record 3;
        SalesPurchPerson: Record 13;
        VATAmountLine: Record 290 temporary;
        DimSetEntry1: Record 480;
        DimSetEntry2: Record 480;
        RespCenter: Record 5714;
        Language: Record 8;
        CurrExchRate: Record 330;
        //   GSTComponent: Record 16405;  //PRU SH
        DetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry";//16419;
        Vendor: Record 23;
        PurchInvCountPrinted: Codeunit 319;
        FormatAddr: Codeunit 365;
        SegManagement: Codeunit 5051;
        // GSTManagement: Codeunit 16401;  //PRU SH
        GSTCompAmount: array[20] of Decimal;
        GSTComponentCode: array[20] of Code[10];
        VendAddr: array[8] of Text[50];
        ShipToAddr: array[8] of Text[50];
        CompanyAddr: array[8] of Text[50];
        PurchaserText: Text[30];
        VATNoText: Text[80];
        ReferenceText: Text[80];
        OrderNoText: Text[80];
        TotalText: Text[50];
        TotalInclVATText: Text[50];
        TotalExclVATText: Text[50];
        MoreLines: Boolean;
        NoOfCopies: Integer;
        NoOfLoops: Integer;
        CopyText: Text[10];
        DimText: Text[120];
        OldDimText: Text[75];
        ShowInternalInfo: Boolean;
        Continue: Boolean;
        LogInteraction: Boolean;
        VALVATBaseLCY: Decimal;
        VALVATAmountLCY: Decimal;
        VALSpecLCYHeader: Text[80];
        VALExchRate: Text[50];
        Text007: Label 'VAT Amount Specification in ';
        Text008: Label 'Local Currency';
        Text009: Label 'Exchange rate: %1/%2';
        CalculatedExchRate: Decimal;
        Text010: Label 'Purchase - Prepayment Invoice %1';
        OutputNo: Integer;
        PricesInclVATtxt: Text[30];
        AllowVATDisctxt: Text[30];
        VATAmountText: Text[30];
        Text011: Label '%1% VAT';
        Text012: Label 'VAT Amount';
        PurchInLineTypeNo: Integer;
        OtherTaxesAmount: Decimal;
        ChargesAmount: Decimal;
        Text13700: Label 'Total %1 Incl. Taxes';
        Text13701: Label 'Total %1 Excl. Taxes';
        SupplementaryText: Text[30];
        Text16500: Label 'Supplementary Invoice';
        //  ServiceTaxEntry: Record 16473;  //PRU SH
        ServiceTaxAmt: Decimal;
        ServiceTaxECessAmt: Decimal;
        AppliedServiceTaxAmt: Decimal;
        AppliedServiceTaxECessAmt: Decimal;
        ServiceTaxSHECessAmt: Decimal;
        AppliedServiceTaxSHECessAmt: Decimal;
        i: Integer;
        SumServiceTaxAmt: Decimal;
        SumServiceTaxECessAmt: Decimal;
        SumServiceTaxSHECessAmt: Decimal;
        [InDataSet]
        LogInteractionEnable: Boolean;
        TotalSubTotal: Decimal;
        TotalAmount: Decimal;
        TotalAmountInclVAT: Decimal;
        TotalAmountVAT: Decimal;
        TotalInvoiceDiscountAmount: Decimal;
        TotalPaymentDiscountOnVAT: Decimal;
        CompanyInfoPhoneNoCaptionLbl: Label 'Phone No.';
        CompanyInfoEMailCaptionLbl: Label 'E-Mail';
        CompanyInfoHomePageCaptionLbl: Label 'Home Page';
        CompanyInfoVATRegistrationNoCaptionLbl: Label 'VAT Reg. No.';
        CompanyInfoGiroNoCaptionLbl: Label 'Giro No.';
        CompanyInfoBankNameCaptionLbl: Label 'Bank';
        CompanyInfoBankAccountNoCaptionLbl: Label 'Account No.';
        PurchInvHeaderDueDateCaptionLbl: Label 'Due Date';
        InvoiceNoCaptionLbl: Label 'Invoice No.';
        PurchInvHeaderPostingDateCaptionLbl: Label 'Posting Date';
        PageCaptionLbl: Label 'Page';
        PaymentTermsDescriptionCaptionLbl: Label 'Payment Terms';
        ShipmentMethodDescriptionCaptionLbl: Label 'Shipment Method';
        DocumentDateCaptionLbl: Label 'Document Date';
        HeaderDimensionsCaptionLbl: Label 'Header Dimensions';
        DirectUnitCostCaptionLbl: Label 'Direct Unit Cost';
        PurchInvLineLineDiscountCaptionLbl: Label 'Discount %';
        AmountCaptionLbl: Label 'Amount';
        SubtotalCaptionLbl: Label 'Subtotal';
        PurchInvLineExciseAmountCaptionLbl: Label 'Excise Amount';
        PurchInvLineTaxAmountCaptionLbl: Label 'Tax Amount';
        ServiceTaxAmountCaptionLbl: Label 'Service Tax Amount';
        TotalTDSIncludingSHECESSCaptionLbl: Label 'Total TDS Including eCess';
        WorkTaxAmountCaptionLbl: Label 'Work Tax Amount';
        OtherTaxesAmountCaptionLbl: Label 'Other Taxes Amount';
        ChargesAmountCaptionLbl: Label 'Charges Amount';
        ServiceTaxeCessAmountCaptionLbl: Label 'Service Tax eCess Amount';
        SvcTaxAmtAppliedCaptionLbl: Label 'Svc Tax Amt (Applied)';
        SvcTaxeCessAmtAppliedCaptionLbl: Label 'Svc Tax eCess Amt (Applied)';
        ServiceTaxSHECessAmountCaptionLbl: Label 'Service Tax SHECess Amount';
        LineAmtInvDiscountAmtAmtInclVATCaptionLbl: Label 'Payment Discount on VAT';
        AllowInvDiscountCaptionLbl: Label 'Allow Invoice Discount';
        LineDimensionsCaptionLbl: Label 'Line Dimensions';
        VATAmountLineVATCaptionLbl: Label 'VAT %';
        VATAmountLineVATBaseVTCCaptionLbl: Label 'VAT Base';
        VATAmtLineVATAmtVTCCaptionLbl: Label 'VAT Amount';
        VATAmountSpecificationCaptionLbl: Label 'VAT Amount Specification';
        VATAmtLineInvDiscBaseAmtVTCCaptionLbl: Label 'Inv. Disc. Base Amount';
        VATAmtLineLineAmtVTCCaptionLbl: Label 'Line Amount';
        VATAmountLineVATIdentifierCaptionLbl: Label 'VAT Identifier';
        VATAmountLineVATBaseVTC1CaptionLbl: Label 'Total';
        ShiptoAddressCaptionLbl: Label 'Ship-to Address';
        InvDiscountAmountCaptionLbl: Label 'Invoice Discount Amount';
        ServiceTaxSBCAmount: Decimal;
        AppliedServiceTaxSBCAmount: Decimal;
        SumServiceTaxSBCAmount: Decimal;
        ServTaxSBCAmtCaptionLbl: Label 'SBC Amount';
        SvcTaxSBCAmtAppliedCaptionLbl: Label 'SBC Amt (Applied)';
        KKCessAmount: Decimal;
        AppliedKKCessAmount: Decimal;
        SumKKCessAmount: Decimal;
        KKCessAmtCaptionLbl: Label 'KK Cess Amount';
        KKCessAmtAppliedCaptionLbl: Label 'KK Cess Amt (Applied)';
        IsGSTApplicable: Boolean;
        j: Integer;
        CompanyRegistrationLbl: Label 'Company Registration No.';
        VendorRegistrationLbl: Label 'Vendor GST Reg No.';
        ReportCaption: Label 'Credit Note';
        VendorAdr: Record 23;
        SrNo: Integer;
        CGST: Decimal;
        IGST: Decimal;
        SGST: Decimal;
        Check: Report 50006;
        AmtInword: array[2] of Text;
        AmounttoVendor_PurchInvHeader: Decimal;
        GSTPercent: Decimal;
        AmtToVend_PurchInvLine: Decimal;
        ExciseAmt_PurchInvLine: Decimal;
        TaxAmt_PurchInvLine: Decimal;
        TtlTDSIncSHECESS_PurchInvLine: Decimal;
        WorkTaxAmt_PurchInvLine: Decimal;

    local procedure DocumentCaption(): Text[250]
    begin
        IF "Purch. Inv. Header"."Prepayment Invoice" THEN
            EXIT(Text010);
        IF "Purch. Inv. Header"."Invoice Type" = "Purch. Inv. Header"."Invoice Type"::"Debit Note" THEN
            EXIT(ReportCaption);
        EXIT(Text004);
    end;


    procedure InitializeRequest(NewNoOfCopies: Integer; NewShowInternalInfo: Boolean; NewLogInteraction: Boolean)
    begin
        NoOfCopies := NewNoOfCopies;
        ShowInternalInfo := NewShowInternalInfo;
        LogInteraction := NewLogInteraction;
    end;
}

