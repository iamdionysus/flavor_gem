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

  context "#normalize_code" do
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

  context "#file_include_template?" do
    it "returns true when file includes template" do
      result = subject.file_include_template? "lib/flavor_gem/template/minitest.rake",
                                              "minitest.rake"
      expect(result).to be true
    end
  end

  context "#append_tesmplate_to_file" do
    rakefile = "lib/flavor_gem/template/Rakefile"
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
end
