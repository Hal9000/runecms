
def usage_message
  puts
  puts <<-TEXT
    rcms config    Initialize config.txt if necessary and edit with vi
    rcms generate  Find stale files under source/ and generate them under target/
    rcms view      View the current state of target/ via browser (local files)
    rcms publish   Publish target/ to the remote server
    rcms update    Shortcut - Like a generate followed by a push
    rcms browse    Browse the current state of the remote server
  TEXT
  puts
  exit
end

def find_files(dir)
  list = nil
  Dir.chdir(dir) { list =  Find.find(".") }
  list
end

def stale?(file)  # without source/ or target/
  return false if File.directory?(file)
  if file.end_with?(".lt3")
    file1 = file
    file2 = file.sub(/.lt3$/, ".html")
  else
    file1 = file2 = file
  end
  return true if ! File.exist?("target/#{file2}")

  t1 = File.mtime("source/#{file1}")
  t2 = File.mtime("target/#{file2}")
  t1 > t2
end

# def stale?(file)  # without source/ or target/
#   if file.end_with?(".lt3")
#     file1 = file
#     file2 = file.sub(/.lt3$/, ".html")
#   else
#     file1 = file2 = file
#   end
#   return true if ! File.exist?(file2)
# 
#   t1 = File.mtime("source/#{file1}")
#   t2 = File.mtime("target/#{file2}")
#   t1 > t2
# end

def read_config
  config = "config.txt"
  here = Dir.pwd
  loop do
    raise if Dir.pwd == "/"  # shouldn't get this far
    break if File.exist?(config)
    Dir.chdir("..")
  end
  lines = File.readlines("config.txt")
  # Example: "user: hal9000"
  lines.each do |line|
    var, val = line.split(": ")
    instance_variable_set(var, val.chomp)
  end
  return true
rescue
  abort "Can't read config file"
  return false
end

