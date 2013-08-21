class AddOggSongToMusics < ActiveRecord::Migration
  def self.up
    add_attachment :musics, :ogg_song
  end

  def self.down
    remove_attachment :musics, :ogg_song
  end
end
