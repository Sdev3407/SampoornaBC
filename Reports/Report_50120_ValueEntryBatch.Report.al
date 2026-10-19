// report 50120 "Value Entry Batch"
// {

//     UsageCategory = Administration;
//     Caption = 'Value Entry Batch';
//     ApplicationArea = All;
//     DefaultLayout = RDLC;
//     RDLCLayout = 'ReportLayout\ValueEntRep.rdl';
//     dataset
//     {
//         dataitem("Value Entry"; "Value Entry")
//         {
//             RequestFilterFields = "Document No.", "Posting Date";
//             DataItemTableView = where("Item Charge No." = filter(<> ''));
//             column(Document_No_; "Document No.")
//             { }
//             column(Document_Date; "Document Date")
//             { }
//             column(Item_Charge_No_; "Item Charge No.")
//             { }
//             column(Item_No_; "Item No.")
//             { }
//             column(Item_Ledger_Entry_Quantity; "Item Ledger Entry Quantity")
//             { }
//             column(Valued_Quantity; "Valued Quantity")
//             { }
//             column(Entry_No_; "Entry No.")
//             { }
//             column(Item_Ledger_Entry_No_; "Item Ledger Entry No.")
//             { }
//             column(Cost_Amount__Actual_; "Cost Amount (Actual)")
//             { }
//             column(Cost_Posted_to_G_L; "Cost Posted to G/L")
//             { }
//             column(DirectCostGenGen; DirectCostGenGen)
//             {

//             }
//             column(InvAccGl; InvAccGl)
//             { }
//             column(InventoryAmount; InventoryAmount)
//             { }
//             column(venAmt; venAmt)
//             { }
//             column(GSTAMt; GSTAMt)
//             { }
//             column(Avilment; Avilment)
//             { }
//             trigger OnAfterGetRecord()
//             begin
//                 Clear(Avilment);
//                 GSTLedger.Reset();
//                 GSTLedger.SetRange("Document No.", "Value Entry"."Document No.");
//                 if GSTLedger.FindFirst() then
//                     Avilment := GSTLedger.Availment;

//                 Clear(DirectCostGenGen);
//                 Clear(InvAccGl);
//                 Clear(InventoryAmount);
//                 Clear(venAmt);
//                 Clear(GSTAMt);
//                 GenItemrel.Reset();
//                 GenItemrel.SetRange("Value Entry No.", "Value Entry"."Entry No.");
//                 if GenItemrel.FindFirst() then begin
//                     repeat
//                         GLEnTry.Reset();
//                         GLEnTry.SetRange("Entry No.", GenItemrel."G/L Entry No.");
//                         GLEnTry.SetRange("G/L Account No.", '132202');
//                         if GLEnTry.FindFirst() then begin
//                             DirectCostGenGen += GLEnTry.Amount;
//                         end;

//                         GLEnTry.Reset();
//                         GLEnTry.SetRange("Entry No.", GenItemrel."G/L Entry No.");
//                         if GLEnTry.FindFirst() then begin
//                             if GLEnTry."G/L Account No." IN ['107621', '107622', '107623', '107624', '107625', '107626', '107627', '107628', '107629', '107630', '107631', '107691', '107692', '107693', '107694', '107695', '107696', '107762', '107801', '107803', '107805', '107806', '107871', '107872', '107873', '107874', '107875', '107901', '107921', '107922', '107923', '107963', '107965', '107981', '107983', '108201', '108202', '108401', '108602', '108603', '108805', '109101', '109102', '109103', '109104', '109304', '109501', '109707', '109801'] then begin
//                                 InvAccGl += GLEnTry."G/L Account No.";
//                                 InventoryAmount += GLEnTry.Amount;
//                             end;
//                         end;
//                         GLEnTry.Reset();
//                         GLEnTry.SetRange("Document No.", "Value Entry"."Document No.");
//                         // GLEnTry.SetRange("Entry No.", GenItemrel."G/L Entry No.");
//                         GLEnTry.SetFilter("G/L Account No.", '%1|%2|%3', '116420', '116450', '110100');
//                         if GLEnTry.FindFirst() then begin
//                             venAmt := GLEnTry.Amount;
//                         end;

//                         GLEnTry.Reset();
//                         GLEnTry.SetRange("Document No.", "Value Entry"."Document No.");
//                         // GLEnTry.SetRange("Entry No.", GenItemrel."G/L Entry No.");
//                         // GLEnTry.SetFilter("G/L Account No.", '%1|%2', '116420', '116450');
//                         if GLEnTry.FindFirst() then begin
//                             repeat
//                                 if GLEnTry."G/L Account No." IN ['111610', '111611', '111612', '111613', '111614', '111615', '116801', '116802', '116803', '116804', '116805', '116806'] then
//                                     GSTAMt := GLEnTry.Amount;
//                             until GLEnTry.Next() = 0;
//                         end;
//                     until GenItemrel.Next() = 0;
//                 end;
//             end;

//         }
//     }
//     var
//         DirectCostGl: Code[20];
//         DirectCostGenGen: Decimal;
//         InvAccGl: Code[20];
//         InventoryAmount: Decimal;
//         venAmt: Decimal;
//         GSTAMt: Decimal;
//         Avilment: Boolean;
//         ItemAppEN: Record "Item Application Entry";
//         GenItemrel: Record 5823;
//         GLEnTry: Record "G/L Entry";
//         GSTLedger: Record "GST Ledger Entry";

// }