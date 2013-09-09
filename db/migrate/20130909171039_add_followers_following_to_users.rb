class AddFollowersFollowingToUsers < ActiveRecord::Migration
  def up
    add_column :users, :followers, :integer, :default => 0
    add_column :users, :following,  :integer, :default => 0
  end

  def down
    remove_column :users, :followers
    remove_column :users, :following
  end
end
