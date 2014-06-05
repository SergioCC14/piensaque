class UsersController < ApplicationController
  include SessionsHelper
  include ApplicationHelper
  include UsersHelper

  before_filter :connected?, :only => [:show]

  # GET /users
  # GET /users.json
  def index
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  # GET /users/:id/relations_in_holder
  # 
  # params: role => following or followed
  # 
  def relations_in_holder
    if (@user = User.find_by_id(params[:id]))

      if (params[:role] == 'following')
        @relations = Relation.where(:user_id => @user.id)
      else
        @relations = Relation.where(:user_relation_id => @user.id)
      end

      respond_to do |format|
        format.html { redirect_to root_path }
        format.js { render }
      end

    else
      error404
    end
  end

  # GET /users/:id
  def show
    if @user = !params[:id].blank? ? User.find(params[:id]) : User.find_by_nick(params[:nick])

      @pnsqs = Pnsq.where(:user_id => @user.id).order('id DESC')

      # Comprueba si mostrar el botón de Seguir
      if (signed_in?) and (current_user.id != @user.id)
        @relation = Relation.where(:user_id => current_user.id, :user_relation_id => @user.id).first
      end

      respond_to do |format|
        format.html { render }
        format.js { render}
      end
    else
      error404
    end
  end

  # GET /users/:id/new_personal_pnsqs_in_holder
  # 
  # Ventana emergente para enviar un Mensaje Privado de Audio a un usuario @user
  def new_personal_pnsq_in_holder
    if (@user = User.find_by_id(params[:id]))

      if !its_me?(@user)
        respond_to do |format|
          format.html { redirect_to root_path}
          format.js { render }
        end
      else
        respond_to do |format|
          format.html { redirect_to root_path}
          format.js { redirect_to root_path, notice: "You cannot send a personal message for yourself"}
        end
      end
    else
      error404
    end
  end

  # GET /users/:id/new_personals_pnsq_in_holder
  # 
  # Ventana emergente para visualizar los Mensajes Privados
  def personal_pnsqs_in_holder
    if ((@user = User.find_by_id(params[:id])) and (its_me?(@user)))

      @pnsqs = @user.privates_all

      # Notificaciones leidas
      @user.update_attributes(:notifications_count => 0)

      respond_to do |format|
        format.html { redirect_to root_path }
        format.js { render }
      end

    else
      error404
    end
  end

  # GET /users/new
  # 
  # Las invitaciones llegan con los params[:ri] y params[:tkn]
  # 
  def new
    if ((!params[:tkn].blank? and !params[:ri].blank?) and (ri = RequestInvitation.find_by(:id => params[:ri].to_i, :token => params[:tkn])) and !ri.checked) or (signed_in? and current_user.legendary_soldier?)


      if (!ri.blank?)

        @user = User.new(
            :name => ri.email.split("@").first.gsub('.',''),
            :nick => checker_nick(ri.email.split("@").first.gsub('.','')),
            :email => ri.email
          )
      else
        @user = User.new
      end

      respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @user }
      end
 
    else
      respond_to do |format|
        format.html {redirect_to root_path}
        format.json { render json: @user }
      end
    end
  end

  # GET /users/:id/edit
  def edit
    if @user = !params[:id].blank? ? User.find(params[:id]) : User.find_by_nick(params[:nick])

      respond_to do |format|
        if (current_user == @user)
          format.html { render }
          format.js { render  }
        else
          format.html { redirect_to root_path }
          format.js { render  }
        end
      end
    else
      respond_to do |format|
        format.html { redirect_to root_path }
        format.js { render  }
      end
    end
  end

  # POST /users
  def create

    @user = User.new(user_params)
    used_nick = false

    # Comprueba si el nick ha sido usado, si ha sido usado lo modifica
    @user.used_nick(@user.nick)

    # Genera una nueva contraseña
    @user.generate_remember_token

    # Es un administrador
    if signed_in?
      respond_to do |format|
        if (@user.save) and (!used_nick)
          format.html { redirect_to @user, notice: 'User was successfully created.' }
          format.json { render json: @user, status: :created, location: @user }
        else
          format.html { render action: "new" }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    
    # Es un usuario de nuevo registro
    else
      iniciar_sesion(@user)

      respond_to do |format|
        format.html { redirect_to @user   }
        format.js { render  }
      end

    end
  end

  # GET /users/:id/change_password_in_holder
  def change_password_in_holder
    if (@user = User.find_by_id(params[:id]))
      respond_to do |format|
        format.html { redirect_to root_path }
        format.js { render }
      end

    else
      error404
    end
  end

  # GET /users/:id/user_next_step
  # POST /users/:id/user_next_step
  # 
  # Params: step = [dashboard_help, user_show_help]
  # 
  def user_next_step
    if (@user = User.find_by_id(params[:id]))
      
      if (UserNextStep.exist_step?(params[:step])) and (user_next_step = UserNextStep.find_or_create_by(:user_id => @user.id)) and (!user_next_step[params[:step].to_sym])
        # Petición POST?
        if request.post?
          
          user_next_step.update_attributes(:dashboard_help => true)
          respond_to do |format|
            format.html { render :nothing => true }
            format.js { render :nothing => true }
          end

        else
          @step = params[:step]

          respond_to do |format|
            format.html { redirect_to root_path }
            format.js { render :template => 'users/user_next_step/next_step' }
          end
        end
      else
        error404
      end
    else
      error404
    end
  end

  # PUT /users/:id/update_password
  def update_password
    if (@user = User.find_by_id(params[:id]))
      
      @user.password_salt = User.encrypt("--#{Time.now.utc}--#{ENV['SALT']}")
      @user.password = User.encrypt("--#{params[:password]}--#{@user.created_at}--#{@user.password_salt}")
      
      if (@user.save)
        respond_to do |format|
          format.html { redirect_to root_path, :notice => 'Password changed' }
          format.js { render :nothing => true }
        end
      else
        error404
      end
    else
      error404
    end
  end

  # PUT /users/:id
  def update
    if (@user = User.find(params[:id]))

      # Compruebo que no exista ningun Usuario con Nick o Email igual
      if ((check_new_mail) and (check_new_nick))
        respond_to do |format|
          if @user.update_attributes(user_params)
            format.html { redirect_to root_path, notice: 'User was successfully updated.' }
            format.js { redirect_to root_path }
          else
            format.html { render action: "edit" }
            format.js { render json: @user.errors, status: :unprocessable_entity }
          end
        end
      else
        respond_to do |format|
          format.html { redirect_to settings_user_path(@user.nick), :notice => 'User or Mail in use' }
          format.js { redirect_to settings_user_path(@user.nick), :notice => 'User or Mail in use'  }
        end
      end
    else
      error404
    end
  end

  # DELETE /users/:id
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  # Valida el nuevo email. Si es valido, devuelve true
  def check_new_mail
    if (params[:user][:email] != @user.email)
      if (User.where(:nick => params[:user][:email]).count > 0)
        false
      else
        true
      end
    else
      true
    end
  end

  # Valida el nuevo nick. Si es valido, devuelve true
  def check_new_nick
    if (params[:user][:nick] != @user.nick)
      if (User.where(:nick => User.clean_nick(params[:user][:nick])).count > 0)
        false
      else
        true
      end
    else
      true
    end
  end

  private
    def user_params
      params.require(:user).permit(:bio, :email, :rank, :nick, :password, :name, :surname,:mt_rock, :mt_pop, :mt_electronic, :mt_instrumental, :mt_jazz, :mt_hiphop, :mt_country, :mt_heavy, :mt_reggae, :mt_classical, :mt_dance, :mt_funk, :avatar, :updated_at, :created_at)
    end

end
