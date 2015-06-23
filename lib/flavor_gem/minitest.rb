require "thor"

module FlavorGem
  module Generate
    class Minitest < Thor::Group
      include Thor::Actions

      def append_rakefile(rakefile = "Rakefile")
        append_template_to_file rakefile, "minitest.rake"
      end

      # TODO
      def create_minitest_helper
      end

      # TODO
      def inject_minitest_gemspec
      end
    end
  end

  module Delete
    class Minitest < Thor::Group
      include Thor::Actions
      # TODO
    end
  end
end
