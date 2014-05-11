class CreateFollow < ActiveRecord::Migration
  def change
    

    create_table :relations do |t|
      t.integer :user_id
      t.integer :user_relation_id

      t.timestamps
    end
    add_column :users, :followers_count, :integer, :default => 0
    add_column :users, :following_count,  :integer, :default => 0

  end
end
