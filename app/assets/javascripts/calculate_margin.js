/**
 * Created by bipashant on 3/29/15.
 */
$(document).ready(function () {

    $('#item_unit_price').on('input keyup paste', function() {
        calculate_sale_price();
    });

    $('#margin_percentage').on('input keyup paste', function() {
        calculate_sale_price();
    });
    var calculate_sale_price = function()
    {
        var unit_price = parseFloat($('#item_unit_price').val());
        var margin = parseFloat($('#margin_percentage').val());
        var vat = parseFloat($('#vat_percentage').val());
        var sale_price = unit_price +unit_price*vat/100+ unit_price * margin/100;
        if(sale_price.toString()=="NaN")
        {
            sale_price = 0;
        }
        $('#item_sell_price').val(sale_price);
    }


});
