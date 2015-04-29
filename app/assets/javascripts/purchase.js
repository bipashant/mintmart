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


    var purchaseDataTable = $('#purchase-table').dataTable({
        "pagingType": "full_numbers",
        "bLengthChange": false,
        "iDisplayLength":10,
        "aaSorting":[[0,'desc']],
        "processing": true
    });
    $('#input-search-purchase').on('input keyup paste', function() {
        purchaseDataTable.fnFilter(this.value);
    });

    // To prevent submit on enter we need to prevent default behaviour of Enter key on keydown event
    $('#input-search-purchase').keydown(function(event){
        if(event.keyCode == 13) {
            event.preventDefault();
            return false;
        }
    });
});
