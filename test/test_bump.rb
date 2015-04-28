require 'minitest_helper'

class FlavorGem::Bump
  public :add_bump_tasks, :remove_bump_tasks
end

class TestBump < Minitest::Test
  def setup
    @bump = FlavorGem::Bump.new
    @bump_tasks = FlavorGem::BumpTasks.new Dir["lib/**/version.rb"][0]    
  end

  def bump_tasks_regex
    /require ["']flavor_gem\/bump_tasks["']/    
  end

  test "should add and delete bump task from Rakefile" do
    rakefile_name = "lib/flavor_gem/template/Rakefile"

    @bump.add_bump_tasks rakefile_name
    rakefile = File.read rakefile_name    
    assert_match bump_tasks_regex, rakefile
    
    @bump.remove_bump_tasks rakefile_name
    rakefile = File.read rakefile_name    
    refute_match bump_tasks_regex, rakefile
  end
  
  test "should parse the version correctly" do
    old_version = @bump_tasks.old_version
    major, minor, patch = @bump_tasks.extract_current_version old_version
    assert_equal old_version, [major, minor, patch].join(".")
  end
  
end
