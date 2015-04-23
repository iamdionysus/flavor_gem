module FlavorGem
  class GemHelper
    include Rake::DSL if defined? Rake::DSL

    class << self
      attr_accessor :instance
      def install_tasks version_file
        new(version_file).install
      end
    end

    def initialize version_file
      @version_file = version_file
      @version_data = File.read @version_file
      version = /\d+\.\d+\.\d+/.match @version_data
      @major, @minor, @patch = extract_current_version version[0]
    end

    def version_file
      @version_file
    end
    
    def extract_current_version version
      version.split(".").map { |i| i.to_i }
    end

    def old_version
      [@major, @minor, @patch].join "."
    end

    def change
      change = ENV['BY'].to_i
      change = 1 if change == 0
      change
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

    def save_version_file new_version
      new_version_data = @version_data.gsub /\d+\.\d+\.\d+/, new_version
      File.open(@version_file, "w") do |f|
        f.write new_version_data
      end
    end
    
    def install
      desc "current version is #{old_version}"
      task :version do
        puts "current version in #{version_file} is #{old_version}"
      end
      
      namespace :bump do
        desc "bump version from #{old_version} to #{bump(0, 0, 1)}"
        task :patch do
          save_version_file(bump(0, 0, change))
        end
        
        desc "bump version from #{old_version} to #{bump(0, 1, 0)}"        
        task :minor do
          save_version_file(bump(0, change, 0))          
        end
        
        desc "bump version from #{old_version} to #{bump(1, 0, 0)}"        
        task :major do
          save_version_file(bump(change, 0, 0))          
        end
      end

      desc "default bump patch version from #{old_version} to #{bump(0, 0, 1)}"
      task :bump => 'bump:patch'
    end
  end
end

FlavorGem::GemHelper.install_tasks(Dir["lib/**/version.rb"][0])
