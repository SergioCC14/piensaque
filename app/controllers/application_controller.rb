class ApplicationController < ActionController::Base
  protect_from_forgery

 def request_invitation
	  respond_to do |format|
	    format.html	{ render }
	    format.js { render :template => 'application/request_invitation'}
	  end
  end

end
