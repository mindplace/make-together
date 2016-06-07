class CreateConversations < ActiveRecord::Migration
  def change
    create_table :conversations do |t|
      t.string :conversation_type
      t.integer :sender_id
      t.integer :receiver_id

      t.timestamps null: false
    end
    add_index :conversations, :sender_id
    add_index :conversations, :receiver_id
  end
end
