class Category < ActiveRecord::Base
   has_many :products
  attr_accessible :name, :product_type, :sort_order
end
