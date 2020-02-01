require 'net/http'
require 'json'

class HikingProjectCli::Scraper

    def self.get_trails_from_api
        
        #returns an array of trail hashes
        url = "https://www.hikingproject.com/data/get-trails?lat=40.0274&lon=-105.2519&maxDistance=10&key=#{ENV['HIKINGPROJECT_API_KEY']}"
        uri = URI(url)
        response = Net::HTTP.get(uri)
        api_trails = JSON.parse(response)

        api_trails["trails"].map {|trail|
            {
                :name => trail["name"],
                :length => trail["length"],
                :summary => trail["summary"],
                :url => trail["url"]
            }   
        }
    end

    def self.scrape_trail_detail(trail_url)
        #returns a trail detail hash (features, overview, description)
        trail_details_hash = {}
        trail_details_hash[:features] = "features features features y"
        trail_details_hash[:overview] = "overview overview overview y"
        trail_details_hash[:description] = "description description description y"
        trail_details_hash
    end

end