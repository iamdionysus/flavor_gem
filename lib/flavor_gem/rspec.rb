require "thor"

module FlavorGem
  module Generate
    class Rspec < Thor::Group
      include Thor::Actions

      def append_rakefile
        append_template_to_file "Rakefile", "rspec.rake"
      end

      def create_helper
        code = code_from_template "helper.rb"
        code.gsub! "@gem_name", File.basename(Dir.getwd)
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
