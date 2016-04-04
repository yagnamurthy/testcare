$(window).load(function() {
    if ( window.location.pathname == '/' ){
         $('li').each(function(){
           $(this).removeClass('active');
       });

    } else {
      $('li').each(function(){
           if(window.location.href.indexOf($(this).find('a:first').attr('href'))>-1) {
           $(this).addClass('active').siblings().removeClass('active');
           }
       });
    }
});