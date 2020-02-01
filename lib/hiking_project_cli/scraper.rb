class HikingProjectCli::Scraper

    def self.get_trails_from_api
        #returns an array of trail hashes
        trails = []

        trail1 = {}
        trail1[:name] = "Trail A"
        trail1[:length] = 10
        trail1[:summary] = "Trail A summary"
        trails << trail1

        trail2 = {}
        trail2[:name] = "Trail B"
        trail2[:length] = 15
        trail2[:summary] = "Trail B summary"
        trails << trail2

        trail3 = {}
        trail3[:name] = "Trail C"
        trail3[:length] = 25
        trail3[:summary] = "Trail C summary"
        trails << trail3

        trails
    end

    def self.scrape_trail_detail(trail_url)
        #returns a trail detail hash (features, overview, description)
    end

end