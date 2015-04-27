require 'minitest_helper'

class TestBump < Minitest::Test
  def setup
    @bump = FlavorGem::Bump.new
  end

  def gem_tasks
    'require "flavor_gem/gem_tasks"'    
  end

  # test "should delete bump task from Rakefile" do
  #   @bump.delete
  #   rakefile = File.read "Rakefile"
  #   refute_match /#{gem_tasks}/, rakefile
  # end

  # test "should add bump task into Rakefile" do
  #   @bump.generate
  #   rakefile = File.read "Rakefile"
  #   assert_match /flavor_gem\/gem_tasks/, rakefile
  # end
end
