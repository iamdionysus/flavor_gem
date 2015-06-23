require "helper"

describe FlavorGem::Generate::Bump do
  let(:rakefile) { "template/Rakefile" }
  it "insert bump task after the bundler/gem_tasks line" do
    backup rakefile, copy: true
    subject.add_rake_bump_task rakefile
    result = subject.file_include_template? rakefile, "bump.rake"
    expect(result).to be true
    # restore rakefile
  end
  it "append require to Rakefile otherwise" do
    # backup rakefile
    # touch rakefile
    # subject.add_rake_bump_task rakefile
    # result = subject.file_include_template? rakefile, "bump.rake"
    # expect(result).to be true
    # restore rakefile
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
