require_relative 'lib/hiking_project_cli/version'

Gem::Specification.new do |spec|
  spec.name          = "hiking_project_cli"
  spec.version       = HikingProjectCli::VERSION
  spec.authors       = ["Will Carter"]
  spec.email         = ["will.carter@fergusllc.com"]

  spec.summary       = %q{Shows hiking trails based on Hiking Project API}
  spec.description   = %q{Shows hiking trails based on Hiking Project API: https://www.hikingproject.com/data}
  spec.homepage      = "https://github.com/FergusDevelopmentLLC/hiking_project_cli"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["allowed_push_host"] = "https://rubygems.org"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/FergusDevelopmentLLC/hiking_project_cli"
  spec.metadata["changelog_uri"] = "https://github.com/FergusDevelopmentLLC/hiking_project_cli/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  # spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  
  spec.bindir = "bin"
  spec.executables = ["hiking_project_cli"]

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "dotenv"

  spec.add_dependency "json"
  spec.add_dependency "nokogiri"

end
