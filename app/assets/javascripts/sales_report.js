/**
 * Created by bipashant on 5/20/15.
 */
$(document).ready(function(){

    var SALE_BASE_URL = 'sales/index'
    $('#sales_reports_form').validate({
        focusInvalid: false,// to prevent the calendar to pop-out on error
        rules: {
            "start_date": {
                required: true
            },
            "end_date": {
                required: true
            }
        },
        messages: {
            "start_date": {
                required: 'Start Date is required'
            },
            "end_date": {
                required: 'End Date is required'
            }
        },
        errorPlacement: function (error, element) {
            error.appendTo('#' + element.attr('id') + '_error');
        },
        submitHandler: function () {
            // submit form only when form elements have changed
               data = $("#sales_reports_form").serialize();
            $('#sales-index-main-table').dataTable().fnDestroy();
            $('#sales-index-main-table').dataTable({
                "pagingType": "simple_numbers",
                "bLengthChange": false,
                "iDisplayLength": 10,
                "aaSorting": [[2, 'desc']],
                "processing": true,
                "serverSide": true,
                "ajax":{
                    url: '/sales/',
                    type: 'get',
                    data: { start_date: $('#sales_report_start_date').val(),end_date:$('#sales_report_end_date').val()},
                    contentType: 'json'
                },
                    "aoColumnDefs": [
                        {'bSortable': false, 'aTargets': [5]}
                    ],
                "footerCallback": function (row, data, start, end, display) {
                    var net_total = 0;
                    $(data).each(function () {
                        net_total += parseFloat($(this)[2]);
                    });
                    $('#sales-table-footer-total').html( net_total);
                }

            });



        }
        });

    var add_column = function (index) {

        $('#sales-index-main-table tbody tr td:nth-child(' + index + ')').each(function () {
            net_total += parseFloat($(this).html());
        });
        debugger;
        return net_total;
    };
    });
