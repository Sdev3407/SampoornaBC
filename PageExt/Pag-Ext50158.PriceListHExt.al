pageextension 50158 PriceListHExt extends "Sales Price List"
{
    layout
    {
        modify(Description)
        {
            Editable = Result1;
        }
        modify(AssignToNo)
        {
            Editable = Result1;
        }
        modify(SourceType)
        {
            Editable = Result1;
        }
        modify(SourceNo)
        {
            Editable = Result1;
        }
        modify(JobSourceType)
        {
            Editable = Result1;
        }
        modify(AssignToParentNoGroup)
        {
            Editable = Result1;
        }
        modify(VATBusPostingGrPrice)
        {
            Editable = Result1;
        }
        modify(PriceIncludesVAT)
        {
            Editable = Result1;
        }
        modify(View)
        {
            Editable = Result1;
        }
        modify(CurrencyCode)
        {
            Editable = Result1;
        }
        modify(StartingDate)
        {
            Editable = Result1;
        }
        modify(EndingDate)
        {
            Editable = Result1;
        }
        modify(AllowInvoiceDisc)
        {
            Editable = Result1;
        }
        modify(AllowLineDisc)
        {
            Editable = Result1;
        }
        modify(AllowUpdatingDefaults)
        {
            Editable = Result1;
        }

        modify(Status)
        {
            trigger OnAfterValidate()
            begin
                IsEditable1;
            end;
        }



    }

    actions
    {
        addafter(SuggestLines)
        {
            action("Sales Price Import")
            {
                ApplicationArea = all;
                Image = Import;
                RunObject = report 50103;
                trigger OnAction()
                var
                    ImportPriceLines: Report 50102;

                begin
                    /*
                    Clear(ImportPriceLines);
                    ImportPriceLines.GetDocNo(Rec.code);
                    ImportPriceLines.RUN;
                    */

                end;
            }
        }
    }
    var
        Result1: Boolean;

    procedure IsEditable1() Result: Boolean;
    begin
        Result1 := (Status = Status::Draft);
    end;

    trigger OnOpenPage()
    begin
        IsEditable1;

    end;

    trigger OnAfterGetRecord()
    begin
        IsEditable1;


    end;

    trigger OnAfterGetCurrRecord()
    begin
        IsEditable1;

    end;

    local procedure IsAllowedEditingActivePrice(): Boolean;
    var
        PriceListManagement: Codeunit "Price List Management";
    begin
        exit(PriceListManagement.IsAllowedEditingActivePrice("Price Type"));
    end;
}