class ConversationsController < ApplicationController

  def create
    if params[:conversation]
      @conversations = current_user.conversations.where(conversation_type: "inbox_message").concat(Conversation.where(recipient_id: current_user.id))
      @conversation = Conversation.between(params[:conversation][:sender_id], params[:conversation][:recipient_id])
      if @conversation.first && @conversation.where(conversation_type: "inbox_message").first
        @conversation = @conversation.where(conversation_type: "inbox_message").first
      else
        @conversation = Conversation.create!(inbox_message_params)
      end
        @messages = @conversation.messages
        @reciever = @conversation.recipient
        @message = Message.new
        render :inbox
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

  def inbox_messages_show
    @conversation = Conversation.find_or_create_by(id: params[:id])
    @reciever = interlocutor(@conversation)
    @messages = @conversation.messages
    @message = Message.new
    @conversations = current_user.conversations.where(conversation_type: "inbox_message").concat(Conversation.where(recipient_id: current_user.id))
    render :inbox
  end

  def inbox
    @conversations = current_user.conversations.where(conversation_type: "inbox_message").concat(Conversation.where(recipient_id: current_user.id))
    render :inbox
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
