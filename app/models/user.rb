class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :plants, dependent: :destroy
  has_many :ratings, dependent: :destroy
  has_many :plant_interests, dependent: :destroy
  has_many :favourites, dependent: :destroy

  before_destroy :destroy_messages

  validates :name, presence: true, length: { maximum: 20 }

  has_one_attached :profile_picture

  def destroy_messages
    sent = Message.where(sender: self)
    received = Message.where(receiver: self)
    sent.or(received).destroy_all
  end
end
