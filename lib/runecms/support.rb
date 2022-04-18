
def usage_message
  puts
  puts <<-TEXT
    rcms config    Initialize config.txt if necessary and edit with vi
    rcms generate  Find stale files under source/ and generate them under target/
    rcms view      View the current state of target/ via browser (local files)
    rcms publish   Publish target/ to the remote server
    rcms browse    Browse the current state of the remote server
  TEXT
  puts
  exit
end

def find_files(dir)
  list = Find.find(dir).to_a - [dir]
  list.map {|x| x.sub("#{dir}/","") }
end

def stale?(file)  # without source/ or target/
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

def update_target(file)
  file2 = fix_extension(file)
  if lt3?(file) 
    update = "livetext" 
    redir = ">"
  else
    update = "cp"
    redir = ""
  end
  cmd = "#{update} source/#{file} #{redir} target/#{file2}"
  puts cmd
  system(cmd)
end

def lt3?(file)
  file.end_with?(".lt3")
end

def fix_extension(file)
  if lt3?(file)
    file2 = file.sub(/.lt3$/, ".html")
  else
    file2 = file
  end
  file2
end

def read_config
  lines = File.readlines("config.txt")
  # Example: "user: hal9000"
  lines.each do |line|
    var, val = line.split(": ")
    instance_variable_set("@"+var, val.chomp.strip)
  end
rescue => err
  abort "Can't open config file: #{err}"
end

