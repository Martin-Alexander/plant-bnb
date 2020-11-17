require "open-uri"

class Plant < ApplicationRecord
  belongs_to :user
  has_many :plant_categories, dependent: :destroy
  has_many :categories, through: :plant_categories
  has_many :plant_interests, dependent: :destroy
  has_many :favourites, dependent: :destroy
  has_many :ratings, dependent: :destroy

  has_many_attached :pictures
  has_one_attached :cover_photo

  validates :title, presence: true, length: { maximum: 80 }
  validates :description, length: { maximum: 2000 }

  validate :validate_has_cover_photo
  validate :validate_has_no_more_than_four_pictures

  include PgSearch::Model
  pg_search_scope(:search_by_title_and_description,
  against: [ :title, :description ],
  using: {
    tsearch: { prefix: true }
  }
  )
  
  def public
    !private
  end
  
  def price=(price_in_dollars)
    self.price_cents = price_in_dollars.to_i * 100
  end
  
  def price
    price_cents / 100
  end
  
  def validate_has_cover_photo
    if !cover_photo.attached?
      errors.add(:cover_photo, "can't be blank")
    end
  end
  
  def validate_has_no_more_than_four_pictures
    if pictures.length > 4
      errors.add(:pictures, "maximum of four")
    end
  end

  # Cloudinary, when requested for a never-before-requested transformed image, takes some time to make the transformation

  # private

  # include CloudinaryHelper
  # after_commit :pre_generate_cloudinary_crops

  # def pre_generate_cloudinary_crops
  #   if cover_photo.attached?
  #     URI.open(cl_image_path(cover_photo.key, height: 380, crop: :scale))
  #   end

  #   if pictures.attached?
  #     pictures.each { |pic| URI.open(cl_image_path(pic.key, height: 380, crop: :scale)) }
  #   end
  # end
end
