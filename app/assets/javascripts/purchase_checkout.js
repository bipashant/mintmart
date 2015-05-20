$(document).ready(function(){

    $('#close_purchase_btn').click(function(){
        var current_purchase = $('#purchased_item_purchase_id').val();

        $.ajax({
            dataType: 'json',
            cache: false,
            url: '/purchases/activate_purchase/?id='+current_purchase,
            timeout: 20000,
            success: function (data) {
                $('#close_purchase_btn').hide();
                window.location.replace('http://localhost:3000/purchases');
            },
            error: function(data){
                alert('Something went wrong.Please refresh the page.');
            }
        });
    });

    $('#add_quantity_div').keypress(function(e) {
        if (e.keyCode == $.ui.keyCode.ENTER) {
            $('#sell_save_items').click();
            $('#item_name').focus();

        }
    });

});
