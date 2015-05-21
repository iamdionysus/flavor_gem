require "thor"

module FlavorGem
  module Generate
    class ThorBin < Thor::Group
      include Thor::Actions

      # TODO
      def add_runtime_dependency
        puts "please edit gemspec to add thor for runtime_dependency"
      end

      def create_runner_class
        code = template_content "runner.rb"
        code.gsub!(/@gem_name/, gem_name)
        code.gsub!(/@gem_class_name/, gem_class_name)
        create_file "lib/#{gem_name}/runner.rb", code
      end

      def create_bin_file
        code = template_content "thor-bin"
        code.gsub!(/@gem_name/, gem_name)
        code.gsub!(/@gem_class_name/, gem_class_name)
        create_file "bin/#{gem_name}", code
      end
    end
  end
end
