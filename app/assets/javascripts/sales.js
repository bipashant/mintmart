$(document).ready(function () {
    var itemsPurchased = new Array;
    var buttonText = '<span class="btn btn-danger delete-btn">Remove</span>' +  '<span class="btn btn-danger delete-btn-all">Remove All</span>';
    var json_data;
    var total_quantity = 0;
    var quantity = 0;

    $('#new-sale').validate({
        rules: {
            "item[name]": {
                required: true
            }
        },
        messages: {
            "item[name]": {
                required: 'Item ID. is required.'
            }
        },
        submitHandler: function (form) {
            var valuesToSubmit = $(form).serialize();
            $.ajax({
                type: "GET",
                url: '/sales/find_item',
                data: valuesToSubmit,
                dataType: "JSON"
            }).done(successfn).fail(errorfn);
            return false;
        }
    });

    var successfn = function (json) {
        if (json != null) {
            json_data = json;
            $('#add_quantity_div').modal('show');
            $('#item_name').val('').focus();
            $('#sell_item_id').val(json_data.item_id);
            $('#sell_item_name').val(json_data.name);
            $('#sell_item_rate').val(json_data.sell_price);
            $('#sell_item_quantity').val('1');
            $('#sell_total_amount').val(json_data.sell_price);
            $('#curent_item_quantity').val(json_data.quantity);

            quantity = $('#sell_item_quantity').val();
            for (var i = 0; i < itemsPurchased.length; i++) {
                if (itemsPurchased[i].indexOf(json_data.item_id) >= 0) {
                    total_quantity = parseInt(itemsPurchased[i][3]) + parseInt(quantity);
                }
                else {
                    total_quantity = parseInt(quantity)
                }
            }

            check_item_status();
        }

    };
    $('#sell_item_rate').on('input keyup paste', function() {
        calculate_sale_price();
    });


    $('#sell_item_quantity').on('input keyup paste', function () {

        check_item_status();
        calculate_sale_price();
    });

    var calculate_sale_price = function() {
        var rate = parseFloat($('#sell_item_rate').val());
        var quantity = parseFloat($('#sell_item_quantity').val());
        var total = rate * quantity;
        if(total.toString()=="NaN")
        {
            total = 0;
        }
        $('#sell_total_amount').val(total);
    }

    var check_item_status = function () {
        quantity = $('#sell_item_quantity').val();
        var stock_quantity = parseInt($('#curent_item_quantity').val());
        total_quantity = parseInt(quantity);
        for (var i = 0; i < itemsPurchased.length; i++) {
            if (itemsPurchased[i].indexOf(json_data.item_id) >= 0) {
                total_quantity = parseInt(itemsPurchased[i][3]) + parseInt(quantity);
                if (stock_quantity < total_quantity) {
                    $('#sell_item_quantity_error').html('Item quantity exceeds.Maximum quantity is ' + stock_quantity - parseInt(itemsPurchased[i][3]));
                    $('#sell_save_items').hide();
                }
            }
            else {
                total_quantity = parseInt(quantity)
            }
        }

        if (stock_quantity < total_quantity) {
            $('#sell_item_quantity_error').html('Item quantity exceeds.Maximum quantity is ' + stock_quantity.toString());
            $('#sell_save_items').hide();
        }
        else {
            $('#sell_item_quantity_error').html('');
            $('#sell_save_items').show();
        }
    }

    $('#sell_save_items').on('click', function () {
        $('#add_quantity_form').validate();
        if ($('#add_quantity_form').valid()){

            quantity = $('#sell_item_quantity').val();
            rate = $('#sell_item_rate').val();
            $('#add_quantity_div').modal('hide');
            var total_amount = $('#sell_total_amount').val();
            $('#sell_total_amount').val(json_data.sell_price);
            var data = [json_data.item_id, json_data.name, rate, quantity, total_amount, buttonText];
            parseDataTable(data);
            drawDataTable();

            $('#item_name').focus();
        }
    });

    var drawDataTable = function () {
        $('#sales-main-table-new').dataTable().fnDestroy();
        $('#sales-main-table-new').dataTable({
            "pagingType": "simple_numbers",
            "bLengthChange": false,
            "iDisplayLength": 10,
            "aaSorting": [[0, 'asc']],
            "processing": true,
            "aaData": itemsPurchased
        });
        $('#sales_net_total').html(add_column(5));
    };

    var add_column = function (index) {
        var net_total = 0;
        $('#sales-main-table-new tbody tr td:nth-child(' + index + ')').each(function () {
            net_total += parseFloat($(this).html());
        });
        return net_total;
    };

    var parseDataTable = function (data) {
        var flag = true;
        $.each(itemsPurchased, function (val) {
            if (this[0] === data[0]) {
                this[2] = data[2];
                itemsPurchased[val][3] = parseInt(itemsPurchased[val][3]) + parseInt(data[3]);
                itemsPurchased[val][4] = itemsPurchased[val][2] * itemsPurchased[val][3];
                flag = false;
            }
        });
        if (flag) {
            itemsPurchased.push(data);
        }
    };

    var errorfn = function () {

    };

    $('#sales-main-table-new tbody').on('click', '.delete-btn-all', function () {
        var index = $('#sales-main-table-new tbody tr').index($(this).parent().parent());
        itemsPurchased.splice(index, 1);
        drawDataTable();
    });


    $('#sell_item_btn').on('click', function () {
        if (itemsPurchased.length > 0) {
            $('#checkout_total_amount').val($('#sales_net_total').html());
            $('#sale_amount').val($('#sales_net_total').html());
            var item_ids = ''
            var quantity = ''
            var rate = ''
            $.each(itemsPurchased, function (index, value) {
                item_ids += value[0] + ','
                quantity += value[3] + ',';
                rate += value[2] + ',';
            });
            $('#items_id_on_cart').val(item_ids);
            $('#items_quantity_on_cart').val(quantity);
            $('#items_rate_on_cart').val(rate);
            $('#checkout_div').modal('show');
        }
        else {
            $('#sales_error').modal('show');
        }

    });

    $('#sales-main-table-new tbody').on('click', '.delete-btn', function () {
        var item_id = ($(this).parent().parent().children()[0]).innerHTML;
        for (var i = 0; i < itemsPurchased.length; i++) {
            if (itemsPurchased[i].indexOf(item_id) >= 0) {
                --itemsPurchased[i][3];
                if (itemsPurchased[i][3] <= 0) {
                    itemsPurchased.splice(i, 1);
                }
                else {
                    itemsPurchased[i][4] = itemsPurchased[i][2] * itemsPurchased[i][3];
                }
            }
        }

        drawDataTable();
    });

    $("#new_sale").validate({
        rules: {
            "sale[amount]": {
                required: true,
                number: true
            },
            "sale[discount]": {
                number: true
            }
        },
        // Specify the validation error messages
        messages: {
            "sale[amount]": {
                required: 'Amount is required',
                number: 'Amount should be numeric'
            },
            "sale[discount]": {
                required: 'Amount is required',
                number: 'Discount should be numeric.'
            }
        },
        errorPlacement: function (error, element) {
            error.appendTo('#' + element.attr('id') + '_error');
        },
        submitHandler: function (form) {
            form.submit()
            //var form_data = $(form).serialize();
            //var value_to_submit = {form_value: form_data, sold_item: itemsPurchased}
            //$.ajax({
            //    type: "POST",
            //    url: $(form).attr('action'), //sumbits it to the given url of the form
            //    data: form_data,
            //    dataType: "JSON" // you want a difference between normal and ajax-calls, and json is standard
            //}).success(function (data) {
            //    $('#myModal').modal('hide');
            //    $('#item_count').html(data.count);
            //    $('#total_amount').html(data.total_amount);
            //    $('#status_div_purchase').html('Item successfully created.').fadeIn(10).fadeOut(5000);
            //    itemDataTable.fnDraw();
            //
            //});
            //return false; // prevents normal behaviour
        }
    });

});
