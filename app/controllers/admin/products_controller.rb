class Admin::ProductsController < Admin::BaseController
  
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
          format.html { redirect_to admin_producto_path(@bycicle), notice: 'Bicycle was successfully created.' }
          format.json { render json: @bycicle, status: :created, location: @bycicle }
        else
          format.html { render action: "new" }
          format.json { render json: @bycicle.errors, status: :unprocessable_entity }
        end
      end

    when "motocicleta"
      @motorcycle = Motorcycle.new(params[:bicycle])
    end

  end     
    
  
  
end
