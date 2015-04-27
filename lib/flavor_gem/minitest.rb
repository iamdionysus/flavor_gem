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
      rakefile_template = template "Rakefile"
      append_to_file "Rakefile", rakefile_template
    end

    def create_minitest_helper
      minitest_helper_rb = "test/minitest_helper.rb"
      minitest_helper_template = template "minitest_helper.rb"
      if File.exist? minitest_helper_rb
        puts "#{minitest_helper_rb} exists. Append to the file"
        append_to_file minitest_helper_rb, minitest_helper_template
      else
        create_file minitest_helper_rb, minitest_helper_template   
      end
    end

    def template name
      File.read "lib/flavor_gem/template/#{name}"
    end
    # TODO
    def inject_minitest_gemspec
      
    end
  end
end
