class MotorcycleImage < Image
  default_scope { where(group: self.name) }
  belongs_to :motorcycle
  mount_uploader :file, BicycleImageUploader
end
