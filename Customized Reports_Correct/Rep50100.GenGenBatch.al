report 50100 GenGenBatch
{
    //  UsageCategory = Administration;
    Caption = 'GenGenBatch';
    //    ApplicationArea = All;
    DefaultLayout = RDLC;
    ProcessingOnly = true;
    Permissions = tabledata "G/L Entry" = rimd;
    dataset
    {
        dataitem("G/L Entry"; "G/L Entry")
        {
            trigger OnAfterGetRecord()
            begin
                "G/L Entry"."External Document No." := '';
                "G/L Entry".Modify();
            end;
        }
    }
}
