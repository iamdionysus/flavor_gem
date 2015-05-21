require "fileutils"
require "coveralls"
Coveralls.wear!

$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "flavor_gem"
require "flavor_gem/runner"

def backup(file_name)
  file_name_bak = "#{file_name}.bak"
  FileUtils.mv(file_name, file_name_bak) if File.exist? file_name
end

def restore(file_name)
  file_name_bak = "#{file_name}.bak"
  FileUtils.mv(file_name_bak, file_name) if File.exist? file_name_bak
end
