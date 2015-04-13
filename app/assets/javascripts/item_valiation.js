/**
 * Created by bipashant on 3/21/15.
 */
'use strict';
$(document).ready(function () {
    var item_list_on_purchase = $('#items-table-purchase').dataTable({
        "pagingType": "full_numbers",
        "bLengthChange": false,
        "iDisplayLength": 10,
        "aaSorting": [[3, 'desc']]
    });

    var item_datatable_on_index = $('#items-main-table').dataTable({
        "pagingType": "simple_numbers",
        "bLengthChange": false,
        "iDisplayLength": 10,
        "aaSorting": [[0, 'asc']],
        "processing": true,
        "serverSide": true,
        "aoColumnDefs": [
            {'bSortable': false, 'aTargets': [5]},
            {'bSearchable': false, 'aTargets': [5]}
        ]
    });

    $('#input-search-items').on('input keyup paste', function () {
        item_datatable_on_index.fnFilter(this.value);
    });
    $('#generate_item_id').on('click', function () {
        $.ajax({
            dataType: 'json',
            cache: false,
            url:'/items/generate_item_id_for_open_item',
            timeout: 20000,
            error: function (data) {
                alert('error');
            },
            success: function (data) {
                $('#item_item_id').val(data.item_id);
            }
        });
    });

    $("#new_item").validate({
        rules: {
            "item[item_id]": {
                remote: '/items/check_item_id',
                required: true
            },
            "item[name]": {
                required: true
            },
            "item[category_id]": {
                required: true
            },
            "item[quantity]": {
                required: true
            },
            "item[unit_price]": {
                required: true,
                number: true
            },
            "item[sell_price]": {
                required: true,
                number: true
            },
            "item[expiration_date]": {
                required: true,
                date: true
            },
            "margin_percentage": {
                required: true,
                number: true
            }

        },
        // Specify the validation error messages
        messages: {
            "item[item_id]": {
                remote: 'Already Taken.',
                required: 'Item ID is required.'
            },
            "item[name]": {
                required: 'Item Name is required'
            },
            "item[category_id]": {
                required: 'Category is required'
            },
            "item[quantity]": {
                required: 'Quantity is required'
            },
            "item[unit_price]": {
                required: 'Unit Price is required',
                number: 'Invalid Unit Price'
            },
            "item[sell_price]": {
                required: 'Sell Price is required',
                number: 'Invalid Sell Price'
            },
            "margin_percentage": {
                required: 'Margin  is required.',
                number: 'Invalid Margin Percentage'
            }

        },
        errorPlacement: function (error, element) {
            error.appendTo('#' + element.attr('id') + '_error');
        },
        submitHandler: function (form) {
            var valuesToSubmit = $(form).serialize();
            $.ajax({
                type: "POST",
                url: $(form).attr('action'), //sumbits it to the given url of the form
                data: valuesToSubmit,
                dataType: "JSON" // you want a difference between normal and ajax-calls, and json is standard
            }).success(function (data) {
                $('#myModal').modal('hide');
                $('#item_count').html(data.count);
                $('#total_amount').html(data.total_amount);
                $('#status_div_purchase').html('Item successfully created.').fadeIn(10).fadeOut(5000);

            });
            return false; // prevents normal behaviour
        }
    });

    $("#tabs > li").click(function () {
        return false;
    });

});

