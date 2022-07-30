# frozen_string_literal: true

class Subscription < ApplicationRecord
  belongs_to :plan
  belongs_to :user

  has_many :usages, dependent: :destroy

  has_many :transactions, dependent: :destroy

  scope :current_users, ->(user_id) { where(user_id: user_id) }
  scope :subscribed_users, -> { group(:user_id).pluck(:user_id) }
  scope :get, lambda { |usage_params|
    where(plan_id: usage_params[:plan_id], user_id: usage_params[:user_id]).ids.first
  }
end
