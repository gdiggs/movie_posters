# Module for manipulating posters
module Posters
  def create(type, poster)
    filename = File.basename poster, '.jpg'

    case type
    when 'bluray'
      create_bluray(filename)
    when '4k'
      create_4k(filename)
    else
      puts 'Wrong type passed'
    end
  end

  def create_bluray(filename)
    unless File.file?("public/#{filename}_bluray.jpg")
      temp_poster = Down.download("https://image.tmdb.org/t/p/w500/#{filename}.jpg")

      MiniMagick::Tool::Convert.new do |convert|
        convert << 'img/bluray.jpg'
        convert << temp_poster.path
        convert << '-append'
        convert << 'public/' + filename + '_bluray.jpg'
      end
    end

    "public/#{filename}_bluray.jpg"
  end

  def create_4k(filename)
    unless File.file?("public/#{filename}_4k.jpg")
      temp_poster = Down.download("https://image.tmdb.org/t/p/w500/#{filename}.jpg")

      MiniMagick::Tool::Convert.new do |convert|
        convert << 'img/4k.jpg'
        convert << temp_poster.path
        convert << '-append'
        convert << 'public/' + filename + '_4k.jpg'
      end
    end

    "public/#{filename}_4k.jpg"
  end
end
