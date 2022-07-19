# frozen_string_literal: true

class Plan < ApplicationRecord
  scope :with_no_features, -> { Plan.all - Plan.joins(:features).uniq }
  has_many :features
  has_one_attached :image, dependent: :destroy
end
