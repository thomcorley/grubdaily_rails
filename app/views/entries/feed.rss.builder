xml.instruct! :xml, version: "1.0"
xml.rss version: "2.0" do
  xml.channel do
    xml.title "Entry List"
    xml.description "Entry List"
    xml.link "https://www.grubdaily.com"
    @entries.each do |entry|
      xml.item do
        xml.title entry.title
        xml.link "https://www.grubdaily.com#{entry.permalink}"
        xml.description entry.summary
        xml.category "Entry"
        xml.pubDate entry.published_at&.strftime("%a, %e %b %Y %H:%M:%S %z")
      end
    end
  end
end
