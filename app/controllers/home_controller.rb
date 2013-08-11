class HomeController < ApplicationController
  def index
  	@request_invitation = RequestInvitation.new
    @session = Session.new 
    
    # @_current_user ||=  session[:current_user_id] && User.find(session[:current_user_id]) 
    # @session =  Session.find_by_session_id
    # @session = RequestInvitation.new

  end
end
