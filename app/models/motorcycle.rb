class  Motorcycle < Product
  	has_many :motorcycle_images, class_name: 'MotorcycleImage', dependent: :destroy
  	accepts_nested_attributes_for :motorcycle_images
    	attr_accessible :mileage, :cylinder_capacity, :fuel_id , :motorcycle_images_attributes
    	
    
end
