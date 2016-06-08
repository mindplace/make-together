module ConversationsHelper
  def all_inbox_conversations
    @conversations = Conversation.where(["sender_id = ? or receiver_id = ?", current_user.id, current_user.id]).where(conversation_type: "inbox_message")
  end

end
