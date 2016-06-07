module UsersHelper
  def is_following?(user)
    current_user.followed_users.include?(user)
  end

  def any_inbox_messages_with?(user)
    Conversation.between(current_user.id, user.id).where(conversation_type: "inbox_message").length > 0
  end
end