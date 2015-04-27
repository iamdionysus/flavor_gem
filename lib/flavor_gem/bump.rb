require "thor"

module FlavorGem
  class Bump < Thor
    include Thor::Actions

    desc "generate", "generate rake bump task to update version file easily"
    def generate
      insert_into_file "Rakefile", gem_tasks, :after => "bundler/gem_tasks\"\n"
    end

    desc "delete", "delete generated bump flavor"
    def delete
      gsub_file "Rakefile", /require "flavor_gem\/gem_tasks"/, ""
      gsub_file "Rakefile", /require 'flavor_gem\/gem_tasks'/, ""      
    end

    private
    def rakefile
      File.read "Rakefile"
    end

    def gem_tasks
      'require "flavor_gem/gem_tasks"'
    end
  end
end
