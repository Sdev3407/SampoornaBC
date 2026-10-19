page 50054 "Production_Role C"
{
    PageType = RoleCenter;

    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(rolecenter)
        {
            group(grp)
            {
                part("Production Planner Activities"; 9038)
                {
                    ApplicationArea = All;
                    Caption = 'Production Planner Activities';
                }
                group(grop)
                {
                    part("My Job Queue"; 675)
                    {
                        ApplicationArea = All;
                        Caption = 'My Job Queue';
                    }
                    part("My Items"; 9152)
                    {
                        ApplicationArea = All;
                        Caption = 'My Items';
                    }

                    systempart(MyNotes; MyNotes)
                    {
                        ApplicationArea = All;
                        Caption = 'MyNotes';
                    }
                }
            }
        }
    }

    actions
    {
        area(embedding)
        {

            action("<Page Released Prod Orders>")
            {
                Caption = 'Released Production Orders';
                ApplicationArea = All;
                RunObject = Page 9326;
            }
            action("<Page Finished Prod Orders>")
            {
                Caption = 'Finished Production Orders';
                ApplicationArea = All;
                RunObject = Page 9327;
            }
            action("Transfer Orders")
            {
                Caption = 'Transfer Orders';
                ApplicationArea = All;
                RunObject = Page 5742;
            }
            action(Item)
            {
                Caption = 'Item';
                ApplicationArea = All;
                RunObject = Page "Item List";
            }

            action("Production BOMs")
            {
                Caption = 'Production BOMs';
                ApplicationArea = All;
                RunObject = Page 99000787;
            }

            action(Routings)
            {
                Caption = 'Routings';
                ApplicationArea = All;
                RunObject = Page 99000764;
            }


            action("<Page Item Journal for Bags>")
            {
                Caption = 'Item Journal for Bags';
                ApplicationArea = All;
                Promoted = true;
                RunObject = Page 50019;
            }
        }
        area(sections)
        {
            group(Journal)
            {
                Caption = 'Journal';
            }
            group(Worsheets)
            {
                Caption = 'Worsheets';
                Image = Worksheets;
            }
            group("Product Design")
            {
                Caption = 'Product Design';
                Image = ProductDesign;
                action("Production BOM")
                {
                    Caption = 'Production BOM';
                    ApplicationArea = All;
                    RunObject = Page 99000787;
                }
                action(Certified)
                {
                    Caption = 'Certified';
                    ApplicationArea = All;
                    RunObject = Page 99000787;
                }
                action(Items)
                {
                    Caption = 'Items';
                    ApplicationArea = All;
                    RunObject = Page "Item List";
                }
                action(Produced)
                {
                    Caption = 'Produced';
                    ApplicationArea = All;
                    RunObject = Page "Item List";
                }
            }
            group(Capacities)
            {
                Caption = 'Capacities';
                Image = Capacities;
                action("Work Centers")
                {
                    Caption = 'Work Centers';
                    ApplicationArea = All;
                    RunObject = Page 99000755;
                }
                action("Machine Centers")
                {
                    Caption = 'Machine Centers';
                    ApplicationArea = All;
                    RunObject = Page 99000761;
                }
                action(Routing)
                {
                    Caption = 'Routing';
                    ApplicationArea = All;
                    RunObject = Page 99000764;
                }
            }
        }
    }
}

