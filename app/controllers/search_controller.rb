class SearchController < ApplicationController

  def show
    #Rails.logger.debug params.inspect
    case params[:product]
      when "bicicleta"
        
          @bicycles = Bicycle.search(params) #.order_by_updated_at.order_by_type.paginate(:page => params[:page], :per_page => 20) 
          #@bicycles = Bicycle.order_by_updated_at.order_by_type.paginate(:page => params[:page], :per_page => 20)
          render :"products/index"
      when "motocicleta"
          @bicycle = bicycle.search params
          render :"products/index"
      
    end
    
  end
  
end
