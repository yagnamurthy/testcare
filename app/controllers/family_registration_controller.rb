require 'braintree'

class FamilyRegistrationController < ApplicationController

	before_action :authenticate_user!
	before_action :verify_family!


	def job
	  @job = current_user.find_or_create_job
	end

  def payment
    @client_token = Braintree::ClientToken.generate(
      :customer_id => current_user.customer_id
    )
  end

  def process_payment
    result = Braintree::Transaction.sale(
      amount: "99.00",
      payment_method_nonce: params[:payment_method_nonce],
      options: {
        submit_for_settlement: true
      }
    )

    job = current_user.job
    job.indexable = true
    job.save!

    redirect_to inbox_mailbox_index_path
  end

	def update
		if job_params
			@job = current_user.find_or_create_job

			if @job.update(job_params)
      			current_user.update!(zipcode: @job.zipcode, phone: @job.phone)
      			redirect_to near_path(zipcode: @job.zipcode), notice: 'Your job has been created'
    		else
      			render action: :job
    		end
		elsif user_params
			if current_user.update!(user_params)
				redirect_to near_path(current_user.zipcode), notice: 'You have finished registratio'
			else
				render action :shared_connections
			end
		else
			redirect_to near_path(current_user.job.zipcode)
		end
	end

	private

	def job_params
		params[:contract].permit(
            :age_range, :hourly_type, :care_type,
            :schedule_type, :schedule_need, :gender,
            :patient_name, :headline, :description, :hours_needed,
            :zipcode, :phone, :job_type, :required_rate,
            screening_questions_attributes: [ :question ],
            service_ids: [], requirement_ids: []) unless params[:contract].nil?
	end

	def user_params
		params[:user].permit(affiliate_ids: []) unless params[:user].nil?
	end
end
