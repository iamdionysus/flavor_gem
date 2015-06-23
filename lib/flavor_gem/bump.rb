require "thor"

module FlavorGem
  module Generate
    class Bump < Thor::Group
      include Thor::Actions

      # this assumes Rakefile is already there
      # TODO: handle when Rakefile is missing
      def add_rake_bump_task(rakefile = "Rakefile")
        bundler_task = "require 'bundler/gem_tasks'"
        bundler_task = format_quote_to_file bundler_task, rakefile
        code_to_insert = template_content "bump.rake", format_file: rakefile
        code_to_insert = format_quote_to_file code_to_insert, rakefile
        if file_include_code? rakefile, code_to_insert
          puts "Rakefile already has the content"
          return
        end
        if file_include_code? rakefile, bundler_task
          insert_line_into_file rakefile, code_to_insert, after: bundler_task
        else
          prepend_to_file rakefile, code_to_insert
        end
      end
    end
  end

  module Delete
    class Bump < Thor::Group
      include Thor::Actions

      def remove_bump_tasks
        # gsub_file "Rakefile", %r{require ["']flavor_gem/bump_tasks["']\n}, ""
        # not working
      end
    end
  end

  # bump task implementation, needs refactoring
  class BumpTasks
    include Rake::DSL if defined? Rake::DSL

    attr_reader :version_file

    class << self
      def install_tasks(version_file)
        new(version_file).install
      end
    end

    def initialize(version_file = Dir["lib/**/version.rb"][0])
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

    def bump(d_major = 0, d_minor = 0, d_patch = 1)
      major = @major + d_major
      minor = @minor + d_minor
      patch = @patch + d_patch
      [major, minor, patch].map { |x| x < 0 ? 0 : x }
      minor = 0 if d_major > 0
      patch = 0 if d_major > 0 || d_minor > 0
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
        save_version_file version
        puts "bump version from #{old_version} to #{version}"
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
