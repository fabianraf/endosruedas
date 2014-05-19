class ProductsController < ApplicationController

def index
	#@bicycles = Bicycle.order_by_updated_at.order_by_type.paginate(:page => params[:page], :per_page => 20)
	@q = Bicycle.search(params[:q])
      @bicycles = @q.result.order_by_updated_at.order_by_type.paginate(:page => params[:page])
end
  
  def show
    @bicycle = Bicycle.find(params[:id])
    @comment = @bicycle.comments.new
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

  def comentar
      @bicycle = Bicycle.find(params[:id])
      params_comment = params[:comment]
      unless current_user.nil?
        params_comment[:user_id] = current_user.id
      end
      @comment = @bicycle.comments.new(params_comment)
      respond_to do |format|
        if @comment.save
          flash[:notice] = "Tu pregunta ha sido enviada exitosamente!"
          format.js
        else
          flash[:notice] = "Han habido errores en tu pregunta :("
          format.js
        end
        
      end
  end
  
end
