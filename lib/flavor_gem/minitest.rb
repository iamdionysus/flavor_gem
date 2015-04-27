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
      rakefile_to_add = File.read "lib/flavor_gem/template/Rakefile"
      append_to_file "Rakefile", rakefile_to_add
    end

    def create_minitest_helper
      minitest_helper_to_add = File.read "lib/flavor_gem/template/minitest_helper.rb"
      minitest_helper_rb = "test/minitest_helper.rb"
      if File.exist? minitest_helper_rb
        puts "#{minitest_helper_rb} exists. Append to the file"
        append_to_file minitest_helper_rb, minitest_helper_to_add
      else
        create_file minitest_helper_rb, minitest_helper_to_add        
      end
    end

    # TODO
    def inject_minitest_gemspec
      
    end
  end
end
