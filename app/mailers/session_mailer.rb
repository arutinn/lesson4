class SessionMailer < ApplicationMailer
	default from: 'from@example.com'
	
	def sigh_in_email
		@user = params[:user]
		mail to: @user.email, subject: 'Your sigh in information' 
	end
end
