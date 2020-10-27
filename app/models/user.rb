class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :plants, dependent: :destroy
  has_many :ratings, dependent: :destroy
  has_many :plant_interests, dependent: :destroy
  has_many :favourites, dependent: :destroy
  has_many :chats, dependent: :destroy

  before_destroy :destroy_message_related_records

  validates :name, presence: true, length: { maximum: 20 }

  has_one_attached :profile_picture

  def number_of_ratings
    Rating.joins(:plant).where(plants: { user: self }).count
  end

  def average_rating
    Rating.joins(:plant).where(plants: { user: self }).average(:stars)
  end

  private

  def destroy_message_related_records
    sent = Message.where(sender: self)
    received = Message.where(receiver: self)
    sent.or(received).destroy_all

    Chat.where(other_user: self).destroy_all
  end
end
