'use strict';

App.dashboard_programs = App.dashboard_programs || {};
App.dashboard_programs.new_edit = {
	init: function init() {
		var self = this;
		if ($('#program_show_calendly_before_payment, #program_show_calendly_after_payment').length > 0) {
			var toggleRequired = false;
			$('#program_show_calendly_before_payment').change(function() {
				toggleRequired = !toggleRequired;
				$('#hide_payment_page_section').toggle();
				$('#calendly_url_section').toggle();
				$('#program_user_calendly_url').attr('required', toggleRequired);
			});
		}
	}
}
