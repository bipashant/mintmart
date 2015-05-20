/**
 * Created by bipashant on 5/14/15.
 */
$(document).ready(function(){

    $("#add_quantity_form").validate({
        rules: {
            "sell_item_id": {
                required: true
            },
            "sell_item_name": {
                required: true
            },
            "sell_item_rate": {
                required: true,
                number: true
            },
            "sell_item_quantity": {
                required: true,
                number: true
            },
            "sell_total_amount": {
                required: true,
                number: true
            }
        },
        // Specify the validation error messages
        messages: {
            "sell_item_id": {
                required: "ID is required."
            },
            "sell_item_name": {
                required: "Name is required."
            },
            "sell_item_rate": {
                required: "Rate is required.",
                number: "Invalid Number."
            },
            "sell_item_quantity": {
                required: "Quantity is required.",
                number: "Invalid Number."
            },
            "sell_total_amount": {
                required: "Total amount is required.",
                number: "Invalid Number."
            }
        },
        errorPlacement: function (error, element) {
            error.appendTo('#' + element.attr('id') + '_error');
        },
        submitHandler: function (form) {

        }
    });
});
