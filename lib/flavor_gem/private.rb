require "thor"

module FlavorGem
  module Generate
    class Private < Thor::Group
      include Thor::Actions

      def fix_rake_bundler_release(file_name = "Rakefile")
        append_template_to_file file_name, "private.rake"
      end
    end
  end
end
