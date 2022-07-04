require 'date'
require 'gemhelper'

require_relative "lib/runecms"

Gem::Specification.new do |s|
  system("rm -f *.gem")
  s.name        = 'runecms'
  s.version     = RuneCMS::VERSION
  s.date        = Date.today.strftime("%Y-%m-%d")
  s.summary     = "Simple static website manager"
  s.description = "A simple static website manager based on Livetext (and Ruby)"
  s.authors     = ["Hal Fulton"]
  s.email       = 'rubyhacker@gmail.com'
  s.executables << "rcms"
  
  # Files...
  main = GemHelper.file_trees("bin", "lib", "examples", "test")
  misc = %w[./README.lt3 ./README.md runecms.gemspec]

  s.files       =  main + misc
  s.homepage    = 'https://github.com/Hal9000/runecms'
  s.license     = "Ruby"
  s.post_install_message = "\n  Success! For help, run 'rcms' with no parameters.\n "
end
