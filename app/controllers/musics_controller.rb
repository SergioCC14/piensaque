class MusicsController < ApplicationController
  include SessionsHelper
  
  before_filter :rank_admin?

  def index
    respond_to do |format|
      format.html 
      format.js { render }
    end
  end

  def new
    @music = Music.new
    respond_to do |format|
        format.html 
        format.json { render json: @music }
    end
  end

  def show

    @music = Music.find(params[:id])

    respond_to do |format|
      format.html 
      format.js { render }
    end
  end

  def create
    raise params[:music][:artist].inspect
    @music = Music.new(params[:music])
    # @Music.mp3toOgg 
    @music.save


    respond_to do |format|
      format.html { redirect_to }
      format.js { render }
    end
  end

  def destroy

    respond_to do |format|
      format.html { redirect_to root_path }
      format.json {  }
    end
  end


end
