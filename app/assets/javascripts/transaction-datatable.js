'use strict';$(document).ready( function () {    /*Starting of  Transaction table on Merchant dashboard*/    var itemOnPurchaseTable = $('#items-table-purchase').dataTable({        "pagingType": "full_numbers",        "bLengthChange": false,        "iDisplayLength": 5,        "aaSorting":[[2,'desc']],        "processing": true,        "serverSide": true,        "ajax": $('#items-table-purchase').data('source'),    });    /*Starting of  Transaction table on admin dashboard*/    $('#trans-table-admin').dataTable({        "pagingType": "simple_numbers",        "bLengthChange": false,        "iDisplayLength": 10,        "aaSorting": [[3, 'desc']],        "processing": true,        "serverSide": true,        "ajax": $('#trans-table-admin').data('source'),        "aoColumnDefs": [            {'bSortable': false, 'aTargets': [7]}        ]    });    $('#input-search-merchant').on('input keyup paste', function() {        dataTableMerchant.fnFilter(safe_tags(this.value));    });    // To prevent submit on enter we need to prevent default behaviour of Enter key on keydown event    $('#input-search-merchant').keydown(function(event){        if(event.keyCode == 13) {            event.preventDefault();            return false;        }    });    /*end of Transaction table on admin dashboard*/    /*Starting of  Transaction table on admin dashboard*/    $('#trans-table-admin').dataTable({        "pagingType": "simple_numbers",        "bLengthChange": false,        "iDisplayLength": 10,        "aaSorting":[[3,'desc']],        "processing": true,        "serverSide": true,        "ajax": $('#trans-table-admin').data('source'),        "aoColumnDefs": [            { 'bSortable': false, 'aTargets': [7] }        ]    });    var dataTableAdmin = $('#trans-table-admin').dataTable();    $('#input-search-admin').on('input keyup paste', function() {        $('#select-merchant').val("");        dataTableAdmin.fnFilter(safe_tags(this.value));    });    // To prevent submit on enter we need to prevent default behaviour of Enter key on keydown event    $('#input-search-admin').keydown(function(event){        if(event.keyCode == 13) {            event.preventDefault();            return false;        }    });    $('#select-merchant').on('change', function() {        $('#input-search-admin').val("");        dataTableAdmin.fnFilter(this.value);    });    // to parse bogus input in name_on_card field    var safe_tags = function(str) {      return str.replace(/&/g,'&amp;').replace(/</g,'&lt;').replace(/>/g,'&gt;') ;    }    /*end of Transaction table on admin dashboard*/});