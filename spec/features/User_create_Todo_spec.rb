require 'rails_helper'

include Warden::Test::Helpers
Warden.test_mode!

describe 'Signing process' do

  it "lets user sign up" do
      # Go to home page
      visit root_path

      # Click the sign up button/link
      within '.user-info' do
        click_link 'Sign Up'
      end

      #fill in the sign up information
      fill_in 'Name', with: "John Smith"
      fill_in 'Email', with: "john_smith@example.com"
      fill_in 'Password', with: "helloworld"
      fill_in 'Password confirmation', with: "helloworld"

      #Click sign up button
      click_button 'Sign up'

      #Check email confirmation
      expect(page).to have_content("A message with a confirmation link has been sent to your email address.")

      #click email confirmation link

      #see the flash message for sign up confirmation

      #try to sign in

      #check the flash message and user name after signed in

  end

  it "lets user sign in and sign out" do
    

      #Go to home page
      user = create(:user)
      visit root_path

      #Click sign in link
      within '.user-info' do
        click_link 'Sign In'
      end

      #fill in details
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password

      #click sign in button
      click_button 'Log in'
      
      #check that user has been signed in
      expect(page).to have_content("Signed in successfully.")
      
      #click sign out button
      within '.user-info' do
        click_link 'Sign out'
      end
      

      # check that user has been signed out
      expect(page).to have_content("Signed out successfully.")

    end
end


describe 'Create and mark to do list', focus: true do
  it "lets user create to-do list" do

      #Go to home page
      user = create(:user)
      visit root_path
      
      #Click sign in link
      within '.user-info' do
        click_link 'Sign In'
      end

      #fill in details
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password

      # #click sign in button
      click_button 'Log in'

      #user create a new todo item
        fill_in 'Enter todo item', with: "Go to market"

      #user click the create button
      click_button 'Create'

      #check that the new todo item has been created
      expect(page).to have_content("Todo was saved.")

      #user create a another new todo item
      fill_in 'Enter todo item', with: "Another market"

      #user click the create button
      click_button 'Create'

      #check that the new todo item has been created
      expect(page).to have_content("Todo was saved.")
      
  
      #user mark first todo item as completed
      page.check('todo_1')

      #user mark second todo item as completed
      page.check('todo_2')

      #user click "delete completed" button
      click_button 'Delete completed'

      #check that the marked completed todo items have been deleted
      expect(page).to have_no_content("Go to market")
      expect(page).to have_no_content("Another market")

  end
end

describe 'custom-rake' do
  it "lets user see how many days are left" do
    
  end

  it "checks to-do items automatically deleted after 7 days" do
    
  end

end
