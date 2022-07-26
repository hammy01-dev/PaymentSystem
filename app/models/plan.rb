# frozen_string_literal: true

class Plan < ApplicationRecord
  validates :name, presence: true
  validates :monthly_fee,  numericality: { only_integer: true }

  scope :with_no_features, -> { Plan.all - Plan.joins(:features).uniq }

  has_many :features, dependent: :destroy
  has_one_attached :image, dependent: :destroy
end
