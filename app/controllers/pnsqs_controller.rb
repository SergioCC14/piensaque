class PnsqsController < ApplicationController
  include SessionsHelper
  include ApplicationHelper

  # GET /pnsqs
  # GET /pnsqs.json
  def index
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @pnsqs }
    end
  end

  # GET /pnsqs/1
  # GET /pnsqs/1.json
  def show
    # respond_to do |format|
    #   format.html # show.html.erb
    #   format.json { render json: @user }
    # end
  end

  # GET /pnsqs/new
  # GET /pnsqs/new.json
  def new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /pnsqs/1/edit
  def edit
    respond_to do |format|
      format.html # edit.html.erb
      format.json { render json: @user }
    end

  end

  # POST /pnsqs
  def create
    # TODO:
    # Primero hay que comprobar si le llegan los parámetros
    # Luego lo creamos

    if (@pnsq = Pnsq.create(pnsq_params))

      respond_to do |format|
        format.html { redirect_to home_path, notice: 'Pnsq was successfully updated.' }
        format.js { render }
      end
    else
      error404
    end
  end

  # DELETE /pnsqs/1
  # DELETE /pnsqs/1.json
  def destroy
    @pnsq = Pnsq.find(params[:id])
    @pnsq.destroy

    respond_to do |format|
      format.html { redirect_to admin_panel_path }
      format.json { head :no_content }
    end
  end

  private
    def pnsq_params
      params.require(:pnsq).permit(:to_user_id, :text, :audio, :tags, :user_id, :updated_at, :created_at, :tags_attributes)
    end

end
