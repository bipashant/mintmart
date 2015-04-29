
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



    var supplierMainDataTable = $('#supplier-main-table').dataTable({
        "pagingType": "full_numbers",
        "bLengthChange": false,
        "iDisplayLength":10,
        "aaSorting":[[0,'desc']],
        "processing": true
    });
    $('#input-search-supplier-main').on('input keyup paste', function() {
        supplierMainDataTable.fnFilter(this.value);
    });

    // To prevent submit on enter we need to prevent default behaviour of Enter key on keydown event
    $('#input-search-itemsOn-Category').keydown(function(event){
        if(event.keyCode == 13) {
            event.preventDefault();
            return false;
        }
    });

    var purchaseOnSupplierDataTable = $('#purchase-table-supplier').dataTable({
        "pagingType": "full_numbers",
        "bLengthChange": false,
        "iDisplayLength":10,
        "aaSorting":[[0,'desc']],
        "processing": true
    });
    $('#input-search-purchase-on-supplier').on('input keyup paste', function() {
        purchaseOnSupplierDataTable.fnFilter(this.value);
    });

    // To prevent submit on enter we need to prevent default behaviour of Enter key on keydown event
    $('#input-search-purchase-on-supplier').keydown(function(event){
        if(event.keyCode == 13) {
            event.preventDefault();
            return false;
        }
    });
});

