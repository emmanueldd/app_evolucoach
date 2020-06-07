// TODO : TESTER le cas de l'update
App.dashboard_payment_infos = App.dashboard_payment_infos || {};
App.dashboard_payment_infos.index = {
  init: function() {
    var self = this;

    // Assumes you've already included Stripe.js!
    const myForm = document.querySelector('.my-form');
    myForm.addEventListener('submit', handleForm);

    async function handleForm(event) {
      event.preventDefault();

      const accountResult = await stripe.createToken('account', {
        // business_type: 'company',
        company: {
          // name: document.querySelector('#payment_info_business_name').value,
          address: {
            // line1: document.querySelector('#payment_info_business_address_1').value,
            // city: document.querySelector('#payment_info_business_city').value,
            // state: document.querySelector('#payment_info_business_state').value,
            // postal_code: document.querySelector('#payment_info_business_zip_code').value,
          },
        },
        tos_shown_and_accepted: true,
      });

      // const personResult = await stripe.createToken('person', {
      //   person: {
          // first_name: document.querySelector('#payment_info_first_name').value,
          // last_name: document.querySelector('#payment_info_last_name').value,
          // address: {
          //   line1: document.querySelector('#payment_info_contact_address_1').value,
          //   city: document.querySelector('#payment_info_contact_city').value,
          //   state: document.querySelector('#payment_info_contact_state').value,
          //   postal_code: document.querySelector('#payment_info_contact_zip_code').value,
          // },
      //   },
      // });

      // if (accountResult.token && personResult.token) {
      if (accountResult.token) {
        document.querySelector('#token-account').value = accountResult.token.id;
        // document.querySelector('#token-person').value = personResult.token.id;
        myForm.submit();
      }
    }





  }
}
