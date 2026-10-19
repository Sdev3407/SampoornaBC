// report 50025 "Customer Statement New"
// {
//     UsageCategory = Administration;
//     Caption = 'Customer Statement New Report';
//     ApplicationArea = All;
//     DefaultLayout = RDLC;
//     RDLCLayout = 'ReportLayout\CustomerStatementNew.rdl';
//     dataset
//     {
//         dataitem(Customer; Customer)
//         {
//             RequestFilterFields = "No.";
//             column(No_Customer; Customer."No.")
//             {
//             }
//             dataitem(CopyLoop; 2000000026)
//             {
//                 DataItemTableView = SORTING(Number);
//                 column(CopyLoopNumber; CopyLoop.Number)
//                 {
//                 }
//                 column(OutputNo; OutputNo)
//                 {
//                 }
//                 column(CopyText; CopyText)
//                 {
//                 }
//                 column(PageNoofLoop; Number)
//                 {
//                 }
//                 column(DocumentCaptionCopyText; STRSUBSTNO(Text000, CopyText))
//                 {
//                 }
//                 column(CompanyAddr1; CompanyAddr[1])
//                 {
//                 }
//                 column(CompanyAddr2; CompanyAddr[2])
//                 {
//                 }
//                 column(CompanyAddr3; CompanyAddr[3])
//                 {
//                 }
//                 column(CompanyAddr4; CompanyAddr[4])
//                 {
//                 }
//                 column(CompanyAddr5; CompanyAddr[5])
//                 {
//                 }
//                 column(CompanyAddr6; CompanyAddr[6])
//                 {
//                 }
//                 column(CompanyInfoPicture; CompanyInfo.Picture)
//                 {
//                 }
//                 column(PhoneNo_Comp; CompanyInfo."Phone No.")
//                 {
//                 }
//                 column(Email_Comp; CompanyInfo."E-Mail")
//                 {
//                 }
//                 column(GSTIN_Comp; CompanyInfo."GST Registration No.")
//                 {
//                 }
//                 column(CustomerAddr1; Customer.Name)
//                 {
//                 }
//                 column(CustomerAddr2; Customer."Name 2")
//                 {
//                 }
//                 column(CustomerAddr3; Customer.Address)
//                 {
//                 }
//                 column(CustomerAddr4; Customer."Address 2")
//                 {
//                 }
//                 column(CustomerAddr5; Customer.City)
//                 {
//                 }
//                 column(CustomerAddr6; Customer."Post Code")
//                 {
//                 }
//                 column(CustomerAddr7; Customer.County + VendorAddress)
//                 {
//                 }
//                 column(PhoneNo_Customer; Customer."Phone No.")
//                 {
//                 }
//                 column(Email_Customer; Customer."E-Mail")
//                 {
//                 }
//                 column(TinNo_Customer; Customer."GST Registration No.")
//                 {
//                 }
//                 column(TodayDT; CURRENTDATETIME)
//                 {
//                 }
//                 column(VendDrCrCaption; CustDrCrCaption)
//                 {
//                 }
//                 column(PrintDate; PrintDate)
//                 {
//                 }
//                 dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
//                 {
//                     DataItemLink = "Customer No." = FIELD("No.");
//                     DataItemLinkReference = Customer;
//                     DataItemTableView = SORTING("Posting Date")
//                                         WHERE(Reversed = CONST(false));
//                     column(CustomerNo_CLE; "Cust. Ledger Entry"."Sell-to Customer No.")
//                     {
//                     }
//                     column(PostingDate_CLE; "Cust. Ledger Entry"."Posting Date")
//                     {
//                     }
//                     column(DocType_CLE; "Cust. Ledger Entry"."Document Type")
//                     {
//                     }
//                     column(ExtDocNo_CLE; "Cust. Ledger Entry"."External Document No.")
//                     {
//                     }
//                     column(DocNo_CLE; "Cust. Ledger Entry"."Document No.")
//                     {
//                     }
//                     column(Desc_CLE; "Cust. Ledger Entry".Description)
//                     {
//                     }
//                     column(DrAmnt_CLE; "Cust. Ledger Entry"."Debit Amount")
//                     {
//                     }
//                     column(CrAmnt_CLE; "Cust. Ledger Entry"."Credit Amount")
//                     {
//                     }
//                     column(CustOpeningBalance; CustOpeningBalance)
//                     {
//                     }
//                     column(CustRunningBalance; CustRunningBalance)
//                     {
//                     }
//                     column(DrCrCaption; DrCrCaption)
//                     {
//                     }
//                     column(AmountWords; numtext1[1])
//                     {
//                     }
//                     column(TCSAmnt_CLE; TCSAmt)
//                     {
//                     }
//                     column(TcsAmt1; TcsAmt1)
//                     {
//                     }

//                     trigger OnAfterGetRecord()
//                     begin
//                         /////CLEAR(VendRunningBalance);

//                         //-->Running Balance

//                         "Cust. Ledger Entry".CALCFIELDS("Debit Amount");
//                         "Cust. Ledger Entry".CALCFIELDS("Credit Amount");
//                         CustRunningBalance := (CustRunningBalance + "Cust. Ledger Entry"."Debit Amount" - "Cust. Ledger Entry"."Credit Amount");

//                         IF CustRunningBalance > 0 THEN
//                             DrCrCaption := 'Dr'
//                         ELSE
//                             DrCrCaption := 'Cr';

//                         //<--Running Balance

//                         //-->Amount in Words
//                         Check1.InitTextVariable;
//                         Check1.FormatNoText1(numtext1, ABS(CustRunningBalance), '');
//                         //<--Amount in Words

//                         //PTPL 011220 #P0272
//                         TCSAmt := '';
//                         TCSEntry.RESET;
//                         TCSEntry.SETRANGE("Document No.", "Cust. Ledger Entry"."Document No.");
//                         IF TCSEntry.FINDFIRST THEN BEGIN
//                             IF "Cust. Ledger Entry"."Credit Amount" < 0 THEN
//                                 TCSAmt := '-' + FORMAT(TCSEntry."TCS Amount")
//                             ELSE
//                                 TCSAmt := FORMAT(TCSEntry."TCS Amount");

//                         END ELSE
//                             TCSAmt := '0.00';
//                         IF TCSAmt = '0' THEN
//                             TCSAmt := '0.00';
//                         CLEAR(TcsAmt1);
//                         tcsEntry11.RESET;
//                         tcsEntry11.SETRANGE("Document No.", "Document No.");
//                         IF tcsEntry11.FINDFIRST THEN
//                             REPEAT
//                                 TcsAmt1 += tcsEntry11."TCS Amount";
//                             UNTIL tcsEntry11.NEXT = 0;
//                     end;

//                     trigger OnPreDataItem()
//                     begin
//                         "Cust. Ledger Entry".SETFILTER("Posting Date", '%1..%2', StartDate, EndDate);
//                         CLEAR(CustRunningBalance);
//                         CustRunningBalance := CustOpeningBalance;
//                     end;
//                 }

//                 trigger OnAfterGetRecord()
//                 begin
//                     IF Number > 1 THEN
//                         CopyText := Text003;
//                     CurrReport.PAGENO := 1;

//                     OutputNo += 1;
//                 end;

//                 trigger OnPreDataItem()
//                 begin
//                     NoOfLoops := ABS(NoOfCopies) + 1;
//                     IF NoOfLoops <= 0 THEN
//                         NoOfLoops := 1;
//                     CopyText := '';
//                     SETRANGE(Number, 1, NoOfLoops);

//                     OutputNo := 1;
//                 end;
//             }

//             trigger OnAfterGetRecord()
//             begin
//                 CompanyInfo.CALCFIELDS(Picture);
//                 FormatAddr.Company(CompanyAddr, CompanyInfo);
//                 FormatAddr.Customer(CustomerAddr, Customer);

//                 //-->Opening Balance
//                 CustOpeningBalance := 0.0;
//                 CLERec.RESET;
//                 CLEAR(CustOpeningBalance);
//                 CLERec.SETRANGE("Customer No.", Customer."No.");
//                 CLERec.SETFILTER("Posting Date", '<%1', StartDate);
//                 IF CLERec.FINDSET THEN
//                     REPEAT
//                         CLERec.CALCFIELDS("Original Amt. (LCY)");
//                         CustOpeningBalance := CustOpeningBalance + CLERec."Original Amt. (LCY)";
//                     UNTIL CLERec.NEXT = 0;
//                 //<--Opening Balance
//                 //->Opening Balance Dr Cr Caption
//                 IF CustOpeningBalance > 0 THEN
//                     CustDrCrCaption := TRUE
//                 ELSE
//                     CustDrCrCaption := FALSE;
//                 //<-Opening Balance Dr Cr Caption

//                 IF CountryRegionRec.GET(Customer."Country/Region Code") THEN
//                     VendorAddress := CountryRegionRec.Name;
//             end;
//         }
//     }

//     requestpage
//     {
//         SaveValues = true;

//         layout
//         {
//             area(content)
//             {
//                 group(Options)
//                 {
//                     Caption = 'Options';
//                     field(StartDate; StartDate)
//                     {
//                         Caption = 'Starting Date';
//                         ApplicationArea = All;
//                     }
//                     field(EndDate; EndDate)
//                     {
//                         Caption = 'Ending Date';
//                         ApplicationArea = All;
//                     }
//                     field(NoOfCopies; NoOfCopies)
//                     {
//                         Caption = 'No. of Copy';
//                         ApplicationArea = All;
//                     }
//                 }
//             }
//         }

//         actions
//         {
//         }
//         trigger OnOpenPage()
//         begin
//             //WithoutNarration := TRUE;
//             Error('Can not use this report Please search report for Statement "Customer Statement_N Report"');
//         end;
//     }

//     labels
//     {
//     }

//     trigger OnPreReport()
//     begin
//         //Error('Can not use this report Please search report for Statement "Customer Statement_N Report"');
//         IF StartDate <> 0D THEN BEGIN
//             IF EndDate = 0D THEN
//                 ERROR('You Must Specify the End Date')
//         END ELSE
//             ERROR('You Must Specify the Start Date');
//         PrintDate := 'Period From ' + FORMAT(StartDate) + ' To ' + FORMAT(EndDate);

//         CompanyInfo.GET;
//     end;

//     var
//         StartDate: Date;
//         EndDate: Date;
//         NoOfCopies: Integer;
//         NoOfLoops: Integer;
//         CopyText: Text[50];
//         OutputNo: Integer;
//         Text003: Label 'COPY';
//         CompanyAddr: array[8] of Text[50];
//         CompanyInfo: Record 79;
//         FormatAddr: Codeunit 365;
//         Text000: Label 'Customer Statement %1';
//         CustomerAddr: array[9] of Text;
//         CustOpeningBalance: Decimal;
//         CustRunningBalance: Decimal;
//         CLERec: Record 21;
//         DrCrCaption: Text;
//         check1: Report 50101;
//         numtext1: array[2] of Text;
//         AmountInWords: Text;
//         RunningDrBalance: Decimal;
//         CustDrCrCaption: Boolean;
//         VendorAddress: Text;
//         CountryRegionRec: Record 9;
//         PrintDate: Text[50];
//         TCSAmt: Text;
//         TCSEntry: Record "TCS Entry";//16514;
//         TcsAmt1: Decimal;
//         tcsEntry11: Record "TCS Entry";//16514;
// }

