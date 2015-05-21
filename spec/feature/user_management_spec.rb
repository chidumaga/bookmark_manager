require 'capybara/rspec'

feature 'user management' do
  scenario 'a user can sign up' do
    expect { sign_up }.to change(User, :count).by(1)
    expect(page).to have_content('Welcome, boy@boy.com')
    expect(User.count).to eq(1)
    user = User.first
    expect(user.name).to eq('Boy')
  end

  scenario 'but must enter the same pword twice' do
    expect { sign_up 'girl', 'girl@girl.com', 'justagirl', 'justaboy' }.to change(User, :count).by(0)
    expect(page).to have_content('Password does not match the confirmation')
  end

  scenario 'and can only sign up once' do
    expect { sign_up }.to change(User, :count).by(1)
    expect { sign_up }.to change(User, :count).by(0)
    expect(page).to have_content('This email has been taken')
  end
end

def sign_up(name = 'Boy', email = 'boy@boy.com', password = 'justaboy', password_confirmation = 'justaboy')
  visit '/users/new'
  within('#sign-up') do
    fill_in 'name', with: name
    fill_in 'email', with: email
    fill_in 'password', with: password
    fill_in 'password_confirmation', with: password_confirmation
    click_button 'Add user'
  end
end
