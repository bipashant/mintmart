
$(document).ready(function () {

    $('#new_supplier').validate({
        // Specify the validation rules
        rules: {
            'supplier[organization_name]': {
                required: true
            },
            'supplier[address]': {
                required: true
            },
            'supplier[contact_no]': {
                required: true
            }
        },

// Specify the validation error messages
        messages: {
            'supplier[organization_name]': {
                required: 'Organization Name is required.'
            },
            'supplier[address]': {
                required: 'Address is required.'
            },
            'supplier[contact_no]': {
                required: 'Contact Number is required.'
            }
        },
        errorPlacement: function (error, element) {
            error.appendTo('#' + element.attr('id') + '_error');
        },
        submitHandler: function (form) {

            form.submit();
        }
    });
});
