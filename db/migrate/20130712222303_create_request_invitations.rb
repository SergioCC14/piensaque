class CreateRequestInvitations < ActiveRecord::Migration
  def change
    create_table :request_invitations do |t|
      t.string :email

      t.timestamps
    end
  end
end
