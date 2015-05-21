require 'capybara/rspec'

feature 'filtering through tags' do
  before(:each) do
    Link.create(title: 'Code', url: 'http://code.org', tags: [Tag.first_or_create(text: 'education')])
    Link.create(title: 'Football', url: 'http://premierleague.com', tags: [Tag.first_or_create(text: 'football')])
  end

  scenario 'users can filter through tags' do
    visit '/tags/education'
    expect(page).to have_content('Code')
    expect(page).not_to have_content('Football')
  end
end
