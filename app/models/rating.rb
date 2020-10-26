class Rating < ApplicationRecord
  belongs_to :user
  belongs_to :plant

  validates :stars, inclusion: { in: 1..5 }
end
