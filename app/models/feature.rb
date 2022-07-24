# frozen_string_literal: true

class Feature < ApplicationRecord
  validates :name, presence: true
  validates :unit_price,  numericality: { only_integer: true }
  validates :max_unit_limit,  numericality: { only_integer: true }
  validates :code,  uniqueness: true


  belongs_to :plan
  has_many :usages, dependent: :destroy
end
