require "thor"

module FlavorGem
  module Generate
    class ThorBin < Thor::Group
      include Thor::Actions

      # TODO
      def add_runtime_dependency
        puts "please edit gemspec to add thor for runtime_dependency"
      end

      def create_runner_class(file_name = nil)
        file_name ||= "lib/#{gem_name}/runner.rb"
        if File.exist? file_name
          puts "#{file_name} already exists, do nothing on it"
          return
        end
        code = template_content "runner.rb"
        code.gsub!(/@gem_name/, gem_name)
        code.gsub!(/@gem_class_name/, gem_class_name)
        create_file file_name, code
      end

      def create_bin_file(file_name = "bin/#{gem_name}")
        if File.exist? file_name
          puts "#{file_name} already exists, do nothing on it"
          return
        end
        code = template_content "thor_bin"
        code.gsub!(/@gem_name/, gem_name)
        code.gsub!(/@gem_class_name/, gem_class_name)
        create_file file_name, code
      end
    end
  end
end
