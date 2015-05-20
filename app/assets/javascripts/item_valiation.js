/**
 * Created by bipashant on 3/21/15.
 */
'use strict';
$(document).ready(function () {
    var itemDataTable = $('#items-main-table-new').dataTable({
        "pagingType": "full_numbers",
        "bLengthChange": false,
        "iDisplayLength":10,
        "aaSorting":[[0,'desc']],
        "processing": true,
        "serverSide": true,
        "ajax": $('#items-main-table-new').data('source'),
    });

    $('#input-search-items').on('input keyup paste', function() {
        itemDataTable.fnFilter(this.value);
    });

    // To prevent submit on enter we need to prevent default behaviour of Enter key on keydown event
    $('#input-search-items').keydown(function(event){
        if(event.keyCode == 13) {
            event.preventDefault();
            return false;
        }
    });


    $('#generate_item_id').on('click', function () {
        $.ajax({
            dataType: 'json',
            cache: false,
            url:'/purchased_items/generate_item_id_for_open_item',
            timeout: 20000,
            error: function (data) {
                alert('Something went wrong');
            },
            success: function (data) {
                $('#purchased_item_item_id').val(data.item_id);
            }
        });
    });

    $("#new_purchased_item").validate({
        rules: {
            "purchased_item[item_id]": {
                remote: '/purchased_items/check_item_id',
                required: true
            },
            "purchased_item[name]": {
                required: true
            },
            "purchased_item[category_id]": {
                required: true
            },
            "purchased_item[quantity]": {
                required: true
            },
            "purchased_item[unit_price]": {
                required: true,
                number: true
            },
            "purchased_item[sell_price]": {
                required: true,
                number: true
            },
            "purchased_item[expiration_date]": {
                required: true,
                date: true
            },
            "purchased_item[margin]": {
                required: true,
                number: true
            }

        },
        // Specify the validation error messages
        messages: {
            "purchased_item[item_id]": {
                remote: 'Already Taken.',
                required: 'Item ID is required.'
            },
            "purchased_item[name]": {
                required: 'Item Name is required'
            },
            "purchased_item[category_id]": {
                required: 'Category is required'
            },
            "purchased_item[quantity]": {
                required: 'Quantity is required'
            },
            "purchased_item[unit_price]": {
                required: 'Unit Price is required',
                number: 'Invalid Unit Price'
            },
            "purchased_item[sell_price]": {
                required: 'Sell Price is required',
                number: 'Invalid Sell Price'
            },
            "purchased_item[margin]": {
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
                itemDataTable.fnDraw();
                $('#items-main-table-new thead tr th:last-child').css('width','316px');


            });
            return false; // prevents normal behaviour
        }
    });
});

