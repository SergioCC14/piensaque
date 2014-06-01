class RequestInvitation < ActiveRecord::Base
  
  before_create :generate_random_token

  def generate_random_token
    self.update_column(:token, User.new_remember_token)
  end

end