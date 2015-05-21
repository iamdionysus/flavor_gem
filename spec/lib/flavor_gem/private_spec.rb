require "helper"

RSpec.describe FlavorGem::Generate::Private do
  describe "#fix_rake_bundler_release" do
    let(:test_file_name) { subject.template_file_name "Rakefile" }
    after(:example) { restore test_file_name }

    it "installs rake taks to prevent rake release to push rubygems" do
      backup test_file_name
      subject.fix_rake_bundler_release test_file_name
      expect(subject.file_include_template?(test_file_name, "private.rake")).to be true
    end
  end
end
