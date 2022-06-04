
require 'find'

CONFIG = "config.txt"

def run_config
  unless File.exist?(CONFIG)
    File.open(CONFIG, "w") do |f|
      f.puts "server: "
      f.puts "path:   "
      f.puts "user:   "
    end
  end
  system("vi #{CONFIG}")
end

def run_generate
  verify_dirs    # handle missing subdirectories
  list = find_files("source") 
  list.each do |file|
    next if File.directory?("source/#{file}")
    if stale?(file)
      puts "  #{file} is stale"
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
  system(cmd)
# puts "Would run: '#{cmd}'"
# puts
end

def run_update
  run_generate
  run_publish
end

def run_browse
  system("open #@server")
# puts "Would run: 'open #@server'"
# puts
end

def command?(cmd)
  self.respond_to?("run_#{cmd}", true)
end

def execute(cmd)
  send("run_#{cmd}")
end

