
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
  puts "Would generate from: "
  list.each {|file| puts "    #{file}" }
  puts
end

def run_view
  # system("open target/index.html")
  puts "Would run:  'open target/index.html'"
  puts
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

