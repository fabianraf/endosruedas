class Product < ActiveRecord::Base

	has_one :user_product
	has_one :user, :through => :user_product
	belongs_to :category
  	attr_accessible :title, :new, :status, :type,   :brand_id, :model_id, :year, :city, :brake, :size_id, :speed_id, :amount, :description, :color, :category_id
  	 
  	validates :title, :brand_id, :model_id, :city, :amount,  :presence => true
    	validates :new, :inclusion => {:in => [true, false]}


end
