report 50057 "TCS Entry"
{
    Caption = 'TCS Entries Report';
    UsageCategory = Administration;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'ReportLayout\TCSEntry.rdl';


    dataset
    {
        dataitem("TCS Entry"; "TCS Entry")
        {
            DataItemTableView = Where("TCS %" = filter(<> 0));  //PRU SH
            //                     ORDER(Ascending);  //PRU SH
            RequestFilterFields = "Document No.";
            column(EntryNo_TDSEntry; "TCS Entry"."Entry No.")
            {
            }
            column(TDSBaseAmount_TDSEntry; "TCS Entry"."TCS Base Amount")
            {
            }
            /*    //PRU SH
            column(PartyType_TDSEntry; "TCS Entry"."Party Type")
            {
            }
            column(PartyCode_TDSEntry; "TCS Entry"."Party Code")
            {
            }
            column(TCSType_TCSEntry; "TCS Entry"."TCS Type")
            {
            }
            */   //PRU SH
            column(PartyType_TDSEntry; PartyType_TDSEntry)
            {
            }
            column(PartyCode_TDSEntry; PartyCode_TDSEntry)
            {
            }
            column(TCSType_TCSEntry; TCSType_TCSEntry)
            {
            }
            column(TDSAmount_TDSEntry; "TCS Entry"."TCS Amount")
            {
            }
            column(TDS_TDSEntry; "TCS Entry"."TCS %")
            {
            }

            column(PartyName; PartyName)
            {
            }

            column(SNo; Sno)
            {
            }
            column(Sno_2; FORMAT(Sno_2))
            {
            }
            column(Name; CompInfo.Name)
            {
            }
            column(Name2; CompInfo."Name 2")
            {
            }
            column(Address; CompInfo.Address)
            {
            }
            column(Address2; CompInfo."Address 2")
            {
            }
            column(City; CompInfo.City)
            {
            }
            column(PostCode; CompInfo."Post Code")
            {
            }
            column(Country; CompInfo.County)
            {
            }
            column(Email; CompInfo."E-Mail")
            {
            }
            column(Picture; CompInfo.Picture)
            {
            }
            column(AssesseeCode_TDSEntry; "TCS Entry"."Assessee Code")
            {
            }
            column(DocumentNo_TDSEntry; "TCS Entry"."Document No.")
            {
            }
            column(PostingDate; PostingDate)
            {
            }
            column(PANNo; PANNo)
            {
            }
            column(VendorCode; TDSPartyCode)
            {
            }
            column(BranchCode; BranchCode)
            {
            }
            column(LOC; LOC)
            {
            }
            column(LOB; LOB)
            {
            }

            trigger OnAfterGetRecord()
            begin
                IF "TCS Entry"."TCS Amount" = 0 THEN
                    CurrReport.SKIP;
                CLEAR(PostingDate);
                CLEAR(VendorCode);
                CLEAR(BranchCode);
                CLEAR(LOB);
                CLEAR(LOC);
                CLEAR(TDSPartyCode);
                CLEAR(TDSPer);
                CLEAR(PANNo);
                CLEAR(DMSI);

                T17.RESET;
                T17.SETRANGE("Document No.", "TCS Entry"."Document No.");
                IF T17.FINDFIRST THEN BEGIN
                    BranchCode := T17."Global Dimension 2 Code";
                    LOB := T17."Global Dimension 1 Code";
                    DMSI := T17."Dimension Set ID";
                END;

                T480.RESET;
                T480.SETRANGE("Dimension Set ID", DMSI);
                T480.SETRANGE(T480."Dimension Code", 'LOC');
                T480.SETAUTOCALCFIELDS("Dimension Value Name");
                IF T480.FINDFIRST THEN
                    LOC := T480."Dimension Value Name";


                CLEAR(Sno_2);
                
                Sno += 1;
                Sno_2 := Sno;
                PostingDate := "Posting Date";
                TDSPer := "TCS Entry"."TCS %";
            end;

            trigger OnPreDataItem()
            begin
                "TCS Entry".SETRANGE("TCS Entry"."Posting Date", StartDate, EndDate);
                Sno := 0;

            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group("Date Filter")
                {
                    field(StartDate; StartDate)
                    {
                        Caption = 'StartDate';
                        ApplicationArea = All;
                    }
                    field(EndDate; EndDate)
                    {
                        Caption = 'EndDate';
                        ApplicationArea = All;
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        CLEAR(CompInfo);
        CompInfo.GET;
        CompInfo.CALCFIELDS(Picture);
    end;

    var
        vendorRec: Record 18;
        PartyName: Text;
        Sno: Integer;
        TDSPer: Decimal;
        TDSPartyCode: Code[10];
        Sno_2: Integer;
        StartDate: Date;
        EndDate: Date;
        CompInfo: Record 79;
        PurchInvHeaderRec: Record 112;
        PostingDate: Date;
        PANNo: Text;
        DocumentNo: Text;
        VendorCode: Text;
        BranchCode: Text;
        LOC: Text;
        LOB: Text;
        T480: Record 480;
        DMSI: Integer;
        T17: Record 21;
        PartyType_TDSEntry: Code[10];
        PartyCode_TDSEntry: Code[10];
        TCSType_TCSEntry: Code[10];

}

