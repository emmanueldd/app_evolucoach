function readURL(input) {
  if (input.files && input.files[0]) {
    var reader = new FileReader();
    reader.onload = function (e) {
      $('#preview').attr('src', e.target.result)
      $('#preview').attr('class', $('#preview').attr('data-class'));
    };
    reader.readAsDataURL(input.files[0]);
  }
}
$(document).ready(function () {
  if ($('#copy').length) {
    $('#copy').click(function() {
      /* Get the text field */
      const el = document.createElement('textarea');
      var str = document.getElementById("to_copy").value;
      el.value = str;
      document.body.appendChild(el);
      el.select();
      el.setSelectionRange(0, 99999);
      document.execCommand('copy');
      document.body.removeChild(el);
      $('body').append('<div class="flash-container blue-bg" id="flash-message"><i class="fa fa-check white"></i  > &nbsp;<p>Copié</p></div>');
      setTimeout(function() {
        $('#flash-message').hide('slow')
      }, 5000);
    })
  }

  if ($('#city').length) {
    var placesAutocomplete = places({
      container: document.getElementById('city'),
      apiKey: '4c070d235457f51f33aa50d9410ea37a',
      appId: 'pl09OMKOFZLK',
      language: 'fr', // Receives results in French
      countries: ['fr'], // Search in France
      type: 'city'
    });
  }

  App.form_autosave.init();
  controller = $("body").data("controller");
  if ($("body").data("namespace") !== undefined && $("body").data("namespace") != controller) {
    controller = $("body").data("namespace") + '_' + controller;
  }
  action = $("body").data("action")
  if (action == 'new' || action == 'edit')
  {
    action = 'new_edit';
  }
  if ((typeof(App[controller]) === 'object') && (typeof(App[controller][action]) === 'object')) {
    App[controller][action].init();
  }
  if ($('#flash-message').length > 0) {
    setTimeout(function() {
      $('#flash-message').hide('slow')
    }, 5000);
  }
  $('.nav-tabs > li > a').click(function (e) {
    var link = $(this);
    hash = link.attr("href");
    window.location = hash;
  });
  var url = document.location.toString();
  if (url.match('#')) {
    $('.nav-tabs a[href="#' + url.split('#')[1] + '"]').tab('show');
    $(window).scrollTop(0);
    // $('html, body').animate({scrollTop: ($(window).scrollTop() - 400) + 'px'}, 200);
  }

  if ($('span.left-angle').length > 0) {
    $('span.left-angle').click(function(){
      window.history.back();
    })
  }
  if ($('#submit-form').length > 0) {
    $('#submit-form').click(function(){
      $('form').submit();
    })
  }
  $('form').each(function() {
    $(this).validate();
  });
  //    Menu Toggle
  $("#menubar").on('click', function (e) {
    e.preventDefault();
    $(this).toggleClass("active");
    $(".menu-area").toggleClass("active");
  });


  if ($('#slider-range').length > 0) {
    $("#slider-range").slider({
      range: true,
      min: 0,
      max: 90,
      values: [0, 90],
      step: 1,
      slide: function (event, ui) {
        $("#min-price").html(ui.values[0]);
        suffix = " ans";
        if (ui.values[1] == $("#max-price").data("max")) {
          suffix = " ans";
        }
        $("#max-price").html(ui.values[1] + suffix);
      }
    });
  }

  $("#site-popup").on('click', function (e) {
    e.preventDefault();
    $(".popup-area").addClass("active");
  });
  $("a#close-popup ").on('click', function (e) {
    e.preventDefault();
    $(".popup-area").removeClass("active");
  });


});
