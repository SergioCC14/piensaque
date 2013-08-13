class SessionsController < ApplicationController
  include SessionsHelper

  def new

  end

  def index
    @session = Session.new;

    respond_to do |format|
      format.html { render  }
      format.js {  }
    end    
  end
  
  def create
    user = (User.find_by_password(params[:pass])) and 
           ((User.find_by_nick(params[:email_or_nick])) or (User.find_by_email(params[:email_or_nick]))) 

    iniciar_sesion(user)

    if user.blank?
      respond_to do |format|
        format.html { redirect_to sessions_path }
        format.js {  }
      end
    else

      self.current_user= user;

      respond_to do |format|
        format.html { redirect_to users_path }
        format.js {  }
      end
    end
  end

  def destroy
    sign_out
    redirect_to root_url
  end



end
