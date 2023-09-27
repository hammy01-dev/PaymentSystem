# frozen_string_literal: true

class Feature < ApplicationRecord
  belongs_to :plan

  has_many :usages, dependent: :destroy

  validates :name, presence: true, length: { maximum: 50 }
  validates :unit_price, numericality: { only_integer: true }
  validates :max_unit_limit, numericality: { only_integer: true }
  validates :code, uniqueness: true, numericality: { only_integer: true }
end
