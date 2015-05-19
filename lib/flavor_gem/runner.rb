require "thor"
require "flavor_gem"

module FlavorGem
  # For Runner.start to make executable
  class Runner < Thor
    include Thor::Actions

    desc "generate [#{FlavorGem::ALL_FLAVORS_NAME}]", "generate flavors"
    option aliases: :g
    def generate(name)
      if name == "all"
        all_flavors.each { |n| invoke_generate n, [] }
      elsif all_flavors.include? name
        invoke "flavor_gem:generate:#{name}", []
      else
        say_not_in_flavors name
      end
    end

    # desc "delete [#{FlavorGem::ALL_FLAVORS_NAME}]", "remove flavors"
    # option aliases: :d
    # def delete(name)
    #   if name == "all"
    #     all_flavors.each { |n| invoke_delete n, [] }
    #   elsif all_flavors.include? name
    #     invoke_delete name, []
    #   else
    #     say_not_in_flavors name
    #   end
    # end

    private

    def all_flavors
      FlavorGem::ALL_FLAVORS
    end

    def all_flavors_name
      FlavorGem::ALL_FLAVORS_NAME
    end

    def invoke_generate(name, args)
      invoke "flavor_gem:#{name}:generate", args
    end

    def invoke_delete(name, args)
      invoke "flavor_gem:#{name}:delete", args
    end

    def say_not_in_flavors(name)
      puts "flavor should be one of the [#{all_flavors_name}], not #{name}"
    end
  end
end
