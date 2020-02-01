class HikingProjectCli::Trail

    attr_accessor :name, :length, :summary
  
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

  end