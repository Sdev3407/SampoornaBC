namespace Sampoorna_BC.Sampoorna_BC;

using Microsoft.Inventory.Ledger;
using Microsoft.Warehouse.GateEntry;

pageextension 50175 PostedGateentryLineExt extends "Posted Gate Entry Line List"
{
    layout
    {
        addafter(Description)
        {
            field(Status; Rec.Status)
            {
                ApplicationArea = All;
            }

        }
    }
}
