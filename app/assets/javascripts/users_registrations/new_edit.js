// TODO : TESTER le cas de l'update
App.users_registrations = App.users_registrations || {};
App.users_registrations.new_edit = {
  init: function() {
    var self = this;
    $('#user_nickname').keyup(function() {
      self.setPseudoUrl(this);
    })
    $('#user_nickname').change(function() {
      self.setPseudoUrl(this);
    })
  },
  setPseudoUrl: function(self) {
    var slug = $(self).val().toLowerCase()
    $.ajax({
			url: '/users/check_slug_availability/' + slug,
	    dataType: "json",
	    contentType: 'application/json',
	  }).done( function(data) {
      var availability = data.available ? '<b class="iblue">est disponible.</b>' : '<b class="red">n\'est pas disponible.</b>'
      if (data.available) {
        $('.user_nickname small.text-muted').html('Sera l\'url du profil : https://evolucoach.com/' + slug + ' ' + availability);
        $('#user_slug').val( $('#user_nickname').val() );
      } else {
        $('#user_slug').val('');
        $('.user_nickname small.text-muted').html('Sera l\'url du profil : https://evolucoach.com/' + slug + ' ' + availability);
      }
    });


  }
}
