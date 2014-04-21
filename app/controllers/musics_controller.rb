class MusicsController < ApplicationController
  include SessionsHelper
  
  before_filter :rank_admin?

  # before_filter :convert_to_ogg
  # before_attachment_post_process :convert_to_ogg

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

  # PUT /music/1
  # PUT /music/1.json
  def update
    @music = Music.find(params[:id])

    respond_to do |format|
      if @music.update_attributes(params[:music])
        format.html { redirect_to music_path, notice: 'Music was successfully updated.' }
        format.js { redirect_to root_path }
      else
        format.html { render action: "edit" }
        format.js { render json: @music.errors, status: :unprocessable_entity }
      end
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
    @music = Music.new(music_params)
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

  private
    def music_params
      params.require(:music).permit(:song, :title, :artist, :album, :genre, :cover, :ogg_song, :updated_at, :created_at)
    end
end
