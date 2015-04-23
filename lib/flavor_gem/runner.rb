require "thor"

module FlavorGem
  class Runner < Thor
    include Thor::Actions

    desc "all", "adds all flavors to bundler gem skeleton"
    def all
      invoke :test
      invoke :thor
      invoke :bump
    end

    desc "test", "adds rails test macro flavor"
    def test
    end

    desc "thor", "adds thor flavor to make executable in bin to use it"
    def thor
    end

    desc "bump", "adds rake bump tasks to update version.rb file easily"
    def bump
    end
  end
end
