module Scraper
  
  class Scrape

    attr_accessor :source  

    def initialize(source) 
      @source = source
    end

    def call
      doc = Nokogiri::HTML(open(self.source))
      result = doc.css('.top-balance > a').text
      Info.new(result)
    end
  end

end
