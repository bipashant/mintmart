/**
 * Created by bipashant on 3/21/15.
 */

$(document).ready(function () {

    $('#purchase_date').datetimepicker({
        theme: 'dark',
        timepicker: false,
        format: 'Y-m-d'
    });

    $('#new_purchase').validate({
        // Specify the validation rules
        rules: {
            'purchase[supplier_id]': {
                required: true
            },
            'purchase[date]': {
                required: true
            }
        },

// Specify the validation error messages
        messages: {
            'purchase[supplier_id]': {
                required: 'Supplier is required.'
            },
            'purchase[date]': {
                required: 'Purchase Date is required.'
            }
        },
        errorPlacement: function (error, element) {
            error.appendTo('#' + element.attr('id') + '_error');
        },
        submitHandler: function (form) {

           form.submit();
        }
    });

    $('#btn_delete').click(function (e) {
        e.preventDefault();
        $('#confirm_dialogue_on_delete').modal('show');
    });

});
