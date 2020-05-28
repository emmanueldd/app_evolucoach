'use strict';

App.interface_orders = App.interface_orders || {};
App.interface_orders.new_edit = {
	init: function init() {
		var self = this;
		var style = {
			base: {
				color: '#303238',
				fontSize: '16px',
				color: "#32325d",
				fontSmoothing: 'antialiased',
				'::placeholder': {
					color: '#ccc',
				},
			},
			invalid: {
				color: '#e5424d',
				':focus': {
					color: '#303238',
				},
			},
		};
		var elements = stripe.elements();
		var card = elements.create('card', {style: style})

		// Add an instance of the card Element into the `card-element` <div>.
		card.mount('#card-element');
		// Handle real-time validation errors from the card Element.
		card.addEventListener('change', function(event) {
			var displayError = document.getElementById('card-errors');
			if (event.error) {
				displayError.textContent = event.error.message;
			} else {
				displayError.textContent = '';
			}
		});

		$("form").validate({
			submitHandler: function(form) {
				// do other things for a valid form
				stripe.handleCardPayment(
					$('#scs').val(),
					card
				).then(function(result) {
					if (result.error) {
						var errorElement = document.getElementById('card-errors');
						errorElement.textContent = result.error.message;
					} else {
						// console.log('result =>', result.paymentIntent);
						stripeTokenHandler(result.paymentIntent);
					}
				});
			}
		});

		// Submit the form with the token ID.
		function stripeTokenHandler(payment_intent) {
			// Insert the payment_intent ID into the form so it gets submitted to the server
			var form = document.getElementById('payment-form');
			var hiddenInput = document.createElement('input');
			hiddenInput.setAttribute('type', 'hidden');
			hiddenInput.setAttribute('name', 'order[stripe_payment_intent_id]');
			hiddenInput.setAttribute('value', payment_intent.id);
			var hiddenInput2 = document.createElement('input');
			hiddenInput2.setAttribute('type', 'hidden');
			hiddenInput2.setAttribute('name', 'order[stripe_payment_method_id]');
			hiddenInput2.setAttribute('value', payment_intent.payment_method);
			form.appendChild(hiddenInput);
			form.appendChild(hiddenInput2);

			// Submit the form
			form.submit();
		}
	},
	stripeResponseHandler: function (status, response) {
		var self = this;
		var $form, token;
		$form = $("#payment-form");
		if (response.error) {
			var errorMessages = {
				incorrect_number: "Votre numéro de carte est incorrect",
				invalid_request_error: "Votre numéro de carte est incorrect",
				invalid_number: "Ce numéro de carte est invalide",
				invalid_expiry_month: "Le mois d'expiration est invalide",
				invalid_expiry_year: "L'année d'expiration est invalide",
				invalid_cvc: "Le code de sécurité CVC est invalide",
				expired_card: "Cette carte a expiré",
				incorrect_cvc: "Le code de sécurité CVC est incorrect",
				incorrect_zip: "Le zip de la carte a échoué à la validation",
				card_declined: "Votre carte a été refusée",
				missing: "Veuillez associer une carte au paiement",
				processing_error: "Une erreur s'est produite durant le paiement",
				rate_limit:  "Une erreur est survenue suite à un trop grand nombre de connexion sur notre serveur. Si le probleme persiste, contactz-nous"
			};
			self.show_error(errorMessages[response.error.code]);
			$form.find("input[type=submit]").prop("disabled", false);
		} else {
			token = response.id;
			$form.append($("<input type=\"hidden\" name=\"order[card_token]\" />").val(token));
			$("[data-stripe=number]").remove();
			$("[data-stripe=cvc]").remove();
			$("[data-stripe=exp-year]").remove();
			$("[data-stripe=exp-month]").remove();
			$form.get(0).submit();
		}
		return false;
	},
	show_error: function (message) {
		var self = this;
		// console.log('error');
		$("#order-error").html('<div class="alert alert-warning"><a class="close" data-dismiss="alert">×</a><div id="flash_alert">' + message + '</div></div>');
		$('.alert').delay(5000).fadeOut(3000);
		return false;
	}
}
