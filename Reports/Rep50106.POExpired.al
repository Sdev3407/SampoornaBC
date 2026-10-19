// report 50106 "PO Expired"
// {
//     ApplicationArea = all;
//     //UsageCategory = ReportsAndAnalysis;
//     ProcessingOnly = true;
//     Caption = 'PO Expired';
//     dataset
//     {
//         dataitem("Purchase Header"; "Purchase Header")
//         {
//             DataItemTableView = SORTING("No.") Where("Document Type" = const(Order));
//             trigger OnAfterGetRecord()
//             var
//                 PurhHeader: record "Purchase Header";
//                 PurchLine: Record "Purchase Line";
//                 Time: Time;
//             begin
//                 // PurhHeader.Reset();
//                 // PurhHeader.SetRange("No.", "Purchase Header"."No.");
//                 // PurhHeader.SetRange(Status, "Purchase Header".Status::Released);
//                 // PurhHeader.SetFilter("PO Expiration Date", '..%1', (WorkDate() - 1));
//                 // PurhHeader.SetRange("Document Type", PurhHeader."Document Type"::Order);
//                 // PurhHeader.SetRange("PO Type", PurhHeader."PO Type"::Goods);
//                 // if PurhHeader.FindFirst() Then
//                 //     repeat
//                 //         PurchLine.Reset();
//                 //         PurchLine.SetRange("Document No.", "Purchase Header"."No.");
//                 //         PurchLine.SetRange("Item Category Code", 'RM');
//                 //         if PurchLine.FindFirst() Then begin
//                 //             PurhHeader.Status := Status::Expired;
//                 //             PurhHeader.Modify();
//                 //         end;
//                 //     Until PurhHeader.Next() = 0;
//                 // // Time := DT2Time(CurrentDateTime);
//                 // // If Format(Time) = '10:00 AM' Then
//                 // PurhHeader.Reset();
//                 // PurhHeader.SetRange("No.", "Purchase Header"."No.");
//                 // PurhHeader.SetRange(Status, "Purchase Header".Status::Open);
//                 // PurhHeader.SetRange("Document Type", PurhHeader."Document Type"::Order);
//                 // PurhHeader.SetFilter("Vendor Posting Group", '<>%1', 'INTER BRANCH TRANSFE');
//                 // PurhHeader.SetRange("Order Date", WorkDate() - 1);
//                 // if PurhHeader.FindFirst() Then
//                 //     repeat
//                 //         PurhHeader.Block := True;
//                 //         PurhHeader.Status := Status::Expired;
//                 //         PurhHeader.Modify();
//                 //     until PurhHeader.Next() = 0;

//             end;

//         }

//     }
// }