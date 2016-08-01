$(window).scroll(function(){
  var isScrolled = false;
  if($(window).scrollTop())
  {
    if(!isScrolled)
    {
      $('header').addClass('scrolled').find('img').attr('src', 'img/bug.jpg');
      console.log('scrolled...');
    }

    isScrolled = true;
  }
  else {
    $('header').removeClass('scrolled').find('img').attr('src', 'img/header.jpg');
    isScrolled = false;
  }
});
