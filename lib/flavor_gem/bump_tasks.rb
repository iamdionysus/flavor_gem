require "flavor_gem/bump"

FlavorGem::BumpTasks.install_tasks(Dir["lib/**/version.rb"][0])
