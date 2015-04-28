require "thor"

module FlavorGem
  class Minitest < Thor
    include Thor::Actions
    
    desc "generate", "edit gemspec, edit Rakefile, add/edit test/test_helper.rb"
    def generate
      append_rakefile
      create_minitest_helper
      inject_minitest_gemspec
    end

    desc "delete", "delete generated minitest flavor"
    def delete
      
    end

    private
    def append_rakefile
      append_template_to_file "Rakefile", "Rakefile"
    end

    def create_minitest_helper
      append_template_to_file "test/minitest_helper.rb", "minitest_helper.rb"
    end

    # TODO
    def inject_minitest_gemspec
      
    end
  end
end
