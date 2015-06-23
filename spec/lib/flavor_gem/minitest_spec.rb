require "helper"
require "fileutils"

describe FlavorGem::Generate::Minitest do
  let(:rakefile) { "template/Rakefile" }
  it "appends minitest.rake template to Rakefile" do
    backup rakefile
    subject.append_rakefile rakefile
    result = subject.file_include_template? rakefile, "minitest.rake"
    expect(result).to be true
    restore rakefile
  end
end

describe FlavorGem::Delete::Minitest do
end
