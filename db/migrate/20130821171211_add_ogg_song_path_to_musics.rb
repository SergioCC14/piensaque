class AddOggSongPathToMusics < ActiveRecord::Migration
  def up
    add_column :musics, :ogg_song_file_path, :string
    add_column :musics, :ogg_song_file_url, :string
  end

  def down
    remove_column :musics, :ogg_song_file_path
    remove_column :musics, :ogg_song_file_url
  end

end
