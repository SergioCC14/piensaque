class AddTasteToPnsq < ActiveRecord::Migration
  def change
    add_column :pnsqs, :taste, :string, :default => nil

    add_column :users, :mt_classical, :boolean, :default => false
    add_column :users, :mt_dance, :boolean, :default => false
    add_column :users, :mt_heavy, :boolean, :default => false
    add_column :users, :mt_reggae, :boolean, :default => false
    add_column :users, :mt_funk, :boolean, :default => false

  end
end
