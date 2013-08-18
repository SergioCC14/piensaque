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
      format.html { render  }
      format.js { render }
    end
  end

  def create
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
