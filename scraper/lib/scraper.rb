require "open-uri"
require "nokogiri"
Dir[File.dirname(__FILE__) + '/scraper/*.rb'].each do |file|
  require file
end