class Product < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: :slugged

  
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
  
  #Method used by FriendlyId
  def should_generate_new_friendly_id?
    # new_record?
    true
  end
  
  def search(params)
    conditions = []
    conditions << [ "status = ?", params[:status] ] if params[:status].present?
    conditions << [ "brand = ?", params[:brand] ] if params[:brand].present?
    conditions << [ "model = ?", params[:model] ] if params[:model].present?
    conditions << [ "type = ?", params[:type] ] if params[:type].present?
    conditions << [ "city = ?", params[:city] ] if params[:city].present?
    conditions << [ "amount = ?", params[:amount] ] if params[:amount].present?
    find(:all, :conditions => conditions )
  end

end
