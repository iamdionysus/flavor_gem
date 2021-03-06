require "thor"

module FlavorGem
  module Generate
    class Rspec < Thor::Group
      include Thor::Actions

      # TODO
      def delete_minitest_rake
      end

      def append_rakefile(rakefile = "Rakefile")
        append_template_to_file rakefile, "rspec.rake"
      end

      def create_helper(helper = "spec/helper.rb")
        code = template_content "helper.rb"
        code.gsub! "@gem_name", gem_name
        append_code_to_file helper, code
      end

      # TODO
      def inject_rspec_gemfile
      end
    end
  end

  module Delete
    class Rspec < Thor::Group
      include Thor::Actions
      # TODO
    end
  end
end
