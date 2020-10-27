class CreateUnreadMessageCounters < ActiveRecord::Migration[6.0]
  def change
    create_table :unread_message_counters do |t|
      t.references :user, null: false, foreign_key: true
      t.references :other_user, null: false, foreign_key: { to_table: :users }
      t.integer :count, default: 0

      t.timestamps
    end
  end
end
