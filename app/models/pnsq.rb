class Pnsq < ActiveRecord::Base

  attr_accessible :audio, :text


  belongs_to :user
  has_many :tags, :dependent => :destroy

  accepts_nested_attributes_for :tags

end
