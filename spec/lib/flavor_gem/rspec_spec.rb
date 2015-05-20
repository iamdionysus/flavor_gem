require "helper"

describe FlavorGem::Generate::Rspec do
  it "appends rake file" do
    subject.append_rakefile
    result = subject.file_include_template?("Rakefile", "rspec.rake")
    expect(result).to be true
  end

  it "creates helper file" do
    subject.create_helper
  end
end
