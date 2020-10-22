'use strict';

App.dashboard_packs = App.dashboard_packs || {};
App.dashboard_packs.new_edit = {
	init: function init() {
		var self = this;
		if ($('#pack_show_calendly_before_payment, #pack_show_calendly_after_payment').length > 0) {
			$('#pack_show_calendly_before_payment, #pack_show_calendly_after_payment').change(function() {

				if ($('#pack_show_calendly_before_payment:checked, #pack_show_calendly_after_payment:checked').length > 0) {
					$('#hide_payment_page_section, #calendly_url_section').show();
					$('#pack_user_calendly_url').attr('required', 'true');
				} else {
					$('#hide_payment_page_section, #calendly_url_section').hide();
					$('#pack_user_calendly_url').attr('required', 'false');
				}
			});
		}
	}
}
