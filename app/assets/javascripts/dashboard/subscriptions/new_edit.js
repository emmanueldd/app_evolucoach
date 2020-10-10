'use strict';

App.dashboard_subscriptions = App.dashboard_subscriptions || {};
App.dashboard_subscriptions.new_edit = {
	init: function init() {
		var self = this;
		if ($('.carousel').length > 0) {
			$('.carousel').carousel();
		}
		if ($('#card-element').length > 0) {
			var elements = stripe.elements();
			var style = {
			  base: {
			    color: "#32325d",
			    fontFamily: '"Helvetica Neue", Helvetica, sans-serif',
			    fontSmoothing: "antialiased",
			    fontSize: "16px",
			    "::placeholder": {
			      color: "#aab7c4"
			    }
			  },
			  invalid: {
			    color: "#fa755a",
			    iconColor: "#fa755a"
			  }
			};
			var cardElement = elements.create("card", { style: style });
			cardElement.mount("#card-element");
			cardElement.on('change', self.showCardError);
			var customerId = $('#customer_id').val();
			var priceId = $('#price_id').val();
			$("#subscription-form").validate({
				submitHandler: function(form) {
					self.createPaymentMethod(cardElement, customerId, priceId, form);
				}
			});
		}


	},
	showCardError: function showCardError(event) {
	  let displayError = document.getElementById('card-errors');
	  if (event.error) {
	    displayError.textContent = event.error.message;
	  } else {
	    displayError.textContent = '';
	  }
	},
	createPaymentMethod: function createPaymentMethod(cardElement, customerId, priceId, form) {
		var self = this;
	  return stripe
	    .createPaymentMethod({
	      type: 'card',
	      card: cardElement,
	    })
	    .then((result) => {
	      if (result.error) {
					let displayError = document.getElementById('card-errors');
	        console.log("error =>>>>>>", result.error);
	      } else {
					// var form = $("#subscription-form");
					form.submit();
					// console.log(form);
					// console.log('form submit');
	        // self.createSubscription({
	        //   customerId: customerId,
	        //   paymentMethodId: result.paymentMethod.id,
	        //   priceId: priceId,
	        // });
	      }
	    });
	},
	createSubscription: function createSubscription({ customerId, paymentMethodId, priceId }) {
		var form = $("#subscription-form");
		form.submit();
		return;
		var self = this;
	  return (
	    fetch('/dashboard/subscriptions/create_subscription', {
	      method: 'post',
	      headers: {
	        'Content-type': 'application/json',
	      },
	      body: JSON.stringify({
	        customerId: customerId,
	        paymentMethodId: paymentMethodId,
	        priceId: priceId,
	      }),
	    })
	      .then((response) => {
	        return response.json();
	      })
	      // If the card is declined, display an error to the user.
	      .then((result) => {
	        if (result.error) {
	          // The card had an error when trying to attach it to a customer.
	          throw result;
	        }
	        return result;
	      })
	      // Normalize the result to contain the object returned by Stripe.
	      // Add the addional details we need.
	      .then((result) => {
	        return {
	          paymentMethodId: paymentMethodId,
	          priceId: priceId,
	          subscription: result,
	        };
	      })
	      // Some payment methods require a customer to be on session
	      // to complete the payment process. Check the status of the
	      // payment intent to handle these actions.

				// @@@@ WARNING
	      // .then(handlePaymentThatRequiresCustomerAction)

	      // If attaching this card to a Customer object succeeds,
	      // but attempts to charge the customer fail, you
	      // get a requires_payment_method error.

				// @@@@ WARNING
	      // .then(handleRequiresPaymentMethod)

	      // No more actions required. Provision your service for the user.
	      .then(self.onSubscriptionComplete)
	      .catch((error) => {
	        // An error has happened. Display the failure to the user here.
	        // We utilize the HTML element we created.
	        self.showCardError(error);
	      })
	  );
	},
	onSubscriptionComplete: function onSubscriptionComplete(result) {
		var self = this;
	  // Payment was successful.
	  if (result.subscription.status === 'active') {
	    // Change your UI to show a success message to your customer.
	    // Call your backend to grant access to your service based on
	    // `result.subscription.items.data[0].price.product` the customer subscribed to.
	  }
	}
}
