module GemifierHelper
  def remove_public(string)
    string.gsub("public/", "")
  end
end
