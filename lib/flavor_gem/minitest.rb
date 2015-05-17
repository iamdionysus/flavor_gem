require "thor"

module FlavorGem
  module Generate
    class Minitest < Thor::Group
      include Thor::Actions

      def append_rakefile
        puts "append_rakefile"
        # append_template_to_file "Rakefile", "Rakefile"
      end

      def create_minitest_helper
        puts "create minitest helper"
        # append_template_to_file "test/minitest_helper.rb", "minitest_helper.rb"
      end

      # TODO
      def inject_minitest_gemspec
        
      end
    end
  end

  module Delete
    class Minitest < Thor::Group
      include Thor::Actions
    end
  end
end
