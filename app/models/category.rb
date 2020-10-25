class Category < ApplicationRecord
  has_many :plant_categories, dependent: :destroy
  has_many :plants, through: :plant_categories
end
