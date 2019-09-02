require 'httparty'
require 'nokogiri'
require 'byebug'

def scraper 
    url= "https://www.monster.de/jobs/suche/?q=ruby&cy=DE&rad=20&intcid=swoop_HeroSearch_DE&stpage=1&page=5"
    unparsed_page = HTTParty.get(url)
    parsed_page = Nokogiri::HTML(unparsed_page)
    
    jobs = Array.new
    job_listings = parsed_page.css('div.flex-row')
    job_listings.each do |job_listing| 
        job = {
            title: job_listing.css('h2.title').text,
            company: job_listing.css('div.company').text,
            location: job_listing.css('div.location').text,
            url: job_listing.css('a')[0].attributes["href"].value
        }
        jobs << job 
        puts "Added #{job[:title]}"
        puts " "
    end
    byebug
end

scraper

