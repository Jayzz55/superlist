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
      expect(unread_emails_for("john_smith@example.com").count).to eq(1)
      open_email("john_smith@example.com")
      click_email_link_matching(/#{user_confirmation_path}/)

      #see the flash message for sign up confirmation
      expect(page).to have_content("Your email address has been successfully confirmed.")

      #try to sign in
      within '.user-info' do
        click_link 'Sign In'
      end

      #fill in details
      fill_in 'Email', with: "john_smith@example.com"
      fill_in 'Password', with: "helloworld"

      #click sign in button
      click_button 'Log in'
      
      #check that user has been signed in
      expect(page).to have_content("Signed in successfully.")
      
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


describe 'Create and mark off to do list' do
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

describe 'custom-rake', focus: true do
  it "checks to-do items automatically deleted after 7 days" do
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
    
      #Time travel to 8 days later
      expect(page).to have_content(7)
      new_time = Time.now + 8.days
      Timecop.travel(new_time)
      click_link 'My List'
      

      #check that the marked completed todo items have been deleted
      expect(page).to have_no_content("Go to market")
      expect(page).to have_no_content("Another market")

    
  end

end
