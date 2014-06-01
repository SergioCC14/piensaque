class AddTokenToRequestInvitations < ActiveRecord::Migration
  def change
    add_column :request_invitations, :token, :string, :default => nil
  end
end
