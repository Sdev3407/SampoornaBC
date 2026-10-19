report 50129 "Update VE Entry"
{
    /*******************************************************************************************
    Name : Developed By Satish FOR SFPL
    Date : 04/12/2023
    Remarks: Update Value Entry and General ledger entry
    ********************************************************************************************/
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    ProcessingOnly = true;
    Permissions = tabledata "G/L Entry" = RIMD,
    tabledata "Value Entry" = RIMD;
    dataset
    {
        dataitem("Purch. Inv. Header"; "Purch. Inv. Header")
        {
            RequestFilterFields = "No.";
            trigger OnAfterGetRecord()
            var
                Valuecrcost: Decimal;
            begin
                Counter := 0;
                Clear(Valuecrcost);
                Progress.OPEN(Text000, Counter);
                PurchLine.Reset();
                PurchLine.SetRange(PurchLine."Document No.", "Purch. Inv. Header"."No.");
                //PurchLine.SetFilter(PurchLine.Type, '<>%1', PurchLine.Type::"Charge (Item)");
                if PurchLine.FindSet() then begin
                    repeat
                        Valuecrcost := 0;
                        Counter := Counter + 1;
                        ValueEntry.Reset();
                        ValueEntry.SetRange(ValueEntry."Document No.", PurchLine."Document No.");
                        ValueEntry.SetRange(ValueEntry."Document Line No.", PurchLine."Line No.");
                        ValueEntry.SetRange("Entry Type", ValueEntry."Entry Type"::"Direct Cost");
                        if ValueEntry.FindSet() then
                            repeat
                                IF PurchLine.Type = PurchLine.Type::"Charge (Item)" then begin
                                    if PurchLine."GST Credit" = PurchLine."GST Credit"::Availment then
                                        Valuecrcost := GetChargeItemcost(ValueEntry, PurchLine."Amount Including VAT") * ValueEntry."Valued Quantity"
                                    else
                                        if PurchLine."GST Credit" = PurchLine."GST Credit"::"Non-Availment" then
                                            Valuecrcost := GetChargeItemcost(ValueEntry, PurchLine."Amount Including VAT" + GetLineamt(PurchLine)) * ValueEntry."Valued Quantity"
                                        else
                                            Valuecrcost := GetChargeItemcost(ValueEntry, PurchLine."Amount Including VAT" + GetLineamt(PurchLine)) * ValueEntry."Valued Quantity";
                                    if (Valuecrcost) <> ValueEntry."Cost Amount (Actual)" then begin
                                        ValueEntry.Validate("Cost per Unit", GetChargeItemcost(ValueEntry, PurchLine."Amount Including VAT" + GetLineamt(PurchLine)));
                                        ValueEntry.Validate("Cost Amount (Actual)", Valuecrcost);
                                        ValueEntry.Validate("Cost Posted to G/L", Valuecrcost);
                                        ValueEntry.Validate("Purchase Amount (Actual)", Valuecrcost);
                                        ValueEntry.Modify();
                                        UpdateGeneralLedger(ValueEntry, Valuecrcost)
                                    end;
                                end else begin
                                    if (PurchLine."Amount Including VAT") <> ValueEntry."Cost Amount (Actual)" then begin
                                        Valuecrcost := 0;
                                        IF PurchLine."GST Credit" = PurchLine."GST Credit"::Availment then begin
                                            ValueEntry.Validate("Cost per Unit", PurchLine."Amount Including VAT" / ValueEntry."Valued Quantity");
                                            ValueEntry.Validate("Cost Amount (Actual)", PurchLine."Amount Including VAT");
                                            ValueEntry.Validate("Cost Posted to G/L", PurchLine."Amount Including VAT");
                                            ValueEntry.Validate("Purchase Amount (Actual)", PurchLine."Amount Including VAT");
                                            Valuecrcost := PurchLine."Amount Including VAT";
                                        end;
                                        if PurchLine."GST Credit" = PurchLine."GST Credit"::"Non-Availment" then begin
                                            ValueEntry.Validate("Cost Amount (Actual)", (PurchLine."Amount Including VAT") + GetLineamt(PurchLine));
                                            ValueEntry.Validate("Cost Posted to G/L", (PurchLine."Amount Including VAT") + GetLineamt(PurchLine));
                                            Valuecrcost := PurchLine."Amount Including VAT" + GetLineamt(PurchLine);
                                            ValueEntry.Validate("Purchase Amount (Actual)", Valuecrcost);
                                            ValueEntry.Validate("Cost per Unit", Valuecrcost / ValueEntry."Valued Quantity");
                                        end;
                                        if PurchLine."GST Credit" = PurchLine."GST Credit"::" " then begin
                                            ValueEntry.Validate("Cost Amount (Actual)", (PurchLine."Amount Including VAT"));
                                            ValueEntry.Validate("Cost Posted to G/L", (PurchLine."Amount Including VAT"));
                                            Valuecrcost := PurchLine."Amount Including VAT";
                                            ValueEntry.Validate("Purchase Amount (Actual)", Valuecrcost);
                                            ValueEntry.Validate("Purchase Amount (Actual)", Valuecrcost);
                                            ValueEntry.Validate("Cost per Unit", Valuecrcost / ValueEntry."Valued Quantity");
                                        end;
                                    end;
                                    ValueEntry.Modify();
                                    UpdateGeneralLedger(ValueEntry, Valuecrcost)
                                end;

                                Progress.Update();
                            until ValueEntry.Next() = 0;
                    //Progress.Close();
                    until PurchLine.Next() = 0;
                end;

            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    field(myInt; myInt)
                    {
                        ApplicationArea = All;

                    }
                }
            }
        }


    }
    local procedure UpdateGeneralLedger(ValueEnt: Record "Value Entry"; AmounttoUpdate: Decimal)
    var
        GLItemLedgRelation: Record "G/L - Item Ledger Relation";
        GLEntry: Record "G/L Entry";
    begin
        GLItemLedgRelation.SetCurrentKey("Value Entry No.");
        GLItemLedgRelation.SetRange("Value Entry No.", ValueEnt."Entry No.");
        if GLItemLedgRelation.FindSet() then
            repeat
                IsNegative := false;
                IF GLEntry.Get(GLItemLedgRelation."G/L Entry No.") then begin
                    if GLEntry.Amount < 0 then
                        IsNegative := true;
                    if IsNegative then begin
                        GLEntry.Validate("Credit Amount", Abs(AmounttoUpdate));
                        AmounttoUpdate := AmounttoUpdate * -1;
                    end else
                        GLEntry.Validate("Debit Amount", Abs(AmounttoUpdate));
                    GLEntry.Validate(Amount, AmounttoUpdate);
                    GLEntry.Modify();
                end;
            until GLItemLedgRelation.Next() = 0;
    end;

    local procedure GetChargeItemcost(ValueEnty: Record "Value Entry"; lineamt: Decimal): Decimal
    var
        CrCost: Decimal;
        ValEntry: Record "Value Entry";
    begin
        CrCost := 0;
        ValEntry.Reset();
        ValEntry.SetRange(ValEntry."Document No.", PurchLine."Document No.");
        ValEntry.SetRange(ValEntry."Document Line No.", PurchLine."Line No.");
        ValEntry.SetRange(ValEntry."Entry Type", ValueEntry."Entry Type"::"Direct Cost");
        IF ValEntry.FindSet() then
            repeat
                CrCost += ValEntry."Valued Quantity";
            until ValEntry.Next() = 0;
        If CrCost <> 0 then
            exit(lineamt / CrCost)
        else
            exit(0);
    end;

    local procedure GetLineamt(LrPurchLine: Record "Purch. Inv. Line"): Decimal
    var
        LineAmt: Decimal;
        DGstLedger: Record 18001;
    begin
        DGstLedger.Reset();
        DGstLedger.SetRange("Document No.", LrPurchLine."Document No.");
        DGstLedger.SetRange("Document Line No.", LrPurchLine."Line No.");
        DGstLedger.SetRange("Entry Type", DGstLedger."Entry Type"::"Initial Entry");
        IF DGstLedger.FindSet() then
            repeat
                LineAmt += DGstLedger."GST Amount";
            until DGstLedger.Next() = 0;
        exit(LineAmt)
    end;

    var
        myInt: Integer;
        PurchLine: Record "Purch. Inv. Line";
        ValueEntry: Record "Value Entry";
        Test: Page 5802;
        Progress: Dialog;
        Counter: Integer;
        Text000: Label 'Counting to 100 ------ #1';
        IsNegative: Boolean;
        puyy: Codeunit 231;
}