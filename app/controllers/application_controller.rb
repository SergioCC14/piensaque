class ApplicationController < ActionController::Base
  protect_from_forgery

  include SessionsHelper

  # No funciona, pero usalo como ejemplo
  def request_invitation
	  respond_to do |format|
	    format.html	{ render }
	    format.js { render :template => 'application/request_invitation'}
	  end
  end

  def index
    @request_invitation = RequestInvitation.new
    @session = Session.new 

  end


  def connected?
    if !signed_in?
      redirect_to root_path
    end
  end
end
