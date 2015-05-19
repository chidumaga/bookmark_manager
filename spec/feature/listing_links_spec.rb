require 'capybara/rspec'

feature "Listing links" do

  before(:each) do
    Link.create(title: "Google", url: "http://google.com")
  end

  scenario "User can see all links listed on the homepage" do
    visit '/'
    expect(page).to have_content("Google")
  end
end