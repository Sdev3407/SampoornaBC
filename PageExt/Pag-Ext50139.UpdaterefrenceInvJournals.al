pageextension 50139 "Update refrence InvJournals" extends "Update Reference Inv. Journals"
{
    layout
    {

    }

    var
        SourceTypeExternal: Option Vendor,Customer;

    Procedure CustomerRecord(SourceType: Option Vendor,Customer)
    begin
        SourceTypeExternal := SourceType;
    end;
}