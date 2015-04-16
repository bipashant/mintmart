/**
 * Created by bipashant on 4/13/15.
 */
$(document).ready(function () {
    $('#item_category_id').change(function () {
        var selected_category = $(this).val();
       $.ajax({
            dataType: 'json',
            cache: false,
            url: '/categories/include_vat/?id='+selected_category,
            timeout: 20000,
            success: function (data) {
                if(data == 1){
                    $('#vat_included_div').removeClass('hide');
                    $('#vat_included_div').addClass('btn-success');
                    $('#vat_percentage').val('13');
                }
                else{
                    $('#vat_included_div').addClass('hide');
                    $('#vat_percentage').val('0');
                }
                calculate_sale_price();
            }
        });
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

    $('#clear_all_field').click(function () {
        $("#new_item").validate().resetForm();
        $('#settlement_invoice_settlement_id').val('');
        $('#new_item input[type="text"]').val('');
        $('#vat_included_div').addClass('hide');
        $('#vat_percentage').val('0');

    });

    });
