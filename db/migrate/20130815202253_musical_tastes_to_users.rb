class MusicalTastesToUsers < ActiveRecord::Migration
  def change
    add_column :users, :mt_rock,          :boolean
    add_column :users, :mt_pop,           :boolean
    add_column :users, :mt_electronic,    :boolean
    add_column :users, :mt_instrumental,  :boolean, :default => true
    add_column :users, :mt_jazz,          :boolean
  end
end
