require "scraper/version"
require "open-uri"
require "nokogiri"

class Scraper

  attr_accessor :source  

  def initialize(source) 
    @source = source
  end

  def call
    doc = Nokogiri::HTML(open(self.source))
    result = doc.css('.top-balance > a').text
  end

end
