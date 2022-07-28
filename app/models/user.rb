# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :invitable

  enum role: { admin: 0, buyer: 1 }
  enum paymet_verified: { not_verified: 0, verified: 1 }

  has_many :subscriptions, dependent: :destroy
  has_many :plans, through: :subscriptions
  has_one_attached :image, dependent: :destroy

  validate :correct_image_type
  def plans_with_no_features
    plans.includes(:features).where(features: { id: nil })
  end

  def correct_image_type
    errors.add(:image, 'Must be a PNG or GIF') if image.attached? && !image.content_type.in?(%w[image/png image/jpeg])
  end
end
