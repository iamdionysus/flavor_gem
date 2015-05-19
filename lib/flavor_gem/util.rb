require "thor"

# Constants
module FlavorGem
  ALL_FLAVORS = %w(minitest thor bump)
  ALL_FLAVORS_NAME = ALL_FLAVORS.join "|"
end

# extend Thor::Actions
class Thor
  module Actions
    def normalize_code(code)
      code.gsub(/\s+/, " ").tr('"', "'").strip
    end

    def file_include_template?(file_name, template)
      file = File.read file_name
      template = File.read(template_file_name(template))
      file = normalize_code file
      template = normalize_code template
      file.include? template
      # template_regex_string = Regexp.escape(template)
      # Regexp.new(template_regex_string) =~ file
    end

    def append_template_to_file(file_name, template)
      if File.exist? file_name
        if file_include_template?(file_name, template)
          puts "#{file_name} already has #{template} contents"
          return false
        else
          append_to_file file_name, File.read(template_file_name(template))
        end
      else
        create_file file_name, File.read(template_file_name(template))
      end
    end

    def template_file_name(template)
      "lib/flavor_gem/template/#{template}"
    end
  end
end
