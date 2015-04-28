require 'thor'

module FlavorGem
  ALL_FLAVORS = %w[minitest thor bump]
  ALL_FLAVORS_NAME = ALL_FLAVORS.join "|"
end

class Thor
  module Actions
    def file_has_template?(file_name, template)
      file = File.read file_name
      template = File.read(template_file_name(template))
      file = file.strip.gsub(/\s+/, " ")
      template = template.strip.gsub(/\s+/, " ")
      template_regex_string = Regexp.escape(template)
      Regexp.new(template_regex_string) =~ file
    end
    
    def append_template_to_file(file_name, template)
      if File.exists? file_name
        if file_has_template?(file_name, template)
          puts "#{file_name} already has #{template} contents"
          return false
        else
          append_to_file file_name, File.read(template_file_name(template))
        end
      else
        create_file file_name, File.read(template_file_name(template))
      end
    end

    def template_file_name template
      "lib/flavor_gem/template/#{template}"
    end
  end
end
