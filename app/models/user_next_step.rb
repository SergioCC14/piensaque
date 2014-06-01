class UserNextStep < ActiveRecord::Base

  STEPS = ['dashboard_help', 'user_show_help']

  # Comprueba si ese paso existe en el tutorial
  def self.exist_step?(step)
    return STEPS.include?(step)
  end

end
