feature 'User signs in' do
  scenario 'when entering the site' do
    expect { sign_up }.to change(User, :count).by(1)
    expect(page).to have_content('Welcome, chidu@chidu.com')
    expect(User.first.email).to eq('chidu@chidu.com')
  end

  scenario 'user fills in wrong password' do
    expect { sign_up 'j@j.com', 'hey123', 'hey124' }.to change(User, :count).by(0)
    expect(current_path).to eq('/users')
    expect(page).to have_content("Sorry")
  end

  def sign_up (email = 'chidu@chidu.com', password = 'hey123', password_confirmation = 'hey123')
    visit '/users/new'
    expect(page.status_code).to eq(200)
    fill_in :email, with: email
    fill_in :password, with: password
    fill_in :password_confirmation, with: password_confirmation
    click_button 'Sign up'
  end
end