class Bicycle < Product
  has_many :bicycle_images, class_name: 'BicycleImage', dependent: :destroy
	accepts_nested_attributes_for :bicycle_images
  attr_accessible :bicycle_images_attributes
end
