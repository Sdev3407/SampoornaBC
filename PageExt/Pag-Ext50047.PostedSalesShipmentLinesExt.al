pageextension 50047 PostedSalesShipmentLinesExt extends "Posted Sales Shipment Lines"
{
    layout
    {

        addafter("Quantity Invoiced")
        {


            field("MRP Price"; Rec."MRP Price")
            {
                ApplicationArea = all;
            }
            field("Total MRP"; Rec."Total MRP")
            {
                ApplicationArea = all;
            }
            field("Allow Invoice Disc."; Rec."Allow Invoice Disc.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Allow Invoice Disc. field.';
            }
            field("Allow Line Disc."; Rec."Allow Line Disc.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Allow Line Disc. field.';
            }
            field("Appl.-from Item Entry"; Rec."Appl.-from Item Entry")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the number of the item ledger entry that the document or journal line is applied from.';
            }

            field("Area"; Rec."Area")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Area field.';
            }
            field("Assessee Code"; Rec."Assessee Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Assessee Code field.';
            }
            field("Attached to Line No."; Rec."Attached to Line No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Attached to Line No. field.';
            }
            field("Authorized for Credit Card"; Rec."Authorized for Credit Card")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Authorized for Credit Card field.';
            }
            field("Bill-to Customer No."; Rec."Bill-to Customer No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the number of the customer that you send or sent the invoice or credit memo to.';
            }
            field("Bin Code"; Rec."Bin Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the bin where the items are picked or put away.';
            }
            field("Blanket Order Line No."; Rec."Blanket Order Line No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the number of the blanket order line that the record originates from.';
            }
            field("Blanket Order No."; Rec."Blanket Order No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the number of the blanket order that the record originates from.';
            }
            field(Correction; Rec.Correction)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies that this sales shipment line has been posted as a corrective entry.';
            }
            // field("Cross-Reference No."; Rec."Cross-Reference No.")
            // {
            //     ApplicationArea = All;
            //     ToolTip = 'Specifies the value of the Cross-Reference No. field.';
            // }
            // field("Cross-Reference Type"; Rec."Cross-Reference Type")
            // {
            //     ApplicationArea = All;
            //     ToolTip = 'Specifies the value of the Cross-Reference Type field.';
            // }
            // field("Cross-Reference Type No."; Rec."Cross-Reference Type No.")
            // {
            //     ApplicationArea = All;
            //     ToolTip = 'Specifies the value of the Cross-Reference Type No. field.';
            // }
            field("Currency Code"; Rec."Currency Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the currency that is used on the entry.';
            }
            field("Customer Disc. Group"; Rec."Customer Disc. Group")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Customer Disc. Group field.';
            }
            field("Customer Price Group"; Rec."Customer Price Group")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Customer Price Group field.';
            }
            field("Depr. until FA Posting Date"; Rec."Depr. until FA Posting Date")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Depr. until FA Posting Date field.';
            }
            field("Depreciation Book Code"; Rec."Depreciation Book Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Depreciation Book Code field.';
            }

            field("Dimension Set ID"; Rec."Dimension Set ID")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Dimension Set ID field.';
            }
            field("Document Id"; Rec."Document Id")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Document Id field.';
            }

            field("Drop Shipment"; Rec."Drop Shipment")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Drop Shipment field.';
            }
            field("Duplicate in Depreciation Book"; Rec."Duplicate in Depreciation Book")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Duplicate in Depreciation Book field.';
            }
            field(Exempted; Rec.Exempted)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Exempted field.';
            }
            field("Exit Point"; Rec."Exit Point")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Exit Point field.';
            }
            field("FA Posting Date"; Rec."FA Posting Date")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the FA Posting Date field.';
            }
            field("GST Assessable Value (LCY)"; Rec."GST Assessable Value (LCY)")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the GST Assessable Value (LCY) field.';
            }
            field("GST Credit"; Rec."GST Credit")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the GST Credit field.';
            }
            field("GST Group Code"; Rec."GST Group Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the GST Group Code field.';
            }
            field("GST Group Type"; Rec."GST Group Type")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the GST Group Type field.';
            }
            field("GST Jurisdiction Type"; Rec."GST Jurisdiction Type")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the GST Jurisdiction Type field.';
            }
            field("GST On Assessable Value"; Rec."GST On Assessable Value")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the GST On Assessable Value field.';
            }
            field("GST Place of Supply"; Rec."GST Place of Supply")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the GST Place of Supply field.';
            }
            field("GST Rounding Line"; Rec."GST Rounding Line")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the GST Rounding Line field.';
            }
            field("Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Gen. Bus. Posting Group field.';
            }
            field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Gen. Prod. Posting Group field.';
            }
            field("Gross Weight"; Rec."Gross Weight")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the gross weight of one unit of the item. In the sales statistics window, the gross weight on the line is included in the total gross weight of all the lines for the particular sales document.';
            }
            field("HSN/SAC Code"; Rec."HSN/SAC Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the HSN/SAC Code field.';
            }
            field("IC Item Reference No."; Rec."IC Item Reference No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the IC Item Reference No. field.';
            }
            field("IC Partner Ref. Type"; Rec."IC Partner Ref. Type")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the IC Partner Ref. Type field.';
            }
            field("IC Partner Reference"; Rec."IC Partner Reference")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the IC Partner Reference field.';
            }
            field("Invoice Type"; Rec."Invoice Type")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Invoice Type field.';
            }
            field("Item Category Code"; Rec."Item Category Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Item Category Code field.';
            }
            field("Item Charge Base Amount"; Rec."Item Charge Base Amount")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Item Charge Base Amount field.';
            }
            field("Item Reference No."; Rec."Item Reference No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the referenced item number.';
            }
            field("Item Reference Type"; Rec."Item Reference Type")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Item Reference Type field.';
            }
            field("Item Reference Type No."; Rec."Item Reference Type No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Item Reference Type No. field.';
            }
            field("Item Reference Unit of Measure"; Rec."Item Reference Unit of Measure")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Unit of Measure (Item Ref.) field.';
            }
            field("Item Shpt. Entry No."; Rec."Item Shpt. Entry No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Item Shpt. Entry No. field.';
            }
            field("Job Contract Entry No."; Rec."Job Contract Entry No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Job Contract Entry No. field.';
            }

            field("Job Task No."; Rec."Job Task No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the number of the related job task.';
            }
            field("Line Discount %"; Rec."Line Discount %")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Line Discount % field.';
            }
            field("Line No."; Rec."Line No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Line No. field.';
            }

            field("Net Weight"; Rec."Net Weight")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the net weight of one unit of the item. In the sales statistics window, the net weight on the line is included in the total net weight of all the lines for the particular sales document.';
            }

            field("Non-GST Line"; Rec."Non-GST Line")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Non-GST Line field.';
            }
            field(Nonstock; Rec.Nonstock)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies that the item on the sales line is a catalog item, which means it is not normally kept in inventory.';
            }
            field("Order Line No."; Rec."Order Line No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Order Line No. field.';
            }
            field("Order No."; Rec."Order No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Order No. field.';
            }
            field("Outbound Whse. Handling Time"; Rec."Outbound Whse. Handling Time")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies a date formula for the time it takes to get items ready to ship from this location. The time element is used in the calculation of the delivery date as follows: Shipment Date + Outbound Warehouse Handling Time = Planned Shipment Date + Shipping Time = Planned Delivery Date.';
            }
            field("Planned Delivery Date"; Rec."Planned Delivery Date")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the planned date that the shipment will be delivered at the customer''s address. If the customer requests a delivery date, the program calculates whether the items will be available for delivery on this date. If the items are available, the planned delivery date will be the same as the requested delivery date. If not, the program calculates the date that the items are available for delivery and enters this date in the Planned Delivery Date field.';
            }
            field("Planned Shipment Date"; Rec."Planned Shipment Date")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the date that the shipment should ship from the warehouse. If the customer requests a delivery date, the program calculates the planned shipment date by subtracting the shipping time from the requested delivery date. If the customer does not request a delivery date or the requested delivery date cannot be met, the program calculates the content of this field by adding the shipment time to the shipping date.';
            }
            field("Posting Date"; Rec."Posting Date")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Posting Date field.';
            }
            field("Posting Group"; Rec."Posting Group")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Posting Group field.';
            }
            field("Price Calculation Method"; Rec."Price Calculation Method")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Price Calculation Method field.';
            }
            field("Price Exclusive of Tax"; Rec."Price Exclusive of Tax")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Price Exclusive of Tax field.';
            }
            field("Promised Delivery Date"; Rec."Promised Delivery Date")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the date that you have promised to deliver the order, as a result of the Order Promising function.';
            }
            field("Purch. Order Line No."; Rec."Purch. Order Line No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Purch. Order Line No. field.';
            }
            field("Purchase Order No."; Rec."Purchase Order No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Purchase Order No. field.';
            }
            field("Purchasing Code"; Rec."Purchasing Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Purchasing Code field.';
            }
            field("Qty. Invoiced (Base)"; Rec."Qty. Invoiced (Base)")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Qty. Invoiced (Base) field.';
            }
            field("Qty. Shipped Not Invoiced"; Rec."Qty. Shipped Not Invoiced")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the quantity of the shipped item that has been posted as shipped but that has not yet been posted as invoiced.';
            }
            field("Qty. per Unit of Measure"; Rec."Qty. per Unit of Measure")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Qty. per Unit of Measure field.';
            }

            field("Quantity (Base)"; Rec."Quantity (Base)")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Quantity (Base) field.';
            }

            field("Requested Delivery Date"; Rec."Requested Delivery Date")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the date that the customer has asked for the order to be delivered.';
            }
            field("Responsibility Center"; Rec."Responsibility Center")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Responsibility Center field.';
            }
            field("Return Reason Code"; Rec."Return Reason Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the code explaining why the item was returned.';
            }

            field("Shipping Time"; Rec."Shipping Time")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies how long it takes from when the items are shipped from the warehouse to when they are delivered.';
            }

            field(SystemCreatedAt; Rec.SystemCreatedAt)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the SystemCreatedAt field.';
            }
            field(SystemCreatedBy; Rec.SystemCreatedBy)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the SystemCreatedBy field.';
            }
            field(SystemId; Rec.SystemId)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the SystemId field.';
            }
            field(SystemModifiedAt; Rec.SystemModifiedAt)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the SystemModifiedAt field.';
            }
            field(SystemModifiedBy; Rec.SystemModifiedBy)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the SystemModifiedBy field.';
            }
            field("TCS Nature of Collection"; Rec."TCS Nature of Collection")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the TCS Nature of Collection field.';
            }
            field("Tax Area Code"; Rec."Tax Area Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Tax Area Code field.';
            }
            field("Tax Group Code"; Rec."Tax Group Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Tax Group Code field.';
            }
            field("Tax Liable"; Rec."Tax Liable")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Tax Liable field.';
            }
            field("Total UPIT Amount"; Rec."Total UPIT Amount")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Total UPIT Amount field.';
            }
            field("Transaction Specification"; Rec."Transaction Specification")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Transaction Specification field.';
            }
            field("Transaction Type"; Rec."Transaction Type")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Transaction Type field.';
            }
            field("Transport Method"; Rec."Transport Method")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Transport Method field.';
            }

            field("Unit Cost"; Rec."Unit Cost")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Unit Cost field.';
            }
            field("Unit Cost (LCY)"; Rec."Unit Cost (LCY)")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the cost, in LCY, of one unit of the item or resource on the line.';
            }
            field("Unit Price"; Rec."Unit Price")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Unit Price field.';
            }
            field("Unit Price Incl. of Tax"; Rec."Unit Price Incl. of Tax")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Unit Price Incl. of Tax field.';
            }
            field("Unit Volume"; Rec."Unit Volume")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the volume of one unit of the item. In the sales statistics window, the volume of one unit of the item on the line is included in the total volume of all the lines for the particular sales document.';
            }

            // field("Unit of Measure (Cross Ref.)"; Rec."Unit of Measure (Cross Ref.)")
            // {
            //     ApplicationArea = All;
            //     ToolTip = 'Specifies the value of the Unit of Measure (Cross Ref.) field.';
            // }

            field("Units per Parcel"; Rec."Units per Parcel")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the number of units per parcel of the item. In the sales statistics window, the number of units per parcel on the line helps to determine the total number of units for all the lines for the particular sales document.';
            }
            field("Use Duplication List"; Rec."Use Duplication List")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Use Duplication List field.';
            }
            field("VAT %"; Rec."VAT %")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the VAT % field.';
            }
            field("VAT Base Amount"; Rec."VAT Base Amount")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the VAT Base Amount field.';
            }
            field("VAT Bus. Posting Group"; Rec."VAT Bus. Posting Group")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the VAT Bus. Posting Group field.';
            }
            field("VAT Calculation Type"; Rec."VAT Calculation Type")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the VAT Calculation Type field.';
            }
            field("VAT Prod. Posting Group"; Rec."VAT Prod. Posting Group")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the VAT Prod. Posting Group field.';
            }

        }

        addafter("No.")
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
            field("Flock No."; Rec."Flock No.")
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
            field("Shipment Amount"; Rec."Shipment Amount")
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

        }
    }

    actions
    {
        // Add changes to page actions here
    }
    trigger OnOpenPage()
    begin
        Rec.FILTERGROUP(2);
        InventoryPeriod.IsValidDate(InventoryOpenedFrom);
        IF InventoryOpenedFrom <> 0D THEN
            IF Rec.GETFILTER("Posting Date") = '' THEN
                Rec.SETFILTER("Posting Date", '%1..', CALCDATE('<+1D>', InventoryOpenedFrom))
            ELSE BEGIN
                IF Rec.GETFILTER("Posting Date") <> STRSUBSTNO('%1..', CALCDATE('<+1D>', InventoryOpenedFrom)) THEN
                    Rec.SETFILTER("Posting Date",
                      STRSUBSTNO('%2&%1..', CALCDATE('<+1D>', InventoryOpenedFrom), Rec.GETFILTER("Posting Date")))
            END;
        Rec.FILTERGROUP(0);
    end;

    var
        myInt: Integer;
        InventoryPeriod: Record 5814;
        InventoryOpenedFrom: Date;
}