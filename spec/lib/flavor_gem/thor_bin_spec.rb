require "fileutils"
require "helper"

RSpec.describe FlavorGem::Generate::ThorBin do
  describe "#add_runtime_dependency" do
    it "says message to edit gemspec" do
      expect { subject.add_runtime_dependency }.to output(/edit gemspec/).to_stdout
    end
  end

  describe "#create_runner_class" do
    let(:test_file_name) { subject.template_file_name "runner_test.rb" }
    after(:example) { restore test_file_name }

    it "creates runner.rb file" do
      backup test_file_name
      expect { subject.create_runner_class test_file_name }
        .to output(/create/).to_stdout
    end

    it "does not create when it exists" do
      backup test_file_name, copy: true
      expect { subject.create_runner_class test_file_name }
        .to output(/exists/).to_stdout
    end
  end

  describe "#create_bin_file" do
    let(:test_file_name) { subject.template_file_name "thor_bin_test" }
    after(:example) { restore test_file_name }

    it "creates bin file with gem name" do
      backup test_file_name
      expect { subject.create_bin_file test_file_name }
        .to output(/#{subject.gem_name}/).to_stdout
    end
  end
end
