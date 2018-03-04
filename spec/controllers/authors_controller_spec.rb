require 'rails_helper'

RSpec.describe AuthorsController, type: :controller do
  before do 
    sign_in create(:super_admin)
  end

  describe "GET #index" do
    before { @authors = create_list(:author, 3) }
    it "assigns array of authors to @authors" do
       get :index
       expect(assigns(:authors)).to eq(@authors)
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end
  end

  describe "GET #show" do
    before { @author = create(:author) }
    subject { get :show, params: { id: @author } }
    it "assigns the requested author to @author" do
      subject
      expect(assigns(:author)).to eq(@author)
    end

    it "renders the show template" do
      subject
      expect(response).to render_template("show")
    end
  end

  describe "GET #new" do
    it "assign a new instance of Author class to @author" do
      get :new
      expect(assigns(:author).instance_of?(Author)).to be_truthy
    end

    it "renders the new template" do
      get :new
      expect(response).to render_template("new")
    end
  end

  describe "GET #edit" do
    before { @author = create(:author) }
    subject { get :edit, params: { id: @author } }

    it "assigns the requested author to @author" do
      subject
      expect(assigns(:author)).to eq(@author)
    end

    it "renders the edit template" do
      subject
      expect(response).to render_template("edit")
    end
  end

  describe "POST #create" do
    subject { post :create, params: { author: attributes_for(:author) } }

    it "creates a new author" do
        expect { subject }.to change(Author, :count).by(1)
    end

    it "redirect to authors#index" do
        expect(subject).to redirect_to(Author)
    end
  end

  describe "POST #update" do
    before { @author = create(:author) }
    subject { put :update, params: { id: @author, author: attributes_for(:author, name: 'Jane Roe', bio: 'Born') } }

    it "changes @author attributes" do
        subject
        @author.reload
        expect(@author.name).to eq('Jane Roe')
        expect(@author.bio).to eq('Born')
    end

    it "redirect to updated @author" do
        expect(subject).to redirect_to(@author) 
    end
  end

  describe 'DELETE #destroy' do
    before { @author = create(:author) }
    subject { delete :destroy, params: { id: @author }}

    it 'deletes the @author' do
      expect { subject }.to change(Author, :count).by(-1)
    end

    it "redirects to authors#index" do
      subject
      expect(subject).to redirect_to(Author)
    end
  end
end