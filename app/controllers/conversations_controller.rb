class ConversationsController < ApplicationController
  layout false

  def create
    if Conversation.between(params[:sender_id],params[:recipient_id]).present?
      @conversation = Conversation.between(params[:sender_id],params[:recipient_id]).first
    else
      @conversation = Conversation.create!(conversation_params)
    end
    if params[:inbox_message]
      render :inbox
    else
      render json: { conversation_id: @conversation.id }
    end
  end

  def show
    @conversation = Conversation.find(params[:id])
    @reciever = interlocutor(@conversation)
    @messages = @conversation.messages
    @message = Message.new
  end

  #new email
  # def mail_show
  #   @conversation = Conversation.find_or_create_by(sender_id: params[:sender_id], recipient_id: params[:recipient_id] )
  #   @reciever = interlocutor(@conversation)
  #   @messages = @conversation.messages
  #   @message = Message.new
  #   render :mail
  # end

  def inbox_show
    @conversation = Conversation.find_or_create_by(id: params[:id])
    @reciever = interlocutor(@conversation)
    @messages = @conversation.messages
    render :inbox_show
  end

  private
  def conversation_params
    params.permit(:sender_id, :recipient_id)
  end

  def interlocutor(conversation)
    current_user == conversation.recipient ? conversation.sender : conversation.recipient
  end
end
