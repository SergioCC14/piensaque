class ChangeNamePathFromMusics < ActiveRecord::Migration
  def up
    remove_column :musics, :path
    add_attachment :musics, :song
  end

  def down
    add_column :musics, :path, :string
    remove_attachment :musics, :song
  end
end