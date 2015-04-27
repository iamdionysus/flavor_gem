require 'minitest_helper'

class FlavorGem::Bump
  public :add_bump_tasks, :remove_bump_tasks
end

class TestBump < Minitest::Test
  def setup
    @bump = FlavorGem::Bump.new
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
end
