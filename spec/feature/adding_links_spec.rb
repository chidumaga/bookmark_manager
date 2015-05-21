require 'capybara/rspec'

feature 'Bookmark manager' do
  scenario 'User can add links to the site homepage' do
    expect(Link.count).to eq(0)
    add_link('Google', 'http://google.com')
    link = Link.first
    expect(link.url).to eq('http://google.com')
    expect(link.title).to eq('Google')
  end

  scenario 'with tags' do
    expect(Link.count).to eq(0)
    add_link('Brap', 'brap.co', %w(trap hood))
    expect(Link.count).to eq(1)
    link = Link.first
    expect(link.tags.map(&:text)).to include('trap', 'hood')
  end

  def add_link(title, url, tags = [])
    visit '/'
    within('#add-link') do
      fill_in 'title', with: title
      fill_in 'url', with: url
      fill_in 'tags', with: tags.join(' ')
    end
    click_button 'Add link'
  end
end
