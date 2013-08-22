class AddRemoveOggColumnsOfMusics < ActiveRecord::Migration
  def up
    remove_column :musics, :ogg_song_file_path
    remove_column :musics, :ogg_song_file_url
  end

  def down
    add_column :musics, :ogg_song_file_path, :string
    add_column :musics, :ogg_song_file_url, :string
  end
end
