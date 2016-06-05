class CreateConversations < ActiveRecord::Migration
  def change
    create_table :conversations do |t|
      t.boolean :inbox_message, default: false
      t.integer :sender_id
      t.integer :recipient_id

      t.timestamps null: false
    end
    add_index :conversations, :sender_id
    add_index :conversations, :recipient_id
  end
end
