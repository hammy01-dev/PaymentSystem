# frozen_string_literal: true
require "#{Rails.root}/app/services/transaction_creator"
class TransactionsController < ApplicationController
  inculde Transactions
  def abc
    # a = TransactionCreator.new
    data  = get_subscriptions
    data.each do |id, total|
      @user = User.find(id)
      InvoiceMailer.new_invoice(@user, total).deliver_now
    end
  end
end
