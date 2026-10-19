tableextension 50111 "WhseItemTrackingLines" extends "Whse. Item Tracking Line"
{
    fields
    {
        field(50201; "Manufacturing Date"; Date)
        {
            Caption = 'Manufacturing Date';
            DataClassification = CustomerContent;
            trigger OnValidate()
            var
                Item: Record Item;
                ItemCategory: Record "Item Category";
                NoofDaysLbl: Label '%1D', Comment = '%1 Days';
                NoofDays: Text;
            begin
                // if Item.Get(Rec."Item No.") then
                //     if ItemCategory.Get(Item."Item Category Code") then begin
                //         NoofDays := StrSubstNo(NoofDaysLbl, Format(ItemCategory."WIN Expiry Days"));

                //         if (ItemCategory."WIN Expiry Days" <> 0) and ("WIN Manufacturing Date" <> 0D) then
                //             validate("Expiration Date", CalcDate(NoofDays, "WIN Manufacturing Date"))
                //         else
                //             validate("Expiration Date", "WIN Manufacturing Date");
                //     end;

                // if "WIN Manufacturing Date" = 0D then
                //     Validate("Expiration Date", 0D);
            end;
        }
        field(50204; "New Manufacturing Date"; Date)
        {
            Caption = 'New Manufacturing Date';
            DataClassification = CustomerContent;

            // trigger OnValidate()
            // var
            //     Item: Record Item;
            //     ItemCategory: Record "Item Category";
            //     NoofDaysLbl: Label '%1D', Comment = '%1 Days';
            //     NoofDays: Text;
            // begin
            //     if Item.Get(Rec."Item No.") then
            //         if ItemCategory.Get(Item."Item Category Code") then begin
            //             NoofDays := StrSubstNo(NoofDaysLbl, Format(ItemCategory."WIN Expiry Days"));

            //             if (ItemCategory."WIN Expiry Days" <> 0) and ("WIN New Manufacturing Date" <> 0D) then
            //                 validate("New Expiration Date", CalcDate(NoofDays, "WIN New Manufacturing Date"))
            //             else
            //                 validate("New Expiration Date", "WIN New Manufacturing Date");
            //         end;

            //     if "WIN New Manufacturing Date" = 0D then
            //         Validate("New Expiration Date", 0D);
            // end;
        }
        //iWMS++
    }
}
