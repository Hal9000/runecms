
def find_files(dir)
  list = nil
  Dir.chdir(dir) { list =  Find.find(".") }
  list
end

def stale?(file)  # without source/ or target/
  if file.end_with?(".lt3")
    file1 = file
    file2 = file.sub(/.lt3$/, ".html")
  else
    file1 = file2 = file
  end
  return true if ! File.exist?(file2)

  t1 = File.mtime("source/#{file1}")
  t2 = File.mtime("target/#{file2}")
  t1 > t2
end

def read_config
  lines = File.readlines("config.txt")
  # Example: "user: hal9000"
  lines.each do |line|
    var, val = line.split(": ")
    instance_variable_set(var, val.chomp)
  end
rescue
  abort "Can't open config file"
end

