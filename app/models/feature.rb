# frozen_string_literal: true

class Feature < ApplicationRecord
  belongs_to :plan
  has_many :usages
end
