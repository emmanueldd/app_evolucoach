'use strict';

App.dashboard_programs = App.dashboard_programs || {};
App.dashboard_programs.new_edit = {
	init: function init() {
		var self = this;
		if ($('#program_show_calendly_before_payment, #program_show_calendly_after_payment').length > 0) {
			$('#program_show_calendly_before_payment, #program_show_calendly_after_payment').change(function() {

				if ($('#program_show_calendly_before_payment:checked, #program_show_calendly_after_payment:checked').length > 0) {
					$('#hide_payment_page_section, #calendly_url_section').show();
					$('#program_user_calendly_url').attr('required', 'true');
				} else {
					$('#hide_payment_page_section, #calendly_url_section').hide();
					$('#program_user_calendly_url').attr('required', 'false');
				}
			});
		}
	}
}
