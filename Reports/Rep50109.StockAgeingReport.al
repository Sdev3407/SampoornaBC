report 50109 "Stock Ageing Report"
{
    //UsageCategory = Administration;
    Caption = 'Stock Ageing Report';
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'ReportLayout\StockAgeing.rdl';

    dataset
    {


        dataitem("Item Ledger Entry"; "Item Ledger Entry")
        {
            //DataItemLink = "Item No." = FIELD("No.");
            //DataItemLinkReference = Item;
            DataItemTableView = SORTING("Item No.")
                                ORDER(Ascending) where("Remaining Quantity" = filter(<> 0), "Location Code" = filter(<> 'IN-TRANSIT'), "Global Dimension 1 Code" = Filter('FEED|CATTLE'));
            RequestFilterFields = "Item Category Code";


            column(Item_No_; "Item Ledger Entry"."Item No.")
            { }
            column(Item_Name; "Item Ledger Entry"."Item Name")
            { }
            column(Location_Code; "Item Ledger Entry"."Location Code")
            { }
            column(Age1520; Age1520)
            { }
            column(Age2030; Age2030)
            { }
            column(Age3040; Age3040)
            { }
            column(Age40Above; Age40Above)
            { }
            column(LocName; LocName)
            { }

            trigger OnAfterGetRecord()
            var
                loc: Record Location;
            begin
                Age1520 := 0;
                Age2030 := 0;
                Age3040 := 0;
                Age3040 := 0;
                Age40Above := 0;

                loc.Get("Item Ledger Entry"."Location Code");
                LocName := loc.Name;
                if (loc."Global Dimension 1 Code" <> 'FEED') and (loc."Global Dimension 1 Code" <> 'CATTLE') then
                    CurrReport.Skip();

                if (("Posting Date" >= ((WorkDate() - 15) - 05)) and ("Posting Date" <= (WorkDate() - 15))) then
                    Age1520 := ("Remaining Quantity") / 50;
                // ILE.Reset();
                // //ILE.SetCurrentKey("Item No.", "Location Code", "Posting Date");
                // ILE.SetRange("Item No.", "Item Ledger Entry"."Item No.");
                // ILE.SetFilter("Remaining Quantity", '<>%1', 0);
                // ILE.SetRange("Location Code", "Item Ledger Entry"."Location Code");
                // ILE.SetRange("Posting Date", ((WorkDate() - 15) - 05), (WorkDate() - 15));
                // if ILE.FindSet() Then
                //     Age1520 += (ILE."Remaining Quantity") / 50;

                // ILE.Reset();
                // //ILE.SetCurrentKey("Item No.", "Location Code", "Posting Date");
                // ILE.SetRange("Item No.", "Item Ledger Entry"."Item No.");
                // ILE.SetFilter("Remaining Quantity", '<>%1', 0);
                // ILE.SetRange("Location Code", "Item Ledger Entry"."Location Code");
                // ILE.SetRange("Posting Date", ((WorkDate() - 21) - 09), (WorkDate() - 21));
                // if ILE.FindSet() Then
                //     Age2030 += (ILE."Remaining Quantity") / 50;
                if (("Posting Date" >= ((WorkDate() - 21) - 09)) and ("Posting Date" <= (WorkDate() - 21))) then
                    Age2030 := ("Remaining Quantity") / 50;

                // ILE.Reset();
                // //ILE.SetCurrentKey("Item No.", "Location Code", "Posting Date");
                // ILE.SetRange("Item No.", "Item Ledger Entry"."Item No.");
                // ILE.SetFilter("Remaining Quantity", '<>%1', 0);
                // ILE.SetRange("Location Code", "Item Ledger Entry"."Location Code");
                // ILE.SetRange("Posting Date", ((WorkDate() - 31) - 09), (WorkDate() - 31));
                // if ILE.FindSet() Then
                //     Age3040 += (ILE."Remaining Quantity") / 50;

                if (("Posting Date" >= ((WorkDate() - 31) - 09)) and ("Posting Date" <= (WorkDate() - 31))) then
                    Age3040 := ("Remaining Quantity") / 50;

                // ILE.Reset();
                // //ILE.SetCurrentKey("Item No.", "Location Code", "Posting Date");
                // ILE.SetFilter("Remaining Quantity", '<>%1', 0);
                // ILE.SetRange("Item No.", "Item Ledger Entry"."Item No.");
                // ILE.SetRange("Location Code", "Item Ledger Entry"."Location Code");
                // ILE.SetRange("Posting Date", 0D, (WorkDate() - 41));
                // if ILE.FindSet() Then
                //     Age40Above += (ILE."Remaining Quantity") / 50;

                if (("Posting Date" >= 0D) and ("Posting Date" <= (WorkDate() - 41))) then
                    Age3040 := ("Remaining Quantity") / 50;


            end;
        }
    }
    //}
    var
        Age1520: Decimal;
        Age2030: Decimal;
        Age3040: Decimal;
        Age40Above: Decimal;
        ILE: Record "Item Ledger Entry";
        LocName: Text;
}