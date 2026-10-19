pageextension 50119 SalesOrderStatisticsExt extends "Sales Order Statistics"
{
    layout
    {
        addafter("Cust.""Credit Limit (LCY)""")
        {
            field("P.A.N. No."; Rec."P.A.N. No.")
            {
                ApplicationArea = All;

            }
            field("No. of Birds"; Rec."No. of Birds")
            {
                ApplicationArea = All;

            }
            field(Weight; Rec.Weight)
            {
                ApplicationArea = All;

            }
            field("Farmer Grade"; Rec."Farmer Grade")
            {
                ApplicationArea = All;

            }
            field("Bank Account No."; Rec."Bank Account No.")
            {
                ApplicationArea = All;

            }
            field("Transporter Code"; Rec."Transporter Code")
            {
                ApplicationArea = All;

            }
            field(Freight; Rec.Freight)
            {
                ApplicationArea = All;

            }
            field("Terms Code"; Rec."Terms Code")
            {
                ApplicationArea = All;

            }
            field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
            {
                ApplicationArea = All;

            }
            field("Freight Value"; Rec."Freight Value")
            {
                ApplicationArea = All;

            }
            field("Against Original Invoice Date"; Rec."Against Original Invoice Date")
            {
                ApplicationArea = All;

            }
            field("Against Original Invoice No."; Rec."Against Original Invoice No.")
            {
                ApplicationArea = All;

            }
            field("DC No."; Rec."DC No.")
            {
                ApplicationArea = All;

            }
            field("Gross Weight"; Rec."Gross Weight")
            {
                ApplicationArea = All;

            }
            field("Net Weight"; Rec."Net Weight")
            {
                ApplicationArea = All;

            }
            field("Tier Weight"; Rec."Tier Weight")
            {
                ApplicationArea = All;

            }

            field(Average; Rec.Average)
            {
                ApplicationArea = All;

            }
            field(Statistics; Rec.Statistics)
            {
                ApplicationArea = All;

            }

            field("Driver Mobile No."; Rec."Driver Mobile No.")
            {
                ApplicationArea = All;

            }
            field("Broker Code"; Rec."Broker Code")
            {
                ApplicationArea = All;

            }
            field("Item Category Code"; Rec."Item Category Code")
            {
                ApplicationArea = All;

            }

            field("Product Group Code"; Rec."Product Group Code")
            {
                ApplicationArea = All;

            }
            field("Entry Date"; Rec."Entry Date")
            {
                ApplicationArea = All;

            }

            field("Line Narration"; Rec."Line Narration")
            {
                ApplicationArea = All;

            }

        }
    }

    actions
    {
        // Add changes to page actions here
    }
    trigger OnAfterGetRecord()
    var
        // GSTManagement: Codeunit 16401;
        SalesLine: Record 37;
        GLSetup: Record 98;
        TransactionType: Option Purchase,Sale,Transfer,Service;
        SalesLineQty: Decimal;
    begin

    end;

    local procedure IsGSTAssessable(): Boolean
    var
        SalesLine: Record 37;
    begin
        SalesLine.SETRANGE("Document Type", Rec."Document Type");
        SalesLine.SETRANGE("Document No.", Rec."No.");
        SalesLine.SETRANGE("GST On Assessable Value", TRUE);
        IF SalesLine.FINDFIRST THEN
            EXIT(TRUE);
    end;

    var
        myInt: Integer;
}