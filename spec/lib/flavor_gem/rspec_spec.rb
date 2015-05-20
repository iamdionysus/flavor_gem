require "helper"
require "fileutils"

describe FlavorGem::Generate::Rspec do
  it "appends rake file" do
    subject.append_rakefile
    result = subject.file_include_template?("Rakefile", "rspec.rake")
    expect(result).to be true
  end

  it "creates helper file" do
    FileUtils.mv "spec/helper.rb", "spec/helper.rb.bak"
    subject.create_helper
    code = subject.code_from_template "helper.rb"
    code.gsub! "@gem_name", File.basename(Dir.getwd)
    result = subject.file_include_code?("spec/helper.rb", code)
    expect(result).to be true
    FileUtils.mv "spec/helper.rb.bak", "spec/helper.rb"
  end
end
