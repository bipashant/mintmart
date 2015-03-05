'use strict';
$(document).ready(function() {
    $("#new_user").validate({
        rules: {
            "user[email]": {
                required: true
            },
            "user[password]": {
                required: true
            }
        },

    messages: {
        "user[email]": {
            required: "Email is requird"
        },
        "user[password]": {
            required: "password is required"
        },
        submitHandler: function (form) {
            form.submit();
        }
    }
    })
});
