function submitForm()
{
  document.portal_form.submit();
}
function setAction(action)
{
  document.portal_form.ACTION.value = action;
}
function switchTab(screenStr)
{
  document.portal_form.SCREEN.value = screenStr;
}

var topMenu = $('#top-actions');
var scrollTop     = $(window).scrollTop(),
    elementOffset = topMenu.offset().top,
    distance      = (elementOffset - scrollTop);
$(window).scroll(function() {
  if ($(this).scrollTop() > distance){
    topMenu.addClass("sticky");
    var paddingLeft = topMenu.css('padding-left').replace('px', '');
    var paddingRight = topMenu.css('padding-right').replace('px', '');
    var paddingHorizontal = parseInt(paddingLeft) + parseInt(paddingRight);
    topMenu.width(topMenu.parent().width() - paddingHorizontal);
  }
  else{
    topMenu.removeClass("sticky");
  }
});
$(document).ready(function(){
  $('.clickable').click(function(){
    var id = $(this).attr('id');
    var target = $('.collapsed-' + id);
    var toggle = $('.toggle-' + id);

    $(target).each(function(){
      $(this).toggle();
    });

    $(toggle).toggleClass('fa-minus');
  });
});
