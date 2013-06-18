class User < ActiveRecord::Base
  attr_accessible :email, :nick, :password
end
