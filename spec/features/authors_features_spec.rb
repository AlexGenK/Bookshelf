require 'rails_helper'

feature 'Access to authors', type: :feature do
  before do 
    @author = create(:author)
    @book = create(:book)
    visit root_path
  end

  context 'when Visitor is logged in' do
    before do
      @user=create(:books_admin)
      click_link 'Log In'
      fill_in 'Username', with: @user.username
      fill_in 'Password', with: @user.password
      click_button 'Log in'
      click_link 'Authors'
    end

    scenario 'Visitor is viewing authors index' do
      expect(page).to have_content 'Index of authors'
      expect(page).to have_css('.list-group-item', count: 2)
    end

    scenario 'Visitor can viewing an author information' do
      click_link @book.authors[0].name
      expect(page).to have_content @book.authors[0].name
      expect(page).to have_css('.list-group-item', count: 1)
    end

    scenario 'Visitor can edit an author' do
      click_link @author.name
      click_link 'Edit'
      fill_in 'Bio', with: 'Bla bla bla'
      click_button 'Update Author'
      expect(page).to have_content @author.name
      expect(page).to have_content 'Bla bla bla'
    end

    scenario 'Visitor can add an author' do
      click_link 'Add author'
      fill_in 'Name', with: 'John Doe'
      fill_in 'Bio', with: 'Bla bla bla'
      click_button 'Create Author'
      expect(page).to have_css('.list-group-item', count: 3)
      expect(page).to have_content 'John Doe'
    end

    scenario 'Visitor can delete an author' do
      click_link @author.name
      click_link 'Delete'
      expect(page).to_not have_content @author.name
      expect(page).to have_css('.list-group-item', count: 1)
    end
  end
end
