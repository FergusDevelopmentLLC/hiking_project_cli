class HikingProjectCli::CLI

    def call
        #welcome message to the user
        puts "Welcome to the Hiking Project CLI"
        puts "---------------------------------"
        puts "Hiking Project API: https://www.hikingproject.com/data"
        puts "Find hiking trails based on a latitude, longitude."
        puts ""
        puts "To find your coordinates:"
        puts "1. On your computer, open Google Maps (https://www.google.com/maps)."
        puts "2. Right-click the place or area on the map."
        puts "3. Select What's here?"
        puts "4. At the bottom, you’ll see a card with the coordinates."
        puts "5. Copy and paste those coordinates below."
        puts ""
        puts "Here are some example coordinates:"
        puts "Denver, CO: 39.74, -104.96"
        puts "Chicago, IL: 41.83, -87.64"
        puts "New York, NY: 40.73, -73.99"
        puts "San Francisco, CA: 37.75, -122.44"
        puts ""
        get_coordinates
    end

    def get_coordinates
        #get coordinates from user
        puts "Please enter your latitude, longitude:"

        coord_input = "" 
        while coord_input == "" || HikingProjectCli::CLI.is_coord_valid(coord_input) == false
            coord_input = gets.strip
            if(coord_input == "exit")
                goodbye
            end
            puts "Invalid coordinates. Please enter a valid latitude, longitude within the United States." unless HikingProjectCli::CLI.is_coord_valid(coord_input)
        end
        
        @coords = coord_input

        #they could be restarting, clear the trails array
        HikingProjectCli::Trail.clear()
        
        list_trails
    end

    def self.is_coord_valid(coord_input)
        if coord_input.match(/\A([-]?[1-9]+|[-]?[1-9]+\d*|[-]?[1-9]+\d*\.\d+),[\s]?([-]?[1-9]+|[-]?[1-9]+\d*|[-]?[1-9]+\d*\.\d+)\z/)
            #split coord_input into array
            coord_input = coord_input.gsub(" ", "")
            coord_input_array = coord_input.split(",")
            
            #source of usa bounding box coords: https://gist.github.com/graydon/11198540
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
            HikingProjectCli::Trail.create_from_collection(trail_hashes_from_api)
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
        # valid inputs: any from the list or list, restart, exit

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
        puts "-----------------------------------------------"
        puts "Thank you for using the Hiking Project CLI"
        exit!
    end
end