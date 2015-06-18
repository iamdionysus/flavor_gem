require "thor"

module FlavorGem
  module Generate
    class Rspec < Thor::Group
      include Thor::Actions

      # TODO
      def delete_minitest_rake
      end

      def append_rakefile
        append_template_to_file "Rakefile", "rspec.rake"
      end

      def create_helper
        code = template_content "helper.rb"
        code.gsub! "@gem_name", gem_name
        append_code_to_file "spec/helper.rb", code
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
