class AddUserIdToPnsq < ActiveRecord::Migration
  def up
    add_column :pnsqs, :user_id, :integer
    
  end

  def down
    remove_column :pnsqs, :user_id
    
  end
end
