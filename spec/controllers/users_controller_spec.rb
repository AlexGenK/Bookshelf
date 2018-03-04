require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  before do
    @superadmin = create(:super_admin)
    @booksadmin = create(:books_admin)
    sign_in @superadmin
  end

  describe "GET #index" do
    it "assigns array of users to @users" do
       get :index
       expect(assigns(:users)).to eq([@booksadmin, @superadmin])
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end
  end

  describe "POST #update" do
    subject { put :update, params: { id: @booksadmin, user: attributes_for(:books_admin, superadmin_role: true) } }

    it "changes @user attributes" do
        subject
        @booksadmin.reload
        expect(@booksadmin.superadmin_role).to eq(true)
    end

    it "redirect to users#index" do
        expect(subject).to redirect_to(User) 
    end
  end

  describe 'DELETE #destroy' do
    subject { delete :destroy, params: { id: @booksadmin }}

    it 'deletes the @booksadmin' do
      expect { subject }.to change(User, :count).by(-1)
    end

    it "redirects to authors#index" do
      expect(subject).to redirect_to(User)
    end
  end
end