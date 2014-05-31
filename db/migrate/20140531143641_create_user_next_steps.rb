class CreateUserNextSteps < ActiveRecord::Migration
  def change
    create_table :user_next_steps do |t|
      t.integer :user_id
      t.boolean :dashboard_help
      t.boolean :user_show_help
    end
  end
end
