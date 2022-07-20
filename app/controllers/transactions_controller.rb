class TransactionsController < ApplicationController
  def abc
    a = TransactionCreator.new
    data = a.get_subscriptions
    data.each do |id,total|
      @user = User.find(id)
      InvoiceMailer.new_invoice(@user,total).deliver_now
      byebug
    end

  end

end
