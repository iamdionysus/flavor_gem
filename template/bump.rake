begin
  require "flavor_gem/bump_tasks"
rescue LoadError => e
  raise LoadError unless e.message.include? "flavor_gem/bump_tasks"
end
