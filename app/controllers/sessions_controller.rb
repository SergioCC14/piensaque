class SessionsController < ApplicationController
  include SessionsHelper

  def new

  end

  def index

    if signed_in?
      respond_to do |format|
        format.html { redirect_to root_path }
        format.js {  }
      end     
    else

      @session = Session.new;

      respond_to do |format|
        format.html { render  }
        format.js {  }
      end    
    end
  end
  
  def create
    user = (User.find_by_password(params[:pass])) and 
           ((User.find_by_nick(params[:email_or_nick])) or (User.find_by_email(params[:email_or_nick])))



    if user.blank?
      respond_to do |format|
        format.html { redirect_to login_path }
        format.js {  }
      end
    else
      
      iniciar_sesion(user)
      self.current_user= user;

      respond_to do |format|
        format.html { redirect_to root_path }
        format.js {  }
      end
    end
  end

  def destroy
    current_user

    sign_out
    redirect_to root_url
  end



end
