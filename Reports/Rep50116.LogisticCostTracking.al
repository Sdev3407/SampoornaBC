report 50116 "Logistic Cost Tracking"
{
    ApplicationArea = All;
    Caption = 'Logistic Cost Tracking';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'ReportLayout\LogisticCostTracking.rdl';
    dataset
    {
        dataitem(SalesInvoiceHeader; "Sales Invoice Header")
        {
            DataItemTableView = sorting("Posting Date");
            column(PostingDate_SalesInvoiceHeader;
            "Posting Date")
            {
            }
            column(SelltoCustomerName_SalesInvoiceHeader; "Sell-to Customer Name")
            {
            }
            column(No_SalesInvoiceHeader; "No.")
            {
            }
            column(SelltoCustomerNo_SalesInvoiceHeader; "Sell-to Customer No.")
            {
            }
            column(FromDate; FromDate)
            { }
            column(ToDate; ToDate)
            { }

            dataitem(SalesInvoiceLine; "Sales Invoice Line")
            {
                DataItemLink = "Document No." = field("No.");
                DataItemTableView = sorting("Document No.", "Line No.") where("Type" = const(Item), Quantity = Filter(<> 0));
                column(LineNo_SalesInvoiceLine; "Line No.")
                {
                }
                column(Description_SalesInvoiceLine; Description)
                {
                }
                column(No_SalesInvoiceLine; "No.")
                {
                }
                column(ItemType_SalesInvoiceLine; "Item Type")
                {
                }
                column(LOB_SalesInvoiceLine; GetDimensionValue(3, "Dimension Set ID"))
                {
                }
                column(Branch_SalesInvoiceLine; GetDimensionValue(2, "Dimension Set ID"))
                {
                }
                column(LocationCode_SalesInvoiceLine; "Location Code")
                {
                }
                column(LocationName_SalesInvoiceLine; SalesInvLocName)
                {
                }
                column(UnitofMeasureCode_SalesInvoiceLine; "Unit of Measure Code")
                {
                }
                column(Quantity_SalesInvoiceLine; "Quantity")
                {
                }
                column(AmountIncludingVAT_SalesInvoiceLine; "Amount Including VAT")
                {
                }

                column(StockType_SalesInvoiceLine; 'Sale')
                {
                }
                column(TransporterCode_SalesInvoiceLine; TransPortCode)
                {
                }
                column(TransporterName_SalesInvoiceLine; TransPortName)
                {
                }
                column(LrNo_SalesInvoiceLine; BiltyNo)
                {
                }
                column(VehicleNo_SalesInvoiceLine; VehicleNo)
                {
                }
                column(DeliveryType_SalesInvoiceLine; DeliveryType)
                {
                }
                column(FreightAmount_SalesInvoiceLine; FreightAmount)
                {
                }
                trigger OnAfterGetRecord()
                var
                    Location: Record Location;
                    saleIvH: Record "Sales Invoice Header";
                begin
                    SalesInvLocName := '';
                    if Location.Get("Location Code") then
                        SalesInvLocName := Location.Name;



                    saleIvH.Reset();
                    saleIvH.SetRange("No.", SalesInvoiceLine."Document No.");
                    if saleIvH.FindFirst() then begin
                        TransPortCode := saleIvH."Transporter Code";
                        TransPortName := saleIvH."Transporter Name";
                        BiltyNo := saleIvH."LR/RR No.";
                        VehicleNo := saleIvH."Vehicle No.";
                        DeliveryType := saleIvH.Freight;

                        if SalesInvFirstLine then
                            FreightAmount := saleIvH."Freight Value"
                        else
                            FreightAmount := 0;

                        SalesInvFirstLine := false;


                    end;
                end;

            }

            trigger OnAfterGetRecord()
            begin
                SalesInvFirstLine := true;
            end;

            trigger OnPreDataItem()
            begin
                SetRange("Posting Date", FromDate, ToDate);
            end;
        }

        dataitem("Transfer Shipment Header"; "Transfer Shipment Header")
        {
            DataItemTableView = sorting("Posting Date");
            column(No_TransferShipmentHeader; "No.")
            {
            }
            column(PostingDate_TransferShipmentHeader; "Posting Date")
            {
            }
            dataitem("Transfer Shipment Line"; "Transfer Shipment Line")
            {
                DataItemLink = "Document No." = field("No.");
                DataItemTableView = sorting("Document No.", "Line No.") where("Item No." = filter(<> ''), Quantity = Filter(<> 0));
                column(LineNo_TransferShipmentLine; "Line No.")
                {
                }
                column(Description_TransferShipmentLine; Description)
                {
                }

                column(No_TransferShipmentLine; "Item No.")
                {
                }
                column(ItemType_TransferShipmentLine; "Item Type")
                {
                }
                column(LOB_TransferShipmentLine; GetDimensionValue(3, "Dimension Set ID"))
                {
                }
                column(Branch_TransferShipmentLine; GetDimensionValue(2, "Dimension Set ID"))
                {
                }
                column(LocationCode_TransferShipmentLine; "Transfer-from Code")
                {
                }
                column(LocationName_TransferShipmentLine; TransferShipLocName)
                {
                }
                column(UnitofMeasureCode_TransferShipmentLine; "Unit of Measure Code")
                {
                }
                column(Quantity_TransferShipmentLine; Quantity)
                {
                }
                column(AmountIncludingVAT_TransferShipmentLine; Amount)
                {
                }
                column(StockType_TransferShipmentLine; 'Transfer')
                {
                }
                column(TransferToLocation_TransferShipmentLine; "Transfer-to Code")
                {
                }
                column(TransferToLocationName_TransferShipmentLine; TransferToLocName)
                {
                }
                column(TransporterCode_TransferShipmentLine; TransPortCode)
                {
                }
                column(TransporterName_TransferShipmentLine; TransPortName)
                {
                }
                column(LrNo_TransferShipmentLine; BiltyNo)
                {
                }
                column(VehicleNo_TransferShipmentLine; VehicleNo)
                {
                }
                column(DeliveryType_TransferShipmentLine; DeliveryType)
                {
                }
                column(FreightAmount_TransferShipmentLine; TransferFreightAmount)
                {
                }

                trigger OnAfterGetRecord()
                var
                    Location: Record Location;
                    saleIvH: Record "Transfer Shipment Header";
                begin
                    TransferShipLocName := '';
                    TransferToLocName := '';
                    if Location.Get("Transfer-from Code") then
                        TransferShipLocName := Location.Name;

                    if Location.Get("Transfer-to Code") then
                        TransferToLocName := Location.Name;





                    saleIvH.Reset();
                    saleIvH.SetRange("No.", "Transfer Shipment Line"."Document No.");
                    if saleIvH.FindFirst() then begin
                        TransPortCode := saleIvH."Transporter Code";
                        TransPortName := saleIvH."Transporter Name";
                        BiltyNo := saleIvH."LR/RR No.";
                        VehicleNo := saleIvH."Vehicle No.";
                        DeliveryType := DeliveryType::EX;


                        if TransferShipFirstLine then
                            TransferFreightAmount := saleIvH."Freight Value"
                        else
                            TransferFreightAmount := 0;

                        TransferShipFirstLine := false;
                    end;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                TransferShipFirstLine := true;
            end;

            trigger OnPreDataItem()
            begin
                SetRange("Posting Date", FromDate, ToDate);
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(Filters)
                {
                    Caption = 'Filters';
                    field(FromDate_req; FromDate)
                    {
                        ApplicationArea = All;
                        Caption = 'From Date';
                        ToolTip = 'Specifies the value of the From Date field.';

                        trigger OnValidate()
                        begin
                            if (ToDate <> 0D) and (FromDate > ToDate) then
                                Error('From Date cannot be greater than To Date.');
                        end;
                    }
                    field(ToDate_req; ToDate)
                    {
                        ApplicationArea = All;
                        Caption = 'To Date';
                        ToolTip = 'Specifies the value of the To Date field.';
                        trigger OnValidate()
                        begin
                            if (FromDate <> 0D) and (ToDate < FromDate) then
                                Error('To Date cannot be less than From Date.');
                        end;
                    }
                }
            }
        }
    }

    trigger OnPreReport()
    var
        FromDateMandatoryLbl: Label 'From Date is mandatory.', Comment = 'Error message when From Date is not entered';
        ToDateMandatoryLbl: Label 'To Date is mandatory.', Comment = 'Error message when To Date is not entered';
    begin
        if FromDate = 0D then
            Error(FromDateMandatoryLbl);

        if ToDate = 0D then
            Error(ToDateMandatoryLbl);
    end;

    var


    var
        SalesInvLocName: Text[100];
        TransferShipLocName: Text[100];
        TransferToLocName: Text[100];
        TransferFreightAmount: Decimal;
        TransferShipFirstLine: Boolean;
        FreightAmount: Decimal;
        SalesInvFirstLine: Boolean;
        FromDate: Date;
        ToDate: Date;
        TransPortCode: Text;
        TransPortName: Text;
        BiltyNo: Text;
        VehicleNo: text;
        DeliveryType: Option " ","FOR",EX;


    local procedure GetDimensionValue(DimesionNo: Integer; DimensionSetId: Integer): Code[20]
    var
        GeneralLedgerSetup: Record "General Ledger Setup";
        DimensionSetEntry: Record "Dimension Set Entry";
        DimSetupCode: Code[20];
    begin
        GeneralLedgerSetup.Get();

        case DimesionNo of
            1:
                DimSetupCode := GeneralLedgerSetup."Global Dimension 1 Code";
            2:
                DimSetupCode := GeneralLedgerSetup."Global Dimension 2 Code";
            3:
                DimSetupCode := GeneralLedgerSetup."Shortcut Dimension 3 Code";
            4:
                DimSetupCode := GeneralLedgerSetup."Shortcut Dimension 4 Code";
            5:
                DimSetupCode := GeneralLedgerSetup."Shortcut Dimension 5 Code";
            6:
                DimSetupCode := GeneralLedgerSetup."Shortcut Dimension 6 Code";
            7:
                DimSetupCode := GeneralLedgerSetup."Shortcut Dimension 7 Code";
            8:
                DimSetupCode := GeneralLedgerSetup."Shortcut Dimension 8 Code";
        end;

        if DimSetupCode = '' then
            exit('');

        DimensionSetEntry.Reset();
        DimensionSetEntry.SetRange("Dimension Set ID", DimensionSetId);
        DimensionSetEntry.SetRange("Dimension Code", DimSetupCode);
        if DimensionSetEntry.FindFirst() then
            exit(DimensionSetEntry."Dimension Value Code")
        else
            exit('');

    end;
}
