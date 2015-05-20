/**
 * Created by bipashant on 5/20/15.
 */
$(document).ready(function(){
    $('#sales-index-main-table').dataTable({
        "pagingType": "simple_numbers",
        "bLengthChange": false,
        "iDisplayLength": 10000,
        "aaSorting": [[2, 'desc']],
        "processing": true,
        "serverSide": true,
        "ajax": $('#sales-index-main-table').data('source'),
        "aoColumnDefs": [
            {'bSortable': false, 'aTargets': [5]}
        ]
    });

    var saleDataTable = $('#sales-index-main-table').dataTable();
    $('#input-search-sales-main').on('input keyup paste', function () {
        saleDataTable.fnFilter(this.value);
    });

// To prevent submit on enter we need to prevent default behaviour of Enter key on keydown event
    $('#input-search-sales-main').keydown(function (event) {
        if (event.keyCode == 13) {
            event.preventDefault();
            return false;
        }
    });
});

