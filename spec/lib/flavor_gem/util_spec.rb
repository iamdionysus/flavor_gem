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

  context "#file_include_template?" do
    it "returns true when file includes template" do
    end
  end

  context "#normalize_code" do
    it "normalizes double quotes, whitespace" do
      code = <<END
require "rake/testtask"
require 'rspec/core/rake_task'
END
      expected_code = "require 'rake/testtask' require 'rspec/core/rake_task'"
      normalized = subject.normalize_code code
      expect(normalized).to be == expected_code
    end
  end
end
