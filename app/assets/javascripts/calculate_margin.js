/**
 * Created by bipashant on 3/29/15.
 */
$(document).ready(function () {

    $('#item_unit_price').on('input keyup paste', function() {
        calculate_sale_price();
    });

    $('#item_sell_price').on('input keyup paste', function() {
        calculate_margin();
    });

    $('#item_margin').on('input keyup paste', function() {
        calculate_sale_price();
    });
    var calculate_sale_price = function()
    {
        var unit_price = parseFloat($('#item_unit_price').val());
        var margin = parseFloat($('#item_margin').val());
        var vat = parseFloat($('#vat_percentage').val());
        var sale_price_with_out_vat = unit_price + unit_price * margin/100;
        sale_price = sale_price_with_out_vat+sale_price_with_out_vat * vat/100;

        if(sale_price.toString()=="NaN")
        {
            sale_price = 0;
        }
        $('#item_sell_price').val(sale_price);
    }

    var calculate_margin = function()
    {
        var unit_price = parseFloat($('#item_unit_price').val());
        var sell_price = parseFloat($('#item_sell_price').val());
        var margin = (sell_price - unit_price)/unit_price *100;

     if(margin.toString()=="NaN")
        {
            margin = 0;
        }
        $('#item_margin').val(margin);
    }


});
