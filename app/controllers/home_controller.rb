class HomeController < ApplicationController
skip_before_action :authenticate_user!, :only => [:index]

  def index
    @categories=Category.order(:name)
  end
end
