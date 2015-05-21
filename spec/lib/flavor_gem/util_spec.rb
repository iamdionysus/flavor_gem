require "fileutils"
require "helper"

describe FlavorGem do
  it "has ALL_FLAVORS" do
    expect(FlavorGem::ALL_FLAVORS).to be_a(Array)
    all_flavors_name = FlavorGem::ALL_FLAVORS.join "|"
    expect(FlavorGem::ALL_FLAVORS_NAME).to be == all_flavors_name
  end
end

describe "Thor::Actions" do
  class Dummy < Thor
    include Thor::Actions
  end
  subject { Dummy.new }

  describe "#template_file_name" do
    it "returns the right path" do
      result = subject.template_file_name("Rakefile")
      expect(result).to eq("c:/gabriel/flavor_gem/template/Rakefile")
    end
  end
  describe "#normalize_code" do
    it "normalizes double quotes, whitespace" do
      code = <<END
require "rake/testtask"
require 'rspec/core/rake_task'
END
      expected_code = "require 'rake/testtask' require 'rspec/core/rake_task'"
      normalized = subject.normalize_code code
      expect(normalized).to eq(expected_code)
    end
  end

  context "#file_include_code?" do
    it "returns true when file includes code" do
      result = subject.file_include_code? "template/bump.rake",
                                          "require 'flavor_gem/bump_tasks'"
      expect(result).to be true
    end
  end

  describe "#file_include_template?" do
    it "returns true when file includes template" do
      result = subject.file_include_template? "template/minitest.rake",
                                              "minitest.rake"
      expect(result).to be true
    end
  end

  describe "#format_quote_to_file" do
    it "converts code to single format when file has more single quote" do
      code = 'require "test"'
      test_file = subject.template_file_name "single_quote.rake"
      code = subject.format_quote_to_file code, test_file
      expect(code).to eq("require 'test'")
    end
    it "converts code to double quote format otherwise" do
      code = "require 'test'"
      code = subject.format_quote_to_file code, "Rakefile"
      expect(code).to eq('require "test"')
    end
  end

  describe "#append_code_to_file" do
    it "append to file when the file does not include code" do
      rakefile = "template/Rakefile"
      code = File.read(subject.template_file_name("minitest.rake"))
      FileUtils.cp rakefile, rakefile + ".bak"
      subject.append_code_to_file rakefile, code
      result = subject.file_include_code? rakefile, code
      expect(result).to be true
      FileUtils.mv rakefile + ".bak", rakefile
    end
  end

  describe "#append_template_to_file" do
    rakefile = "template/Rakefile"
    template = "minitest.rake"
    it "creates file when the file does not exist" do
      FileUtils.mv rakefile, rakefile + ".bak"
      expect { subject.append_template_to_file rakefile, template }.to output(/create/).to_stdout
      FileUtils.mv rakefile + ".bak", rakefile
    end

    it "append to file when the file does not include template" do
      FileUtils.cp rakefile, rakefile + ".bak"
      expect { subject.append_template_to_file rakefile, template }.to output(/append/).to_stdout
    end

    it "says message when the files includes template" do
      expect { subject.append_template_to_file rakefile, template }.to output(/has/).to_stdout
      FileUtils.mv rakefile + ".bak", rakefile
    end
  end

  describe "#gem_name" do
    it "gets current gem name" do
      expect(subject.gem_name).to eq("flavor_gem")
    end
  end

  describe "#gem_class_name" do
    it "gets gem class name" do
      expect(subject.gem_class_name).to eq("FlavorGem")
    end
  end
end
