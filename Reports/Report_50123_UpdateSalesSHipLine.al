report 50125 "Update Sales Shipment Line"
{
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    Caption = 'Update Sales Shipment Line';
    Permissions = tabledata "Sales Shipment Line" = rm, tabledata "Item Ledger Entry" = rm;
    dataset
    {
        dataitem("Sales Shipment Line"; "Sales Shipment Line")
        {
            trigger OnPreDataItem()
            begin
                SetRange("Document No.", DOCNo);
            end;

            trigger OnAfterGetRecord()
            begin
                "Sales Shipment Line"."Flock No." := FLOCKNo;
                "Sales Shipment Line".Modify();
            end;
        }
        dataitem("Item Ledger Entry"; "Item Ledger Entry")
        {


            trigger OnPreDataItem()
            begin
                SetRange("Document No.", DOCNo);
            end;

            trigger OnAfterGetRecord()
            begin
                "Item Ledger Entry"."Flock No." := FLOCKNo;
                "Item Ledger Entry".Modify();
            end;
        }
    }



    requestpage
    {
        layout
        {
            area(content)
            {
                field(DOCNo; DOCNo)
                {
                    Caption = 'Doc No';
                    ApplicationArea = all;
                }
                field(FLOCKNo; FLOCKNo)
                {
                    Caption = 'Flock No';
                    ApplicationArea = all;
                }
            }
        }
    }

    trigger OnPreReport()
    begin
        if UserId <> 'PTPL01' then
            Error('Please connect with administrator');

        if DOCNo = '' then
            Error('Please enter the doc no.');
    end;

    var
        DOCNo: Code[20];
        FLOCKNo: Code[20];
}