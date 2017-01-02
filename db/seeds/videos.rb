require "nokogiri"


# TODO add TCE video
# TODO add Vimeo videos


# Videos
filepath = File.expand_path("../db/seeds/videos/", __FILE__)

Dir.glob("#{filepath}/*").each do |f|
  path_pieces = f.strip.split("/")
  filename    = path_pieces.last

  unless filename =~ /.DS_Store/
    doc   = File.open(f) { |f| Nokogiri::HTML(f) }

    title        = doc.css(".title").text
    slug         = title.to_slug

    info_pieces = doc.css(".info").text
    quality, year, duration = info_pieces.split(" / ")

    published_at = year
    content      = doc.css(".desc").inner_html.gsub(/\s+/, " ")
    vimeo_id     = doc.css("iframe").attribute("src").value.match(/video\/(\d+)/)[1]

    # Save the Video
    video = Video.create!(
      title:          title,
      subtitle:       nil,
      content:        content,
      tweet:          nil,
      summary:        nil,
      slug:           slug,
      quality:        quality,
      duration:       duration,
      vimeo_id:       vimeo_id,
      published_at:   published_at,
      content_format: "html"
    )

    # TODO
    # ["/texts/#{namespace}/#{slug}", "/texts/#{namespace}/#{slug}/", "/texts/#{namespace}/#{slug}/.index.html"].each do |source_path|
    #   Redirect.create! source_path: source_path, target_path: article.path, temporary: false
    # end
 end
end
