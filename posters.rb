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

      first_image  = MiniMagick::Image.new(temp_poster.path)
      second_image = MiniMagick::Image.new('img/bluray.jpg')
      result = first_image.composite(second_image) do |c|
        c.compose 'Over'
        c.geometry '100%'
      end

      result.write "public/#{filename}_bluray.jpg"
    end

    "public/#{filename}_bluray.jpg"
  end

  def create_4k(filename)
    unless File.file?("public/#{filename}_4k.jpg")
      temp_poster = Down.download("https://image.tmdb.org/t/p/w500/#{filename}.jpg")

      first_image  = MiniMagick::Image.new(temp_poster.path)
      second_image = MiniMagick::Image.new('img/4k.jpg')
      result = first_image.composite(second_image) do |c|
        c.compose 'Over'
        c.geometry '100%'
      end

      result.write "public/#{filename}_4k.jpg"
    end

    "public/#{filename}_4k.jpg"
  end
end
