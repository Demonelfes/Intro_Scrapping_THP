require "rubygems"
require "open-uri"
require "nokogiri"
require "watir"
require "selenium-webdriver"
require "webdrivers"

def get_town_email(townhall_url)
  page = Nokogiri.HTML(URI.open(townhall_url))
  page.xpath("/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]").text
end

def get_town_urls(annuaire)
  each_city_urls = annuaire.xpath('//a[@class="lientxt"]/@href')

  city_name = []
  full_city_urls_array =
    each_city_urls.map do |elem|
      city_name << elem.to_s.sub(%r{\./95\/}, "").sub(/\.html$/, "").upcase
      elem = "http://annuaire-des-mairies.com" + elem.to_s.sub(/./, "")
    end

  mails_array = []
  (full_city_urls_array.count).times do |i|
    mails_array << get_town_email(full_city_urls_array[i])
  end

  final_array_of_hash =
    city_name.zip(mails_array).map { |name, value| { name => value } }

  array_without_empty = mails_array.reject(&:empty?)

  puts "Voici la liste des #{array_without_empty.count} emails de de mairies du Val d'Oise disponibles :\n"
  puts array_without_empty
  puts "#{(mails_array.count - array_without_empty.count)} mairies n'ont pas communique leurs addresses mail."
  return final_array_of_hash
end

def perform
  annuaire =
    Nokogiri.HTML(URI.open("http://annuaire-des-mairies.com/val-d-oise.html"))

  get_town_urls(annuaire)
end

perform
