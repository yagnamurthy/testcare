$(window).load(function() {
   setTimeout($('.section-banner').addClass('show-bg'), 1000);
   if($('.gender input[type=radio]').is(':checked')) {
      $('input[type=submit]').addClass('green');
   };
});

var dataTab = 'basic';

$(document).ready(function(){
    var formatPhone = true;

    $('#new_user input').focus(function() {
      $(this).next("span").css("display","inline").fadeOut(1000);
    });

    $('body.registration header.main h1 a').click(function(){ return false; });

    if($('.form-item.current').hasClass('gender')) { $('.buttons .back').hide(); }

    $('body').on('click', '.gender input[type=radio]', function() {
        var checked = $('.reg-slider').find('[name="caregiver[gender]"]').is(':checked') ? 1 : 0;
        isRequired(checked);
    });

    $('body').on('change', '.birthdate select', function() {
        isDate($('.reg-slider').find('.birthdate select'),false);
    });

    $('body').on('keyup', '.zipcode input[type=text]', function() {
        $('.error-msg').css("display","none");
        validateText($(this),false);
    });

    $('body').on('keyup', '.phone input[type=tel]', function() {
        $('.error-msg').css("display","none");
        validateText($(this),false);
    });

    $('body').on('change', '.language input[type=checkbox]', function() {
        var checked=$('.reg-slider').find('input[name="caregiver[language_ids][]"]:checked');
        isOptional(checked.length);
    });

    $('body').on('change', '.smoke input[type=radio]', function() {
        var checked=$('.reg-slider').find('input[name="caregiver[smokes]"]:checked') ? 1 : 0;
        isRequired(checked);
    });

    $('body').on('change', '.allergies input[type=checkbox]', function() {
        var checked=$('.reg-slider').find('input[name="caregiver[allergy_ids][]"]:checked');
        isOptional(checked.length);
    });

    $('body').on('change', '.pets input[type=radio]', function() {
        var checked=$('.reg-slider').find('input[name="caregiver[pets]"]:checked') ? 1 : 0;
        isRequired(checked);
    });

    $('body').on('keyup', '.work-experience input[type=number]', function() {
        validateText($(this),false);
    });

    $('body').on('change', '.skills input[type=checkbox]', function() {
      var checked=$('form').find('input[name="caregiver[health_service_ids][]"]:checked');
      isRequired(checked.length);
    });

    $('body').on('change', '.services input[type=checkbox]', function() {
      var checked=$('form').find('input[name="caregiver[general_service_ids][]"]:checked');
      isRequired(checked.length);
    });

    $('body').on('keyup', '.hourly-rate input[type=number]', function() {
        validateText($(this),false);
    });

    $('body').on('change', '.live_in input[type=radio]', function(){
        validateLiveIn($(this));
    });

    $('body').on('keyup', '.live_in input[type=number]', function() {
        $('.reg-slider').find('.live_in .rate').removeClass('redBorder');
        $('.reg-slider').find('#yes-live_in').prop('checked',true);
        validateText($(this),false);
    });

    $('body').on('change', '.schedule input[type=checkbox]', function() {
        isScheduled($('.reg-slider').find('.schedule input[type=checkbox]'),true);
    });

    $('body').on('change', '.credentials input[type=checkbox]', function() {
        var checked=$('.reg-slider').find('.credentials input[type=checkbox]').is(':checked') ? 1 : 0;
        isRequired(checked);
    });

    $('body').on('keyup', '.hometown input[type=text]', function() {
        $('.error-msg').css("display","none");
        validateText($(this),false);
    });

    $('body').on('change', '.about-skills input[type=checkbox]', function() {
        validateSkills($('.reg-slider').find('.about-skills input[type=checkbox]'));
    });

    $('body').on('keyup', '.your-title input[type=text]', function() {
        $('.error-msg').css("display","none");
        validateText($(this),false);
    });

    $('body').on('keyup', '.great-caregiver textarea', function() {
        $('.error-msg').css("display","none");
        validateText($(this),false);
    });

    $('body').on('change', '.background input[type=radio]', function() {
        var checked=$('.reg-slider').find('input[name="caregiver[background]"]:checked') ? 1 : 0;
        isRequired(checked);
    });

    $('.user-register-page input[type=submit]').attr('disabled', false);

    $('.user-register-page input[type=submit]').click(function(){
        if(validateFields()) {

            if(!$('.current').attr('data-last')) {

                var $submitBtn = $(this);
                console.log($('form').serialize());
                $.ajax({
                    type: "POST",
                    data: $('form').serialize(),
                    url: $('form').attr('action'),
                    success: function(data) {
                        var $formItem = $(data).find('.form-item').addClass('next');
                        $regSlider = $('.reg-slider');

                        //show banner if it's another section
                        if($formItem.attr('data-tab') != dataTab) {
                            dataTab = $formItem.attr('data-tab');

                            if($formItem.attr('data-tab') != 'photos') {
                                $('.section-banner').dequeue();
                                $('.section-banner').remove();

                                var $banner = $(data).find('.section-banner');
                                $('.user-register-page').addClass('show-section-banner').prepend($banner);
                                if($formItem.hasClass('gender')){
                                    $('<img/>').attr('src', '/assets/v2/register/hands.jpg').load(function() {
                                        $(this).remove(); // prevent memory leaks as @benweet suggested
                                        $('.section-banner').addClass('show-bg');
                                    });
                                } else {
                                    $('.section-banner').delay(500).queue(function(){
                                        $(this).addClass('show-bg');
                                    });
                                }
                            };

                            $('.tabs li.active').removeClass('active');
                            $('.tabs li.' + dataTab + '').addClass('active');
                        }

                        //switch items
                        $regSlider.find('.form-items').append($formItem);

                        if($('#fileupload').length > 0) {
                          $('input[type=file]').unsigned_cloudinary_upload('ckpdccvn', {
                            cloud_name: 'carespotter'
                          }, {
                            multiple: true
                          }).bind('fileuploadstart', function() {
                            $('.photo .ajax-indicator').show();
                          })
                          .bind('cloudinarydone', function(response, data) {
                            $.ajax({
                              dataType: 'json',
                              method: 'POST',
                              url: '/photo/upload',
                              data: {
                                file: data.result
                              }
                            }).done(function(response){
                                $('.thumbnail').html('<img src="' + response.url + '">');
                                $('.photo .ajax-indicator').hide();
                                $submitBtn.addClass('green').val('Save and continue');
                            });
                          });
                        }

                        if($formItem.outerHeight() > 400) {
                            $regSlider.find('.form-items').height($formItem.outerHeight());
                        } else {
                            $regSlider.find('.form-items').removeAttr('style');
                        }
                        $regSlider.find('.current').addClass('prev').removeClass('current').find('.error-msg').hide();

                        setTimeout(function() {
                            $regSlider.find('.next').addClass('current').removeClass('next');
                        }, 100);

                        //Load the next screen
                        $submitBtn.removeClass('green').val('Save and continue');

                        if($formItem.hasClass('birthdate')) {
                            var birthMonth = $('form').find('#caregiver_date_of_birth_month option:selected').text();
                            var birthDay = $('form').find('#caregiver_date_of_birth_day option:selected').text();
                            var birthYear = $('form').find('#caregiver_date_of_birth_year option:selected').text();

                            if (birthMonth.length > 0 && birthDay.length > 0 && birthYear.length >0 ){
                              $('.reg-slider').find('#month').text(birthMonth);
                              $('.reg-slider').find('#day').text(birthDay);
                              $('.reg-slider').find('#year').text(birthYear);
                              $('.reg-slider').find('.select-box').addClass('active');
                              $('.reg-slider').find('.select-box .day').addClass('active');
                              $('.reg-slider').find('.select-box .year').addClass('active');
                              isDate($('.reg-slider').find('.birthdate select'),false);
                            }
                        }

                        if($formItem.hasClass('zipcode')) {
                           if ($('form').find('#caregiver_zipcode').val().length > 0){
                             $submitBtn.addClass('green').val('Save and continue');
                           }
                        }

                        if($formItem.hasClass('phone')){
                            if ($('form').find('#caregiver_phone').val().length > 0){
                              $submitBtn.addClass('green').val('Save and continue');
                            }
                        }

                        if($formItem.hasClass('phone') && formatPhone == true) {
                            $('#caregiver_phone').mask('999-999-9999');
                            formatPhone = false;
                        }

                        if($formItem.hasClass('language')){
                            var checked=$('form').find('input[name="caregiver[language_ids][]"]:checked');
                            if (checked.length > 0){
                                $submitBtn.addClass('green').val('Save and continue');
                            } else {
                                $submitBtn.addClass('green').val("No, let's continue");
                            }
                        }

                        if($formItem.hasClass('smoke')){
                            if ($('form').find('[name="caregiver[smokes]"]').is(':checked')){
                                $submitBtn.addClass('green').val('Save and continue');
                            }
                        }

                        if($formItem.hasClass('allergies')){
                            var checked=$('form').find('input[name="caregiver[allergy_ids][]"]:checked');
                            if (checked.length > 0){
                                $submitBtn.addClass('green').val('Save and continue');
                            } else {
                                $submitBtn.addClass('green').val("No, let's continue");
                            }
                        }

                        if($formItem.hasClass('pets')){
                            var checked=$('form').find('input[name="caregiver[pets]"]:checked');
                            if (checked.length > 0){
                                $submitBtn.addClass('green').val('Save and continue');
                            }
                        }

                        if($formItem.hasClass('work-experience')){
                            if ($('form').find('#caregiver_work_experience').val().length > 0){
                                $submitBtn.addClass('green').val('Save and continue');
                            }
                        }

                        if($formItem.hasClass('skills')){
                            var checked=$('form').find('input[name="caregiver[health_service_ids][]"]:checked');
                            if (checked.length > 0){
                                $submitBtn.addClass('green').val('Save and continue');
                            }
                        }

                        if($formItem.hasClass('services')){
                            var checked=$('form').find('input[name="caregiver[general_service_ids][]"]:checked');
                            if (checked.length > 0){
                                $submitBtn.addClass('green').val('Save and continue');
                            }
                        }

                        if($formItem.hasClass('skills') || $formItem.hasClass('services') || $formItem.hasClass('about-skills')) {
                            $formItem.find('.custom-checkbox label').each(function() {
                                if($(this).outerHeight() > 30) {
                                    $(this).parent().addClass('two-lined');
                                }
                            });
                        }

                        if($formItem.hasClass('hourly-rate')) {
                            if ($('form').find('#caregiver_hourly_rate').val().length > 0){
                              $submitBtn.addClass('green').val('Save and continue');
                            }
                        }

                        if($formItem.hasClass('live_in')){
                            if ($('#no-live_in').is(':checked')) {
                                $submitBtn.addClass('green').val('Save and continue');
                            }
                            if ($('form').find('#caregiver_live_in_rate').val().length > 0){
                              $('#yes-live_in').prop('checked', true);
                              $submitBtn.addClass('green').val('Save and continue');
                            }
                        }

                        if($formItem.hasClass('schedule')){
                            if(isScheduled($('form').find('.schedule input[type=checkbox]'),false)){
                                $submitBtn.addClass('green').val('Save and continue');
                            }
                        }

                        if($formItem.hasClass('credentials')){
                            var checked=$('form').find('.credentials input[type=checkbox]').is(':checked');
                            if (checked){
                                $submitBtn.addClass('green').val('Save and continue');
                            }
                        }

                        if($formItem.hasClass('hometown')) {
                          new google.maps.places.Autocomplete((document.getElementById('autocomplete')),
                              {
                                types: ['(cities)']
                                //,componentRestrictions: {country: "us"}
                              });
                          if ($('form').find('#caregiver_hometown').val().length > 0){
                              $submitBtn.addClass('green').val('Save and continue');
                          }
                        }

                        if($formItem.hasClass('about-skills')){
                            var checked=$('form').find('input[name="caregiver[skill_service_ids][]"]:checked');
                            if (checked.length > 0){
                               $submitBtn.addClass('green').val('Save and continue');
                            }
                        }

                        if($formItem.hasClass('your-title')) {
                            var titleLen = $('form').find('#caregiver_headline').val().length;

                            if (titleLen >= 20){
                                $submitBtn.addClass('green').val('Save and continue');
                                $('form').find('#titleCount').text(titleLen);
                                $('form').find('#titleLength').addClass('ok');
                            }
                        }

                        if($formItem.hasClass('great-caregiver')) {
                          var greatLen = $('form').find('#caregiver_question_1').val().length;

                          if (greatLen >= 150){
                              $submitBtn.addClass('green').val('Save and continue');
                              $('form').find('#greatCount').text(greatLen);
                              $('form').find('#greatLength').addClass('ok');
                          }
                        }

                        if($formItem.hasClass('background')){
                            var checked=$('form').find('input[name="caregiver[background]"]:checked');
                            if (checked.length > 0){
                                $submitBtn.addClass('green').val('Save and continue');
                            }
                        }

                        $('.buttons .back').show();
                        $submitBtn.attr('disabled', false);
                    },
                    error: function(data) {
                        $('.form-item.current .error-msg').show()
                        $submitBtn.attr('disabled', false);
                    }
                });
                return false;
            }
        } else {
            return false;
        }
    });

    //back button
    $('.buttons .back').click(function(){

        formatPhone = true;
        var prevItem = $('.form-items .prev').last();
        var previousTab = $('.form-items .current').attr('data-tab');

        $('.form-items .current').addClass('next').removeClass('current');
        prevItem.removeClass('prev').addClass('current');

        var currentTab = $('.form-items .current').attr('data-tab');

        if(currentTab != previousTab){
            $('.tabs li.active').removeClass('active');
            $('.tabs li.' + currentTab + '').addClass('active');
        }

        dataTab = currentTab;

        $('input[type=submit]').addClass('green').val('Save and continue');
        $('.error-msg').css("display","none");

        if($('.form-item.current').hasClass('gender')) {
            $('.buttons .back').hide();
        }

        if($('.form-item.current').hasClass('birthdate')) {
            isDate($('.reg-slider').find('.birthdate select'),false);
        }

        if($('.form-item.current').hasClass('language')){
            var formHeight = $('.form-item.current').outerHeight();
            $('.reg-slider').find('.form-items').height(formHeight);

            var checked=$('form').find('input[name="caregiver[language_ids][]"]:checked');
            if (checked.length == 0){
                $('input[type=submit]').addClass('green').val("No, let's continue");
            }
        }

        if($('.form-item.current').hasClass('allergies')){
            var checked=$('form').find('input[name="caregiver[allergy_ids][]"]:checked');
            if (checked.length == 0){
                $('input[type=submit]').addClass('green').val("No, let's continue");
            }
        }

        if($('.form-item.current').hasClass('hometown') || $('.form-item.current').hasClass('your-title') || $('.form-item.current').hasClass('great-caregiver')){
            var formHeight = $('.form-item.current').outerHeight();
            $('.reg-slider').find('.form-items').height(formHeight);
        }

        if($('.form-item.current').hasClass('skills') || $('.form-item.current').hasClass('services') || $('.form-item.current').hasClass('about-skills') || $('.form-item.current').hasClass('schedule')) {
            var formHeight = $('.form-item.current').outerHeight();
            $('.reg-slider').find('.form-items').height(formHeight);
        }

        setTimeout($('.form-items .next').remove(), 1000);

    });

    //section  banner continue btn
    $('body').on('click', '.section-banner .btn-save', function() {
        $(this).closest('.show-bg').removeClass('show-bg').addClass('out-bg');
        setTimeout(function() {
            $('.user-register-page').removeClass('show-section-banner');
            $('.section-banner').removeClass('out-bg');
        }, 600);
        return false;
    });
});

var validateFields = function() {

    var thisScreen = $('.reg-slider').find('.current').attr('class').split(' ')[1];

    switch(thisScreen) {
      case 'gender':
          var checked = $('.reg-slider').find('[name="caregiver[gender]"]').is(':checked') ? 1 : 0;
          return isRequired(checked) ? true : false;
          break;
      case 'birthdate':
          return isDate($('.reg-slider').find('.birthdate select'),true) ? true : false;
          break;
      case 'zipcode':
          return validateText($('.reg-slider').find('.zipcode input[type=text]'),true) ? true : false;
          break;
      case 'phone':
          return validateText($('.reg-slider').find('.phone input[type=tel]'),true) ? true : false;
          break;
      case 'language':
          isOptional($('.reg-slider').find('input[name="caregiver[language_ids][]"]:checked').length);
          return true;
          break;
      case 'smoke':
          var checked=$('.reg-slider').find('[name="caregiver[smokes]"]').is(':checked') ? 1 : 0;
          return isRequired(checked) ? true : false;
          break;
      case 'allergies':
          isOptional($('.reg-slider').find('input[name="caregiver[allergy_ids][]"]:checked').length);
          return true;
          break;
      case 'pets':
          var checked=$('.reg-slider').find('[name="caregiver[pets]"]').is(':checked') ? 1 : 0;
          return isRequired(checked) ? true : false;
          break;
      case 'work-experience':
          return validateText($('.reg-slider').find('.work-experience input[type=number]'),true) ? true : false;
          break;
      case 'skills':
          return isRequired($('.reg-slider').find('input[name="caregiver[health_service_ids][]"]:checked').length) ? true : false;
          break;
      case 'services':
          return isRequired($('.reg-slider').find('[name="caregiver[general_service_ids][]"]:checked').length) ? true : false;
          break;
      case 'hourly-rate':
          return validateText($('.reg-slider').find('.hourly-rate input[type=number]'),true) ? true : false;
          break;
      case 'live_in':
          console.log(validateLiveIn($('.reg-slider').find('.live_in input[type=radio]')));
          return validateLiveIn($('.reg-slider').find('.live_in input[type=radio]')) ? true : false;
          break;
      case 'schedule':
          return isScheduled($('.reg-slider').find('.schedule input[type=checkbox]'),true) ? true : false;
          break;
      case 'credentials':
          return isRequired($('.reg-slider').find('.credentials input[type=checkbox]').is(':checked') ? 1 : 0) ? true : false;
          break;
      case 'hometown':
          return validateText($('.reg-slider').find('.hometown input[type=text]'),true) ? true : false;
          break;
      case 'about-skills':
          return validateSkills($('.reg-slider').find('.about-skills input[type=checkbox]'),true) ? true : false;
          break;
      case 'your-title':
          return validateText($('.reg-slider').find('.your-title input[type=text]'),true) ? true : false;
          break;
      case 'great-caregiver':
          return validateText($('.reg-slider').find('.great-caregiver textarea'),true) ? true : false;
          break;
      case 'photo':
          if ($(".thumbnail img[alt='Default avatar']").length > 0) {
            return false;
          } else {
            return true;
          }
          break;
      case 'background':
          var checked=$('.reg-slider').find('[name="caregiver[background]"]').is(':checked') ? 1 : 0;
          return isRequired(checked) ? true : false;
          break;
      default:
          return false;
    }
}

var isRequired = function(num){
  if (num > 0){
      showValid();
      return true;
  } else {
      showInvalid();
      return false;
  }
}

var isOptional = function(num){
  if (num > 0){
      $('input[type=submit]').addClass('green').val('Save and continue');
  } else {
      $('input[type=submit]').val("No, let's continue");
  }
}

var isPhone = function(phone) {
    var regex = /^[0-9]{3}[-]{0,1}[0-9]{3}[-]{0,1}[0-9]{4}$/;
    return regex.test(phone);
}

var isDate = function(elem,showMsg) {
    if (typeof elem !== 'undefined') {
      var arrDOB = [];
      elem.each(function(){
        if($(this).val()!=="") { arrDOB.push($(this).val()); }
      });
      if (arrDOB.length===3){
          var dob = new Date(arrDOB[2],arrDOB[0],arrDOB[1]);
          var today = new Date();
          var age = Math.floor((today-dob) / (365.25 * 24 * 60 * 60 * 1000));
          $('.form-item.current .error-msg').show().text('');
          $('input[type=submit]').addClass('green').val("Yes, I'm " + age);
          return true;
      } else {
          if (showMsg==true){
            $('.form-item.current .error-msg').show().text('A valid birthdate is required');
          } else {
            $('.form-item.current .error-msg').show().text('');
          }
          $('input[type=submit]').removeClass('green');
          return false;
      }
    }
}

var validateText = function(elem,showMsg){
  var isValid = false;
  var textVal = elem.val();

  switch(elem.attr('id')) {
    case 'caregiver_zipcode':
        if(textVal.length == 5){ isValid = true; }
        break;
    case 'caregiver_phone':
        if(textVal.length == 12 && isPhone(textVal)) { isValid = true; }
        break;
    case 'caregiver_hourly_rate':
    case 'caregiver_live_in_rate':
        if(textVal.length > 0 && textVal.length < 4) { isValid = true; }
        break;
    case 'caregiver_headline':
        if(textVal.length >= 20 && textVal.length <= 60) { isValid = true; }
        break;
    case 'caregiver_question_1':
        if(textVal.length >= 150) { isValid = true; }
        break;
    default:
        if(textVal.length > 0){ isValid = true; }
  }
  if(isValid){
    $('.error-msg').css("display","none");
    $('input[type=submit]').addClass('green');
    return true;
  } else {
    if (showMsg){ $('.error-msg').css("display","block"); }
    $('input[type=submit]').removeClass('green');
    return false;
  }
}

var validateLiveIn = function(elem){
  if (typeof elem !== 'undefined'){
    var checked = false;
    var checkedVal = 0;
    var isValid = false;
    elem.each(function(){
        if(elem.is(":checked")){
          checked = true;
          checkedVal = $(this).val();
          return false;
        }
    });
    if (checked){
      if (checkedVal == 1){
        if (validateText($('.reg-slider').find('#caregiver_live_in_rate'))){
           $('.reg-slider').find('.live_in .rate').removeClass('redBorder');
           isValid = true;
           showValid();
        } else {
           $('.reg-slider').find('.live_in .rate').addClass('redBorder');
           isValid = false;
           showInvalid();
        }
      } else {
        $('.reg-slider').find('.live_in .rate').removeClass('redBorder');
        showValid();
        isValid = true;
      }
    } else {
        $('.reg-slider').find('.live_in .rate').removeClass('redBorder');
        $('.reg-slider').find('.live_in input[type=number]').val('');
        showInvalid();
    }
    return isValid;
  }
}

var validateSkills = function(elem){
  if (typeof elem !== 'undefined'){
    var checked = 0;
    elem.closest('.about-skills').find('input[type=checkbox]').each(function() {
        if($(this).is(":checked")){
          checked++;
        }
    });
    if(checked == 3){
        $('input[type=submit]').addClass('green');
        return true;
    } else {
        $('input[type=submit]').removeClass('green');
        return false;
    }
  }
}

var showInvalid = function(){
  $('.error-msg').css("display","block");
  $('input[type=submit]').removeClass('green');
}

var showValid = function(){
  $('.error-msg').css("display","none");
  $('input[type=submit]').addClass('green');
}


var isScheduled = function(elem,showMsg){
  if (typeof elem !== 'undefined'){
    var isValid = false;
    elem.each(function(){
        if(elem.is(":checked")){
            isValid = true;
            return false;
        }
    });
    if (isValid){
        showValid();
    } else {
        if (showMsg) showInvalid();
    }
    return isValid;
  }
}
