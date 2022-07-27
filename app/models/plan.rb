# frozen_string_literal: true

class Plan < ApplicationRecord
  has_one_attached :image, dependent: :destroy

  has_many :features, dependent: :destroy

  validates :name, presence: true, length: { maximum: 100 }
  validates :monthly_fee, numericality: { only_integer: true }
end
