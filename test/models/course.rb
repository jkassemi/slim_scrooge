class Course < ActiveRecord::Base
  before_save :setup

  def setup
    value = (rand * 1000).to_s
    self.name = value
    self.unused = value
  end
end
