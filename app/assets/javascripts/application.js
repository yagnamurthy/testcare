//= require jquery
//= require jquery_ujs
//= require maskedinput
//= require jquery-ui
//= require cloudinary/jquery.ui.widget
//= require cloudinary/load-image.min
//= require cloudinary/canvas-to-blob.min
//= require cloudinary/jquery.iframe-transport
//= require cloudinary/jquery.fileupload
//= require cloudinary/jquery.fileupload-process
//= require cloudinary/jquery.fileupload-image
//= require cloudinary/jquery.fileupload-validate
//= require cloudinary/jquery.cloudinary
//= require jquery.remotipart
//= require cloudinary/selectivity-full
//= require vendor/modernizr
//= require foundation
//= require jquery.modal
//= require jquery.tokeninput
//= require jquery.html5-placeholder-shim
//= require selectize
//= require rails.validations
//= require accountingjs
//= require countable
//= require jquery.mask-input
//= require maskedinput
//= require jquery.raty.min
//= require find_caretaker_step
//= require_tree .


// We need to move the code from this file
// to the relative Backbone Views


$.ajaxSetup({
  headers: {
    'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
  }
});

$.cloudinary.config({ cloud_name: 'carespotter', api_key: '685381727265862'});

(function (App, $) {

   App.Init = function() {
      $(document).ready(function(){ onReady(); });
      $(window).load(function() { onLoad(); });
   };

   var onReady = function() {
      $(document).foundation();
      App.Plugins.FormsAddons();
      App.Plugins.ForgotPasswordButton();
      if ($("ul#about-menu a").length) App.Plugins.PageScroller("ul#about-menu a");
      if ($(".family-applications a.extended-view").length) App.Plugins.FamilyApplicationViewSwitcher();
      if ($("#hp-slider-butt").length) App.Plugins.PageScroller("#hp-slider-butt");
      App.Plugins.RegistrationHotTip();
      App.Plugins.MenuSwitch();
      App.Plugins.UserMenuSwitch();
      App.Plugins.ToggleBtn();
      App.Plugins.HelpBubble();
      App.Plugins.CustomSelect();
      App.Plugins.UserProfileScroll();
      App.Plugins.BindTextarea();
      App.Plugins.PositionModalWindowOnMobile();

      $.CustomFormElements.init()

      $(document).foundation()

      window.caregivers()
      window.offers()

      $('[disabled=disabled]').on('click', function(evt) {
        evt.preventDefault()
      });
   };

   var onLoad = function() {
      App.Plugins.MenuAddons();
      if ($(".app-custom-scroll").length) App.Plugins.CustomScrollBar(".app-custom-scroll");
      if($(window).width() > 760) {
         $('head').append('<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">');
      }
   };

   App.Plugins = {

      CustomScrollBar: function(container) {
         $(container).mCustomScrollbar({
            mouseWheel:false,
            theme: 'dark-thick',
            scrollInertia: 0,
            scrollButtons: {
               enable:true
            }
         });
      },

      HelpBubble: function() {
         $('.help-bubble').hover(function(){
            $(this).toggleClass('active');
         });
      },

      RegisterSlider: function() {
         $('.reg-slider').flexslider({
            controlNav: false,
            animation: 'slide',
            slideshow: false,
            animationLoop: false,
            prevText: 'Go back',
            nextText: 'Save and Continue'
         });
      },

      MenuSwitch: function() {
         $('.menu-switch').on('click', function() {
            $(this).toggleClass('active');
            $(this).parent().children('nav').toggleClass('open');
            return false;
         });
      },

      UserMenuSwitch: function() {
         $('#user-menu > a').on('click', function() {
            $(this).toggleClass('active');
            $(this).parent().toggleClass('open');
            return false;
         });
      },

      CustomSelect: function() {
         $('.custom-select > a').on('click', function() {
            $(this).parent().addClass('active');
            return false;
         });
         $('.custom-select .select > a').on('click', function() {
            $(this).closest('.custom-select').removeClass('active');
            return false;
         });
         $('.custom-select .select li a').on('click', function() {
            $(this).closest('.custom-select').removeClass('active')
                  .children('a').text($(this).text());
         });
      },

      FormsAddons: function() {
         $("#datepicker").datepicker();
         $('body').on('change', '.select-box select', function() {
            var value = $(this).find("option[value='"+ $(this).val() +"']").text();
            $(this).prev('a').text(value);
            $(this).parent().removeClass('error').addClass('active');
         });
      },

      ForgotPasswordButton: function() {
        $(document).on('click', '#forgot-password-button', function() {
            $('#forgot-password-button').prop('disabled', true);
            $('#login').submit();
        });
      },

      PageScroller: function(links) {
         $(links).click(function() {
            var where = $(this).attr("href");
            if (where.indexOf('#') >= 0) {
               var tab = where.split("#");
               where = "#" + tab.pop();
               if ($(where).length) {
                  $("html, body").animate({scrollTop: $(where).offset().top-10}, 1000);
                  return false;
               }
            }
            return true;
         });
      },

      MenuAddons: function() {
         $("div#user-small-menu").click(function(){
            $(this).find("nav").slideToggle();
         });

         $("nav .caregivers-changer a").click(function() {
            $(this).parent().find("div.changer-list").slideToggle();
            return false;
         });

         $("nav.dashboard-navigator").css("height",$("div.dashboard-page div.content.main-cnt").height());
      },

      FamilyApplicationViewSwitcher: function() {
         $(".family-applications a.extended-view").click(function(){
            parent = $(this).parent(".desc");
            container = $(parent).parent('.headline');
            if ($(parent).hasClass("simple")) {
               $(container).find(".desc.simple").hide();
               $(container).find(".desc.extended").show();
            }
            else {
               $(container).find(".desc.simple").show();
               $(container).find(".desc.extended").hide();
            }
            return false;
         });
      },

      UserProfileScroll: function() {
         $(document).scroll(function() {
            if ($(document).scrollTop() >= 500) {
               $('.user-page').addClass('hide-topbar');
            } else {
               $('.user-page').removeClass('hide-topbar');
            }
            if ($(document).scrollTop() >= 600) {
               $('.user-page').addClass('scrolled');
               $('.user-page').removeClass('hide-topbar');
            } else {
               $('.user-page').removeClass('scrolled');
            }
         });

         $('.caregiver-tab-bar a').click(function() {

            var target = $(this).attr('href');

            if($(window).width() > 940) {
               if(!$('.user-page').hasClass('scrolled')) {
                  var targetOffset = $(target).offset().top - 550;
               } else {
                  var targetOffset = $(target).offset().top - 120;
               }
            } else {
                if(!$('.user-page').hasClass('scrolled')) {
                  var targetOffset = $(target).offset().top - 800;
               } else {
                  var targetOffset = $(target).offset().top - 200;
               }
            }

            $('html, body').animate({
               scrollTop: targetOffset
            }, 1000);

            $('.caregiver-tab-bar .active').removeClass('active');
            $(this).parent().addClass('active');

            return false;
         });
      },

      /** experimental dynamic tip **/
      RegistrationHotTip : function() {
         $("div.form-item input, div.form-item select, div.form-item textarea").focus(function() {
            $(this).parents("div.form-item").find(".hot-tip").fadeIn();
         }).focusout(function() {
            $(this).parents("div.form-item").find(".hot-tip").fadeOut();
         });
      },

      ToggleBtn: function() {
         $('.toggle-btn').click(function(){

            var target = $(this).attr('data-target');
            $('#' + target).slideToggle();

            return false;
         });
      },

      BindTextarea: function() {
         $('body').on('input propertychange', '.min-max-characters textarea, .min-max-characters input[type=text]', function(){
            App.Plugins.CheckMsgLength($(this));
         });
      },

      CheckMsgLength: function($obj) {
         var min = $obj.parent().attr('data-min');
         var charLength = $obj.val().length;

         $obj.parent().find('.length span').text(charLength);
         $obj.parent().find('.num').text(charLength);

         if(charLength > min) {
            $obj.parent().children('.length').addClass('ok');
            $obj.parent().children('.char-number').addClass('correct');
            $('.buttons .btn-save').addClass('green');
         } else {
            $obj.parent().children('.length').removeClass('ok');
            $obj.parent().children('.char-number').removeClass('correct');
            $('.buttons .btn-save').removeClass('green');
         }
      },

      PositionModalWindowOnMobile: function() {
         $('html').on($.modal.OPEN, function(event, modal) {
            if($(window).width() < 960) {
               var offsetTop = $('html').scrollTop() + 30;
               $('.modal.current').offset({ top: offsetTop });
            }
         });
      }
   }


}(window.App = window.App || {}, jQuery));

App.Init();
