class Conversation < ActiveRecord::Base
  belongs_to :sender, foreign_key: :sender_id, class_name: "User"
  belongs_to :receiver, foreign_key: :receiver_id, class_name: "User"

  has_many :messages, dependent: :destroy

  scope :involving, -> (user) do
    where("conversations.sender_id =? OR conversations.receiver_id =?",user.id,user.id)
  end

  scope :between, -> (sender_id,receiver_id) do
    where("(conversations.sender_id = ? AND conversations.receiver_id =?) OR (conversations.sender_id = ? AND conversations.receiver_id =?)", sender_id,receiver_id, receiver_id, sender_id)
  end

end
