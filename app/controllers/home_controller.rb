class HomeController < ApplicationController
  def index
  	@request_invitation = RequestInvitation.new


  end
end
