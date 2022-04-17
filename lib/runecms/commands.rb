
require 'find'

def run_config
  unless File.exist?("config.txt")
    File.open("config.txt", "w") do |f|
      f.puts "server: "
      f.puts "path: "
      f.puts "user: "
    end
  end
  system("vi config.txt")
end

def run_generate
  list = find_files("source") 
end

def run_view
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

