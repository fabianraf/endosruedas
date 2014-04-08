class Product < ActiveRecord::Base

	has_one :user_product
	has_one :user, :through => :user_product
	belongs_to :category
  	attr_accessible :title, :new, :status, :type,   :brand_id, :model_id, :year, :city, :brake, :size_id, :speed_id, :amount, :description, :color, :category_id
  	 
  	validates :title, :brand_id, :model_id, :city, :amount,  :presence => true
    	validates :new, :inclusion => {:in => [true, false]}
    	scope :order_by_updated_at, :order => "updated_at DESC"
    	scope :order_by_type, :order => "type DESC"


    	def is_bicycle?
    		true if self.type.downcase == "bicycle"
    	end

    	def is_motorcycle?
    		true if self.type.downcase == "motorcycle"
    	end

end
