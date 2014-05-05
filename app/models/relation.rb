class Relation < ActiveRecord::Base
  
  belongs_to :user

  before_destroy :decrement_follows
  before_create :increment_follows


  # Incremantar los Seguidores/Siguiendo
  def increment_follows
    # Usuario que hace follow
    self.user.atomic_increment!(:following_count) if !self.user.blank?

    # Usuario al que le hacen follow
    User.find_by_id(self.user_relation_id).atomic_increment!(:followers_count) if User.find_by_id(self.user_relation_id)
  end

  # Decrementar los Seguidores/Siguiendo
  def decrement_follows
    # Usuario que hace follow
    self.user.atomic_decrement!(:following_count) if !self.user.blank?

    # Usuario al que le hacen follow
    User.find_by_id(self.user_relation_id).atomic_decrement!(:followers_count) if User.find_by_id(self.user_relation_id)    
  end

end
