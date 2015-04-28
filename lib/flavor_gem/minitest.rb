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
      rakefile = File.read "Rakefile"
      if rakefile =~ /#{rakefile_template}/
        puts "minitest is already there in Rakefile"
      else
        append_to_file "Rakefile", rakefile_template
      end
    end

    def create_minitest_helper
      minitest_helper_rb = "test/minitest_helper.rb"
      minitest_helper_template = template "minitest_helper.rb"
      if File.exist? minitest_helper_rb
        if file_has_template? minitest_helper_rb, minitest_helper_template
          puts "#{minitest_helper_rb} alread has necessary set up"
        else 
          puts "#{minitest_helper_rb} exists. Append to the file"          
          append_to_file minitest_helper_rb, minitest_helper_template
        end
      else
        create_file minitest_helper_rb, minitest_helper_template   
      end
    end

    def file_has_template? original_file_name, template
      original = File.read original_file_name
      original =~ /#{template}/
    end
    
    def template name
      File.read "lib/flavor_gem/template/#{name}"
    end
    # TODO
    def inject_minitest_gemspec
      
    end
  end
end
