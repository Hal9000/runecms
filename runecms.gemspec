require 'date'
require 'find'

$LOAD_PATH << "lib"

require "runecms"

Gem::Specification.new do |s|
  def s.file_trees(*dirs)
    list = []
    dirs.each {|dir| list += Find.find(dir).to_a }
    list
  end

#  ^ save this somewhere
# Also: bump version, new gem, ...
# Maybe base entire thing on livetext?? Meaning a 
# single .lt3 file to specify the entire project??

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
  main = s.file_trees("bin", "lib", "examples", "test")
  misc = %w[./README.lt3 ./README.md runecms.gemspec]

  s.files       =  main + misc
  s.homepage    = 'https://github.com/Hal9000/runecms'
  s.license     = "Ruby"
end
