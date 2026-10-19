report 50014 "TDS Entry"
{

    UsageCategory = Administration;
    Caption = 'TDS Entry Report';
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'ReportLayout\TDSEntry.rdl';

    dataset
    {
        dataitem("TDS Entry"; "TDS Entry")
        {
            DataItemTableView = SORTING("Party Code", "TDS %") Where("TDS %" = FILTER(<> 0)); //Pru Neha
            //                    ORDER(Ascending)
            //                    WHERE("Party Type" = CONST(Vendor));
            RequestFilterFields = "Document No.";
            column(EntryNo_TDSEntry; "TDS Entry"."Entry No.")
            {
            }
            column(TDSBaseAmount_TDSEntry; "TDS Entry"."TDS Base Amount")
            {
            }
            column(PartyType_TDSEntry; "TDS Entry"."Party Type")
            {
            }
            column(TDSAmount_TDSEntry; "TDS Entry"."TDS Amount")
            {
            }
            column(TDS_TDSEntry; "TDS Entry"."TDS %")
            {
            }
            //  column(TDSSection_TDSEntry; "TDS Entry"."TDS Section")  {}  //PRU SH
            //  column(TDSSection_TDSEntry; TDSSection_TDSEntry) { } //Pru Neha
            column(TDSSection_TDSEntry; "TDS Entry".Section) { } //pru neha

            column(PartyCode_TDSEntry; "TDS Entry"."Party Code") { }


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
            column(AssesseeCode_TDSEntry; "TDS Entry"."Assessee Code")
            {
            }
            column(DocumentNo_TDSEntry; "TDS Entry"."Document No.")
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
                T17.SETRANGE("Document No.", "TDS Entry"."Document No.");
                IF T17.FINDFIRST THEN BEGIN
                    //PostingDate:= PurchInvHeaderRec."Posting Date";
                    //VendorCode:= PurchInvHeaderRec."Buy-from Vendor No.";
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
                //IF (("TDS Entry"."Party Code"<>TDSPartyCode)  OR ("TDS Entry"."TDS %"<> TDSPer)) THEN BEGIN
                Sno += 1;
                Sno_2 := Sno;
                //END;
                PostingDate := "Posting Date";
                TDSPartyCode := "TDS Entry"."Vendor No.";//"TDS Entry"."Party Code"; //pru neha
                TDSPer := "TDS Entry"."TDS %";

                //vendorRec.RESET;
                //vendorRec.SETRANGE("No.","TDS Entry"."Party Code");
                // IF vendorRec.GET("TDS Entry"."Party Code") THEN BEGIN
                IF vendorRec.GET("TDS Entry"."Vendor No.") THEN BEGIN //Pru neha
                    PartyName := vendorRec.Name;
                    PANNo := vendorRec."P.A.N. No.";
                END;
            end;

            trigger OnPreDataItem()
            begin
                "TDS Entry".SETRANGE("TDS Entry"."Posting Date", StartDate, EndDate);
                Sno := 0;
                //CLEAR(TDSPartyCode);
                //CLEAR(TDSPer);
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
        vendorRec: Record 23;
        PartyName: Text;
        Sno: Integer;
        TDSPer: Decimal;
        TDSPartyCode: Code[10];
        Sno_2: Integer;
        StartDate: Date;
        EndDate: Date;
        CompInfo: Record 79;
        PurchInvHeaderRec: Record 122;
        PostingDate: Date;
        PANNo: Text;
        DocumentNo: Text;
        VendorCode: Text;
        BranchCode: Text;
        LOC: Text;
        LOB: Text;
        T480: Record 480;
        DMSI: Integer;
        T17: Record 25;
        TDSSection_TDSEntry: Decimal;
}

