/**
 * Created by bipashant on 3/29/15.
 */
$(document).ready(function () {

    $('#checkout_total_amount').on('input keyup paste', function() {
        calculate_final_amount();
        calculate_retunable_amount
    });

    $('#sale_discount').on('input keyup paste', function() {
        calculate_final_amount();
        calculate_retunable_amount
    });

    $('#sale_amount').on('input keyup paste', function() {
        calculate_discount();
        calculate_retunable_amount
    });

    var calculate_final_amount = function()
    {
        var initial_amount = parseFloat($('#checkout_total_amount').val());
        var discount = parseFloat($('#sale_discount').val());

        var final_amount = initial_amount - initial_amount * discount/100;
        if(final_amount.toString()=="NaN")
        {
            final_amount = 0;
        }
        $('#sale_amount').val(final_amount);
    }

    var calculate_discount = function()
    {
        var initial_amount = parseFloat($('#checkout_total_amount').val());
        var final_amount = parseFloat($('#sale_amount').val());

        var discount = (initial_amount - final_amount)/initial_amount *100;

     if(discount.toString()=="NaN")
        {
            discount = 0;
        }
        $('#sale_discount').val(discount);
    }

    $('#checkout_received_amount').on('input keyup paste', function() {
        calculate_retunable_amount
        var sale_amount = parseFloat($('#sale_amount').val());
        var received_amount = parseFloat($('#checkout_received_amount').val());

        var returnable_amount = received_amount - sale_amount;

        if(returnable_amount.toString()=="NaN")
        {
            returnable_amount = 0;
        }
        debugger;
        $('#checkout_returnable_amount').val(returnable_amount);
    });
    var calculate_retunable_amount = function(){

        var sale_amount = parseFloat($('#sale_amount').val());
        var received_amount = parseFloat($('#checkout_received_amount').val());

        var returnable_amount = received_amount - sale_amount;

        if(returnable_amount.toString()=="NaN")
        {
            returnable_amount = 0;
        }
        debugger;
        $('#checkout_returnable_amount').val(returnable_amount);
    }
});
