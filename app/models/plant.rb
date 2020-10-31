class Plant < ApplicationRecord
  belongs_to :user
  has_many :plant_categories, dependent: :destroy
  has_many :categories, through: :plant_categories
  has_many :plant_interests, dependent: :destroy
  has_many :favourites, dependent: :destroy
  has_many :ratings, dependent: :destroy

  validates :title, presence: true, length: { maximum: 80 }
  validates :description, length: { maximum: 2000 }

  validate :validate_has_cover_photo
  validate :validate_has_no_more_than_four_pictures

  has_many_attached :pictures
  has_one_attached :cover_photo

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
    if pictures.length > 3
      errors.add(:pictures, "maximum of three")
    end
  end
end
