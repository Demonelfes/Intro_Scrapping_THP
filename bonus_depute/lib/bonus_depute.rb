require "rubygems"
require "open-uri"
require "nokogiri"
require "watir"
require "selenium-webdriver"
require "webdrivers"

def get_depute_mails(annuaire)
  all_urls = annuaire.xpath('//*[@id="deputes-list"]/div[*]/ul[*]/li[*]/a')
  name_depute = []
  first_names = []
  last_names = []
  suffix_email = "@assemblee-nationale.fr"
  depute_emails = []

  all_urls.each do |elem|
    name = elem.text.strip
    url_depute = elem.attr("href") #scrap urls
    name_depute << name
  end

  name_depute.each do |name|
    parts = name.split(" ")
    first_names << parts[1]
    last_names << parts[2..parts.length].join("")
    depute_emails << "#{parts[1]}.#{parts[2..parts.length].join("")}#{suffix_email}" #parts[2..parts.length].join("") sert a recomposer les nom composer
  end
  liste_depute = first_names.zip(last_names, depute_emails)
  annuaire_depute = []
  liste_depute.each do |elem|
    hash = {
      "First Name" => elem[0],
      "Last_name" => elem[1],
      "Email" => elem[2]
    }
    annuaire_depute << hash
  end

  return annuaire_depute
end

def perform
  annuaire =
    Nokogiri.HTML(
      URI.open("https://www2.assemblee-nationale.fr/deputes/liste/alphabetique")
    )
  puts get_depute_mails(annuaire).count
end

perform
