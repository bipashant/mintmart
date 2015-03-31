$(document).ready(function () {
    $("#new_category").validate({
        rules: {
            "category[name]": {
                required: true
            }
        },
        // Specify the validation error messages
        messages: {
            "category[name]": {
                required: 'Category Name is required.'
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
