feature "while signed in homie can sign out" do
  before(:each) do
    User.create(name: "john", email: "john@john", password: "123", password_confirmation: "123")
  end
  scenario "homie can sign out" do
    sign_in("john@john", "123")
    expect(page).to have_content("Goodbye")
    expect(page).not_to have_content("Welcome")
  end