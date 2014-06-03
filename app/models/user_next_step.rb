class UserNextStep < ActiveRecord::Base

  STEPS = ['dashboard_help']

  after_create :preset

  # Comprueba si ese paso existe en el tutorial
  def self.exist_step?(step)
    return STEPS.include?(step)
  end

  def preset
    self.assign_attributes(
      :dashboard_help => false,
      :user_show_help => false)
  end

end
