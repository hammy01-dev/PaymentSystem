# frozen_string_literal: true

class Subscription < ApplicationRecord
  scope :current_users, ->(user_id) { where(user_id: user_id) }
  belongs_to :plan
  belongs_to :user
end
