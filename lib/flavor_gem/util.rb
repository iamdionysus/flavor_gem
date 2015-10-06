require "thor"

# Constants
module FlavorGem
  ALL_FLAVORS = %w(rspec minitest thor_bin private)
  ALL_FLAVORS_NAME = ALL_FLAVORS.join "|"
end

# extend Thor::Actions
class Thor
  module Actions
    def file_include_template?(file_name, template)
      file = File.read file_name
      template = template_content template
      file = normalize_code file
      template = normalize_code template
      file.include? template
    end

    def file_include_code?(file_name, code)
      file = File.read file_name
      file = normalize_code file
      code = normalize_code code
      file.include? code
    end

    def format_quote_to_file(code, file_name)
      file = File.read file_name
      double_quote_count = file.count '"'
      single_quote_count = file.count "'"
      if single_quote_count > double_quote_count
        code.tr '"', "'"
      else
        code.tr "'", '"'
      end
    end

    def detect_line_ending(file_name)
      file = File.read file_name
      dos = file.scan /\r\n$/
      unix = file.scan /[^\r]\n$/
      if dos.size > unix.size
        "\r\n"
      else
        "\n"
      end
    end

    def replace_line_ending(code, line_ending)
      pattern = /[\\r]?\\n/
      code.gsub pattern, line_ending
    end

    def normalize_code(code, format_file: nil)
      if format_file
        code = format_quote_to_file code, format_file
        code = replace_line_ending code, detect_line_ending(format_file)
      else
        code.gsub(/\s+/, " ").tr('"', "'").strip
      end
    end

    def insert_line_into_file(file_name, code, **options)
      line_ending = detect_line_ending file_name
      options.map { |k, v| [k, v << line_ending] }.to_h if options
      code = replace_line_ending(code, line_ending)
      p file_name
      insert_into_file file_name, code, after: "require 'bundler/gem_tasks'\n"
    end

    def append_code_to_file(file_name, code)
      if File.exist? file_name
        if file_include_code?(file_name, code)
          puts "#{file_name} already has the content"
          return false
        else
          append_to_file file_name, code
        end
      else
        create_file file_name, code
      end
    end

    def append_template_to_file(file_name, template)
      code = template_content template
      append_code_to_file file_name, code
    end

    def template_file_name(template)
      File.expand_path("../../../template/#{template}", __FILE__)
    end

    def template_content(template_name, format_file: nil)
      template = File.read template_file_name(template_name)
      if format_file
        normalize_code template, format_file: format_file
      else
        template
      end
    end

    def gem_name
      File.basename Dir.getwd
    end

    def gem_class_name
      gem_name.split("_").map(&:capitalize).join
    end
  end
end
