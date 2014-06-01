class AddCheckedToRequestInvitations < ActiveRecord::Migration
  def change
    add_column :request_invitations, :checked, :boolean, :default => false
  end
end
