require 'net/http'
require 'json'
require 'open-uri'
require 'nokogiri'
require 'dotenv/load'

require_relative "hiking_project_cli/version"
require_relative "hiking_project_cli/cli"
require_relative "hiking_project_cli/scraper"
require_relative "hiking_project_cli/trail"

module HikingProjectCli
  class Error < StandardError; end
  # Your code goes here...
end
