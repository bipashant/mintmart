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


});
