class RequestInvitationsController < ApplicationController
  
  before_filter :rank_admin? , :only => [:destroy, :delete]

  def index
    @request_invitations = RequestInvitation.all
		@request_invitation = RequestInvitation.find(request_invitation_params)

    respond_to do |format|
      format.html 
      format.js { render }
    end
  end

	def new
    @request_invitation = RequestInvitation.new


    respond_to do |format|
      format.html	{ render }
      format.js { render }
    end
  end

	def create
		@request_invitation = RequestInvitation.new(request_invitation_params)
		@request_invitation.save

	  respond_to do |format|
	    format.html	{ redirect_to root_path(:invitation => 'sent')}
	    format.js { render }
	  end
	end

  def destroy
    @request_invitation = RequestInvitation.find(params[:id])
    @request_invitation.destroy

    respond_to do |format|
      format.html { redirect_to admin_panel_path }
      format.json {  }
    end
  end

  private
    def request_invitation_params
      params.require(:request_invitation).permit(:email, :checked, :token, :updated_at, :created_at)
    end
end
