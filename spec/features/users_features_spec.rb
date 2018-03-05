require 'rails_helper'

feature 'Access to users', type: :feature do
  before do 
    @user_super=create(:super_admin)
    visit root_path
  end

  context 'when Visitor is logged in without super_admin role' do
    before do
      @user_book=create(:books_admin)
      click_link 'Log In'
      fill_in 'Username', with: @user_book.username
      fill_in 'Password', with: @user_book.password
      click_button 'Log in'
      click_link 'Users'
    end

    scenario 'Visitor cannot viewing users info' do
      expect(page).to_not have_content 'Index of users'
      expect(page).to have_content 'You are not authorized to access this page'
    end
  end

  context 'when Visitor is logged in with super_admin role' do
    before do
      click_link 'Log In'
      fill_in 'Username', with: @user_super.username
      fill_in 'Password', with: @user_super.password
      click_button 'Log in'
      click_link 'Users'
    end

    scenario 'Visitor is viewing users index' do
      expect(page).to have_content 'Index of users'
      expect(page).to have_css('.user', count: 1)
    end

    scenario 'Visitor can change users roles' do
      expect(page).to have_unchecked_field('user_admin_books_role')
      first('#user_admin_books_role').click
      first('.update-role').click
      expect(page).to have_checked_field('user_admin_books_role')
    end

    scenario 'Visitor can add a user' do
      expect(page).to have_css('.user', count: 1)
      click_link 'New user'
      fill_in 'Username', with: attributes_for(:books_admin)[:username]
      fill_in 'Email', with: attributes_for(:books_admin)[:email]
      fill_in 'Password', with: attributes_for(:books_admin)[:password]
      fill_in 'Password confirmation', with: attributes_for(:books_admin)[:password]
      click_button 'Sign up'
      click_link 'Users'
      expect(page).to have_css('.user', count: 2)
    end

    scenario 'Visitor can delete a user ' do
      @user_book=create(:books_admin)
      click_link 'Users'
      expect(page).to have_css('.user', count: 2)
      first(:link, 'Delete').click
      expect(page).to have_css('.user', count: 1)
    end

    scenario 'Visitor can not delete a last superadmin user ' do
      first(:link, 'Delete').click
      expect(page).to have_content 'Unable delete last superadmin'
      expect(page).to have_css('.user', count: 1)
    end
  end
end
