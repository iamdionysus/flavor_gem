require "helper"
require "fileutils"

describe FlavorGem::Generate::Bump do
  it "insert require to Rakefile when it has bundler gem task" do
    # FileUtils.cp "Rakefile", "Rakefile.bak"
    # subject.gsub_file "Rakefile", %r{require ["']flavor_gem/bump_tasks["']\n}, ""
    # subject.add_rake_bump_task
    # result = subject.file_include_template? "Rakefile", "bump.rake"
    # expect(result).to be true
    # FileUtils.mv "Rakefile.bak", "Rakefile"
  end
  it "append require to Rakefile otherwise" do
    FileUtils.mv "Rakefile", "Rakefile.bak"
    FileUtils.touch "Rakefile"
    subject.add_rake_bump_task
    result = subject.file_include_template? "Rakefile", "bump.rake"
    expect(result).to be true
    FileUtils.mv "Rakefile.bak", "Rakefile"
  end
end

describe FlavorGem::BumpTasks do
  it "bumps the version" do
    old_version = subject.old_version
    major, minor, patch = subject.extract_current_version old_version
    new_version = [major, minor, patch + 1].join "."
    expect(subject.bump).to eq(new_version)
  end

  context "#extract_current_version" do
    it "returns major, minor, patch" do
      major, minor, patch = subject.extract_current_version "0.1.4"
      expect([major, minor, patch]).to eq([0, 1, 4])
    end
  end
end
