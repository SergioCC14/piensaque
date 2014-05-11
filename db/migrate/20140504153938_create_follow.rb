class CreateFollow < ActiveRecord::Migration
  def change
    
    create_table :relations do |t|
      t.integer :user_id
      t.integer :user_relation_id

      t.timestamps
    end

  end
end
