class ProductsController < ApplicationController
  #uncomment this line to force login
  #before_filter :authorize
  
  def index
    @products = Product.all.order(created_at: :desc)
  end

  def show
    @product = Product.find params[:id]
  end

end
# defines what variable are available in the views file
# knows by naming convention of the views files