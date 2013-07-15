class RequestInvitationsController < ApplicationController
  

  def index
    @request_invitations = RequestInvitation.all
		@request_invitation = RequestInvitation.find(params[:request_invitation])

    respond_to do |format|
      format.html 
      format.js { render }
    end
  end

	def new
    @request_invitation = RequestInvitation.new


    respond_to do |format|
      format.html	{ render  }
      format.js { render }
    end
  end

	def create
		@request_invitation = RequestInvitation.new(params[:request_invitation])

		@request_invitation.save

	  respond_to do |format|
	    format.html	{ redirect_to root_path(:invitation => 'sent')}
	    format.js { render }
	  end
	end

end
