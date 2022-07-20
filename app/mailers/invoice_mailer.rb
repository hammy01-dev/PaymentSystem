# frozen_string_literal: true

class InvoiceMailer < ApplicationMailer
  def new_invoice(user, total)
    # default from: 'hamza.am/er@devsinc.com'
    p 'this is user', @user = user
    @total = total
    mail(to: @user.email, subject: 'You got a new order!')
  end
end
