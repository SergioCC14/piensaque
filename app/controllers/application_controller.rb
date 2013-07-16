class ApplicationController < ActionController::Base
  protect_from_forgery

  # No funciona, pero usalo como ejemplo
 def request_invitation
	  respond_to do |format|
	    format.html	{ render }
	    format.js { render :template => 'application/request_invitation'}
	  end
  end


  private
		def current_user
			@_current_user ||= 	session[:current_user_id] && User.find(session[:current_user_id]) end 

end
