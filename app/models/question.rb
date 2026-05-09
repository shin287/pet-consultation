class Question < ApplicationRecord
  belongs_to :user
  has_many :answers, dependent: :destroy
  has_one_attached :image

  validates :title, presence: true
  validates :body, presence: true
  validates :animal_type, presence: true
  validates :consultation_type, presence: true
  validates :animal_other, presence: true, if: -> { animal_type == "その他" }
end
