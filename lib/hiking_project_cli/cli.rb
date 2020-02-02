require "pry"
class HikingProjectCli::CLI


    def call
        #welcome message to the user
        puts "Welcome to the Hiking Project CLI"
        puts "---------------------------------"
        # puts "Orlando: 28.533819, -81.316097"
        # puts "only 3: 28.539358, -81.39"
        get_coordinates
    end

    def get_coordinates
        #get coordinates from user
        puts "Please enter your latitude, longitude"

        coord_input = "" 
        while coord_input == "" || HikingProjectCli::CLI.is_coord_valid(coord_input) == false
            coord_input = gets.strip
            if(coord_input == "exit")
                goodbye
            end
            puts "Invalid coordinates. Please enter a valid latitude, longitude within the United States." unless HikingProjectCli::CLI.is_coord_valid(coord_input)
        end
        
        @coords = coord_input

        HikingProjectCli::Trail.clear()
        list_trails
    end

    def self.is_coord_valid(coord_input)
        if coord_input.match(/\A([-]?[1-9]+|[-]?[1-9]+\d*|[-]?[1-9]+\d*\.\d+),[\s]?([-]?[1-9]+|[-]?[1-9]+\d*|[-]?[1-9]+\d*\.\d+)\z/)
            #split coord_input into array
            coord_input = coord_input.gsub(" ", "")
            coord_input_array = coord_input.split(",")
            if(coord_input_array[0].to_f.between?(18.91619, 71.3577635769) && coord_input_array[1].to_f.between?(-171.791110603, -66.96466)) 
                true
            else
                false
            end
        else
            false
        end
    end

    def list_trails
        @coords = @coords.gsub(" ", "")
        coords_array = @coords.split(",")
        coords_qs = "lat=#{coords_array[0]}&lon=#{coords_array[1]}"
        
        if HikingProjectCli::Trail.all.length == 0
            trail_hashes_from_api = HikingProjectCli::Scraper.get_trails_from_api(coords_qs)
            trails = HikingProjectCli::Trail.create_from_collection(trail_hashes_from_api)
        end
        
        puts "Trails for latitude: #{coords_array[0]} longitude: #{coords_array[1]}"
        puts "-----------------------------------------------"
        if(HikingProjectCli::Trail.all.length > 0)
            HikingProjectCli::Trail.all.each.with_index(1) {|trail, index|
                puts "#{index} - #{trail.print_summary}"
            }
        else
            puts "No trails found for those coordinates."
        end
        puts "-----------------------------------------------"
        
        menu
    end

    def menu
        # valid inputs
        # any from the list
        # or
        # list, restart, exit

        valid_inputs = HikingProjectCli::Trail.all.each.with_index(1).map {|trail, index| index.to_s}
        valid_inputs = valid_inputs.concat ["restart", "list", "exit"]

        puts "Enter the number of the trail you would like more information on, list to relist, restart, or exit."

        input = ""
        while input == "" || valid_inputs.include?(input) == false
            input = gets.strip
            puts "Invalid entry, please enter the number of the trail, list to relist, restart or exit." unless valid_inputs.include?(input)
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
        trail.print_full_description
        menu
    end

    def goodbye
        puts "Thank you for using the Hiking Project CLI"
        exit!
    end
end