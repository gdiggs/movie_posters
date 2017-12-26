# Module for manipulating posters
module Posters
  def create(type, poster)
    filename = File.basename poster, '.jpg'

    case type
    when 'bluray'
      create_bluray(filename)
    when '4k'
      puts '4K Ultra HD'
    else
      puts 'Wrong type passed'
    end
  end

  def create_bluray(filename)
    if not File.file?("public/#{filename}_bluray.jpg")
      temp_poster = Down.download("https://image.tmdb.org/t/p/w500/#{filename}.jpg")

      first_image  = MiniMagick::Image.new(temp_poster.path)
      second_image = MiniMagick::Image.new('img/bluray.png')
      result = first_image.composite(second_image) do |c|
        c.compose 'Over'
        c.geometry '100%'
      end

      result.write "public/#{filename}_bluray.jpg"
    else
      "public/#{filename}_bluray.jpg"
    end
  end
end
