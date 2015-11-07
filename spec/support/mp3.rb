mp3_file = Rails.root.join('spec/fixtures/1984-01_64kb.mp3')

unless File.exist?(mp3_file)
  require 'open-uri'
  File.open(mp3_file, 'wb') do |saved_file|
    puts 'Downloading mp3 audiobook ...'
    open(
      'https://archive.org/download/George-Orwell-1984-Audio-book/1984-01_64kb.mp3',
      'rb'
    ) do |read_file|
      saved_file.write(read_file.read)
    end
  end
end
