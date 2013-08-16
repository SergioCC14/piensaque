require 'test_helper'

class SessionsHelperTest < ActionView::TestCase


  def admin?
    self.rank == 'ADMIN'
  end

  def legendary_soldier?
    self.rank == 'BIG_BOSS'
  end

end
