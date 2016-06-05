class MessagesController < ApplicationController

  def create
    @conversation = Conversation.find(params[:conversation_id])
    @message = @conversation.messages.build(message_params)
    @message.user_id = current_user.id
    @message.save!
    if @conversation.inbox_message
      render '/conversations/inbox_show'
    else
      @path = conversation_path(@conversation)
    end
  end

  private

  def message_params
    params.require(:message).permit(:body)
  end
end


        # <%= form_for @conversation, url: users_mail_conversations_path do |f| %>
        # <%= f.hidden_field :sender_id, value: current_user.id %>
        # <%= f.hidden_field :recipient_id, value: @user.id %>
        #   %= f.submit "Send" %>
        # <% end %>
