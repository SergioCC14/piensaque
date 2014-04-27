class AddUserIdToPnsq < ActiveRecord::Migration
  def up
    add_column :pnsq, :user_id, :integer
    
  end

  def down
    remove_column :pnsq, :user_id
    
  end
end
