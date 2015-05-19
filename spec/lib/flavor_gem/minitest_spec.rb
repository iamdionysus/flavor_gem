require "helper"
require "fileutils"

describe FlavorGem::Generate::Minitest do
  it "appends minitest.rake template to Rakefile" do
    FileUtils.mv "Rakefile", "Rakefile.bak"
    subject.append_rakefile
    result = subject.file_include_template? "Rakefile", "minitest.rake"
    expect(result).to be true
    FileUtils.mv "Rakefile.bak", "Rakefile"
  end
end

describe FlavorGem::Delete::Minitest do
end
