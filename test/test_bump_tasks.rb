require "minitest_helper"

class TestBumpTasks < Minitest::Test
  def setup
    @bump_tasks = FlavorGem::BumpTasks.new Dir["lib/**/version.rb"][0]
  end
  test "should parse the version correctly" do
    old_version = @bump_tasks.old_version
    major, minor, patch = @bump_tasks.extract_current_version old_version
    assert_equal old_version, [major, minor, patch].join(".")
  end
end
