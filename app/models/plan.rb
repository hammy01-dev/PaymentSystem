# frozen_string_literal: true

class Plan < ApplicationRecord
  has_many :features, dependent: :destroy
  has_many :subscriptions, dependent: :destroy

  validates :name, presence: true, length: { maximum: 50 }
  validates :monthly_fee, numericality: { only_integer: true }
end
