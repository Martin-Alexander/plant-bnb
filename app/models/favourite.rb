class Favourite < ApplicationRecord
  belongs_to :user
  belongs_to :plant

  validates :user, uniqueness: { scope: :plant }

  validate :validate_plant_not_owned_by_user

  def self.already_existing_between(user, plant)
    Favourite.find_by(user: user, plant: plant)
  end

  private

  def validate_plant_not_owned_by_user
    if plant.user == user
      errors.add(:plant, "owned by user")
    end
  end
end
