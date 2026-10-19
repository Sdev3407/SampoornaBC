page 50099 "Production Order List_1"
{
    // // PRU_AS0.0003 : Created this new page by Save as of Transfer Order List Page.

    Caption = 'Production Order List';
    DataCaptionFields = Status;
    DeleteAllowed = false;
    Editable = true;
    PageType = List;
    SourceTable = 5405;
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(grp)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Lookup = false;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Source No."; Rec."Source No.")
                {
                    ApplicationArea = All;
                }
                field("Description 2"; Rec."Description 2")
                {
                    ApplicationArea = All;
                }
                field("Routing No."; Rec."Routing No.")
                {
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Hatchery Name"; Rec."Hatchery Name")
                {
                    ApplicationArea = All;
                }
                field("Hatching Date"; Rec."Hatching Date")
                {
                    ApplicationArea = All;
                }
                field("Starting Time"; Rec."Starting Date-Time")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Starting Date"; Rec."Starting Date-Time")
                {
                    ApplicationArea = All;
                }
                field("Ending Time"; Rec."Ending Date-Time")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Ending Date"; Rec."Ending Date-Time")
                {
                    ApplicationArea = All;
                }
                field("Due Date"; Rec."Due Date")
                {
                    ApplicationArea = All;
                }
                field("Short Close"; Rec."Short Close")
                {
                    ApplicationArea = All;
                }
                field("Assigned User ID"; Rec."Assigned User ID")
                {
                    ApplicationArea = All;
                }
                field("Finished Date"; Rec."Finished Date")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Search Description"; Rec."Search Description")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
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
            group("Pro&d. Order")
            {
                Caption = 'Pro&d. Order';
                Image = "Order";
                action(Card)
                {
                    Caption = 'Card';
                    ApplicationArea = All;
                    Image = EditLines;
                    ShortCutKey = 'Shift+F7';

                    trigger OnAction()
                    begin
                        CASE Rec.Status OF
                            Rec.Status::Simulated:
                                PAGE.RUN(PAGE::"Simulated Production Order", Rec);
                            Rec.Status::Planned:
                                PAGE.RUN(PAGE::"Planned Production Order", Rec);
                            Rec.Status::"Firm Planned":
                                PAGE.RUN(PAGE::"Firm Planned Prod. Order", Rec);
                            Rec.Status::Released:
                                PAGE.RUN(PAGE::"Released Production Order", Rec);
                            Rec.Status::Finished:
                                PAGE.RUN(PAGE::"Finished Production Order", Rec);
                        END;
                    end;
                }
                group("E&ntries")
                {
                    Caption = 'E&ntries';
                    Image = Entries;
                    action("Item Ledger E&ntries")
                    {
                        Caption = 'Item Ledger E&ntries';
                        ApplicationArea = All;
                        Image = ItemLedger;
                        RunObject = Page "Item Ledger Entries";
                        RunPageLink = "Order Type" = CONST(Production),
                                      "Order No." = FIELD("No.");
                        RunPageView = SORTING("Order Type", "Order No.");
                        ShortCutKey = 'Ctrl+F7';
                    }
                    action("Capacity Ledger Entries")
                    {
                        Caption = 'Capacity Ledger Entries';
                        ApplicationArea = All;
                        Image = CapacityLedger;
                        RunObject = Page 5832;
                        RunPageLink = "Order Type" = CONST(Production),
                                      "Order No." = FIELD("No.");
                        RunPageView = SORTING("Order Type", "Order No.");
                    }
                    action("Value Entries")
                    {
                        Caption = 'Value Entries';
                        ApplicationArea = All;
                        Image = ValueLedger;
                        RunObject = Page "Value Entries";
                        RunPageLink = "Order Type" = CONST(Production),
                                      "Order No." = FIELD("No.");
                        RunPageView = SORTING("Order Type", "Order No.");
                    }
                    action("&Warehouse Entries")
                    {
                        Caption = '&Warehouse Entries';
                        ApplicationArea = All;
                        Image = BinLedger;
                        RunObject = Page 7318;
                        RunPageLink = "Source Type" = FILTER(83 | 5407),
                                      "Source Subtype" = FILTER(3 | 4 | 5),
                                      "Source No." = FIELD("No.");
                        RunPageView = SORTING("Source Type", "Source Subtype", "Source No.");
                    }
                }
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    ApplicationArea = All;
                    Image = ViewComments;
                    RunObject = Page 99000838;
                    RunPageLink = Status = FIELD(Status),
                                  "Prod. Order No." = FIELD("No.");
                }
                action(Dimensions)
                {
                    AccessByPermission = TableData 348 = R;
                    Caption = 'Dimensions';
                    ApplicationArea = All;
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';

                    trigger OnAction()
                    begin
                        Rec.ShowDocDim;
                        CurrPage.SAVERECORD;
                    end;
                }

                action(Statistics)
                {
                    Caption = 'Statistics';
                    ApplicationArea = All;
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Production Order Statistics";
                    RunPageLink = Status = FIELD(Status),
                                  "No." = FIELD("No."),
                                  "Date Filter" = FIELD("Date Filter");
                    ShortCutKey = 'F7';
                }
            }
        }
    }

    var
        UserSetup: Record 91;
}

