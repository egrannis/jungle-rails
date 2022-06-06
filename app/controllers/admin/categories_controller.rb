class Admin::CategoriesController < ApplicationController


# basic user authenticiation with creds in .env file
  http_basic_authenticate_with name: ENV['ADMIN_NAME'], password: ENV['ADMIN_PASSWORD']

def index
    @categories = Category.order(id: :asc).all
  end

  def new
    @product = Category.new
  end

  def create
    @product = Category.new(category_params)

    if @category.save
      redirect_to [:admin, :categories], notice: 'Category created!'
    else
      render :new
    end
  end

  private

  def product_params
    params.require(:category).permit(
      :name,
    )
  end

end
