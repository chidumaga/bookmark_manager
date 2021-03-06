require 'sinatra/base'
require 'data_mapper'
require 'rack-flash'

env = ENV['RACK_ENV'] || 'development'

DataMapper.setup(:default, ENV['DATABASE_URL'] || "postgres://localhost/bookmark_manager_#{env}")

require './lib/link'
require './lib/tag'
require './lib/user'

DataMapper.finalize

DataMapper.auto_upgrade!

class BookmarkManager < Sinatra::Base
  enable :sessions
  set :session_secret, 'seekrit'
  use Rack::Flash

  get '/' do
    @links = Link.all
    erb :index
  end

  post '/' do
    tags = params['tags'].split(' ').map do |tag|
      Tag.first_or_create(text: tag)
    end
    Link.create(title: params['title'], url: params['url'], tags: tags)
    redirect to('/')
    erb :index
  end

  get '/tags/:text' do
    tag = Tag.first(text: params[:text])
    @links = tag ? tag.links : []
    erb :index
  end

  get '/users/new' do
    @user = User.new
    erb :users
  end

  post '/users' do
    @user = User.new(name: params[:name], email: params[:email], password: params[:password], password_confirmation: params[:password_confirmation])

    if @user.save
      session[:user_id] = @user.id
      redirect to('/')
    else
      flash.now[:errors] = @user.errors.full_messages
      erb :users
    end
  end

  get '/sessions/new' do
    erb :sessions
  end

  post '/sessions' do
    email, password = params[:email], params[:password]
    user = User.authenticate(email, password)

    if user
      session[:user_id] = user.id
      redirect to('/')
    else
        flash[:errors] = ["please try again"]
      erb :sessions
    end
  end

  helpers do
    def current_user
      @current_user ||= User.get(session[:user_id]) if session[:user_id]
    end
  end

  # start the server if ruby file executed directly
  run! if app_file == $PROGRAM_NAME
end
