class BicycleImage < Image
  default_scope { where(group: self.name) }
  belongs_to :bicycle
  mount_uploader :file, BicycleImageUploader
end
