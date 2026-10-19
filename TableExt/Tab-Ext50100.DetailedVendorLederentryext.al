tableextension 50100 DetailedVendorLederentryext extends "Detailed Vendor Ledg. Entry"

{
    fields
    {
        field(50000; "SFPL_Security Entry"; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = Exist("Vendor Ledger Entry" Where("Entry No." = field("Vendor Ledger Entry No."), "Remaining Amount" = FILTER(<> 0), "Security Group Code" = filter(<> '')));



        }
    }
}