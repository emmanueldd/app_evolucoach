'use strict';

App.dashboard_online_offers = App.dashboard_online_offers || {};
App.dashboard_online_offers.new_edit = {
	init: function init() {
		var self = this;
		if ($('#online_offer_show_calendly_before_payment').length > 0) {
			var toggleRequired = false;
			$('#online_offer_show_calendly_before_payment, #online_offer_show_calendly_after_payment').change(function() {
				toggleRequired = !toggleRequired;
				$('#hide_payment_page_section').toggle();
				$('#calendly_url_section').toggle();
				$('#online_offer_user_calendly_url').attr('required', toggleRequired);
			});
		}
	}
}
