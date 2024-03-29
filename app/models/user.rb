# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :invitable
  enum role: { admin: 0, buyer: 1 }
  has_many :subscriptions
  has_many :plan, through: :subscriptions
end
