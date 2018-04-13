require 'sinatra/base'
require './lib/bookmark'
require 'sinatra/flash'

class BookmarkManager < Sinatra::Base

  register Sinatra::Flash
  enable :sessions

  get '/' do
    'Hello World'
  end

  post '/bookmarks' do
    p params
    flash[:message] = Bookmark.create(params)
    redirect '/bookmarks'
  end

  get '/bookmarks' do
    @bookmarks = Bookmark.all
    @urls = Bookmark.display
    erb :index
  end

  get '/bookmarks/new' do
    erb :"bookmarks/new"
  end

  post '/bookmarks/new' do
    erb :"bookmarks/new"
    redirect '/bookmarks'

  end

  post '/bookmarks/delete' do
    p params
    Bookmark.delete(params.key('Delete'))
    redirect '/bookmarks'
  end

  run! if app_file == $PROGRAM_NAME
end
