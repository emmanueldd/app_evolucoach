// TODO : TESTER le cas de l'update
App.dashboard_home = App.dashboard_home || {};
App.dashboard_home.index = {
  init: function() {
    var self = this;
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
      $('body').append('<div class="aboslute-text blue-bg" id="flash-message"><i class="fa fa-check white"></i  > &nbsp;<p>Copié</p></div>');
      setTimeout(function() {
        $('#flash-message').hide('slow')
      }, 5000);
    })
  }
}
