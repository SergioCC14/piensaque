class AddMoreMusicTasteToUsers < ActiveRecord::Migration
  def up
    add_column :users, :mt_country, :boolean
    add_column :users, :mt_hiphop,  :boolean
  end

  def down
    remove_column :users, :mt_country
    remove_column :users, :mt_hiphop
  end
end
