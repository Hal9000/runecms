
require 'find'

CONFIG = "config.txt"

def run_version
  puts RuneCMS::VERSION
end

def run_check
  stale = stale_files("source")
  if stale.empty? 
    puts "No stale files"
  else
    puts "Stale files:"
    stale.each {|x| puts "  " + x }
    puts
  end
end

def run_config
  unless read_config
    File.open("config.txt", "w") do |f|
      f.puts "server: "
      f.puts "path: "
      f.puts "user: "
    end
  end
  system("vi config.txt")
end

def run_generate
  verify_dirs    # handle missing subdirectories
  stale = stale_files("source") 
  if stale.empty? 
    puts "Nothing to do"
  else
    puts "Stale files:"
    stale.each do |file| 
      puts "  " + x
      update_target(file)
    end
    puts
  end
end

def run_update
  run_generate
  run_publish
end

def run_view
  # FIXME index is hardcoded...
  system("open target/index.html")
end

def run_publish
  cmd = "rsync -r -z target/ #@user@#@server:#@path/"
  system(cmd)
end

def run_browse
  system("open #@server")
end

def command?(cmd)
  self.respond_to?("run_#{cmd}", true)
end

def execute(cmd)
  send("run_#{cmd}")
end

