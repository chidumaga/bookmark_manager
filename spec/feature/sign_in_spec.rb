feature "User can sign in" do
  before(:each) do
    User.create(name: "john", email: "john@john", password: "123", password_confirmation: "123")
  end
  scenario "user can sign in" do
    visit '/'
    expect(page).not_to have_content("Welcome, john@john")
    sign_in("john@john", "123")
    expect(page).to have_content("Welcome, john@john")
  end

  def sign_in(email, password)
  visit '/sessions/new'
  within('#sign-in') do
    fill_in 'email', with: email
    fill_in 'password', with: password
    click_button 'Sign in'
  end
end
end

