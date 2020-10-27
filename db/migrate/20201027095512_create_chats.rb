class CreateChats < ActiveRecord::Migration[6.0]
  def change
    create_table :chats do |t|
      t.references :user, null: false, foreign_key: true
      t.references :other_user, null: false, foreign_key: { to_table: :users }
      t.integer :number_of_unread_messages, default: 0

      t.timestamps
    end
  end
end
