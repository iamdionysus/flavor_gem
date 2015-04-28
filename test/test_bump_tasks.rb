require "minitest_helper"

class TestBumpTasks < Minitest::Test
  test "should create BumpTasks instance" do
    bump_tasks = FlavorGem::BumpTasks.new Dir["lib/**/version.rb"][0]
    refute_nil bump_tasks
  end
end
