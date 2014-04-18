class Concerns::IframeContentCreator
  attr_accessor :page, :file, :digest, :doc, :disable_iframe

  def initialize(params)
    @page = params[:website] !~ /http/ ? "http://#{params[:website]}" : params[:website] 
    @doc = open(page)
    @digest = Digest::MD5.hexdigest(page)
    @file = File.new("public/tmp/#{digest}.html", 'w')
  #   @disable_iframe =  <<-EOT
  # <head>
  # <script src="//ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
  #   <script>
  #     function disableIframe() {
  #       $("iframe").contents().find("html").each(function() {
  #         $(this).bind("click", function(e) { 
  #           e.preventDefault();
  #           e.stopPropagation();
  #           console.log("from an iframe within an iframe");
  #         });
  #       });
  #     }
  #   </script>
  #   EOT
  end

  def create_iframe_file
    file.write(content)
    file.close
  end

  def content
    @content = doc.read.gsub(/<script[^>]*>[^<]*<\/script>/, "<script></script>")
    @content = @content.gsub(/<meta[^[Xx]]*[Xx]-[Ff][rame]*[-][Oo][ptions]*[^>]*\/>/, "")
    @content = @content.gsub(/(onload=".*")/, "")
    @content = @content.gsub(/<iframe/, "<video")
    @content = @content.gsub(/<\/iframe>/, "</video>")
    # @content = @content.gsub(/(<head.*>)/, "#{disable_iframe}")
    # @content = @content.gsub(/<iframe/, "<iframe onload='disableIframe()'")
  end
end