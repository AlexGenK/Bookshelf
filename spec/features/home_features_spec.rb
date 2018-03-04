require 'rails_helper'

feature 'View bookshelf', type: :feature do
  before do 
    @category = create(:category)
    @book = create(:book)
    visit root_path
  end

  scenario 'Visitor is viewing bookshelf' do
    expect(page).to have_content @category.name
    expect(page).to have_content @book.category.name
    expect(page).to have_content @book.title
    expect(page).to have_css('.category-card', count: 2)
    expect(page).to have_css('.book-card', count: 1)
  end

  context 'when Visitor is logged out' do
    scenario 'Visitor cannot access to admin area' do
      expect(page).to_not have_content 'Admin area'
    end
  end

  context 'when Visitor is logged in' do
    before do
      @user = create(:super_admin)
      click_link 'Log In'
      fill_in 'Username', with: @user.username
      fill_in 'Password', with: @user.password
      click_button 'Log in'
    end
    
    scenario 'Visitor can access to admin area' do
      expect(page).to have_content 'Admin area'
    end
  end

end
