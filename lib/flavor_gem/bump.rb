require "thor"

module FlavorGem
  # version bump task command
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
      %r{require ["']flavor_gem/bump_tasks["']}
    end

    def add_bump_tasks(file_name)
      rakefile = File.read file_name
      single_quote_bundler_require = 'require "bundler\/bump_tasks"\n'
      double_quote_bundler_require = "require 'bundler/bump_tasks'\n"
      return if rakefile =~ bump_tasks_regex
      if rakefile.include? single_quote_bundler_require
        insert_into_file file_name, bump_tasks, after: single_quote_bundler_require
      elsif rakefile.include? double_quote_bundler_require
        insert_into_file file_name, bump_tasks, after: double_quote_bundler_require
      else
        prepend_to_file file_name, bump_tasks
      end
    end

    def remove_bump_tasks(file_name)
      gsub_file file_name, %r{require ["']flavor_gem/bump_tasks["']\n}, ""
    end
  end

  # bump task implementation
  class BumpTasks
    include Rake::DSL if defined? Rake::DSL

    attr_reader :version_file

    class << self
      def install_tasks(version_file)
        new(version_file).install
      end
    end

    def initialize(version_file)
      @version_file = version_file
      @version_data = File.read @version_file
      version = /\d+\.\d+\.\d+/.match @version_data
      @major, @minor, @patch = extract_current_version version[0]
    end

    def extract_current_version(version)
      version.split(".").map(&:to_i)
    end

    def old_version
      [@major, @minor, @patch].join "."
    end

    def bump(major = 0, minor = 0, patch = 1)
      major = @major + major
      minor = @minor + minor
      patch = @patch + patch
      major = 0 if major < 0
      minor = 0 if minor < 0
      patch = 0 if patch < 0
      [major, minor, patch].join "."
    end

    def save_version_file(new_version)
      version_regex = /\d+\.\d+\.\d+/
      new_version_data = @version_data.gsub version_regex, new_version
      File.open(@version_file, "w") do |f|
        f.write new_version_data
      end
    end

    def install
      install_version_task
      install_all_bump_task
      install_default_bump_task
    end

    private

    def install_version_task
      desc "current version is #{old_version}"
      task :version do
        puts "current version in #{version_file} is #{old_version}"
      end
    end

    def install_all_bump_task
      namespace :bump do
        install_bump_task(:patch, bump(0, 0, change))
        install_bump_task(:minor, bump(0, change, 0))
        install_bump_task(:major, bump(change, 0, 0))
      end
    end

    def install_bump_task(version_type, version)
      desc "bump version from #{old_version} to #{version}"
      task version_type do
        save_version_file new_version
      end
    end

    def install_default_bump_task
      desc "default bump patch version from #{old_version} to #{bump(0, 0, 1)}"
      task bump: "bump:patch"
    end

    def change
      change = ENV["BY"].to_i
      change = 1 if change == 0
      change
    end
  end
end
