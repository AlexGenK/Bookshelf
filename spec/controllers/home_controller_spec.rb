require 'rails_helper'

RSpec.describe HomeController, type: :controller do
   describe "GET #index" do
      before { @category = create_list(:category, 3) }

      it "assigns array of category to @category sorted by name" do
         get :index
         expect(assigns(:categories)).to eq(@category.sort_by {|h| h[:name]})
      end

      it "renders the index template" do
        get :index
        expect(response).to render_template("index")
      end
  end
end