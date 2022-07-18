# frozen_string_literal: true

class Plan < ApplicationRecord
  has_many :features
  has_one_attached :image, dependent: :destroy
end
