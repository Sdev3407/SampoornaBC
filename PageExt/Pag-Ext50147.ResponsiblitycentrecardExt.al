pageextension 50147 ResponsiblitycentrecardExt extends "Responsibility Center Card"
{
    layout
    {
        addafter(Communication)
        {
            group(Numbering)
            {
                group(Sales)
                {

                    field("Quote Nos."; Rec."Quote Nos.")
                    {
                        ApplicationArea = All;
                    }
                    field("Order Nos."; Rec."Order Nos.")
                    {
                        ApplicationArea = All;
                    }
                    field("Invoice Nos."; Rec."Invoice Nos.")
                    {
                        ApplicationArea = All;
                    }
                    field("Posted Invoice Nos."; Rec."Posted Invoice Nos.")
                    {
                        ApplicationArea = All;
                    }
                    field("Credit Memo Nos."; Rec."Credit Memo Nos.")
                    {
                        ApplicationArea = All;
                    }
                    field("Posted Credit Memo Nos."; Rec."Posted Credit Memo Nos.")
                    {
                        ApplicationArea = All;
                    }
                    field("Posted Shipment Nos."; Rec."Posted Shipment Nos.")
                    {
                        ApplicationArea = All;
                    }
                    field("Reminder Nos."; Rec."Reminder Nos.")
                    {
                        ApplicationArea = All;
                    }

                    field("Issued Reminder Nos."; Rec."Issued Reminder Nos.")
                    {
                        ApplicationArea = All;
                    }
                    field("Fin. Chrg. Memo Nos."; Rec."Fin. Chrg. Memo Nos.")
                    {
                        ApplicationArea = All;
                    }
                    field("Issued Fin. Chrg. M. Nos."; Rec."Issued Fin. Chrg. M. Nos.")
                    {
                        ApplicationArea = All;
                    }
                    field("Posted Prepmt. Inv. Nos."; Rec."Posted Prepmt. Inv. Nos.")
                    {
                        ApplicationArea = All;
                    }
                    field("Posted Prepmt. Cr. Memo Nos."; Rec."Posted Prepmt. Cr. Memo Nos.")
                    {
                        ApplicationArea = All;
                    }
                    field("Blanket Order Nos."; Rec."Blanket Order Nos.")
                    {
                        ApplicationArea = All;
                    }

                    Field("Direct Debit Mandate Nos."; Rec."Direct Debit Mandate Nos.")
                    {
                        ApplicationArea = All;
                    }
                    Field("Posted Return Receipt Nos."; Rec."Posted Return Receipt Nos.")
                    {
                        ApplicationArea = All;
                    }
                    Field("Return Order Nos."; Rec."Return Order Nos.")
                    {
                        ApplicationArea = All;
                    }
                    Field("Third Party Nos."; Rec."Third Party Nos.")
                    {
                        ApplicationArea = All;
                    }
                    Field("Posted Invoice Nos. (Trading)"; Rec."Posted Invoice Nos. (Trading)")
                    {
                        ApplicationArea = All;
                    }
                    Field("Posted Ret Rcpt Nos. (Trading)"; Rec."Posted Ret Rcpt Nos. (Trading)")
                    {
                        ApplicationArea = All;
                    }
                    Field("Posted Sales Shpt. (Trading)"; Rec."Posted Sales Shpt. (Trading)")
                    {
                        ApplicationArea = All;
                    }
                    Field("Posted Sale Cr. Memo (Trading)"; Rec."Posted Sale Cr. Memo (Trading)")
                    {
                        ApplicationArea = All;
                    }
                    Field("Posted Inv. Nos. (Exempt)"; Rec."Posted Inv. Nos. (Exempt)")
                    {
                        ApplicationArea = All;
                    }
                    Field("Posted Cr. Memo Nos. (Exempt)"; Rec."Posted Cr. Memo Nos. (Exempt)")
                    {
                        ApplicationArea = All;
                    }
                    Field("Posted Inv. No. (Export)"; Rec."Posted Inv. No. (Export)")
                    {
                        ApplicationArea = All;
                    }
                    Field("Posted Cr. Memo No. (Export)"; Rec."Posted Cr. Memo No. (Export)")
                    {
                        ApplicationArea = All;
                    }
                    Field("Posted Inv. No. (Supp)"; Rec."Posted Inv. No. (Supp)")
                    {
                        ApplicationArea = All;
                    }
                    Field("Posted Cr. Memo No. (Supp)"; Rec."Posted Cr. Memo No. (Supp)")
                    {
                        ApplicationArea = All;
                    }
                    Field("Posted Inv. No. (Debit Note)"; Rec."Posted Inv. No. (Debit Note)")
                    {
                        ApplicationArea = All;
                    }
                    Field("Posted Inv. No. (Non-GST)"; Rec."Posted Inv. No. (Non-GST)")
                    {
                        ApplicationArea = All;
                    }
                    Field("Posted Cr. Memo No. (Non-GST)"; Rec."Posted Cr. Memo No. (Non-GST)")
                    {
                        ApplicationArea = All;
                    }
                }
                group(Purchase)
                {
                    Caption = 'Purchase';
                    field("Purch. Quote Nos."; Rec."Purch. Quote Nos.")
                    {
                        ApplicationArea = All;
                    }
                    field("Purch. Order Nos."; Rec."Purch. Order Nos.")
                    {
                        ApplicationArea = All;
                    }
                    field("Purch. Invoice Nos."; Rec."Purch. Invoice Nos.")
                    {
                        ApplicationArea = All;
                    }
                    field("Posted Purch. Invoice Nos."; Rec."Posted Purch. Invoice Nos.")
                    {
                        ApplicationArea = All;
                    }
                    field("Purch. Credit Memo Nos."; Rec."Purch. Credit Memo Nos.")
                    {
                        ApplicationArea = All;
                    }
                    field("Posted Purch. Credit Memo Nos."; Rec."Posted Purch. Credit Memo Nos.")
                    {
                        ApplicationArea = All;
                    }
                    field("Posted Purch. Receipt Nos."; Rec."Posted Purch. Receipt Nos.")
                    {
                        ApplicationArea = All;
                    }
                    field("Blanket Purch. Order Nos."; Rec."Blanket Purch. Order Nos.")
                    {
                        ApplicationArea = All;
                    }
                    field("Posted Purch.Prepmt. Inv. Nos."; Rec."Posted Purch.Prepmt. Inv. Nos.")
                    {
                        ApplicationArea = All;
                    }
                    field("Posted P.Prepmt. Cr. Memo Nos."; Rec."Posted P.Prepmt. Cr. Memo Nos.")
                    {
                        ApplicationArea = All;
                    }
                    field("Posted Purch.Return Shpt. Nos."; Rec."Posted Purch.Return Shpt. Nos.")
                    {
                        ApplicationArea = All;
                    }
                    field("Purch. Return Order Nos."; Rec."Purch. Return Order Nos.")
                    {
                        ApplicationArea = All;
                    }
                    field("Purch. Third Party Nos."; Rec."Purch. Third Party Nos.")
                    {
                        ApplicationArea = All;
                    }
                    field("Posted Delivery Challan Nos."; Rec."Posted Delivery Challan Nos.")
                    {
                        ApplicationArea = All;
                    }
                    field("Subcontracting Order Nos."; Rec."Subcontracting Order Nos.")
                    {
                        ApplicationArea = All;
                    }
                    field("Posted SC Comp. Rcpt. Nos."; Rec."Posted SC Comp. Rcpt. Nos.")
                    {
                        ApplicationArea = All;
                    }
                    field("Delivery Challan Nos."; Rec."Delivery Challan Nos.")
                    {
                        ApplicationArea = All;
                    }
                    field("Posted PInvoice Nos. (Trading)"; Rec."Posted PInvoice Nos. (Trading)")
                    {
                        ApplicationArea = All;
                    }
                    field("Posted PRet Shpt Nos.(Trading)"; Rec."Posted PRet Shpt Nos.(Trading)")
                    {
                        ApplicationArea = All;
                    }
                    field("Posted Purch. Rcpt. (Trading)"; Rec."Posted Purch. Rcpt. (Trading)")
                    {
                        ApplicationArea = All;
                    }
                    field("Posted Purch Cr. Memo(Trading)"; Rec."Posted Purch Cr. Memo(Trading)")
                    {
                        ApplicationArea = All;
                    }
                    field("Multiple Subcon. Order Det Nos"; Rec."Multiple Subcon. Order Det Nos")
                    {
                        ApplicationArea = All;
                    }
                    field("Posted Purch. Inv.(Unreg)"; Rec."Posted Purch. Inv.(Unreg)")
                    {
                        ApplicationArea = All;
                    }
                    field("Posted Purch Cr. Memo(Unreg)"; Rec."Posted Purch Cr. Memo(Unreg)")
                    {
                        ApplicationArea = All;
                    }
                    field("Posted Purch Inv.(Unreg Supp)"; Rec."Posted Purch Inv.(Unreg Supp)")
                    {
                        ApplicationArea = All;
                    }
                    field("RGP Nos."; Rec."RGP Nos.")
                    {
                        ApplicationArea = All;
                    }
                    field("NRGP Nos."; Rec."NRGP Nos.")
                    {
                        ApplicationArea = All;
                    }
                    field("Pst. Pur. Inv(Unreg. Deb.Note)"; Rec."Pst. Pur. Inv(Unreg. Deb.Note)")
                    {
                        ApplicationArea = All;
                    }
                }
                group(Manufacturing)
                {
                    Caption = 'Manufacturing';
                    field("Simulated Order Nos."; Rec."Simulated Order Nos.")
                    {
                        ApplicationArea = All;
                    }
                    field("Planned Order Nos."; Rec."Planned Order Nos.")
                    {
                        ApplicationArea = All;
                    }
                    field("Firm Planned Order Nos."; Rec."Firm Planned Order Nos.")
                    {
                        ApplicationArea = All;
                    }
                    field("Released Order Nos."; Rec."Released Order Nos.")
                    {
                        ApplicationArea = All;
                    }
                    field("Work Center Nos."; Rec."Work Center Nos.")
                    {
                        ApplicationArea = All;
                    }
                    field("Machine Center Nos."; Rec."Machine Center Nos.")
                    {
                        ApplicationArea = All;
                    }
                    field("Routing Nos."; Rec."Routing Nos.")
                    {
                        ApplicationArea = All;
                    }
                }
                group(Inventory)
                {
                    Caption = 'Inventory';
                    field("Transfer Order Nos."; Rec."Transfer Order Nos.")
                    {
                        ApplicationArea = All;
                    }
                    field("Posted Transfer Shpt. Nos."; Rec."Posted Transfer Shpt. Nos.")
                    {
                        ApplicationArea = All;
                    }
                    field("Posted Transfer Rcpt. Nos."; Rec."Posted Transfer Rcpt. Nos.")
                    {
                        ApplicationArea = All;
                    }
                    field("Nonstock Item Nos."; Rec."Nonstock Item Nos.")
                    {
                        ApplicationArea = All;
                    }
                    field("Inventory Put-away Nos."; Rec."Inventory Put-away Nos.")
                    {
                        ApplicationArea = All;
                    }
                    field("Inventory Pick Nos."; Rec."Inventory Pick Nos.")
                    {
                        ApplicationArea = All;
                    }
                    field("Posted Invt. Put-away Nos."; Rec."Posted Invt. Put-away Nos.")
                    {
                        ApplicationArea = All;
                    }
                    field("Posted Invt. Pick Nos."; Rec."Posted Invt. Pick Nos.")
                    {
                        ApplicationArea = All;
                    }
                    field("Inventory Movement Nos."; Rec."Inventory Movement Nos.")
                    {
                        ApplicationArea = All;
                    }
                    field("Registered Invt. Movement Nos."; Rec."Registered Invt. Movement Nos.")
                    {
                        ApplicationArea = All;
                    }
                    field("Internal Movement Nos."; Rec."Internal Movement Nos.")
                    {
                        ApplicationArea = All;
                    }
                    field("Third Party Nos.(Inventory)"; Rec."Third Party Nos.(Inventory)")
                    {
                        ApplicationArea = All;
                    }
                    field("Inward Gate Entry Nos."; Rec."Inward Gate Entry Nos.")
                    {
                        ApplicationArea = All;
                    }
                    field("Outward Gate Entry Nos."; Rec."Outward Gate Entry Nos.")
                    {
                        ApplicationArea = All;
                    }
                    field("Posted Shpt. Nos. (Captive)"; Rec."Posted Shpt. Nos. (Captive)")
                    {
                        ApplicationArea = All;
                    }
                    field("Transfer Order Nos. (Captive)"; Rec."Transfer Order Nos. (Captive)")
                    {
                        ApplicationArea = All;
                    }
                    field("Service Transfer Order Nos."; Rec."Service Transfer Order Nos.")
                    {
                        ApplicationArea = All;
                    }
                    field("Posted Serv. Trans. Shpt. Nos."; Rec."Posted Serv. Trans. Shpt. Nos.")
                    {
                        ApplicationArea = All;
                    }
                    field("Posted Serv. Trans. Rcpt. Nos."; Rec."Posted Serv. Trans. Rcpt. Nos.")
                    {
                        ApplicationArea = All;
                    }
                    field("Indent No. Series"; Rec."Indent No. Series")
                    {
                        ApplicationArea = All;
                    }
                }
                group(NavFarm)
                {
                    Caption = 'NavFarm';
                    field("Parameter No"; Rec."Parameter No")
                    {
                        ApplicationArea = All;
                    }
                    field("Parameter Template No"; Rec."Parameter Template No")
                    {
                        ApplicationArea = All;
                    }
                    field("Breed Code"; Rec."Breed Code")
                    {
                        ApplicationArea = All;
                    }
                    field("Data Sheet Nos"; Rec."Data Sheet Nos")
                    {
                        ApplicationArea = All;
                    }
                    field("Hatchery Code"; Rec."Hatchery Code")
                    {
                        ApplicationArea = All;
                    }
                    field("Hatchery Nos"; Rec."Hatchery Nos")
                    {
                        ApplicationArea = All;
                    }
                    field("GC Statement Nos."; Rec."GC Statement Nos.")
                    {
                        ApplicationArea = All;
                    }
                }
            }
        }
    }
}