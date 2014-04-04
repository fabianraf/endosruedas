class Admin::ProductsController < Admin::BaseController
  
  def publish
    #New Bicycle
    @bicycle = Bicycle.new
    3.times {@bicycle.bicycle_images.build}
    #New Motorcycle
    @motorcycle = Motorcycle.new
    3.times {@motorcycle.motorcycle_images.build}
  end
  
  def create
    case params[:producto]
    when "bicicleta"
      @bycicle = Bicycle.new(params[:bicycle])
    when "motocicleta"
    end
  end
  
end
