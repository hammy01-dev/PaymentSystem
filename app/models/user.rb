# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :invitable

  enum role: { admin: 0, buyer: 1 }
  enum paymet_verified: { not_verified: 0, verified: 1 }

  has_many :subscriptions, dependent: :destroy
  has_many :plans, through: :subscriptions
  has_one_attached :image, dependent: :destroy

  validate :image_type_size
  def plans_with_no_features
    plans.includes(:features).where(features: { id: nil })
  end

  def image_type_size
    if image.attached?
      if image.blob.byte_size > 2_097_152
        image.purge
        errors.add(:image, 'size can not exceed 2mb')
      elsif !image.blob.content_type.in?(%w[image/jpeg image/png])
        image.purge
        errors.add(:image, 'must be jpeg/png file')
      end
    end
  end
end
