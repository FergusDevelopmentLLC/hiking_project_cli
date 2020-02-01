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
        #list trails based on user input
        puts "Trails for latitude: x longitude: y"
        puts "-----------------------------------------------"
        puts "1 - Trail A name (xxx miles) - Trail A Summary"
        puts "2 - Trail B name (xxx miles) - Trail A Summary"
        puts "3 - Trail C name (xxx miles) - Trail A Summary"
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