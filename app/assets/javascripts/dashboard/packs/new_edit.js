'use strict';

App.dashboard_packs = App.dashboard_packs || {};
App.dashboard_packs.new_edit = {
	init: function init() {
		var self = this;
		if ($('#pack_show_calendly_before_payment').length > 0) {
			var toggleRequired = false;
			$('#pack_show_calendly_before_payment, #pack_show_calendly_after_payment').change(function() {
				toggleRequired = !toggleRequired;
				$('#pack_user_calendly_url').attr('required', toggleRequired);
				$('#calendly_url_section').toggle();
				$('#hide_payment_page_section').toggle();
			});
		}
	}
}
