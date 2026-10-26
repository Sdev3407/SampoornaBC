page 50159 "Insurance Document Attached"
{

    Caption = 'Insurance Document Attached';
    Editable = true;
    PageType = List;
    SourceTable = "Document Attachment";
    SourceTableView = SORTING(ID, "Table ID");
    RefreshOnActivate = true;
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("File Name"; Rec."File Name")
                {
                    Caption = 'File Name';
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the filename of the attachment.';
                    Editable = false;
                    trigger OnDrillDown()
                    var
                        myInt: Integer;
                        FileManagement: Codeunit "File Management";
                        TempBlob: Codeunit "Temp Blob";
                        FilterTxt: Label '*.jpg;*.jpeg;*.bmp;*.png;*.gif;*.tiff;*.tif;*.pdf;*.docx;*.doc;*.xlsx;*.xls;*.pptx;*.ppt;*.msg;*.xml;*.*';
                        ImportTxt: Label 'Attach a document.';
                        FileDialogTxt: Label 'Attachments (%1)|%1';
                        FileName: Text;
                        FromRecRef: RecordRef;
                    begin
                        IF Recs.Get(rec."No.") then;
                        FromRecRef.GetTable(Recs);
                        IF Rec."Document Reference ID".HASVALUE THEN
                            Export2(TRUE)
                        ELSE BEGIN
                            FileName := FileManagement.BLOBImportWithFilter(TempBlob, ImportTxt, FileName, STRSUBSTNO(FileDialogTxt, FilterTxt), FilterTxt);
                            SaveAttachment2(FromRecRef, FileName, TempBlob, TRUE, format(Recs."Insurance No."));
                            CurrPage.UPDATE(FALSE);
                        END;
                    end;
                }
                field("File Type"; Rec."File Type")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("File Extension"; Rec."File Extension")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field(User; Rec.User)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Attached Date"; Rec."Attached Date")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
            }
        }
    }
    var
        Recs: Record "insurance Expiration Alert";
        EmptyFileNameErr: Label 'Please choose a file to attach.';
        DuplicateErr: Label 'This file is already attached to the document. Please choose another file.';

    procedure Export2(ShowFileDialog: Boolean): Text
    var
        FullFileName: Text;
        DocumentStream: OutStream;
        TempBlob: Codeunit "Temp Blob";
        FileManagement: Codeunit "File Management";
    begin
        IF Rec.ID = 0 THEN
            EXIT;

        IF NOT Rec."Document Reference ID".HASVALUE THEN
            EXIT;

        FullFileName := Rec."File Name" + '.' + Rec."File Extension";
        TempBlob.CREATEOUTSTREAM(DocumentStream);
        Rec."Document Reference ID".EXPORTSTREAM(DocumentStream);
        EXIT(FileManagement.BLOBExport(TempBlob, FullFileName, ShowFileDialog));
    end;

    procedure SaveAttachment2(RecRef: RecordRef; FileName: Text; TempBlob: Codeunit "Temp Blob"; OpportunityAttachment: Boolean; OpportunityNo: Code[30])
    var
        Rec_Document: Record "Document Attachment";
        Rec_Attachment: Record "Document Attachment";
        FileManagement: Codeunit "File Management";
        DocumentAttachmentMgmt: Codeunit "Document Attachment Mgmt";
        IncomingFileName2: Text;
        DocStream2: Instream;
        EmptyFileNameErr: Label 'No content';
        NoDocumentAttachedErr: Label 'No document attached';
        FieldRef: FieldRef;
        LineNo: Integer;
    begin
        IF FileName = '' THEN
            ERROR(EmptyFileNameErr);

        if DocumentAttachmentMgmt.IsDuplicateFile(
           "Table ID", "No.", "Document Type".AsInteger(), "Line No.", "File Name", "File Extension")
        then
            Error(DuplicateErr);

        IF NOT TempBlob.HASVALUE THEN
            ERROR(EmptyFileNameErr);

        IncomingFileName2 := FileName;
        Clear(Rec_Attachment);
        Rec_Attachment.Reset();
        Rec_Attachment.INIT;
        Rec_Attachment.VALIDATE("File Extension", FileManagement.GetExtension(IncomingFileName2));
        Rec_Attachment.VALIDATE("File Name", COPYSTR(FileManagement.GetFileNameWithoutExtension(IncomingFileName2), 1, MAXSTRLEN(Rec."File Name")));
        Rec_Attachment.Validate("Document Type", Rec."Document Type"::Order);
        Rec_Attachment.VALIDATE("Table ID", RecRef.NUMBER);
        Rec_Attachment.Validate("No.", OpportunityNo);
        TempBlob.CREATEINSTREAM(DocStream2);
        Rec_Attachment."Document Reference ID".IMPORTSTREAM(DocStream2, '', IncomingFileName2);
        IF NOT Rec_Attachment."Document Reference ID".HASVALUE THEN
            ERROR(NoDocumentAttachedErr);
        CASE RecRef.NUMBER OF
            DATABASE::"Insurance Expiration Alert":
                BEGIN
                    FieldRef := RecRef.FIELD(1);
                    Clear(Rec_Document);
                    Rec_Document.SetRange("Table ID", RecRef.Number);
                    Rec_Document.SetRange("No.", Recs."Insurance No.");
                    IF Rec_Document.FindLast() then
                        Rec_Attachment.Validate("Line No.", Rec_Document."Line No." + 1000)
                    else
                        Rec_Attachment.Validate("Line No.", 1000);
                END;
        END;
        Rec_Attachment.INSERT(TRUE);
    end;

    var
        SelectFileTxt: Label 'Select File...';

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."File Name" := SelectFileTxt;
    end;
}
