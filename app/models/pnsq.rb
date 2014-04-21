class Pnsq < ActiveRecord::Base

  belongs_to :user
  has_many :tags, :dependent => :destroy

  accepts_nested_attributes_for :tags

  has_attached_file :audio

end
