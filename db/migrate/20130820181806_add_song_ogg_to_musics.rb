class AddSongOggToMusics < ActiveRecord::Migration
  def self.up
    add_attachment :musics, :song_ogg
  end

  def self.down
    remove_attachment :musics, :song_ogg
  end
end