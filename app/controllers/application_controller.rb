# Documentacion:
# http://railscasts.com/episodes/196-nested-model-form-part-1

class ApplicationController < ActionController::Base
  protect_from_forgery

  include SessionsHelper
  include PnsqHelper

  # No funciona, pero usalo como ejemplo
  def request_invitation
	  respond_to do |format|
	    format.html	{ render }
	    format.js { render :template => 'application/request_invitation'}
	  end
  end

  def index
    max_tags = 3


    @request_invitation = RequestInvitation.new
    @session = Session.new
    @pnsq = Pnsq.new
    
    max_tags.times{ @pnsq.tags.build }
    @tag = Tag.new 

  end

  def rank_admin?
    if signed_in?
      if !current_user.admin?
        redirect_to root_path
      end
    else
      redirect_to root_path
    end

  end

  def connected?
    if !signed_in?
      redirect_to root_path
    end
  end

  # Solo pueden pasar los administradores
  def admin_panel
    if !signed_in? or !current_user.admin?
      redirect_to root_path
    end
  end
end
