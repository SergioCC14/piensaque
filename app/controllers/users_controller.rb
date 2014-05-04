class UsersController < ApplicationController
  include SessionsHelper
  include ApplicationHelper

  before_filter :connected?, :except => [:show]

  # GET /users
  # GET /users.json
  def index

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    if @user = !params[:id].blank? ? User.find(params[:id]) : User.find_by_nick(params[:nick])

      @pnsqs = Pnsq.where(:user_id => @user.id)

      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @user }
      end
    else
      error404
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

    if !current_user.blank? and current_user.legendary_soldier? 
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

  # GET /users/1/edit
  def edit
    @user = !params[:id].blank? ? User.find(params[:id]) : User.find_by_nick(params[:nick])

    respond_to do |format|
      if (current_user == @user)
        format.html { render }
        format.js { render  }
      else
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

    respond_to do |format|
      if (@user.save) and (!used_nick)
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update

    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(user_params)
        format.html { redirect_to root_path, notice: 'User was successfully updated.' }
        format.js { redirect_to root_path }
      else
        format.html { render action: "edit" }
        format.js { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  private
    def user_params
      params.require(:user).permit(:email, :rank, :nick, :password, :name, :surname,:mt_rock, :mt_pop, :mt_electronic, :mt_instrumental, :mt_jazz, :mt_hiphop, :mt_country, :avatar, :updated_at, :created_at)
    end

end
