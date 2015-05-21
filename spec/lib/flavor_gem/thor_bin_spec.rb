require "fileutils"
require "helper"

RSpec.describe FlavorGem::Generate::ThorBin do
  describe "#add_runtime_dependency" do
    it "says message to edit gemspec" do
      expect { subject.add_runtime_dependency }.to output(/edit gemspec/).to_stdout
    end
  end

  describe "#create_runner_class" do
    it "creates runner.rb file" do
      test_file_name = "lib/#{subject.gem_name}/runner.rb"
      backup test_file_name
      expect { subject.create_runner_class }.to output(/#{subject.gem_name}/).to_stdout
      restore test_file_name
    end
  end

  describe "#create_bin_file" do
    it "creates bin file with gem name" do
      test_file_name = "bin/#{subject.gem_name}"
      backup test_file_name
      expect { subject.create_bin_file }.to output(/#{subject.gem_name}/).to_stdout
      restore test_file_name
    end
  end
end
