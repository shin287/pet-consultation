require "securerandom"

class User < ApplicationRecord
  has_secure_password

  has_many :questions, dependent: :destroy
  has_many :answers, dependent: :destroy

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, on: :create
  validates :password_confirmation, presence: true, on: :create

  def self.guest
    find_or_create_by!(email: "guest@example.com") do |user|
      user.name = "ゲストユーザー"
      user.password = SecureRandom.urlsafe_base64
      user.password_confirmation = user.password
      user.role = "general"
    end
  end

  def expert?
    role == "expert"
  end

  def guest?
    email == "guest@example.com"
  end

  def general?
    role == "general"
  end
end
