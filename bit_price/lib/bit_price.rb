require "open-uri"
require "nokogiri"
Dir[File.dirname(__FILE__) + '/bit_price/*.rb'].each do |file|
  require file
end
