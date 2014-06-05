class RequestInvitation < ActiveRecord::Base
  
  before_create :generate_random_token
  after_create :notify_admins

  scope :not_sent, -> { where('request_invitations.checked = false') }

  def generate_random_token
    self.token = User.new_remember_token
  end

  def notify_admins
    if (Rails.env == "production")
      ApplicationMailer.new_invitation(self).deliver
    end
  end

end