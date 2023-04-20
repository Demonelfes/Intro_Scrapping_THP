require "rubygems"
require "open-uri"
require "nokogiri"
require "watir"
require "selenium-webdriver"
require "webdrivers"

def crazy_scrapeur
  browser = Watir::Browser.new :chrome, headless: true
  browser.goto("https://coinmarketcap.com/all/views/all/")

  #Envoie des keys a la page (ici, envoie des spaces pour scroll la page)
  16.times do
    browser.send_keys(:space)
    sleep 0.1
  end

  # Parse la page

  page = Nokogiri::HTML.parse(browser.html)

  all_currencies = page.xpath("//tr[*]/td[3]/div")
  all_values = page.xpath("//tr[*]/td[5]")

  name_array = all_currencies.map { |coin| coin.text }
  value_array =
    all_values.map { |coin| coin.text.gsub("$", "").gsub(",", "").to_f }

  browser.close

  currencies =
    name_array.zip(value_array).map { |name, value| { name => value } }
  return currencies.class
end

def perform
  crazy_scrapeur
end

puts perform
