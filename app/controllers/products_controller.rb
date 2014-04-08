class ProductsController < ApplicationController

	def index
		@bicycles = Bicycle.order_by_updated_at.order_by_type.paginate(:page => params[:page], :per_page => 20)
	end
  
  def show
    @bicycle = Bicycle.find(params[:id])
  end
  
end
