page 50017 "Posted Sales Shipment API"
{

    PageType = API;
    DelayedInsert = true;
    SourceTable = "Sales Shipment Header";
    SourceTableView = sorting("No.") where(OTP = filter(<> 0), "OTP Varified" = filter(false));
    ApplicationArea = All;
    UsageCategory = Lists;
    ChangeTrackingAllowed = true;
    EntityCaption = 'Posted Sales Shipment';
    EntitySetCaption = 'Posted Sales Shipment';
    EntityName = 'postedSalesshipment';
    EntitySetName = 'postedSalesshipment';
    InsertAllowed = false;
    DeleteAllowed = false;
    ModifyAllowed = false;


    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Order_No_"; Rec."Order No.")
                {
                    ApplicationArea = All;
                }
                field(CustomerCode; Rec."Sell-to Customer No.")
                {
                    ApplicationArea = All;
                }
                field(CustomerName; Rec."Sell-to Customer Name")
                {
                    ApplicationArea = All;
                }
                field(PostingDate; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field(SalespersonCode; Rec."Salesperson Code")
                {
                    ApplicationArea = All;
                }
                field("TeamCode"; Rec."Team Code")
                {
                    ApplicationArea = All;
                }
                field(OTP; Rec.OTP)
                {
                    ApplicationArea = All;
                }
                field("OTPVarified"; Rec."OTP Varified")
                {
                    ApplicationArea = All;
                }

            }
        }
    }

    var
    // Pagetypr: Page 9970
}

