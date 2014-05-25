class AddToUserIdToPnsq < ActiveRecord::Migration
  def change
    add_column :pnsqs, :to_user_id, :integer, :default => nil
    add_column :users, :password_salt, :string, :default => nil
  end
end
