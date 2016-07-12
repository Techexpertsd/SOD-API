class Api::V1::SessionsController < Devise::SessionsController
	  acts_as_token_authentication_handler_for User, fallback: :none
	  skip_before_filter :verify_authenticity_token , only: [:create]
	  respond_to :json
	  
	
	def create 
		if User.exists?(:phone_number => params['user']['phone_number'])
			self.resource = warden.authenticate!(auth_options)
			if sign_in(resource_name, resource)
			  render :status => 200,
				   :json => {  :code => 200,
							   :data => {:user => current_user} }
			else
			  render :status => 403,
				   :json => {  :code => 403,
							   :data => {} }
			end
		else
			createUser
		end
	end
	
	def createUser
		user = User.new(user_params)
		user.email = 'null@null.com'
		if user.save!
			render :status => 201,
				   :json => {  :code => 201,
							   :data => {:user => user} }
		else
			render :status => 500,
				   :json => {  :code => 500,
							   :data => {} }
		end
	end

	
	def update
			user = current_user
			user.first_name = params['user']['first_name']
			user.last_name = params['user']['last_name']
			user.email = params['user']['email']
			user.public_key = params['user']['public_key']
			if user.save!
				render :status => 200,
					   :json => {  :code => 200,
								   :data => {:user => user} }
			else
				render :status => 500,
					   :json => {  :code => 500,
								   :data => {} }
			end
	
	  
	end
	
	def user_params
		params.require(:user).permit(:email,:password,:phone_number,:public_key)
	end
end