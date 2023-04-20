require "rubygems"
require "open-uri"
require "nokogiri"

PAGE_URL = "http://www.google.com/search?q=doughnuts"
PAGE_URL2 = "http://ruby.bastardsbook.com/chapters/html-parsing/"

page = Nokogiri.HTML(URI.open(PAGE_URL2))
links = page.css("a")

doc = Nokogiri.HTML(URI.open(PAGE_URL2))
doc.xpath("//h1/*").each { |node| puts node.text }
# doc.css("h3.r > a.l").each { |node| puts node.text }

# puts links.length # => 6
# puts links[0].text # => Click here
# puts links[0]["href"]

# news_links = page.css("a").select { |link| link["data-category"] == "news" }
# news_links.each { |link| puts link["href"] }
