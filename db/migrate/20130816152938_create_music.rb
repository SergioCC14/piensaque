class CreateMusic < ActiveRecord::Migration
def change
    create_table :musics do |t|
      t.string  :path
      t.text    :title
      t.text    :artist
      t.text    :album

      t.timestamps
    end
  end
end
