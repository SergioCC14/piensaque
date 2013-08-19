class AddCoverToMusics < ActiveRecord::Migration
  def self.up
    add_attachment :musics, :cover
  end

  def self.down
    remove_attachment :musics, :cover
  end
end