pageextension 50165 RelProLine extends "Released Prod. Order Lines"
{
    layout
    {
    }
    actions
    {
        modify(ProductionJournal)
        {
            trigger OnBeforeAction()
            var
                myInt: Integer;
            begin
                CompanyInfo.Get;
                if CompanyInfo.SFPLCompany = CompanyInfo.SFPLCompany::Sampoorna then
                    Rec.TESTFIELD("Production BOM No.");
            end;
        }
        addafter(Components)
        {
            action("Update Componenet")
            {
                Visible = Visible;
                Image = Process;

                trigger OnAction()
                var
                Begin

                    UpdateComponent(Rec);

                End;
            }


            action("Star Prod Jn")
            {
                Visible = Visible;
                Image = Journal;
                trigger OnAction()
                var

                begin
                    StarProdJN(Rec."Prod. Order No.");
                end;
            }
        }
    }
    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        Visible := False;

        CompanyInfo.Get;
        if CompanyInfo.SFPLCompany in [CompanyInfo.SFPLCompany::"Star Foods"] then
            Visible := True;

    end;

    var
        CompanyInfo: Record "Company Information";
        Visible: Boolean;
    //UpdateCompo: Codeunit AllCodeunitExt;

    procedure StarProdJN(ProdOrder: Code[20])
    var
        MfgSetup: Record "Manufacturing Setup";
        ProdOrderN: Record "Production Order";
        ProductionJrnlMgt: Codeunit "Production Journal Mgt";
        ProgressBar: Dialog;
        GeneratingJnlLinesMsg: Label 'Generating journal lines.';
    begin
        ProdOrderN.Get(Enum::"Production Order Status"::Released, ProdOrder);
        MfgSetup.Get();
        Clear(ProductionJrnlMgt);
        ProductionJrnlMgt.Handling(ProdOrderN, 0);

    end;

    procedure UpdateItemTrackingOutput(Rec: Record "Item Journal Line")
    var
        ProdOrder: Record "Production Order";
        ItemJn: Record "Item Journal Line";
        ReservationEntry: Record "Reservation Entry";
        ReservationEntry1: Record "Reservation Entry";
        PeriodYear: Integer;
        StartDate: Date;
        EndDate: Date;
        NoofDaysInYear: Integer;
        BatchMaster: Record "Batch Master";
        LotNo: text;
        LotType: Option ,"LB","RP","TP";
    begin
        ProdOrder.Get(Enum::"Production Order Status"::Released, Rec."Document No.");
        ProdOrder.TestField("Due Date");
        ProdOrder.TestField("RPO Type");
        ReservationEntry1.Reset();
        ReservationEntry1.SetRange("Source Batch Name", Rec."Journal Batch Name");
        ReservationEntry1.SetRange("Item No.", Rec."Item No.");
        ReservationEntry1.SetRange("Location Code", Rec."Location Code");
        ReservationEntry1.SetRange("Source Type", 83);
        ReservationEntry1.SetRange("Source Subtype", 6);
        ReservationEntry1.SetRange("Source Ref. No.", Rec."Line No.");
        ReservationEntry1.SetRange("Source ID", 'PROD. ORDE');
        if not ReservationEntry1.FindFirst() then begin
            ReservationEntry.Init();
            ReservationEntry."Reservation Status" := Enum::"Reservation Status"::Prospect;
            ReservationEntry."Item No." := Rec."Item No.";
            ReservationEntry."Location Code" := rec."Location Code";

            ReservationEntry."Source Type" := 83;
            ReservationEntry."Source Subtype" := 6;
            ReservationEntry."Source ID" := 'PROD. ORDE';
            ReservationEntry."Source Batch Name" := Rec."Journal Batch Name";
            ReservationEntry."Source Prod. Order Line" := 0;
            ReservationEntry."Source Ref. No." := Rec."Line No.";
            ReservationEntry.Positive := True;
            ReservationEntry."Item Tracking" := Enum::"Item Tracking Type"::"Lot No.";
            ReservationEntry."Lot No." := ProdOrder."Lot No.";
            ReservationEntry.Validate(Quantity, Rec."Output Quantity");
            ReservationEntry.Validate("Quantity (Base)", Rec."Output Quantity");
            ReservationEntry.Validate("Qty. to Handle (Base)", Rec."Output Quantity");
            ReservationEntry.Validate("Qty. to Invoice (Base)", Rec."Output Quantity");
            ReservationEntry.Insert(true);
        end;

    end;

    procedure UpdateComponent(var Rec: Record "Prod. Order Line")
    var
        RecProdCompo: Record "Prod. Order Component";
        CompanyInfo: Record "Company Information";
        Item: Record Item;
        ProdHeader: Record "Production Order";
        ProdOrderLine: Record "Prod. Order Line";
    begin
        CompanyInfo.Get;
        ProdHeader.Get(Rec.Status, Rec."Prod. Order No.");
        If CompanyInfo.SFPLCompany in [CompanyInfo.SFPLCompany::"Star Foods"] then begin
            ProdOrderLine.Reset();
            ProdOrderLine.SetRange(ProdOrderLine."Prod. Order No.", rec."Prod. Order No.");
            //ProdOrderLine.SetRange(ProdOrderLine."Line No.", Rec."Line No.");
            ProdOrderLine.SetFilter(ProdOrderLine.Quantity, '<>%1', 0);
            if ProdOrderLine.FindSet() then
                repeat
                    Item.Get(ProdOrderLine."Item No.");
                    RecProdCompo.Reset();
                    RecProdCompo.SetRange("Prod. Order No.", ProdOrderLine."Prod. Order No.");
                    RecProdCompo.SetRange("Prod. Order Line No.", ProdOrderLine."Line No.");
                    RecProdCompo.SetFilter("Item No.", '<>%1', '');
                    If not RecProdCompo.FindFirst() then begin
                        If Item.ItemComponent <> '' Then Begin
                            RecProdCompo.Init();
                            RecProdCompo.Status := Rec.Status::Released;
                            RecProdCompo."Prod. Order No." := ProdOrderLine."Prod. Order No.";
                            RecProdCompo."Prod. Order Line No." := ProdOrderLine."Line No.";
                            RecProdCompo.Validate("Item No.", Item.ItemComponent);
                            RecProdCompo.Validate("Location Code", ProdHeader."Location Code");
                            RecProdCompo.Validate("Quantity per", 1.03);
                            RecProdCompo.Insert();
                        End;
                    end;
                until ProdOrderLine.Next() = 0;
        end;
    end;

    procedure UpdateItemTrackingConsumption(Rec: Record "Item Journal Line")
    var
        ProdOrder: Record "Production Order";
        ItemJn: Record "Item Journal Line";
        ReservationEntry: Record "Reservation Entry";
        ReservationEntry1: Record "Reservation Entry";
        PeriodYear: Integer;
        StartDate: Date;
        EndDate: Date;
        NoofDaysInYear: Integer;
        BatchMaster: Record "Batch Master";
        LotNo: text;
        LotType: Option ,"LB","RP","TP";
    begin
        ProdOrder.Get(Enum::"Production Order Status"::Released, Rec."Document No.");
        ProdOrder.TestField("Due Date");
        ProdOrder.TestField("RPO Type");
        ReservationEntry1.Reset();
        ReservationEntry1.SetRange("Source Batch Name", Rec."Journal Batch Name");
        ReservationEntry1.SetRange("Item No.", Rec."Item No.");
        ReservationEntry1.SetRange("Location Code", Rec."Location Code");
        ReservationEntry1.SetRange("Source Type", 83);
        ReservationEntry1.SetRange("Source Subtype", 5);
        ReservationEntry1.SetRange("Source Ref. No.", Rec."Line No.");
        ReservationEntry1.SetRange("Source ID", 'PROD. ORDE');
        if not ReservationEntry1.FindFirst() then begin
            ReservationEntry.Init();
            ReservationEntry."Reservation Status" := Enum::"Reservation Status"::Prospect;
            ReservationEntry."Item No." := Rec."Item No.";
            ReservationEntry."Location Code" := rec."Location Code";

            ReservationEntry."Source Type" := 83;
            ReservationEntry."Source Subtype" := 5;
            ReservationEntry."Source ID" := 'PROD. ORDE';
            ReservationEntry."Source Batch Name" := Rec."Journal Batch Name";
            ReservationEntry."Source Prod. Order Line" := 0;
            ReservationEntry."Source Ref. No." := Rec."Line No.";
            ReservationEntry.Positive := True;
            ReservationEntry."Item Tracking" := Enum::"Item Tracking Type"::"Lot No.";
            ReservationEntry."Lot No." := ProdOrder."Lot No.";
            ReservationEntry.Validate(Quantity, -Rec.Quantity);
            ReservationEntry.Validate("Quantity (Base)", -Rec.Quantity);
            ReservationEntry.Validate("Qty. to Handle (Base)", -Rec.Quantity);
            // ReservationEntry.Validate("Qty. to Invoice (Base)", -Rec.Quantity);
            ReservationEntry.Insert(true);
        end;

    end;
}