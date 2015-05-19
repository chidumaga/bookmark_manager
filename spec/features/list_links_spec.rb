
feature 'user lists links' do
  before(:each) do
    Link.create(url: 'www.google.com',
                title: 'Google',
                tags: [Tag.first_or_create(text: 'search')])
    Link.create(url: 'www.bbc.com',
                title: 'BBC',
                tags: [Tag.first_or_create(text: 'news')])
  end

  scenario 'and sees filtered links' do
    visit '/tags/search'
    expect(page).not_to have_content('BBC')
    expect(page).to have_content('Google')
  end
end