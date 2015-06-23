require "helper"
require "fileutils"

describe FlavorGem::Generate::Rspec do
  let(:helper) { "template/rspec_helper_dummy.rb"}
  let(:rakefile) { "template/Rakefile" }
  it "appends rake file" do
    backup rakefile
    subject.append_rakefile rakefile
    result = subject.file_include_template? rakefile, "rspec.rake"
    expect(result).to be true
    restore rakefile
  end

  it "creates helper file" do
    backup helper
    subject.create_helper helper
    code = subject.template_content "helper.rb"
    code.gsub! "@gem_name", File.basename(Dir.getwd)
    result = subject.file_include_code? helper, code
    expect(result).to be true
    restore helper
  end
end
