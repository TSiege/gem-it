
require "open-uri"
require "nokogiri"
Dir[File.dirname(__FILE__) + '/newgem/*.rb'].each do |file|
  require file
end

