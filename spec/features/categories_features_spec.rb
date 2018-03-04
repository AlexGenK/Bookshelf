require 'rails_helper'

feature 'Access to categories', type: :feature do
  before do 
    @category = create(:category)
    @book = create(:book)
    visit root_path
  end

  context 'when Visitor is logged in without categories_admin role' do
    before do
      @user=create(:books_admin)
      click_link 'Log In'
      fill_in 'Username', with: @user.username
      fill_in 'Password', with: @user.password
      click_button 'Log in'
      click_link 'Categories'
    end

    scenario 'Visitor cannot viewing categories info' do
      expect(page).to_not have_content 'Index of categories'
      expect(page).to have_content 'You are not authorized to access this page'
    end
  end

  context 'when Visitor is logged in with categories_admin role' do
    before do
      @user=create(:categories_admin)
      click_link 'Log In'
      fill_in 'Username', with: @user.username
      fill_in 'Password', with: @user.password
      click_button 'Log in'
      click_link 'Categories'
    end

    scenario 'Visitor is viewing categories index' do
      expect(page).to have_content 'Index of categories'
      expect(page).to have_css('.category', count: 2)
    end

    scenario 'Visitor can change books category' do
      click_link @book.category.name
      expect(page).to have_content 'List of books'
      expect(page).to have_content @book.title
      expect(page).to have_css('.list-group-item', count: 1)
      select(@category.name, from: 'book[category_id]')
      click_button 'Change category'
      expect(page).to_not have_css('.list-group-item')
      click_link '<< Back'
      click_link @category.name
      expect(page).to have_css('.list-group-item', count: 1)
    end

    scenario 'Visitor can add a category' do
      fill_in 'Category name', with: 'Category X'
      click_button 'Create Category'
      expect(page).to have_css('.category', count: 3)
      expect(page).to have_content 'Category X'
    end

    scenario 'Visitor can delete a category' do
      first(:link, 'Delete').click
      expect(page).to have_css('.category', count: 1)
    end
  end
end
