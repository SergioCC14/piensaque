class AddFollowersFollowingToUsers < ActiveRecord::Migration
  def change

    create_table :relations_tables do |t|
      t.integer :user_id
      t.integer :user_relation_id

      t.timestamps
    end

    add_column :users, :followers, :integer, :default => 0
    add_column :users, :following,  :integer, :default => 0
  end

end
