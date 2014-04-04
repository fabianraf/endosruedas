class  Motorcycle < Product
  	has_many :motorcycle_images, class_name: 'MotorcycleImage', dependent: :destroy
    attr_accessible :mileage, :cylinder_capacity, :fuel_id  
    
end
