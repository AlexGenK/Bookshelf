class AuthorsController < ApplicationController
  before_action :set_author, only: [:edit, :update, :destroy]

  def index
    @authors = Author.order(:name)
  end

  def new
    @author = Author.new
  end

  def create
    @author = Author.new(author_params)
    if @author.save
      redirect_to authors_path
    else
      flash[:alert] = 'Unable create the author'
      render :new
    end
  end

  def destroy
    Author.find(params[:id]).destroy
    redirect_to authors_path
  end

  def edit
  end

  def update
    if @author.update(author_params)
        redirect_to authors_path, notice: 'Author was successfully updated.'
      else
        flash[:alert] = 'Unable update the author'
        render :edit
      end
  end

  private

  def set_author
    @author = Author.find(params[:id])
  end


  def author_params
    params.require(:author).permit(:name, :bio)
  end

end
