class Pnsq < ActiveRecord::Base

  belongs_to :user
  belongs_to :to_user, :class_name => "User"
  has_and_belongs_to_many :tags
  has_attached_file :audio
  accepts_nested_attributes_for :tags

  before_save :choose_taste
  after_create :increment_notifications

  scope :publics, -> { where('to_user_id IS NULL') }
  scope :privates, -> { where('to_user_id IS NOT NULL') }

  # Elige el Taste para el PnsQ. Depende de los gustos del usuario
  def choose_taste
    if (!self.user.blank?)
      taste = self.user.getTastes
      self.taste = taste[rand(taste.count)]
    end
  end

  # Comprueba si es un PnsQ privado.
  # En dicho caso, suma uno a las notificaciones del usuario
  def increment_notifications
    self.to_user.atomic_increment!(:notifications_count) if (!self.to_user_id.blank?)
  end

end
