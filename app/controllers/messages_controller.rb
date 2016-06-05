class MessagesController < ApplicationController

  def create
    if params[:id]
      @conversation = Conversation.find_by(id: params[:id])
      @message = @conversation.messages.build(message_params)
      @message.user_id = current_user.id
      @messages = @conversation.messages
      @reciever = @conversation.recipient
      if @message.save!
        redirect_to inbox_show_path(@conversation)
      else
        @errors = @message.errors
        render '/conversations/inbox_show'
      end
    else
      @conversation = Conversation.find(params[:conversation_id])
      @message = @conversation.messages.build(message_params  )
      @message.user_id = current_user.id
      @message.save!

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
