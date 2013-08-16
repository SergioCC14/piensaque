class CreatePnsqs < ActiveRecord::Migration
def change
    create_table :pnsqs do |t|
      t.string  :audio
      t.text    :text

      t.timestamps
    end
  end
end
