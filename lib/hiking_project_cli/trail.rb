class HikingProjectCli::Trail

    attr_accessor :name, :length, :summary, :location, :difficulty, :stars, :ascent, :descent, :high, :low, :conditionStatus, :conditionDetails, :conditionDate, :url, :features, :overview, :description
  
    @@all = []
  
    def initialize(trail_hash)
        trail_hash.each {|key, value| self.send(("#{key}="), value)}
        @@all << self
    end
  
    def self.create_from_collection(trails_array)
        trails_array.each {|trail|
            HikingProjectCli::Trail.new(trail)
        }
    end
  
    def add_full_details(details_hash)
        details_hash.each {|key, value| self.send(("#{key}="), value)}
        self
    end
  
    def self.all
      @@all
    end

    def self.clear
        @@all = Array.new
    end

    def print_full_description
        puts "-----------------------------------------------"
        puts "#{self.name} (#{self.length} miles)"
        puts ""
        puts "Location: #{self.location}" unless self.location == nil
        puts "Summary: #{self.summary}" unless (self.summary == nil || self.summary == "Needs Summary" || self.summary == "")
        puts "Difficulty: #{self.difficulty}" unless self.difficulty == nil
        puts "Stars: #{self.stars}" unless self.stars == nil
        puts "Ascent: #{self.ascent}" unless self.ascent == nil
        puts "Descent: #{self.descent}" unless self.descent == nil
        puts "High: #{self.high}" unless self.high == nil
        puts "Low: #{self.low}" unless self.low == nil
        puts "Condition Status: #{self.conditionStatus}" unless (self.conditionStatus == nil || self.conditionStatus == "Unknown")
        puts "Condition Details: #{self.conditionDetails}" unless self.conditionDetails == nil
        puts "Condition Date: #{self.conditionDate}" unless (self.conditionDate == nil || self.conditionDate == "1970-01-01 00:00:00")
        
        puts "" unless (self.features == nil || self.features == "-none-")
        puts "Features:" unless (self.features == nil || self.features == "-none-")
        puts "#{self.features}" unless (self.features == nil || self.features == "-none-")

        puts "" unless self.overview == nil
        puts "Overview:" unless self.overview == nil
        puts "#{self.overview}" unless self.overview == nil
        
        puts "" unless self.description == nil
        puts "Description:" unless self.description == nil
        puts "#{self.description}" unless self.description == nil
        puts ""
        puts "-----------------------------------------------"
    end
  end