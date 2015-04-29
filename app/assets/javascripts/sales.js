$(document).ready(function () {
    var itemsPurchased = new Array;
    var buttonText = '<span class="btn btn-danger delete-btn">Remove</span>';
    var buttonTextAll = '<span class="btn btn-danger delete-btn-all">Remove All</span>';

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
            $('#item_name').val('').focus();

            var data = [json.item_id, json.name, json.sell_price, 1, (json.sell_price * 1), buttonText];
            parseDataTable(data);
            drawDataTable();
        }
        else {
            alert('Item not found');
        }

    };

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
                ++itemsPurchased[val][3];
                itemsPurchased[val][4] = itemsPurchased[val][2] * itemsPurchased[val][3];
                if (itemsPurchased[val][3] == 2) {
                    itemsPurchased[val][5] += buttonTextAll;
                }
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
            $('#sale_amount').val($('#sales_net_total').html());
            var item_ids = ''
            var quantity = ''
            $.each(itemsPurchased, function( index, value ) {
                item_ids += value[0]+','
                quantity += value[3]+',';
            });
            $('#items_id_on_cart').val(item_ids);
            $('#items_quantity_on_cart').val(quantity);
            $('#items_quantity_on_cart').val();
            $('#checkout_div').modal('show');
        }
        else {
            $('#sales_error').modal('show');
        }

    });


    $('#create-sale-btn').on('click', function () {
        alert('ha ha ha ha ha ha');
    });


    $('#sales-main-table-new tbody').on('click', '.delete-btn', function () {
        var index = $('#sales-main-table-new tbody tr').index($(this).parent().parent());
        --itemsPurchased[index][3];
        if (itemsPurchased[index][3] <= 0) {
            itemsPurchased.splice(index, 1);
        }
        else {
            itemsPurchased[index][4] = itemsPurchased[index][2] * itemsPurchased[index][3];
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
            var form_data = $(form).serialize();
            var value_to_submit = {form_value: form_data, sold_item: itemsPurchased}
            $.ajax({
                type: "POST",
                url: $(form).attr('action'), //sumbits it to the given url of the form
                data: form_data,
                dataType: "JSON" // you want a difference between normal and ajax-calls, and json is standard
            }).success(function (data) {
                $('#myModal').modal('hide');
                $('#item_count').html(data.count);
                $('#total_amount').html(data.total_amount);
                $('#status_div_purchase').html('Item successfully created.').fadeIn(10).fadeOut(5000);
                itemDataTable.fnDraw();

            });
            return false; // prevents normal behaviour
        }
    });

});
