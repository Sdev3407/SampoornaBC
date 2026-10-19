page 50046 "Consum. for Consumable Item"
{

    AutoSplitKey = true;
    Caption = 'Item Journal';
    DataCaptionFields = "Journal Batch Name";
    DelayedInsert = true;
    PageType = Worksheet;
    SaveValues = true;
    SourceTable = 83;

    layout
    {
        area(content)
        {
            field(CurrentJnlBatchName; CurrentJnlBatchName)
            {
                ApplicationArea = All;

                Caption = 'Batch Name';
                Lookup = true;

                trigger OnLookup(var Text: Text): Boolean
                var
                    ItemJnlMgt: Codeunit ItemJnlManagement;
                begin
                    CurrPage.SAVERECORD;
                    ItemJnlMgt.LookupName(CurrentJnlBatchName, Rec);
                    CurrPage.UPDATE(FALSE);
                end;

                trigger OnValidate()
                begin
                    ItemJnlMgt.CheckName(CurrentJnlBatchName, Rec);
                    CurrentJnlBatchNameOnAfterVali;
                end;
            }
            repeater(grp)
            {
                field("Posting Date"; "Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Document Date"; "Document Date")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Entry Type"; "Entry Type")
                {
                    ApplicationArea = All;
                    // OptionCaption = 'Purchase,Sale,Positive Adjmt.,Negative Adjmt.';

                    trigger OnValidate()
                    begin
                        //   UpdateNatureOfDisposal;
                    end;
                }
                field("Document No."; "Document No.")
                {
                    ApplicationArea = All;
                }
                field("External Document No."; "External Document No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Item No."; "Item No.")
                {
                    ApplicationArea = All;
                    TableRelation = IF ("Item Type" = CONST(GEN)) Item WHERE("Item Type" = CONST(GEN));

                    trigger OnValidate()
                    begin
                        ItemJnlMgt.GetItem("Item No.", ItemDescription);
                        ShowShortcutDimCode(ShortcutDimCode);
                    end;
                }
                field("Variant Code"; "Variant Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 1 Code"; "Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Shortcut Dimension 2 Code"; "Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Shortcut Dimension 3 Code"; "Shortcut Dimension 3 Code")
                {
                    ApplicationArea = All;
                }
                field(ShortcutDimCode4; ShortcutDimCode[4])
                {
                    ApplicationArea = All;
                    CaptionClass = '1,2,4';
                    TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4),
                                                                     "Dimension Value Type" = CONST(Standard),
                                                                     Blocked = CONST(false));
                    Visible = false;

                    trigger OnValidate()
                    begin
                        ValidateShortcutDimCode(4, ShortcutDimCode[4]);
                    end;
                }
                field(ShortcutDimCode5; ShortcutDimCode[5])
                {
                    ApplicationArea = All;
                    CaptionClass = '1,2,5';
                    TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(5),
                                                                     "Dimension Value Type" = CONST(Standard),
                                                                     Blocked = CONST(false));
                    Visible = false;

                    trigger OnValidate()
                    begin
                        ValidateShortcutDimCode(5, ShortcutDimCode[5]);
                    end;
                }
                field(ShortcutDimCode6; ShortcutDimCode[6])
                {
                    ApplicationArea = All;
                    CaptionClass = '1,2,6';
                    TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(6),
                                                                     "Dimension Value Type" = CONST(Standard),
                                                                     Blocked = CONST(false));
                    Visible = false;

                    trigger OnValidate()
                    begin
                        ValidateShortcutDimCode(6, ShortcutDimCode[6]);
                    end;
                }
                field(ShortcutDimCode7; ShortcutDimCode[7])
                {
                    ApplicationArea = All;
                    CaptionClass = '1,2,7';
                    TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(7),
                                                                     "Dimension Value Type" = CONST(Standard),
                                                                     Blocked = CONST(false));
                    Visible = false;

                    trigger OnValidate()
                    begin
                        ValidateShortcutDimCode(7, ShortcutDimCode[7]);
                    end;
                }
                field(ShortcutDimCode8; ShortcutDimCode[8])
                {
                    ApplicationArea = All;
                    CaptionClass = '1,2,8';
                    TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(8),
                                                                     "Dimension Value Type" = CONST(Standard),
                                                                     Blocked = CONST(false));
                    Visible = false;

                    trigger OnValidate()
                    begin
                        ValidateShortcutDimCode(8, ShortcutDimCode[8]);
                    end;
                }
                field("Location Code"; "Location Code")
                {
                    ApplicationArea = All;
                    Visible = true;

                    trigger OnValidate()
                    var
                    //  WMSManagement: Codeunit 7302;
                    begin
                        //WMSManagement.CheckItemJnlLineLocation(Rec,xRec);
                    end;
                }
                field("Bin Code"; "Bin Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Salespers./Purch. Code"; "Salespers./Purch. Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Gen. Bus. Posting Group"; "Gen. Bus. Posting Group")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Gen. Prod. Posting Group"; "Gen. Prod. Posting Group")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Quantity; Quantity)
                {
                    ApplicationArea = All;
                }
                field("Unit of Measure Code"; "Unit of Measure Code")
                {
                    ApplicationArea = All;
                }
                field("Unit Amount"; "Unit Amount")
                {
                    ApplicationArea = All;
                }
                field(Amount; Amount)
                {
                    ApplicationArea = All;
                }
                field("Discount Amount"; "Discount Amount")
                {
                    ApplicationArea = All;
                }
                field("Indirect Cost %"; "Indirect Cost %")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                /*
                field("Other Usage"; "Other Usage")
                {
                    ApplicationArea = All;
                    Editable = "Other UsageEditable";
                    Visible = false;

                    trigger OnValidate()
                    begin
                        MakeFieldNonEditable;
                    end;
                }
                
                field("Excise Entry"; "Excise Entry")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Nature of Disposal"; "Nature of Disposal")
                {
                    ApplicationArea = All;
                    Editable = true;
                    Visible = false;
                }
                */
                field("Unit Cost"; "Unit Cost")
                {
                    ApplicationArea = All;
                }
                field("Applies-to Entry"; "Applies-to Entry")
                {
                    ApplicationArea = All;
                }
                field("Applies-from Entry"; "Applies-from Entry")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Transaction Type"; "Transaction Type")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Transport Method"; "Transport Method")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Country/Region Code"; "Country/Region Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Reason Code"; "Reason Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                /*
                field("Applies-to Entry (RG 23 D)"; "Applies-to Entry (RG 23 D)")
                {
                    ApplicationArea = All;
                }
                */
            }
            group(ItemDescription1)
            {

                group("Item Description")
                {
                    Caption = 'Item Description';
                    field(ItemDescription; ItemDescription)
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                }
            }
        }
        area(factboxes)
        {
            part("Item replenishment Factbox"; 9090)
            {
                ApplicationArea = All;
                SubPageLink = "No." = FIELD("Item No.");
                Visible = false;
            }
            systempart(Links; Links)
            {
                ApplicationArea = All;
                Visible = false;
            }
            systempart(Notes; Notes)
            {
                ApplicationArea = All;
                Visible = false;
            }
        }
    }


    actions
    {
        area(navigation)
        {
            group("&Line")
            {
                Caption = '&Line';
                Image = Line;
                action(Dimensions)
                {
                    AccessByPermission = TableData 348 = R;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'Shift+Ctrl+D';
                    Visible = false;
                    ApplicationArea = All;
                    trigger OnAction()
                    begin
                        ShowDimensions;
                        CurrPage.SAVERECORD;
                    end;
                }
                action(ItemTrackingLines)
                {
                    Caption = 'Item &Tracking Lines';
                    Image = ItemTrackingLines;
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'Shift+Ctrl+I';
                    ApplicationArea = All;
                    trigger OnAction()
                    begin
                        OpenItemTrackingLines(FALSE);
                    end;
                }
                action("Bin Contents")
                {
                    Caption = 'Bin Contents';
                    ApplicationArea = All;
                    Image = BinContent;
                    RunObject = Page 7305;
                    RunPageLink = "Location Code" = FIELD("Location Code"),
                                     "Item No." = FIELD("Item No."),
                                     "Variant Code" = FIELD("Variant Code");
                    RunPageView = SORTING("Location Code", "Item No.", "Variant Code");
                }

                action("&Recalculate Unit Amount")
                {
                    Caption = '&Recalculate Unit Amount';
                    ApplicationArea = All;
                    Image = UpdateUnitCost;

                    trigger OnAction()
                    begin
                        RecalculateUnitAmount;
                        CurrPage.SAVERECORD;
                    end;
                }
            }
            group("&Item")
            {
                Caption = '&Item';
                Image = Item;
                action(Card)
                {
                    Caption = 'Card';
                    ApplicationArea = All;
                    Image = EditLines;
                    RunObject = Page 30;
                    RunPageLink = "No." = FIELD("Item No.");
                    ShortCutKey = 'Shift+F7';
                }
                action("Ledger E&ntries")
                {
                    Caption = 'Ledger E&ntries';
                    ApplicationArea = All;
                    Image = ItemLedger;
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;
                    RunObject = Page 38;
                    RunPageLink = "Item No." = FIELD("Item No.");
                    RunPageView = SORTING("Item No.");
                    ShortCutKey = 'Ctrl+F7';
                }
                group("Item Availability by")
                {
                    Caption = 'Item Availability by';

                    Image = ItemAvailability;
                    action("Event")
                    {
                        Caption = 'Event';
                        Image = "Event";

                        trigger OnAction()
                        begin
                            ItemAvailFormsMgt.ShowItemAvailFromItemJnlLine(Rec, ItemAvailFormsMgt.ByEvent)
                        end;
                    }
                    action(Period)
                    {
                        Caption = 'Period';
                        ApplicationArea = All;
                        Image = Period;

                        trigger OnAction()
                        begin
                            ItemAvailFormsMgt.ShowItemAvailFromItemJnlLine(Rec, ItemAvailFormsMgt.ByPeriod)
                        end;
                    }
                    action(Variant)
                    {
                        Caption = 'Variant';
                        ApplicationArea = All;
                        Image = ItemVariant;

                        trigger OnAction()
                        begin
                            ItemAvailFormsMgt.ShowItemAvailFromItemJnlLine(Rec, ItemAvailFormsMgt.ByVariant)
                        end;
                    }
                    action(Location)
                    {
                        AccessByPermission = TableData 14 = R;
                        Caption = 'Location';
                        ApplicationArea = All;
                        Image = Warehouse;

                        trigger OnAction()
                        begin
                            ItemAvailFormsMgt.ShowItemAvailFromItemJnlLine(Rec, ItemAvailFormsMgt.ByLocation)
                        end;
                    }
                    action("BOM Level")
                    {
                        Caption = 'BOM Level';
                        ApplicationArea = All;
                        Image = BOMLevel;

                        trigger OnAction()
                        begin
                            ItemAvailFormsMgt.ShowItemAvailFromItemJnlLine(Rec, ItemAvailFormsMgt.ByBOM)
                        end;
                    }
                }
            }
        }
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                action("E&xplode BOM")
                {
                    Caption = 'E&xplode BOM';
                    ApplicationArea = All;
                    Image = ExplodeBOM;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Codeunit 246;
                }
                action("&Calculate Whse. Adjustment")
                {
                    Caption = '&Calculate Whse. Adjustment';
                    ApplicationArea = All;
                    Ellipsis = true;
                    Image = CalculateWarehouseAdjustment;

                    trigger OnAction()
                    begin
                        CalcWhseAdjmt.SetItemJnlLine(Rec);
                        CalcWhseAdjmt.RUNMODAL;
                        CLEAR(CalcWhseAdjmt);
                    end;
                }

                action("&Get Standard Journals")
                {
                    Caption = '&Get Standard Journals';
                    ApplicationArea = All;
                    Ellipsis = true;
                    Image = GetStandardJournal;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                        StdItemJnl: Record 752;
                    begin
                        StdItemJnl.FILTERGROUP := 2;
                        StdItemJnl.SETRANGE("Journal Template Name", "Journal Template Name");
                        StdItemJnl.FILTERGROUP := 0;
                        IF PAGE.RUNMODAL(PAGE::"Standard Item Journals", StdItemJnl) = ACTION::LookupOK THEN BEGIN
                            StdItemJnl.CreateItemJnlFromStdJnl(StdItemJnl, CurrentJnlBatchName);
                            MESSAGE(Text001, StdItemJnl.Code);
                        END
                    end;
                }
                action("&Save as Standard Journal")
                {
                    Caption = '&Save as Standard Journal';
                    ApplicationArea = All;
                    Ellipsis = true;
                    Image = SaveasStandardJournal;

                    trigger OnAction()
                    var
                        ItemJnlBatch: Record 233;
                        ItemJnlLines: Record 83;
                        StdItemJnl: Record 752;
                        SaveAsStdItemJnl: Report 751;
                    begin
                        ItemJnlLines.SETFILTER("Journal Template Name", "Journal Template Name");
                        ItemJnlLines.SETFILTER("Journal Batch Name", CurrentJnlBatchName);
                        CurrPage.SETSELECTIONFILTER(ItemJnlLines);
                        ItemJnlLines.COPYFILTERS(Rec);

                        ItemJnlBatch.GET("Journal Template Name", CurrentJnlBatchName);
                        SaveAsStdItemJnl.Initialise(ItemJnlLines, ItemJnlBatch);
                        SaveAsStdItemJnl.RUNMODAL;
                        IF NOT SaveAsStdItemJnl.GetStdItemJournal(StdItemJnl) THEN
                            EXIT;

                        MESSAGE(Text002, StdItemJnl.Code);
                    end;
                }
            }
            group("P&osting")
            {
                Caption = 'P&osting';
                Image = Post;
                action("Test Report")
                {
                    Caption = 'Test Report';
                    ApplicationArea = All;
                    Ellipsis = true;
                    Image = TestReport;

                    trigger OnAction()
                    begin
                        ReportPrint.PrintItemJnlLine(Rec);
                    end;
                }
                action(Post)
                {
                    Caption = 'P&ost';
                    ApplicationArea = All;
                    Image = PostOrder;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F9';

                    trigger OnAction()
                    begin
                        //PRU_DD 1.10
                        IF "Entry Type" <> "Entry Type"::"Negative Adjmt." THEN
                            ERROR('Entry Type must be Negative Adjmt.');

                        UserSetup.RESET;
                        UserSetup.SETRANGE("User ID", USERID);
                        UserSetup.SETFILTER(UserSetup."Access Item Journal", '%1', UserSetup."Access Item Journal"::Edit);
                        IF UserSetup.FINDFIRST THEN
                            ERROR('You do not have permission to post Item Journal');

                        //PRU_DD 1.10
                        UserSetup.RESET;
                        UserSetup.SETRANGE("User ID", USERID);
                        UserSetup.SETFILTER(UserSetup."Access Item Journal", '%1', UserSetup."Access Item Journal"::Create);
                        IF UserSetup.FINDFIRST THEN
                            ERROR('You do not have permission to post Item Journal');

                        //PRU_DD 1.10
                        UserSetup.RESET;
                        UserSetup.SETRANGE("User ID", USERID);
                        UserSetup.SETFILTER(UserSetup."Access Item Journal", '%1', UserSetup."Access Item Journal"::View);
                        IF UserSetup.FINDFIRST THEN
                            ERROR('You do not have permission to post Item Journal');

                        CODEUNIT.RUN(CODEUNIT::"Item Jnl.-Post", Rec);
                        CurrentJnlBatchName := GETRANGEMAX("Journal Batch Name");
                        CurrPage.UPDATE(FALSE);
                    end;
                }
                action("Post and &Print")
                {
                    Caption = 'Post and &Print';
                    Image = PostPrint;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'Shift+F9';
                    ApplicationArea = All;
                    trigger OnAction()
                    begin
                        //PRU_DD 1.10
                        IF "Entry Type" <> "Entry Type"::"Negative Adjmt." THEN
                            ERROR('Entry Type must be Negative Adjmt.');

                        UserSetup.RESET;
                        UserSetup.SETRANGE("User ID", USERID);
                        UserSetup.SETFILTER(UserSetup."Access Item Journal", '%1', UserSetup."Access Item Journal"::Edit);
                        IF UserSetup.FINDFIRST THEN
                            ERROR('You do not have permission to post Item Journal');

                        //PRU_DD 1.10
                        UserSetup.RESET;
                        UserSetup.SETRANGE("User ID", USERID);
                        UserSetup.SETFILTER(UserSetup."Access Item Journal", '%1', UserSetup."Access Item Journal"::Create);
                        IF UserSetup.FINDFIRST THEN
                            ERROR('You do not have permission to post Item Journal');

                        //PRU_DD 1.10
                        UserSetup.RESET;
                        UserSetup.SETRANGE("User ID", USERID);
                        UserSetup.SETFILTER(UserSetup."Access Item Journal", '%1', UserSetup."Access Item Journal"::View);
                        IF UserSetup.FINDFIRST THEN
                            ERROR('You do not have permission to post Item Journal');
                        CODEUNIT.RUN(CODEUNIT::"Item Jnl.-Post+Print", Rec);
                        CurrentJnlBatchName := GETRANGEMAX("Journal Batch Name");
                        CurrPage.UPDATE(FALSE);
                    end;
                }
            }
            action("&Print")
            {
                Caption = '&Print';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;
                trigger OnAction()
                var
                    ItemJnlLine: Record 83;
                begin
                    ItemJnlLine.COPY(Rec);
                    ItemJnlLine.SETRANGE("Journal Template Name", "Journal Template Name");
                    ItemJnlLine.SETRANGE("Journal Batch Name", "Journal Batch Name");
                    REPORT.RUNMODAL(REPORT::"Inventory Movement", TRUE, TRUE, ItemJnlLine);
                end;
            }
        }
    }



    trigger OnAfterGetCurrRecord()
    begin
        ItemJnlMgt.GetItem("Item No.", ItemDescription);
        UpdateNatureOfDisposal;
        MakeFieldNonEditable;
    end;

    trigger OnAfterGetRecord()
    begin
        ShowShortcutDimCode(ShortcutDimCode);
        UpdateNatureOfDisposal;
        MakeFieldNonEditable;
    end;

    trigger OnDeleteRecord(): Boolean
    var
        ReserveItemJnlLine: Codeunit 99000835;
    begin
        COMMIT;
        IF NOT ReserveItemJnlLine.DeleteLineConfirm(Rec) THEN
            EXIT(FALSE);
        ReserveItemJnlLine.DeleteLine(Rec);
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Item Journal", '%1', UserSetup."Access Item Journal"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not  have Permission to Delete Item Journal');
        //PRU_DD 1.10
    end;

    trigger OnInit()
    begin
        "Nature of DisposalEditable" := TRUE;
        "Other UsageEditable" := TRUE;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin

        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Item Journal", '%1', UserSetup."Access Item Journal"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Item Journal", '%1', UserSetup."Access Item Journal"::Edit);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not  have Permission to create Item Journal');
        //PRU_DD 1.10

        IF "Entry Type" > "Entry Type"::"Negative Adjmt." THEN
            ERROR(Text000, "Entry Type");
    end;

    trigger OnModifyRecord(): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Item Journal", '%1', UserSetup."Access Item Journal"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not  have Permission to Change Item Journal Details');
        //PRU_DD 1.10
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        SetUpNewLine(xRec);
        CLEAR(ShortcutDimCode);
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Item Journal", '%1', UserSetup."Access Item Journal"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10
    end;

    trigger OnOpenPage()
    var
        JnlSelected: Boolean;
    begin
        //PRU_DD 1.10
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Item Journal", '%1', UserSetup."Access Item Journal"::" ");
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to open Item Journal');

        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Item Journal", '%1', UserSetup."Access Item Journal"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10


        IF IsOpenedFromBatch THEN BEGIN
            CurrentJnlBatchName := "Journal Batch Name";
            ItemJnlMgt.OpenJnl(CurrentJnlBatchName, Rec);
            EXIT;
        END;
        ItemJnlMgt.TemplateSelection(PAGE::"Item Journal", 0, FALSE, Rec, JnlSelected);
        IF NOT JnlSelected THEN
            ERROR('');
        ItemJnlMgt.OpenJnl(CurrentJnlBatchName, Rec);
        UpdateNatureOfDisposal;
        MakeFieldNonEditable;
        OnActivateForm;
    end;

    var
        Text000: Label 'You cannot use entry type %1 in this journal.';
        ItemJnlMgt: Codeunit 240;
        ReportPrint: Codeunit 228;
        ItemAvailFormsMgt: Codeunit 353;
        CalcWhseAdjmt: Report 7315;
        CurrentJnlBatchName: Code[10];
        ItemDescription: Text[50];
        ShortcutDimCode: array[8] of Code[20];
        Text001: Label 'Item Journal lines have been successfully inserted from Standard Item Journal %1.';
        Text002: Label 'Standard Item Journal %1 has been successfully created.';
        [InDataSet]
        "Other UsageEditable": Boolean;
        [InDataSet]
        "Nature of DisposalEditable": Boolean;
        UserSetup: Record 91;


    local procedure UpdateNatureOfDisposal()
    begin
        IF "Entry Type" <> "Entry Type"::"Negative Adjmt." THEN BEGIN
            "Other UsageEditable" := FALSE;
            "Nature of DisposalEditable" := FALSE;
            //  "Other Usage" := 0;
            // "Nature of Disposal" := '';
        END ELSE BEGIN
            "Other UsageEditable" := TRUE;
            "Nature of DisposalEditable" := TRUE;
        END;
        //  IF "Other Usage" <> "Other Usage"::"Wasted/Destroyed" THEN
        //     "Nature of DisposalEditable" := FALSE;
    end;


    local procedure MakeFieldNonEditable()
    begin
        /*
        IF ("Other Usage" = "Other Usage"::"Wasted/Destroyed") OR ("Other Usage" = "Other Usage"::" ") THEN BEGIN
            "Nature of DisposalEditable" := FALSE;
            "Nature of Disposal" := '';
        END ELSE
            "Nature of DisposalEditable" := TRUE;
            */
    end;

    local procedure CurrentJnlBatchNameOnAfterVali()
    begin
        CurrPage.SAVERECORD;
        ItemJnlMgt.SetName(CurrentJnlBatchName, Rec);
        CurrPage.UPDATE(FALSE);
    end;

    local procedure OtherUsageOnActivate()
    begin
        MakeFieldNonEditable;
    end;

    local procedure OnActivateForm()
    begin
        UpdateNatureOfDisposal;
    end;

    local procedure OtherUsageOnAfterInput(var Text: Text[1024])
    begin
        MakeFieldNonEditable;
    end;

    local procedure OtherUsageOnInputChange(var Text: Text[1024])
    begin
        MakeFieldNonEditable;
    end;


}