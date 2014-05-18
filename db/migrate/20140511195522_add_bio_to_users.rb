class AddBioToUsers < ActiveRecord::Migration
  def change
    add_column :users, :bio, :text, :default => 'nil'
  end
end
