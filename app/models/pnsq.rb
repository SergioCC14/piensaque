class Pnsq < ActiveRecord::Base

  belongs_to :user
  has_many :tags, :dependent => :destroy
  has_attached_file :audio
  accepts_nested_attributes_for :tags

  before_create :choose_taste

  # Elige el Taste para el PnsQ. Depende de los gustos del usuario
  def choose_taste
    if (!self.user.blank?)
      taste = self.user.getTastes
      self.update_column(:taste, taste[rand(taste.count)])
    end
  end

end
