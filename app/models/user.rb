class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable, :recoverable,
  acts_as_token_authenticatable
  devise :database_authenticatable, :registerable,
          :rememberable, :trackable, :validatable
  
	def email_required?
		false
	end
	
	def email_changed?
		false
	end
end
