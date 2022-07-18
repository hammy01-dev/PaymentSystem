# frozen_string_literal: true

class Usage < ApplicationRecord
  belongs_to :user
  belongs_to :feature
end
