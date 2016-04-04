var FindCaretakerStep;

FindCaretakerStep = (function() {
  function FindCaretakerStep() {
    this.bindAll();
  }

  FindCaretakerStep.prototype.bindAll = function() {
    return $('#example-1').selectivity({
      allowClear: true,
      items: ['Amsterdam', 'Antwerp'],
      placeholder: 'No city selected'
    });
  };

  return FindCaretakerStep;

})();

$(function() {
  $( "#datepicker" ).datepicker();

  $('#schedule_type_0').on('click', function() {
    $('#flexible').show();
    $('#weekly').hide();
    $("#hours_needed").val('');
  });

  $('#schedule_type_1').on('click', function() {
    $('#flexible').hide();
    $('#weekly').show();
    $("#hours_needed").val('');
  });

  $('#gender_1').on('click', function() {
    $('.would-live').html('he would be living…');
    $('.live-out').html('In his own home (Live-out)');
  });

  $('#gender_2').on('click', function() {
    $('.would-live').html('she would be living…');
    $('.live-out').html('In her own home (Live-out)');
  });

  $('.care_type').on('click', function() {
    var userCaretype = $('#care_type:checked').map(function(){
      return $(this).val();
    }).get().join();

    $('#care_types').val(userCaretype);
  });

  $('.schedule_step').on('click', function() {
    var timeOfday = $('#time_of_day:checked').map(function(){
      return $(this).val();
    }).get().join();

    $('#schedule_time').val(timeOfday);
  });

  $('#weekly input').on('click', function() {
    var day;
    var days;

    day = $(this).val();
    $('#week_timing').append("<div class='field full-width'> " + day + " <label for='Morning' class='week-label'>Morning</label> <input type='checkbox' name='time_of_day' id='time_of_day' value='"  + day +  "Morning'> <label for='Afternoon' class='week-label'>Afternoon</label> <input type='checkbox' name='time_of_day' id='time_of_day' value='" + day + "Afternoon'> <label for='Evening' class='week-label'>Evening</label> <input type='checkbox' name='time_of_day' id='time_of_day' value='" + day + "Evening'> <label for='Overnight' class='week-label'>Overnight</label> <input type='checkbox' name='time_of_day' id='time_of_day' value='" + day + "Overnight'}> </div>");

    if($("#hours_needed").val() == 0){
      days = $("#hours_needed").val() + 5;
      $("#hours_needed").val(days);
    }

    else{
      days = parseInt($("#hours_needed").val()) + 5;
      $("#hours_needed").val(days);
    }

  });

  $("#select_val").on('change', function() {
    var select;
    select = $(this).val();

    if(select.indexOf('mother') > -1 || select == 'wife' || select.indexOf('female') > -1 || select == 'sister'){
      $('#select_label').html('Where does she need care?')
    }
    else{
      $('#select_label').html('Where does he need care?')
    }
  });

  $("#days_of_care").on('input', function() {
    var day;
    var days;

    day = $(this).val();

    if(day % 1 === 0){
      days = day * 5;
      $("#hours_needed").val(days)
    }
    else{
      $("#hours_needed").val('NaN')
    }
  });

  $('#select-lng').selectize({
    persist: false,
    maxItems: null,
    valueField: 'code',
    labelField: 'name',
    searchField: ['code', 'name'],
    options: window.languages,
    render: {
      item: function(item, escape) {
        return '<div>' +
            (item.name ? '<span class="name">' + escape(item.name) + '</span>' : '') +
            '</div>';
      },
      option: function(item, escape) {
        var caption = item.name ? item.name : null;
        return '<div>' +
            (caption ? '<span class="caption">' + escape(caption) + '</span>' : '') +
            '</div>';
      }
    }
  });

  $('#search-city').selectize({
    persist: false,
    maxItems: 1,
    sortField: 'text',
    valueField: 'long_name',
    labelField: 'long_name',
    searchField: ['long_name', 'short_name'],
    render: {
      item: function(item, escape) {
        return '<div>' +
            (item.long_name ? '<span class="name">' + escape(item.long_name) + ', ' + escape(item.short_name) + '</span>' : '') +
        '</div>';
      },
      option: function(item, escape) {
        var caption = item.short_name ? item.long_name : null;
        return '<div>' +
            (caption ? '<span class="caption">' + escape(caption) + ', ' + escape(item.short_name) + '</span>' : '') +
            '</div>';
      }
    },
    load: function(query, callback) {
      if (query.length >= 2) {
        return $.ajax({
          url: '/find_caretaker_step/search',
          type: 'GET',
          data: {
            query: query
          },
          error: function() {
            return callback();
          },
          success: function(data) {
            return callback(data.search);
          }
        });
      }
    }
  });

  $('#care-concerns').selectize({
    delimiter: ',',
    persist: false,
    create: function(input) {
      return {
        value: input,
        text: input
      }
    }
  });

  new FindCaretakerStep;
});
