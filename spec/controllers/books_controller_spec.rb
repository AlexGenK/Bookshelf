require 'rails_helper'

RSpec.describe BooksController, type: :controller do
  before do 
    sign_in create(:books_admin)
  end

  describe "GET #index" do
    before { @books = create_list(:book, 3) }
    it "assigns array of books to @books" do
       get :index
       expect(assigns(:books)).to eq(@books)
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end
  end

  describe "GET #new" do
    it "assign a new instance of Book class to new book" do
      get :new
      expect(assigns(:book).instance_of?(Book)).to be_truthy
    end

    it "renders the new template" do
      get :new
      expect(response).to render_template("new")
    end
  end

  describe "GET #edit" do
    before { @book = create(:book) }
    subject { get :edit, params: { id: @book } }

    it "assigns the requested book to @book" do
      subject
      expect(assigns(:book)).to eq(@book)
    end

    it "renders the edit template" do
      subject
      expect(response).to render_template("edit")
    end
  end
  
  describe "POST #create" do
    subject { post :create, params: { book: attributes_for(:book) } }

    it "creates a new book" do
        expect { subject }.to change(Book, :count).by(1)
    end

    it "redirect to books#index" do
        expect(subject).to redirect_to(Book)
    end
  end

  describe "POST #update" do
    before { @book = create(:book) }
    subject { put :update, params: { id: @book, book: attributes_for(:book, title: 'New Book', description: 'Ipsum lorem') } }

    it "changes @book attributes" do
        subject
        @book.reload
        expect(@book.title).to eq('New Book')
        expect(@book.description).to eq('Ipsum lorem')
    end

    it "redirect to books#index" do
        expect(subject).to redirect_to(Book) 
    end
  end

  describe 'DELETE #destroy' do
    before { @book = create(:book) }
    subject { delete :destroy, params: { id: @book }}

    it 'deletes the @book' do
      expect { subject }.to change(Book, :count).by(-1)
    end

    it "redirects to books#index" do
      subject
      expect(subject).to redirect_to(Book)
    end
  end
end