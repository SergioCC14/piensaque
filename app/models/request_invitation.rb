class RequestInvitation < ActiveRecord::Base
  
  before_create :generate_random_token


  scope :not_sent, -> { where('request_invitations.checked = false') }

  def generate_random_token
    self.token = User.new_remember_token
  end

end