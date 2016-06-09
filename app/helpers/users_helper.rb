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
    if @new_messages.compact.length > 0
      return @new_messages.compact.delete_if {|message| message.user_id == current_user.id}.length
    else
      return 0
    end
  end

  def current_projects(user)
    if user.projects.length > 1
      "#{user.projects.length} Current Projects"
    elsif user.projects.length == 1
      "1 Current Project"
    else
      ""
    end
  end

  def suggested_following
    if current_user.followers.length == 0
      suggested = []
      suggested << User.all.sample(2)
      suggested.flatten.delete_if {|user| user.id == current_user.id}
    end
    return suggested.flatten
  end
end
