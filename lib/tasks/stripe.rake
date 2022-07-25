# frozen_string_literal: true

require "#{Rails.root}/app/services/transaction_creator"
include Transactions
desc 'Print something five times.'
task charge: :environment do
  5.times { puts 'something' }
  # InvoiceMailer.new_invoice(current_user, 200).deliver_now
  # transaction = TransactionCreator.new
  # data = transaction.get_subscriptions
  get_subscriptions
end
