class OffersController < ApplicationController
  before_action :authenticate_user!

  before_action :set_offer, only: [:show, :edit, :step1, :update]
  before_action :set_caregiver, only: [:new, :step1, :step2, :update, :create]
  before_action :set_dashboard, only: [:show, :show]

  # GET /offers
  def index
    @offers = current_user.offers.active
  end

  # GET /offers/1
  def show
    @offer = current_user.offers.where(id: params[:id]).first
  end

  # GET /offers/new
  def new
    @message = Message.new
    @offer = Offer.new
  end

  def add_to_job
    @contract = current_user.job
    @offer = Offer.where(contract_id: @contract.id, id: params[:offer_id]).first
    @offer.status = Offer::ACCEPTED
    @offer.save!
    @caregiver = Caregiver.find(params[:caregiver_id])

    @caregiver.contracts << @contract
    current_user.send_message(@caregiver, 'You have been added to a job offer', "#{current_user.first_name} has added you to their job.")

    OfferMailer.caregiver_is_added_to_job(@caregiver, current_user, @contract).deliver_later(wait: 5.seconds)

    redirect_to dashboard_path, notice: "#{@caregiver.first_name} was added to your job."
  end

  def apply_to_job
    @contract = Contract.find(params[:contract_id])
    @offer = Offer.new(caregiver_id: current_user.id)
  end

  # # GET /offers/1/edit
  # def edit
  # end

  # POST /offers
  def create
    if current_user.caregiver?
      @contract = Contract.find(params[:offer][:contract_id])
      @offer = current_user.offer_for_contract(@contract)

      if @offer
        @offer.rate = params[:offer][:rate]
        @offer.status = Offer::NEW
      else
        @offer = Offer.new(
          contract_id: params[:offer][:contract_id],
          caregiver_id: current_user.id,
          rate: params[:offer][:rate]
        )
      end

      body = params[:offer][:cover_letter] ?
                current_user.cover_letter.body :
                  params[:offer][:body]


      if @offer.save
        @contract_owner = @offer.contract.owner
        caregiver = current_user.is_a?(CaregiverDecorator) ? current_user.object : current_user
        message = current_user.send_message(@contract_owner, body, @offer.contract.headline)
        OfferMailer.offer_to_family(@contract_owner, caregiver, message.notification, @contract, @offer).deliver_later(wait: 5.seconds)
        CaregiverMailer.send_caregiver_toolkit(caregiver).deliver_later(wait: 5.seconds)

        @offer.conversation_id = message.conversation.id
        @offer.save!

        redirect_to dashboard_path, notice: "Inquiry was sent to #{@contract_owner.first_name}"
      else
        render action: 'apply_to_job'
      end

    else
      @offer = Offer.new(offer_params.merge(caregiver_id: params[:caregiver_id]))
      @contract = Contract.find(params[:offer][:contract_id])

      if @offer.save
        message = current_user.send_message(@caregiver, message_params[:message][:body], "A new job inquiry from #{current_user.first_name}!")

        OfferMailer.offer_to_caregiver(@caregiver, current_user, @contract, message.notification).deliver_later(wait: 5.seconds)
        CaregiverMailer.send_caregiver_toolkit(@caregiver).deliver_later(wait: 5.seconds)

        @offer.conversation_id = message.conversation.id
        @offer.save!
        redirect_to caregiver_path(params[:caregiver_id]), notice: "Offer to #{current_user.first_name} was sent."
      else
        render action: 'new'
      end
    end
  end

  # PATCH/PUT /offers/1
  # def update
  #   current_step = params[:step1] ? 'step1' : 'step2'

  #   if @offer.update(offer_params)
  #     if message_params && message_params[:message] && !message_params[:message][:body].blank?
  #       current_user.send_message(@caregiver, message_params[:message][:body], "Pending offer from #{current_user.first_name}")
  #     end
  #     redirect_to dashboard_path, notice: "Offer was sent to #{@caregiver.first_name}"
  #   else
  #     render action: 'edit'
  #   end
  # end

  # DELETE /offers/1
  def destroy
    @offer = current_user.offers.where(id: params[:id]).first
    @contract = @offer.contract
    @contract_holder = @contract.owner
    @offer.status = Offer::DECLINED
    @offer.save!
    # current_user.send_message(@contract_holder, 'This offer was declined', "#{current_user.first_name} has declined your offer.")
    redirect_to dashboard_path, notice: 'Offer was removed from contract'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_offer
      id = params[:id] || params[:offer_id]
      @offer = Offer.find(id)
    end

    def set_caregiver
      @caregiver = Caregiver.find(params[:caregiver_id])
    end

    # Only allow a trusted parameter "white list" through.
    def offer_params
      params[:offer].permit(:contract_id, :contract_type, :rate)
    end

    def message_params
      params[:offer].permit(message: [:body])
    end
end
