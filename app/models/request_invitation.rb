class RequestInvitation < ActiveRecord::Base
  
  before_create :generate_random_token

  def generate_random_token
    self.token = User.new_remember_token
  end

end