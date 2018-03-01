class CategoriesController < ApplicationController
   before_action :set_category, only: [:show, :destroy]
   load_and_authorize_resource

  def index
    @categories = Category.order(:name)
    @category = Category.new
  end

  def show
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to categories_path
    else
      flash[:alert] = 'Unable create category'
      render :new
    end
  end

  def destroy
    @category.destroy
    redirect_to categories_path
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name)
  end

end
