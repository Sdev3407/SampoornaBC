pageextension 50023 "Posted_SalesCrMemoSubformExt" extends "Posted Sales Cr. Memo Subform"
{
    layout
    {


        addafter(Description)
        {

            field("Alternate UOM"; Rec."Alternate UOM")
            {
                ApplicationArea = All;
            }
            field("Alternate Quantity"; Rec."Alternate Quantity")
            {
                ApplicationArea = All;
            }
        }
        addafter(Quantity)
        {
            field("Total MRP"; Rec."Total MRP")
            {
                Editable = false;
            }
        }
        addafter("Unit of Measure Code")
        {
            field("Flock No."; Rec."Flock No.")
            {
                ApplicationArea = All;
            }
            field("Posting Date"; rec."Posting Date")
            {
                ApplicationArea = All;
            }
            field("Location Code"; rec."Location Code")
            {
                ApplicationArea = All;
            }
            field("Posting Group"; rec."Posting Group")
            {
                ApplicationArea = All;
            }
            field("Shipment Date"; Rec."Shipment Date")
            {
                ApplicationArea = All;
            }
            field("GST Jurisdiction Type"; Rec."GST Jurisdiction Type")
            {
                ApplicationArea = All;
            }
            field("Location State Code"; Rec."Location State Code")
            {
                ApplicationArea = All;
            }
            field("GST Place of Supply"; Rec."GST Place of Supply")
            {
                ApplicationArea = All;
            }
            field("HSN/SAC Code"; Rec."HSN/SAC Code")
            {
                ApplicationArea = All;
            }
            field(Exempted; Exempted)
            {
                ApplicationArea = All;
            }
            field("Line No."; Rec."Line No.")
            {
                ApplicationArea = All;
            }

            field("GST Group Code"; Rec."GST Group Code")
            {
                ApplicationArea = All;
            }
            field("Amount Including VAT"; Rec."Amount Including VAT")
            {
                ApplicationArea = All;
            }

            field("Amt. to Customer"; Rec."Amt. to Customer")
            {
                ApplicationArea = All;
            }
            field("TCS Nature of Collection"; Rec."TCS Nature of Collection")
            {
                ApplicationArea = All;
            }
            field("GST Group Type"; Rec."GST Group Type")
            {
                ApplicationArea = All;
            }
            field("Invoice Type"; Rec."Invoice Type")
            {
                ApplicationArea = All;
            }

        }
        moveafter("Location Code"; "Gen. Prod. Posting Group")
        /*  addafter("Line Amount")
          {
              field("Chicks Item"; Rec."Chicks Item")
              {
                  ApplicationArea = All;

              }
              field("Alternate Quantity"; Rec."Alternate Quantity")
              {
                  ApplicationArea = All;

              }
              field("Alternate UOM"; Rec."Alternate UOM")
              {
                  ApplicationArea = All;

              }
              
              field("Item Type"; Rec."Item Type")
              {
                  ApplicationArea = All;

              }
              field("Bird Type"; Rec."Bird Type")
              {
                  ApplicationArea = All;

              }
              field("Male Brid Qty."; Rec."Male Brid Qty.")
              {
                  ApplicationArea = All;

              }
              field("Female Bird Qty."; Rec."Female Bird Qty.")
              {
                  ApplicationArea = All;

              }
              field("Freight Reimbursment Discount"; Rec."Freight Reimbursment Discount")
              {
                  ApplicationArea = All;

              }
              field("Amt. to Customer"; Rec."Amt. to Customer")
              {
                  ApplicationArea = All;

              }
              field("Location State Code"; Rec."Location State Code")
              {
                  ApplicationArea = All;

              }
              field("Price Discount"; Rec."Price Discount")
              {
                  ApplicationArea = All;

              }
          }*/
    }
}