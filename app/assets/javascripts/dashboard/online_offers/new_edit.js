'use strict';

App.dashboard_online_offers = App.dashboard_online_offers || {};
App.dashboard_online_offers.new_edit = {
	init: function init() {
		var self = this;
		if ($('#online_offer_show_calendly_before_payment, #online_offer_show_calendly_after_payment').length > 0) {
			$('#online_offer_show_calendly_before_payment, #online_offer_show_calendly_after_payment').change(function() {

				if ($('#online_offer_show_calendly_before_payment:checked, #online_offer_show_calendly_after_payment:checked').length > 0) {
					$('#hide_payment_page_section, #calendly_url_section').show();
					$('#online_offer_user_calendly_url').attr('required', 'true');
				} else {
					$('#hide_payment_page_section, #calendly_url_section').hide();
					$('#online_offer_user_calendly_url').attr('required', 'false');
				}
			});
		}
	}
}
