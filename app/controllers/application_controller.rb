# Documentacion:
# http://railscasts.com/episodes/196-nested-model-form-part-1

class ApplicationController < ActionController::Base
  protect_from_forgery

  include SessionsHelper
  include PnsqHelper

  before_filter :rank_admin? , :only => [:admin_panel]
  before_filter :set_cache_buster

  # Ruta Dashboard / Landing
  def index
    if (!signed_in?)
      @request_invitation = RequestInvitation.new
      @session = Session.new

    else
      @pnsq_list = Pnsq.publics.joins(:user).uniq.joins("INNER JOIN relations ON ((pnsqs.user_id = relations.user_relation_id) AND (relations.user_id = #{current_user.id}) AND (pnsqs.user_id = users.id) OR (pnsqs.user_id = #{current_user.id}))").uniq.order('id DESC')

      # Si no sigues a nadie la relación de arriba no funcionará, por lo que cascamos sus propios Pnsqs
      @pnsq_list = @pnsq_list.blank? ? current_user.pnsqs.publics : @pnsq_list

    end
  end

  # Comprueba si tiene rango Admin
  def rank_admin?
    if signed_in?
      if !current_user.admin?
        redirect_to root_path
      end
    else
      redirect_to root_path
    end
  end

  # Comprueba si el usuario esta conectado
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

  def error404
    respond_to do |format|
      format.js { render :nothing => true }
      format.html { render :template => "layouts/404", :layout => 'application', :status => 404 }
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
