describe Link do

  context 'This is just a demo of how DataMapper (a sexy ORM) works' do

    it 'can count the number of columns in an exisiting table' do
      expect(Link.count).to eq(0)
    end

    it 'can create and populate a new column in the table' do
      Link.create(title: "Github",
                  url: "http://github.com")
      expect(Link.count).to eq(1)
    end
  end
end