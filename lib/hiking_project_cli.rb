require 'dotenv/load'

require "./lib/hiking_project_cli/version"
require "./lib/hiking_project_cli/cli"
require "./lib/hiking_project_cli/scraper"
require "./lib/hiking_project_cli/trail"

module HikingProjectCli
  class Error < StandardError; end
  # Your code goes here...
end
