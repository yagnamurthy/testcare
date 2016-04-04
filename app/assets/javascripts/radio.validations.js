$(document).ready(function() {
        // client_side_validations rails gem doesn't handle radio buttons, so manually process those with this code
        // this code assumes that your related radio buttons are wrapped in a div with class .radio
        function validate_radio(validations, $radio, form) {
            var input_wrap = window.ClientSideValidations.forms[form.id].input_tag.split('<span id="input_tag" />');
            var label_wrap = window.ClientSideValidations.forms[form.id].label_tag.split('<label id="label_tag" />');
            var $radio_container = $radio.closest('.custom-checkbox-container');

            if ($radio_container.find('input[type="radio"]:checked').length) {
                // buttons were checked, so if a previous error message was displayed then get rid of it.
                $radio_container.find('.field_with_errors > *').unwrap();
                $radio_container.find('.message').remove();
            } else {
                // no radio buttons in this group were checked so see if we have a presence validator
                var name = ($radio.find('input[type="radio"]').attr('name'));
                if (validations.validators[name] && validations.validators[name].presence && validations.validators[name].presence.length) {
                    var message = '<label class="message">' + validations.validators[name].presence[0].message + '</label>';

                    // if we don't already have an error message, then display it
                    if (!$radio_container.children('.field_with_errors').length) {
                        $('<div class="field_with_errors">' + message + '</div').appendTo($radio_container);
                        return false;
                    }
                }

                if (validations.validators[name] && validations.validators[name].inclusion && validations.validators[name].inclusion.length) {
                    var message = '<label class="message">' + validations.validators[name].inclusion[0].message + '</label>';


                    // if we don't already have an error message, then display it
                    if (!$radio_container.children('.field_with_errors').length) {
                        $('<div class="field_with_errors">' + message + '</div').appendTo($radio_container);
                        return false;
                    }
                }
            }
        }

        $('form').each(function() {
            var validations = window.ClientSideValidations.forms[$(this).attr('id')];
            var form = this;
            if (validations) {
                $(this).submit(function(evt) {
                  evt.preventDefault();

                    // check all radio buttons on submit
                    $(this).find('.custom-checkbox').each(function() {
                        var return_value = validate_radio(validations, $(this), form);

                        if(return_value == false) {
                          return false;
                        } else {
                          $(form).off('submit').submit();
                        }
                    });
                });
                $(this).find('.custom-checkbox input[type="radio"]').change(function() {
                  validate_radio(validations, $(this).parents('.custom-checkbox'), form);
                });
            }
        });
})
