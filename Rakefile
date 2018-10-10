require_relative './config/environment'

def reload!
  load_all './lib'
end

task :console do
  Pry.start
end

task :scrape_rooms do
  houston_scraper = RoomScraper.new('https://houston.craigslist.org/search/roo')
  houston_scraper.call
  dallas_scraper = RoomScraper.new('https://dallas.craigslist.org/search/roo')
  dallas_scraper.call
  Room.all 
end
