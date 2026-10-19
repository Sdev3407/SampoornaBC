namespace Sampoorna_BC.Sampoorna_BC;

enum 50001 "Eway Cancel Reason"
{

    Extensible = true;

    value(0; " ")
    {
        Caption = ' ';
    }
    value(1; Duplicate)
    {
        Caption = 'Duplicate';
    }
    value(2; "Data Entry Mistake")
    {
        Caption = 'Data Entry Mistake';
    }
    value(3; "Order Canceled")
    {
        Caption = 'Order Canceled';
    }
    value(4; "Others")
    {
        Caption = 'Others';
    }
}