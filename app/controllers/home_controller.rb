class HomeController < ApplicationController
  def index
    @categories=Category.order(:name)
  end
end
