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

    var categoryDataTable = $('#category-list-table').dataTable({
        "pagingType": "full_numbers",
        "bLengthChange": false,
        "iDisplayLength":10,
        "aaSorting":[[0,'desc']],
        "processing": true
    });
    $('#input-search-categories').on('input keyup paste', function() {
        categoryDataTable.fnFilter(this.value);
    });

    // To prevent submit on enter we need to prevent default behaviour of Enter key on keydown event
    $('#input-search-categories').keydown(function(event){
        if(event.keyCode == 13) {
            event.preventDefault();
            return false;
        }
    });

    var itemsOnCategoryDataTable = $('#items-table-on-category').dataTable({
        "pagingType": "full_numbers",
        "bLengthChange": false,
        "iDisplayLength":10,
        "aaSorting":[[0,'desc']],
        "processing": true
    });
    $('#input-search-itemsOn-Category').on('input keyup paste', function() {
        itemsOnCategoryDataTable.fnFilter(this.value);
    });

    // To prevent submit on enter we need to prevent default behaviour of Enter key on keydown event
    $('#input-search-itemsOn-Category').keydown(function(event){
        if(event.keyCode == 13) {
            event.preventDefault();
            return false;
        }
    });
});
