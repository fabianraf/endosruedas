class Admin::ProductsController < Admin::BaseController
  before_filter :get_product, :only => [:show, :edit, :update]


  def index
    @products = Product.order_by_updated_at.order_by_type.paginate(:page => params[:page], :per_page => 20)
  end

  def show

  end

  def publish
    #New Bicycle
    @bicycle = Bicycle.new
    6.times {@bicycle.bicycle_images.build}
    #New Motorcycle
    @motorcycle = Motorcycle.new
    6.times {@motorcycle.motorcycle_images.build}
  end
  
  def create
    case params[:producto]
    when "bicicleta"
      @bycicle = Bicycle.new(params[:bicycle])
      respond_to do |format|
        if @bycicle.save
          format.html { redirect_to admin_productos_path, notice: 'Bicycle was successfully created.' }
        else
          format.html { render action: "new" }
          format.json { render json: @bycicle.errors, status: :unprocessable_entity }
        end
      end

    when "motocicleta"
      @motorcycle = Motorcycle.new(params[:bicycle])
    end

  end     


  def edit
    
  end

    def update
    params_to_be_saved = {}
    if @product. is_bicycle?
      params_to_be_saved = params[:bicycle]
    elsif @product.is_motorcycle?
      params_to_be_saved = params[:motorcycle]
    end
    respond_to do |format|
        if @product.update_attributes(params_to_be_saved)
          format.html { redirect_to admin_productos_path, notice: 'Product was successfully created.' }
         else
          format.html { render action: "edit" }
          format.json { render json: @product.errors, status: :unprocessable_entity }
        end
      end
  end
    
  private

  def get_product
    @product = Product.find(params[:id])
  end
  
  
end
