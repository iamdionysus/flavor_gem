require "thor"

module FlavorGem
  class Bump < Thor
    include Thor::Actions

    desc "generate", "generate rake bump task to update version file easily"
    def generate
      add_bump_tasks "Rakefile"
    end

    desc "delete", "delete generated bump flavor"
    def delete
      remove_bump_tasks "Rakefile"
    end

    private
    def bump_tasks
      "require \"flavor_gem/bump_tasks\"\n"
    end

    def bump_tasks_regex
      /require ["']flavor_gem\/bump_tasks["']/
    end

    def add_bump_tasks file_name
      rakefile = File.read file_name
      single_quote_bundler_require = 'require "bundler\/bump_tasks"\n'
      double_quote_bundler_require = "require 'bundler/bump_tasks'\n"
      if rakefile =~ bump_tasks_regex
        return
      end
      if rakefile.include? single_quote_bundler_require
        insert_into_file file_name, bump_tasks, :after => single_quote_bundler_require
      elsif rakefile.include? double_quote_bundler_require
        insert_into_file file_name, bump_tasks, :after => double_quote_bundler_require
      else
        prepend_to_file file_name, bump_tasks
      end
    end

    def remove_bump_tasks file_name
      gsub_file file_name, /require ["']flavor_gem\/bump_tasks["']\n/, ""      
    end
  end
end
