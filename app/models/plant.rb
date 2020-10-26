class Plant < ApplicationRecord
  belongs_to :user
  has_many :plant_categories, dependent: :destroy
  has_many :categories, through: :plant_categories
  has_many :plant_interests, dependent: :destroy
  has_many :favourites, dependent: :destroy
  has_many :ratings, dependent: :destroy

  validates :title, presence: true, length: { maximum: 80 }
  validates :description, length: { maximum: 2000 }

  has_many_attached :pictures
  has_one_attached :cover_photo
end
