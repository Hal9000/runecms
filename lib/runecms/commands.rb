
require 'find'

def run_config
  unless File.exist?("config.txt")
    File.open("config.txt", "w") do |f|
      f.puts "server: "
      f.puts "path:   "
      f.puts "user:   "
    end
  end
  system("vi config.txt")
end

def run_generate
  list = find_files("source") 
# puts "Would generate from: "
# list.each {|file| puts "  #{file}" }
# puts
  list.each do |file|
    if stale?(file)
      print "  #{file} is stale: \n    => "
      update_target(file)
    end
  end
end

def run_view
  # FIXME index is hardcoded...
  system("open target/index.html")
end

def run_publish
  cmd = "rsync -r -z target/ #@user@#@server:#@path/"
  # system(cmd)
  puts "Would run: '#{cmd}'"
  puts
end

def run_browse
  # system("open #@server")
  puts "Would run: 'open #@server'"
  puts
end

def command?(cmd)
  self.respond_to?("run_#{cmd}", true)
end

def execute(cmd)
  send("run_#{cmd}")
end

