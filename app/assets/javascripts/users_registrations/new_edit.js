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
      console.log(data);
      var availability = data.available ? '<b class="iblue">est disponible.</b>' : '<b class="red">n\'est pas disponible.</b>'
      $('.user_nickname small.text-muted').html('Sera l\'url du profil : evolucoach.com/' + slug + ' ' + availability);
    });


  }
}
