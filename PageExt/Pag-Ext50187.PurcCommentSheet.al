pageextension 50187 "PurcCommentSheet" extends "Purch. Comment Sheet"
{
    layout
    {
        addbefore(Code)
        {
            field("Document Type"; Rec."Document Type")
            {
                ApplicationArea = Comment;
            }
            field("No."; Rec."No.")
            {
                ApplicationArea = Comment;
            }
            field("Document Line No."; Rec."Document Line No.")
            {
                ApplicationArea = Comment;
            }
        }
    }
}
