require 'rails_helper'

feature 'Access to books', type: :feature do
  before do 
    @book = create(:book)
    @author = create(:author)
    visit root_path
  end

  context 'when Visitor is logged in without books_admin role' do
    before do
      @user=create(:categories_admin)
      click_link 'Log In'
      fill_in 'Username', with: @user.username
      fill_in 'Password', with: @user.password
      click_button 'Log in'
      click_link 'Books'
    end

    scenario 'Visitor cannot viewing books info' do
      expect(page).to_not have_content 'Index of books'
      expect(page).to have_content 'You are not authorized to access this page'
    end
  end

  context 'when Visitor is logged in with books_admin role' do
    before do
      @user=create(:books_admin)
      click_link 'Log In'
      fill_in 'Username', with: @user.username
      fill_in 'Password', with: @user.password
      click_button 'Log in'
      click_link 'Books'
    end

    scenario 'Visitor is viewing books index' do
      expect(page).to have_content 'Index of books'
      expect(page).to have_css('.book', count: 1)
    end

    scenario 'Visitor can add a book' do
      click_link 'New book'
      fill_in 'Title', with: 'Book X'
      fill_in 'Description', with: 'Bla bla bla'
      select(@author.name, from: 'book_author_ids_')
      click_button 'Create Book'
      expect(page).to have_css('.book', count: 2)
      expect(page).to have_content 'Book X'
    end

    scenario 'Visitor can edit a book' do
      click_link 'Edit'
      fill_in 'Title', with: 'Book X'
      click_button 'Update Book'
      expect(page).to have_content 'Book X'
      expect(page).to have_css('.book', count: 1)
    end

    scenario 'Visitor can delete a book' do
      click_link 'Delete'
      expect(page).to_not have_content @book.title
      expect(page).to_not have_css('.book')
    end
  end
end
