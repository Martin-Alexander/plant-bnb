class CreateNotifications < ActiveRecord::Migration[6.0]
  def change
    create_table :notifications do |t|
      t.references :chat, null: false, foreign_key: true
      t.string :title, null: false
      t.string :message_preview, null: false
      t.boolean :read, default: false

      t.timestamps
    end
  end
end
