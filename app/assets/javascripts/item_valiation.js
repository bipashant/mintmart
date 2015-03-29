/**
 * Created by bipashant on 3/21/15.
 */
'use strict';
$(document).ready(function () {
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
                required: true
            },
            "item[sell_price]": {
                required: true
            }

        }

        // Specify the validation error messages
        messages: {
            "organization[name]": {
                required: I18n.t('organization_name_required'),
                remote: I18n.t('organization_name_not_available')
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
                $('#business_profile_organization_id').val(json.id);
                $('#tab-first').removeClass('active');
                $('#tab-second').addClass('active');
                $('#create-org-tab').removeClass('active');
                $('#add-profile-tab').addClass('active')
            });
            return false; // prevents normal behaviour
        }
    });

    $("#tabs > li").click(function () {
        return false;
    });
});

