'use strict';

App.dashboard_programs = App.dashboard_programs || {};
App.dashboard_programs.show = {
	init: function init() {
		var self = this;
		$('#video-modal').on('show.bs.modal', function (event) {
		  var button = $(event.relatedTarget) // Button that triggered the modal
		  var video_id = button.data('video-id');
		  var video_title = button.data('video-title');
		  var modal = $(this);
			modal.find('.modal-body').html('<iframe style="width: 100%; min-height: 400px" src="https://www.youtube.com/embed/' + video_id + '" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>');
			modal.find('.modal-title').html(video_title);
		  // modal.find('.modal-title').text('New message to ' + recipient)
		  // modal.find('.modal-body input').val(recipient)
		})
		$('#video-modal').on('hide.bs.modal', function (e) {
		  var modal = $(this);
			modal.find('.modal-body').html('');
		})
	}
}
