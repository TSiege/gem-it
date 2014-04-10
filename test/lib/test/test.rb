
module Test
  
  class Magic

    attr_accessor :source  

    def initialize(source) 
      @source = source
    end

    def call
      doc = Nokogiri::HTML(open(self.source))
      result = doc.xpath('id("cColumnTopSpanRegion")/div[1]/div[1]/div[1]/div[2]/div[1]/div[1]/h5[1]/a[1]').text
      if result.empty?
        result = doc.xpath('id("cColumnTopSpanRegion")/div[1]/div[1]/div[1]/div[2]/div[1]/div[1]/h5[1]/a[1]').text
      end
      Info.new(result)
    end
  end

end

