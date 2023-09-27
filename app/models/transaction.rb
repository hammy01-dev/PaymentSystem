# frozen_string_literal: true

class Transaction < ApplicationRecord
  validates :subscription_id, presence: true

  belongs_to :subscription
end
