class AdminController < ApplicationController
	before_action :authenticate_user!
	before_action :verify_admin!

	def dashboard
		@recent_caregivers = Caregiver.order("updated_at DESC").limit(10)
		@recent_jobs = Contract.order("updated_at DESC").limit(10)
		@recent_families = User.families.order("updated_at DESC").limit(10)
	end

	def caregivers
		if params[:f]
			@caregivers = Caregiver.completed.order("updated_at DESC").page(params[:page] || 1).per(20)
		else
			@caregivers = Caregiver.order("updated_at DESC").page(params[:page] || 1).per(20)
		end
	end

	def families
		if params[:f]
			@families = User.families.order("updated_at DESC").page(params[:page] || 1).per(20)
		else
			@families = User.families.order("updated_at DESC").page(params[:page] || 1).per(20)
		end
	end

  def contracts
    @contracts = Contract.order("updated_at DESC").page(params[:page] || 1).per(20)
  end

	def contacted
		@caregiver = Caregiver.find(params[:id])
		@caregiver.contacted=true

		if @caregiver.save
			redirect_to request.referer, notice: "#{@caregiver.first_name} was contacted"
		else
			redirect_to request.referer, notice: "#{@caregiver.first_name} wasn't contacted"
		end
	end

	def add
		klass = params[:model].constantize
		user = klass.find(params[:id])
		klass.show.store user
		klass.index.refresh

		user.indexable = true

		if user.save
			user.send_approval_email
			redirect_to request.referer, notice: "#{user.full_name} was enabled"
		else
			redirect_to request.referer, notice: "Error occurred when enabling #{user.full_name}. Please try again."
		end
	end

	def remove
		klass = params[:model].constantize
		user = klass.find(params[:id])
		klass.show.remove user
		user.indexable = false

		if user.save
			redirect_to request.referer, notice: "#{user.full_name} was disabled"
		else
			redirect_to request.referer, notice: "Error occurred when disabling #{user.full_name}. Please try again."
		end
	end
end
