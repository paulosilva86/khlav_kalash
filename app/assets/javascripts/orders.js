$(document).ready(function() {

  /**
  * Create instance of Stripe Elements.
  **/
  var stripe = Stripe('pk_test_51HDGl1C96uJmWMnrD5izUSnlk08reOGJ6m1TpWTNFQFRsfQRzxH51jVpggFTYsDt5FMd5dobqpjjdifSPiAFGi6200rK2bWPNr');
  var elements = stripe.elements();

  /**
  * Create and mount card.
  **/
  var style = {
    base: {
      color: "#32325d",
    }
  };

  var card = elements.create("card", { style: style });
  card.mount("#card-element");

  /**
  * Validate user input on change.
  **/
  card.on('change', ({error}) => {
    const displayError = document.getElementById('card-errors');
    if (error) {
      displayError.textContent = error.message;
    } else {
      displayError.textContent = '';
    }
  });

  /**
  * Submit payment to Stripe on button click.
  **/
  var payButton = $('#submit');
  var clientSecret = payButton.attr('data-secret');
  var fullName = $('#first-name').text() + ' ' + $('#last-name').text();

  payButton.click(function(ev) {
    ev.preventDefault();
    stripe.confirmCardPayment(clientSecret, {
      payment_method: {
        card: card,
        billing_details: {
          name: fullName 
        }
      }
    }).then(function(result) {
      if (result.error) {
        alert(result.error.message);
      } else {
        if (result.paymentIntent.status === 'succeeded') {
          alert("Payment successful!")
        }
      }
    });
  });
});
