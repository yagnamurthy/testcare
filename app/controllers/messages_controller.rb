class MessagesController < ApplicationController
  before_action :authenticate_user!
  around_action :can_view?

  before_action :set_message, only: [:read, :show, :edit, :update, :destroy]


  def index
    redirect_to inbox_mailbox_index_path
  end
  def inbox; end
  def sentbox; end
  def trash; end

  # GET /messages/1
  def show
    @message.mark_as_read(current_user)
    @new_message = Mailboxer::Message.new
    @offer = Offer.get_based_on_message @message
  end

  # GET /messages/new
  def new
    @message = Mailboxer::Message.new
    @return_url = params[:return_url]
    if params[:user_id]
      @user = User.find(params[:user_id])
    end
    @receiver = User.find(params[:user_id])
    @sender = current_user
  end

  def new_invite
  end

  def new_offer
  end

  # POST /messages
  def create
    receiver = User.find(params[:user_id])
    sender = current_user

    if params[:conversation_id]
      conversation = Mailboxer::Conversation.find(params[:conversation_id])
      body = message_params[:body]
      message = current_user.reply_to_conversation(conversation, body)
    elsif params[:contract_id]
      contract = Contract.find(params[:contract_id])
      subject = "#{contract.headline}"
      body = params[:mailboxer_message][:body]
    else
      subject = "A message from #{current_user.first_name}"
      body = params[:mailboxer_message][:body]
    end

    message = current_user.send_message(receiver, body, subject)

    MessageMailer.send_message(sanitize_receiver(receiver), sanitize_sender(sender), body).deliver_later(wait: 5.seconds)

    if params[:conversation_id]
      redirect_to inbox_mailbox_index_path
    else
      redirect_to caregiver_path(receiver)
    end
  end

  def read
    render json: @message.mark_as_read(current_user)
  end

  def destroy
    render json: @message.move_to_trash(current_user)
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Mailboxer::Conversation.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def message_params
      params[:mailboxer_message].permit(:subject, :body)
    end

    def sanitize_sender sender
      if sender.try(:object)
        sender.object
      else
        sender
      end
    end

    def sanitize_receiver receiver
      if receiver.try(:object)
        receiver.object
      else
        receiver
      end
    end

    def can_view?
      if current_user && !current_user.admin?
        yield
      else
        redirect_to '/'
      end
    end
end
