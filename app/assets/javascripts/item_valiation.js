/**
 * Created by bipashant on 3/21/15.
 */
'use strict';
$(document).ready(function () {

    var item_list_on_purchase = $('#items-table-purchase').dataTable({
        "pagingType": "simple_numbers",
        "bLengthChange": false,
        "iDisplayLength": 1,
        "aaSorting": [[3, 'desc']],
        "processing": true,
        "serverSide": true
    });

    var purchase_list_on_show_page =  $('#purchase-table-purchase').dataTable({
        "pagingType": "simple_numbers",
        "bLengthChange": false,
        "iDisplayLength": 1,
        "aaSorting": [[3, 'desc']],
        "processing": true,
        "serverSide": true
    });
    $("#new_item").validate({
        rules: {
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
            }).success(function (json) {
                $('#myModal').modal('hide');
                purchase_list_on_show_page.fnDraw();
                item_list_on_purchase.fnDraw();
            });
            return false; // prevents normal behaviour
        }
    });

    $("#tabs > li").click(function () {
        return false;
    });

});

