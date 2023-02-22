require 'find'

module GemHelper
  def self.file_trees(*dirs)
    list = []
    dirs.each do |dir| 
      stuff = Find.find(dir).to_a 
      list += stuff
    end
    list
  end

  def self.read_spec
    File.readlines("gemdata")
  end
end

#  ^ save this somewhere
# Also: bump version, new gem, ...
# Maybe base entire thing on livetext?? Meaning a 
# single .lt3 file to specify the entire project??

