require "thor"

module FlavorGem
  module Generate
    class ThorBin < Thor::Group
      include Thor::Actions
    end
  end
end
