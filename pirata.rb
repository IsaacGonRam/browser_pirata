require 'Nokogiri'
require 'net/https'


class Page
  def initialize(link)
    @print_link = link
    @link = Net::HTTP.get_response(URI(link))
    @link = @link.body
    @url = Nokogiri::HTML(@link)

  end

  def fetch!
    puts "url> #{@print_link}"
    puts "Fetching......"
    puts "Titulo: #{title}" 
    links
    puts "Links:"
    for i in 0..(@texto.size) -1
      puts "  #{@texto[i]}  #{@href[i]}"
    end
    puts "..."
    puts "url>"
  end

  def links
    @texto = []
    @href = []
    aux = 0
    all_links = @url.css('.nav-item')
    all_links.each do |link|
      @href << link.css('a')[aux]['href']
      @texto << link.css('a').inner_text
    end
    @texto.shift(2)
    @href.shift(2)
    
  end

  def title
    titulo = @url.css('title').inner_text
  end
end

class Browser
  def run!(link)
    page = Page.new(link).fetch!
  end
end


link = ARGV[0]
#page = Page.new(link).fetch!
browser = Browser.new.run!(link)



