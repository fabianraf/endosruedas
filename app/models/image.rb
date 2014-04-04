class Image < ActiveRecord::Base
  attr_accessible :file

  after_initialize :set_group
  before_save :set_group
  
  private
  
    def set_group
      self.group = self.class.name
    end
end
