class UsersController < ApplicationController
  include SessionsHelper
  include ApplicationHelper

  before_filter :connected?, :except => [:show]

  # GET /users
  # GET /users.json
  def index

    # raise params.inspect
    # raise current_user.inspect

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    if @user = !params[:id].blank? ? User.find(params[:id]) : User.find_by_nick(params[:nick])
      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @user }
      end
    else
      error500
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
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
    @user = User.new(params[:user])
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
      if @user.update_attributes(params[:user])
        format.html { redirect_to user_nick_path(@user.nick), notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
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

end
