class User < ApplicationRecord
  has_secure_password

  has_many :questions, dependent: :destroy
  has_many :answers, dependent: :destroy

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, on: :create
  validates :password_confirmation, presence: true, on: :create

  def expert?
    role == "expert"
  end

  def general?
    role == "general"
  end
end
