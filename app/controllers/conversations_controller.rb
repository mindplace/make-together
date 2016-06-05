class ConversationsController < ApplicationController
  layout false

  # def create
  #   if Conversation.between(params[:sender_id],params[:recipient_id]).present?
  #     @conversation = Conversation.between(params[:sender_id],params[:recipient_id])
  #     if !@conversation.inbox_message
  #       @conversation = Conversation.create!(conversation_params)
  #     end
  #   end
  #   if params[:inbox_message]
  #     @conversation.update_attributes(inbox_message: true)
  #     @conversations = current_user.conversations.where(inbox_message: true)
  #     render :inbox
  #   else
  #     render json: { conversation_id: @conversation.id }
  #   end
  # end

  def create
    if params[:conversation]
      @conversations = current_user.conversations.where(conversation_type: "inbox_message")
        @conversation = Conversation.between(params[:conversation][:sender_id], params[:conversation][:recipient_id])
        if @conversation.first && @conversation.where(conversation_type: "inbox_message").first
          render :inbox
        else
          @conversation = Conversation.create!( inbox_message_params)
          render :inbox
        end
      elsif params[:conversation_type] == "chat"
        @conversation = Conversation.between(params[:sender_id],params[:recipient_id])
        if @conversation.first && @conversation.where(conversation_type: "chat").first
          render json: { conversation_id: @conversation.where(conversation_type: "chat").first.id }
        else
          @conversation = Conversation.create!( conversation_params)
          render json: { conversation_id: @conversation.id }
        end
      end
  end

  def show
    @conversation = Conversation.find(params[:id])
    @reciever = interlocutor(@conversation)
    @messages = @conversation.messages
    @message = Message.new
  end

  def inbox_show
    @conversation = Conversation.find_or_create_by(id: params[:id])
    @reciever = interlocutor(@conversation)
    @messages = @conversation.messages
    @message = Message.new
    render :inbox_show
  end

  private
  def conversation_params
    params.permit(:sender_id, :recipient_id, :conversation_type)
  end

  def inbox_message_params
    params.require(:conversation).permit(:sender_id, :recipient_id, :conversation_type)
  end

  def interlocutor(conversation)
    current_user == conversation.recipient ? conversation.sender : conversation.recipient
  end
end
