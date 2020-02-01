require "pry"
class HikingProjectCli::CLI

    def call
        #welcome message to the user
        puts "Welcome to the Hiking Project CLI"
        puts "---------------------------------"
        get_coordinates
    end

    def get_coordinates
        #get coordinates from user
        puts "Please enter your latitude, longitude"

        coord_input = ""
        while coord_input == ""
            coord_input = gets.strip
        end

        list_trails
    end

    def list_trails
        
        trail_hashes_from_api = HikingProjectCli::Scraper.get_trails_from_api
        trails = HikingProjectCli::Trail.create_from_collection(trail_hashes_from_api)
        
        puts "Trails for latitude: x longitude: y"
        puts "-----------------------------------------------"
        HikingProjectCli::Trail.all.each.with_index(1) {|trail, index|
            puts "#{index} - #{trail.name} (#{trail.length.to_s} miles) - #{trail.summary}"
        }
        puts "-----------------------------------------------"
        
        menu
    end

    def menu
        puts "Enter the number of the trail you would like more information on, list to relist, restart, or exit."

        input = ""
        while input == ""
            input = gets.strip
        end
        
        #allows user to relist trails, choose a trail to show detail, restart, or exit
        if input == "restart"
            call
        elsif input == "list"
            list_trails
        elsif input == "exit"
            goodbye
        else
            show_full_description
        end
    end

    def show_full_description
        #display trail full details
        puts "-----------------------------------------------"
        puts "Features: features1 features1 features1"
        puts "Overview: overview1 overview1 overview1"
        puts "Description: description1 description1 description1"
        puts "-----------------------------------------------"
        menu
    end

    def goodbye
        puts "Thank you for using the Hiking Project CLI"
    end
end