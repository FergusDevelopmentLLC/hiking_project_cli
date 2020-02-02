class HikingProjectCli::Trail

    attr_accessor :name, :length, :summary, :url, :features, :overview, :description
  
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