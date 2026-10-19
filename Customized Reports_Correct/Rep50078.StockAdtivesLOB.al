report 50078 "StockAdtivesLOB"
{
    UsageCategory = Administration;
    Caption = 'StockAdtivesLOB';
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'ReportLayout\StockReportImportLOB.rdl';
    dataset
    {
        dataitem("Item Ledger Entry"; "Item Ledger Entry")
        {
            DataItemTableView = WHERE(Open = CONST(true));
            RequestFilterFields = "Posting Date", "Item No.", "Global Dimension 1 Code";
            column(Description_Item; "Item Ledger Entry"."Item Name")
            {
            }
            column(LOB; LOB)
            { }
            column(No_Item; "Item Ledger Entry"."Item No.")
            {
            }
            column(Cost_Amount__Actual_; StockValue)
            { }

            column(UOM; "Item Ledger Entry"."Unit of Measure Code")
            { }
            column(CompanyInformation_Name; CompanyInformation.Name)
            {
            }
            column(CompanyInformation_Address; CompanyInformation.Address)
            {
            }
            column(CompanyInformation_Address2; CompanyInformation."Address 2")
            {
            }
            column(CompanyInformation_City; CompanyInformation.City)
            {
            }
            column(CompanyInformation_PostCode; CompanyInformation."Post Code")
            {
            }
            /*  //PRU SH 01082022
            column(CompanyInformation_State; CompanyInformation.State)
            {
            }
            */  //PRU SH 01082022
            column(CompanyInformation_State; CompanyInformation_State)
            { }
            column(CompanyInformation_Picture; CompanyInformation.Picture)
            {
            }
            column(LocationCode_ItemLedgerEntry; "Item Ledger Entry"."Location Code")
            {
            }
            column(Quantity_ItemLedgerEntry; "Item Ledger Entry"."Remaining Quantity")
            {
            }
            column(InvoicedQuantity_ItemLedgerEntry; "Item Ledger Entry"."Invoiced Quantity")
            {
            }
            trigger OnAfterGetRecord()
            var
                myInt: Integer;
            begin
                "Item Ledger Entry".CalcFields("Cost Amount (Actual)");
                StockValue := ("Item Ledger Entry"."Cost Amount (Actual)" / "Item Ledger Entry".Quantity) * "Item Ledger Entry"."Remaining Quantity";

                DimensionValue.Get('LOB', "Item Ledger Entry"."Global Dimension 1 Code");
                LOB := DimensionValue.Name;

            end;


            trigger OnPreDataItem()
            begin
                "Item Ledger Entry".SETCURRENTKEY("Item No.", "Global Dimension 1 Code");

                //Filters := "Item Ledger Entry".GETFILTERS();
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
        CompanyInformation.GET;
        CompanyInformation.CALCFIELDS(Picture);

    end;

    var
        ExcelBuffer: Record 370 temporary;
        ShowLine: Integer;
        CompanyInformation: Record 79;
        Filters: Text;
        CompanyInformation_State: Code[10];
        StockValue: Decimal;
        DimensionValue: Record "Dimension Value";
        LOB: Text;

    local procedure CreateExcelHeader()
    begin
    end;
}

