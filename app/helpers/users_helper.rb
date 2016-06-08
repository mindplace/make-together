module UsersHelper
  include ConversationsHelper

  def is_following?(user)
    current_user.followed_users.include?(user)
  end

  def any_inbox_messages_with?(user)
    Conversation.between(current_user.id, user.id).where(conversation_type: "inbox_message").length > 0
  end

  def all_conversations(user)
    @conversations = Conversation.where(["sender_id = ? or receiver_id = ?", user.id, user.id])
  end

  def new_messages
    all_conversations(current_user)
    @new_messages = []
    @conversations.each do |conversation|
      @new_messages << conversation.messages.last
    end
    @new_messages.delete_if {|message| message.user_id== current_user.id}
    return @new_messages
  end
end