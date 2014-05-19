class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :product
  attr_accessible :comment, :email, :name, :user_id
  validates :comment, :presence => true
  validates :name, :email, :presence => true, :if => :not_logged_in?

  def not_logged_in?
  	self.user_id.nil?
  end

end
