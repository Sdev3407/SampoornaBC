pageextension 50173 ProdOrderComponenet extends "Prod. Order Components"
{
    layout
    {
        modify("Item No.")
        {
            StyleExpr = DescriptionEmphasize;
        }

        modify(Description)
        {
            StyleExpr = DescriptionEmphasize;
        }


    }
    actions
    {
        modify(ItemTrackingLines)
        {
            trigger OnBeforeAction()
            var
                myInt: Integer;
            begin
                //Message('Test');
            end;
        }
    }
    trigger OnAfterGetRecord()
    var

    Begin
        If Rec."Item No." <> '' then
            CodeOnFormat();
    End;

    trigger OnOpenPage()
    var
        UserSetup: Record 91;
    begin
        IF UserSetup.get(UserId) then
            if UserSetup."Access Work Center" = UserSetup."Access Work Center"::View then
                CurrPage.Editable := false
            Else
                CurrPage.Editable := true;
    end;

    procedure CodeOnFormat()
    var
        Item: Record Item;
    begin
        CLear(DescriptionEmphasize);
        Item.Get(Rec."Item No.");
        //DescriptionIndent := Rec.Level;
        if Item."Item Tracking Code" <> '' then
            DescriptionEmphasize := 'Unfavorable';

    end;

    var
        DescriptionEmphasize: Text;
}