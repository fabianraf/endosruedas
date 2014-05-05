class ProductsController < ApplicationController

	def index
		#@bicycles = Bicycle.order_by_updated_at.order_by_type.paginate(:page => params[:page], :per_page => 20)
		@q = Bicycle.search(params[:q])
    @bicycles = @q.result.order_by_updated_at.order_by_type.paginate(:page => params[:page])
	end
  
  def show
    @bicycle = Bicycle.find(params[:id])
  end
  
  
  def search
    case params[:product]
      when "bicicleta"
          index
          render :index
      when "motocicleta"
          render :"admin/productos"
      
    end
  end
  
end
