class CreatePlaylists < ActiveRecord::Migration
def change
    create_table :playlists do |t|
      t.string  :name
      t.string  :genre
      t.string  :order    # Aleatoria, normal...

      t.timestamps
    end
  end
end
