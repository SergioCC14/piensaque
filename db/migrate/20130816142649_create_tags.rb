class CreateTags < ActiveRecord::Migration
def change
    create_table :tags do |t|
      t.string :name
      t.references :pnsq

      t.timestamps
    end
    add_index :tags, :pnsq_id
  end
end
