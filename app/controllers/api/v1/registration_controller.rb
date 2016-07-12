class Api::V1::RegistrationController < Devise::RegistrationsController
	  skip_before_filter :verify_authenticity_token
	  #acts_as_token_authentication_handler_for User
	  respond_to :json
	  
  
	def update
			@user = current_user
			@user.first_name = params['user']['first_name']
			@user.last_name = params['user']['last_name']
			@user.email = params['user']['email']
			if @user.save!
				render :status => 200,
					   :json => {  :code => 200,
								   :data => {:user => @user} }
			else
				render :status => 500,
					   :json => {  :code => 500,
								   :data => {} }
			end
	
	  
	end
	
	
	def user_params
		params.require(:user).permit(:email,:first_name, :last_name, :password,:phone_number)
	end
end