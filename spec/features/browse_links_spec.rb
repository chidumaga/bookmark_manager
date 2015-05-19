require 'capybara/rspec'

feature 'user browses links' do

  scenario 'when opening the home page' do
    visit '/'
  end

  scenario 'I can add a new link' do
    expect(Link.count).to eq(0)
    visit '/'
    add_link('Github', 'http://github.com')
    expect(Link.count).to eq(1)
    link = Link.first
    expect(link.title).to eq('Github')
    expect(link.url).to eq('http://github.com')
  end

  scenario 'with a few tags' do
    visit '/'
    add_link('BBC', 'http://bbc.co.uk', %w(news information))
    link = Link.first
    expect(link.tags.map(&:text)).to include('news', 'information')
  end

  def add_link title, url, tags=[]
    within('#new-link') do
      fill_in 'url', with: url
      fill_in 'title', with: title

      fill_in 'tags', with: tags.join(' ')
      click_button 'Add link'
    end

  end

end
