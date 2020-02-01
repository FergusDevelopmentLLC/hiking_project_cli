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
        
        #lat,lng
        list_trails(coord_input)
    end

    def list_trails(coords_input)
        coords_input = coords_input.gsub(" ", "")
        coords_array = coords_input.split(",")
        coords_qs = "lat=#{coords_array[0]}&lon=#{coords_array[1]}"
        trail_hashes_from_api = HikingProjectCli::Scraper.get_trails_from_api(coords_qs)
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
            #get selected trail.url
            selected_trail = HikingProjectCli::Trail.all[input.to_i - 1]
            show_full_description(selected_trail)
        end
    end

    def show_full_description(trail)
        #display trail full details
        trail_details_hash = HikingProjectCli::Scraper.scrape_trail_detail(trail.url)
        trail.add_full_details(trail_details_hash)
        puts "-----------------------------------------------"
        puts "Features:"
        puts "#{trail.features}"
        puts ""
        puts "Overview:"
        puts "#{trail.overview}"
        puts ""
        puts "Description:"
        puts "#{trail.description}"
        puts "-----------------------------------------------"
        menu
    end

    def goodbye
        puts "Thank you for using the Hiking Project CLI"
    end
end