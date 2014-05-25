class Pnsq < ActiveRecord::Base

  belongs_to :user
  has_and_belongs_to_many :tags
  has_attached_file :audio
  accepts_nested_attributes_for :tags

  before_save :choose_taste

  # Elige el Taste para el PnsQ. Depende de los gustos del usuario
  def choose_taste

    if (!self.user.blank?)
      taste = self.user.getTastes
      self.taste = taste[rand(taste.count)]
    end
  end

end
