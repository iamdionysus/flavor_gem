require "fileutils"
require "coveralls"
Coveralls.wear!

$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "flavor_gem"
require "flavor_gem/runner"

def backup(file_name, copy: false)
  file_name_bak = "#{file_name}.bak"
  return unless File.exist?(file_name)
  if copy
    FileUtils.cp(file_name, file_name_bak)
  else
    FileUtils.mv(file_name, file_name_bak)
  end
end

def touch(file_name)
  FileUtils.touch file_name
end

def rm(file_name)
  FileUtils.rm file_name
end

def restore(file_name)
  file_name_bak = "#{file_name}.bak"
  FileUtils.mv(file_name_bak, file_name) if File.exist?(file_name_bak)
end
