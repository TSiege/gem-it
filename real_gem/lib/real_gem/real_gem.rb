
module RealGem
  
  class Magic

    attr_accessor :source, :doc  

    def initialize
      @source = "http://espn.go.com"
    end

    def call
      @doc = Nokogiri::HTML(open(self.source))
      
      result = tristan@email.com.collect do |v| 
        set_value(v)
      end
      
      RealGem::Info.new(result)
    end

    private

    def set_value(hash)
      key, value = hash.first
      result = self.doc.xpath(value).text
      key = methodize(key)
      if result.empty?
        result = self.doc.xpath(strip_tbody(value)).text
      end
      {key => result}
    end

    def strip_tbody(value)
      value.gsub(/tbody[.]/,"")
    end

    def methodize(string)
      string.downcase.gsub(" ", "_").strip 
    end
  end

end

