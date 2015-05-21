require "thor"

module FlavorGem
  module Generate
    class Private < Thor::Group
      include Thor::Actions

      def fix_rake_bundler_release
      end
    end
  end
end
