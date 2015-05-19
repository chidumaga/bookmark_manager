feature 'User signs in' do
  scenario 'when entering the site' do
    expect { sign_up }.to change(User, :count).by(1)
    expect(page).to have_content('Welcome, chidu@chidu.com')
    expect(User.first.email).to eq('chidu@chidu.com')
  end

  def sign_up (email = 'chidu@chidu.com', password = 'hey123')
    visit '/users/new'
    expect(page.status_code).to eq(200)
    fill_in :email, with: email
    fill_in :password, with: password
    click_button 'Sign up'
  end
end