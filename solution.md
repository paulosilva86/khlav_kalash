# Solution

### General overview

Customers can buy khlav kalash online following a 2 step checkout process.

In the first step they can enter the order details: name, address, email, etc.

In the second step they can pay using a credit card.

If everything is entered correctly, customers will receive their khlav kalash!

### Technical details

The validation of the email format and the required fields are in `app/models/order.rb`.
Specs for these validations are in `spec/models/order_spec.rb`.

System specs for creating an order are in `spec/system/orders_spec.rb`.

The Stripe integration is separated into backend and frontend.

##### Backend

After placing the order successfully, the order is created and the customer goes to the permalink view. This is where a PaymentIntent is created in Stripe and its ID is associated to the order (`payment_intent_id`).

The code is in `app/core/create_payment_intent.rb` and specs are in `spec/core/create_payment_intent_spec.rb`.
The client secret from the PaymentIntent is returned to the frontend.

##### Frontend

Stripe Elements is used to create the UI where the customer can enter credit card details and make the payment. Successful or incomplete payments can be tracked in Stripe's dashboard.

The client secret from the PaymentIntent is used to make the request to Stripe with the card details.

The code is in `app/assets/javascripts/orders.js`.

### Notes
* Added dependencies: rspec, jquery and stripe.
* A migration was created to add a column [payment_intent_id] to the orders table.
