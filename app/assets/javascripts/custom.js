/**
 * Created by bipashant on 3/2/15.
 */
$(document).ready(function () {

    $("#logout-btn").on("click",function() {
        $("#mb-signout").show();
    });

    $('.accordion > a').click(function (e) {
        e.preventDefault();
        var $ul = $(this).siblings('ul');
        var $li = $(this).parent();
        if ($ul.is(':visible')) $li.removeClass('active');
        else                    $li.addClass('active');
        $ul.slideToggle();
    });

    $('.accordion li.active:first').parents('ul').slideDown();

    $('.btn-close').click(function (e) {
        e.preventDefault();
        $(this).parent().parent().parent().fadeOut();
    });
    $('.btn-minimize').click(function (e) {
        e.preventDefault();
        var $target = $(this).parent().parent().next('.box-content');
        if ($target.is(':visible')) $('i', $(this)).removeClass('glyphicon-chevron-up').addClass('glyphicon-chevron-down');
        else                       $('i', $(this)).removeClass('glyphicon-chevron-down').addClass('glyphicon-chevron-up');
        $target.slideToggle();
    });
    $('.btn-setting').click(function (e) {
        e.preventDefault();
        $('#myModal').modal('show');
    });
    $('#purchase_add_item_button').click(function (e) {
        e.preventDefault();
        $('#myModal').modal('show');
    });


    //////chosen - improves select
    ////$('[data-rel="chosen"],[rel="chosen"]').chosen();
    //
    //var config = {
    //    '.chosen-select'           : {},
    //    '.chosen-select-deselect'  : {allow_single_deselect:true},
    //    '.chosen-select-no-single' : {disable_search_threshold:10},
    //    '.chosen-select-no-results': {no_results_text:'Oops, nothing found!'},
    //    '.chosen-select-width'     : {width:"95%"}
    //}
    //for (var selector in config) {
    //    $(selector).chosen(config[selector]);
    //}
});
