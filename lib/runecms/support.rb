
def usage_message
  puts
  puts <<-TEXT
    rcms config    Initialize config.txt if necessary and edit with vi
    rcms check     List stale files, but do nothing else
    rcms generate  Find stale files under source/ and generate them under target/
    rcms view      View the current state of target/ via browser (local files)
    rcms publish   Publish target/ to the remote server
    rcms update    Shortcut - Like a generate followed by a push
    rcms browse    Browse the current state of the remote server

    Run from a directory with a config.txt, a source/ dir, and a target/ dir.

    Config file looks like:
      server: example.com
      path: /some/arbitrary/path
      user: myuser

  TEXT
  puts
  exit
end

def stale_files(dir)
  list = nil
  path = "#{Dir.pwd}/#{dir}/"
  list = Find.find(path).to_a
  list = list.select {|x| ! File.directory?(x) }
  list.map! {|x| x.sub(path, "") }
  list.select {|x| stale?(x) }
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

def update_target(file)
  file2 = fix_extension(file)
  if lt3?(file) 
    cmd = "livetext source/#{file} > target/#{file2}"
  else
    if File.directory?(file)
      cmd = "mkdir target/#{file2}"
    else
      cmd = "cp source/#{file} target/#{file2}"
    end
  end
  system(cmd)
end

def verify_dirs
  src_dirs = []
  Find.find("source") do |path|
    src_dirs << path if File.directory?(path)
  end

  src_dirs.each do |path|
    tdir = path.sub("source", "target")
    Dir.mkdir(tdir) unless Dir.exist?(tdir)
  end
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
    var, val = "@" + var, val.chomp.strip
    # puts "Config: setting #{var} to #{val.inspect}"
    instance_variable_set(var, val)
  end
  return true
rescue => e
  puts "Can't read config file: here = #{here}  pwd = #{Dir.pwd}"
  puts e
  return false
end

