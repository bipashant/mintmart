
$(document).ready(function () {
    $("#new_user").validate({
        rules: {
            "user[email]": {
                required: true
            },
            "user[password]": {
                required: true
            }
        },
        // Specify the validation error messages
        messages: {
            "user[email]": {
                required: 'Username/Email is required.'
            },
            "user[password]": {
                required: 'Password is required.'
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
