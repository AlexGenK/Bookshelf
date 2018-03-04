require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
  before do 
    sign_in create(:categories_admin)
  end

  describe "GET #index" do
    before { @categories = create_list(:category, 3) }

    it "assigns array of categories to @categories" do
       get :index
       expect(assigns(:categories)).to eq(@categories)
    end

    it "assign a new instance of Category class to new category" do
      get :index
      expect(assigns(:category).instance_of?(Category)).to be_truthy
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end
  end

  describe "GET #show" do
    before { @category = create(:category) }
    subject { get :show, params: { id: @category } }

    it "assigns the requested category to @category" do
      subject
      expect(assigns(:category)).to eq(@category)
    end

    it "renders the show template" do
      subject
      expect(response).to render_template("show")
    end
  end

  describe "POST #create" do
    subject { post :create, params: { category: attributes_for(:category) } }

    it "creates a new category" do
        expect { subject }.to change(Category, :count).by(1)
    end

    it "redirect to categories#index" do
        expect(subject).to redirect_to(Category)
    end
  end

  describe 'DELETE #destroy' do
    before { @categories = create_list(:category, 3) }
    subject { delete :destroy, params: { id: @categories[1] }}

    it 'deletes the category' do
      expect { subject }.to change(Category, :count).by(-1)
    end

    it "redirects to categories#index" do
      subject
      expect(subject).to redirect_to(Category)
    end
  end
end