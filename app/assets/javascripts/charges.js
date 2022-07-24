// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://coffeescript.org/
// console.log(Rails.configuration)
var stripe = Stripe("pk_test_51LNcMwFJ1WA9H4gSGfyWJlm2kn27XqZncMQuUrCe5jczzRHzCV7LAPvGSDFfjs6vqVRV2lBdFNaxBUoaL2tWQkkL001xmPca5I");
var elements = stripe.elements()
console.log(elements)

// Custom styling can be passed to options when creating an Element.
var style = {
  base: {
    // Add your base input styles here. For example:
    fontSize: '16px',
    color: '#32325d',
    width: "200"
  },
};

// Create an instance of the card Element.
var card = elements.create('card', {style: style});
console.log("this is card",card)

// Add an instance of the card Element into the `card-element` <div>.
window.onload = function(){

  card.mount('#card-element123');
}
