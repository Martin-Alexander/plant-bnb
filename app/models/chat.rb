class Chat < ApplicationRecord
  belongs_to :user
  belongs_to :other_user, class_name: "User"
  has_many :notifications, dependent: :destroy

  def self.find_and_increment_number_of_unread_messages_or_create!(args = {})
    user = args.fetch(:user)
    other_user = args.fetch(:other_user)
    existing_record = self.find_by(user: user, other_user: other_user)

    if existing_record
      existing_record.number_of_unread_messages = existing_record.number_of_unread_messages + 1
      existing_record.save!

      return existing_record
    else
      return self.create!(user: user, other_user: other_user, number_of_unread_messages: 1)
    end
  end

  def other_users_chat
    Chat.find_by(user: other_user, other_user: user)
  end

  def messages
    messages_sent_by_you.or(messages_sent_by_the_other_person)
  end

  def messages_sent_by_you
    Message.where(sender: user, receiver: other_user)
  end

  def messages_sent_by_the_other_person
    Message.where(sender: other_user, receiver: user)
  end
end
