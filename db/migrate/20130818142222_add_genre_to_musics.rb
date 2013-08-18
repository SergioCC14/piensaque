class AddGenreToMusics < ActiveRecord::Migration
  def change
    add_column :musics, :genre, :string
  end
end
