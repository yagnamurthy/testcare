$(function() {

  if ($("div.sidebar-scrolling").size() === 0)
    return;

  var nav = $('div.sidebar-scrolling');
  var navHomeY = nav.offset().top;
  var isFixed = false;
  var $w = $(window);
  var height = nav.height();

  $w.scroll(function() {
      var scrollTop = $w.scrollTop();
      var shouldBeFixed = scrollTop > navHomeY;

      if (scrollTop >= $("footer.main").offset().top - height) {
        nav.css({
          top: 'auto',
          bottom: $("footer.main").height()+2,
        });
      }
      else {
        nav.css({
          top: 0,
          bottom: 'auto'
        });
      }

      if (shouldBeFixed && !isFixed) {
             nav.css({
                 position: 'fixed',
                 top: 0,
                 left: nav.offset().left,
                 width: nav.width(),
             });
             isFixed = true;
      }
      else if (!shouldBeFixed && isFixed)
      {
          nav.css({
              position: 'absolute',
              left: 0
          });
          isFixed = false;
      }
  });

});