class ConversationsController < ApplicationController
  include UsersHelper

  def create
    if params[:conversation]
      @conversations = all_inbox_conversations
      @conversation = Conversation.between(params[:conversation][:sender_id], params[:conversation][:receiver_id])
      if @conversation.first && any_inbox_conversation_with_user?
        @conversation = any_inbox_conversation_with_user?
      else
        @conversation = Conversation.create!(inbox_message_params)
      end
        set_messages_receiver_message
        render :inbox
    elsif params[:conversation_type] == "chat"
      @conversation = Conversation.between(params[:sender_id],params[:receiver_id])
      if @conversation.first && any_chat_conversation_with_user?
        render json: { conversation_id: any_chat_conversation_with_user?.id }
      else
        @conversation = Conversation.create!( conversation_params)
        render json: { conversation_id: @conversation.id }
      end
    end
  end

  def show
    @conversation = Conversation.find(params[:id])
    set_messages_receiver_message
    render :show, layout: false
  end

  def inbox_messages_show
    @conversation = Conversation.find_or_create_by(id: params[:id])
    set_messages_receiver_message
    @conversations = all_inbox_conversations
    if request.xhr?
      render :_inbox_show, layout: false, locals: {conversation: @conversation, receiver: @receiver, messages: @messages}
    else
      render :inbox
    end
  end

  def inbox
    @conversations = all_inbox_conversations
    render :inbox
  end

  private
  def conversation_params
    params.permit(:sender_id, :receiver_id, :conversation_type)
  end

  def inbox_message_params
    params.require(:conversation).permit(:sender_id, :receiver_id, :conversation_type)
  end

  def interlocutor(conversation)
    current_user == conversation.receiver ? conversation.sender : conversation.receiver
  end

  def any_inbox_conversation_with_user?
    @conversation.where(conversation_type: "inbox_message").first
  end

  def any_chat_conversation_with_user?
    @conversation.where(conversation_type: "chat").first
  end

  def set_messages_receiver_message
    @messages = @conversation.messages
    @receiver = interlocutor(@conversation)
    @message = Message.new
  end

end
