class MessagesController < ApplicationController
  layout false

  def create
    if params[:id]
      @conversation = Conversation.find_by(id: params[:id])
      @message = @conversation.messages.build(message_params)
      @message.user_id = current_user.id
      @messages = @conversation.messages
      @receiver = @conversation.receiver
      if @message.save!
        if request.xhr?
          render '/conversations/_individual_message', layout: false, locals: {message: @message}
        else
          redirect_to inbox_messages_show_path(@conversation)
        end
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
