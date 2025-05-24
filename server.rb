require 'dotenv'
Dotenv.load

require 'sinatra'
require 'mini_magick'
require 'down'
require 'json'
require 'haml'
require_relative 'movies'
require_relative 'posters'

include Movies
include Posters

get '/' do
  haml :index
end

get '/search' do
  query = params['movie']
  results = Movies.search(query)

  haml :search, locals: { results: results }
end

get '/movie/:id' do
  posters = Movies.get_posters(params[:id])

  haml :movie, locals: { posters: posters }
end

get '/poster' do
  type = params['type']
  poster = params['poster']

  new_poster = Posters.create(type, poster)
  new_poster_path = new_poster.slice!(6, 100)

  haml :poster, locals: { poster: new_poster_path }
end
