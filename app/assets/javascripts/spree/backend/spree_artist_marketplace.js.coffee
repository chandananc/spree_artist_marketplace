#= require spree/backend

$(document).ready ->
  if $('.new_artist_bank_account').length > 0
    $('.new_artist_bank_account').submit ->
      if $('#artist_bank_account_token').val() == ''
        Stripe.bankAccount.createToken({
            country: $('#artist_bank_account_country_iso').val(),
            routingNumber: $('#artist_bank_account_routing_number').val(),
            accountNumber: $('#artist_bank_account_account_number').val(),
        }, stripeBankAccountResponseHandler);
        return false

stripeBankAccountResponseHandler = (status, response) ->
  if response.error
    $('#stripeError').html(response.error.message)
    $('#stripeError').show()
  else
    $('#artist_bank_account_account_number').prop("disabled" , true);
    $('#artist_bank_account_routing_number').prop("disabled" , true);
    $('#artist_bank_account_masked_number').val('xxxxxx' + response['bank_account']['last4'])
    $('#artist_bank_account_name').val(response['bank_account']['bank_name'])
    $('#artist_bank_account_token').val(response['id'])
    $('.new_artist_bank_account').submit()