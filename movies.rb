# Module for talking to TheMovieDB
module Movies
  require 'themoviedb'

  Tmdb::Api.key(ENV['TMDB'])

  def search(query)
    results = Tmdb::Movie.find(query)

    results.map do |movie|
      {
        title: movie.title,
        release_date: movie.release_date,
        id: movie.id,
        poster_path: movie.poster_path
      }
    end
  end

  def get_posters(id)
    images = Tmdb::Movie.images(id)
    images['posters'].map do |poster|
      poster['file_path']
    end
  end
end
