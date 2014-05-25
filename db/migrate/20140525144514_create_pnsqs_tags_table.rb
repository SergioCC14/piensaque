class CreatePnsqsTagsTable < ActiveRecord::Migration
  def change
    create_table :pnsqs_tags do |t|
      t.integer :pnsq_id
      t.integer :tag_id
      t.timestamps
    end

  remove_column :tags, :pnsq_id

  end
end
