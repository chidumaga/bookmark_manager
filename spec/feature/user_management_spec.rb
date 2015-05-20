require 'capybara/rspec'

feature "user management" do
  scenario "a user can sign up" do
    expect { sign_up }.to change(User, :count).by(1)
    expect(page).to have_content("Welcome, boy@boy.com")
    expect(User.count).to eq(1)
    user = User.first
    expect(user.name).to eq("Boy")
  end
end

def sign_up name="Boy", email="boy@boy.com"
  visit '/users/new'
  within("#sign-up") do
      fill_in 'name', :with => name
      fill_in 'email', :with => email
      click_button "Add user"
    end
end

