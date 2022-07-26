# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :invitable

  enum role: { admin: 0, buyer: 1 }
  enum paymet_verified: { not_verified: 0, verified: 1 }

  has_many :subscriptions, dependent: :destroy
  has_many :plan, through: :subscriptions
  has_one_attached :image, dependent: :destroy
end
