report 50090 "Consumption Report"
{
    UsageCategory = ReportsAndAnalysis;
    Caption = 'Consumption Report';
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'ReportLayout\COnsumptionDetail.rdl';

    dataset
    {
        dataitem("Item Ledger Entry"; "Item Ledger Entry")
        {
            RequestFilterFields = "Posting Date";
            column(Posting_Date; "Posting Date")
            { }
            column(Document_No_; "Document No.")
            { }
            column(Item_No_; "Item No.")
            { }
            column(Item_Name; "Item Name")
            { }
            column(Item_Category_Code; "Item Category Code")
            { }
            column(Quantity; (Quantity * -1))
            { }
            column(Rate; Rate)
            { }
            column(Cost_Amount__Actual_; ("Cost Amount (Actual)" * -1))
            { }
            column(Global_Dimension_1_Code; "Global Dimension 1 Code")
            { }
            column(Global_Dimension_2_Code; "Global Dimension 2 Code")
            { }
            column(Location_Code; "Location Code")
            { }
            column(LocationName; LocationName)
            { }
            column(GLCode; GLCode)
            { }
            column(GLName; GLName)
            { }

            trigger OnAfterGetRecord()
            var
                VLE: Record "Value Entry";
                GLItemLedgRelation: Record "G/L - Item Ledger Relation";
                GLEntry: Record "G/L Entry";
                GLaccount: Record "G/L Account";

            begin
                Clear(GLCode);
                Clear(GLName);
                Location.Get("Item Ledger Entry"."Location Code");
                LocationName := Location.Name;
                Rate := 0;
                "Item Ledger Entry".CalcFields("Cost Amount (Actual)");
                if "Item Ledger Entry"."Cost Amount (Actual)" <> 0 then
                    Rate := Round("Item Ledger Entry"."Cost Amount (Actual)" / "Item Ledger Entry".Quantity, 0.01);
                VLE.Reset();
                VLE.SetRange("Item Ledger Entry No.", "Item Ledger Entry"."Entry No.");
                VLE.Setfilter("Cost Amount (Actual)", '<>%1', 0);
                VLE.SetRange("Item No.", "Item Ledger Entry"."Item No.");
                VLE.SetRange("Location Code", "Item Ledger Entry"."Location Code");
                if VLE.FindFirst() then begin
                    GLItemLedgRelation.SetCurrentKey("Value Entry No.");
                    GLItemLedgRelation.SetRange("Value Entry No.", VLE."Entry No.");
                    if GLItemLedgRelation.FindSet() then
                        repeat
                            GLEntry.Get(GLItemLedgRelation."G/L Entry No.");
                            GLaccount.Reset();
                            GLaccount.SetRange("No.", GLEntry."G/L Account No.");
                            GLaccount.SetRange("Income/Balance", GLaccount."Income/Balance"::"Income Statement");
                            if GLaccount.FindFirst() then begin
                                GLCode := GLaccount."No.";
                                GLName := GLaccount.Name;
                            end;


                        until GLItemLedgRelation.Next() = 0;

                end;


            end;

            trigger OnPreDataItem()
            var
                myInt: Integer;
            begin
                "Item Ledger Entry".SetRange(Consumption, true);
                //"Item Ledger Entry".SetRange("Entry Type", "Item Ledger Entry"."Entry Type"::"Negative Adjmt.");

            end;


        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        Rate: Decimal;
        GLCode: Text;
        GLName: Text;
        LocationName: Text;
        Location: Record Location;
}

