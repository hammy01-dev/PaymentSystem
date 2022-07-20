# frozen_string_literal: true

class Subscription < ApplicationRecord
  scope :current_users, ->(user_id) { where(user_id: user_id) }
  scope :subscribed_users, -> { group(:user_id).pluck(:user_id) }
  scope :subs, -> {where("created_at <=? and created_at >=? ", Time.now - 0.5 *60*60 ,Time.now-12*60*60).pluck(:id)}
  belongs_to :plan
  belongs_to :user
  has_many :usages
end
