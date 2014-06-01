# Documentacion:
# http://railscasts.com/episodes/196-nested-model-form-part-1

class ApplicationController < ActionController::Base
  protect_from_forgery

  include SessionsHelper
  include PnsqHelper

  before_filter :set_cache_buster

  # No funciona, pero usalo como ejemplo
  def request_invitation
	  respond_to do |format|
	    format.html	{ render }
	    format.js { render :template => 'application/request_invitation'}
	  end
  end


  # root_path
  def index
    if (!signed_in?)
      @request_invitation = RequestInvitation.new
      @session = Session.new

    else
      @pnsq_list = current_user.pnsqs.publics.order('id DESC')

    end
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

  # Establece unas cabeceras para evitar (Solicitud desde origen distinto bloqueada: la política de mismo origen impide leer el recurso remoto en http://s3.amazonaws.com/public.piensaque.com/assets/font-awesome/font/fontawesome-webfont.woff?v=3.2.1. Esto se puede arreglar moviendo el recurso al mismo dominio o activando CORS.)
  def set_cache_buster
    response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
    response.headers["Access-Control-Allow-Origin"] = "*"
    response.headers["Access-Control-Allow-Credentials"] = "true"
    response.headers["X-Frame-Options"] = "ALLOWALL"
  end

end
