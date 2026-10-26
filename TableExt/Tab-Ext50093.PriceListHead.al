tableextension 50093 PriceListHead extends "Price List Header"
{
    fields
    {
        modify(Status)
        {
            trigger OnAfterValidate()
            var
                PriLisH: Record "Price List Line";
                PriLisL: Record "Price List Line";
            begin
                if rec.Status = rec.Status::Active then begin

                    PriLisH.Reset();
                    PriLisH.SetRange(Status, PriLisH.Status::Active);
                    if PriLisH.FindFirst() then
                        repeat
                            PriLisL.Reset();
                            PriLisL.SETFILTER("Starting Date", '<=%1', PriLisH."Starting Date");
                            PriLisL.SetRange("Assign-to No.", PriLisH."Assign-to No.");
                            PriLisL.SetRange("Product No1", PriLisH."Product No1");
                            if PriLisH."Ending Date" <> 0D then
                                PriLisL.SETFILTER(PriLisL."Ending Date", '%1|>=%2', 0D, PriLisH."Ending Date");
                            PriLisL.SetRange(Status, PriLisL.Status::Active);
                            if PriLisL.FindFirst() then
                                repeat
                                    
                                    if PriLisL."Price List Code" <> PriLisH."Price List Code" then
                                        Error('Sales Price already Exist %1 Product No. %2', PriLisL."Product No1", PriLisL."Price List Code");
                                until PriLisL.Next() = 0;
                        until PriLisH.Next() = 0;


                end;
            end;
        }
    
        modify("Ending Date")
        {
            trigger OnAfterValidate()
            var
                PriLisH: Record "Price List Header";
                PriceL: Record "Price List Line";
            begin
                /*
                Rec.TestField("Starting Date");
                if rec."Starting Date" <> 0D then begin
                    PriLisH.Reset();
                    PriLisH.SETFILTER("Starting Date", '<=%1', "Starting Date");
                    PriLisH.SetRange("Assign-to No.", "Assign-to No.");
                    PriLisH.SETFILTER(PriLisH."Ending Date", '%1|>=%2', 0D, "Ending Date");
                    PriLisH.SetRange(Status, PriLisH.Status::Active);
                    if PriLisH.FindFirst() then
                        Error('Sales Price already Exist');
                END;
                */

            end;
        }
    }
}