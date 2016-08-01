$(document).ready(function(){
  $('header button').click(function(){
    var parent = $(this).parent();
    var parentId = parent.attr('id');
    if(parentId != null)
    {
      parentId = parentId.split('-btn')[0];
    }
    $('#menu-nav,#search-nav,#refer-nav').hide();
    $('#' + parentId + '-nav').show();
    $('#push-menu').show().animate({ 'width': '500px' }, 600);
    $('body').addClass('pushed').animate({ 'margin-left': '500px' }, 600);
  });
  $(".close-menu").click(function(){
    $('#push-menu').animate({ 'width': '0' }, 600, function(){
      $(this).hide();
    });
    $("body").removeClass("pushed").animate({"margin-left": "0"}, 600, function(){
      $('#menu-nav,#search-nav,#refer-nav').hide();
    }).removeClass("exposed");;
  });
  $('#menu-nav li').click(function(){
    $(this).find('ul').slideToggle();
    $(this).find('.fa').toggleClass('fa-minus fa-plus');
  });
});
