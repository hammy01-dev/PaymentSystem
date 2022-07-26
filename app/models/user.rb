# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :invitable

  enum role: { admin: 0, buyer: 1 }
  enum paymet_verified: { not_verified: 0, verified: 1 }

  has_many :subscriptions, dependent: :destroy
  has_many :plans, through: :subscriptions
  has_one_attached :image, dependent: :destroy

  def plans_with_no_features
    plans.includes(:features).where(features: { id: nil })
  end
end
